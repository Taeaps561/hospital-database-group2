-- ==============================================================================
-- 03_create_tables.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — รวมตารางระบบย่อย H1 ถึง H7
-- ข้อตกลงสำคัญ: ในไฟล์นี้จะสร้างเฉพาะ Table และ PRIMARY KEY เท่านั้น
--              ส่วน FOREIGN KEY จะถูกแยกไปใส่ในไฟล์ 04_create_constraints.sql
--              เพื่อป้องกันปัญหา Circular Dependency หรือรันข้ามตารางแล้วเกิด Error
-- ==============================================================================

\connect hospital_enterprise_db

-- ==============================================================================
-- 🏥 โมดูล H1: ระบบทะเบียนผู้ป่วย (Patient Registration System)
-- ผู้รับผิดชอบ: สมาชิก H1
-- ข้อมูลหลัก: ผู้ป่วย, ที่อยู่/ช่องทางติดต่อ, สิทธิการรักษา
-- ==============================================================================

-- ตารางรายชื่อจังหวัดมาตรฐาน (3NF Master)
CREATE TABLE IF NOT EXISTS patient_system.provinces (
    province_id SERIAL PRIMARY KEY,
    province_name VARCHAR(100) UNIQUE NOT NULL
);

-- ตารางสาขาโรงพยาบาลในเครือ
CREATE TABLE IF NOT EXISTS patient_system.hospital_branches (
    branch_id VARCHAR(50) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    province_id INT NOT NULL
);

-- ตารางข้อมูลอัตลักษณ์ผู้ป่วยหลัก (Central Master Patient Entity)
CREATE TABLE IF NOT EXISTS patient_system.patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    title_prefix VARCHAR(50),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    blood_group VARCHAR(10),
    province_id INT NOT NULL,
    weight_kg NUMERIC(5, 2),
    height_cm NUMERIC(5, 2),
    registered_branch_id VARCHAR(50),
    patient_status VARCHAR(20) NOT NULL DEFAULT 'Active'
);

-- ตารางช่องทางการติดต่อผู้ป่วย (3NF Normalization)
CREATE TABLE IF NOT EXISTS patient_system.patient_contacts (
    contact_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    contact_type VARCHAR(20) NOT NULL,
    contact_value VARCHAR(150) NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE
);

-- ตารางบริษัทประกันและกองทุนสุขภาพ
CREATE TABLE IF NOT EXISTS patient_system.insurance_providers (
    provider_id SERIAL PRIMARY KEY,
    provider_name VARCHAR(100) UNIQUE NOT NULL
);

-- ตารางสิทธิประกันสุขภาพของผู้ป่วย (Change Card H02: Multi-Insurance)
CREATE TABLE IF NOT EXISTS patient_system.patient_insurance_policies (
    policy_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    provider_id INT NOT NULL,
    policy_number VARCHAR(100) UNIQUE NOT NULL,
    coverage_limit NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    expiry_date DATE NOT NULL
);

-- ตารางประเภทบทบาทสิทธิ์ในระบบ
CREATE TABLE IF NOT EXISTS patient_system.roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- ตารางบัญชีผู้ใช้งานระบบความปลอดภัย
CREATE TABLE IF NOT EXISTS patient_system.users_security (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_value VARCHAR(255) NOT NULL,
    password_algorithm VARCHAR(50) NOT NULL DEFAULT 'bcrypt',
    role_id INT NOT NULL,
    patient_id VARCHAR(50),
    doctor_id VARCHAR(50),
    account_status VARCHAR(50) NOT NULL DEFAULT 'Active',
    last_login TIMESTAMP
);

-- ตารางบันทึกการเข้าถึงเวชระเบียนฉุกเฉิน (Change Card H06: Break-Glass Protocol)
CREATE TABLE IF NOT EXISTS patient_system.emergency_access_audit_log (
    log_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    patient_id VARCHAR(50) NOT NULL,
    access_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    access_reason TEXT NOT NULL,
    ip_address VARCHAR(50)
);


-- ==============================================================================
-- 👨‍⚕️ โมดูล H7: ระบบบริหารบุคลากรและแพทย์ (Staff & Personnel System)
-- ผู้รับผิดชอบ: สมาชิก H7
-- ข้อมูลหลัก: แพทย์, พยาบาล, บุคลากร, ใบอนุญาต, ตารางเวร, การลา, เงินเดือน และสิทธิ์การใช้งาน
-- ==============================================================================

-- 1. ตาราง Lookup พื้นฐาน
CREATE TABLE IF NOT EXISTS staff_system.titles (
    title_id SERIAL PRIMARY KEY,
    title_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS staff_system.genders (
    gender_id SERIAL PRIMARY KEY,
    gender_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS staff_system.shift_types (
    shift_type_id SERIAL PRIMARY KEY,
    shift_name VARCHAR(50) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS staff_system.specialties (
    specialty_id SERIAL PRIMARY KEY,
    specialty_name VARCHAR(150) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS staff_system.leave_types (
    leave_type_id SERIAL PRIMARY KEY,
    leave_name VARCHAR(50) NOT NULL,
    max_days_per_year INT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS staff_system.roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- 2. ตารางแผนกและตำแหน่งงาน
CREATE TABLE IF NOT EXISTS staff_system.departments (
    department_id VARCHAR(50) PRIMARY KEY,
    branch_id VARCHAR(50) NOT NULL,
    department_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    department_head_id VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS staff_system.positions (
    position_id SERIAL PRIMARY KEY,
    position_name VARCHAR(100) NOT NULL,
    base_salary NUMERIC(12, 2)
);

-- 3. ตารางข้อมูลหลักบุคลากร (Central Employee Entity)
CREATE TABLE IF NOT EXISTS staff_system.employees (
    employee_id VARCHAR(50) PRIMARY KEY,
    title_id INT,
    gender_id INT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    national_id VARCHAR(13),
    date_of_birth DATE,
    hire_date DATE,
    department_id VARCHAR(50) NOT NULL,
    position_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    phone VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    address TEXT,
    marital_status VARCHAR(20),
    photo_url TEXT
);

-- ตารางแพทย์สำหรับความเข้ากันได้ย้อนหลังกับโมดูลอื่น (Backward Compatibility Bridge)
CREATE TABLE IF NOT EXISTS staff_system.doctors (
    doctor_id VARCHAR(50) PRIMARY KEY,
    employee_id VARCHAR(50),
    department_id VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    salary_thb NUMERIC(12, 2),
    position VARCHAR(100)
);

-- 4. ตารางวิชาชีพแพทย์และความเชี่ยวชาญ
CREATE TABLE IF NOT EXISTS staff_system.medical_licenses (
    license_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    license_type VARCHAR(100),
    license_number VARCHAR(50),
    issued_date DATE,
    expiry_date DATE,
    issuing_authority VARCHAR(150),
    status VARCHAR(20) NOT NULL DEFAULT 'active'
);

CREATE TABLE IF NOT EXISTS staff_system.employee_specialties (
    employee_id VARCHAR(50) NOT NULL,
    specialty_id INT NOT NULL,
    certified_date DATE,
    PRIMARY KEY (employee_id, specialty_id)
);

-- 5. ตารางประวัติการทำงานและการโยกย้าย
CREATE TABLE IF NOT EXISTS staff_system.employee_department_history (
    history_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    department_id VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

CREATE TABLE IF NOT EXISTS staff_system.employee_position_history (
    history_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    position_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

-- 6. ตารางเวรปฏิบัติงาน การเข้างาน และการลา
CREATE TABLE IF NOT EXISTS staff_system.work_shifts (
    shift_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    shift_date DATE NOT NULL,
    shift_type_id INT
);

CREATE TABLE IF NOT EXISTS staff_system.attendance (
    attendance_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    shift_id INT,
    work_date DATE NOT NULL,
    check_in_time TIMESTAMP,
    check_out_time TIMESTAMP,
    status VARCHAR(20) DEFAULT 'present'
);

CREATE TABLE IF NOT EXISTS staff_system.leave_requests (
    leave_request_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    leave_type_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    approved_by VARCHAR(50),
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_at TIMESTAMP
);

-- 7. สัญญาจ้างงานและเงินเดือน
CREATE TABLE IF NOT EXISTS staff_system.employee_contracts (
    contract_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    contract_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    probation_end_date DATE,
    contract_file_url TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE IF NOT EXISTS staff_system.payroll (
    payroll_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    pay_period_start DATE NOT NULL,
    pay_period_end DATE NOT NULL,
    net_amount NUMERIC(12, 2) NOT NULL,
    paid_at TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
);

CREATE TABLE IF NOT EXISTS staff_system.payroll_items (
    payroll_item_id SERIAL PRIMARY KEY,
    payroll_id INT NOT NULL,
    item_type VARCHAR(20) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL
);

-- 8. ข้อมูลติดต่อฉุกเฉินและระบบผู้ใช้ / บันทึกตรวจสอบ
CREATE TABLE IF NOT EXISTS staff_system.emergency_contacts (
    contact_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) NOT NULL,
    contact_name VARCHAR(150) NOT NULL,
    relationship VARCHAR(50),
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS staff_system.users (
    user_id VARCHAR(50) PRIMARY KEY,
    employee_id VARCHAR(50) UNIQUE,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role_id INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    last_login_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS staff_system.audit_logs (
    audit_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50),
    action VARCHAR(50) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id TEXT,
    old_values JSONB,
    new_values JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



-- ==============================================================================
-- 📅 โมดูล H2: ระบบนัดหมายและงานผู้ป่วยนอก (Appointments & OPD System)
-- ข้อมูลหลัก: การนัดหมาย, การเข้ารับบริการ, บันทึกการตรวจรักษา
-- ==============================================================================

CREATE TABLE IF NOT EXISTS opd_system.appointments (
    appointment_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(50) NOT NULL,
    branch_id VARCHAR(50) NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_status VARCHAR(50) NOT NULL,
    appointment_source VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS opd_system.diagnoses (
    diagnosis_id VARCHAR(50) PRIMARY KEY,
    icd_code VARCHAR(50) UNIQUE NOT NULL,
    diagnosis_name VARCHAR(255) NOT NULL,
    diagnosis_category VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS opd_system.clinical_records (
    record_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(50) NOT NULL,
    diagnosis_id VARCHAR(50) NOT NULL,
    record_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    systolic_bp NUMERIC(5, 2),
    diastolic_bp NUMERIC(5, 2),
    temperature_c NUMERIC(4, 2),
    blood_glucose_mg_dl NUMERIC(5, 2),
    care_setting VARCHAR(50)
);


-- ==============================================================================
-- 🔬 โมดูล H5: ระบบห้องปฏิบัติการ (Laboratory System)
-- ข้อมูลหลัก: คำสั่งตรวจ, ตัวอย่างสิ่งส่งตรวจ, ผลตรวจแล็บ
-- ==============================================================================

CREATE TABLE IF NOT EXISTS lab_system.lab_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(50) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) NOT NULL DEFAULT 'Pending'
);

CREATE TABLE IF NOT EXISTS lab_system.lab_results (
    result_id SERIAL PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    test_result_value VARCHAR(100) NOT NULL,
    normal_reference_range VARCHAR(100),
    result_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ==============================================================================
-- 💊 โมดูล H4: ระบบเภสัชกรรม (Pharmacy & Medications System)
-- ข้อมูลหลัก: ยา, ใบสั่งยา, การจ่ายยา, คลังยา
-- ==============================================================================

CREATE TABLE IF NOT EXISTS pharmacy_system.medications (
    medication_id VARCHAR(50) PRIMARY KEY,
    medication_name VARCHAR(150) NOT NULL,
    standard_dosage VARCHAR(100),
    unit_price_thb NUMERIC(12, 2) NOT NULL DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS pharmacy_system.prescriptions (
    prescription_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(50) NOT NULL,
    prescription_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dispense_status VARCHAR(50) NOT NULL DEFAULT 'Pending'
);

-- Associative Entity: รายการยาในใบสั่งยา (M:N Prescriptions <-> Medications)
CREATE TABLE IF NOT EXISTS pharmacy_system.prescription_items (
    item_id SERIAL PRIMARY KEY,
    prescription_id VARCHAR(50) NOT NULL,
    medication_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    instructions TEXT
);


-- ==============================================================================
-- 🛏️ โมดูล H6: ระบบผู้ป่วยในและหอผู้ป่วย (Inpatient & Wards System)
-- ข้อมูลหลัก: Admit, เตียง, วอร์ด, การย้ายเตียง (Change Card H03)
-- ==============================================================================

CREATE TABLE IF NOT EXISTS ipd_system.wards (
    ward_id VARCHAR(50) PRIMARY KEY,
    department_id VARCHAR(50) NOT NULL,
    ward_name VARCHAR(100) NOT NULL,
    ward_type VARCHAR(50) NOT NULL,
    bed_capacity INT NOT NULL,
    head_nurse_id VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS ipd_system.beds (
    bed_id VARCHAR(50) PRIMARY KEY,
    ward_id VARCHAR(50) NOT NULL,
    room_number VARCHAR(50) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    bed_status VARCHAR(50) NOT NULL DEFAULT 'Available'
);

CREATE TABLE IF NOT EXISTS ipd_system.admissions (
    admission_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    attending_doctor_id VARCHAR(50) NOT NULL,
    bed_id VARCHAR(50) NOT NULL,
    admission_date TIMESTAMP NOT NULL,
    discharge_date TIMESTAMP,
    admission_type VARCHAR(50) NOT NULL,
    discharge_status VARCHAR(50),
    length_of_stay_days INT
);

-- Associative Entity: บันทึกการย้ายเตียง (Change Card H03: Bed Transfers)
CREATE TABLE IF NOT EXISTS ipd_system.bed_transfers (
    transfer_id SERIAL PRIMARY KEY,
    admission_id VARCHAR(50) NOT NULL,
    from_bed_id VARCHAR(50) NOT NULL,
    to_bed_id VARCHAR(50) NOT NULL,
    transfer_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transfer_reason TEXT
);


-- ==============================================================================
-- 💰 โมดูล H3: ระบบการเงินและบัญชีค่าใช้จ่าย (Billing & Finance System)
-- ข้อมูลหลัก: ใบแจ้งหนี้, รายการค่าใช้จ่าย, การชำระเงิน (Change Card H02: Split Billing)
-- ==============================================================================

CREATE TABLE IF NOT EXISTS billing_system.invoices (
    invoice_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    policy_id INT, -- รองรับการตัดจ่ายผ่านประกัน (H02)
    service_type VARCHAR(50) NOT NULL,
    service_reference VARCHAR(50),
    total_amount_thb NUMERIC(12, 2) NOT NULL,
    insurance_paid_thb NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    patient_paid_thb NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    invoice_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
