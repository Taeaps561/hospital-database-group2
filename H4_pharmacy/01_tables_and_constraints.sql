-- ==============================================================================
-- H4: ระบบเภสัชกรรมและคลังยา (Pharmacy & Medications System)
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Enterprise HIS v2) - กลุ่มที่ 2
-- ผู้รับผิดชอบ: โมดูล H4 (Pharmacy & Medications)
-- ==============================================================================

CREATE SCHEMA IF NOT EXISTS pharmacy_system;
SET search_path TO pharmacy_system, patient_system, staff_system, public;

-- 1. ตารางรายการยาและเวชภัณฑ์ (Medication Master)
CREATE TABLE IF NOT EXISTS pharmacy_system.medications (
    medication_id VARCHAR(50) PRIMARY KEY,
    medication_name VARCHAR(150) NOT NULL,
    standard_dosage VARCHAR(100),
    unit_price_thb NUMERIC(12, 2) NOT NULL CHECK (unit_price_thb >= 0.0),
    stock_quantity INT NOT NULL DEFAULT 1000 CHECK (stock_quantity >= 0)
);

-- 2. ตารางใบสั่งยา (Prescriptions)
CREATE TABLE IF NOT EXISTS pharmacy_system.prescriptions (
    prescription_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL REFERENCES patient_system.patients(patient_id) ON DELETE CASCADE,
    doctor_id VARCHAR(50) NOT NULL,
    prescription_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dispense_status VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (dispense_status IN ('Pending', 'Dispensed', 'Cancelled'))
);

-- 3. ตารางความสัมพันธ์รายการยาในใบสั่งยา (Associative Entity M:N)
CREATE TABLE IF NOT EXISTS pharmacy_system.prescription_items (
    item_id SERIAL PRIMARY KEY,
    prescription_id VARCHAR(50) NOT NULL REFERENCES pharmacy_system.prescriptions(prescription_id) ON DELETE CASCADE,
    medication_id VARCHAR(50) NOT NULL REFERENCES pharmacy_system.medications(medication_id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    instructions TEXT,
    CONSTRAINT uniq_prescription_med UNIQUE (prescription_id, medication_id)
);

-- สร้าง Indexes
CREATE INDEX IF NOT EXISTS idx_rx_patient ON pharmacy_system.prescriptions(patient_id);
CREATE INDEX IF NOT EXISTS idx_rx_items_rx ON pharmacy_system.prescription_items(prescription_id);
