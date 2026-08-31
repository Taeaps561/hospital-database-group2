-- ==============================================================================
-- 07_grant_permissions.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: กำหนดสิทธิ์การเข้าถึงตารางและสคีมาตามหลัก Principle of Least Privilege
-- ==============================================================================

\connect hospital_enterprise_db

-- 1. สิทธิ์สำหรับผู้ดูแลระบบ (Admin)
GRANT ALL PRIVILEGES ON SCHEMA patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system TO hospital_admin_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system TO hospital_admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system TO hospital_admin_role;

-- 2. สิทธิ์สำหรับเจ้าหน้าที่ทะเบียนเวชระเบียน (H1 Registration Staff)
GRANT USAGE ON SCHEMA patient_system TO registration_staff_role;
GRANT SELECT, INSERT, UPDATE ON patient_system.patients TO registration_staff_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON patient_system.patient_contacts TO registration_staff_role;
GRANT SELECT, INSERT, UPDATE ON patient_system.patient_insurance_policies TO registration_staff_role;
GRANT SELECT ON patient_system.provinces, patient_system.hospital_branches, patient_system.insurance_providers TO registration_staff_role;

-- 3. สิทธิ์สำหรับแพทย์ (Doctor Role)
GRANT USAGE ON SCHEMA patient_system, opd_system, ipd_system, pharmacy_system, lab_system, staff_system TO doctor_role;
-- ดูข้อมูลพื้นฐานคนไข้ได้
GRANT SELECT ON patient_system.patients, patient_system.patient_insurance_policies TO doctor_role;
-- เขียนใบนัด บันทึกตรวจ สั่งยา สั่งแล็บ
GRANT SELECT, INSERT, UPDATE ON opd_system.appointments, opd_system.clinical_records TO doctor_role;
GRANT SELECT, INSERT ON pharmacy_system.prescriptions, pharmacy_system.prescription_items TO doctor_role;
GRANT SELECT, INSERT ON lab_system.lab_orders TO doctor_role;
GRANT SELECT ON lab_system.lab_results, pharmacy_system.medications TO doctor_role;
GRANT SELECT, UPDATE ON ipd_system.admissions TO doctor_role;

-- 4. สิทธิ์สำหรับเภสัชกร (Pharmacist Role)
GRANT USAGE ON SCHEMA pharmacy_system, patient_system TO pharmacist_role;
GRANT SELECT ON patient_system.patients TO pharmacist_role;
GRANT SELECT, UPDATE ON pharmacy_system.prescriptions TO pharmacist_role;
GRANT SELECT ON pharmacy_system.prescription_items, pharmacy_system.medications TO pharmacist_role;

-- 5. สิทธิ์สำหรับนักเทคนิคห้องแล็บ (Lab Technician Role)
GRANT USAGE ON SCHEMA lab_system, patient_system TO lab_technician_role;
GRANT SELECT ON patient_system.patients TO lab_technician_role;
GRANT SELECT, UPDATE ON lab_system.lab_orders TO lab_technician_role;
GRANT SELECT, INSERT, UPDATE ON lab_system.lab_results TO lab_technician_role;

-- 6. สิทธิ์สำหรับพยาบาลประจำวอร์ด (Nurse Ward Role)
GRANT USAGE ON SCHEMA ipd_system, patient_system TO nurse_ward_role;
GRANT SELECT ON patient_system.patients, patient_system.patient_contacts TO nurse_ward_role;
GRANT SELECT, UPDATE ON ipd_system.beds, ipd_system.admissions TO nurse_ward_role;
GRANT SELECT, INSERT ON ipd_system.bed_transfers TO nurse_ward_role;

-- 7. สิทธิ์สำหรับเจ้าหน้าที่การเงิน (Billing Officer Role)
GRANT USAGE ON SCHEMA billing_system, patient_system TO billing_officer_role;
GRANT SELECT ON patient_system.patients, patient_system.patient_insurance_policies TO billing_officer_role;
GRANT SELECT, INSERT, UPDATE ON billing_system.invoices TO billing_officer_role;

-- 8. สิทธิ์สำหรับผู้ตรวจสอบ (Auditor Readonly Role)
GRANT USAGE ON SCHEMA patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system TO auditor_readonly_role;
GRANT SELECT ON ALL TABLES IN SCHEMA patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system TO auditor_readonly_role;
