CREATE TABLE hospital_h6.bed_transfers (
    transfer_id integer NOT NULL,
    admission_id character varying(10) NOT NULL,
    from_bed_id character(5) NOT NULL,
    to_bed_id character(5) NOT NULL,
    transfer_date timestamp with time zone DEFAULT now() NOT NULL,
    transfer_reason text,
    transferred_by character varying(7) NOT NULL,
    CONSTRAINT chk_bt_different_beds CHECK ((from_bed_id <> to_bed_id))
);


ALTER TABLE hospital_h6.bed_transfers OWNER TO postgres;

--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE bed_transfers; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON TABLE hospital_h6.bed_transfers IS '[NEW TABLE FOR H6] การย้ายเตียง — H03_BED_TRANSFER.txt: ผู้ป่วยย้ายเตียงระหว่าง Admission เดียวกันได้';


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN bed_transfers.from_bed_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.bed_transfers.from_bed_id IS 'FK: เตียงที่ย้ายออก';


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN bed_transfers.to_bed_id; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.bed_transfers.to_bed_id IS 'FK: เตียงที่ย้ายเข้า (ต้องต่างจาก from_bed_id)';


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN bed_transfers.transferred_by; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON COLUMN hospital_h6.bed_transfers.transferred_by IS 'FK: แพทย์ที่สั่งย้ายเตียง → doctors.doctor_id';


--
-- TOC entry 245 (class 1259 OID 16752)
-- Name: bed_transfers_transfer_id_seq; Type: SEQUENCE; Schema: hospital_h6; Owner: postgres
--

CREATE SEQUENCE hospital_h6.bed_transfers_transfer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE hospital_h6.bed_transfers_transfer_id_seq OWNER TO postgres;

--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 245
-- Name: bed_transfers_transfer_id_seq; Type: SEQUENCE OWNED BY; Schema: hospital_h6; Owner: postgres
--

ALTER SEQUENCE hospital_h6.bed_transfers_transfer_id_seq OWNED BY hospital_h6.bed_transfers.transfer_id;


--
-- TOC entry 243 (class 1259 OID 16715)
-- Name: beds; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

COPY hospital_h6.bed_transfers (transfer_id, admission_id, from_bed_id, to_bed_id, transfer_date, transfer_reason, transferred_by) FROM stdin;
\.


--
-- TOC entry 3702 (class 0 OID 16715)
-- Dependencies: 243
-- Data for Name: beds; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

