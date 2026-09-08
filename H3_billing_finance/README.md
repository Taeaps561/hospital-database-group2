# 🏥 H3: ระบบการเงินและบัญชีโรงพยาบาล (Hospital Billing & Finance)
**ผู้รับผิดชอบ:** นายนธิศ เลิศรัชต์ (รหัสนักศึกษา: `u68001`)  
**กลุ่ม:** กลุ่มที่ 2 — Enterprise Hospital Database  
**Schema กลาง:** `u68001` (PostgreSQL Server: `10.129.57.22`)

---

## 📁 โครงสร้างโฟลเดอร์ (Directory Structure)

```text
H3_billing_finance/
├── postgres 2 - postgres - u68001.png   # แผนภาพ ER Diagram จริงของ Schema u68001 จาก DBeaver
├── README.md                            # คำอธิบายสารบัญและโครงสร้างโมดูล H3
│
├── reports/                             # เอกสารส่งความก้าวหน้า (Progress Reports)
│   ├── PROGRESS_REPORT_WEEK11_u68001.pdf # เล่มรายงานส่งความก้าวหน้าฉบับสมบูรณ์ (PDF)
│   ├── PROGRESS_REPORT_WEEK11_u68001.md  # รายงานส่งความก้าวหน้าฉบับ Markdown
│   └── generate_progress_report.html    # ซอร์สโค้ด HTML สำหรับคอมไพล์เป็น PDF
│
├── sql/                                 # สคริปต์ฐานข้อมูลและการบูรณาการระบบ
│   ├── connect_all_fk.sql               # สคริปต์เชื่อมโยง Foreign Key ครบทุกระบบใน Schema u68001
│   ├── full_integration.sql            # สคริปต์ DDL สร้างโครงสร้าง 32 ตาราง H1-H6
│   ├── u68001_week11.sql                # สคริปต์งานเดี่ยวสัปดาห์ที่ 11
│   └── studentID_week11.sql             # เทมเพลตสคริปต์งานเดี่ยว
│
├── docs/                                # เอกสารวิเคราะห์ระบบก่อนรวมร่าง (Subsystem Analysis)
│   ├── SUBSYSTEM_ANALYSIS_u68001.pdf    # รายงานการวิเคราะห์ระบบย่อย H3 (PDF)
│   ├── SUBSYSTEM_ANALYSIS_u68001.md     # รายงานการวิเคราะห์ระบบย่อย H3 (Markdown)
│   ├── subsystem_analysis_report.html   # ไฟล์ HTML สำหรับดูรายงานบน Browser
│   └── h3_integration_diagram.html      # ไดอะแกรมจำลองความสัมพันธ์ของระบบ
│
└── archive/                             # ไฟล์ร่าง/ไฟล์ประวัติการทำงานเดิม
    ├── report_draft.md                  # ดราฟต์รายงานแรกเริ่ม
    ├── build_pdf.py                     # สคริปต์ช่วยแปลง HTML เป็น PDF
    ├── progress_report_week11.html      # เทมเพลต HTML ความก้าวหน้ารุ่นก่อนหน้า
    └── task3_progress_submission.html   # เทมเพลตรายงานแบบย่อ
```

---

## 📌 สรุปงานสำคัญและการส่งงาน

1. **ส่งงานความก้าวหน้า (งานที่ 3):**
   * เอกสารหลัก: [PROGRESS_REPORT_WEEK11_u68001.pdf](file:///c:/Users/LEGION/Desktop/Hospital_Dataset/hospital-database-group2/H3_billing_finance/reports/PROGRESS_REPORT_WEEK11_u68001.pdf)
   * รายละเอียดเกณฑ์: บันทึกและขอรับคะแนนเฉพาะผู้ที่มาส่งงานจริง คือ **นายนธิศ เลิศรัชต์ (`u68001`)**
2. **การบูรณาการระบบฐานข้อมูล:**
   * สคริปต์รวม DDL: [full_integration.sql](file:///c:/Users/LEGION/Desktop/Hospital_Dataset/hospital-database-group2/H3_billing_finance/sql/full_integration.sql)
   * สคริปต์ผูก Foreign Keys: [connect_all_fk.sql](file:///c:/Users/LEGION/Desktop/Hospital_Dataset/hospital-database-group2/H3_billing_finance/sql/connect_all_fk.sql)
