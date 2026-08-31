# 📁 โฟลเดอร์งานของโมดูล H1: ระบบทะเบียนผู้ป่วย (Patient Registration System)
**ผู้รับผิดชอบ:** นายอภิสิทธิ์ ศรีพัฒน์ (รหัสนักศึกษา **6811011662010**)
**สถานะ:** ✅ เสร็จสมบูรณ์ (Master Reference สำหรับเพื่อน H2 - H7)

---

### 📄 เอกสารและไฟล์ที่ส่งมอบในโมดูล H1:
1. **`SUBSYSTEM_ANALYSIS_6811011662010.pdf`**: รายงานวิเคราะห์ระบบย่อยก่อนรวม (งานที่ 1 ครบ 7 หัวข้อ)
2. **`DATA_DICTIONARY_H1_6811011662010.pdf`**: พจนานุกรมข้อมูลกลางของ H1 (งานที่ 2 ครบ 10 คอลัมน์)
3. **`er_diagram.png`**: แผนภาพ ER Diagram ของโมดูล H1 ตามมาตรฐาน 3NF
4. **`01_tables.sql`**: สคริปต์สร้างตารางของ H1
5. **`02_foreign_keys.sql`**: สคริปต์ Constraints และความสัมพันธ์
6. **`03_sample_data.sql`**: ข้อมูลตัวอย่างทดสอบของ H1
7. **`04_queries_and_tests.sql`**: Query 2 ข้อ และ Test Cases 2 กรณี

---

### 📌 ข้อมูลที่ระบบอื่น (H2 - H7) ต้องใช้เชื่อมต่อกับ H1:
* **Primary Key ผู้ป่วย:** `patient_system.patients(patient_id)` (ชนิดข้อมูล: `VARCHAR(50)`)
* **Foreign Key สิทธิประกันสุขภาพ:** `patient_system.patient_insurance_policies(policy_id)` (ชนิดข้อมูล: `INT`)
* **Foreign Key สาขาโรงพยาบาล:** `patient_system.hospital_branches(branch_id)` (ชนิดข้อมูล: `VARCHAR(50)`)
