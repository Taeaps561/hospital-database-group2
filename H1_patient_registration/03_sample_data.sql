-- ==============================================================================
-- 03_sample_data_h1.sql
-- ข้อมูลตัวอย่างทดสอบสำหรับระบบย่อย H1: ทะเบียนผู้ป่วย
-- ผู้รับผิดชอบ: สมาชิก H1
-- ==============================================================================

SET search_path TO patient_system, public;

-- 1. ข้อมูลจังหวัด
INSERT INTO provinces (province_id, province_name) VALUES
(1, 'กรุงเทพมหานคร'),
(2, 'นนทบุรี'),
(3, 'เชียงใหม่'),
(4, 'ชลบุรี')
ON CONFLICT (province_id) DO NOTHING;

-- 2. ข้อมูลสาขาโรงพยาบาล
INSERT INTO hospital_branches (branch_id, branch_name, province_id) VALUES
('B001', 'โรงพยาบาลศูนย์กรุงเทพ (สำนักงานใหญ่)', 1),
('B002', 'โรงพยาบาลสาขานนทบุรี', 2),
('B003', 'โรงพยาบาลสาขาเชียงใหม่', 3)
ON CONFLICT (branch_id) DO NOTHING;

-- 3. ข้อมูลผู้ป่วย
INSERT INTO patients 
(patient_id, title_prefix, first_name, last_name, gender, birth_date, blood_group, province_id, weight_kg, height_cm, registered_branch_id, patient_status) VALUES
('P000001', 'นาย', 'สมชาย', 'ใจดี', 'M', '1985-05-12', 'O+', 1, 68.50, 172.00, 'B001', 'Active'),
('P000002', 'นางสาว', 'สุดา', 'รักสงบ', 'F', '1992-11-24', 'A-', 2, 52.00, 160.00, 'B001', 'Active'),
('P000003', 'นาย', 'สมศักดิ์', 'เจริญผล', 'M', '1970-03-15', 'B+', 3, 75.00, 168.00, 'B003', 'Active')
ON CONFLICT (patient_id) DO NOTHING;

-- 4. ช่องทางติดต่อ (3NF)
INSERT INTO patient_contacts (patient_id, contact_type, contact_value, is_primary) VALUES
('P000001', 'Phone', '0812345678', TRUE),
('P000001', 'Email', 'somchai.j@gmail.com', FALSE),
('P000002', 'Phone', '0898765432', TRUE),
('P000003', 'Phone', '0865554321', TRUE);

-- 5. สิทธิการรักษาและประกันสุขภาพ (H02)
INSERT INTO insurance_providers (provider_id, provider_name) VALUES
(1, 'สำนักงานหลักประกันสุขภาพแห่งชาติ (บัตรทอง 30 บาท)'),
(2, 'สำนักงานประกันสังคม'),
(3, 'เอไอเอ ประกันชีวิต (AIA Thailand)')
ON CONFLICT (provider_id) DO NOTHING;

INSERT INTO patient_insurance_policies 
(policy_id, patient_id, provider_id, policy_number, coverage_limit, expiry_date) VALUES
(1, 'P000001', 1, 'NHSO-681101-001', 50000.00, '2027-12-31'),
(2, 'P000001', 3, 'AIA-PLATINUM-9988', 500000.00, '2026-12-31'),
(3, 'P000002', 2, 'SSO-BANGKOK-1234', 100000.00, '2028-06-30')
ON CONFLICT (policy_id) DO NOTHING;
