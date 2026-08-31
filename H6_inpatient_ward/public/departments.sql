CREATE TABLE public.departments (
    department_id text NOT NULL,
    branch_id text NOT NULL,
    department_name text NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16606)
-- Name: doctors; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.departments (department_id, branch_id, department_name) FROM stdin;
D01	H05	Emergency Medicine
D02	H01	Internal Medicine
D03	H02	Surgery
D04	H05	Pediatrics
D05	H03	Obstetrics and Gynecology
D06	H05	Orthopedics
D07	H03	Cardiology
D08	H05	Neurology
D09	H03	Dermatology
D10	H03	Ophthalmology
D11	H03	ENT
D12	H05	Psychiatry
D13	H04	Radiology
D14	H01	Pathology
D15	H01	Anesthesiology
D16	H03	Rehabilitation Medicine
D17	H03	Dentistry
D18	H02	Oncology
D19	H02	Nephrology
D20	H02	Infectious Disease
\.


--
-- TOC entry 3695 (class 0 OID 16606)
-- Dependencies: 236
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: postgres
--

