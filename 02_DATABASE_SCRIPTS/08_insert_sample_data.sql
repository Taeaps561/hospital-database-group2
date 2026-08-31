-- ==============================================================================
-- 08_insert_sample_data.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: ใส่ข้อมูลตัวอย่าง (Sample Test Data) ที่เชื่อมโยงครบทุกโมดูล H1 - H7
--         เพื่อให้สามารถทดสอบและไหลผ่าน 3 กระบวนการกลาง (OPD, IPD, Audit) ได้สมบูรณ์
-- ==============================================================================

\connect hospital_enterprise_db

-- 1. ข้อมูลจังหวัดและสาขาโรงพยาบาล (H1 Master)
INSERT INTO patient_system.provinces (province_id, province_name) VALUES
(1, 'กรุงเทพมหานคร'),
(2, 'นนทบุรี'),
(3, 'เชียงใหม่'),
(4, 'ชลบุรี')
ON CONFLICT (province_id) DO NOTHING;

INSERT INTO patient_system.hospital_branches (branch_id, branch_name, province_id) VALUES
('B001', 'โรงพยาบาลศูนย์กรุงเทพ (สำนักงานใหญ่)', 1),
('B002', 'โรงพยาบาลสาขานนทบุรี', 2),
('B003', 'โรงพยาบาลสาขาเชียงใหม่', 3)
ON CONFLICT (branch_id) DO NOTHING;

-- 2. ข้อมูลบริษัทประกันและกองทุนสิทธิการรักษา (H1)
INSERT INTO patient_system.insurance_providers (provider_id, provider_name) VALUES
(1, 'สำนักงานหลักประกันสุขภาพแห่งชาติ (บัตรทอง 30 บาท)'),
(2, 'สำนักงานประกันสังคม'),
(3, 'เอไอเอ ประกันชีวิต (AIA Thailand)'),
(4, 'เมืองไทยประกันชีวิต (Muang Thai Life)')
ON CONFLICT (provider_id) DO NOTHING;

-- 3. ข้อมูลผู้ป่วยตัวอย่าง (H1 Master Patient Index)
INSERT INTO patient_system.patients 
(patient_id, title_prefix, first_name, last_name, gender, birth_date, blood_group, province_id, weight_kg, height_cm, registered_branch_id, patient_status) VALUES
('P000001', 'นาย', 'สมชาย', 'ใจดี', 'M', '1985-05-12', 'O+', 1, 68.50, 172.00, 'B001', 'Active'),
('P000002', 'นางสาว', 'สุดา', 'รักสงบ', 'F', '1992-11-24', 'A-', 2, 52.00, 160.00, 'B001', 'Active'),
('P000003', 'นาย', 'สมศักดิ์', 'เจริญผล', 'M', '1970-03-15', 'B+', 3, 75.00, 168.00, 'B003', 'Active')
ON CONFLICT (patient_id) DO NOTHING;

-- ช่องทางติดต่อผู้ป่วย (H1 3NF Contacts)
INSERT INTO patient_system.patient_contacts (patient_id, contact_type, contact_value, is_primary) VALUES
('P000001', 'Phone', '0812345678', TRUE),
('P000001', 'Email', 'somchai.j@gmail.com', FALSE),
('P000002', 'Phone', '0898765432', TRUE),
('P000003', 'Phone', '0865554321', TRUE);

-- สิทธิการรักษาของผู้ป่วย (H1 Change Card H02: Multi-Insurance)
INSERT INTO patient_system.patient_insurance_policies 
(policy_id, patient_id, provider_id, policy_number, coverage_limit, expiry_date) VALUES
(1, 'P000001', 1, 'NHSO-681101-001', 50000.00, '2027-12-31'),
(2, 'P000001', 3, 'AIA-PLATINUM-9988', 500000.00, '2026-12-31'), -- P000001 มี 2 กรมธรรม์
(3, 'P000002', 2, 'SSO-BANGKOK-1234', 100000.00, '2028-06-30')
ON CONFLICT (policy_id) DO NOTHING;

-- 4. ข้อมูลแผนกและแพทย์ (H7 บุคลากร)
INSERT INTO staff_system.departments (department_id, branch_id, department_name) VALUES
('DEP01', 'B001', 'แผนกอายุรกรรม (Internal Medicine)'),
('DEP02', 'B001', 'แผนกศัลยกรรม (General Surgery)'),
('DEP03', 'B001', 'แผนกอายุรกรรมโรคหัวใจ (Cardiology)')
ON CONFLICT (department_id) DO NOTHING;

INSERT INTO staff_system.doctors (doctor_id, department_id, doctor_name, email, salary_thb, position) VALUES
('DOC001', 'DEP01', 'นพ. วิทยา รักษาดี', 'wittaya.r@hospital.org', 120000.00, 'อายุรแพทย์ทั่วไป'),
('DOC002', 'DEP03', 'พญ. ปรียา หทัยธรรม', 'preeya.h@hospital.org', 150000.00, 'อายุรแพทย์โรคหัวใจ')
ON CONFLICT (doctor_id) DO NOTHING;

-- 5. ข้อมูลการนัดหมายและวินิจฉัย (H2 นัดหมาย/OPD)
INSERT INTO opd_system.diagnoses (diagnosis_id, icd_code, diagnosis_name, diagnosis_category) VALUES
('D01', 'I10', 'ความดันโลหิตสูงไม่ทราบสาเหตุ (Essential Hypertension)', 'ระบบไหลเวียนโลหิต'),
('D02', 'E11', 'เบาหวานชนิดที่ 2 (Type 2 Diabetes Mellitus)', 'ต่อมไร้ท่อและเมตาบอลิซึม')
ON CONFLICT (diagnosis_id) DO NOTHING;

INSERT INTO opd_system.appointments 
(appointment_id, patient_id, doctor_id, branch_id, appointment_date, appointment_time, appointment_status, appointment_source) VALUES
('APT001', 'P000001', 'DOC001', 'B001', '2026-09-05', '09:30:00', 'Scheduled', 'Mobile App'),
('APT002', 'P000002', 'DOC002', 'B001', '2026-09-06', '10:00:00', 'Completed', 'Walk-in')
ON CONFLICT (appointment_id) DO NOTHING;

INSERT INTO opd_system.clinical_records 
(record_id, patient_id, doctor_id, diagnosis_id, record_date, systolic_bp, diastolic_bp, temperature_c, blood_glucose_mg_dl, care_setting) VALUES
('CR001', 'P000001', 'DOC001', 'D01', '2026-08-31 10:15:00', 135.0, 85.0, 36.8, 110.0, 'OPD')
ON CONFLICT (record_id) DO NOTHING;

-- 6. ข้อมูลคำสั่งแล็บและผลตรวจ (H5 ห้องแล็บ)
INSERT INTO lab_system.lab_orders (order_id, patient_id, doctor_id, order_date, order_status) VALUES
('LAB001', 'P000001', 'DOC001', '2026-08-31 10:30:00', 'Completed')
ON CONFLICT (order_id) DO NOTHING;

INSERT INTO lab_system.lab_results (order_id, test_name, test_result_value, normal_reference_range) VALUES
('LAB001', 'FBS (Fasting Blood Sugar)', '110 mg/dL', '70 - 99 mg/dL'),
('LAB001', 'Lipid Profile (Cholesterol)', '195 mg/dL', '< 200 mg/dL');

-- 7. ข้อมูลยาและใบสั่งยา (H4 เภสัชกรรม)
INSERT INTO pharmacy_system.medications (medication_id, medication_name, standard_dosage, unit_price_thb) VALUES
('MED01', 'Amlodipine 5mg', 'รับประทานวันละ 1 เม็ด หลังอาหารเช้า', 12.50),
('MED02', 'Metformin 500mg', 'รับประทานวันละ 1 เม็ด พร้อมอาหารเย็น', 8.00)
ON CONFLICT (medication_id) DO NOTHING;

INSERT INTO pharmacy_system.prescriptions (prescription_id, patient_id, doctor_id, prescription_date, dispense_status) VALUES
('RX001', 'P000001', 'DOC001', '2026-08-31 10:45:00', 'Dispensed')
ON CONFLICT (prescription_id) DO NOTHING;

INSERT INTO pharmacy_system.prescription_items (prescription_id, medication_id, quantity, instructions) VALUES
('RX001', 'MED01', 30, 'ทานต่อเนื่อง 1 เดือนเพื่อคุมความดัน');

-- 8. ข้อมูลวอร์ด เตียง และการรับผู้ป่วยใน (H6 วอร์ด/IPD)
INSERT INTO ipd_system.wards (ward_id, department_id, ward_name, ward_type, bed_capacity) VALUES
('W01', 'DEP01', 'หอผู้ป่วยอายุรกรรมชาย 1', 'General', 20)
ON CONFLICT (ward_id) DO NOTHING;

INSERT INTO ipd_system.beds (bed_id, ward_id, room_number, bed_type, bed_status) VALUES
('BED01', 'W01', 'Room 301', 'Electric Bed', 'Occupied'),
('BED02', 'W01', 'Room 302', 'Electric Bed', 'Available')
ON CONFLICT (bed_id) DO NOTHING;

INSERT INTO ipd_system.admissions 
(admission_id, patient_id, attending_doctor_id, bed_id, admission_date, discharge_date, admission_type, discharge_status, length_of_stay_days) VALUES
('ADM001', 'P000002', 'DOC002', 'BED01', '2026-08-25 14:00:00', '2026-08-28 11:00:00', 'Elective', 'Recovered', 3)
ON CONFLICT (admission_id) DO NOTHING;

-- 9. ข้อมูลใบแจ้งหนี้และการชำระเงิน (H3 การเงิน - Change Card H02 Split Billing)
INSERT INTO billing_system.invoices 
(invoice_id, patient_id, policy_id, service_type, service_reference, total_amount_thb, insurance_paid_thb, patient_paid_thb, payment_method, payment_status, invoice_date) VALUES
('INV001', 'P000001', 2, 'OPD Visit & Medications', 'RX001', 1250.00, 1000.00, 250.00, 'Credit Card & AIA Claim', 'Paid', '2026-08-31 11:15:00'),
('INV002', 'P000002', 3, 'IPD Admission', 'ADM001', 18500.00, 15000.00, 3500.00, 'Cash & SSO', 'Paid', '2026-08-28 11:30:00')
ON CONFLICT (invoice_id) DO NOTHING;
