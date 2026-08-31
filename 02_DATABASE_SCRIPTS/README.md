# 02_DATABASE_SCRIPTS: สคริปต์รวมฐานข้อมูลกลาง (Hospital Enterprise DB v2)

โฟลเดอร์นี้รวบรวม **10 สคริปต์ SQL รวมกลาง** ตามข้อกำหนดของอาจารย์ใน **"งานที่ 4: รวม SQL เป็นฐานข้อมูลเดียว"** รองรับการทำงานบูรณาการครบทั้ง 7 ระบบย่อย (H1 ถึง H7)

---

## 📑 สรุปรายชื่อ 10 สคริปต์ SQL และหน้าที่การทำงาน

| ลำดับไฟล์ | ชื่อไฟล์สคริปต์ | หน้าที่การทำงานตามข้อกำหนดอาจารย์ | สถานะการรัน |
| :---: | :--- | :--- | :---: |
| **01** | `01_create_database.sql` | สร้างฐานข้อมูลกลาง `hospital_enterprise_db` เข้ารหัส `UTF8` | ✅ ผ่าน 100% |
| **02** | `02_create_schema.sql` | สร้าง 6 Schemas แยกความรับผิดชอบ: `patient_system`, `opd_system`, `billing_system`, `pharmacy_system`, `lab_system`, `ipd_system`, `staff_system` | ✅ ผ่าน 100% |
| **03** | `03_create_tables.sql` | สร้างตารางและ Primary Key ครบทุกโมดูล H1-H7 (ไม่มีตารางซ้ำซ้อน) | ✅ ผ่าน 100% |
| **04** | `04_create_constraints.sql` | สร้าง Foreign Keys เชื่อมข้ามระบบ (โดยมี H1 เป็นศูนย์กลาง) และ CHECK Constraints | ✅ ผ่าน 100% |
| **05** | `05_create_indexes.sql` | สร้าง B-Tree Indexes สำหรับคอลัมน์ที่ใช้ค้นหาและ JOIN บ่อย | ✅ ผ่าน 100% |
| **06** | `06_create_roles.sql` | สร้าง Database Roles ตามบทบาทหน้าที่ของบุคลากร (RBAC) | ✅ ผ่าน 100% |
| **07** | `07_grant_permissions.sql` | กำหนดสิทธิ์ Least Privilege ให้แต่ละ Role อย่างปลอดภัย | ✅ ผ่าน 100% |
| **08** | `08_insert_sample_data.sql` | ใส่ข้อมูลตัวอย่างเชื่อมโยงจริงครบทุกโมดูล H1 ถึง H7 | ✅ ผ่าน 100% |
| **09** | `09_views_reports.sql` | สร้าง View รายงานสำหรับ 3 กระบวนการกลาง: OPD, IPD, และ Audit 360° | ✅ ผ่าน 100% |
| **10** | `10_test_queries.sql` | คำสั่งทดสอบ 3 กระบวนการกลาง และ Test Cases รายบุคคล | ✅ ผ่าน 100% |

---

## 🚀 วิธีการรันคำสั่งทั้งหมดบน PostgreSQL

### รันผ่าน psql Terminal:
```bash
# 1. สร้างฐานข้อมูล
psql -h localhost -p 5433 -U postgres -d postgres -f 01_create_database.sql

# 2. รันสคริปต์ที่เหลือตามลำดับ
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 02_create_schema.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 03_create_tables.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 04_create_constraints.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 05_create_indexes.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 06_create_roles.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 07_grant_permissions.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 08_insert_sample_data.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 09_views_reports.sql
psql -h localhost -p 5433 -U postgres -d hospital_enterprise_db -f 10_test_queries.sql
```

---
*จัดทำและทดสอบโดย: กลุ่มที่ 2 — Enterprise Hospital Database Project*
