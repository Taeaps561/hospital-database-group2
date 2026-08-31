-- ==============================================================================
-- 02_queries_and_tests.sql
-- คำสั่ง Query วิเคราะห์ข้อมูล และ Test Cases สำหรับโมดูล H2: นัดหมาย/OPD
-- ==============================================================================

SET search_path TO opd_system, patient_system, staff_system, public;

-- [Query 1]: รายงานการนัดหมายผู้ป่วยแยกตามสถานะและสาขา
SELECT 
    b.branch_name AS "สาขาโรงพยาบาล",
    apt.appointment_status AS "สถานะการนัด",
    COUNT(apt.appointment_id) AS "จำนวนนัดหมาย (รายการ)"
FROM opd_system.appointments apt
JOIN patient_system.hospital_branches b ON apt.branch_id = b.branch_id
GROUP BY b.branch_name, apt.appointment_status
ORDER BY b.branch_name, "จำนวนนัดหมาย (รายการ)" DESC;

-- [Query 2]: คัดกรองผู้ป่วยกลุ่มเสี่ยงความดันโลหิตสูงและเบาหวาน (Clinical Risk Screen)
SELECT 
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อ-นามสกุล",
    cr.systolic_bp AS "ความดันตัวบน (mmHg)",
    cr.diastolic_bp AS "ความดันตัวล่าง (mmHg)",
    cr.blood_glucose_mg_dl AS "ระดับน้ำตาลในเลือด (mg/dL)",
    diag.diagnosis_name AS "ผลการวินิจฉัย"
FROM opd_system.clinical_records cr
JOIN patient_system.patients p ON cr.patient_id = p.patient_id
JOIN opd_system.diagnoses diag ON cr.diagnosis_id = diag.diagnosis_id
WHERE cr.systolic_bp >= 140.0 OR cr.blood_glucose_mg_dl >= 126.0;

-- [Test Case 1]: ตรวจสอบ Foreign Key ห้ามนัดหมายผู้ป่วยที่ไม่มีรหัสใน H1
DO $$
BEGIN
    INSERT INTO opd_system.appointments 
    (appointment_id, patient_id, doctor_id, branch_id, appointment_date, appointment_time, appointment_status)
    VALUES ('APT_TEST_ERR', 'NON_EXISTENT_P', 'DOC001', 'B001', CURRENT_DATE, '10:00:00', 'Scheduled');
    RAISE EXCEPTION 'TEST FAILED: Appointment created for non-existent patient!';
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'TEST PASSED: Cannot create appointment for non-existent patient.';
END $$;

-- [Test Case 2]: ตรวจสอบสัญญาณชีพขีดจำกัดสรีรวิทยา (Check Constraint)
DO $$
BEGIN
    INSERT INTO opd_system.clinical_records 
    (record_id, patient_id, doctor_id, diagnosis_id, systolic_bp)
    VALUES ('CR_TEST_ERR', 'P000001', 'DOC001', 'D01', 500.0);
    RAISE EXCEPTION 'TEST FAILED: Impossible systolic BP accepted!';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'TEST PASSED: Abnormal physiological vital signs rejected.';
END $$;
