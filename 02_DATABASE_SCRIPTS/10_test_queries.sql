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
-- 🙋‍♂️ ส่วนที่ 2: ส่วนของสมาชิก H1: ระบบทะเบียนผู้ป่วย
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
-- วัตถุประสงค์: ตรวจสอบว่าระบบป้องกันการเกิด Orphan Records (ห้ามลบจังหวัดที่มีสาขา/ผู้ป่วยอ้างอิง)
-- ------------------------------------------------------------------------------
-- ค้นหาจังหวัดที่มีสาขาหรือผู้ป่วยอ้างอิงอยู่จริง (พิสูจน์ความสัมพันธ์ของ Foreign Key)
SELECT 
    p.province_id,
    p.province_name,
    COUNT(DISTINCT b.branch_id) AS "จำนวนสาขาที่เชื่อมโยง",
    COUNT(DISTINCT pt.patient_id) AS "จำนวนผู้ป่วยที่ลงทะเบียน"
FROM patient_system.provinces p
LEFT JOIN patient_system.hospital_branches b ON p.province_id = b.province_id
LEFT JOIN patient_system.patients pt ON p.province_id = pt.province_id
WHERE p.province_id = 1
GROUP BY p.province_id, p.province_name;

-- ------------------------------------------------------------------------------
-- [H1 - Test Case กรณีที่ 2]: ทดสอบ Clinical Data Integrity & Physiological Check
-- วัตถุประสงค์: ตรวจสอบเงื่อนไข CHECK Constraints และสถิติข้อมูลผู้ป่วยที่ถูกต้องตามกฎเกณฑ์
-- ------------------------------------------------------------------------------
-- ตรวจสอบว่าไม่มีผู้ป่วยคนใดที่มีวันเกิดในอนาคต หรือค่าน้ำหนัก/ส่วนสูงผิดปกติ (Validation Audit)
SELECT 
    COUNT(*) AS "จำนวนผู้ป่วยทั้งหมด",
    COUNT(*) FILTER (WHERE birth_date <= CURRENT_DATE) AS "ผู้ป่วยวันเกิดถูกต้องตามกฎ",
    COUNT(*) FILTER (WHERE weight_kg > 0 AND weight_kg < 300) AS "ผู้ป่วยน้ำหนักสมเหตุสมผล",
    COUNT(*) FILTER (WHERE height_cm > 0 AND height_cm < 250) AS "ผู้ป่วยส่วนสูงสมเหตุสมผล"
FROM patient_system.patients;


-- ==============================================================================
-- 👥 ส่วนที่ 3: พื้นที่สำหรับสมาชิก H2 - H7 เพิ่มเติม Query และ Test Cases
-- ==============================================================================
-- [H2 นัดหมาย/OPD]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H3 การเงิน]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H4 เภสัชกรรม]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H5 ห้องแล็บ]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H6 ผู้ป่วยใน]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
-- [H7 บุคลากร]: เพิ่มเติม Query 2 ข้อ และ Test Case 2 ข้อที่นี่
