# พจนานุกรมข้อมูลกลาง (Central Data Dictionary)
## ระบบสารสนเทศโรงพยาบาล: การบูรณาการโมดูล H7 (บุคลากร) และ H6 (ผู้ป่วยใน)
**โครงการ:** การบูรณาการฐานข้อมูลระดับองค์กร (Enterprise Database Integration Project)  
**โมดูล:** H7 (บุคลากรทางการแพทย์และเจ้าหน้าที่) & H6 (ผู้ป่วยในและหอผู้ป่วย)  
**มาตรฐานข้อมูล:** PostgreSQL 16+, 3NF Normalized, สอดคล้องกับมาตรฐานความปลอดภัยและ PDPA  

---

### 1. โครงสร้างตารางโมดูล H7: ระบบบริหารบุคลากรและแพทย์ (`staff_system`)

#### 1.1 ตาราง `staff_system.departments` (แผนกในโรงพยาบาล)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `departments` | `department_id` | VARCHAR | 50 | PK | NO | - | Primary Key | รหัสแผนก | H7 | Public |
| `departments` | `branch_id` | VARCHAR | 50 | FK | NO | - | REFERENCES hospital_branches | สาขา รพ. ที่สังกัด | H7 | Public |
| `departments` | `department_name`| VARCHAR | 100 | - | NO | - | - | ชื่อแผนกทางการแพทย์/สนับสนุน | H7 | Public |
| `departments` | `contact_number` | VARCHAR | 20 | - | YES | NULL | - | เบอร์โทรติดต่อภายในแผนก | H7 | Public |
| `departments` | `department_head_id`| VARCHAR | 50 | FK | YES | NULL | REFERENCES employees | รหัสพนักงานที่เป็นหัวหน้าแผนก | H7 | Internal |

---

#### 1.2 ตาราง `staff_system.positions` (ตำแหน่งงานและฐานเงินเดือน)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `positions` | `position_id` | SERIAL | - | PK | NO | Auto | Primary Key | รหัสตำแหน่งงาน | H7 | Internal |
| `positions` | `position_name` | VARCHAR | 100 | - | NO | - | UNIQUE | ชื่อตำแหน่งงาน | H7 | Public |
| `positions` | `base_salary` | NUMERIC | (12,2)| - | YES | NULL | CHECK (base_salary >= 0) | ฐานเงินเดือนมาตรฐานของตำแหน่ง | H7 | Confidential |

---

#### 1.3 ตาราง `staff_system.employees` (ข้อมูลบุคลากรและเจ้าหน้าที่หลัก)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `employees` | `employee_id` | VARCHAR | 50 | PK | NO | - | Primary Key (รองรับ UUID) | รหัสประจำตัวบุคลากร | H7 | Public |
| `employees` | `title_id` | INT | - | FK | YES | NULL | REFERENCES titles | คำนำหน้าชื่อ | H7 | Public |
| `employees` | `gender_id` | INT | - | FK | YES | NULL | REFERENCES genders | เพศ | H7 | Internal |
| `employees` | `first_name` | VARCHAR | 100 | - | NO | - | - | ชื่อจริงบุคลากร | H7 | Public |
| `employees` | `last_name` | VARCHAR | 100 | - | NO | - | - | นามสกุลบุคลากร | H7 | Public |
| `employees` | `national_id` | VARCHAR | 13 | - | YES | NULL | UNIQUE 13 หลัก | เลขประจำตัวประชาชน | H7 | Confidential |
| `employees` | `date_of_birth` | DATE | - | - | YES | NULL | - | วันเดือนปีเกิด | H7 | Confidential |
| `employees` | `hire_date` | DATE | - | - | YES | NULL | - | วันที่เริ่มเข้าทำงาน | H7 | Internal |
| `employees` | `department_id` | VARCHAR | 50 | FK | NO | - | REFERENCES departments | แผนกที่สังกัดปัจจุบัน | H7 | Public |
| `employees` | `position_id` | INT | - | FK | NO | - | REFERENCES positions | ตำแหน่งงานปัจจุบัน | H7 | Public |
| `employees` | `status` | VARCHAR | 20 | - | YES | 'active'| CHECK IN ('active', 'resigned', ...) | สถานะการทำงาน | H7 | Internal |
| `employees` | `phone` | VARCHAR | 20 | - | YES | NULL | - | หมายเลขโทรศัพท์ติดต่อ | H7 | Confidential |
| `employees` | `email` | VARCHAR | 150 | - | YES | NULL | UNIQUE | อีเมลประจำตัวบุคลากร | H7 | Public |
| `employees` | `address` | TEXT | - | - | YES | NULL | - | ที่อยู่ตามทะเบียนบ้าน/ที่พัก | H7 | Confidential |
| `employees` | `marital_status` | VARCHAR | 20 | - | YES | NULL | - | สถานภาพสมรส | H7 | Confidential |
| `employees` | `photo_url` | TEXT | - | - | YES | NULL | - | ลิงก์ไฟล์รูปภาพโปรไฟล์ | H7 | Public |

---

#### 1.4 ตาราง `staff_system.doctors` (ข้อมูลแพทย์และบริดจ์เชื่อมโยงระบบเดิม)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `doctors` | `doctor_id` | VARCHAR | 50 | PK | NO | - | Primary Key | รหัสแพทย์ที่ระบบอื่นอ้างอิง | H7 | Public |
| `doctors` | `employee_id` | VARCHAR | 50 | FK | YES | NULL | REFERENCES employees | รหัสพนักงานที่เชื่อมกับระบบกลาง | H7 | Internal |
| `doctors` | `department_id` | VARCHAR | 50 | FK | NO | - | REFERENCES departments | แผนกตรวจรักษา | H7 | Public |
| `doctors` | `doctor_name` | VARCHAR | 150 | - | NO | - | - | ชื่อ-นามสกุลแพทย์พร้อมยศ | H7 | Public |
| `doctors` | `email` | VARCHAR | 150 | - | YES | NULL | - | อีเมลสำหรับติดต่อ | H7 | Public |
| `doctors` | `salary_thb` | NUMERIC | (12,2)| - | YES | NULL | CHECK (salary_thb >= 0) | อัตราเงินเดือนและค่าตอบแทนแพทย์ | H7 | Confidential |
| `doctors` | `position` | VARCHAR | 100 | - | YES | NULL | - | ตำแหน่งแพทย์เฉพาะทาง | H7 | Public |

---

#### 1.5 ตาราง `staff_system.medical_licenses` (ใบอนุญาตประกอบวิชาชีพ)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `medical_licenses` | `license_id` | SERIAL | - | PK | NO | Auto | Primary Key | รหัสใบอนุญาต | H7 | Internal |
| `medical_licenses` | `employee_id` | VARCHAR | 50 | FK | NO | - | REFERENCES employees | บุคลากรผู้ถือครองใบอนุญาต | H7 | Public |
| `medical_licenses` | `license_type` | VARCHAR | 100 | - | YES | NULL | - | ประเภทใบประกอบวิชาชีพ | H7 | Public |
| `medical_licenses` | `license_number` | VARCHAR | 50 | - | YES | NULL | UNIQUE | เลขที่ใบอนุญาตวิชาชีพ | H7 | Public |
| `medical_licenses` | `issued_date` | DATE | - | - | YES | NULL | - | วันที่ออกใบอนุญาต | H7 | Internal |
| `medical_licenses` | `expiry_date` | DATE | - | - | YES | NULL | CHECK (expiry_date >= issued_date)| วันหมดอายุใบอนุญาต | H7 | Internal |
| `medical_licenses` | `issuing_authority`| VARCHAR | 150 | - | YES | NULL | - | หน่วยงานผู้ออกใบอนุญาต | H7 | Public |
| `medical_licenses` | `status` | VARCHAR | 20 | - | NO | 'active'| CHECK IN ('active', 'expired', ...)| สถานะใบอนุญาตวิชาชีพ | H7 | Internal |

---

#### 1.6 ตาราง `staff_system.work_shifts` (ตารางเวรปฏิบัติงาน)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `work_shifts` | `shift_id` | SERIAL | - | PK | NO | Auto | Primary Key | รหัสเวรปฏิบัติงาน | H7 | Internal |
| `work_shifts` | `employee_id` | VARCHAR | 50 | FK | NO | - | REFERENCES employees | บุคลากรที่เข้าเวร | H7 | Internal |
| `work_shifts` | `shift_date` | DATE | - | - | NO | - | - | วันที่ขึ้นปฏิบัติหน้าที่เวร | H7 | Internal |
| `work_shifts` | `shift_type_id` | INT | - | FK | YES | NULL | REFERENCES shift_types | ประเภทเวร (เช้า/บ่าย/ดึก) | H7 | Internal |

---

#### 1.7 ตาราง `staff_system.leave_requests` (คำขออนุมัติการลา)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `leave_requests` | `leave_request_id`| SERIAL | - | PK | NO | Auto | Primary Key | รหัสคำขอลา | H7 | Internal |
| `leave_requests` | `employee_id` | VARCHAR | 50 | FK | NO | - | REFERENCES employees | บุคลากรผู้ยื่นคำขอลา | H7 | Internal |
| `leave_requests` | `leave_type_id` | INT | - | FK | NO | - | REFERENCES leave_types | ประเภทการลา | H7 | Internal |
| `leave_requests` | `start_date` | DATE | - | - | NO | - | - | วันที่เริ่มลา | H7 | Internal |
| `leave_requests` | `end_date` | DATE | - | - | NO | - | CHECK (end_date >= start_date) | วันที่สิ้นสุดการลา | H7 | Internal |
| `leave_requests` | `reason` | TEXT | - | - | YES | NULL | - | เหตุผลความจำเป็นในการลา | H7 | Confidential |
| `leave_requests` | `status` | VARCHAR | 20 | - | NO | 'pending'| CHECK IN ('pending', 'approved', ...)| สถานะคำขอลา | H7 | Internal |
| `leave_requests` | `approved_by` | VARCHAR | 50 | FK | YES | NULL | REFERENCES employees | รหัสหัวหน้าผู้อนุมัติคำขอ | H7 | Internal |

---

#### 1.8 ตาราง `staff_system.payroll` (การจ่ายเงินเดือนและค่าตอบแทน)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `payroll` | `payroll_id` | SERIAL | - | PK | NO | Auto | Primary Key | รหัสรอบจ่ายเงินเดือน | H7 | Confidential |
| `payroll` | `employee_id` | VARCHAR | 50 | FK | NO | - | REFERENCES employees | บุคลากรผู้รับเงินเดือน | H7 | Confidential |
| `payroll` | `pay_period_start`| DATE | - | - | NO | - | - | วันเริ่มต้นรอบคำนวณ | H7 | Internal |
| `payroll` | `pay_period_end` | DATE | - | - | NO | - | CHECK (end >= start) | วันสิ้นสุดรอบคำนวณ | H7 | Internal |
| `payroll` | `net_amount` | NUMERIC | (12,2)| - | NO | - | ยอดเงินสุทธิหลังหัก | เงินเดือนสุทธิที่จ่ายจริง | H7 | Sensitive |
| `payroll` | `paid_at` | TIMESTAMP | - | - | YES | NULL | - | วันเวลาที่โอนเงินจริง | H7 | Confidential |
| `payroll` | `status` | VARCHAR | 20 | - | NO | 'pending'| CHECK IN ('pending', 'paid') | สถานะการจ่ายเงิน | H7 | Internal |

---

### 2. โครงสร้างตารางโมดูล H6: ระบบผู้ป่วยในและวอร์ด (`ipd_system`) ที่เชื่อมต่อกับ H7

#### 2.1 ตาราง `ipd_system.wards` (หอผู้ป่วยใน)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `wards` | `ward_id` | VARCHAR | 50 | PK | NO | - | Primary Key | รหัสหอผู้ป่วย | H6 | Public |
| `wards` | `department_id` | VARCHAR | 50 | FK | NO | - | REFERENCES staff_system.departments | แผนกที่ดูแลวอร์ดนี้ | H6/H7 | Public |
| `wards` | `ward_name` | VARCHAR | 100 | - | NO | - | - | ชื่อหอผู้ป่วย | H6 | Public |
| `wards` | `ward_type` | VARCHAR | 50 | - | NO | - | - | ประเภทวอร์ด (General, ICU, etc.)| H6 | Public |
| `wards` | `bed_capacity` | INT | - | - | NO | 0 | CHECK (bed_capacity >= 0) | ความจุเตียงสูงสุด | H6 | Public |
| `wards` | `head_nurse_id` | VARCHAR | 50 | FK | YES | NULL | REFERENCES staff_system.employees | **หัวหน้าพยาบาลประจำวอร์ด (เชื่อม H7)** | H6/H7 | Public |

---

#### 2.2 ตาราง `ipd_system.admissions` (การรับผู้ป่วยเข้ารักษาในโรงพยาบาล)
| Table Name | Column Name | Data Type | Size | PK/FK | NULL | Default | Constraint | Description | Owner | Data Classification |
| :--- | :--- | :--- | :--- | :---: | :---: | :--- | :--- | :--- | :---: | :--- |
| `admissions` | `admission_id` | VARCHAR | 50 | PK | NO | - | Primary Key | รหัสการรับผู้ป่วยใน | H6 | Public |
| `admissions` | `patient_id` | VARCHAR | 50 | FK | NO | - | REFERENCES patient_system.patients | รหัสผู้ป่วย (เชื่อม H1) | H6/H1 | Confidential |
| `admissions` | `attending_doctor_id`| VARCHAR | 50 | FK | NO | - | REFERENCES staff_system.doctors | **แพทย์เจ้าของไข้ผู้ดูแล (เชื่อม H7)**| H6/H7 | Public |
| `admissions` | `bed_id` | VARCHAR | 50 | FK | NO | - | REFERENCES ipd_system.beds | เตียงที่จัดสรรให้ผู้ป่วย | H6 | Internal |
| `admissions` | `admission_date` | TIMESTAMP | - | - | NO | - | - | วันเวลาที่รับเข้าวอร์ด | H6 | Internal |
| `admissions` | `discharge_date` | TIMESTAMP | - | - | YES | NULL | CHECK (discharge >= admission) | วันเวลาที่แพทย์จำหน่าย | H6 | Internal |
| `admissions` | `admission_type` | VARCHAR | 50 | - | NO | - | - | ประเภทการรับ (Emergency, Elective) | H6 | Internal |
| `admissions` | `discharge_status` | VARCHAR | 50 | - | YES | NULL | - | สภาพผู้ป่วยตอนจำหน่าย | H6 | Confidential |
| `admissions` | `length_of_stay_days`| INT | - | - | YES | NULL | - | จำนวนวันนอนโรงพยาบาล | H6 | Internal |
