# 🏥 Enterprise Hospital Information System v2 (HIS v2)
## ฐานข้อมูลกลางระบบสารสนเทศโรงพยาบาลระดับองค์กร — กลุ่มที่ 2

โครงการบูรณาการและรวมระบบฐานข้อมูลโรงพยาบาล (Hospital Information System Consolidation) จาก 7 ระบบย่อย (H1 - H7) ให้เป็นฐานข้อมูลเชิงสัมพันธ์ระดับองค์กรที่เป็นหนึ่งเดียว ภายใต้มาตรฐาน **3NF (Third Normal Form)**, สอดคล้องกับพระราชบัญญัติคุ้มครองข้อมูลส่วนบุคคล (PDPA) และรองรับข้อกำหนดการเปลี่ยนแปลงระบบ (Change Cards H01 - H06)

---

### 👥 สมาชิกและการแบ่งความรับผิดชอบระบบย่อย (Subsystem Matrix)

| รหัสระบบ | ชื่อระบบย่อย | ข้อมูลหลักของระบบ | ผู้รับผิดชอบ | สถานะการพัฒนา |
| :---: | :--- | :--- | :---: | :---: |
| **H1** | **ทะเบียนผู้ป่วย (Patient Registration)** | ผู้ป่วย, ที่อยู่/ช่องทางติดต่อ, สิทธิการรักษา | สมาชิก H1 | ✅ เสร็จสมบูรณ์ (Base) |
| **H2** | **นัดหมาย/OPD (Appointments & OPD)** | นัดหมาย, การเข้ารับบริการ, การตรวจรักษา | สมาชิก H2 | 🔄 Ready for Integration |
| **H3** | **การเงิน (Billing & Accounts)** | ใบแจ้งหนี้, รายการค่าใช้จ่าย, การชำระเงิน | สมาชิก H3 | ✅ อัปเดตงานแล้ว |
| **H4** | **เภสัชกรรม (Pharmacy & Medications)** | ยา, ใบสั่งยา, การจ่ายยา, คลังยา | สมาชิก H4 | 🔄 Ready for Integration |
| **H5** | **ห้องแล็บ (Laboratory System)** | คำสั่งตรวจ, ตัวอย่าง, ผลตรวจแล็บ | สมาชิก H5 | 🔄 Ready for Integration |
| **H6** | **ผู้ป่วยใน/วอร์ด (Inpatient & Wards)** | Admit, เตียง, วอร์ด, การย้าย, การจำหน่าย | สมาชิก H6 | ✅ อัปเดตงานแล้ว |
| **H7** | **บุคลากร (Staff & Personnel)** | แพทย์, พยาบาล, เภสัชกร, เจ้าหน้าที่ | สมาชิก H7 | ✅ อัปเดตงานแล้ว |

---

### 🔄 3 กระบวนการกลางที่ต้องทำงานได้ (Core Clinical Workflows)

1. **กระบวนการที่ 1: ผู้ป่วยนอก (OPD Workflow)**
   $$\text{ผู้ป่วย (H1)} \rightarrow \text{นัดหมาย (H2)} \rightarrow \text{พบแพทย์ (H7)} \rightarrow \text{สั่งตรวจแล็บ (H5)} \rightarrow \text{สั่งยา (H4)} \rightarrow \text{คิดค่าใช้จ่าย (H3)} \rightarrow \text{ชำระเงิน (H3/สิทธิ H1)}$$
2. **กระบวนการที่ 2: ผู้ป่วยใน (IPD Workflow)**
   $$\text{ผู้ป่วย (H1)} \rightarrow \text{รับเข้า รพ. Admit (H6)} \rightarrow \text{จัดวอร์ด/เตียง (H6)} \rightarrow \text{ตรวจรักษา (H7)} \rightarrow \text{สั่งยา/แล็บ (H4/H5)} \rightarrow \text{จำหน่าย (H6)} \rightarrow \text{สรุปค่าใช้จ่าย (H3)}$$
3. **กระบวนการที่ 3: การตรวจสอบย้อนหลัง (Audit & Traceability 360°)**
   ค้นหาจาก `patient_id` หนึ่งคน แล้วสามารถแสดงประวัติการรับบริการ, แพทย์ผู้ตรวจ, ผลแล็บ, ประวัติยา, ประวัตินอนโรงพยาบาล และสถานะการเงินได้ครบวงจร

---

### 📁 โครงสร้างโปรเจกต์ (Project Structure)

```text
hospital-database-group2/
├── README.md                           <-- เอกสารภาพรวมโครงการและการติดตั้ง
├── CONTRIBUTING.md                     <-- คู่มือการแตก Branch และส่ง Pull Request สำหรับสมาชิก
├── .gitignore                          <-- การตั้งค่าไฟล์ที่ไม่นำเข้า Git
│
├── 01_ER_DIAGRAM/                      <-- งานที่ 3: แผนภาพ ER Diagram กลาง
│   ├── H1_patient_er.png               <-- 1. ER Diagram ระบบย่อย H1 (ทะเบียนผู้ป่วย)
│   ├── hospital_er_unadjusted.png      <-- 2. ER Diagram รวมก่อนปรับปรุง (ชี้จุดบกพร่อง/ซ้ำซ้อน)
│   ├── hospital_er_consolidated_3nf.png<-- 3. ER Diagram ฉบับสมบูรณ์ (3NF + Associative Entities)
│   └── ER_CONSOLIDATION_REPORT.pdf     <-- 4. เล่มรายงานอธิบายสิ่งที่แก้ไขจากการรวมระบบ
│
└── 02_DATABASE_SCRIPTS/                <-- งานที่ 4: รวม SQL เป็นฐานข้อมูลเดียว (10 สคริปต์)
    ├── 01_create_database.sql          <-- 1. สร้าง Database กลาง (hospital_enterprise_db)
    ├── 02_create_schema.sql            <-- 2. สร้าง Schema แยกตามระบบย่อย
    ├── 03_create_tables.sql            <-- 3. รวมคำสั่ง CREATE TABLE พร้อม PK ของทุกระบบ
    ├── 04_create_constraints.sql       <-- 4. รวม Foreign Keys เชื่อมข้ามระบบ และ Constraints
    ├── 05_create_indexes.sql           <-- 5. สร้าง Index เพื่อเพิ่มความเร็วในการสืบค้น
    ├── 06_create_roles.sql             <-- 6. สร้าง Database Roles ตามบทบาทหน้าที่
    ├── 07_grant_permissions.sql        <-- 7. กำหนดสิทธิ์ตามหลัก Least Privilege
    ├── 08_insert_sample_data.sql       <-- 8. ข้อมูลตัวอย่างทดสอบ 3 กระบวนการกลาง
    ├── 09_views_reports.sql            <-- 9. Views สำหรับรายงาน OPD, IPD และ Traceability
    └── 10_test_queries.sql             <-- 10. Query ทดสอบระบบ และ Test Cases
```

---

### ⚙️ ขั้นตอนการรันฐานข้อมูล (Execution Guide)

เปิดโปรแกรม **Command Prompt** หรือ **PowerShell** แล้วรันคำสั่งตามลำดับดังนี้:

```bash
# 1. เชื่อมต่อ PostgreSQL และสร้างฐานข้อมูล
psql -U postgres -f 02_DATABASE_SCRIPTS/01_create_database.sql

# 2. รันสคริปต์ที่เหลือเข้าสู่ฐานข้อมูล hospital_enterprise_db
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/02_create_schema.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/03_create_tables.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/04_create_constraints.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/05_create_indexes.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/06_create_roles.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/07_grant_permissions.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/08_insert_sample_data.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/09_views_reports.sql
psql -U postgres -d hospital_enterprise_db -f 02_DATABASE_SCRIPTS/10_test_queries.sql
```

---

### 📌 กฎและข้อตกลงมาตรฐานร่วมกัน (Standard Conventions)
1. **Primary Key**: ใช้ชื่อฟอร์แมตระบุ Entity ชัดเจน เช่น `patient_id`, `doctor_id`, `invoice_id`
2. **วันที่และเวลา**: วันที่ใช้ประเภท `DATE`, วันเวลาบันทึกระดับวินาทีใช้ `TIMESTAMP`
3. **จำนวนเงิน**: วงเงินและยอดค่าใช้จ่ายทั้งหมดต้องใช้ประเภท `NUMERIC(12,2)`
4. **ห้ามเก็บข้อมูลซ้ำซ้อน**: ห้ามระบบ H2 - H7 เก็บชื่อ-นามสกุลคนไข้ หรือเบอร์โทรซ้ำ โดยเด็ดขาด ให้ดึงผ่าน `patient_id` จากโมดูล H1 เท่านั้น
