# 📊 01_ER_DIAGRAM: โครงสร้าง ER Diagram กลาง (Enterprise Hospital Database Group 2)

โฟลเดอร์นี้รวบรวมแผนภาพและเอกสารรายงาน **งานที่ 3: การสร้าง ER Diagram กลาง** สำหรับระบบฐานข้อมูลโรงพยาบาลระดับองค์กร (Enterprise Hospital Information System v2)

---

## 📑 รายการเอกสารและแผนภาพ (Group Deliverables)

| ชื่อไฟล์ | ประเภท | คำอธิบาย |
| :--- | :---: | :--- |
| [**`ER_CONSOLIDATION_REPORT.pdf`**](./ER_CONSOLIDATION_REPORT.pdf) | 📄 PDF Report | รายงานสรุปผลการบูรณาการระบบ, ตาราง Integration Matrix, และคำอธิบายการปรับปรุงโครงสร้างตามหลัก 3NF |
| [**`hospital_er_unadjusted.png`**](./hospital_er_unadjusted.png) | 🖼️ Diagram | แผนภาพ ER Diagram ฉบับรวมก่อนปรับปรุง (BEFORE) แสดงข้อผิดพลาดทางสถาปัตยกรรม (Data Silos, Data Redundancy, M:N) |
| [**`hospital_er_consolidated_3nf.png`**](./hospital_er_consolidated_3nf.png) | 🖼️ Diagram | แผนภาพ ER Diagram กลางฉบับสมบูรณ์ (AFTER) ผ่านการ Normalization 3NF และแก้ปัญหา M:N ด้วย Associative Entities |
| [**`unadjusted.html`**](./unadjusted.html) | 🌐 Source | ซอร์สโค้ด SVG/HTML Layout สำหรับเรนเดอร์ภาพก่อนปรับปรุง |
| [**`consolidated.html`**](./consolidated.html) | 🌐 Source | ซอร์สโค้ด SVG/HTML Layout สำหรับเรนเดอร์ภาพฉบับสมบูรณ์ 3NF |
| [**`er_consolidation_report.html`**](./er_consolidation_report.html) | 🌐 Web Report | รายงานฉบับเว็บ HTML เต็มรูปแบบ |

---

## 🏥 ระบบย่อยที่บูรณาการ (Integrated Subsystems H1 – H7)

1. **H1: patient_system (ระบบทะเบียนผู้ป่วย)** — Single Source of Truth / Master Patient Index (MPI)
2. **H2: appointment_system (ระบบนัดหมาย OPD)** — คิวนัดหมายและแพทย์ผู้ตรวจ
3. **H3: billing_system (ระบบการเงิน & บัญชี)** — ใบแจ้งหนี้ การชำระเงิน และ Split Billing (H02)
4. **H4: pharmacy_system (ระบบยาและใบสั่งยา)** — ใบสั่งยา คลังยา และ Associative Entity (1NF)
5. **H5: lab_system (ระบบห้องปฏิบัติการ)** — ใบสั่งตรวจและผลแล็บพร้อม Clinical Traceability
6. **H6: inpatient_system (ระบบผู้ป่วยใน IPD & เตียง)** — Admission, Bed Transfer History (H03), และ Multi-Doctor Team (H01)
7. **H7: staff_system (ระบบบุคลากร & สิทธิ์การใช้งาน)** — ข้อมูลแพทย์ บุคลากร แผนก และระบบ Security/Roles

---

> 📌 **หมายเหตุ:** แผนภาพและเอกสารวิเคราะห์ระบบย่อยของสมาชิกแต่ละบุคคลจะถูกจัดเก็บแยกไว้ในโฟลเดอร์โมดูลของตนเอง (เช่น `H1_patient_registration/`, `H2_appointments_opd/`, ฯลฯ)
