-- ==============================================================================
-- 02_queries_and_tests.sql
-- คำสั่ง Query และ Test Cases สำหรับโมดูล H5: ห้องแล็บ
-- ==============================================================================

SET search_path TO lab_system, patient_system, staff_system, public;

-- [Query 1]: รายงานคำสั่งตรวจและผลแล็บทั้งหมดที่ผลการตรวจผิดปกติ (Abnormal Lab Alerts)
SELECT 
    lo.order_id AS "รหัสคำสั่งแล็บ",
    p.patient_id AS "รหัสผู้ป่วย",
    p.title_prefix || p.first_name || ' ' || p.last_name AS "ชื่อผู้ป่วย",
    lr.test_name AS "รายการตรวจ",
    lr.test_result_value AS "ค่าผลตรวจ",
    lr.normal_reference_range AS "ค่าอ้างอิงปกติ",
    lr.result_timestamp AS "เวลาที่รายงานผล"
FROM lab_system.lab_results lr
JOIN lab_system.lab_orders lo ON lr.order_id = lo.order_id
JOIN patient_system.patients p ON lo.patient_id = p.patient_id
WHERE lr.is_abnormal = TRUE;

-- [Query 2]: สรุปสถานะคำสั่งตรวจแล็บรายวัน
SELECT 
    DATE(order_date) AS "วันที่",
    order_status AS "สถานะ",
    COUNT(order_id) AS "จำนวนคำสั่งตรวจ (รายการ)"
FROM lab_system.lab_orders
GROUP BY DATE(order_date), order_status
ORDER BY "วันที่" DESC;

-- [Test Case 1]: ตรวจสอบการลบคำสั่งแล็บจะต้องลบผลแล็บตามไปด้วย (ON DELETE CASCADE)
DO $$
DECLARE
    v_order_count INT;
    v_result_count INT;
BEGIN
    -- สร้างคำสั่งตรวจทดสอบ
    INSERT INTO lab_system.lab_orders (order_id, patient_id, doctor_id) VALUES ('LAB_TEST_CAS', 'P000001', 'DOC001');
    INSERT INTO lab_system.lab_results (order_id, test_name, test_result_value) VALUES ('LAB_TEST_CAS', 'Test CBC', 'Normal');
    
    -- ลบ order
    DELETE FROM lab_system.lab_orders WHERE order_id = 'LAB_TEST_CAS';
    
    -- ตรวจสอบว่าผลแล็บถูกลบตามไปด้วยหรือไม่
    SELECT COUNT(*) INTO v_result_count FROM lab_system.lab_results WHERE order_id = 'LAB_TEST_CAS';
    IF v_result_count > 0 THEN
        RAISE EXCEPTION 'TEST FAILED: Lab results were not cascaded!';
    ELSE
        RAISE NOTICE 'TEST PASSED: Lab results successfully cascaded on order deletion.';
    END IF;
END $$;

-- [Test Case 2]: ตรวจสอบการปฏิเสธสถานะคำสั่งแล็บที่ไม่อยู่ในเงื่อนไข (Check Constraint)
DO $$
BEGIN
    INSERT INTO lab_system.lab_orders (order_id, patient_id, doctor_id, order_status)
    VALUES ('LAB_ERR', 'P000001', 'DOC001', 'UnknownStatus');
    RAISE EXCEPTION 'TEST FAILED: Invalid lab order status accepted!';
EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'TEST PASSED: Invalid lab order status rejected.';
END $$;
