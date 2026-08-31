# 📁 พื้นที่ส่งงาน: H6: ระบบผู้ป่วยในและหอผู้ป่วย (Inpatient & Wards)
**ผู้รับผิดชอบ:** วริศรา (สมาชิก H6)  
**ขอบเขตข้อมูลหลัก:** Admit เตียง วอร์ด การย้าย การจำหน่าย (เชื่อมต่อ H1, H3, H4, H5, H7)  

---

### 📦 รายการไฟล์สำหรับส่งงานของระบบนี้ (Individual Submission Checklist):

ตามข้อกำหนดของอาจารย์ในโครงงานบูรณาการฐานข้อมูล สมาชิกแต่ละคนต้องมีไฟล์ส่งมอบในโฟลเดอร์นี้ดังต่อไปนี้:

1. 📄 **`SUBSYSTEM_ANALYSIS_<รหัสนักศึกษา>.pdf`**: เอกสารวิเคราะห์ระบบย่อยก่อนรวม (งานที่ 1 ครบ 7 หัวข้อ)
2. 📊 **`er_diagram.png`**: แผนภาพ ER Diagram ของระบบย่อยตนเองตามมาตรฐาน 3NF
3. 💾 **`01_tables_and_constraints.sql`**: สคริปต์ DDL สร้างตาราง, Primary Key, และ Foreign Key เชื่อมโยงข้ามระบบ
4. 📝 **`02_queries_and_tests.sql`**: คำสั่ง SQL Query อย่างน้อย 2 ข้อ และ Test Cases ตรวจสอบความถูกต้องอย่างน้อย 2 กรณี
5. 🧪 **`03_sample_data.sql`**: ข้อมูลตัวอย่างทดสอบที่เชื่อมโยงกับระบบอื่นได้จริง

---

### 🔗 จุดเชื่อมโยงสำคัญ (Integration Endpoints):
* **ผู้ป่วยกลาง (H1):** เชื่อมโยงผ่าน `patient_system.patients(patient_id)` (VARCHAR)
* **แพทย์กลาง (H7):** เชื่อมโยงผ่าน `staff_system.doctors(doctor_id)` (VARCHAR)
* **สิทธิประกัน (H1):** เชื่อมโยงผ่าน `patient_system.patient_insurance_policies(policy_id)` (INT)
* **สาขาโรงพยาบาล (H1):** เชื่อมโยงผ่าน `patient_system.hospital_branches(branch_id)` (VARCHAR)

---
*Enterprise Hospital Database Group 2 Integration Project*
