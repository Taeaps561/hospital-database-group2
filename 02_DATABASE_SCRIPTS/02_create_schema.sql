-- ==============================================================================
-- 02_create_schema.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: สร้างและจัดโครงสร้าง Schemas สำหรับระบบย่อยทั้ง 7 ระบบ เพื่อแยกขอบเขตงานอย่างเป็นระเบียบ
-- ==============================================================================

\connect hospital_enterprise_db

-- 1. Schema โมดูล H1: ระบบทะเบียนผู้ป่วยและประชากรศาสตร์ (ผู้รับผิดชอบ: สมาชิก H1)
CREATE SCHEMA IF NOT EXISTS patient_system;
COMMENT ON SCHEMA patient_system IS 'Module H1: Patient Registration, Demographics, and Insurance Master System';

-- 2. Schema โมดูล H2: ระบบนัดหมายและงานผู้ป่วยนอก (Appointments & OPD)
CREATE SCHEMA IF NOT EXISTS opd_system;
COMMENT ON SCHEMA opd_system IS 'Module H2: Outpatient Department, Clinical Visits, and Appointment Scheduling';

-- 3. Schema โมดูล H3: ระบบการเงินและบัญชีเรียกเก็บ (Billing & Finance)
CREATE SCHEMA IF NOT EXISTS billing_system;
COMMENT ON SCHEMA billing_system IS 'Module H3: Patient Invoicing, Insurance Claims, and Payment Receipts';

-- 4. Schema โมดูล H4: ระบบเภสัชกรรมและคลังยา (Pharmacy & Medications)
CREATE SCHEMA IF NOT EXISTS pharmacy_system;
COMMENT ON SCHEMA pharmacy_system IS 'Module H4: Drug Inventory, Prescriptions, and Medication Dispensing';

-- 5. Schema โมดูล H5: ระบบห้องปฏิบัติการทางการแพทย์ (Laboratory System)
CREATE SCHEMA IF NOT EXISTS lab_system;
COMMENT ON SCHEMA lab_system IS 'Module H5: Lab Orders, Specimen Tracking, and Clinical Test Results';

-- 6. Schema โมดูล H6: ระบบผู้ป่วยในและหอผู้ป่วย (Inpatient & Wards)
CREATE SCHEMA IF NOT EXISTS ipd_system;
COMMENT ON SCHEMA ipd_system IS 'Module H6: Inpatient Admissions, Ward & Bed Management, and Transfers';

-- 7. Schema โมดูล H7: ระบบบริหารบุคลากรทางการแพทย์ (Staff & Personnel)
CREATE SCHEMA IF NOT EXISTS staff_system;
COMMENT ON SCHEMA staff_system IS 'Module H7: Doctors, Nurses, Medical Staff, and Department Hierarchy';

-- ตั้งค่า Search Path ให้มองเห็น Schema ทั้งหมดตามลำดับความสำคัญ
SET search_path TO patient_system, opd_system, billing_system, pharmacy_system, lab_system, ipd_system, staff_system, public;
