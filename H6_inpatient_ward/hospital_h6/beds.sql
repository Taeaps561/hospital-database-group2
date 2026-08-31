CREATE TABLE hospital_h6.beds (
    bed_id character(5) NOT NULL,
    ward_id character(4) NOT NULL,
    room_number character varying(10) NOT NULL,
    bed_type character varying(15) NOT NULL,
    bed_status character varying(15) DEFAULT 'Available'::character varying NOT NULL,
    CONSTRAINT chk_bed_status CHECK (((bed_status)::text = ANY ((ARRAY['Available'::character varying, 'Occupied'::character varying, 'Maintenance'::character varying])::text[]))),
    CONSTRAINT chk_bed_type CHECK (((bed_type)::text = ANY ((ARRAY['Standard'::character varying, 'ICU'::character varying, 'Private'::character varying, 'Isolation'::character varying])::text[])))
);


ALTER TABLE hospital_h6.beds OWNER TO postgres;

--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE beds; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.beds IS 'เตียง — อ้างอิง 04_beds.csv (400 beds: B0001–B0400)';


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN beds.bed_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.beds.bed_id IS 'PK: B0001–B0400';


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN beds.room_number; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.beds.room_number IS 'หมายเลขห้อง เช่น R119, R598 (ค่าจาก Dataset จริง)';


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN beds.bed_type; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.beds.bed_type IS 'Standard|ICU|Private|Isolation (ค่าจาก Dataset จริง)';


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN beds.bed_status; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.beds.bed_status IS 'Available|Occupied|Maintenance (ค่าจาก Dataset จริง)';


--
-- TOC entry 239 (class 1259 OID 16666)
-- Name: departments; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.beds (bed_id, ward_id, room_number, bed_type, bed_status) FROM stdin;
\.


--
-- TOC entry 3698 (class 0 OID 16666)
-- Dependencies: 239
-- Data for Name: departments; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

