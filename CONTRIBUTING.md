# 🤝 คู่มือการมีส่วนร่วมและส่งงานรวมระบบ (Contribution & Git Guide)
## สำหรับสมาชิกกลุ่มที่ 2: ระบบสารสนเทศโรงพยาบาล (Enterprise HIS v2)

เอกสารฉบับนี้จัดทำขึ้นเพื่อกำหนดขั้นตอนมาตรฐานในการนำส่งโค้ด SQL และแผนภาพฐานข้อมูลของระบบย่อย (H1 ถึง H7) โดยใช้ **GitHub Workflow (Branch & Pull Request)** เพื่อให้มีประวัติการ Commit รายบุคคลที่ถูกต้องตามเกณฑ์การประเมินของอาจารย์

---

### 📋 กฎการตั้งชื่อ Branch รายบุคคล

ห้ามทำการ Push โค้ดตรงเข้าสู่ Branch `main` โดยเด็ดขาด ให้แตก Branch ย่อยตามระบบย่อยที่ตนเองรับผิดชอบ:

* **H1 (ทะเบียนผู้ป่วย)**: `feature/H1-patient-registration` *(สมาชิก H1)*
* **H2 (นัดหมาย/OPD)**: `feature/H2-appointments-opd`
* **H3 (การเงิน)**: `feature/H3-billing-finance`
* **H4 (เภสัชกรรม)**: `feature/H4-pharmacy`
* **H5 (ห้องแล็บ)**: `feature/H5-laboratory`
* **H6 (ผู้ป่วยใน/วอร์ด)**: `feature/H6-inpatient-ward`
* **H7 (บุคลากร)**: `feature/H7-staff-personnel`

---

### 💻 ขั้นตอนการทำงาน (Step-by-Step Git Commands)

#### 1. Clone โปรเจกต์ลงเครื่องตนเอง
```bash
git clone https://github.com/TaeAphisit/hospital-database-group2.git
cd hospital-database-group2
```

#### 2. แตก Branch ของตนเอง
```bash
# ตัวอย่าง: สำหรับสมาชิก H2
git checkout -b feature/H2-appointments-opd
```

#### 3. แก้ไขไฟล์ตามข้อกำหนดที่แบ่งความรับผิดชอบ
สมาชิกแต่ละคนต้องแก้ไขโค้ดในสคริปต์ที่กำหนดไว้ โดยมองหาบล็อก Comment ประจำระบบตนเอง เช่น:
* `02_DATABASE_SCRIPTS/03_create_tables.sql` ➔ ใส่คำสั่ง `CREATE TABLE` ของระบบตนเอง (พร้อม Primary Key)
* `02_DATABASE_SCRIPTS/04_create_constraints.sql` ➔ ใส่คำสั่ง `ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY` เชื่อมโยงไปยัง `patient_id` ของ H1 หรือ Entity อื่นๆ
* `02_DATABASE_SCRIPTS/06_create_roles.sql` & `07_grant_permissions.sql` ➔ กำหนด Role และสิทธิ์ของตนเอง
* `02_DATABASE_SCRIPTS/08_insert_sample_data.sql` ➔ หยอดข้อมูลทดสอบของระบบตนเอง
* `02_DATABASE_SCRIPTS/10_test_queries.sql` ➔ เพิ่ม Query ทดสอบอย่างน้อย 2 ข้อ และ Test Cases

#### 4. บันทึกและ Commit งานด้วยบัญชีของตนเอง
```bash
git add .
git commit -m "feat(H2): Add appointment tables, foreign keys, and test queries"
```

#### 5. Push Branch ขึ้น GitHub
```bash
git push origin feature/H2-appointments-opd
```

#### 6. เปิด Pull Request (PR)
1. ไปที่หน้า Repository บน GitHub
2. กดปุ่ม **"Compare & pull request"**
3. ตั้งชื่อ PR: `[H2] Integrate Appointments and OPD Module`
4. ระบุรายละเอียดสิ่งที่เพิ่มลงในกล่องข้อความ และกดส่ง Pull Request
5. Maintainer (สมาชิก H1) จะทำการตรวจทานความถูกต้อง (Review) ก่อน Merge เข้าสู่ `main`

---

### ⚠️ ข้อควรระวังเชิงเทคนิค
1. **อย่าลบหรือแก้ไขโครงสร้างของ H1**: เนื่องจากระบบ H1 เป็น Central Single Source of Truth ที่ระบบอื่นต้องอ้างอิง Foreign Key
2. **การตั้งชื่อ Foreign Key**: ต้องอ้างอิงรหัสผู้ป่วย `patient_id` ให้ตรงชนิดข้อมูล (`VARCHAR(50)`)
3. **การทดสอบก่อนส่ง**: ตรวจสอบให้แน่ใจว่าสคริปต์ของตนเองสามารถรันบน PostgreSQL ได้โดยไม่เกิด Syntax Error
