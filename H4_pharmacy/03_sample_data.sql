-- ==============================================================================
-- 03_sample_data.sql
-- ข้อมูลตัวอย่างทดสอบสำหรับโมดูล H4: เภสัชกรรม
-- ==============================================================================

SET search_path TO pharmacy_system, patient_system, staff_system, public;

-- รายการยา
INSERT INTO pharmacy_system.medications (medication_id, medication_name, standard_dosage, unit_price_thb, stock_quantity) VALUES
('MED01', 'Amlodipine 5mg', 'รับประทานวันละ 1 เม็ด หลังอาหารเช้า', 12.50, 1500),
('MED02', 'Metformin 500mg', 'รับประทานวันละ 1 เม็ด พร้อมอาหารเย็น', 8.00, 2000),
('MED03', 'Paracetamol 500mg', 'รับประทานครั้งละ 1-2 เม็ด ทุก 4-6 ชั่วโมง เมื่อมีอาการปวดหรือเป็นไข้', 2.00, 5000),
('MED04', 'Amoxicillin 500mg', 'รับประทานครั้งละ 1 แคปซูล วันละ 3 ครั้ง ก่อนอาหาร', 15.00, 450) -- สต็อกน้อยกว่า 500
ON CONFLICT (medication_id) DO NOTHING;

-- ใบสั่งยา
INSERT INTO pharmacy_system.prescriptions (prescription_id, patient_id, doctor_id, prescription_date, dispense_status) VALUES
('RX001', 'P000001', 'DOC001', '2026-08-31 10:45:00', 'Dispensed'),
('RX002', 'P000002', 'DOC002', '2026-08-31 11:30:00', 'Dispensed')
ON CONFLICT (prescription_id) DO NOTHING;

-- รายการยาในใบสั่งยา
INSERT INTO pharmacy_system.prescription_items (prescription_id, medication_id, quantity, instructions) VALUES
('RX001', 'MED01', 30, 'ทานต่อเนื่อง 1 เดือนเพื่อควบคุมความดัน'),
('RX001', 'MED03', 20, 'ทานเมื่อมีอาการปวดศีรษะ'),
('RX002', 'MED02', 60, 'ทานต่อเนื่อง 2 เดือน ควบคุมระดับน้ำตาล')
ON CONFLICT DO NOTHING;
