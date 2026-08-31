-- ==============================================================================
-- 02_queries_and_tests.sql
-- คำสั่ง Query และ Test Cases สำหรับโมดูล H4: เภสัชกรรม
-- ==============================================================================

SET search_path TO pharmacy_system, patient_system, staff_system, public;

-- [Query 1]: รายงานการจ่ายยาและคำนวณมูลค่ายารวมต่อใบสั่งยา
SELECT 
    rx.prescription_id AS "รหัสใบสั่งยา",
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อผู้ป่วย",
    COUNT(items.item_id) AS "จำนวนรายการยา",
    SUM(items.quantity * med.unit_price_thb) AS "ราคารวมค่ายา (บาท)",
    rx.dispense_status AS "สถานะการจ่ายยา"
FROM pharmacy_system.prescriptions rx
JOIN patient_system.patients p ON rx.patient_id = p.patient_id
JOIN pharmacy_system.prescription_items items ON rx.prescription_id = items.prescription_id
JOIN pharmacy_system.medications med ON items.medication_id = med.medication_id
GROUP BY rx.prescription_id, p.patient_id, p.title_prefix, p.first_name, p.last_name, rx.dispense_status;

-- [Query 2]: ตรวจสอบรายการยาที่คงเหลือในคลังน้อยกว่าเกณฑ์ปลอดภัย (Safety Stock Alert)
SELECT 
    medication_id AS "รหัสยา",
    medication_name AS "ชื่อยา",
    standard_dosage AS "ขนาดมาตรฐาน",
    stock_quantity AS "จำนวนคงเหลือในคลัง",
    unit_price_thb AS "ราคาต่อหน่วย (บาท)"
FROM pharmacy_system.medications
WHERE stock_quantity < 500
ORDER BY stock_quantity ASC;

-- [Test Case 1]: ตรวจสอบการห้ามจ่ายยาจำนวนติดลบหรือ 0
DO $$
BEGIN
    INSERT INTO pharmacy_system.prescription_items 
    (prescription_id, medication_id, quantity)
    VALUES ('RX001', 'MED01', 0);
    RAISE EXCEPTION 'TEST FAILED: Zero medication quantity accepted!';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'TEST PASSED: Zero or negative medication quantity rejected.';
END $$;

-- [Test Case 2]: ตรวจสอบการป้องกันยาซ้ำในใบสั่งยาเดิม (Unique Constraint)
DO $$
BEGIN
    INSERT INTO pharmacy_system.prescription_items 
    (prescription_id, medication_id, quantity)
    VALUES ('RX001', 'MED01', 10);
    -- Insert duplicate item
    INSERT INTO pharmacy_system.prescription_items 
    (prescription_id, medication_id, quantity)
    VALUES ('RX001', 'MED01', 20);
    RAISE EXCEPTION 'TEST FAILED: Duplicate medication item accepted in same prescription!';
EXCEPTION WHEN unique_violation THEN
    RAISE NOTICE 'TEST PASSED: Cannot add duplicate medication in same prescription.';
END $$;
