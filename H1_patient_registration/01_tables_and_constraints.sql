-- ===================================================
-- GROUP 2 — ENTERPRISE HOSPITAL INFORMATION SYSTEM v2
-- Production Database Schema (H1 Patient Registration)
-- ===================================================

-- สร้างและสลับไปยัง Schema "patient_system" (ระบบทะเบียนผู้ป่วย H1)
-- เพื่อหลีกเลี่ยงปัญหาการแสดงภาษาไทยเพี้ยน (Mojibake) ใน pgAdmin
DROP SCHEMA IF EXISTS "ระบบผู้ป่วย" CASCADE;
CREATE SCHEMA IF NOT EXISTS patient_system;
SET search_path TO patient_system, public;

-- 1. CLEANUP EXISTING TABLES (In correct order of dependency)
DROP TABLE IF EXISTS emergency_access_audit_log CASCADE;
DROP TABLE IF EXISTS patient_insurance_policies CASCADE;
DROP TABLE IF EXISTS insurance_providers CASCADE;
DROP TABLE IF EXISTS patient_contacts CASCADE;
DROP TABLE IF EXISTS users_security CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS hospital_branches CASCADE;
DROP TABLE IF EXISTS provinces CASCADE;

-- 2. CREATE PRODUCTION TABLES

-- A. Table: provinces (ตารางรายชื่อจังหวัด - Advanced Normalization)
CREATE TABLE provinces (
    province_id SERIAL PRIMARY KEY,
    province_name VARCHAR(100) UNIQUE NOT NULL
);

-- B. Table: hospital_branches (สาขาโรงพยาบาล)
CREATE TABLE hospital_branches (
    branch_id VARCHAR(50) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    province_id INT NOT NULL REFERENCES provinces(province_id) ON DELETE RESTRICT
);

-- C. Table: patients (ทะเบียนผู้ป่วย - ปรับปรุงโครงสร้างและใส่ constraints)
CREATE TABLE patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    title_prefix VARCHAR(50), -- คำนำหน้าชื่อ (เช่น นาย, นาง, นางสาว, ด.ช., ด.ญ., Mr., Ms., Mrs.)
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL CHECK (gender IN ('M', 'F', 'Other')),
    birth_date DATE NOT NULL CHECK (birth_date <= CURRENT_DATE),
    blood_group VARCHAR(10) CHECK (blood_group IN ('A', 'B', 'AB', 'O', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    province_id INT NOT NULL REFERENCES provinces(province_id) ON DELETE RESTRICT,
    weight_kg NUMERIC(5, 2) CHECK (weight_kg > 0.0 AND weight_kg < 300.0), -- ตรวจสอบความถูกต้องของน้ำหนักตามจริง
    height_cm NUMERIC(5, 2) CHECK (height_cm > 0.0 AND height_cm < 250.0), -- ตรวจสอบความถูกต้องของส่วนสูงตามจริง
    registered_branch_id VARCHAR(50) REFERENCES hospital_branches(branch_id) ON DELETE SET NULL,
    patient_status VARCHAR(20) NOT NULL CHECK (patient_status IN ('Active', 'Inactive', 'Transferred', 'Deceased'))
);

-- D. Table: patient_contacts (ข้อมูลการติดต่อคนไข้ - Advanced 3NF Separation)
CREATE TABLE patient_contacts (
    contact_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    contact_type VARCHAR(20) NOT NULL CHECK (contact_type IN ('Phone', 'Email')),
    contact_value VARCHAR(150) NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE,
    CONSTRAINT uniq_patient_contact UNIQUE (patient_id, contact_type, contact_value)
);

-- E. Table: doctors (ตารางแพทย์เพื่อรองรับความสัมพันธ์ของบัญชีผู้ใช้งาน)
CREATE TABLE doctors (
    doctor_id VARCHAR(50) PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    salary_thb NUMERIC(12, 2) CHECK (salary_thb > 0.0)
);

-- F. Table: roles (สิทธิ์การใช้งานของระบบ - 3NF Separation)
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- G. Table: users_security (ข้อมูลความปลอดภัยและบัญชีผู้ใช้งาน - 3NF Separation)
CREATE TABLE users_security (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_value VARCHAR(255) NOT NULL,
    password_algorithm VARCHAR(50) NOT NULL,
    role_id INT NOT NULL REFERENCES roles(role_id) ON DELETE RESTRICT,
    patient_id VARCHAR(50) REFERENCES patients(patient_id) ON DELETE SET NULL,
    doctor_id VARCHAR(50) REFERENCES doctors(doctor_id) ON DELETE SET NULL,
    account_status VARCHAR(50) NOT NULL CHECK (account_status IN ('Active', 'Locked', 'Disabled')),
    last_login TIMESTAMP
);

-- H. Table: insurance_providers (บริษัทประกันภัย/สิทธิ์การรักษา - Advanced Normalization)
CREATE TABLE insurance_providers (
    provider_id SERIAL PRIMARY KEY,
    provider_name VARCHAR(100) UNIQUE NOT NULL
);

-- I. Table: patient_insurance_policies (ตารางสิทธิ์การรักษาผู้ป่วย - Change Card H02)
CREATE TABLE patient_insurance_policies (
    policy_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    provider_id INT NOT NULL REFERENCES insurance_providers(provider_id) ON DELETE RESTRICT,
    policy_number VARCHAR(100) NOT NULL UNIQUE,
    coverage_limit NUMERIC(12, 2) NOT NULL CHECK (coverage_limit >= 0.0),
    expiry_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- J. Table: emergency_access_audit_log (ระบบบันทึกการเข้าถึงข้อมูลฉุกเฉิน - Change Card H06 / Break-Glass Audit)
CREATE TABLE emergency_access_audit_log (
    log_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users_security(user_id) ON DELETE RESTRICT,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    access_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    access_reason TEXT NOT NULL,
    ip_address VARCHAR(50)
);

-- K. Table: relationship_types (ประเภทความสัมพันธ์ผู้ติดต่อฉุกเฉิน)
CREATE TABLE relationship_types (
    relationship_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(100)
);

-- L. Table: patient_emergency_contacts (บุคคลติดต่อฉุกเฉิน / ญาติ)
CREATE TABLE patient_emergency_contacts (
    contact_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    full_name VARCHAR(150) NOT NULL,
    relationship_type_id INT NOT NULL REFERENCES relationship_types(relationship_type_id),
    phone_number VARCHAR(50) NOT NULL,
    priority_order INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- M. Table: address_types (ประเภทที่อยู่)
CREATE TABLE address_types (
    address_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(100)
);

-- N. Table: patient_addresses (ที่อยู่ผู้ป่วยตามมาตรฐาน 3NF)
CREATE TABLE patient_addresses (
    address_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    address_type_id INT NOT NULL REFERENCES address_types(address_type_id),
    address_line TEXT NOT NULL,
    province_id INT NOT NULL REFERENCES provinces(province_id),
    zipcode VARCHAR(10),
    is_primary BOOLEAN DEFAULT TRUE
);

-- O. Table: id_types (ประเภทเอกสารยืนยันตัวตน)
CREATE TABLE id_types (
    id_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(100)
);

-- P. Table: patient_identifications (เอกสารยืนยันตัวตนผู้ป่วย)
CREATE TABLE patient_identifications (
    record_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    id_type_id INT NOT NULL REFERENCES id_types(id_type_id),
    id_number VARCHAR(100) NOT NULL,
    issuing_country VARCHAR(100) DEFAULT 'Thailand',
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uniq_patient_id_type UNIQUE (patient_id, id_type_id, id_number)
);

-- Q. Table: allergy_severity_levels (ระดับความรุนแรงของการแพ้ยา/อาหาร)
CREATE TABLE allergy_severity_levels (
    severity_id SERIAL PRIMARY KEY,
    level_name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(100),
    badge_color VARCHAR(20) DEFAULT '#ef4444'
);

-- R. Table: patient_allergies (ประวัติการแพ้ยาและอาหาร)
CREATE TABLE patient_allergies (
    allergy_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    allergen_name VARCHAR(150) NOT NULL,
    allergy_type VARCHAR(50) NOT NULL CHECK (allergy_type IN ('Drug', 'Food', 'Environmental', 'Other')),
    severity_id INT NOT NULL REFERENCES allergy_severity_levels(severity_id),
    reaction_symptoms TEXT,
    diagnosed_date DATE DEFAULT CURRENT_DATE
);

-- S. Table: patient_chronic_conditions (ประวัติโรคประจำตัวเดิม)
CREATE TABLE patient_chronic_conditions (
    condition_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    condition_name VARCHAR(150) NOT NULL,
    icd_code VARCHAR(20),
    diagnosed_year INT,
    notes TEXT
);

-- T. Table: insurance_plans (แผนประกันสุขภาพ)
CREATE TABLE insurance_plans (
    plan_id SERIAL PRIMARY KEY,
    provider_id INT NOT NULL REFERENCES insurance_providers(provider_id) ON DELETE RESTRICT,
    plan_name VARCHAR(150) NOT NULL,
    plan_type VARCHAR(50) DEFAULT 'Health',
    copay_pct NUMERIC(5, 2) DEFAULT 0.00
);

-- U. Table: patient_pdpa_consents (บันทึกความยินยอม PDPA)
CREATE TABLE patient_pdpa_consents (
    consent_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patients(patient_id) ON DELETE CASCADE,
    consent_type VARCHAR(50) NOT NULL,
    is_agreed BOOLEAN NOT NULL DEFAULT TRUE,
    consent_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    consent_channel VARCHAR(50) DEFAULT 'Web Portal'
);

-- V. Table: user_login_logs (ประวัติการเข้าสู่ระบบ)
CREATE TABLE user_login_logs (
    log_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL REFERENCES users_security(user_id) ON DELETE CASCADE,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50) DEFAULT '127.0.0.1',
    login_status VARCHAR(20) DEFAULT 'SUCCESS'
);

-- 3. CREATE INDEXES FOR PERFORMANCE
CREATE INDEX idx_patients_name ON patients(last_name, first_name);
CREATE INDEX idx_patient_contacts_val ON patient_contacts(contact_value);
CREATE INDEX idx_users_username ON users_security(username);
CREATE INDEX idx_patient_allergies_pid ON patient_allergies(patient_id);
CREATE INDEX idx_patient_emergency_pid ON patient_emergency_contacts(patient_id);

-- 4. SECURITY ANNOTATIONS (M5 - Classify data columns)
COMMENT ON COLUMN patients.first_name IS 'Security Classification: PII (Confidential)';
COMMENT ON COLUMN patients.last_name IS 'Security Classification: PII (Confidential)';
COMMENT ON COLUMN patient_contacts.contact_value IS 'Security Classification: PII (Confidential)';
COMMENT ON COLUMN patients.weight_kg IS 'Security Classification: Health Data (Restricted)';
COMMENT ON COLUMN patients.height_cm IS 'Security Classification: Health Data (Restricted)';
COMMENT ON COLUMN users_security.password_value IS 'Security Classification: Credential (Highly Restricted)';
COMMENT ON COLUMN patient_insurance_policies.policy_number IS 'Security Classification: Financial/PII (Confidential)';

-- 5. DATA CLEANING & MIGRATION FROM STAGING TO PRODUCTION
SELECT 'Starting data migration...' AS log_message;

-- A. Migrate Provinces
INSERT INTO provinces (province_name)
SELECT DISTINCT TRIM(province) 
FROM (
    SELECT province FROM stg_hospital_branches WHERE province IS NOT NULL AND province <> ''
    UNION
    SELECT province FROM stg_patients WHERE province IS NOT NULL AND province <> ''
) t
ON CONFLICT DO NOTHING;

-- B. Migrate Branches
INSERT INTO hospital_branches (branch_id, branch_name, province_id)
SELECT b.branch_id, b.branch_name, p.province_id
FROM stg_hospital_branches b
JOIN provinces p ON TRIM(b.province) = p.province_name;

-- C. Migrate Patients (Deduplication + Cleaning Invalid Weight/Height + Foreign Key Mapping)
INSERT INTO patients (
    patient_id, first_name, last_name, gender, birth_date, blood_group, province_id, weight_kg, height_cm, registered_branch_id, patient_status
)
SELECT 
    patient_id, 
    first_name, 
    last_name, 
    gender, 
    CASE WHEN birth_date LIKE '%/%' OR birth_date = '31/02/1980' THEN '1900-01-01'::DATE ELSE CAST(NULLIF(birth_date, '') AS DATE) END AS birth_date, 
    CASE WHEN blood_group = 'X' THEN NULL ELSE blood_group END AS blood_group, 
    p.province_id, 
    CASE WHEN CAST(NULLIF(weight_kg, '') AS NUMERIC) > 300.0 OR CAST(NULLIF(weight_kg, '') AS NUMERIC) <= 0.0 THEN NULL ELSE CAST(NULLIF(weight_kg, '') AS NUMERIC) END AS weight_kg,
    CASE WHEN CAST(NULLIF(height_cm, '') AS NUMERIC) > 250.0 OR CAST(NULLIF(height_cm, '') AS NUMERIC) <= 0.0 THEN NULL ELSE CAST(NULLIF(height_cm, '') AS NUMERIC) END AS height_cm,
    registered_branch_id, 
    patient_status
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY patient_id) as rn
    FROM stg_patients
) t
JOIN provinces p ON TRIM(t.province) = p.province_name
WHERE rn = 1;

-- D. Migrate Patient Contacts (Separately migrating phone and email values)
-- D1. Migrate Phone numbers
INSERT INTO patient_contacts (patient_id, contact_type, contact_value, is_primary)
SELECT DISTINCT patient_id, 'Phone', phone, TRUE
FROM stg_patients
WHERE phone IS NOT NULL AND phone <> '';

-- D2. Migrate Emails
INSERT INTO patient_contacts (patient_id, contact_type, contact_value, is_primary)
SELECT DISTINCT patient_id, 'Email', email, TRUE
FROM stg_patients
WHERE email IS NOT NULL AND email <> '';

-- E. Migrate Doctors
INSERT INTO doctors (doctor_id, doctor_name, specialty, email, salary_thb)
SELECT doctor_id, doctor_name, position, email, 
       CASE WHEN CAST(NULLIF(salary_thb, '') AS NUMERIC) <= 0.0 THEN NULL ELSE CAST(NULLIF(salary_thb, '') AS NUMERIC) END
FROM stg_doctors;

-- F. Migrate Roles
INSERT INTO roles (role_name, description) VALUES
('patient', 'Patient Access Role'),
('doctor', 'Doctor Access Role'),
('nurse', 'Nurse Access Role'),
('admin', 'System Administrator Role'),
('billing_staff', 'Billing Staff Role'),
('lab_staff', 'Laboratory Staff Role');

-- G. Migrate Users (Linking to target patients/doctors using sequential patterns)
INSERT INTO users_security (
    user_id, username, password_value, password_algorithm, role_id, patient_id, doctor_id, account_status, last_login
)
SELECT 
    u.user_id,
    u.username,
    u.password_value,
    u.password_algorithm,
    r.role_id,
    -- Map patient_id if role is patient and the mapped patient exists in patients table
    CASE WHEN u.role_name = 'patient' THEN 
        (SELECT p.patient_id FROM patients p WHERE p.patient_id = ('P' || LPAD(SUBSTRING(u.username FROM 'hospital_user([0-9]+)'), 6, '0')))
        ELSE NULL END,
    -- Map doctor_id if role is doctor and the mapped doctor exists in doctors table
    CASE WHEN u.role_name = 'doctor' THEN 
        (SELECT d.doctor_id FROM doctors d WHERE d.doctor_id = ('DR' || LPAD(SUBSTRING(u.username FROM 'hospital_user([0-9]+)'), 4, '0')))
        ELSE NULL END,
    u.account_status,
    CAST(NULLIF(u.last_login, '') AS TIMESTAMP)
FROM stg_users_security_lab u
JOIN roles r ON u.role_name = r.role_name;

-- H. Populate Insurance Providers Lookup
INSERT INTO insurance_providers (provider_name) VALUES
('AIA'),
('Allianz'),
('Cigna'),
('Bupa'),
('Thai Health'),
('Government Welfare'),
('Social Security Card')
ON CONFLICT DO NOTHING;

-- 6. BREAK-GLASS EMERGENCY ACCESS FUNCTION (Change Card H06)
CREATE OR REPLACE FUNCTION request_emergency_access(
    p_user_id VARCHAR,
    p_patient_id VARCHAR,
    p_reason TEXT
)
RETURNS TABLE (
    patient_id VARCHAR,
    first_name VARCHAR,
    last_name VARCHAR,
    gender VARCHAR,
    birth_date DATE,
    blood_group VARCHAR,
    weight_kg NUMERIC,
    height_cm NUMERIC,
    patient_status VARCHAR
) AS $$
BEGIN
    -- Log the emergency access event to audit trail
    INSERT INTO emergency_access_audit_log (user_id, patient_id, access_reason)
    VALUES (p_user_id, p_patient_id, p_reason);
    
    -- Return the patient records
    RETURN QUERY
    SELECT p.patient_id, p.first_name, p.last_name, p.gender, p.birth_date, p.blood_group, p.weight_kg, p.height_cm, p.patient_status
    FROM patients p
    WHERE p.patient_id = p_patient_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. DEFINE DATABASE ROLES AND PRIVILEGES (RBAC)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'patient_admin_role') THEN
        CREATE ROLE patient_admin_role;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'medical_staff_role') THEN
        CREATE ROLE medical_staff_role;
    END IF;
END
$$;

-- Grant permissions to patient_admin_role (Can manage patients demographics)
GRANT SELECT, INSERT, UPDATE ON patients TO patient_admin_role;
GRANT SELECT, INSERT, UPDATE ON hospital_branches TO patient_admin_role;
GRANT SELECT, INSERT, UPDATE ON patient_contacts TO patient_admin_role;
GRANT SELECT, INSERT, UPDATE ON patient_insurance_policies TO patient_admin_role;

-- Grant permissions to medical_staff_role (Can only view patients through emergency function)
GRANT EXECUTE ON FUNCTION request_emergency_access(VARCHAR, VARCHAR, TEXT) TO medical_staff_role;
