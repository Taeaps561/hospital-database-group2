# 📊 แผนภาพ ER Diagram โมดูล H7: ระบบบริหารบุคลากรและแพทย์ (Staff & Personnel)
**ผู้รับผิดชอบ:** สมาชิก H7 (ระบบบุคลากร)  
**มาตรฐานการออกแบบ:** 3NF (Third Normal Form), ปราศจาก M:N โดยตรง, ควบคุม Referential Integrity  

---

## 1. แผนภาพ ER Diagram ระบบย่อย H7 (Mermaid Architecture)

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

## 2. คำอธิบายการออกแบบตามหลัก Normalization (3NF)
1. **1NF (First Normal Form):**
   - ทุกแอตทริบิวต์เป็น Atomic Value ไม่มีการเก็บเบอร์โทรศัพท์หลายเบอร์ในคอลัมน์เดียว โดยแยกเป็นตาราง `emergency_contacts` หรือคอลัมน์เฉพาะ
   - รายการย่อยของเงินเดือนแยกเป็นตาราง `payroll_items`
2. **2NF (Second Normal Form):**
   - ตารางที่มี Composite Key เช่น `employee_specialties(employee_id, specialty_id)` ทุกคอลัมน์ (เช่น `certified_date`) ขึ้นตรงกับ Primary Key ทั้งสองตัวอย่างสมบูรณ์
3. **3NF (Third Normal Form):**
   - ขจัด Transitive Dependency โดยแยกข้อมูลคำนำหน้า (`titles`), เพศ (`genders`), ประเภทเวร (`shift_types`), ประเภทการลา (`leave_types`), และตำแหน่งพร้อมฐานเงินเดือน (`positions`) ออกเป็น Lookup Tables เพื่อไม่ให้มีแอตทริบิวต์ใดขึ้นต่อแอตทริบิวต์ที่ไม่ใช่คีย์หลัก

---

## 3. จุดเชื่อมต่อกับระบบอื่น (Inter-system Integration Points)
* **เชื่อมต่อ H6 (ผู้ป่วยใน/วอร์ด):**
  * `ipd_system.admissions(attending_doctor_id)` $\rightarrow$ `staff_system.doctors(doctor_id)` / `staff_system.employees(employee_id)`
  * `ipd_system.wards(head_nurse_id)` $\rightarrow$ `staff_system.employees(employee_id)`
  * `ipd_system.wards(department_id)` $\rightarrow$ `staff_system.departments(department_id)`
* **เชื่อมต่อ H2 (นัดหมาย/OPD):**
  * `opd_system.appointments(doctor_id)` $\rightarrow$ `staff_system.doctors(doctor_id)`
* **เชื่อมต่อ H4 (เภสัชกรรม):**
  * `pharmacy_system.prescriptions(doctor_id)` $\rightarrow$ `staff_system.doctors(doctor_id)`
* **เชื่อมต่อ H5 (ห้องแล็บ):**
  * `lab_system.lab_orders(doctor_id)` $\rightarrow$ `staff_system.doctors(doctor_id)`
