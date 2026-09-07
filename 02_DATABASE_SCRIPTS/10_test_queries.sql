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
-- 👥 ส่วนที่ 3: แบบทดสอบรายบุคคลสำหรับสมาชิก H6 และ H7
-- ==============================================================================

-- ==============================================================================
-- 🛏️ ส่วนของสมาชิก H6: ระบบผู้ป่วยในและหอผู้ป่วย (Inpatient & Wards)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- [H6 - Query ข้อที่ 1]: รายงานสรุปอัตราการครองเตียงและสถานะความจุของแต่ละวอร์ด (Bed Occupancy Analytics)
-- คำอธิบาย: คำนวณจำนวนเตียงทั้งหมด, จำนวนเตียงที่ถูกใช้งาน, เตียงว่าง และคิดเป็น % อัตราการครองเตียง
-- ------------------------------------------------------------------------------
SELECT 
    w.ward_id AS "รหัสวอร์ด",
    w.ward_name AS "ชื่อหอผู้ป่วย",
    w.ward_type AS "ประเภทวอร์ด",
    dept.department_name AS "แผนกที่สังกัด",
    w.bed_capacity AS "ความจุเตียงสูงสุด",
    COUNT(b.bed_id) AS "เตียงที่ติดตั้งจริง",
    COUNT(b.bed_id) FILTER (WHERE b.bed_status = 'Occupied') AS "เตียงที่มีผู้ป่วยครอง",
    COUNT(b.bed_id) FILTER (WHERE b.bed_status = 'Available') AS "เตียงว่างพร้อมรับ",
    ROUND((COUNT(b.bed_id) FILTER (WHERE b.bed_status = 'Occupied')::NUMERIC / NULLIF(COUNT(b.bed_id), 0)) * 100, 2) AS "อัตราการครองเตียง (%)"
FROM ipd_system.wards w
JOIN staff_system.departments dept ON w.department_id = dept.department_id
LEFT JOIN ipd_system.beds b ON w.ward_id = b.ward_id
GROUP BY w.ward_id, w.ward_name, w.ward_type, dept.department_name, w.bed_capacity
ORDER BY "อัตราการครองเตียง (%)" DESC;

-- ------------------------------------------------------------------------------
-- [H6 - Query ข้อที่ 2]: รายงานประวัติและระยะเวลาการนอนโรงพยาบาลของผู้ป่วยใน (Inpatient Admission & Length of Stay)
-- คำอธิบาย: แสดงข้อมูลผู้ป่วยใน, วอร์ด, เตียง, แพทย์เจ้าของไข้, และจำนวนวันนอนจริง
-- ------------------------------------------------------------------------------
SELECT 
    adm.admission_id AS "รหัสการรับผู้ป่วย",
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อ-นามสกุลผู้ป่วย",
    w.ward_name AS "หอผู้ป่วย",
    b.room_number || ' (' || b.bed_type || ')' AS "ห้องและเตียง",
    doc.doctor_name AS "แพทย์เจ้าของไข้",
    adm.admission_date::DATE AS "วันที่รับเข้า",
    adm.discharge_date::DATE AS "วันที่จำหน่าย",
    adm.admission_type AS "ประเภทการรับเข้า",
    adm.discharge_status AS "สถานะจำหน่าย",
    COALESCE(adm.length_of_stay_days, (CURRENT_DATE - adm.admission_date::DATE)) AS "จำนวนวันนอน (วัน)"
FROM ipd_system.admissions adm
JOIN patient_system.patients p ON adm.patient_id = p.patient_id
JOIN ipd_system.beds b ON adm.bed_id = b.bed_id
JOIN ipd_system.wards w ON b.ward_id = w.ward_id
JOIN staff_system.doctors doc ON adm.attending_doctor_id = doc.doctor_id;

-- ------------------------------------------------------------------------------
-- [H6 - Test Case กรณีที่ 1]: ทดสอบ CHECK Constraint วันที่จำหน่าย (Admission Date Consistency)
-- วัตถุประสงค์: ยืนยันว่าระบบปฏิเสธข้อมูลที่ discharge_date เกิดขึ้นก่อน admission_date
-- ------------------------------------------------------------------------------
DO $$
BEGIN
    INSERT INTO ipd_system.admissions 
    (admission_id, patient_id, attending_doctor_id, bed_id, admission_date, discharge_date, admission_type, discharge_status)
    VALUES ('TEST_ADM_ERR', 'P000001', 'DOC001', 'BED02', '2026-09-01 10:00:00', '2026-08-01 10:00:00', 'Emergency', 'Recovered');
    RAISE EXCEPTION 'TEST FAILED: Database accepted invalid discharge date!';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'SUCCESS [H6 Test 1]: Check constraint chk_admission_dates successfully rejected invalid dates.';
END $$;

-- ------------------------------------------------------------------------------
-- [H6 - Test Case กรณีที่ 2]: ทดสอบ Referential Integrity ของเตียงและวอร์ด (Bed-Ward Integrity)
-- วัตถุประสงค์: ตรวจสอบว่าไม่สามารถสร้างเตียงโดยอ้างอิงวอร์ดที่ไม่มีอยู่จริงได้
-- ------------------------------------------------------------------------------
DO $$
BEGIN
    INSERT INTO ipd_system.beds (bed_id, ward_id, room_number, bed_type, bed_status)
    VALUES ('BED_FAKE', 'W999', 'Room 999', 'Standard', 'Available');
    RAISE EXCEPTION 'TEST FAILED: Database accepted bed with nonexistent ward!';
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'SUCCESS [H6 Test 2]: Foreign key constraint fk_beds_ward successfully prevented invalid ward reference.';
END $$;


-- ==============================================================================
-- 👨‍⚕️ ส่วนของสมาชิก H7: ระบบบริหารบุคลากรและแพทย์ (Staff & Personnel)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- [H7 - Query ข้อที่ 1]: รายงานการมอบหมายแพทย์เจ้าของไข้และหัวหน้าพยาบาลผู้ดูแลผู้ป่วยใน (Ward Clinical Care Assignment)
-- คำอธิบาย: เชื่อมโยงข้อมูลระหว่างระบบบุคลากร (H7) และระบบวอร์ดผู้ป่วยใน (H6) เพื่อตรวจสอบ
--          ว่าผู้ป่วยแต่ละคนมีแพทย์เจ้าของไข้ท่านใด และมีหัวหน้าพยาบาลวอร์ดคนใดเป็นผู้ดูแล
-- ------------------------------------------------------------------------------
SELECT 
    adm.admission_id AS "รหัสการรับเข้า",
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อผู้ป่วย",
    w.ward_name AS "หอผู้ป่วย",
    doc.doctor_name AS "แพทย์เจ้าของไข้ (H7)",
    doc.email AS "อีเมลแพทย์",
    nurse.first_name || ' ' || nurse.last_name AS "หัวหน้าพยาบาลประจำวอร์ด (H7)",
    nurse.phone AS "เบอร์ติดต่อพยาบาล",
    adm.admission_date AS "วันเวลาที่รับเข้า"
FROM ipd_system.admissions adm
JOIN patient_system.patients p ON adm.patient_id = p.patient_id
JOIN ipd_system.beds b ON adm.bed_id = b.bed_id
JOIN ipd_system.wards w ON b.ward_id = w.ward_id
JOIN staff_system.doctors doc ON adm.attending_doctor_id = doc.doctor_id
LEFT JOIN staff_system.employees nurse ON w.head_nurse_id = nurse.employee_id
ORDER BY adm.admission_date DESC;

-- ------------------------------------------------------------------------------
-- [H7 - Query ข้อที่ 2]: รายงานการตรวจสอบความถูกต้องของใบประกอบวิชาชีพและค่าตอบแทนบุคลากร (Medical Credentials & Payroll Audit)
-- คำอธิบาย: วิเคราะห์บุคลากรทางการแพทย์ทุกตำแหน่ง แผนกที่สังกัด เลขที่ใบอนุญาต วันหมดอายุ 
--          และประวัติยอดจ่ายเงินเดือนสุทธิล่าสุด เพื่อควบคุมมาตรฐานวิชาชีพและการบริหารงบประมาณ
-- ------------------------------------------------------------------------------
SELECT 
    emp.employee_id AS "รหัสบุคลากร",
    t.title_name || emp.first_name || ' ' || emp.last_name AS "ชื่อ-นามสกุล",
    pos.position_name AS "ตำแหน่งงาน",
    dept.department_name AS "แผนกที่สังกัด",
    lic.license_type AS "ประเภทใบอนุญาตวิชาชีพ",
    lic.license_number AS "เลขที่ใบอนุญาต",
    lic.expiry_date AS "วันหมดอายุใบอนุญาต",
    CASE 
        WHEN lic.expiry_date < CURRENT_DATE THEN 'ใบอนุญาตหมดอายุ ⚠️'
        WHEN lic.expiry_date <= CURRENT_DATE + INTERVAL '180 days' THEN 'ใกล้หมดอายุ (ภายใน 6 เดือน) ⏳'
        ELSE 'สถานะปกติ สมบูรณ์ ✅'
    END AS "สถานะใบอนุญาต",
    COALESCE(pay.net_amount, pos.base_salary) AS "เงินเดือนสุทธิล่าสุด (บาท)"
FROM staff_system.employees emp
LEFT JOIN staff_system.titles t ON emp.title_id = t.title_id
JOIN staff_system.departments dept ON emp.department_id = dept.department_id
JOIN staff_system.positions pos ON emp.position_id = pos.position_id
LEFT JOIN staff_system.medical_licenses lic ON emp.employee_id = lic.employee_id AND lic.status = 'active'
LEFT JOIN (
    SELECT employee_id, net_amount, pay_period_end,
           ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY pay_period_end DESC) as rn
    FROM staff_system.payroll
) pay ON emp.employee_id = pay.employee_id AND pay.rn = 1
ORDER BY dept.department_name, pos.position_name;

-- ------------------------------------------------------------------------------
-- [H7 - Test Case กรณีที่ 1]: ทดสอบ Referential Integrity ข้ามระบบ (Inter-Module Foreign Key Violation)
-- วัตถุประสงค์: ตรวจสอบว่าระบบป้องกันไม่ให้บันทึกการ Admit ใน H6 ด้วยรหัสแพทย์ที่ไม่มีใน H7
-- ------------------------------------------------------------------------------
DO $$
BEGIN
    INSERT INTO ipd_system.admissions 
    (admission_id, patient_id, attending_doctor_id, bed_id, admission_date, admission_type, discharge_status)
    VALUES ('TEST_FK_ERR', 'P000001', 'DOC_NONEXISTENT_999', 'BED01', CURRENT_TIMESTAMP, 'Emergency', 'Ongoing');
    RAISE EXCEPTION 'TEST FAILED: Database accepted admission with invalid doctor ID!';
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'SUCCESS [H7 Test 1]: Foreign key constraint fk_admissions_doctor successfully rejected invalid doctor reference.';
END $$;

-- ------------------------------------------------------------------------------
-- [H7 - Test Case กรณีที่ 2]: ทดสอบ Business Rule Constraint การยื่นใบลา (Check Constraint Validation)
-- วัตถุประสงค์: ยืนยันว่าระบบปฏิเสธคำขอลาที่มีวันที่สิ้นสุดมาก่อนวันที่เริ่มลา (end_date < start_date)
-- ------------------------------------------------------------------------------
DO $$
BEGIN
    INSERT INTO staff_system.leave_requests 
    (employee_id, leave_type_id, start_date, end_date, reason)
    VALUES ('EMP001', 1, '2026-10-15', '2026-10-10', 'วันสิ้นสุดมาก่อนวันเริ่มต้นเพื่อทดสอบระบบ');
    RAISE EXCEPTION 'TEST FAILED: Database accepted leave request with end_date earlier than start_date!';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'SUCCESS [H7 Test 2]: Check constraint chk_leave_dates successfully blocked invalid date range.';
END $$;

