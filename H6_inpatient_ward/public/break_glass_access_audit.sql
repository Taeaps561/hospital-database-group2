CREATE TABLE public.break_glass_access_audit (
    audit_id bigint NOT NULL,
    user_id text NOT NULL,
    patient_id text NOT NULL,
    access_reason text NOT NULL,
    access_purpose text NOT NULL,
    accessed_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    source_ip inet,
    CONSTRAINT break_glass_access_audit_access_purpose_check CHECK ((access_purpose = ANY (ARRAY['EMERGENCY_CARE'::text, 'LIFE_SAFETY'::text]))),
    CONSTRAINT break_glass_access_audit_access_reason_check CHECK ((length(btrim(access_reason)) >= 10))
);


ALTER TABLE public.break_glass_access_audit OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16493)
-- Name: break_glass_access_audit_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.break_glass_access_audit ALTER COLUMN audit_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.break_glass_access_audit_audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16576)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.break_glass_access_audit (audit_id, user_id, patient_id, access_reason, access_purpose, accessed_at, source_ip) FROM stdin;
\.


--
-- TOC entry 3693 (class 0 OID 16576)
-- Dependencies: 234
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

