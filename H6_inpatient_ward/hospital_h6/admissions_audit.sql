CREATE TABLE hospital_h6.admissions_audit (
    audit_id bigint NOT NULL,
    admission_id character varying(10) NOT NULL,
    operation character varying(6) NOT NULL,
    changed_by character varying(50) DEFAULT CURRENT_USER NOT NULL,
    changed_at timestamp with time zone DEFAULT now() NOT NULL,
    old_data jsonb,
    new_data jsonb,
    CONSTRAINT chk_audit_operation CHECK (((operation)::text = ANY ((ARRAY['INSERT'::character varying, 'UPDATE'::character varying, 'DELETE'::character varying])::text[])))
);


ALTER TABLE hospital_h6.admissions_audit OWNER TO postgres;

--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE admissions_audit; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.admissions_audit IS 'Audit Trail ของ admissions — บันทึกทุก INSERT/UPDATE/DELETE';


--
-- TOC entry 249 (class 1259 OID 16826)
-- Name: admissions_audit_audit_id_seq; Type: SEQUENCE; Schema: hospital_h6; Owner: postgres
--

CREATE SEQUENCE hospital_h6.admissions_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hospital_h6.admissions_audit_audit_id_seq OWNER TO postgres;

--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 249
-- Name: admissions_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: hospital_h6; Owner: postgres
--

ALTER SEQUENCE hospital_h6.admissions_audit_audit_id_seq OWNED BY hospital_h6.admissions_audit.audit_id;


--
-- TOC entry 246 (class 1259 OID 16753)
-- Name: bed_transfers; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.admissions_audit (audit_id, admission_id, operation, changed_by, changed_at, old_data, new_data) FROM stdin;
\.


--
-- TOC entry 3705 (class 0 OID 16753)
-- Dependencies: 246
-- Data for Name: bed_transfers; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

