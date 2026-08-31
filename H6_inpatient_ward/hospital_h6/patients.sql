CREATE TABLE hospital_h6.patients (
    patient_id character varying(7) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    gender character varying(10) NOT NULL,
    birth_date date,
    blood_group character varying(3),
    province character varying(50),
    email character varying(150),
    phone character varying(15),
    weight_kg numeric(5,1),
    height_cm numeric(5,1),
    registered_branch_id character varying(3),
    patient_status character varying(10) DEFAULT 'Active'::character varying NOT NULL,
    CONSTRAINT chk_patient_blood_group CHECK ((((blood_group)::text = ANY ((ARRAY['A'::character varying, 'B'::character varying, 'AB'::character varying, 'O'::character varying])::text[])) OR (blood_group IS NULL))),
    CONSTRAINT chk_patient_gender CHECK (((gender)::text = ANY ((ARRAY['M'::character varying, 'F'::character varying, 'Other'::character varying])::text[]))),
    CONSTRAINT chk_patient_height CHECK (((height_cm > (0)::numeric) OR (height_cm IS NULL))),
    CONSTRAINT chk_patient_status CHECK (((patient_status)::text = ANY ((ARRAY['Active'::character varying, 'Inactive'::character varying, 'Deceased'::character varying])::text[]))),
    CONSTRAINT chk_patient_weight CHECK (((weight_kg > (0)::numeric) OR (weight_kg IS NULL)))
);


ALTER TABLE hospital_h6.patients OWNER TO postgres;

--
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE patients; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.patients IS 'ผู้ป่วย — อ้างอิง 06_patients.csv (50,000 patients: P000001–P050000)';


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN patients.patient_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.patients.patient_id IS 'PK: P000001–P050000';


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN patients.patient_status; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.patients.patient_status IS 'Active | Inactive | Deceased';


--
-- TOC entry 242 (class 1259 OID 16702)
-- Name: wards; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.patients (patient_id, first_name, last_name, gender, birth_date, blood_group, province, email, phone, weight_kg, height_cm, registered_branch_id, patient_status) FROM stdin;
\.


--
-- TOC entry 3701 (class 0 OID 16702)
-- Dependencies: 242
-- Data for Name: wards; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

