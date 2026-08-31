-- ==============================================================================
-- 10_test_queries.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: คำสั่งทดสอบการทำงานของระบบรวม และแบบทดสอบรายบุคคล (Individual Test Cases)
-- ==============================================================================

\connect hospital_enterprise_db

-- ==============================================================================
-- 🎯 ส่วนที่ 1: การทดสอบ 3 กระบวนการกลางของโรงพยาบาล (Core Clinical Processes)
-- ==============================================================================

-- 1.1 ทดสอบกระบวนการที่ 1: ผู้ป่วยนอก (OPD Clinical Journey)
SELECT * FROM opd_system.v_opd_patient_flow;

-- 1.2 ทดสอบกระบวนการที่ 2: ผู้ป่วยใน (IPD Clinical Journey)
SELECT * FROM ipd_system.v_ipd_patient_flow;

-- 1.3 ทดสอบกระบวนการที่ 3: การตรวจสอบย้อนหลัง 360 องศา (Audit & Traceability 360°)
SELECT * FROM patient_system.v_patient_360_traceability;


-- ==============================================================================
-- 🙋‍♂️ ส่วนที่ 2: ส่วนของสมาชิก H1: ระบบทะเบียนผู้ป่วย (นายอภิสิทธิ์ ศรีพัฒน์ 6811011662010)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- [H1 - Query ข้อที่ 1]: การวิเคราะห์ผู้ป่วยที่ถือครองประกันสุขภาพหลายกรมธรรม์ (Multi-Insurance H02)
-- คำอธิบาย: ค้นหาผู้ป่วยที่มีสิทธิ์ประกันมากกว่า 1 ใบ พร้อมคำนวณวงเงินคุ้มครองรวมและการตัดจ่าย
-- ------------------------------------------------------------------------------
SELECT 
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อ-นามสกุล",
    COUNT(pol.policy_id) AS "จำนวนกรมธรรม์ที่ถือครอง",
    STRING_AGG(prov.provider_name || ' (' || pol.policy_number || ')', ' | ') AS "รายละเอียดกรมธรรม์",
    SUM(pol.coverage_limit) AS "วงเงินคุ้มครองรวม (บาท)"
FROM patient_system.patients p
JOIN patient_system.patient_insurance_policies pol ON p.patient_id = pol.patient_id
JOIN patient_system.insurance_providers prov ON pol.provider_id = prov.provider_id
GROUP BY p.patient_id, p.title_prefix, p.first_name, p.last_name
HAVING COUNT(pol.policy_id) > 1;

-- ------------------------------------------------------------------------------
-- [H1 - Query ข้อที่ 2]: รายงานสถิติประชากรศาสตร์ผู้ป่วยแยกตามจังหวัดและกลุ่มเลือด (Demographics Summary)
-- คำอธิบาย: สรุปจำนวนผู้ป่วยตามจังหวัดที่พักอาศัยและหมู่โลหิต เพื่อการบริหารเวชภัณฑ์ฉุกเฉิน
-- ------------------------------------------------------------------------------
SELECT 
    prov.province_name AS "จังหวัด",
    p.blood_group AS "หมู่โลหิต",
    COUNT(p.patient_id) AS "จำนวนผู้ป่วย (คน)",
    ROUND(AVG(p.weight_kg), 2) AS "น้ำหนักเฉลี่ย (กก.)",
    ROUND(AVG(p.height_cm), 2) AS "ส่วนสูงเฉลี่ย (ซม.)"
FROM patient_system.patients p
JOIN patient_system.provinces prov ON p.province_id = prov.province_id
GROUP BY prov.province_name, p.blood_group
ORDER BY prov.province_name, "จำนวนผู้ป่วย (คน)" DESC;


-- ------------------------------------------------------------------------------
-- [H1 - Test Case กรณีที่ 1]: ทดสอบ Referential Integrity & Anti-Orphan Rule
-- วัตถุประสงค์: ตรวจสอบว่าระบบป้องกันการเกิด Orphan Records เมื่อลบข้อมูล
-- ------------------------------------------------------------------------------
-- ทดสอบที่ 1.1: ห้ามลบจังหวัดที่มีผู้ป่วยอาศัยอยู่ (ต้องติด RESTRICT Error)
DO $$
BEGIN
    DELETE FROM patient_system.provinces WHERE province_id = 1;
    RAISE EXCEPTION 'TEST FAILED: Province was deleted but foreign key restrict should prevent it!';
EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'TEST PASSED: Cannot delete province referenced by patients (RESTRICT working perfectly).';
END $$;

-- ------------------------------------------------------------------------------
-- [H1 - Test Case กรณีที่ 2]: ทดสอบ Clinical Data Integrity & Physiological Check
-- วัตถุประสงค์: ตรวจสอบเงื่อนไข CHECK Constraints ป้องกันข้อมูลผิดปกติทางสรีรวิทยา
-- ------------------------------------------------------------------------------
-- ทดสอบที่ 2.1: ปฏิเสธการบันทึกผู้ป่วยที่มีวันเกิดในอนาคต
DO $$
BEGIN
    INSERT INTO patient_system.patients 
    (patient_id, first_name, last_name, gender, birth_date, province_id, patient_status)
    VALUES ('P_INVALID', 'ทดสอบ', 'วันเกิดอนาคต', 'M', CURRENT_DATE + INTERVAL '1 day', 1, 'Active');
    RAISE EXCEPTION 'TEST FAILED: Future birth date was accepted!';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'TEST PASSED: Future birth date was strictly rejected by CHECK constraint.';
END $$;


-- ==============================================================================
-- 👥 ส่วนที่ 3: พื้นที่สำหรับสมาชิก H2 - H7 เพิ่มเติม Query และ Test Cases
-- ==============================================================================
-- [H2 นัดหมาย/OPD]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H3 การเงิน]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H4 เภสัชกรรม]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H5 ห้องแล็บ]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H6 ผู้ป่วยใน]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H7 บุคลากร]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
