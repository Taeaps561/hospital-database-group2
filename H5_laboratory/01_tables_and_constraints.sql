-- ==============================================================================
-- H5: ระบบห้องปฏิบัติการทางการแพทย์ (Laboratory System)
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Enterprise HIS v2) - กลุ่มที่ 2
-- ผู้รับผิดชอบ: โมดูล H5 (Laboratory System)
-- ==============================================================================

CREATE SCHEMA IF NOT EXISTS lab_system;
SET search_path TO lab_system, patient_system, staff_system, public;

-- 1. ตารางคำสั่งตรวจทางห้องปฏิบัติการ (Lab Orders)
CREATE TABLE IF NOT EXISTS lab_system.lab_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patient_system.patients(patient_id) ON DELETE CASCADE,
    doctor_id VARCHAR(50) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (order_status IN ('Pending', 'In-Progress', 'Completed', 'Cancelled'))
);

-- 2. ตารางผลการตรวจทางห้องปฏิบัติการ (Lab Results)
CREATE TABLE IF NOT EXISTS lab_system.lab_results (
    result_id SERIAL PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL REFERENCES lab_system.lab_orders(order_id) ON DELETE CASCADE,
    test_name VARCHAR(100) NOT NULL,
    test_result_value VARCHAR(100) NOT NULL,
    normal_reference_range VARCHAR(100),
    is_abnormal BOOLEAN DEFAULT FALSE,
    result_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- สร้าง Indexes
CREATE INDEX IF NOT EXISTS idx_lab_patient ON lab_system.lab_orders(patient_id);
CREATE INDEX IF NOT EXISTS idx_lab_results_order ON lab_system.lab_results(order_id);
