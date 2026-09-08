-- ==============================================================================
-- H1_TO_H6_INTEGRATION.SQL (SCHEMA: u68001)
-- โครงการ: บูรณาการรวมฐานข้อมูลโรงพยาบาล (Hospital Information System Integration)
-- เฉพาะระบบย่อย H1, H2, H3, H4, H5, H6 (รันใน Schema u68001 ได้สิทธิ์ 100%)
-- ==============================================================================

SET search_path TO u68001, public;

-- ==============================================================================
-- 1. CREATE TABLES (H1 ถึง H6) ใน Schema u68001
-- ==============================================================================

-- H1: ทะเบียนผู้ป่วย
CREATE TABLE IF NOT EXISTS u68001.provinces (
    province_id SERIAL PRIMARY KEY,
    province_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS u68001.hospital_branches (
    branch_id VARCHAR(50) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    province_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS u68001.patients (
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

CREATE TABLE IF NOT EXISTS u68001.patient_contacts (
    contact_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    contact_type VARCHAR(20) NOT NULL,
    contact_value VARCHAR(150) NOT NULL,
    is_primary BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS u68001.insurance_providers (
    provider_id SERIAL PRIMARY KEY,
    provider_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS u68001.patient_insurance_policies (
    policy_id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    provider_id INT NOT NULL,
    policy_number VARCHAR(100) UNIQUE NOT NULL,
    coverage_limit NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    expiry_date DATE NOT NULL
);

-- H2: นัดหมาย/OPD
CREATE TABLE IF NOT EXISTS u68001.appointments (
    appointment_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    branch_id VARCHAR(50) NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    reason TEXT
);

CREATE TABLE IF NOT EXISTS u68001.diagnoses (
    diagnosis_id VARCHAR(50) PRIMARY KEY,
    icd10_code VARCHAR(20) NOT NULL,
    disease_name_th VARCHAR(150) NOT NULL,
    disease_name_en VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS u68001.clinical_records (
    record_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    diagnosis_id VARCHAR(50) NOT NULL,
    symptoms TEXT NOT NULL,
    treatment_plan TEXT,
    visit_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- H5: ห้องแล็บ
CREATE TABLE IF NOT EXISTS u68001.lab_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lab_type VARCHAR(100) NOT NULL,
    order_status VARCHAR(50) NOT NULL DEFAULT 'Requested'
);

CREATE TABLE IF NOT EXISTS u68001.lab_results (
    result_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    result_value VARCHAR(100) NOT NULL,
    unit VARCHAR(20),
    normal_range VARCHAR(50),
    result_status VARCHAR(50) NOT NULL DEFAULT 'Final'
);

-- H4: เภสัชกรรม
CREATE TABLE IF NOT EXISTS u68001.medications (
    medication_id VARCHAR(50) PRIMARY KEY,
    medication_name VARCHAR(150) NOT NULL,
    generic_name VARCHAR(150),
    unit_price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS u68001.prescriptions (
    prescription_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    prescription_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dispense_status VARCHAR(50) NOT NULL DEFAULT 'Pending'
);

CREATE TABLE IF NOT EXISTS u68001.prescription_items (
    item_id SERIAL PRIMARY KEY,
    prescription_id VARCHAR(50) NOT NULL,
    medication_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    instructions TEXT
);

-- H6: ผู้ป่วยใน/วอร์ด
CREATE TABLE IF NOT EXISTS u68001.wards (
    ward_id VARCHAR(50) PRIMARY KEY,
    ward_name VARCHAR(100) NOT NULL,
    ward_type VARCHAR(50) NOT NULL,
    bed_capacity INT NOT NULL,
    head_nurse_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS u68001.beds (
    bed_id VARCHAR(50) PRIMARY KEY,
    ward_id VARCHAR(50) NOT NULL,
    room_number VARCHAR(50) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    bed_status VARCHAR(50) NOT NULL DEFAULT 'Available'
);

CREATE TABLE IF NOT EXISTS u68001.admissions (
    admission_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    attending_doctor_name VARCHAR(100) NOT NULL,
    bed_id VARCHAR(50) NOT NULL,
    admission_date TIMESTAMP NOT NULL,
    discharge_date TIMESTAMP,
    admission_type VARCHAR(50) NOT NULL,
    discharge_status VARCHAR(50)
);

-- ==============================================================================
-- 2. FOREIGN KEY CONSTRAINTS (CONNECTING H1 TO H6 IN u68001)
-- ==============================================================================

-- H3 การเงิน (ใช้ตาราง invoices ที่มีอยู่แล้ว หรือสร้างใหม่)
CREATE TABLE IF NOT EXISTS u68001.h3_invoices (
    invoice_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    policy_id INT,
    service_type VARCHAR(50) NOT NULL,
    service_reference VARCHAR(50),
    total_amount_thb NUMERIC(12, 2) NOT NULL,
    insurance_paid_thb NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    patient_paid_thb NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    invoice_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- เพิ่ม Foreign Key เชื่อมหา H1 (patients)
ALTER TABLE u68001.h3_invoices
    DROP CONSTRAINT IF EXISTS fk_h3_invoices_patient,
    ADD CONSTRAINT fk_h3_invoices_patient
    FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE;

ALTER TABLE u68001.appointments
    DROP CONSTRAINT IF EXISTS fk_appointments_patient,
    ADD CONSTRAINT fk_appointments_patient 
    FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE;

ALTER TABLE u68001.lab_orders
    DROP CONSTRAINT IF EXISTS fk_lab_patient,
    ADD CONSTRAINT fk_lab_patient 
    FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE;

ALTER TABLE u68001.prescriptions
    DROP CONSTRAINT IF EXISTS fk_prescriptions_patient,
    ADD CONSTRAINT fk_prescriptions_patient 
    FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE;

ALTER TABLE u68001.admissions
    DROP CONSTRAINT IF EXISTS fk_admissions_patient,
    ADD CONSTRAINT fk_admissions_patient 
    FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE,
    DROP CONSTRAINT IF EXISTS fk_admissions_bed,
    ADD CONSTRAINT fk_admissions_bed 
    FOREIGN KEY (bed_id) REFERENCES u68001.beds(bed_id) ON DELETE RESTRICT;

-- ==============================================================================
-- 3. INSERT SAMPLE DATA (ข้อมูลทดสอบเฉพาะ H1 - H6 ใน u68001)
-- ==============================================================================

INSERT INTO u68001.provinces (province_id, province_name) VALUES (1, 'กรุงเทพมหานคร') ON CONFLICT DO NOTHING;
INSERT INTO u68001.hospital_branches (branch_id, branch_name, province_id) VALUES ('BR-01', 'สำนักงานใหญ่', 1) ON CONFLICT DO NOTHING;
INSERT INTO u68001.patients (patient_id, first_name, last_name, gender, birth_date, province_id) 
VALUES ('HN-001', 'สมชาย', 'ใจดี', 'M', '1985-05-20', 1) ON CONFLICT DO NOTHING;

INSERT INTO u68001.appointments (appointment_id, patient_id, doctor_name, branch_id, appointment_date, reason)
VALUES ('APP-001', 'HN-001', 'นพ. วิชัย รักษาดี', 'BR-01', CURRENT_TIMESTAMP, 'ตรวจสุขภาพประจำปี') ON CONFLICT DO NOTHING;

INSERT INTO u68001.lab_orders (order_id, patient_id, doctor_name, lab_type)
VALUES ('LAB-001', 'HN-001', 'นพ. วิชัย รักษาดี', 'Blood Glucose') ON CONFLICT DO NOTHING;

INSERT INTO u68001.prescriptions (prescription_id, patient_id, doctor_name)
VALUES ('RX-001', 'HN-001', 'นพ. วิชัย รักษาดี') ON CONFLICT DO NOTHING;

INSERT INTO u68001.wards (ward_id, ward_name, ward_type, bed_capacity)
VALUES ('WARD-01', 'วอร์ดอายุรกรรมชาย', 'General', 10) ON CONFLICT DO NOTHING;

INSERT INTO u68001.beds (bed_id, ward_id, room_number, bed_type)
VALUES ('BED-001', 'WARD-01', '101', 'Standard') ON CONFLICT DO NOTHING;

INSERT INTO u68001.admissions (admission_id, patient_id, attending_doctor_name, bed_id, admission_date, admission_type)
VALUES ('ADM-001', 'HN-001', 'นพ. วิชัย รักษาดี', 'BED-001', CURRENT_TIMESTAMP, 'Emergency') ON CONFLICT DO NOTHING;

INSERT INTO u68001.h3_invoices (invoice_id, patient_id, service_type, service_reference, total_amount_thb, patient_paid_thb, payment_method, payment_status)
VALUES ('INV-2026-001', 'HN-001', 'OPD Visit', 'APP-001', 1500.00, 1500.00, 'PromptPay', 'Paid') ON CONFLICT DO NOTHING;
