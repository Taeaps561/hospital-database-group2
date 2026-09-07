# 👨‍⚕️ H7_staff_personnel: ระบบบริหารบุคลากรทางการแพทย์และเจ้าหน้าที่ (Hospital Staff & Personnel System)

โมดูล **H7** รับผิดชอบการเป็นฐานข้อมูลหลัก (Master Data Provider) สำหรับทรัพยากรบุคคลทั้งหมดในโรงพยาบาล รวมถึงแพทย์ พยาบาล เภสัชกร นักเทคนิคการแพทย์ และเจ้าหน้าที่ฝ่ายสนับสนุน

---

## 📁 โครงสร้างไฟล์ภายในโมดูล
* [**`h7_staff_personnel_standalone.sql`**](./h7_staff_personnel_standalone.sql): โค้ด DDL และ DML สำหรับรันระบบ H7 แบบสแตนด์อโลน (22 ตาราง พร้อม Constraints & Indexes)
* [**`H7_ER_DIAGRAM.md`**](./H7_ER_DIAGRAM.md): แผนภาพ Entity-Relationship Diagram ฉบับสมบูรณ์ (Mermaid Architecture) และคำอธิบาย 3NF
* [**`VIDEO_PRESENTATION_SCRIPT.md`**](./VIDEO_PRESENTATION_SCRIPT.md): บทพูดสำหรับอัดคลิปวิดีโอนำเสนอผลงานรายบุคคลความยาว 2-3 นาที

---

## 🔗 จุดเชื่อมโยงกับระบบอื่นในโรงพยาบาล (Inter-system Foreign Keys)
1. **โมดูล H6 (ผู้ป่วยในและวอร์ด):**
   * ตาราง `ipd_system.admissions` อ้างอิงแพทย์เจ้าของไข้ `attending_doctor_id` มายัง `staff_system.doctors(doctor_id)`
   * ตาราง `ipd_system.wards` อ้างอิงหัวหน้าพยาบาลประจำวอร์ด `head_nurse_id` มายัง `staff_system.employees(employee_id)`
   * ตาราง `ipd_system.wards` อ้างอิงแผนก `department_id` มายัง `staff_system.departments(department_id)`
2. **โมดูล H2 (นัดหมาย/OPD):**
   * `opd_system.appointments(doctor_id)` อ้างอิงแพทย์ผู้ออกตรวจ
   * `opd_system.clinical_records(doctor_id)` อ้างอิงแพทย์ผู้บันทึกการรักษา
3. **โมดูล H4 (เภสัชกรรม):**
   * `pharmacy_system.prescriptions(doctor_id)` อ้างอิงแพทย์ผู้สั่งจ่ายยา
4. **โมดูล H5 (ห้องแล็บ):**
   * `lab_system.lab_orders(doctor_id)` อ้างอิงแพทย์ผู้สั่งตรวจทางห้องปฏิบัติการ

---

## 🛡️ มาตรการความปลอดภัยและการคุ้มครองข้อมูลส่วนบุคคล (PDPA)
* **RBAC (Role-Based Access Control):** แยกบทบาท `hr_manager_role`, `doctor_role`, `nurse_ward_role` เพื่อจำกัดการเข้าถึงข้อมูลตาม Least Privilege
* **Data Classification:**
  * **Public:** ชื่อแพทย์, แผนก, ตำแหน่ง, ความเชี่ยวชาญ
  * **Internal:** ตารางเวร, บันทึกการเข้างาน, คำขอลา
  * **Confidential:** เลขประจำตัวประชาชน 13 หลัก, เบอร์โทรศัพท์, ที่อยู่, ผู้ติดต่อฉุกเฉิน
  * **Sensitive:** รหัสผ่านแฮช (bcrypt), ข้อมูลเงินเดือนและรายการรับ-หัก (`payroll`)
