CREATE TABLE hospital_h6.admissions (
    admission_id character varying(10) NOT NULL,
    patient_id character varying(7) NOT NULL,
    attending_doctor_id character varying(7) NOT NULL,
    bed_id character(5) NOT NULL,
    admission_date date NOT NULL,
    discharge_date date,
    admission_type character varying(15) NOT NULL,
    discharge_status character varying(15) NOT NULL,
    length_of_stay_days smallint,
    CONSTRAINT chk_admission_dates CHECK (((discharge_date IS NULL) OR (discharge_date >= admission_date))),
    CONSTRAINT chk_admission_type CHECK (((admission_type)::text = ANY ((ARRAY['Emergency'::character varying, 'Elective'::character varying, 'Transfer'::character varying])::text[]))),
    CONSTRAINT chk_discharge_status CHECK (((discharge_status)::text = ANY ((ARRAY['Recovered'::character varying, 'Improved'::character varying, 'Deceased'::character varying, 'Transferred'::character varying, 'Ongoing'::character varying])::text[]))),
    CONSTRAINT chk_length_of_stay CHECK (((length_of_stay_days IS NULL) OR (length_of_stay_days >= 0)))
);

ALTER TABLE ONLY hospital_h6.admissions FORCE ROW LEVEL SECURITY;


ALTER TABLE hospital_h6.admissions OWNER TO postgres;

--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE admissions; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.admissions IS 'การ Admit ผู้ป่วย — อ้างอิง 09_admissions.csv (100,000 records: AD0000001–AD0100000)';


--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.admission_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.admission_id IS 'PK: AD0000001–AD0100000';


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.attending_doctor_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.attending_doctor_id IS 'FK: แพทย์ผู้รับผิดชอบ → doctors.doctor_id';


--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.discharge_date; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.discharge_date IS 'NULL เมื่อ discharge_status = Ongoing';


--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.admission_type; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.admission_type IS 'Emergency|Elective|Transfer (ค่าจาก Dataset จริง)';


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.discharge_status; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.discharge_status IS 'Recovered|Improved|Deceased|Transferred|Ongoing (ค่าจาก Dataset จริง)';


--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN admissions.length_of_stay_days; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.admissions.length_of_stay_days IS 'จำนวนวันนอน (NULL ได้เมื่อ Ongoing)';


--
-- TOC entry 250 (class 1259 OID 16827)
-- Name: admissions_audit; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.admissions (admission_id, patient_id, attending_doctor_id, bed_id, admission_date, discharge_date, admission_type, discharge_status, length_of_stay_days) FROM stdin;
\.


--
-- TOC entry 3709 (class 0 OID 16827)
-- Dependencies: 250
-- Data for Name: admissions_audit; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

