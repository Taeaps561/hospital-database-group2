-- ==============================================================================
-- 06_create_roles.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: สร้าง Database Roles ตามบทบาทหน้าที่ของบุคลากรในโรงพยาบาล (RBAC)
-- ==============================================================================

\connect hospital_enterprise_db

-- สร้าง Database Roles หากยังไม่มี (Safe Idempotent Creation)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'hospital_admin_role') THEN
        CREATE ROLE hospital_admin_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'registration_staff_role') THEN
        CREATE ROLE registration_staff_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'doctor_role') THEN
        CREATE ROLE doctor_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'nurse_ward_role') THEN
        CREATE ROLE nurse_ward_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'pharmacist_role') THEN
        CREATE ROLE pharmacist_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'lab_technician_role') THEN
        CREATE ROLE lab_technician_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'billing_officer_role') THEN
        CREATE ROLE billing_officer_role WITH NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'auditor_readonly_role') THEN
        CREATE ROLE auditor_readonly_role WITH NOLOGIN;
    END IF;
END $$;
