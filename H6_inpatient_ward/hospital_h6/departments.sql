CREATE TABLE hospital_h6.departments (
    department_id character varying(3) NOT NULL,
    branch_id character varying(3) NOT NULL,
    department_name character varying(100) NOT NULL
);


ALTER TABLE hospital_h6.departments OWNER TO postgres;

--
-- TOC entry 3744 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE departments; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.departments IS 'แผนก — อ้างอิง 02_departments.csv (20 departments: D01–D20)';


--
-- TOC entry 3745 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN departments.department_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.departments.department_id IS 'PK: D01–D20';


--
-- TOC entry 241 (class 1259 OID 16692)
-- Name: doctors; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.departments (department_id, branch_id, department_name) FROM stdin;
\.


--
-- TOC entry 3700 (class 0 OID 16692)
-- Dependencies: 241
-- Data for Name: doctors; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

