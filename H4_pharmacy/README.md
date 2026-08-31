# 📁 โฟลเดอร์งานของโมดูล H4: ระบบเภสัชกรรมและคลังยา (Pharmacy & Medications)
**ผู้รับผิดชอบ:** สมาชิก H4

---

### 📋 สิ่งที่สมาชิก H4 ต้องอัปโหลดลงในโฟลเดอร์นี้:
ให้แตก Branch ของตนเอง (เช่น `feature/H4-pharmacy`) แล้วอัปโหลดไฟล์ของระบบตนเองเข้ามาที่โฟลเดอร์นี้:

1. **`01_tables.sql`**: คำสั่ง `CREATE TABLE` ในระบบย่อย H4 (เช่น `medications`, `prescriptions`, `prescription_items` พร้อม Primary Key ทุกตาราง)
2. **`02_foreign_keys.sql`**: คำสั่ง Foreign Key ที่เชื่อมโยงข้ามระบบ:
   - เชื่อมผู้ป่วย: `FOREIGN KEY (patient_id) REFERENCES patient_system.patients(patient_id)`
   - เชื่อมแพทย์ผู้สั่งยา: `FOREIGN KEY (doctor_id) REFERENCES staff_system.doctors(doctor_id)`
3. **`03_sample_data.sql`**: ข้อมูลตัวอย่างยาและใบสั่งยา
4. **`04_queries_and_tests.sql`**:
   - Query อย่างน้อย 2 ข้อ
   - Test Case อย่างน้อย 2 กรณี
   - Role และสิทธิ์ที่เกี่ยวข้อง
5. **`er_diagram.png`**: ภาพ ER Diagram ระบบย่อย H4
6. **`SUBSYSTEM_ANALYSIS_รหัสนักศึกษา.pdf`**: รายงานวิเคราะห์ระบบย่อย 7 หัวข้อ (งานที่ 1)

---
💡 *ดูตัวอย่างรูปแบบไฟล์ที่สมบูรณ์ได้จากโฟลเดอร์ `H1_patient_registration/`*
