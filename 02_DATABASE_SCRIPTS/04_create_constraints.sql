-- ==============================================================================
-- 04_create_constraints.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: กำหนด Foreign Keys เชื่อมข้ามระบบ (Inter-System FKs) และ Domain Constraints
--         โดยมี H1 (patient_id) เป็นศูนย์กลางการเชื่อมโยงข้อมูลผู้ป่วยทั้งโรงพยาบาล
-- ==============================================================================

\connect hospital_enterprise_db

-- ==============================================================================
-- 1. FOREIGN KEYS & CONSTRAINTS ภายในโมดูล H1: ทะเบียนผู้ป่วย
-- ==============================================================================

ALTER TABLE patient_system.hospital_branches
    ADD CONSTRAINT fk_branches_province
    FOREIGN KEY (province_id) REFERENCES patient_system.provinces(province_id)
    ON DELETE RESTRICT;

ALTER TABLE patient_system.patients
    ADD CONSTRAINT fk_patients_province
    FOREIGN KEY (province_id) REFERENCES patient_system.provinces(province_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_patients_branch
    FOREIGN KEY (registered_branch_id) REFERENCES patient_system.hospital_branches(branch_id)
    ON DELETE SET NULL,
    ADD CONSTRAINT chk_patients_gender
    CHECK (gender IN ('M', 'F', 'Other')),
    ADD CONSTRAINT chk_patients_birth_date
    CHECK (birth_date <= CURRENT_DATE),
    ADD CONSTRAINT chk_patients_blood_group
    CHECK (blood_group IN ('A', 'B', 'AB', 'O', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    ADD CONSTRAINT chk_patients_weight
    CHECK (weight_kg > 0.0 AND weight_kg < 300.0),
    ADD CONSTRAINT chk_patients_height
    CHECK (height_cm > 0.0 AND height_cm < 250.0),
    ADD CONSTRAINT chk_patients_status
    CHECK (patient_status IN ('Active', 'Inactive', 'Transferred', 'Deceased'));

ALTER TABLE patient_system.patient_contacts
    ADD CONSTRAINT fk_contacts_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT chk_contact_type
    CHECK (contact_type IN ('Phone', 'Email'));

ALTER TABLE patient_system.patient_insurance_policies
    ADD CONSTRAINT fk_policies_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_policies_provider
    FOREIGN KEY (provider_id) REFERENCES patient_system.insurance_providers(provider_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT chk_coverage_limit
    CHECK (coverage_limit >= 0.0);

ALTER TABLE patient_system.users_security
    ADD CONSTRAINT fk_users_role
    FOREIGN KEY (role_id) REFERENCES patient_system.roles(role_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_users_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE SET NULL,
    ADD CONSTRAINT chk_account_status
    CHECK (account_status IN ('Active', 'Locked', 'Suspended', 'Pending'));

ALTER TABLE patient_system.emergency_access_audit_log
    ADD CONSTRAINT fk_audit_user
    FOREIGN KEY (user_id) REFERENCES patient_system.users_security(user_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_audit_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE;


-- ==============================================================================
-- 2. FOREIGN KEYS เชื่อมโยงโมดูล H7: บุคลากร
-- ==============================================================================

ALTER TABLE staff_system.departments
    ADD CONSTRAINT fk_departments_branch
    FOREIGN KEY (branch_id) REFERENCES patient_system.hospital_branches(branch_id)
    ON DELETE RESTRICT;

ALTER TABLE staff_system.doctors
    ADD CONSTRAINT fk_doctors_department
    FOREIGN KEY (department_id) REFERENCES staff_system.departments(department_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT chk_doctors_salary
    CHECK (salary_thb >= 0.0);

-- เชื่อมต่อบัญชีความปลอดภัยผู้ใช้ไปยังแพทย์
ALTER TABLE patient_system.users_security
    ADD CONSTRAINT fk_users_doctor
    FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE SET NULL;


-- ==============================================================================
-- 3. FOREIGN KEYS เชื่อมโยงโมดูล H2: นัดหมาย/OPD (เชื่อมหา H1 และ H7)
-- ==============================================================================

ALTER TABLE opd_system.appointments
    ADD CONSTRAINT fk_appointments_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_appointments_doctor
    FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_appointments_branch
    FOREIGN KEY (branch_id) REFERENCES patient_system.hospital_branches(branch_id)
    ON DELETE RESTRICT;

ALTER TABLE opd_system.clinical_records
    ADD CONSTRAINT fk_clinical_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_clinical_doctor
    FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_clinical_diagnosis
    FOREIGN KEY (diagnosis_id) REFERENCES opd_system.diagnoses(diagnosis_id)
    ON DELETE RESTRICT;


-- ==============================================================================
-- 4. FOREIGN KEYS เชื่อมโยงโมดูล H5: ห้องแล็บ (เชื่อมหา H1 และ H7)
-- ==============================================================================

ALTER TABLE lab_system.lab_orders
    ADD CONSTRAINT fk_lab_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_lab_doctor
    FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE RESTRICT;

ALTER TABLE lab_system.lab_results
    ADD CONSTRAINT fk_lab_order
    FOREIGN KEY (order_id) REFERENCES lab_system.lab_orders(order_id)
    ON DELETE CASCADE;


-- ==============================================================================
-- 5. FOREIGN KEYS เชื่อมโยงโมดูล H4: เภสัชกรรม (เชื่อมหา H1 และ H7)
-- ==============================================================================

ALTER TABLE pharmacy_system.prescriptions
    ADD CONSTRAINT fk_prescriptions_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_prescriptions_doctor
    FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE RESTRICT;

ALTER TABLE pharmacy_system.prescription_items
    ADD CONSTRAINT fk_items_prescription
    FOREIGN KEY (prescription_id) REFERENCES pharmacy_system.prescriptions(prescription_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_items_medication
    FOREIGN KEY (medication_id) REFERENCES pharmacy_system.medications(medication_id)
    ON DELETE RESTRICT;


-- ==============================================================================
-- 6. FOREIGN KEYS เชื่อมโยงโมดูล H6: ผู้ป่วยในและวอร์ด (เชื่อมหา H1 และ H7)
-- ==============================================================================

ALTER TABLE ipd_system.wards
    ADD CONSTRAINT fk_wards_department
    FOREIGN KEY (department_id) REFERENCES staff_system.departments(department_id)
    ON DELETE RESTRICT;

ALTER TABLE ipd_system.beds
    ADD CONSTRAINT fk_beds_ward
    FOREIGN KEY (ward_id) REFERENCES ipd_system.wards(ward_id)
    ON DELETE RESTRICT;

ALTER TABLE ipd_system.admissions
    ADD CONSTRAINT fk_admissions_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_admissions_doctor
    FOREIGN KEY (attending_doctor_id) REFERENCES staff_system.doctors(doctor_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_admissions_bed
    FOREIGN KEY (bed_id) REFERENCES ipd_system.beds(bed_id)
    ON DELETE RESTRICT;

ALTER TABLE ipd_system.bed_transfers
    ADD CONSTRAINT fk_transfers_admission
    FOREIGN KEY (admission_id) REFERENCES ipd_system.admissions(admission_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_transfers_from_bed
    FOREIGN KEY (from_bed_id) REFERENCES ipd_system.beds(bed_id)
    ON DELETE RESTRICT,
    ADD CONSTRAINT fk_transfers_to_bed
    FOREIGN KEY (to_bed_id) REFERENCES ipd_system.beds(bed_id)
    ON DELETE RESTRICT;


-- ==============================================================================
-- 7. FOREIGN KEYS เชื่อมโยงโมดูล H3: การเงิน (เชื่อมหา H1 และสิทธิ์ประกัน H02)
-- ==============================================================================

ALTER TABLE billing_system.invoices
    ADD CONSTRAINT fk_invoices_patient
    FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_invoices_policy
    FOREIGN KEY (policy_id) REFERENCES patient_system.patient_insurance_policies(policy_id)
    ON DELETE SET NULL,
    ADD CONSTRAINT chk_invoices_amount
    CHECK (total_amount_thb >= 0.0 AND insurance_paid_thb >= 0.0 AND patient_paid_thb >= 0.0);
