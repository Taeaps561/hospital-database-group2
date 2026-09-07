-- =====================================================================
-- HOSPITAL HR SYSTEM (H7: STAFF & PERSONNEL) - STANDALONE VERSION
-- Subsystem: H7 ระบบบริหารบุคลากรทางการแพทย์และเจ้าหน้าที่
-- Target: PostgreSQL 13+
-- Tables: 22 Tables (Normalized 3NF)
-- =====================================================================

-- 1) ตาราง Lookup พื้นฐาน
CREATE TABLE IF NOT EXISTS titles (
    title_id     SERIAL PRIMARY KEY,
    title_name   VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO titles (title_name) VALUES
    ('นาย'), ('นาง'), ('นางสาว'), ('นพ.'), ('พญ.')
ON CONFLICT (title_name) DO NOTHING;

CREATE TABLE IF NOT EXISTS genders (
    gender_id     SERIAL PRIMARY KEY,
    gender_name   VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO genders (gender_name) VALUES
    ('ชาย'), ('หญิง'), ('ไม่ระบุ')
ON CONFLICT (gender_name) DO NOTHING;

CREATE TABLE IF NOT EXISTS shift_types (
    shift_type_id   SERIAL PRIMARY KEY,
    shift_name      VARCHAR(50) NOT NULL,
    start_time      TIME NOT NULL,
    end_time        TIME NOT NULL,
    description     TEXT
);

INSERT INTO shift_types (shift_name, start_time, end_time, description) VALUES
    ('เวรเช้า (Morning)', '07:00:00', '15:00:00', 'เวรเช้า'),
    ('เวรบ่าย (Afternoon)', '15:00:00', '23:00:00', 'เวรบ่าย'),
    ('เวรดึก (Night)', '23:00:00', '07:00:00', 'เวรดึก')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS specialties (
    specialty_id    SERIAL PRIMARY KEY,
    specialty_name  VARCHAR(150) NOT NULL,
    description     TEXT
);

INSERT INTO specialties (specialty_name, description) VALUES
    ('อายุรศาสตร์ทั่วไป', 'การรักษาโรคทางอายุรกรรมทั่วไป'),
    ('อายุรศาสตร์โรคหัวใจ', 'ความเชี่ยวชาญด้านหัวใจและหลอดเลือด'),
    ('การพยาบาลผู้ป่วยใน', 'การบริบาลผู้ป่วยในหอผู้ป่วย')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS leave_types (
    leave_type_id     SERIAL PRIMARY KEY,
    leave_name        VARCHAR(50) NOT NULL,
    max_days_per_year INT,
    description       TEXT
);

INSERT INTO leave_types (leave_name, max_days_per_year, description) VALUES
    ('ลาป่วย', 30, 'ลาป่วยตามสิทธิแรงงาน'),
    ('ลากิจ', 10, 'ลากิจจำเป็น'),
    ('ลาพักร้อน', 10, 'วันหยุดพักผ่อนประจำปี')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS roles (
    role_id       SERIAL PRIMARY KEY,
    role_name     VARCHAR(50) NOT NULL UNIQUE,
    description   TEXT
);

INSERT INTO roles (role_name, description) VALUES
    ('HR Admin', 'ผู้ดูแลระบบบุคคล'),
    ('Physician', 'แพทย์ผู้ตรวจรักษา'),
    ('Head Nurse', 'หัวหน้าพยาบาลวอร์ด')
ON CONFLICT (role_name) DO NOTHING;

-- 2) ตารางหลัก (Departments, Positions, Employees)
CREATE TABLE IF NOT EXISTS departments (
    department_id      VARCHAR(50) PRIMARY KEY,
    branch_id          VARCHAR(50) NOT NULL,
    department_name    VARCHAR(100) NOT NULL,
    contact_number     VARCHAR(20),
    department_head_id VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS positions (
    position_id     SERIAL PRIMARY KEY,
    position_name   VARCHAR(100) NOT NULL UNIQUE,
    base_salary     NUMERIC(12,2) CHECK (base_salary >= 0)
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id     VARCHAR(50) PRIMARY KEY,
    title_id        INT REFERENCES titles(title_id),
    gender_id       INT REFERENCES genders(gender_id),
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    national_id     VARCHAR(13),
    date_of_birth   DATE,
    hire_date       DATE,
    department_id   VARCHAR(50) NOT NULL REFERENCES departments(department_id),
    position_id     INT NOT NULL REFERENCES positions(position_id),
    status          VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'resigned', 'on leave', 'suspended', 'retired')),
    phone           VARCHAR(20),
    email           VARCHAR(150) UNIQUE,
    address         TEXT,
    marital_status  VARCHAR(20),
    photo_url       TEXT
);

-- Foreign Key หัวหน้าแผนก
ALTER TABLE departments
    DROP CONSTRAINT IF EXISTS fk_departments_head;
ALTER TABLE departments
    ADD CONSTRAINT fk_departments_head
    FOREIGN KEY (department_head_id) REFERENCES employees(employee_id) ON DELETE SET NULL;

-- 3) ตารางวิชาชีพแพทย์
CREATE TABLE IF NOT EXISTS medical_licenses (
    license_id        SERIAL PRIMARY KEY,
    employee_id       VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    license_type      VARCHAR(100),
    license_number    VARCHAR(50) UNIQUE,
    issued_date       DATE,
    expiry_date       DATE CHECK (expiry_date IS NULL OR expiry_date >= issued_date),
    issuing_authority VARCHAR(150),
    status            VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'suspended', 'revoked', 'expired'))
);

CREATE TABLE IF NOT EXISTS employee_specialties (
    employee_id     VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    specialty_id    INT NOT NULL REFERENCES specialties(specialty_id) ON DELETE CASCADE,
    certified_date  DATE,
    PRIMARY KEY (employee_id, specialty_id)
);

-- 4) ตารางประวัติการทำงาน
CREATE TABLE IF NOT EXISTS employee_department_history (
    history_id    SERIAL PRIMARY KEY,
    employee_id   VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    department_id VARCHAR(50) NOT NULL REFERENCES departments(department_id),
    start_date    DATE NOT NULL,
    end_date      DATE
);

CREATE TABLE IF NOT EXISTS employee_position_history (
    history_id    SERIAL PRIMARY KEY,
    employee_id   VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    position_id   INT NOT NULL REFERENCES positions(position_id),
    start_date    DATE NOT NULL,
    end_date      DATE
);

-- 5) ตารางเวรและการเข้างาน / คำขอลา
CREATE TABLE IF NOT EXISTS work_shifts (
    shift_id      SERIAL PRIMARY KEY,
    employee_id   VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    shift_date    DATE NOT NULL,
    shift_type_id INT REFERENCES shift_types(shift_type_id)
);

CREATE TABLE IF NOT EXISTS attendance (
    attendance_id   SERIAL PRIMARY KEY,
    employee_id     VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    shift_id        INT REFERENCES work_shifts(shift_id) ON DELETE SET NULL,
    work_date       DATE NOT NULL,
    check_in_time   TIMESTAMP,
    check_out_time  TIMESTAMP CHECK (check_out_time IS NULL OR check_out_time >= check_in_time),
    status          VARCHAR(20) DEFAULT 'present'
);

CREATE TABLE IF NOT EXISTS leave_requests (
    leave_request_id SERIAL PRIMARY KEY,
    employee_id      VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    leave_type_id    INT NOT NULL REFERENCES leave_types(leave_type_id),
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL CHECK (end_date >= start_date),
    reason           TEXT,
    status           VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    approved_by      VARCHAR(50) REFERENCES employees(employee_id) ON DELETE SET NULL,
    requested_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_at      TIMESTAMP
);

-- 6) สัญญาจ้างและเงินเดือน
CREATE TABLE IF NOT EXISTS employee_contracts (
    contract_id        SERIAL PRIMARY KEY,
    employee_id        VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    contract_type      VARCHAR(50) NOT NULL,
    start_date         DATE NOT NULL,
    end_date           DATE,
    probation_end_date DATE,
    contract_file_url  TEXT,
    is_active          BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE IF NOT EXISTS payroll (
    payroll_id       SERIAL PRIMARY KEY,
    employee_id      VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    pay_period_start DATE NOT NULL,
    pay_period_end   DATE NOT NULL CHECK (pay_period_end >= pay_period_start),
    net_amount       NUMERIC(12,2) NOT NULL,
    paid_at          TIMESTAMP,
    status           VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid'))
);

CREATE TABLE IF NOT EXISTS payroll_items (
    payroll_item_id SERIAL PRIMARY KEY,
    payroll_id      INT NOT NULL REFERENCES payroll(payroll_id) ON DELETE CASCADE,
    item_type       VARCHAR(20) NOT NULL CHECK (item_type IN ('earning', 'deduction')),
    item_name       VARCHAR(100) NOT NULL,
    amount          NUMERIC(12,2) NOT NULL
);

-- 7) ข้อมูลเสริมและระบบความปลอดภัย
CREATE TABLE IF NOT EXISTS emergency_contacts (
    contact_id   SERIAL PRIMARY KEY,
    employee_id  VARCHAR(50) NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    contact_name VARCHAR(150) NOT NULL,
    relationship VARCHAR(50),
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    user_id       VARCHAR(50) PRIMARY KEY,
    employee_id   VARCHAR(50) UNIQUE REFERENCES employees(employee_id) ON DELETE CASCADE,
    username      VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role_id       INT NOT NULL REFERENCES roles(role_id),
    is_active     BOOLEAN NOT NULL DEFAULT true,
    last_login_at TIMESTAMP,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_logs (
    audit_id   SERIAL PRIMARY KEY,
    user_id    VARCHAR(50) REFERENCES users(user_id) ON DELETE SET NULL,
    action     VARCHAR(50) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id  TEXT,
    old_values JSONB,
    new_values JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 8) Indexes สำหรับค้นหาเร็ว
CREATE INDEX IF NOT EXISTS idx_employees_department ON employees(department_id);
CREATE INDEX IF NOT EXISTS idx_employees_position ON employees(position_id);
CREATE INDEX IF NOT EXISTS idx_attendance_employee_date ON attendance(employee_id, work_date);
CREATE INDEX IF NOT EXISTS idx_work_shifts_employee_date ON work_shifts(employee_id, shift_date);
CREATE INDEX IF NOT EXISTS idx_payroll_employee_period ON payroll(employee_id, pay_period_start);
CREATE INDEX IF NOT EXISTS idx_medical_licenses_employee ON medical_licenses(employee_id);
