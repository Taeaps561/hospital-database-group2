CREATE TABLE hospital_h6.hospital_branches (
    branch_id character varying(3) NOT NULL,
    branch_name character varying(100) NOT NULL,
    province character varying(50) NOT NULL,
    director_name character varying(100) NOT NULL
);


ALTER TABLE hospital_h6.hospital_branches OWNER TO postgres;

--
-- TOC entry 3754 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE hospital_branches; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.hospital_branches IS 'สาขาโรงพยาบาล — อ้างอิง 01_hospital_branches.csv (5 branches: H01–H05)';


--
-- TOC entry 3755 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN hospital_branches.branch_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.hospital_branches.branch_id IS 'PK: H01–H05';


--
-- TOC entry 240 (class 1259 OID 16676)
-- Name: patients; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.hospital_branches (branch_id, branch_name, province, director_name) FROM stdin;
\.


--
-- TOC entry 3699 (class 0 OID 16676)
-- Dependencies: 240
-- Data for Name: patients; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

