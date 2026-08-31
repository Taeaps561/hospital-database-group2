-- ==============================================================================
-- 09_views_reports.sql
-- โครงการ: รวมระบบสารสนเทศโรงพยาบาล (Hospital Information System Integration v2)
-- ผู้รับผิดชอบ: กลุ่มที่ 2 — Enterprise Hospital Database
-- หน้าที่: สร้าง Views รายงานสำหรับ 3 กระบวนการกลางของโรงพยาบาลตามที่อาจารย์กำหนด
-- ==============================================================================

\connect hospital_enterprise_db

-- ==============================================================================
-- 1. View สำหรับกระบวนการที่ 1: ผู้ป่วยนอก (OPD Clinical Journey View)
-- เส้นทาง: ผู้ป่วย (H1) ➔ นัดหมาย (H2) ➔ พบแพทย์ (H7) ➔ แล็บ (H5) ➔ ยา (H4) ➔ การเงิน (H3)
-- ==============================================================================
CREATE OR REPLACE VIEW opd_system.v_opd_patient_flow AS
SELECT 
    p.patient_id,
    p.title_prefix || p.first_name || ' ' || p.last_name AS patient_name,
    p.gender,
    EXTRACT(YEAR FROM AGE(p.birth_date)) AS age,
    apt.appointment_id,
    apt.appointment_date,
    d.doctor_name,
    dept.department_name,
    cr.record_date,
    diag.icd_code,
    diag.diagnosis_name,
    rx.prescription_id,
    inv.invoice_id,
    inv.total_amount_thb,
    inv.payment_status
FROM patient_system.patients p
LEFT JOIN opd_system.appointments apt ON p.patient_id = apt.patient_id
LEFT JOIN staff_system.doctors d ON apt.doctor_id = d.doctor_id
LEFT JOIN staff_system.departments dept ON d.department_id = dept.department_id
LEFT JOIN opd_system.clinical_records cr ON p.patient_id = cr.patient_id
LEFT JOIN opd_system.diagnoses diag ON cr.diagnosis_id = diag.diagnosis_id
LEFT JOIN pharmacy_system.prescriptions rx ON p.patient_id = rx.patient_id
LEFT JOIN billing_system.invoices inv ON p.patient_id = inv.patient_id AND inv.service_type LIKE '%OPD%';


-- ==============================================================================
-- 2. View สำหรับกระบวนการที่ 2: ผู้ป่วยใน (IPD Clinical Journey View)
-- เส้นทาง: ผู้ป่วย (H1) ➔ รับเข้า Admit (H6) ➔ จัดวอร์ด/เตียง ➔ แพทย์ตรวจ (H7) ➔ จำหน่าย ➔ ค่าใช้จ่าย (H3)
-- ==============================================================================
CREATE OR REPLACE VIEW ipd_system.v_ipd_patient_flow AS
SELECT 
    adm.admission_id,
    p.patient_id,
    p.title_prefix || p.first_name || ' ' || p.last_name AS patient_name,
    p.blood_group,
    w.ward_name,
    b.room_number,
    b.bed_type,
    adm.admission_date,
    adm.discharge_date,
    adm.length_of_stay_days,
    d.doctor_name AS attending_physician,
    inv.invoice_id,
    inv.total_amount_thb,
    inv.insurance_paid_thb,
    inv.patient_paid_thb,
    inv.payment_status
FROM ipd_system.admissions adm
JOIN patient_system.patients p ON adm.patient_id = p.patient_id
JOIN ipd_system.beds b ON adm.bed_id = b.bed_id
JOIN ipd_system.wards w ON b.ward_id = w.ward_id
JOIN staff_system.doctors d ON adm.attending_doctor_id = d.doctor_id
LEFT JOIN billing_system.invoices inv ON adm.patient_id = inv.patient_id AND inv.service_reference = adm.admission_id;


-- ==============================================================================
-- 3. View สำหรับกระบวนการที่ 3: การตรวจสอบย้อนหลังแบบ 360 องศา (Audit & Traceability 360°)
-- ค้นหาผู้ป่วย 1 คน แล้วแสดงข้อมูลเชื่อมโยงทุกมิติทั้ง 7 ระบบ
-- ==============================================================================
CREATE OR REPLACE VIEW patient_system.v_patient_360_traceability AS
SELECT 
    p.patient_id,
    p.title_prefix || p.first_name || ' ' || p.last_name AS full_name,
    p.gender,
    p.birth_date,
    p.blood_group,
    prov.province_name,
    branch.branch_name AS registered_branch,
    pc.contact_value AS primary_phone,
    pol.policy_number,
    prov_ins.provider_name AS insurance_name,
    pol.coverage_limit,
    (SELECT COUNT(*) FROM opd_system.appointments WHERE patient_id = p.patient_id) AS total_appointments,
    (SELECT COUNT(*) FROM ipd_system.admissions WHERE patient_id = p.patient_id) AS total_admissions,
    (SELECT COUNT(*) FROM pharmacy_system.prescriptions WHERE patient_id = p.patient_id) AS total_prescriptions,
    (SELECT COUNT(*) FROM lab_system.lab_orders WHERE patient_id = p.patient_id) AS total_lab_orders,
    COALESCE((SELECT SUM(total_amount_thb) FROM billing_system.invoices WHERE patient_id = p.patient_id), 0.00) AS cumulative_billing_thb
FROM patient_system.patients p
LEFT JOIN patient_system.provinces prov ON p.province_id = prov.province_id
LEFT JOIN patient_system.hospital_branches branch ON p.registered_branch_id = branch.branch_id
LEFT JOIN patient_system.patient_contacts pc ON p.patient_id = pc.patient_id AND pc.is_primary = TRUE AND pc.contact_type = 'Phone'
LEFT JOIN patient_system.patient_insurance_policies pol ON p.patient_id = pol.patient_id
LEFT JOIN patient_system.insurance_providers prov_ins ON pol.provider_id = prov_ins.provider_id;
