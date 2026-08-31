-- ==============================================================================
-- 03_sample_data.sql
-- ข้อมูลตัวอย่างทดสอบสำหรับโมดูล H2: นัดหมาย/OPD
-- ==============================================================================

SET search_path TO opd_system, patient_system, staff_system, public;

-- ข้อมูลรหัสโรค ICD-10
INSERT INTO opd_system.diagnoses (diagnosis_id, icd_code, diagnosis_name, diagnosis_category) VALUES
('D01', 'I10', 'ความดันโลหิตสูงไม่ทราบสาเหตุ (Essential Hypertension)', 'ระบบไหลเวียนโลหิต'),
('D02', 'E11', 'เบาหวานชนิดที่ 2 (Type 2 Diabetes Mellitus)', 'ต่อมไร้ท่อและเมตาบอลิซึม'),
('D03', 'J00', 'โพรงจมูกและคอหอยอักเสบเฉียบพลัน/หวัด (Acute Nasopharyngitis)', 'ระบบทางเดินหายใจ'),
('D04', 'K29', 'โรคกระเพาะอาหารอักเสบ (Gastritis and Duodenitis)', 'ระบบทางเดินอาหาร')
ON CONFLICT (diagnosis_id) DO NOTHING;

-- ข้อมูลการนัดหมาย
INSERT INTO opd_system.appointments 
(appointment_id, patient_id, doctor_id, branch_id, appointment_date, appointment_time, appointment_status, appointment_source) VALUES
('APT001', 'P000001', 'DOC001', 'B001', '2026-09-05', '09:30:00', 'Scheduled', 'Mobile App'),
('APT002', 'P000002', 'DOC002', 'B001', '2026-09-06', '10:00:00', 'Confirmed', 'Walk-in'),
('APT003', 'P000003', 'DOC001', 'B003', '2026-09-07', '13:00:00', 'Scheduled', 'Call Center')
ON CONFLICT (appointment_id) DO NOTHING;

-- ข้อมูลบันทึกสัญญาณชีพและผลการตรวจ
INSERT INTO opd_system.clinical_records 
(record_id, patient_id, doctor_id, diagnosis_id, record_date, systolic_bp, diastolic_bp, temperature_c, blood_glucose_mg_dl, care_setting) VALUES
('CR001', 'P000001', 'DOC001', 'D01', '2026-08-31 10:15:00', 138.0, 88.0, 36.7, 115.0, 'OPD'),
('CR002', 'P000002', 'DOC002', 'D02', '2026-08-31 11:00:00', 120.0, 78.0, 36.5, 142.0, 'OPD')
ON CONFLICT (record_id) DO NOTHING;
