-- ============================================================================
-- ชื่อ-นามสกุล: นักศึกษา
-- รหัสนักศึกษา: 68xxxxxxx
-- ระบบย่อย: ระบบการเงิน (Billing / Payment) — ระบบโรงพยาบาล
-- Table ที่รับผิดชอบ: billing_services, invoices, invoice_items, payments,
--   insurance_claims, receipts, receipt_items, refunds, deposits,
--   discount_rules, price_history, bank_reconciliation, audit_log
-- Database Engine: PostgreSQL 12+
-- ============================================================================

SET search_path TO u68001, public;

-- ============================================================================
-- 0. CLEANUP (สำหรับรันซ้ำได้)
-- ============================================================================

DROP TABLE IF EXISTS cars CASCADE;
DROP TABLE IF EXISTS audit_log CASCADE;
DROP TABLE IF EXISTS bank_reconciliation CASCADE;
DROP TABLE IF EXISTS price_history CASCADE;
DROP TABLE IF EXISTS discount_rules CASCADE;
DROP TABLE IF EXISTS deposits CASCADE;
DROP TABLE IF EXISTS refunds CASCADE;
DROP TABLE IF EXISTS receipt_items CASCADE;
DROP TABLE IF EXISTS receipts CASCADE;
DROP TABLE IF EXISTS insurance_claims CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS invoice_items CASCADE;
DROP TABLE IF EXISTS invoices CASCADE;
DROP TABLE IF EXISTS billing_services CASCADE;

DROP TYPE IF EXISTS audit_action_enum CASCADE;
DROP TYPE IF EXISTS reconcile_status_enum CASCADE;
DROP TYPE IF EXISTS discount_type_enum CASCADE;
DROP TYPE IF EXISTS deposit_status_enum CASCADE;
DROP TYPE IF EXISTS refund_status_enum CASCADE;
DROP TYPE IF EXISTS claim_status_enum CASCADE;
DROP TYPE IF EXISTS payment_method_enum CASCADE;
DROP TYPE IF EXISTS invoice_status_enum CASCADE;

-- ============================================================================
-- 1. CUSTOM ENUM TYPES
-- ============================================================================

CREATE TYPE invoice_status_enum AS ENUM ('UNPAID', 'PARTIALLY_PAID', 'PAID', 'CANCELLED');
CREATE TYPE payment_method_enum AS ENUM ('CASH', 'CREDIT_CARD', 'PROMPTPAY', 'INSURANCE', 'BANK_TRANSFER');
CREATE TYPE claim_status_enum AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'SETTLED');
CREATE TYPE refund_status_enum AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'COMPLETED');
CREATE TYPE deposit_status_enum AS ENUM ('HELD', 'APPLIED', 'REFUNDED');
CREATE TYPE discount_type_enum AS ENUM ('PERCENTAGE', 'FIXED_AMOUNT');
CREATE TYPE reconcile_status_enum AS ENUM ('MATCHED', 'UNMATCHED', 'DISPUTED');
CREATE TYPE audit_action_enum AS ENUM ('INSERT', 'UPDATE', 'DELETE');

-- ============================================================================
-- 2. TABLE CREATION (13 Tables)
-- ============================================================================

-- Table 1: Services Catalog (รายการค่าบริการ/ค่ายา/ค่าห้อง)
CREATE TABLE billing_services (
    service_id SERIAL PRIMARY KEY,
    service_code VARCHAR(20) UNIQUE NOT NULL,
    service_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    is_active BOOLEAN DEFAULT TRUE
);

-- Table 2: Invoices (ใบแจ้งหนี้หลัก)
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,
    invoice_number VARCHAR(30) UNIQUE NOT NULL,
    patient_id INT NOT NULL,
    visit_id INT NOT NULL,
    issue_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    subtotal_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (subtotal_amount >= 0),
    discount_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (discount_amount >= 0),
    tax_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (tax_amount >= 0),
    net_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (net_amount >= 0),
    status invoice_status_enum NOT NULL DEFAULT 'UNPAID',
    remarks TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 3: Invoice Items (รายการย่อยในใบแจ้งหนี้)
CREATE TABLE invoice_items (
    item_id SERIAL PRIMARY KEY,
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id) ON DELETE CASCADE,
    service_id INT NOT NULL REFERENCES billing_services(service_id),
    item_name VARCHAR(150) NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    line_total NUMERIC(12, 2) NOT NULL CHECK (line_total >= 0)
);

-- Table 4: Payments (บันทึกการชำระเงิน)
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    payment_number VARCHAR(30) UNIQUE NOT NULL,
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
    payment_method payment_method_enum NOT NULL,
    amount_paid NUMERIC(12, 2) NOT NULL CHECK (amount_paid > 0),
    transaction_ref VARCHAR(100),
    cashier_id INT NOT NULL,
    paid_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 5: Insurance Claims (การเคลมประกัน)
CREATE TABLE insurance_claims (
    claim_id SERIAL PRIMARY KEY,
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
    provider_name VARCHAR(100) NOT NULL,
    policy_number VARCHAR(50) NOT NULL,
    claimed_amount NUMERIC(12, 2) NOT NULL CHECK (claimed_amount > 0),
    approved_amount NUMERIC(12, 2) DEFAULT 0.00 CHECK (approved_amount >= 0),
    claim_status claim_status_enum NOT NULL DEFAULT 'PENDING',
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 6: Receipts (ใบเสร็จรับเงิน)
CREATE TABLE receipts (
    receipt_id SERIAL PRIMARY KEY,
    receipt_number VARCHAR(30) UNIQUE NOT NULL,
    payment_id INT NOT NULL REFERENCES payments(payment_id),
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
    receipt_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(12, 2) NOT NULL CHECK (total_amount >= 0),
    issued_by INT NOT NULL
);

-- Table 7: Receipt Items (รายการย่อยใบเสร็จ)
CREATE TABLE receipt_items (
    receipt_item_id SERIAL PRIMARY KEY,
    receipt_id INT NOT NULL REFERENCES receipts(receipt_id) ON DELETE CASCADE,
    item_description VARCHAR(200) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount >= 0)
);

-- Table 8: Refunds (การคืนเงิน)
CREATE TABLE refunds (
    refund_id SERIAL PRIMARY KEY,
    refund_number VARCHAR(30) UNIQUE NOT NULL,
    payment_id INT NOT NULL REFERENCES payments(payment_id),
    invoice_id INT NOT NULL REFERENCES invoices(invoice_id),
    refund_amount NUMERIC(12, 2) NOT NULL CHECK (refund_amount > 0),
    refund_reason TEXT NOT NULL,
    refund_status refund_status_enum NOT NULL DEFAULT 'PENDING',
    approved_by INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 9: Deposits (เงินมัดจำล่วงหน้า)
CREATE TABLE deposits (
    deposit_id SERIAL PRIMARY KEY,
    deposit_number VARCHAR(30) UNIQUE NOT NULL,
    patient_id INT NOT NULL,
    deposit_amount NUMERIC(12, 2) NOT NULL CHECK (deposit_amount > 0),
    deposit_status deposit_status_enum NOT NULL DEFAULT 'HELD',
    invoice_id INT REFERENCES invoices(invoice_id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    released_at TIMESTAMPTZ
);

-- Table 10: Discount Rules (กฎส่วนลดและโปรโมชัน)
CREATE TABLE discount_rules (
    rule_id SERIAL PRIMARY KEY,
    rule_name VARCHAR(100) NOT NULL,
    discount_type discount_type_enum NOT NULL,
    discount_value NUMERIC(12, 2) NOT NULL CHECK (discount_value > 0),
    target_category VARCHAR(50) NOT NULL DEFAULT 'ALL',
    min_amount NUMERIC(12, 2) NOT NULL DEFAULT 0.00 CHECK (min_amount >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    valid_from TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valid_until TIMESTAMPTZ,
    invoice_id INT REFERENCES invoices(invoice_id)
);

-- Table 11: Price History (ประวัติการปรับราคาบริการ)
CREATE TABLE price_history (
    history_id SERIAL PRIMARY KEY,
    service_id INT NOT NULL REFERENCES billing_services(service_id),
    old_price NUMERIC(12, 2) NOT NULL CHECK (old_price >= 0),
    new_price NUMERIC(12, 2) NOT NULL CHECK (new_price >= 0),
    changed_by INT NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Table 12: Bank Reconciliation (การกระทบยอดธนาคาร)
CREATE TABLE bank_reconciliation (
    reconciliation_id SERIAL PRIMARY KEY,
    bank_date DATE NOT NULL,
    bank_ref VARCHAR(100) NOT NULL,
    bank_amount NUMERIC(12, 2) NOT NULL CHECK (bank_amount > 0),
    payment_id INT REFERENCES payments(payment_id),
    match_status reconcile_status_enum NOT NULL DEFAULT 'UNMATCHED',
    reconciled_by INT,
    reconciled_at TIMESTAMPTZ
);

-- Table 13: Audit Log (บันทึกประวัติการเปลี่ยนแปลงข้อมูล)
CREATE TABLE audit_log (
    log_id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    action audit_action_enum NOT NULL,
    old_values JSONB,
    new_values JSONB,
    performed_by INT NOT NULL,
    performed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    invoice_id INT REFERENCES invoices(invoice_id)
);

-- Indexes
CREATE INDEX idx_invoices_patient ON invoices(patient_id);
CREATE INDEX idx_invoices_status ON invoices(status);
CREATE INDEX idx_payments_invoice ON payments(invoice_id);
CREATE INDEX idx_receipts_payment ON receipts(payment_id);
CREATE INDEX idx_refunds_invoice ON refunds(invoice_id);
CREATE INDEX idx_deposits_patient ON deposits(patient_id);
CREATE INDEX idx_price_history_service ON price_history(service_id);
CREATE INDEX idx_audit_log_table_record ON audit_log(table_name, record_id);

-- ============================================================================
-- 2. TEST DATA INSERTION (ข้อมูลทดสอบครบเกณฑ์)
-- ============================================================================

-- Services Catalog (12 รายการ)
INSERT INTO billing_services (service_code, service_name, category, unit_price) VALUES
('SVC-DOC-01', 'ค่าตรวจรักษาโดยแพทย์ทั่วไป', 'DOCTOR_FEE', 500.00),
('SVC-DOC-02', 'ค่าตรวจรักษาโดยแพทย์เฉพาะทาง', 'DOCTOR_FEE', 1000.00),
('SVC-LAB-01', 'ตรวจความสมบูรณ์ของเลือด (CBC)', 'LABORATORY', 350.00),
('SVC-LAB-02', 'ตรวจระดับน้ำตาลในเลือด (FBS)', 'LABORATORY', 150.00),
('SVC-LAB-03', 'ตรวจปัสสาวะ (Urinalysis)', 'LABORATORY', 120.00),
('SVC-MED-01', 'ยาแก้ปวด Paracetamol 500mg (10 เม็ด)', 'PHARMACY', 50.00),
('SVC-MED-02', 'ยาแก้อักเสบ Amoxicillin 500mg (10 เม็ด)', 'PHARMACY', 120.00),
('SVC-MED-03', 'ยาน้ำแก้ไอแก้เจ็บคอ', 'PHARMACY', 65.00),
('SVC-MED-04', 'ยาแก้แพ้ลดน้ำมูก CPM', 'PHARMACY', 30.00),
('SVC-RM-01', 'ค่าห้องพักผู้ป่วยธรรมดา (1 คืน)', 'ROOM', 1500.00),
('SVC-RM-02', 'ค่าห้องพักผู้ป่วย VIP (1 คืน)', 'ROOM', 3500.00),
('SVC-RM-03', 'ค่าห้อง ICU (1 คืน)', 'ROOM', 5000.00);

-- Invoices (15 รายการ)
INSERT INTO invoices (invoice_number, patient_id, visit_id, issue_date, subtotal_amount, discount_amount, tax_amount, net_amount, status) VALUES
('INV-2026-0001', 1001, 5001, '2026-01-05 09:00:00+7', 900.00, 0.00, 0.00, 900.00, 'PAID'),
('INV-2026-0002', 1002, 5002, '2026-01-10 10:30:00+7', 3000.00, 200.00, 0.00, 2800.00, 'UNPAID'),
('INV-2026-0003', 1003, 5003, '2026-01-15 14:00:00+7', 335.00, 0.00, 0.00, 335.00, 'UNPAID'),
('INV-2026-0004', 1004, 5004, '2026-02-01 08:30:00+7', 530.00, 0.00, 0.00, 530.00, 'PAID'),
('INV-2026-0005', 1005, 5005, '2026-02-10 11:00:00+7', 3000.00, 0.00, 0.00, 3000.00, 'PAID'),
('INV-2026-0006', 1006, 5006, '2026-02-15 09:30:00+7', 500.00, 0.00, 0.00, 500.00, 'PAID'),
('INV-2026-0007', 1007, 5007, '2026-03-01 13:00:00+7', 185.00, 0.00, 0.00, 185.00, 'UNPAID'),
('INV-2026-0008', 1008, 5008, '2026-03-05 10:00:00+7', 1030.00, 0.00, 0.00, 1030.00, 'PARTIALLY_PAID'),
('INV-2026-0009', 1009, 5009, '2026-03-10 15:30:00+7', 3120.00, 0.00, 0.00, 3120.00, 'PAID'),
('INV-2026-0010', 1010, 5010, '2026-03-15 08:00:00+7', 650.00, 50.00, 0.00, 600.00, 'PAID'),
('INV-2026-0011', 1011, 5011, '2026-04-01 09:00:00+7', 5000.00, 0.00, 0.00, 5000.00, 'PAID'),
('INV-2026-0012', 1012, 5012, '2026-04-05 11:30:00+7', 1670.00, 100.00, 0.00, 1570.00, 'UNPAID'),
('INV-2026-0013', 1013, 5013, '2026-04-10 14:00:00+7', 2500.00, 0.00, 0.00, 2500.00, 'PAID'),
('INV-2026-0014', 1014, 5014, '2026-04-15 16:00:00+7', 850.00, 0.00, 0.00, 850.00, 'CANCELLED'),
('INV-2026-0015', 1015, 5015, '2026-05-01 10:00:00+7', 6500.00, 500.00, 0.00, 6000.00, 'PAID');

-- Invoice Items (30 รายการ)
INSERT INTO invoice_items (invoice_id, service_id, item_name, unit_price, quantity, line_total) VALUES
(1, 1, 'ค่าตรวจรักษาโดยแพทย์ทั่วไป', 500.00, 1, 500.00),
(1, 3, 'ตรวจ CBC', 350.00, 1, 350.00),
(1, 6, 'Paracetamol', 50.00, 1, 50.00),
(2, 10, 'ค่าห้องพักธรรมดา 1 คืน', 1500.00, 1, 1500.00),
(2, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(2, 11, 'ค่าห้อง VIP 1 คืน', 3500.00, 1, 3500.00),
(3, 4, 'FBS', 150.00, 1, 150.00),
(3, 7, 'Amoxicillin', 120.00, 1, 120.00),
(3, 8, 'ยาน้ำแก้ไอ', 65.00, 1, 65.00),
(4, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(4, 9, 'CPM', 30.00, 1, 30.00),
(5, 12, 'ค่าห้อง ICU 1 คืน', 5000.00, 1, 5000.00),
(6, 2, 'CBC', 350.00, 1, 350.00),
(6, 4, 'FBS', 150.00, 1, 150.00),
(7, 7, 'Amoxicillin', 120.00, 1, 120.00),
(7, 8, 'ยาน้ำแก้ไอ', 65.00, 1, 65.00),
(8, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(8, 3, 'CBC', 350.00, 1, 350.00),
(8, 6, 'Paracetamol', 50.00, 1, 50.00),
(8, 9, 'CPM', 30.00, 1, 30.00),
(9, 2, 'ค่าตรวจเฉพาะทาง', 1000.00, 1, 1000.00),
(9, 10, 'ค่าห้องธรรมดา 1 คืน', 1500.00, 1, 1500.00),
(9, 7, 'Amoxicillin', 120.00, 1, 120.00),
(10, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(10, 3, 'CBC', 350.00, 1, 350.00),
(11, 12, 'ค่าห้อง ICU 1 คืน', 5000.00, 1, 5000.00),
(12, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(12, 3, 'CBC', 350.00, 1, 350.00),
(12, 7, 'Amoxicillin', 120.00, 5, 600.00),
(13, 11, 'ค่าห้อง VIP 1 คืน', 3500.00, 1, 3500.00),
(14, 1, 'ค่าตรวจรักษา', 500.00, 1, 500.00),
(14, 4, 'FBS', 150.00, 1, 150.00),
(15, 2, 'ค่าตรวจเฉพาะทาง', 1000.00, 1, 1000.00),
(15, 12, 'ค่าห้อง ICU 2 คืน', 5000.00, 2, 10000.00),
(15, 9, 'CPM', 30.00, 2, 60.00);

-- Payments (20 รายการ)
INSERT INTO payments (payment_number, invoice_id, payment_method, amount_paid, transaction_ref, cashier_id, paid_at) VALUES
('PAY-2026-0001', 1, 'PROMPTPAY', 900.00, 'PP-9876543210-TXN', 7001, '2026-01-05 09:30:00+7'),
('PAY-2026-0002', 4, 'CASH', 530.00, NULL, 7001, '2026-02-01 09:00:00+7'),
('PAY-2026-0003', 5, 'CREDIT_CARD', 3000.00, 'CC-1234-5678-9012', 7001, '2026-02-10 11:30:00+7'),
('PAY-2026-0004', 6, 'CASH', 500.00, NULL, 7001, '2026-02-15 10:00:00+7'),
('PAY-2026-0005', 8, 'PROMPTPAY', 500.00, 'PP-5555123456-TXN', 7001, '2026-03-05 10:30:00+7'),
('PAY-2026-0006', 9, 'BANK_TRANSFER', 3120.00, 'BT-9876543210-TXN', 7001, '2026-03-10 16:00:00+7'),
('PAY-2026-0007', 10, 'CASH', 600.00, NULL, 7001, '2026-03-15 08:30:00+7'),
('PAY-2026-0008', 11, 'CREDIT_CARD', 5000.00, 'CC-5678-1234-5678', 7001, '2026-04-01 09:30:00+7'),
('PAY-2026-0009', 13, 'PROMPTPAY', 2500.00, 'PP-1111222233-TXN', 7001, '2026-04-10 14:30:00+7'),
('PAY-2026-0010', 15, 'BANK_TRANSFER', 6000.00, 'BT-4444555566-TXN', 7001, '2026-05-01 10:30:00+7'),
('PAY-2026-0011', 1, 'CASH', 200.00, NULL, 7002, '2026-01-06 10:00:00+7'),
('PAY-2026-0012', 3, 'PROMPTPAY', 335.00, 'PP-7777888899-TXN', 7001, '2026-01-16 09:00:00+7'),
('PAY-2026-0013', 7, 'CASH', 185.00, NULL, 7001, '2026-03-02 13:30:00+7'),
('PAY-2026-0014', 2, 'INSURANCE', 2800.00, 'INS-11223344', 7001, '2026-01-20 11:00:00+7'),
('PAY-2026-0015', 5, 'PROMPTPAY', 1500.00, 'PP-9999000011-TXN', 7002, '2026-02-12 14:00:00+7'),
('PAY-2026-0016', 8, 'CREDIT_CARD', 530.00, 'CC-111122223333', 7001, '2026-03-08 09:00:00+7'),
('PAY-2026-0017', 12, 'PROMPTPAY', 1000.00, 'PP-2222333344-TXN', 7001, '2026-04-06 10:00:00+7'),
('PAY-2026-0018', 14, 'CASH', 850.00, NULL, 7001, '2026-04-15 16:30:00+7'),
('PAY-2026-0019', 6, 'PROMPTPAY', 300.00, 'PP-3333444455-TXN', 7002, '2026-02-16 11:00:00+7'),
('PAY-2026-0020', 9, 'CASH', 500.00, NULL, 7001, '2026-03-11 09:00:00+7');

-- Insurance Claims (10 รายการ)
INSERT INTO insurance_claims (invoice_id, provider_name, policy_number, claimed_amount, approved_amount, claim_status, submitted_at) VALUES
(2, 'เมืองไทยประกันชีวิต', 'POL-99887766', 2800.00, 2000.00, 'APPROVED', '2026-01-20 10:00:00+7'),
(5, 'วิริยะประกันภัย', 'POL-11223344', 3000.00, 3000.00, 'APPROVED', '2026-02-11 09:00:00+7'),
(8, 'ไทยประกัน生命', 'POL-55667788', 1030.00, 530.00, 'APPROVED', '2026-03-06 10:00:00+7'),
(11, 'เมืองไทยประกันชีวิต', 'POL-99887766', 5000.00, 5000.00, 'SETTLED', '2026-04-02 09:30:00+7'),
(15, 'วิริยะประกันภัย', 'POL-11223344', 6000.00, 0.00, 'PENDING', '2026-05-02 10:00:00+7'),
(3, 'ประกันสังคม', 'POL-33445566', 335.00, 335.00, 'SETTLED', '2026-01-16 14:00:00+7'),

(12, 'ไทยประกัน生命', 'POL-55667788', 1570.00, 0.00, 'REJECTED', '2026-04-06 11:00:00+7'),
(9, 'ประกันสังคม', 'POL-33445566', 3120.00, 2500.00, 'APPROVED', '2026-03-11 15:00:00+7'),
(13, 'เมืองไทยประกันชีวิต', 'POL-99887766', 2500.00, 2500.00, 'SETTLED', '2026-04-11 14:00:00+7'),
(10, 'วิริยะประกันภัย', 'POL-11223344', 600.00, 0.00, 'PENDING', '2026-03-16 08:30:00+7');

-- Receipts (20 รายการ)
INSERT INTO receipts (receipt_number, payment_id, invoice_id, total_amount, issued_by, receipt_date) VALUES
('RCP-2026-0001', 1, 1, 900.00, 7001, '2026-01-05 09:30:00+7'),
('RCP-2026-0002', 2, 4, 530.00, 7001, '2026-02-01 09:00:00+7'),
('RCP-2026-0003', 3, 5, 3000.00, 7001, '2026-02-10 11:30:00+7'),
('RCP-2026-0004', 4, 6, 500.00, 7001, '2026-02-15 10:00:00+7'),
('RCP-2026-0005', 5, 8, 500.00, 7001, '2026-03-05 10:30:00+7'),
('RCP-2026-0006', 6, 9, 3120.00, 7001, '2026-03-10 16:00:00+7'),
('RCP-2026-0007', 7, 10, 600.00, 7001, '2026-03-15 08:30:00+7'),
('RCP-2026-0008', 8, 11, 5000.00, 7001, '2026-04-01 09:30:00+7'),
('RCP-2026-0009', 9, 13, 2500.00, 7001, '2026-04-10 14:30:00+7'),
('RCP-2026-0010', 10, 15, 6000.00, 7001, '2026-05-01 10:30:00+7'),
('RCP-2026-0011', 11, 1, 200.00, 7002, '2026-01-06 10:00:00+7'),
('RCP-2026-0012', 12, 3, 335.00, 7001, '2026-01-16 09:00:00+7'),
('RCP-2026-0013', 13, 7, 185.00, 7001, '2026-03-02 13:30:00+7'),
('RCP-2026-0014', 14, 2, 2800.00, 7001, '2026-01-20 11:00:00+7'),
('RCP-2026-0015', 15, 5, 1500.00, 7002, '2026-02-12 14:00:00+7'),
('RCP-2026-0016', 16, 8, 530.00, 7001, '2026-03-08 09:00:00+7'),
('RCP-2026-0017', 17, 12, 1000.00, 7001, '2026-04-06 10:00:00+7'),
('RCP-2026-0018', 19, 6, 300.00, 7002, '2026-02-16 11:00:00+7'),
('RCP-2026-0019', 20, 9, 500.00, 7001, '2026-03-11 09:00:00+7'),
('RCP-2026-0020', 3, 5, 500.00, 7001, '2026-02-11 10:00:00+7');

-- Receipt Items (25 รายการ)
INSERT INTO receipt_items (receipt_id, item_description, amount) VALUES
(1, 'ค่าตรวจ + CBC + Paracetamol', 900.00),
(2, 'ค่าตรวจ + CPM', 530.00),
(3, 'ค่าห้อง ICU (Patient 1005)', 5000.00),
(4, 'CBC + FBS (Patient 1006)', 500.00),
(5, 'ค่าหมอ + CBC + ยา (Patient 1008)', 500.00),
(6, 'ค่าหมอเฉพาะทาง + ห้อง + Amoxicillin', 3120.00),
(7, 'ค่าตรวจ + CBC (Patient 1010)', 600.00),
(8, 'ค่าห้อง ICU (Patient 1011)', 5000.00),
(9, 'ค่าห้อง VIP (Patient 1013)', 2500.00),
(10, 'ค่าตรวจเฉพาะทาง + ห้อง ICU 2 คืน', 6000.00),
(11, 'ค่าตรวจส่วนต่าง (Patient 1001)', 200.00),
(12, 'FBS + Amoxicillin + ยาน้ำ', 335.00),
(13, 'Amoxicillin + ยาน้ำแก้ไอ', 185.00),
(14, 'ค่าห้อง + ค่าตรวจ (Patient 1002)', 2800.00),
(15, 'ค่าห้อง ICU ส่วนต่าง (Patient 1005)', 1500.00),
(16, 'CBC + Paracetamol + CPM', 530.00),
(17, 'ค่าตรวจ + CBC + Amoxicillin x5', 1000.00),
(18, 'CBC + FBS ส่วนต่าง (Patient 1006)', 300.00),
(19, 'ค่าห้อง + Amoxicillin ส่วนต่าง', 500.00),
(20, 'FBS + CBC (Patient 1005)', 500.00),
(1, 'ค่าตรวจรักษา (Patient 1001)', 500.00),
(2, 'ค่าห้อง VIP (Patient 1002)', 3500.00),
(3, 'ค่าตรวจเฉพาะทาง (Patient 1012)', 1000.00),
(4, 'Amoxicillin 5 กล่อง (Patient 1012)', 600.00),
(5, 'CPM 2 ขวด (Patient 1015)', 60.00);

-- Refunds (12 รายการ)
INSERT INTO refunds (refund_number, payment_id, invoice_id, refund_amount, refund_reason, refund_status, approved_by, created_at) VALUES
('RFD-2026-0001', 1, 1, 350.00, 'ห้องแล็บขัดข้อง ไม่ได้ตรวจ CBC', 'COMPLETED', 7009, '2026-01-07 09:00:00+7'),
('RFD-2026-0002', 4, 6, 150.00, 'ตรวจ CBC ซ้ำ คืนค่า FBS', 'COMPLETED', 7009, '2026-02-17 10:00:00+7'),
('RFD-2026-0003', 3, 5, 500.00, 'ผู้ป่วยขอคืนส่วนห้อง ICU', 'APPROVED', 7009, '2026-02-14 11:00:00+7'),
('RFD-2026-0004', 6, 9, 120.00, 'Amoxicillin หมดอายุ เปลี่ยนยาใหม่', 'COMPLETED', 7009, '2026-03-12 14:00:00+7'),
('RFD-2026-0005', 8, 11, 1000.00, 'ยกเลิก ICU 1 คืน (erroneous charge)', 'PENDING', NULL, '2026-04-03 09:00:00+7'),
('RFD-2026-0006', 10, 15, 500.00, 'ลดราคาห้อง ICU เนื่องจากเข้าพักไม่เต็มวัน', 'COMPLETED', 7009, '2026-05-03 10:00:00+7'),
('RFD-2026-0007', 12, 3, 65.00, 'ยาน้ำแก้ไอ ไม่ได้ใช้', 'COMPLETED', 7009, '2026-01-18 09:00:00+7'),
('RFD-2026-0008', 14, 2, 200.00, 'ส่วนลดซ้ำกับประกัน', 'REJECTED', 7009, '2026-01-22 11:00:00+7'),
('RFD-2026-0009', 17, 12, 100.00, 'ส่วนลด Amoxicillin 5 กล่อง', 'APPROVED', 7009, '2026-04-08 10:00:00+7'),
('RFD-2026-0010', 16, 8, 30.00, 'คืนค่า CPM (แพ้ยา)', 'COMPLETED', 7009, '2026-03-10 09:00:00+7'),
('RFD-2026-0011', 19, 6, 50.00, 'FBS ตรวจซ้ำ คืนค่ารายการ', 'COMPLETED', 7009, '2026-02-18 14:00:00+7'),
('RFD-2026-0012', 20, 9, 50.00, 'คืนค่า CPM ส่วนเกิน', 'PENDING', NULL, '2026-03-13 11:00:00+7');

-- Deposits (12 รายการ)
INSERT INTO deposits (deposit_number, patient_id, deposit_amount, deposit_status, invoice_id, created_at) VALUES
('DEP-2026-0001', 1001, 5000.00, 'HELD', NULL, '2026-01-04 08:00:00+7'),
('DEP-2026-0002', 1002, 3000.00, 'APPLIED', 2, '2026-01-09 09:00:00+7'),
('DEP-2026-0003', 1005, 3000.00, 'APPLIED', 5, '2026-02-09 10:00:00+7'),
('DEP-2026-0004', 1009, 3500.00, 'APPLIED', 9, '2026-03-09 14:00:00+7'),
('DEP-2026-0005', 1010, 1000.00, 'REFUNDED', NULL, '2026-03-14 08:00:00+7'),
('DEP-2026-0006', 1011, 5000.00, 'APPLIED', 11, '2026-03-31 09:00:00+7'),
('DEP-2026-0007', 1013, 2500.00, 'APPLIED', 13, '2026-04-09 13:00:00+7'),
('DEP-2026-0008', 1015, 7000.00, 'HELD', NULL, '2026-04-30 10:00:00+7'),
('DEP-2026-0009', 1003, 500.00, 'APPLIED', 3, '2026-01-14 14:00:00+7'),
('DEP-2026-0010', 1007, 300.00, 'REFUNDED', NULL, '2026-02-28 13:00:00+7'),
('DEP-2026-0011', 1012, 2000.00, 'HELD', NULL, '2026-04-04 11:00:00+7'),
('DEP-2026-0012', 1008, 1500.00, 'APPLIED', 8, '2026-03-04 10:00:00+7');

-- Discount Rules (10 รายการ)
INSERT INTO discount_rules (rule_name, discount_type, discount_value, target_category, min_amount, is_active, invoice_id) VALUES
('ส่วนลดผู้สูงอายุ 60+ (ค่ายา)', 'PERCENTAGE', 10.00, 'PHARMACY', 100.00, TRUE, 1),
('คูปองตรวจสุขภาพประจำปี', 'FIXED_AMOUNT', 200.00, 'ALL', 1000.00, TRUE, 2),
('ส่วนลดสมาชิกประกันสังคม', 'PERCENTAGE', 5.00, 'DOCTOR_FEE', 0.00, TRUE, 3),
('โปรโมชันห้องพัก VIP', 'FIXED_AMOUNT', 500.00, 'ROOM', 3000.00, TRUE, 5),
('ส่วนลดผู้ป่วยเรื้อรัง', 'PERCENTAGE', 15.00, 'PHARMACY', 500.00, TRUE, 7),
('ส่วนลดชำระเงินสด', 'PERCENTAGE', 2.00, 'ALL', 100.00, TRUE, 4),
('ส่วนลูกค้าองค์กร', 'FIXED_AMOUNT', 300.00, 'ALL', 2000.00, FALSE, 9),
('ส่วนลดวันเกิด', 'PERCENTAGE', 10.00, 'ALL', 0.00, TRUE, 10),
('ส่วนลดห้องพักระยะยาว', 'PERCENTAGE', 8.00, 'ROOM', 5000.00, TRUE, 11),
('ส่วนลดตรวจเลือดประจำปี', 'FIXED_AMOUNT', 100.00, 'LABORATORY', 300.00, TRUE, 6);

-- Price History (12 รายการ)
INSERT INTO price_history (service_id, old_price, new_price, changed_by, changed_at) VALUES
(1, 450.00, 500.00, 7009, '2026-01-01 08:00:00+7'),
(10, 1200.00, 1500.00, 7009, '2026-01-01 08:00:00+7'),
(11, 3000.00, 3500.00, 7009, '2026-01-01 08:00:00+7'),
(12, 4500.00, 5000.00, 7009, '2026-02-01 08:00:00+7'),
(3, 300.00, 350.00, 7009, '2026-02-15 09:00:00+7'),
(4, 120.00, 150.00, 7009, '2026-02-15 09:00:00+7'),
(2, 800.00, 1000.00, 7009, '2026-03-01 08:00:00+7'),
(6, 45.00, 50.00, 7009, '2026-03-01 08:00:00+7'),
(8, 55.00, 65.00, 7009, '2026-04-01 08:00:00+7'),
(5, 100.00, 120.00, 7009, '2026-04-01 08:00:00+7'),
(9, 25.00, 30.00, 7009, '2026-04-15 09:00:00+7'),
(7, 110.00, 120.00, 7009, '2026-05-01 08:00:00+7');

-- Bank Reconciliation (12 รายการ)
INSERT INTO bank_reconciliation (bank_date, bank_ref, bank_amount, payment_id, match_status, reconciled_by, reconciled_at) VALUES
('2026-01-05', 'BANK-PP-9876543210', 900.00, 1, 'MATCHED', 7008, '2026-01-06 09:00:00+7'),
('2026-01-10', 'BANK-UNKNOWN-0099', 1500.00, NULL, 'UNMATCHED', NULL, NULL),
('2026-02-01', 'BANK-CASH-001', 530.00, 2, 'MATCHED', 7008, '2026-02-02 09:00:00+7'),
('2026-02-10', 'BANK-CC-1234-5678-9012', 3000.00, 3, 'MATCHED', 7008, '2026-02-11 09:00:00+7'),
('2026-02-15', 'BANK-PP-5555123456', 500.00, 4, 'MATCHED', 7008, '2026-02-16 09:00:00+7'),
('2026-03-05', 'BANK-PP-1111222233', 500.00, 5, 'MATCHED', 7008, '2026-03-06 09:00:00+7'),
('2026-03-10', 'BANK-BT-9876543210', 3120.00, 6, 'MATCHED', 7008, '2026-03-11 09:00:00+7'),
('2026-03-12', 'BANK-UNKNOWN-1122', 2500.00, NULL, 'UNMATCHED', NULL, NULL),
('2026-04-01', 'BANK-CC-5678-1234-5678', 5000.00, 8, 'MATCHED', 7008, '2026-04-02 09:00:00+7'),
('2026-04-10', 'BANK-PP-3333444455', 2500.00, 9, 'MATCHED', 7008, '2026-04-11 09:00:00+7'),
('2026-05-01', 'BANK-BT-4444555566', 6000.00, 10, 'MATCHED', 7008, '2026-05-02 09:00:00+7'),
('2026-05-05', 'BANK-UNKNOWN-5566', 8000.00, NULL, 'DISPUTED', NULL, NULL);

-- Audit Log (25 รายการ)
INSERT INTO audit_log (table_name, record_id, action, old_values, new_values, performed_by, performed_at, invoice_id) VALUES
('billing_services', 1, 'UPDATE', '{"unit_price": 450.00}', '{"unit_price": 500.00}', 7009, '2026-01-01 08:00:00+7', NULL),
('billing_services', 10, 'UPDATE', '{"unit_price": 1200.00}', '{"unit_price": 1500.00}', 7009, '2026-01-01 08:00:00+7', NULL),
('billing_services', 11, 'UPDATE', '{"unit_price": 3000.00}', '{"unit_price": 3500.00}', 7009, '2026-01-01 08:00:00+7', NULL),
('billing_services', 12, 'UPDATE', '{"unit_price": 4500.00}', '{"unit_price": 5000.00}', 7009, '2026-02-01 08:00:00+7', NULL),
('invoices', 1, 'INSERT', NULL, '{"invoice_number": "INV-2026-0001", "patient_id": 1001, "net_amount": 900.00}', 7001, '2026-01-05 09:00:00+7', 1),
('invoices', 2, 'INSERT', NULL, '{"invoice_number": "INV-2026-0002", "patient_id": 1002, "net_amount": 2800.00}', 7001, '2026-01-10 10:30:00+7', 2),
('invoices', 5, 'INSERT', NULL, '{"invoice_number": "INV-2026-0005", "patient_id": 1005, "net_amount": 3000.00}', 7001, '2026-02-10 11:00:00+7', 5),
('invoices', 14, 'UPDATE', '{"status": "PAID"}', '{"status": "CANCELLED"}', 7009, '2026-04-15 16:30:00+7', 14),
('payments', 1, 'INSERT', NULL, '{"payment_number": "PAY-2026-0001", "amount_paid": 900.00}', 7001, '2026-01-05 09:30:00+7', 1),
('payments', 3, 'INSERT', NULL, '{"payment_number": "PAY-2026-0003", "amount_paid": 3000.00}', 7001, '2026-02-10 11:30:00+7', 5),
('payments', 6, 'INSERT', NULL, '{"payment_number": "PAY-2026-0006", "amount_paid": 3120.00}', 7001, '2026-03-10 16:00:00+7', 9),
('payments', 10, 'INSERT', NULL, '{"payment_number": "PAY-2026-0010", "amount_paid": 6000.00}', 7001, '2026-05-01 10:30:00+7', 15),
('refunds', 1, 'INSERT', NULL, '{"refund_number": "RFD-2026-0001", "refund_amount": 350.00}', 7009, '2026-01-07 09:00:00+7', 1),
('refunds', 2, 'INSERT', NULL, '{"refund_number": "RFD-2026-0002", "refund_amount": 150.00}', 7009, '2026-02-17 10:00:00+7', 6),
('refunds', 3, 'UPDATE', '{"refund_status": "PENDING"}', '{"refund_status": "APPROVED"}', 7009, '2026-02-15 11:00:00+7', 5),
('refunds', 6, 'INSERT', NULL, '{"refund_number": "RFD-2026-0006", "refund_amount": 500.00}', 7009, '2026-05-03 10:00:00+7', 15),
('insurance_claims', 1, 'INSERT', NULL, '{"claim_id": 1, "provider_name": "เมืองไทยประกันชีวิต"}', 7001, '2026-01-20 10:00:00+7', 2),
('insurance_claims', 2, 'UPDATE', '{"claim_status": "PENDING"}', '{"claim_status": "APPROVED"}', 7009, '2026-02-12 09:00:00+7', 5),
('insurance_claims', 7, 'UPDATE', '{"claim_status": "PENDING"}', '{"claim_status": "REJECTED"}', 7009, '2026-04-10 11:00:00+7', 12),
('deposits', 1, 'INSERT', NULL, '{"deposit_number": "DEP-2026-0001", "deposit_amount": 5000.00}', 7001, '2026-01-04 08:00:00+7', NULL),
('deposits', 2, 'UPDATE', '{"deposit_status": "HELD"}', '{"deposit_status": "APPLIED"}', 7009, '2026-01-15 09:00:00+7', 2),
('deposits', 5, 'UPDATE', '{"deposit_status": "HELD"}', '{"deposit_status": "REFUNDED"}', 7009, '2026-03-20 10:00:00+7', NULL),
('bank_reconciliation', 2, 'INSERT', NULL, '{"bank_ref": "BANK-UNKNOWN-0099", "bank_amount": 1500.00}', 7008, '2026-01-12 09:00:00+7', NULL),
('bank_reconciliation', 8, 'INSERT', NULL, '{"bank_ref": "BANK-UNKNOWN-1122", "bank_amount": 2500.00}', 7008, '2026-03-14 09:00:00+7', NULL),
('bank_reconciliation', 12, 'INSERT', NULL, '{"bank_ref": "BANK-UNKNOWN-5566", "bank_amount": 8000.00}', 7008, '2026-05-07 09:00:00+7', NULL);

-- ============================================================================
-- 3. VERIFICATION
-- ============================================================================

SELECT '=== H3 Billing DDL + Test Data - สำเร็จ! ===' AS status;

-- ============================================================================
-- ส่วนที่ 1 ข้อ 1.2 ตรวจสอบจำนวนข้อมูล — 6 คะแนน
-- ============================================================================

-- ข้อ 1.2: แสดงจำนวนข้อมูลของทุก Table
SELECT 'billing_services' AS table_name, COUNT(*) AS total_rows FROM billing_services
UNION ALL SELECT 'invoices', COUNT(*) FROM invoices
UNION ALL SELECT 'invoice_items', COUNT(*) FROM invoice_items
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'insurance_claims', COUNT(*) FROM insurance_claims
UNION ALL SELECT 'receipts', COUNT(*) FROM receipts
UNION ALL SELECT 'receipt_items', COUNT(*) FROM receipt_items
UNION ALL SELECT 'refunds', COUNT(*) FROM refunds
UNION ALL SELECT 'deposits', COUNT(*) FROM deposits
UNION ALL SELECT 'discount_rules', COUNT(*) FROM discount_rules
UNION ALL SELECT 'price_history', COUNT(*) FROM price_history
UNION ALL SELECT 'bank_reconciliation', COUNT(*) FROM bank_reconciliation
UNION ALL SELECT 'audit_log', COUNT(*) FROM audit_log
ORDER BY table_name;

-- ============================================================================
-- ส่วนที่ 2 การเรียกดูและกรองข้อมูล — 6 คะแนน
-- ============================================================================

-- ============================================================================
-- ข้อ 2.1 SELECT และ Alias — 1 คะแนน
-- คำถาม: ต้องการแสดงรายการใบแจ้งหนี้ที่ยังไม่ชำระเงิน พร้อมชื่อคอลัมน์ที่เข้าใจง่าย
-- ============================================================================

SELECT 
    service_id AS "รหัสบริการภายใน",
    service_code AS "รหัสบริการอ้างอิง",
    service_name AS "ชื่อบริการทางการแพทย์",
    unit_price AS "ราคาค่าบริการต่อหน่วย (บาท)"
FROM billing_services;

-- ผลที่คาดหวัง: ตารางรายการบริการทั้งหมด 12 แถว แสดงด้วยหัวคอลัมน์ที่เป็นภาษาไทยตามที่ระบุไว้ใน Alias
-- คำอธิบาย: ใช้ดึงข้อมูลแค็ตตาล็อกบริการของโรงพยาบาลและแปลงหัวคอลัมน์ให้เหมาะสมสำหรับนำไปแสดงผลบนหน้าจอผู้ใช้งานภาษาไทย

-- ============================================================================
-- ข้อ 2.2 WHERE และ Operators — 1 คะแนน
-- คำถาม: ต้องการหารายการชำระเงินที่มียอดมากกว่า 1000 บาท และชำระด้วยบัตรเครดิตหรือโอนเงิน
-- ============================================================================

SELECT 
    invoice_number AS "เลขที่ใบแจ้งหนี้", 
    patient_id AS "รหัสผู้ป่วย", 
    net_amount AS "ยอดสุทธิ", 
    status AS "สถานะ"
FROM invoices 
WHERE status = 'PAID' AND net_amount > 1000.00;

-- ผลที่คาดหวัง: แสดงรายการใบแจ้งหนี้ที่มีสถานะเป็น 'PAID' และมียอดสุทธิเกิน 1000 บาท
-- คำอธิบาย: ใช้คัดกรองใบแจ้งหนี้ที่ชำระเงินเรียบร้อยและมียอดใช้จ่ายสูง เพื่อนำมาทำสถิติลูกค้ากลุ่มเป้าหมายที่มีกำลังจ่าย

-- ============================================================================
-- ข้อ 2.3 LIKE — 1 คะแนน
-- คำถาม: ต้องการค้นหาบริการที่มีคำว่า "ห้อง" ในชื่อบริการ
-- ============================================================================

SELECT
    service_code AS "รหัสบริการ",
    service_name AS "ชื่อบริการ",
    category AS "หมวดหมู่",
    unit_price AS "ราคาหน่วย"
FROM billing_services
WHERE service_name LIKE '%ห้อง%';

-- ผลที่คาดหวัง: รายการบริการที่เกี่ยวกับห้องพักทั้งหมด
-- คำอธิบาย: LIKE '%ห้อง%' ค้นหาคำที่มี "ห้อง" อยู่ตรงไหนก็ได้ในชื่อบริการ

-- ============================================================================
-- ข้อ 2.4 IN — 1 คะแนน
-- คำถาม: ต้องการแสดงใบแจ้งหนี้ที่มีสถานะ PAID หรือ PARTIALLY_PAID
-- ============================================================================

SELECT
    invoice_number AS "เลขที่ใบแจ้งหนี้",
    patient_id AS "รหัสผู้ป่วย",
    net_amount AS "จำนวนเงินสุทธิ",
    status AS "สถานะ"
FROM invoices
WHERE status IN ('PAID', 'PARTIALLY_PAID');

-- ผลที่คาดหวัง: ใบแจ้งหนี้ที่ชำระแล้วและชำระบางส่วน
-- คำอธิบาย: IN ใช้เลือกข้อมูลที่ตรงกับค่าหลายค่าใน list เดียวกัน

-- ============================================================================
-- ข้อ 2.5 BETWEEN — 1 คะแนน
-- คำถาม: ต้องการหารายการใบแจ้งหนี้ที่ออกในช่วงเดือนมกราคมถึงมีนาคม 2026
-- ============================================================================

SELECT 
    payment_number AS "รหัสชำระเงิน", 
    invoice_id AS "รหัสใบแจ้งหนี้", 
    payment_method AS "วิธีการชำระ", 
    amount_paid AS "ยอดที่จ่าย", 
    paid_at AS "เวลาชำระเงิน"
FROM payments 
WHERE amount_paid BETWEEN 500.00 AND 2000.00;

-- ผลที่คาดหวัง: รายการชำระเงินที่มียอดเงินอยู่ในช่วง 500 ถึง 2000 บาท
-- คำอธิบาย: ค้นหาข้อมูลยอดชำระเงินระดับปานกลางเพื่อวิเคราะห์แนวโน้มยอดเงินชำระเฉลี่ยผ่านช่องทางต่างๆ ของโรงพยาบาล

-- ============================================================================
-- ข้อ 2.6 DISTINCT — 1 คะแนน
-- คำถาม: ต้องการทราบว่ามีวิธีการชำระเงินใดบ้างที่ใช้ในระบบ (ไม่ซ้ำกัน)
-- ============================================================================

SELECT DISTINCT
    payment_method AS "วิธีชำระเงิน"
FROM payments;

-- ผลที่คาดหวัง: รายการวิธีชำระเงินที่ไม่ซ้ำกันทั้งหมด
-- คำอธิบาย: DISTINCT แสดงค่าที่ไม่ซ้ำกัน ช่วยตอบคำถามว่า "มีวิธีชำระเงินกี่ประเภท"

-- ============================================================================
-- ส่วนที่ 3 การเรียงลำดับและสรุปข้อมูล — 6 คะแนน
-- ============================================================================

-- ============================================================================
-- ข้อ 3.1 ORDER BY และ LIMIT — 1 คะแนน
-- คำถาม: ต้องการทราบ 5 รายการใบแจ้งหนี้ที่มียอดเงินสุทธิสูงสุด
-- ============================================================================

SELECT
    invoice_number AS "เลขที่ใบแจ้งหนี้",
    patient_id AS "รหัสผู้ป่วย",
    net_amount AS "จำนวนเงินสุทธิ",
    status AS "สถานะ"
FROM invoices
ORDER BY net_amount DESC
LIMIT 5;

-- ผลที่คาดหวัง: 5 ใบแจ้งหนี้ที่มียอดเงินสูงสุด เรียงจากมากไปน้อย
-- คำอธิบาย: ORDER BY DESC เรียงลำดับจากมากไปน้อย LIMIT 5 แสดงเฉพาะ 5 รายการแรก

-- ============================================================================
-- ข้อ 3.2 MIN และ MAX — 1 คะแนน
-- คำถาม: ต้องการทราบช่วงราคาของบริการทั้งหมดในระบบ (ราคาต่ำสุดและสูงสุด)
-- ============================================================================

SELECT
    MIN(unit_price) AS "ราคาต่ำสุด",
    MAX(unit_price) AS "ราคาสูงสุด",
    MAX(unit_price) - MIN(unit_price) AS "ช่วงราคา"
FROM billing_services;

-- ผลที่คาดหวัง: ราคาต่ำสุด 30.00 (CPM) และราคาสูงสุด 5000.00 (ICU)
-- คำอธิบาย: MIN/MAX หาค่าต่ำสุดและสูงสุดจากคอลัมน์ unit_price

-- ============================================================================
-- ข้อ 3.3 COUNT — 1 คะแนน
-- คำถาม: ต้องการทราบจำนวนใบแจ้งหนี้แยกตามสถานะ
-- ============================================================================

SELECT COUNT(*) AS "จำนวนรายการเคลมประกันที่ค้างอยู่"
FROM insurance_claims 
WHERE claim_status = 'PENDING';

-- ผลที่คาดหวัง: แสดงจำนวนยอดเคสเคลมประกันที่ยังค้างพิจารณา
-- คำอธิบาย: คิวรีนี้ช่วยตรวจสอบปริมาณงานเคลมที่ค้างชำระ เพื่อแจ้งเตือนพนักงานบัญชีให้ส่งข้อมูลประกันเพิ่ม

-- ============================================================================
-- ข้อ 3.4 SUM — 1 คะแนน
-- คำถาม: ต้องการทราบยอดเงินรวมที่ชำระเข้ามาทั้งหมดในระบบ
-- ============================================================================

SELECT
    SUM(amount_paid) AS "ยอดชำระรวมทั้งหมด",
    COUNT(*) AS "จำนวนรายการชำระ"
FROM payments;

-- ผลที่คาดหวัง: ผลรวมยอดเงินที่ชำระทั้งหมด
-- คำอธิบาย: SUM(amount_paid) คำนวณยอดเงินรวมที่ชำระเข้ามาทั้งหมดในระบบ

-- ============================================================================
-- ข้อ 3.5 AVG — 1 คะแนน
-- คำถาม: ต้องการทราบค่าเฉลี่ยยอดเงินชำระต่อรายการ
-- ============================================================================

SELECT
    AVG(amount_paid)::NUMERIC(12,2) AS "ยอดชำระเฉลี่ย",
    MIN(amount_paid) AS "ยอดชำระต่ำสุด",
    MAX(amount_paid) AS "ยอดชำระสูงสุด"
FROM payments
WHERE amount_paid > 0;

-- ผลที่คาดหวัง: ค่าเฉลี่ยยอดชำระต่อรายการ (ไม่รวมรายการที่ยอด 0)
-- คำอธิบาย: AVG หาค่าเฉลี่ย ช่วยให้เห็นภาพว่าผู้ป่วยเฉลี่ยจ่ายเงินเท่าไหร่ต่อบิล

-- ============================================================================
-- ข้อ 3.6 CASE — 1 คะแนน
-- คำถาม: ต้องการจัดกลุ่มใบแจ้งหนี้เป็น 3 ระดับ ตามยอดเงินสุทธิ
-- ============================================================================

SELECT
    invoice_number AS "เลขที่ใบแจ้งหนี้",
    net_amount AS "จำนวนเงินสุทธิ",
    status AS "สถานะ",
    CASE
        WHEN net_amount >= 3000 THEN 'ยอดสูง'
        WHEN net_amount >= 1000 THEN 'ยอดปานกลาง'
        ELSE 'ยอดต่ำ'
    END AS "กลุ่มยอดเงิน"
FROM invoices
ORDER BY net_amount DESC;

-- ผลที่คาดหวัง: ใบแจ้งหนี้แต่ละรายการถูกจัดกลุ่มเป็น ยอดสูง / ยอดปานกลาง / ยอดต่ำ
-- คำอธิบาย: CASE ใช้จัดประเภทข้อมูลตามเงื่อนไขที่กำหนด ช่วยในการวิเคราะห์ระดับยอดเงิน

-- ============================================================================
-- ส่วนที่ 4 GROUP BY และ HAVING — 4 คะแนน
-- ============================================================================

-- ============================================================================
-- ข้อ 4.1 GROUP BY — 2 คะแนน
-- คำถาม: ต้องการทราบยอดเงินรวมแยกตามหมวดหมู่บริการ (DOCTOR_FEE, LABORATORY, PHARMACY, ROOM)
-- ============================================================================

SELECT 
    payment_method AS "วิธีการชำระเงิน", 
    COUNT(*) AS "จำนวนครั้งที่ใช้งาน",
    SUM(amount_paid) AS "ยอดชำระรวมทั้งหมด (บาท)"
FROM payments
GROUP BY payment_method
ORDER BY SUM(amount_paid) DESC;

-- ============================================================================
-- ข้อ 4.2 HAVING — 2 คะแนน
-- คำถาม: ต้องการแสดงเฉพาะหมวดหมู่บริการที่มียอดรวมมากกว่า 1000 บาท
-- ============================================================================

SELECT 
    category AS "หมวดหมู่ค่าบริการ", 
    COUNT(*) AS "จำนวนรายการย่อย",
    ROUND(AVG(unit_price), 2) AS "ราคาเฉลี่ย (บาท)"
FROM billing_services
GROUP BY category
HAVING COUNT(*) >= 3;

-- ผลที่คาดหวัง: แสดงเฉพาะหมวดหมู่ที่มียอดรวมมากกว่า 1000 บาท
-- คำอธิบาย: WHERE กรองข้อมูลก่อน GROUP BY, HAVING กรองข้อมูลหลัง GROUP BY

-- ============================================================================
-- ความแตกต่างระหว่าง WHERE และ HAVING
-- ============================================================================
-- WHERE: กรองแถว individual ก่อนการจัดกลุ่ม (ก่อน GROUP BY)
-- HAVING: กรองกลุ่มหลังจัดกลุ่มแล้ว (หลัง GROUP BY)
-- ตัวอย่าง: WHERE unit_price > 100 กรองรายการที่ราคาเกิน 100 ก่อน แล้ว GROUP BY แล้วค่อย HAVING SUM > 1000

-- ============================================================================
-- ส่วนที่ 5 ความสัมพันธ์และ JOIN — 5 คะแนน
-- ============================================================================

-- ============================================================================
-- ข้อ 5.1 INNER JOIN — 2 คะแนน
-- คำถาม: ต้องการแสดงรายละเอียดใบแจ้งหนี้พร้อมรายการบริการที่สั่งซื้อ
-- ============================================================================

SELECT
    inv.invoice_number AS "เลขที่ใบแจ้งหนี้",
    inv.patient_id AS "รหัสผู้ป่วย",
    bs.service_name AS "ชื่อบริการ",
    bs.category AS "หมวดหมู่",
    ii.unit_price AS "ราคาหน่วย",
    ii.quantity AS "จำนวน",
    ii.line_total AS "ยอดรวมรายการ"
FROM invoice_items ii
INNER JOIN invoices inv ON ii.invoice_id = inv.invoice_id
INNER JOIN billing_services bs ON ii.service_id = bs.service_id
ORDER BY inv.invoice_number, bs.service_name;

-- ผลที่คาดหวัง: รายการบริการที่มีในใบแจ้งหนี้เท่านั้น (ไม่รวมรายการที่ยังไม่มีใน invoice_items)
-- คำอธิบาย: INNER JOIN แสดงเฉพาะข้อมูลที่ตรงกันทั้งสองตาราง

-- ============================================================================
-- ข้อ 5.2 LEFT JOIN — 2 คะแนน
-- คำถาม: ต้องการแสดงใบแจ้งหนี้ทั้งหมด พร้อมยอดชำระ (ถ้ามี) เพื่อดูว่าใบไหนยังไม่มีการชำระ
-- ============================================================================

SELECT
    inv.invoice_number AS "เลขที่ใบแจ้งหนี้",
    inv.patient_id AS "รหัสผู้ป่วย",
    inv.net_amount AS "ยอดหนี้สุทธิ",
    inv.status AS "สถานะ",
    p.payment_number AS "เลขที่ชำระ",
    p.amount_paid AS "ยอดชำระ"
FROM invoices inv
LEFT JOIN payments p ON inv.invoice_id = p.invoice_id
ORDER BY inv.invoice_number;

-- ผลที่คาดหวัง: ใบแจ้งหนี้ทั้งหมด แสดงยอดชำระถ้ามี หรือ NULL ถ้ายังไม่มี
-- คำอธิบาย: LEFT JOIN แสดงข้อมูลทั้งหมดจากตารางซ้าย แม้จะไม่มีข้อมูลตรงกันในตารางขวา

-- ============================================================================
-- ข้อ 5.3 ตรวจข้อมูลที่ไม่มีความสัมพันธ์ — 1 คะแนน
-- คำถาม: ต้องการหาใบแจ้งหนี้ที่ยังไม่มีรายการชำระเงินเลย (ยังไม่มี payment)
-- ============================================================================

SELECT 
    i.invoice_number AS "เลขที่ใบแจ้งหนี้ที่ยังไม่ชำระเงิน", 
    i.patient_id AS "รหัสผู้ป่วย", 
    i.net_amount AS "ยอดค้างชำระ (บาท)", 
    i.status AS "สถานะปัจจุบัน"
FROM invoices i
LEFT JOIN payments p ON i.invoice_id = p.invoice_id
WHERE p.payment_id IS NULL
ORDER BY i.invoice_number;

-- ผลที่คาดหวัง: ใบแจ้งหนี้ที่ยังไม่มีรายการชำระเงิน (ยังไม่มี payment record)
-- คำอธิบาย: NOT EXISTS ใช้หาข้อมูลในตารางหลักที่ไม่มีข้อมูลเชื่อมโยงในตารางลูก

-- ============================================================================
-- ส่วนที่ 6 ตรวจสอบและทำความสะอาดข้อมูล — 3 คะแนน
-- ============================================================================

-- ============================================================================
-- ข้อ 6.1 ตรวจค่าที่หายไป (NULL) — 1 คะแนน
-- คำถาม: ต้องการตรวจว่ามีใบแจ้งหนี้ไหนที่ remark เป็น NULL หรือไม่
-- ============================================================================

SELECT
    invoice_number AS "เลขที่ใบแจ้งหนี้",
    patient_id AS "รหัสผู้ป่วย",
    remarks AS "หมายเหตุ"
FROM invoices
WHERE remarks IS NULL;

-- ============================================================================
-- ข้อ 6.2 ตรวจข้อมูลซ้ำ — 1 คะแนน
-- คำถาม: ต้องการตรวจว่ามีผู้ป่วยคนไหนที่มีใบแจ้งหนี้หลายรายการหรือไม่
-- ============================================================================

SELECT 
    service_code AS "รหัสค่าบริการทางการแพทย์", 
    COUNT(*) AS "จำนวนแถวที่ซ้ำซ้อน"
FROM billing_services
GROUP BY service_code
HAVING COUNT(*) > 1;

-- ============================================================================
-- ข้อ 6.3 เสนอแนวทางแก้ไข — 1 คะแนน
-- ============================================================================

-- หากพบว่ามีข้อมูลผิดปกติ สามารถแก้ไขได้ดังนี้:

-- ตัวอย่างที่ 1: แก้ไข remarks ที่เป็น NULL
BEGIN;

-- 1. แสดงราคาเดิมก่อนแก้ไข
SELECT service_code, service_name, unit_price 
FROM billing_services 
WHERE service_code = 'SVC-RM-01';

-- 2. เสนอทางแก้ไขโดยใช้คำสั่ง UPDATE ปรับราคาห้องพักจาก 2,500 บาท เป็น 2,800 บาท
UPDATE billing_services 
SET unit_price = 2800.00 
WHERE service_code = 'SVC-RM-01';

-- 3. เรียกดูผลลัพธ์จำลองราคาใหม่หลังปรับปรุงเพื่อตรวจสอบความถูกต้อง
SELECT service_code, service_name, unit_price 
FROM billing_services 
WHERE service_code = 'SVC-RM-01';

-- 4. ย้อนกลับคำสั่งเพื่อไม่ให้บันทึกจริง ป้องกันข้อมูลหลักเสียหาย
ROLLBACK;

-- ตัวอย่างที่ 3: ป้องกันข้อมูลซ้ำในอนาคตด้วย UNIQUE constraint
-- ALTER TABLE payments ADD CONSTRAINT uq_payment_number UNIQUE (payment_number);
-- (payment_number มี UNIQUE constraint อยู่แล้วจากตอนสร้างตาราง)

-- ตัวอย่างที่ 4: กำหนด NOT NULL สำหรับคอลัมน์ที่จำเป็น
-- ALTER TABLE invoices ALTER COLUMN remarks SET NOT NULL;
-- (ต้องรัน UPDATE SET remarks = 'ไม่มีหมายเหตุ' WHERE remarks IS NULL ก่อน จึงจะใช้ได้)

-- ตัวอย่างที่ 5: กำหนด CHECK constraint สำหรับคอลัมน์ที่ต้องมีค่าเฉพาะ
-- ALTER TABLE payments ADD CONSTRAINT chk_amount_positive CHECK (amount_paid > 0);
-- (amount_paid มี CHECK constraint อยู่แล้วจากตอนสร้างตาราง)

-- คำอธิบาย: ใช้ BEGIN/ROLLBACK เพื่อทดสอบคำสั่งโดยไม่กระทบข้อมูลจริง
-- หากต้องการยืนยันการแก้ไข ให้เปลี่ยน ROLLBACK เป็น COMMIT

-- ============================================================================
-- สรุปคะแนน
-- ============================================================================
-- ส่วนที่ 1: โครงสร้างและข้อมูลในฐานข้อมูล — 6 คะแนน
-- ส่วนที่ 2: การเรียกดูและกรองข้อมูล — 6 คะแนน
-- ส่วนที่ 3: การเรียงลำดับและสรุปข้อมูล — 6 คะแนน
-- ส่วนที่ 4: GROUP BY และ HAVING — 4 คะแนน
-- ส่วนที่ 5: ความสัมพันธ์และ JOIN — 5 คะแนน
-- ส่วนที่ 6: การตรวจและทำความสะอาดข้อมูล — 3 คะแนน
-- รวม — 30 คะแนน
-- ============================================================================
