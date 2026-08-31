-- ==============================================================================
-- 05_create_indexes.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: สร้าง Indexes สำหรับคอลัมน์ที่ใช้ค้นหาบ่อย, คอลัมน์ที่ใช้ JOIN ข้ามโมดูล
--         และ Foreign Keys เพื่อเพิ่มประสิทธิภาพการทำงานระดับ Production
-- ==============================================================================

\connect hospital_enterprise_db

-- 1. Indexes สำหรับโมดูล H1: ทะเบียนผู้ป่วย
CREATE INDEX IF NOT EXISTS idx_patients_name 
    ON patient_system.patients(last_name, first_name);

CREATE INDEX IF NOT EXISTS idx_patients_status 
    ON patient_system.patients(patient_status);

CREATE INDEX IF NOT EXISTS idx_patients_branch 
    ON patient_system.patients(registered_branch_id);

CREATE INDEX IF NOT EXISTS idx_contacts_patient 
    ON patient_system.patient_contacts(patient_id);

CREATE INDEX IF NOT EXISTS idx_contacts_value 
    ON patient_system.patient_contacts(contact_value);

CREATE INDEX IF NOT EXISTS idx_policies_patient 
    ON patient_system.patient_insurance_policies(patient_id);

CREATE INDEX IF NOT EXISTS idx_users_username 
    ON patient_system.users_security(username);

CREATE INDEX IF NOT EXISTS idx_audit_patient 
    ON patient_system.emergency_access_audit_log(patient_id);

-- 2. Indexes สำหรับโมดูล H2: นัดหมาย/OPD (JOIN ข้ามไป H1 และ H7)
CREATE INDEX IF NOT EXISTS idx_appointments_patient 
    ON opd_system.appointments(patient_id);

CREATE INDEX IF NOT EXISTS idx_appointments_doctor 
    ON opd_system.appointments(doctor_id);

CREATE INDEX IF NOT EXISTS idx_appointments_date 
    ON opd_system.appointments(appointment_date);

CREATE INDEX IF NOT EXISTS idx_clinical_patient 
    ON opd_system.clinical_records(patient_id);

CREATE INDEX IF NOT EXISTS idx_clinical_doctor 
    ON opd_system.clinical_records(doctor_id);

CREATE INDEX IF NOT EXISTS idx_clinical_date 
    ON opd_system.clinical_records(record_date);

-- 3. Indexes สำหรับโมดูล H5: ห้องแล็บ
CREATE INDEX IF NOT EXISTS idx_lab_patient 
    ON lab_system.lab_orders(patient_id);

CREATE INDEX IF NOT EXISTS idx_lab_order_results 
    ON lab_system.lab_results(order_id);

-- 4. Indexes สำหรับโมดูล H4: เภสัชกรรม
CREATE INDEX IF NOT EXISTS idx_prescriptions_patient 
    ON pharmacy_system.prescriptions(patient_id);

CREATE INDEX IF NOT EXISTS idx_prescription_items_prescription 
    ON pharmacy_system.prescription_items(prescription_id);

-- 5. Indexes สำหรับโมดูล H6: ผู้ป่วยในและเตียง
CREATE INDEX IF NOT EXISTS idx_admissions_patient 
    ON ipd_system.admissions(patient_id);

CREATE INDEX IF NOT EXISTS idx_admissions_bed 
    ON ipd_system.admissions(bed_id);

CREATE INDEX IF NOT EXISTS idx_admissions_dates 
    ON ipd_system.admissions(admission_date, discharge_date);

CREATE INDEX IF NOT EXISTS idx_transfers_admission 
    ON ipd_system.bed_transfers(admission_id);

-- 6. Indexes สำหรับโมดูล H3: การเงิน
CREATE INDEX IF NOT EXISTS idx_invoices_patient 
    ON billing_system.invoices(patient_id);

CREATE INDEX IF NOT EXISTS idx_invoices_date 
    ON billing_system.invoices(invoice_date);

CREATE INDEX IF NOT EXISTS idx_invoices_status 
    ON billing_system.invoices(payment_status);
