-- ==============================================================================
-- H2: ระบบนัดหมายและงานผู้ป่วยนอก (Appointments & OPD System)
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Enterprise HIS v2) - กลุ่มที่ 2
-- ผู้รับผิดชอบ: โมดูล H2 (Appointments & OPD)
-- ==============================================================================

CREATE SCHEMA IF NOT EXISTS opd_system;
SET search_path TO opd_system, patient_system, staff_system, public;

-- 1. ตารางการวินิจฉัยโรคตามมาตรฐาน ICD-10
CREATE TABLE IF NOT EXISTS opd_system.diagnoses (
    diagnosis_id VARCHAR(50) PRIMARY KEY,
    icd_code VARCHAR(50) UNIQUE NOT NULL,
    diagnosis_name VARCHAR(255) NOT NULL,
    diagnosis_category VARCHAR(100)
);

-- 2. ตารางการนัดหมายผู้ป่วยนอก (Appointments)
CREATE TABLE IF NOT EXISTS opd_system.appointments (
    appointment_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patient_system.patients(patient_id) ON DELETE CASCADE,
    doctor_id VARCHAR(50) NOT NULL,
    branch_id VARCHAR(50) NOT NULL REFERENCES patient_system.hospital_branches(branch_id) ON DELETE RESTRICT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_status VARCHAR(50) NOT NULL CHECK (appointment_status IN ('Scheduled', 'Confirmed', 'Completed', 'Cancelled', 'No-show')),
    appointment_source VARCHAR(50) DEFAULT 'Walk-in'
);

-- 3. ตารางบันทึกการตรวจรักษาผู้ป่วยนอกและสัญญาณชีพ (Clinical Records)
CREATE TABLE IF NOT EXISTS opd_system.clinical_records (
    record_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patient_system.patients(patient_id) ON DELETE CASCADE,
    doctor_id VARCHAR(50) NOT NULL,
    diagnosis_id VARCHAR(50) NOT NULL REFERENCES opd_system.diagnoses(diagnosis_id) ON DELETE RESTRICT,
    record_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    systolic_bp NUMERIC(5, 2) CHECK (systolic_bp > 40 AND systolic_bp < 300),
    diastolic_bp NUMERIC(5, 2) CHECK (diastolic_bp > 20 AND diastolic_bp < 200),
    temperature_c NUMERIC(4, 2) CHECK (temperature_c > 30.0 AND temperature_c < 45.0),
    blood_glucose_mg_dl NUMERIC(5, 2) CHECK (blood_glucose_mg_dl > 10.0),
    care_setting VARCHAR(50) DEFAULT 'OPD'
);

-- สร้าง Indexes เพื่อเพิ่มความเร็วในการค้นหา
CREATE INDEX IF NOT EXISTS idx_apt_patient ON opd_system.appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_apt_date ON opd_system.appointments(appointment_date);
CREATE INDEX IF NOT EXISTS idx_cr_patient ON opd_system.clinical_records(patient_id);
