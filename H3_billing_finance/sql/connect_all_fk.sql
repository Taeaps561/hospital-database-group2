-- ==============================================================================
-- ADD_ALL_MISSING_FOREIGN_KEYS.SQL
-- รันคำสั่งนี้เพื่อผูกเส้น Foreign Key ให้ครบทุกระบบใน Schema u68001
-- ==============================================================================

SET search_path TO u68001, public;

-- 1. H1 ทะเบียนผู้ป่วย เชื่อมโยงภายใน
ALTER TABLE u68001.patients
    DROP CONSTRAINT IF EXISTS fk_patients_province,
    ADD CONSTRAINT fk_patients_province FOREIGN KEY (province_id) REFERENCES u68001.provinces(province_id) ON DELETE RESTRICT;

ALTER TABLE u68001.patient_contacts
    DROP CONSTRAINT IF EXISTS fk_contacts_patient,
    ADD CONSTRAINT fk_contacts_patient FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE;

ALTER TABLE u68001.patient_insurance_policies
    DROP CONSTRAINT IF EXISTS fk_policies_patient,
    ADD CONSTRAINT fk_policies_patient FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE,
    DROP CONSTRAINT IF EXISTS fk_policies_provider,
    ADD CONSTRAINT fk_policies_provider FOREIGN KEY (provider_id) REFERENCES u68001.insurance_providers(provider_id) ON DELETE RESTRICT;

-- 2. H4 เภสัชกรรม (ใบสั่งยา และ รายการยา)
ALTER TABLE u68001.prescription_items
    DROP CONSTRAINT IF EXISTS fk_items_prescription,
    ADD CONSTRAINT fk_items_prescription FOREIGN KEY (prescription_id) REFERENCES u68001.prescriptions(prescription_id) ON DELETE CASCADE,
    DROP CONSTRAINT IF EXISTS fk_items_medication,
    ADD CONSTRAINT fk_items_medication FOREIGN KEY (medication_id) REFERENCES u68001.medications(medication_id) ON DELETE RESTRICT;

-- 3. H5 ห้องแล็บ (ผลตรวจแล็บ)
ALTER TABLE u68001.lab_results
    DROP CONSTRAINT IF EXISTS fk_results_order,
    ADD CONSTRAINT fk_results_order FOREIGN KEY (order_id) REFERENCES u68001.lab_orders(order_id) ON DELETE CASCADE;

-- 4. H6 ผู้ป่วยใน (วอร์ด และ เตียง)
ALTER TABLE u68001.beds
    DROP CONSTRAINT IF EXISTS fk_beds_ward,
    ADD CONSTRAINT fk_beds_ward FOREIGN KEY (ward_id) REFERENCES u68001.wards(ward_id) ON DELETE RESTRICT;

-- 5. H2 OPD การตรวจวินิจฉัยโรค
ALTER TABLE u68001.clinical_records
    DROP CONSTRAINT IF EXISTS fk_records_patient,
    ADD CONSTRAINT fk_records_patient FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE,
    DROP CONSTRAINT IF EXISTS fk_records_diagnosis,
    ADD CONSTRAINT fk_records_diagnosis FOREIGN KEY (diagnosis_id) REFERENCES u68001.diagnoses(diagnosis_id) ON DELETE RESTRICT;

-- 6. H3 การเงิน (ผูก h3_invoices ข้ามระบบไปยัง H1, H2, H6)
ALTER TABLE u68001.h3_invoices
    DROP CONSTRAINT IF EXISTS fk_h3_invoices_patient,
    ADD CONSTRAINT fk_h3_invoices_patient FOREIGN KEY (patient_id) REFERENCES u68001.patients(patient_id) ON DELETE CASCADE,
    DROP CONSTRAINT IF EXISTS fk_h3_invoices_policy,
    ADD CONSTRAINT fk_h3_invoices_policy FOREIGN KEY (policy_id) REFERENCES u68001.patient_insurance_policies(policy_id) ON DELETE SET NULL;
