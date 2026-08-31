CREATE TABLE public.stg_hospital_branches (
    branch_id text,
    branch_name text,
    province text,
    director_name text
);


ALTER TABLE public.stg_hospital_branches OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16531)
-- Name: stg_patients; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.stg_hospital_branches (branch_id, branch_name, province, director_name) FROM stdin;
H01	Central Hospital	Bangkok	Dr. Siriporn Prasertkul
H02	North Medical Center	Chiang Mai	Dr. Ratchanon Chaiyaporn
H03	Northeast Hospital	Khon Kaen	Dr. Kittiya Buranapong
H04	Eastern Health Center	Chonburi	Dr. Warut Meesuk
H05	Southern Medical Center	Songkhla	Dr. Thanawat Chaiyaporn
\.


--
-- TOC entry 3685 (class 0 OID 16531)
-- Dependencies: 226
-- Data for Name: stg_patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

