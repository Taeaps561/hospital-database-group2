-- ==============================================================================
-- 06_create_roles.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: สร้าง Database Roles ตามบทบาทหน้าที่ของบุคลากรในโรงพยาบาล (RBAC)
-- ==============================================================================

\connect hospital_enterprise_db

-- ยกเลิก Roles เดิมหากมีอยู่แล้ว (Clean setup)
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'hospital_admin_role') THEN
        DROP ROLE hospital_admin_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'registration_staff_role') THEN
        DROP ROLE registration_staff_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'doctor_role') THEN
        DROP ROLE doctor_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'nurse_ward_role') THEN
        DROP ROLE nurse_ward_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'pharmacist_role') THEN
        DROP ROLE pharmacist_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'lab_technician_role') THEN
        DROP ROLE lab_technician_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'billing_officer_role') THEN
        DROP ROLE billing_officer_role;
    END IF;
    IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'auditor_readonly_role') THEN
        DROP ROLE auditor_readonly_role;
    END IF;
END $$;

-- 1. บทบาทผู้ดูแลระบบฐานข้อมูลโรงพยาบาล (Hospital System Administrator)
CREATE ROLE hospital_admin_role WITH NOLOGIN;

-- 2. บทบาทเจ้าหน้าที่เวชระเบียนและลงทะเบียน (H1 Registration Staff)
CREATE ROLE registration_staff_role WITH NOLOGIN;

-- 3. บทบาทแพทย์ผู้ตรวจรักษา (H7 / H2 / H6 Clinical Doctor)
CREATE ROLE doctor_role WITH NOLOGIN;

-- 4. บทบาทพยาบาลประจำหอผู้ป่วยใน (H6 Inpatient Ward Nurse)
CREATE ROLE nurse_ward_role WITH NOLOGIN;

-- 5. บทบาทเภสัชกร (H4 Pharmacist)
CREATE ROLE pharmacist_role WITH NOLOGIN;

-- 6. บทบาทนักเทคนิคการแพทย์ห้องแล็บ (H5 Medical Technologist)
CREATE ROLE lab_technician_role WITH NOLOGIN;

-- 7. บทบาทเจ้าหน้าที่การเงินและเรียกเก็บ (H3 Billing Officer)
CREATE ROLE billing_officer_role WITH NOLOGIN;

-- 8. บทบาทผู้ตรวจการและควบคุมคุณภาพเวชระเบียน (Quality & Compliance Auditor)
CREATE ROLE auditor_readonly_role WITH NOLOGIN;
