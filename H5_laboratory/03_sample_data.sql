-- ==============================================================================
-- 03_sample_data.sql
-- ข้อมูลตัวอย่างทดสอบสำหรับโมดูล H5: ห้องปฏิบัติการ (Laboratory System)
-- ==============================================================================

SET search_path TO lab_system, patient_system, staff_system, public;

-- ข้อมูลคำสั่งตรวจทางห้องปฏิบัติการ (Lab Orders)
INSERT INTO lab_system.lab_orders (order_id, patient_id, doctor_id, order_date, order_status) VALUES
('LAB001', 'P000001', 'DOC001', '2026-08-31 10:30:00', 'Completed'),
('LAB002', 'P000002', 'DOC002', '2026-08-31 11:15:00', 'Completed'),
('LAB003', 'P000003', 'DOC001', '2026-08-31 14:00:00', 'Pending')
ON CONFLICT (order_id) DO NOTHING;

-- ข้อมูลผลการตรวจแล็บ (Lab Results)
INSERT INTO lab_system.lab_results (order_id, test_name, test_result_value, normal_reference_range, is_abnormal, result_timestamp) VALUES
('LAB001', 'FBS (Fasting Blood Sugar)', '115 mg/dL', '70 - 99 mg/dL', TRUE, '2026-08-31 11:00:00'),
('LAB001', 'Lipid Profile (Cholesterol)', '195 mg/dL', '< 200 mg/dL', FALSE, '2026-08-31 11:00:00'),
('LAB001', 'HbA1c', '6.8 %', '< 5.7 %', TRUE, '2026-08-31 11:05:00'),
('LAB002', 'CBC (Complete Blood Count)', 'WBC 6,500 /uL', '4,500 - 10,000 /uL', FALSE, '2026-08-31 11:45:00'),
('LAB002', 'Serum Creatinine', '0.9 mg/dL', '0.6 - 1.2 mg/dL', FALSE, '2026-08-31 11:45:00')
ON CONFLICT DO NOTHING;
