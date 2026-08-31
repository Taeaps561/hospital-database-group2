CREATE TABLE hospital_h6.wards (
    ward_id character(4) NOT NULL,
    department_id character varying(3) NOT NULL,
    ward_name character varying(50) NOT NULL,
    ward_type character varying(20) NOT NULL,
    bed_capacity smallint DEFAULT 0 NOT NULL,
    CONSTRAINT chk_ward_bed_capacity CHECK ((bed_capacity >= 0)),
    CONSTRAINT chk_ward_type CHECK (((ward_type)::text = ANY ((ARRAY['General'::character varying, 'ICU'::character varying, 'Isolation'::character varying, 'Maternity'::character varying, 'Pediatric'::character varying, 'Rehabilitation'::character varying, 'CCU'::character varying, 'Surgical'::character varying])::text[])))
);


ALTER TABLE hospital_h6.wards OWNER TO postgres;

--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE wards; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.wards IS 'วอร์ด — อ้างอิง 03_wards.csv (80 wards: W001–W080)';


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN wards.ward_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.wards.ward_id IS 'PK: W001–W080';


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN wards.ward_type; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.wards.ward_type IS 'General|ICU|Isolation|Maternity|Pediatric|Rehabilitation|CCU|Surgical (ค่าจาก Dataset จริง)';


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN wards.bed_capacity; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.wards.bed_capacity IS 'จำนวนเตียงสูงสุดในวอร์ด (ค่าจริง: 10–60)';


--
-- TOC entry 218 (class 1259 OID 16474)
-- Name: admissions; Type: TABLE; Schema: public; Owner: postgres
--

COPY hospital_h6.wards (ward_id, department_id, ward_name, ward_type, bed_capacity) FROM stdin;
\.


--
-- TOC entry 3677 (class 0 OID 16474)
-- Dependencies: 218
-- Data for Name: admissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

