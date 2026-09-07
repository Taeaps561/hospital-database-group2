# 📊 แผนภาพ ER Diagram โมดูล H7: ระบบบริหารบุคลากร และการบูรณาการร่วมกับ H6 (ผู้ป่วยใน)
**ผู้รับผิดชอบ:** สมาชิก H7 (ระบบบริหารบุคลากรทางการแพทย์และเจ้าหน้าที่)  
**มาตรฐานการออกแบบ:** 3NF (Third Normal Form), ปราศจาก M:N โดยตรง, ควบคุม Referential Integrity ครบถ้วน  

---

## 1. แผนภาพที่ 1: ระบบย่อย H7 เดี่ยวๆ (H7 Standalone ER Diagram)
*แสดงโครงสร้าง 22 ตารางของระบบบริหารทรัพยากรบุคคลและบุคลากรทางการแพทย์*

```mermaid
erDiagram
    departments ||--o{ employees : "employs"
    positions ||--o{ employees : "categorizes"
    titles ||--o{ employees : "prefixes"
    genders ||--o{ employees : "classifies"
    
    employees ||--o{ medical_licenses : "holds"
    employees ||--o{ work_shifts : "scheduled"
    shift_types ||--o{ work_shifts : "defines"
    
    employees ||--o{ attendance : "logs"
    employees ||--o{ leave_requests : "requests"
    leave_types ||--o{ leave_requests : "specifies"
    
    employees ||--o{ employee_contracts : "signs"
    employees ||--o{ payroll : "receives"
    payroll ||--o{ payroll_items : "itemizes"
    
    employees ||--o{ emergency_contacts : "contacts"
    employees ||--o| users : "accesses"
    roles ||--o{ users : "assigns"
    
    employees ||--o{ employee_specialties : "specializes"
    specialties ||--o{ employee_specialties : "in"
    
    employees ||--o{ employee_department_history : "records_dept"
    employees ||--o{ employee_position_history : "records_pos"

    employees {
        string employee_id PK
        string first_name
        string last_name
        string national_id
        date date_of_birth
        string department_id FK
        int position_id FK
        string status
        string email
    }

    departments {
        string department_id PK
        string department_name
        string branch_id FK
        string department_head_id FK
    }

    medical_licenses {
        int license_id PK
        string employee_id FK
        string license_type
        string license_number
        date expiry_date
        string status
    }

    payroll {
        int payroll_id PK
        string employee_id FK
        date pay_period_start
        date pay_period_end
        numeric net_amount
    }
```

---

## 2. แผนภาพที่ 2: การบูรณาการข้ามระบบ H7 (บุคลากร) + H6 (ผู้ป่วยในและวอร์ด)
*แสดงจุดเชื่อมโยงสำคัญ (Inter-system Foreign Keys) ระหว่างแพทย์/พยาบาล (H7) กับการรับคนไข้และหอผู้ป่วย (H6)*

```mermaid
erDiagram
    %% -----------------------------------------
    %% H7: บุคลากรทางการแพทย์ (Staff & Personnel)
    %% -----------------------------------------
    departments ||--o{ employees : "สังกัดแผนก"
    departments ||--o{ doctors : "แผนกที่ออกตรวจ"
    employees ||--o| doctors : "บทบาทแพทย์ (employee_id)"
    
    %% -----------------------------------------
    %% H6: ผู้ป่วยในและหอผู้ป่วย (Inpatient & Wards)
    %% -----------------------------------------
    departments ||--o{ wards : "กำกับดูแลวอร์ด (department_id)"
    wards ||--o{ beds : "ติดตั้งเตียงในวอร์ด (ward_id)"
    beds ||--o{ admissions : "ครองเตียงรักษา (bed_id)"

    %% -----------------------------------------
    %% จุดเชื่อมต่อข้ามระบบ (Cross-Module Links)
    %% -----------------------------------------
    doctors ||--o{ admissions : "แพทย์เจ้าของไข้ผู้ดูแล (attending_doctor_id)"
    employees ||--o{ wards : "หัวหน้าพยาบาลประจำวอร์ด (head_nurse_id)"

    %% คำอธิบายโครงสร้างตาราง
    departments {
        string department_id PK "รหัสแผนก"
        string department_name "ชื่อแผนก"
    }

    employees {
        string employee_id PK "รหัสบุคลากร"
        string first_name "ชื่อ"
        string last_name "นามสกุล"
        string department_id FK "แผนกที่สังกัด"
        string status "สถานะการทำงาน"
    }

    doctors {
        string doctor_id PK "รหัสแพทย์ (สำหรับระบบอื่นอ้างอิง)"
        string employee_id FK "รหัสบุคลากรหลัก"
        string department_id FK "แผนกตรวจ"
        string doctor_name "ชื่อ-นามสกุลแพทย์"
    }

    wards {
        string ward_id PK "รหัสหอผู้ป่วย"
        string ward_name "ชื่อวอร์ด"
        string department_id FK "อ้างอิง H7 departments"
        string head_nurse_id FK "อ้างอิง H7 employees (หัวหน้าพยาบาล)"
        int bed_capacity "ความจุเตียง"
    }

    beds {
        string bed_id PK "รหัสเตียง"
        string ward_id FK "วอร์ดที่ติดตั้ง"
        string room_number "หมายเลขห้อง"
        string bed_status "สถานะเตียง (Available/Occupied)"
    }

    admissions {
        string admission_id PK "รหัสการรับผู้ป่วยใน"
        string patient_id FK "รหัสผู้ป่วย (H1)"
        string attending_doctor_id FK "อ้างอิง H7 doctors (แพทย์เจ้าของไข้)"
        string bed_id FK "เตียงที่นอน (H6)"
        timestamp admission_date "วันเวลาที่รับเข้า"
        timestamp discharge_date "วันเวลาที่จำหน่าย"
    }
```

---

## 3. คำอธิบายจุดเชื่อมโยง (Integration Details)
1. **แพทย์เจ้าของไข้ (Attending Physician):**
   * ตาราง `admissions` ของ H6 มี Foreign Key `attending_doctor_id` ชี้ไปยัง `staff_system.doctors(doctor_id)` ซึ่งเชื่อมโยงต่อไปยัง `staff_system.employees(employee_id)` ของ H7 เพื่อให้ทราบประวัติและคุณวุฒิของแพทย์ผู้รักษา
2. **หัวหน้าพยาบาลประจำวอร์ด (Head Nurse Assignment):**
   * ตาราง `wards` ของ H6 มี Foreign Key `head_nurse_id` ชี้มายัง `staff_system.employees(employee_id)` เพื่อระบุพยาบาลวิชาชีพผู้รับผิดชอบการบริบาลในแต่ละหอผู้ป่วย
3. **แผนกทางการแพทย์ (Clinical Department Hierarchy):**
   * ตาราง `wards` ของ H6 อ้างอิง `department_id` มายังตาราง `staff_system.departments` ของ H7 เพื่อไม่ให้เกิดตารางแผนกซ้ำซ้อนตามหลัก 3NF
