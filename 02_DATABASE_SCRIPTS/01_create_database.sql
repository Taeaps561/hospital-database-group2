-- ==============================================================================
-- 01_create_database.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: นายอภิสิทธิ์ ศรีพัฒน์ (รหัสนักศึกษา 6811011662010) - โมดูล H1 ทะเบียนผู้ป่วย
-- หน้าที่: สร้างฐานข้อมูลกลางระดับองค์กรสำหรับรองรับระบบย่อย H1 - H7
-- ==============================================================================

-- ตรวจสอบและยกเลิกการเชื่อมต่อเดิมหากต้องการสร้างใหม่ (Development Only)
-- SELECT pg_terminate_backend(pg_stat_activity.pid)
-- FROM pg_stat_activity
-- WHERE pg_stat_activity.datname = 'hospital_enterprise_db'
--   AND pid <> pg_backend_pid();

-- คำสั่งสร้างฐานข้อมูลกลางของโรงพยาบาล
CREATE DATABASE hospital_enterprise_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE hospital_enterprise_db IS 'Enterprise Hospital Information System Database (HIS Group 2 - Consolidation H1 to H7)';
