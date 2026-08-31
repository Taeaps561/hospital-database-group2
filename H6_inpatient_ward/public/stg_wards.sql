CREATE TABLE public.stg_wards (
    ward_id text,
    department_id text,
    ward_name text,
    ward_type text,
    bed_capacity text
);


ALTER TABLE public.stg_wards OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16450)
-- Name: wards; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.stg_wards (ward_id, department_id, ward_name, ward_type, bed_capacity) FROM stdin;
W001	D06	Ward 1	Rehabilitation	42
W002	D17	Ward 2	Isolation	22
W003	D20	Ward 3	Surgical	48
W004	D06	Ward 4	Pediatric	44
W005	D12	Ward 5	General	48
W006	D15	Ward 6	Pediatric	31
W007	D04	Ward 7	CCU	18
W008	D02	Ward 8	Rehabilitation	30
W009	D20	Ward 9	Pediatric	10
W010	D11	Ward 10	CCU	16
W011	D10	Ward 11	ICU	19
W012	D13	Ward 12	Isolation	28
W013	D14	Ward 13	ICU	13
W014	D17	Ward 14	Isolation	13
W015	D10	Ward 15	Maternity	12
W016	D10	Ward 16	Maternity	21
W017	D19	Ward 17	CCU	60
W018	D19	Ward 18	Rehabilitation	26
W019	D01	Ward 19	General	14
W020	D15	Ward 20	Maternity	20
W021	D10	Ward 21	ICU	36
W022	D04	Ward 22	ICU	43
W023	D12	Ward 23	ICU	28
W024	D19	Ward 24	Isolation	40
W025	D16	Ward 25	Pediatric	47
W026	D13	Ward 26	General	16
W027	D06	Ward 27	CCU	28
W028	D18	Ward 28	ICU	31
W029	D02	Ward 29	Surgical	48
W030	D07	Ward 30	CCU	14
W031	D17	Ward 31	Rehabilitation	45
W032	D14	Ward 32	Pediatric	30
W033	D09	Ward 33	Surgical	16
W034	D02	Ward 34	Maternity	40
W035	D18	Ward 35	Isolation	38
W036	D12	Ward 36	General	21
W037	D09	Ward 37	General	18
W038	D18	Ward 38	General	37
W039	D16	Ward 39	CCU	30
W040	D19	Ward 40	General	44
W041	D16	Ward 41	ICU	25
W042	D11	Ward 42	ICU	52
W043	D10	Ward 43	Maternity	49
W044	D13	Ward 44	Maternity	35
W045	D17	Ward 45	Pediatric	31
W046	D13	Ward 46	Maternity	39
W047	D19	Ward 47	Isolation	35
W048	D06	Ward 48	Rehabilitation	23
W049	D09	Ward 49	General	31
W050	D10	Ward 50	ICU	29
W051	D18	Ward 51	Pediatric	29
W052	D11	Ward 52	Rehabilitation	33
W053	D15	Ward 53	CCU	41
W054	D20	Ward 54	Maternity	23
W055	D08	Ward 55	Pediatric	60
W056	D09	Ward 56	Surgical	33
W057	D18	Ward 57	Maternity	57
W058	D09	Ward 58	Surgical	18
W059	D11	Ward 59	Isolation	18
W060	D20	Ward 60	CCU	40
W061	D19	Ward 61	CCU	17
W062	D17	Ward 62	Maternity	53
W063	D02	Ward 63	Surgical	59
W064	D12	Ward 64	Maternity	15
W065	D05	Ward 65	General	42
W066	D03	Ward 66	General	24
W067	D16	Ward 67	Pediatric	26
W068	D05	Ward 68	Isolation	27
W069	D11	Ward 69	General	26
W070	D15	Ward 70	Maternity	34
W071	D18	Ward 71	CCU	26
W072	D15	Ward 72	Rehabilitation	18
W073	D11	Ward 73	CCU	43
W074	D15	Ward 74	Pediatric	16
W075	D10	Ward 75	Surgical	33
W076	D05	Ward 76	General	17
W077	D01	Ward 77	General	11
W078	D07	Ward 78	Surgical	56
W079	D11	Ward 79	Surgical	41
W080	D13	Ward 80	Rehabilitation	39
\.


--
-- TOC entry 3675 (class 0 OID 16450)
-- Dependencies: 216
-- Data for Name: wards; Type: TABLE DATA; Schema: public; Owner: postgres
--

