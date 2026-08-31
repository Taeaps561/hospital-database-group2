-- ==============================================================================
-- งานสัปดาห์ที่ 11: การเรียกใช้และวิเคราะห์ข้อมูลด้วย PostgreSQL
-- ชื่อ-นามสกุล: นายอภิสิทธิ์ ศรีพัฒน์
-- รหัสนักศึกษา: 6811011662010
-- ระบบย่อย: ระบบลงทะเบียนและประวัติผู้ป่วย (Patient Registration & Demographics - Module H1)
-- Table ที่รับผิดชอบ: patient_system.patients, patient_system.patient_contacts, 
--                     patient_system.provinces, patient_system.hospital_branches, 
--                     patient_system.users_security
-- ==============================================================================

-- กำหนด schema การทำงานเป็น patient_system
SET search_path TO patient_system, public;


-- ==============================================================================
-- ส่วนที่ 1: ตรวจสอบฐานข้อมูลก่อนทำงาน
-- ==============================================================================

-- ข้อ 1.2 ตรวจสอบจำนวนข้อมูลของทุก Table ที่รับผิดชอบ
SELECT 'patients' AS table_name, COUNT(*) AS total_rows FROM patient_system.patients
UNION ALL
SELECT 'patient_contacts', COUNT(*) FROM patient_system.patient_contacts
UNION ALL
SELECT 'provinces', COUNT(*) FROM patient_system.provinces
UNION ALL
SELECT 'hospital_branches', COUNT(*) FROM patient_system.hospital_branches
UNION ALL
SELECT 'users_security', COUNT(*) FROM patient_system.users_security;
-- ผลที่คาดหวัง: patients 50,000 แถว, patient_contacts 99,985 แถว, users_security 1,000 แถว
-- คำอธิบาย: ตรวจสอบความพร้อมของข้อมูล โดย Table หลักมีมากกว่า 10 แถว และ Table รายการสัมพันธ์มีมากกว่า 20 แถวครบตามเกณฑ์


-- ==============================================================================
-- ส่วนที่ 2: การเรียกดูและกรองข้อมูล
-- ==============================================================================

-- ข้อ 2.1 SELECT และ Alias
-- คำถามที่ต้องการหาคำตอบ: แสดงรหัส ชื่อ นามสกุล เพศ และวันเกิดของผู้ป่วย โดยตั้งชื่อคอลัมน์ให้อ่านง่ายเป็นภาษาไทย
SELECT 
    patient_id AS "รหัสผู้ป่วย",
    first_name AS "ชื่อ",
    last_name AS "นามสกุล",
    gender AS "เพศ",
    birth_date AS "วันเดือนปีเกิด"
FROM patient_system.patients
LIMIT 10;
-- ผลที่คาดหวัง: แสดงข้อมูลผู้ป่วย 5 คอลัมน์แรก จำนวน 10 รายการ พร้อมหัวคอลัมน์ภาษาไทย
-- คำอธิบาย: ใช้ SELECT เลือกคอลัมน์ที่จำเป็น และใช้ AS เพื่อเปลี่ยนชื่อคอลัมน์ให้สื่อความหมายเข้าใจง่าย


-- ข้อ 2.2 WHERE และ Operators
-- คำถามที่ต้องการหาคำตอบ: ค้นหาผู้ป่วยเพศหญิง (F) ที่มีน้ำหนักตัวตั้งแต่ 70 กก. ขึ้นไปเพื่อคัดกรองกลุ่มเสี่ยง
SELECT patient_id, first_name, last_name, gender, weight_kg, height_cm
FROM patient_system.patients
WHERE gender = 'F' AND weight_kg >= 70.0
LIMIT 10;
-- ผลที่คาดหวัง: รายชื่อเฉพาะผู้ป่วยเพศหญิงที่มีน้ำหนัก >= 70.0 กก.
-- คำอธิบาย: ใช้ตัวดำเนินการ = ร่วมกับ >= และ AND ในการกรองเงื่อนไขพร้อมกัน 2 เงื่อนไข


-- ข้อ 2.3 LIKE
-- คำถามที่ต้องการหาคำตอบ: ค้นหาผู้ป่วยที่ชื่อต้นขึ้นต้นด้วยตัวอักษร 'S' (เช่น Somchai, Supansa)
SELECT patient_id, first_name, last_name, gender
FROM patient_system.patients
WHERE first_name ILIKE 'S%'
LIMIT 10;
-- ผลที่คาดหวัง: รายชื่อผู้ป่วยที่ชื่อขึ้นต้นด้วย S หรือ s
-- คำอธิบาย: ใช้ ILIKE 'S%' เพื่อค้นหาข้อความที่ขึ้นต้นด้วย S โดยไม่สนใจตัวพิมพ์เล็ก-ใหญ่


-- ข้อ 2.4 IN
-- คำถามที่ต้องการหาคำตอบ: คัดกรองผู้ป่วยที่มีหมู่เลือดเฉพาะเจาะจง ได้แก่ หมู่เลือด 'AB' และ 'O'
SELECT patient_id, first_name, last_name, blood_group
FROM patient_system.patients
WHERE blood_group IN ('AB', 'O')
LIMIT 10;
-- ผลที่คาดหวัง: รายชื่อผู้ป่วยที่มี blood_group เป็น AB หรือ O
-- คำอธิบาย: ใช้ IN ('AB', 'O') แทนการเขียน OR หลายชั้น เพื่อกรองค่าที่ตรงกับสมาชิกในเซต


-- ข้อ 2.5 BETWEEN
-- คำถามที่ต้องการหาคำตอบ: ค้นหากลุ่มผู้ป่วยวัยรุ่นที่เกิดระหว่างปี ค.ศ. 2000 ถึง 2005
SELECT patient_id, first_name, last_name, birth_date
FROM patient_system.patients
WHERE birth_date BETWEEN '2000-01-01' AND '2005-12-31'
LIMIT 10;
-- ผลที่คาดหวัง: ข้อมูลผู้ป่วยที่มีวันเกิดอยู่ในช่วง 2000-01-01 ถึง 2005-12-31
-- คำอธิบาย: ใช้ BETWEEN ในการระบุช่วงวันที่แบบรวมขอบเขตหัวท้าย เพื่อคัดกรองกลุ่มอายุที่ต้องการ


-- ข้อ 2.6 DISTINCT
-- คำถามที่ต้องการหาคำตอบ: ในฐานข้อมูลโรงพยาบาลนี้ มีการจัดเก็บหมู่เลือดประเภทใดอยู่บ้างโดยไม่ซ้ำกัน?
SELECT DISTINCT blood_group AS "หมู่เลือดที่มีในระบบ"
FROM patient_system.patients
ORDER BY blood_group;
-- ผลที่คาดหวัง: รายการหมู่เลือดที่ไม่ซ้ำ (A, AB, B, O)
-- คำอธิบาย: คำสั่ง DISTINCT ช่วยตัดค่าที่ซ้ำออก เพื่อสรุปว่าระบบมีชนิดของหมู่เลือดกี่ประเภทในระบบ


-- ==============================================================================
-- ส่วนที่ 3: การเรียงลำดับและสรุปข้อมูล
-- ==============================================================================

-- ข้อ 3.1 ORDER BY และ LIMIT
-- คำถามที่ต้องการหาคำตอบ: แสดงข้อมูลผู้ป่วยอายุน้อยที่สุด (เกิดล่าสุด) 5 อันดับแรกของโรงพยาบาล
SELECT patient_id, first_name, last_name, birth_date
FROM patient_system.patients
ORDER BY birth_date DESC
LIMIT 5;
-- ผลที่คาดหวัง: รายชื่อผู้ป่วย 5 รายที่มีวันเกิดล่าสุด
-- คำอธิบาย: ใช้ ORDER BY birth_date DESC เรียงจากวันเกิดล่าสุดลงมา และใช้ LIMIT 5 เพื่อดูผู้ป่วยเด็กแรกเกิด


-- ข้อ 3.2 MIN และ MAX
-- คำถามที่ต้องการหาคำตอบ: น้ำหนักตัวต่ำสุด/สูงสุด และส่วนสูงต่ำสุด/สูงสุดของผู้ป่วยในระบบเป็นเท่าใด?
SELECT 
    MIN(weight_kg) AS "น้ำหนักต่ำสุด_กก",
    MAX(weight_kg) AS "น้ำหนักสูงสุด_กก",
    MIN(height_cm) AS "ส่วนสูงต่ำสุด_ซม",
    MAX(height_cm) AS "ส่วนสูงสูงสุด_ซม"
FROM patient_system.patients;
-- ผลที่คาดหวัง: ค่าสถิติต่ำสุดและสูงสุดของน้ำหนัก (2.00 - 123.20) และส่วนสูง (122.90 - 211.00)
-- คำอธิบาย: ใช้ MIN และ MAX หาช่วงขอบเขตสถิติกายภาพของผู้ป่วยเพื่อใช้วางแผนจัดเตรียมอุปกรณ์และขนาดยา


-- ข้อ 3.3 COUNT
-- คำถามที่ต้องการหาคำตอบ: นับจำนวนผู้ป่วยที่มีสถานะเป็นปกติพร้อมรับการรักษา (Active) ในระบบ
SELECT COUNT(*) AS "จำนวนผู้ป่วยสถานะ_Active"
FROM patient_system.patients
WHERE patient_status = 'Active';
-- ผลที่คาดหวัง: จำนวนผู้ป่วยสถานะ Active (44,893 ราย)
-- คำอธิบาย: ใช้ COUNT(*) ร่วมกับเงื่อนไข WHERE เพื่อนับจำนวนผู้รับบริการปัจจุบันของโรงพยาบาล


-- ข้อ 3.4 SUM
-- คำถามที่ต้องการหาคำตอบ: ยอดรวมงบประมาณค่าตอบแทน/เงินเดือนแพทย์ทั้งหมดในโรงพยาบาลเป็นเท่าใด?
SELECT SUM(salary_thb) AS "ยอดรวมเงินเดือนแพทย์ทั้งหมด_บาท"
FROM patient_system.doctors;
-- ผลที่คาดหวัง: ผลรวมเงินเดือนแพทย์ทั้งหมด (78,159,739.12 บาท)
-- คำอธิบาย: ใช้ฟังก์ชัน SUM หาผลรวมงบประมาณเงินเดือนของบุคลากรแพทย์ทั้งหมด


-- ข้อ 3.5 AVG
-- คำถามที่ต้องการหาคำตอบ: ค่าน้ำหนักและส่วนสูงเฉลี่ยของผู้ป่วยในโรงพยาบาลมีค่าเท่าใด?
SELECT 
    ROUND(AVG(weight_kg), 2) AS "น้ำหนักเฉลี่ย_กก",
    ROUND(AVG(height_cm), 2) AS "ส่วนสูงเฉลี่ย_ซม"
FROM patient_system.patients;
-- ผลที่คาดหวัง: น้ำหนักเฉลี่ย 62.03 กก. และส่วนสูงเฉลี่ย 164.07 ซม.
-- คำอธิบาย: ค่าเฉลี่ยบ่งบอกถึงขนาดทางกายภาพมาตรฐานของกลุ่มประชากรผู้ป่วยที่มารับบริการ


-- ข้อ 3.6 CASE
-- คำถามที่ต้องการหาคำตอบ: คำนวณค่าดัชนีมวลกาย (BMI) และจัดกลุ่มภาวะโภชนาการออกเป็น 4 ระดับตามเกณฑ์สุขภาพ
SELECT 
    patient_id,
    first_name,
    last_name,
    weight_kg,
    height_cm,
    ROUND(weight_kg / ((height_cm / 100.0) * (height_cm / 100.0)), 2) AS bmi,
    CASE 
        WHEN (weight_kg / ((height_cm / 100.0) * (height_cm / 100.0))) < 18.5 THEN 'น้ำหนักต่ำกว่าเกณฑ์'
        WHEN (weight_kg / ((height_cm / 100.0) * (height_cm / 100.0))) BETWEEN 18.5 AND 24.9 THEN 'น้ำหนักปกติ สมส่วน'
        WHEN (weight_kg / ((height_cm / 100.0) * (height_cm / 100.0))) BETWEEN 25.0 AND 29.9 THEN 'น้ำหนักเกินเกณฑ์'
        ELSE 'โรคอ้วน'
    END AS "ระดับภาวะโภชนาการ"
FROM patient_system.patients
WHERE weight_kg IS NOT NULL AND height_cm IS NOT NULL
LIMIT 10;
-- ผลที่คาดหวัง: รายการผู้ป่วยพร้อมค่า BMI และระดับภาวะโภชนาการ 4 ระดับ
-- คำอธิบาย: ใช้ CASE แปลงค่า BMI เป็นระดับการประเมินทางคลินิกที่มีความหมายต่อการวินิจฉัยของแพทย์


-- ==============================================================================
-- ส่วนที่ 4: GROUP BY และ HAVING
-- ==============================================================================

-- ข้อ 4.1 GROUP BY
-- คำถามที่ต้องการหาคำตอบ: สรุปจำนวนผู้ป่วยแยกตามรายจังหวัดที่ผู้ป่วยลงทะเบียนอาศัยอยู่
SELECT 
    p.province_name AS "จังหวัด",
    COUNT(pt.patient_id) AS "จำนวนผู้ป่วย"
FROM patient_system.patients pt
JOIN patient_system.provinces p ON pt.province_id = p.province_id
GROUP BY p.province_name
ORDER BY "จำนวนผู้ป่วย" DESC;
-- ผลที่คาดหวัง: รายชื่อจังหวัด 12 จังหวัดพร้อมจำนวนผู้ป่วยในแต่ละจังหวัด
-- คำอธิบาย: ใช้ GROUP BY จัดกลุ่มข้อมูลตามจังหวัดเพื่อนับจำนวนผู้ป่วยในแต่ละพื้นที่


-- ข้อ 4.2 HAVING
-- คำถามที่ต้องการหาคำตอบ: แสดงเฉพาะจังหวัดที่มีจำนวนผู้ป่วยอาศัยอยู่มากกว่า 4,000 คน
SELECT 
    p.province_name AS "จังหวัด",
    COUNT(pt.patient_id) AS "จำนวนผู้ป่วย"
FROM patient_system.patients pt
JOIN patient_system.provinces p ON pt.province_id = p.province_id
GROUP BY p.province_name
HAVING COUNT(pt.patient_id) > 4000
ORDER BY "จำนวนผู้ป่วย" DESC;
-- ผลที่คาดหวัง: รายชื่อจังหวัดที่มีผู้ป่วยมากกว่า 4,000 คน
-- คำอธิบาย: ใช้ HAVING กรองผลลัพธ์หลังการรวมกลุ่ม (Group-level) ต่างจาก WHERE ที่กรองระดับแถวก่อนรวมกลุ่ม


-- ==============================================================================
-- ส่วนที่ 5: ความสัมพันธ์และ JOIN
-- ==============================================================================

-- ข้อ 5.1 INNER JOIN
-- คำถามที่ต้องการหาคำตอบ: แสดงรายชื่อผู้ป่วยพร้อมข้อมูลช่องทางการติดต่อ (เบอร์โทรและอีเมล) ที่จับคู่กันได้
SELECT 
    pt.patient_id,
    pt.first_name,
    pt.last_name,
    pc.contact_type,
    pc.contact_value
FROM patient_system.patients pt
INNER JOIN patient_system.patient_contacts pc ON pt.patient_id = pc.patient_id
LIMIT 10;
-- ผลที่คาดหวัง: ข้อมูลผู้ป่วยพร้อมเบอร์โทรและอีเมลที่ตรงกันในทั้งสองตาราง
-- คำอธิบาย: เชื่อมโยง Foreign Key (patient_id) ระหว่างตาราง patients และ patient_contacts


-- ข้อ 5.2 LEFT JOIN
-- คำถามที่ต้องการหาคำตอบ: แสดงรายชื่อผู้ป่วยทุกคน พร้อมบัญชีผู้ใช้งานระบบ (หากยังไม่มีบัญชีจะแสดงเป็น NULL)
SELECT 
    pt.patient_id,
    pt.first_name,
    pt.last_name,
    u.user_id,
    u.username,
    u.account_status
FROM patient_system.patients pt
LEFT JOIN patient_system.users_security u ON pt.patient_id = u.patient_id
LIMIT 10;
-- ผลที่คาดหวัง: ข้อมูลผู้ป่วยครบทุกแถว แม้บางรายจะยังไม่มีบัญชีผู้ใช้งาน
-- คำอธิบาย: LEFT JOIN ดึงข้อมูลทุกแถวจากตารางหลัก (patients) แม้จะไม่มี Record สัมพันธ์ในตารางรอง


-- ข้อ 5.3 ตรวจสอบข้อมูลที่ไม่มีความสัมพันธ์ (NOT EXISTS)
-- คำถามที่ต้องการหาคำตอบ: ค้นหารายชื่อผู้ป่วยที่ยังไม่มีบัญชีผู้ใช้งานระบบความปลอดภัย
SELECT pt.patient_id, pt.first_name, pt.last_name
FROM patient_system.patients pt
WHERE NOT EXISTS (
    SELECT 1 
    FROM patient_system.users_security u 
    WHERE u.patient_id = pt.patient_id
)
LIMIT 10;
-- ผลที่คาดหวัง: รายชื่อผู้ป่วยที่ไม่มีข้อมูลในตาราง users_security
-- คำอธิบาย: ใช้ WHERE NOT EXISTS กรองหา Parent record ที่ไม่มี Child record เชื่อมโยง


-- ==============================================================================
-- ส่วนที่ 6: ตรวจสอบและทำความสะอาดข้อมูล
-- ==============================================================================

-- ข้อ 6.1 ตรวจสอบค่าที่หายไป (IS NULL)
-- คำถามที่ต้องการหาคำตอบ: ตรวจสอบรายชื่อผู้ป่วยที่ยังไม่มีการระบุคำนำหน้าชื่อ (title_prefix เป็น NULL)
SELECT patient_id, first_name, last_name, title_prefix
FROM patient_system.patients
WHERE title_prefix IS NULL
LIMIT 10;
-- ผลที่คาดหวัง: รายการผู้ป่วยที่ title_prefix มีค่าเป็น NULL
-- คำอธิบาย: ใช้ WHERE column IS NULL เพื่อตรวจสอบความไม่สมบูรณ์ของข้อมูล


-- ข้อ 6.2 ตรวจสอบข้อมูลซ้ำ (Duplicate Detection)
-- คำถามที่ต้องการหาคำตอบ: ตรวจสอบว่าในตารางบัญชีผู้ใช้งาน มีชื่อผู้ใช้ (username) ซ้ำกันหรือไม่
SELECT 
    username,
    COUNT(*) AS duplicate_count
FROM patient_system.users_security
GROUP BY username
HAVING COUNT(*) > 1;
-- ผลที่คาดหวัง: 0 แถว (ไม่พบข้อมูลซ้ำซ้อน)
-- คำอธิบาย: จัดกลุ่มตาม username และใช้ HAVING COUNT(*) > 1 เพื่อตรวจหาค่าที่ซ้ำ


-- ข้อ 6.3 เสนอแนวทางแก้ไขและทดสอบด้วย Transaction
-- คำถามที่ต้องการหาคำตอบ: ทดสอบการแก้ไขข้อมูลผู้ป่วยที่มี title_prefix เป็น NULL อย่างปลอดภัย
BEGIN;

-- 1. ทดสอบอัปเดตข้อมูลผู้ป่วยที่ไม่มีคำนำหน้าชื่อ ให้มีค่าเริ่มต้นเป็น 'คุณ'
UPDATE patient_system.patients
SET title_prefix = 'คุณ'
WHERE title_prefix IS NULL;

-- 2. ยกเลิกการเปลี่ยนแปลงทั้งหมดเพื่อความปลอดภัยของข้อมูล
ROLLBACK;
-- ผลที่คาดหวัง: UPDATE แถวสำเร็จ และทำการ ROLLBACK คืนค่าเดิมทันที
-- คำอธิบาย: การใช้ BEGIN ... ROLLBACK ช่วยให้ทดสอบคำสั่งแก้ไขข้อมูลได้โดยไม่กระทบต่อฐานข้อมูลจริง
