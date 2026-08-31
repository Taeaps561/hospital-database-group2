CREATE TABLE public.hospital_branches (
    branch_id text NOT NULL,
    branch_name text NOT NULL,
    province text NOT NULL,
    director_name text NOT NULL
);


ALTER TABLE public.hospital_branches OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16590)
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.hospital_branches (branch_id, branch_name, province, director_name) FROM stdin;
H01	Central Hospital	Bangkok	Dr. Siriporn Prasertkul
H02	North Medical Center	Chiang Mai	Dr. Ratchanon Chaiyaporn
H03	Northeast Hospital	Khon Kaen	Dr. Kittiya Buranapong
H04	Eastern Health Center	Chonburi	Dr. Warut Meesuk
H05	Southern Medical Center	Songkhla	Dr. Thanawat Chaiyaporn
H06	Week11 Training Branch 06	Bangkok	Training Director 06
H07	Week11 Training Branch 07	Chiang Mai	Training Director 07
H08	Week11 Training Branch 08	Khon Kaen	Training Director 08
H09	Week11 Training Branch 09	Songkhla	Training Director 09
H10	Week11 Training Branch 10	Chonburi	Training Director 10
\.


--
-- TOC entry 3694 (class 0 OID 16590)
-- Dependencies: 235
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

