CREATE TABLE hospital_h6.emergency_access_logs (
    log_id bigint NOT NULL,
    accessed_by_username character varying(50) NOT NULL,
    admission_id character varying(10) NOT NULL,
    access_timestamp timestamp with time zone DEFAULT now() NOT NULL,
    reason text NOT NULL,
    access_type character varying(30) DEFAULT 'BREAK_GLASS'::character varying NOT NULL,
    CONSTRAINT chk_eal_access_type CHECK (((access_type)::text = ANY ((ARRAY['BREAK_GLASS'::character varying, 'EMERGENCY_VIEW'::character varying, 'OVERRIDE_ACCESS'::character varying])::text[]))),
    CONSTRAINT chk_eal_reason CHECK ((char_length(TRIM(BOTH FROM reason)) > 0))
);


ALTER TABLE hospital_h6.emergency_access_logs OWNER TO postgres;

--
-- TOC entry 3749 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE emergency_access_logs; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.emergency_access_logs IS '[NEW TABLE FOR H6] Audit Log การเข้าถึงฉุกเฉิน — H06_BREAK_GLASS.txt: บันทึกทุกครั้งที่ Override การเข้าถึง';


--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN emergency_access_logs.accessed_by_username; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.emergency_access_logs.accessed_by_username IS 'username ผู้เข้าถึง (อ้างอิง 12_users_security_lab.csv)';


--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN emergency_access_logs.reason; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.emergency_access_logs.reason IS 'เหตุผล: บังคับ NOT NULL + ห้ามว่าง ตาม H06_BREAK_GLASS';


--
-- TOC entry 247 (class 1259 OID 16783)
-- Name: emergency_access_logs_log_id_seq; Type: SEQUENCE; Schema: hospital_h6; Owner: postgres
--

CREATE SEQUENCE hospital_h6.emergency_access_logs_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hospital_h6.emergency_access_logs_log_id_seq OWNER TO postgres;

--
-- TOC entry 3753 (class 0 OID 0)
-- Dependencies: 247
-- Name: emergency_access_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: hospital_h6; Owner: postgres
--

ALTER SEQUENCE hospital_h6.emergency_access_logs_log_id_seq OWNED BY hospital_h6.emergency_access_logs.log_id;


--
-- TOC entry 238 (class 1259 OID 16661)
-- Name: hospital_branches; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.emergency_access_logs (log_id, accessed_by_username, admission_id, access_timestamp, reason, access_type) FROM stdin;
\.


--
-- TOC entry 3697 (class 0 OID 16661)
-- Dependencies: 238
-- Data for Name: hospital_branches; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

