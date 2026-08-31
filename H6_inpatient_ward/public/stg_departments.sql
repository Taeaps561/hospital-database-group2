CREATE TABLE public.stg_departments (
    department_id text,
    branch_id text,
    department_name text
);


ALTER TABLE public.stg_departments OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16536)
-- Name: stg_diagnoses; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.stg_departments (department_id, branch_id, department_name) FROM stdin;
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
-- TOC entry 3686 (class 0 OID 16536)
-- Dependencies: 227
-- Data for Name: stg_diagnoses; Type: TABLE DATA; Schema: public; Owner: postgres
--

