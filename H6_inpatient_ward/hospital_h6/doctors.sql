CREATE TABLE hospital_h6.doctors (
    doctor_id character varying(7) NOT NULL,
    department_id character varying(3) NOT NULL,
    doctor_name character varying(100) NOT NULL,
    email character varying(150),
    salary_thb numeric(10,2),
    "position" character varying(50)
);


ALTER TABLE hospital_h6.doctors OWNER TO postgres;

--
-- TOC entry 3746 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE doctors; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.doctors IS 'แพทย์ — อ้างอิง 05_doctors.csv (800 doctors: DR0001–DR0800)';


--
-- TOC entry 3747 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN doctors.doctor_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.doctors.doctor_id IS 'PK: DR0001–DR0800';


--
-- TOC entry 3748 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN doctors.salary_thb; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.doctors.salary_thb IS 'SENSITIVE: ข้อมูลทางการเงิน — GRANT เฉพาะ admin/HR';


--
-- TOC entry 248 (class 1259 OID 16784)
-- Name: emergency_access_logs; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.doctors (doctor_id, department_id, doctor_name, email, salary_thb, "position") FROM stdin;
\.


--
-- TOC entry 3707 (class 0 OID 16784)
-- Dependencies: 248
-- Data for Name: emergency_access_logs; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

