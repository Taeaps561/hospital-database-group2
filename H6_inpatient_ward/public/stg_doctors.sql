CREATE TABLE public.stg_doctors (
    doctor_id text,
    department_id text,
    doctor_name text,
    email text,
    salary_thb text,
    "position" text
);


ALTER TABLE public.stg_doctors OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16506)
-- Name: stg_hospital_branches; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.stg_doctors (doctor_id, department_id, doctor_name, email, salary_thb, "position") FROM stdin;
DR0001	D10	Somchai Chaiyaporn	doctor0001@hospital.org	66807.25	Specialist
DR0002	D04	Jirawat Sukjai	doctor0002@hospital.org	85606.23	Specialist
DR0003	D12	Narin Boonmee	doctor0003@hospital.org	73920.37	Consultant
DR0004	D20	Pimchanok Jindarat	doctor0004@hospital.org	35000	Consultant
DR0005	D11	Siriporn Chantarangsu	doctor0005@hospital.org	92089.03	General Practitioner
DR0006	D16	Ratchanon Prasertkul	doctor0006@hospital.org	94538.59	Senior Specialist
DR0007	D10	Siriporn Sukjai	doctor0007@hospital.org	36760.58	General Practitioner
DR0008	D15	Nattapong Panyarat	doctor0008@hospital.org	102496.26	Senior Specialist
DR0009	D10	Mali Wongsa	doctor0009@hospital.org	101672.86	Specialist
DR0010	D12	Supansa Khamdee	doctor0010@hospital.org	104290.46	Senior Specialist
DR0011	D07	Mali Wattanakul	doctor0011@hospital.org	148954.78	General Practitioner
DR0012	D12	Somchai Srisuk	doctor0012@hospital.org	82940.99	Specialist
DR0013	D12	Narin Meesuk	doctor0013@hospital.org	85832.95	Specialist
DR0014	D03	Kittiya Sukjai	doctor0014@hospital.org	120098.11	Senior Specialist
DR0015	D02	Jirawat Kittisak	doctor0015@hospital.org	108956.98	Senior Specialist
DR0016	D10	Narin Thongchai	doctor0016@hospital.org	98651.62	Specialist
DR0017	D19	Supansa Meesuk	doctor0017@hospital.org	120452.45	General Practitioner
DR0018	D02	Suda Meesuk	doctor0018@hospital.org	121504.27	Specialist
DR0019	D03	Supansa Chaiyaporn	doctor0019@hospital.org	91079.09	Specialist
DR0020	D13	Kanya Saengthong	doctor0020@hospital.org	35035.82	Senior Specialist
DR0021	D04	Warut Jindarat	doctor0021@hospital.org	95536.65	Specialist
DR0022	D04	Pimchanok Khamdee	doctor0022@hospital.org	74140.0	Specialist
DR0023	D10	Thanawat Panyarat	doctor0023@hospital.org	100002.88	Specialist
DR0024	D11	Siriporn Saelim	doctor0024@hospital.org	87292.31	Consultant
DR0025	D08	Anan Chuenchom	doctor0025@hospital.org	61594.79	General Practitioner
DR0026	D03	Nicha Wattanakul	doctor0026@hospital.org	117475.14	Consultant
DR0027	D17	Siriporn Chaiyaporn	doctor0027@hospital.org	135035.9	Consultant
DR0028	D14	Kanya Prasertkul	doctor0028@hospital.org	93859.54	Consultant
DR0029	D13	Nattapong Boonmee	doctor0029@hospital.org	42601.01	Senior Specialist
DR0030	D11	Anan Srisuk	doctor0030@hospital.org	71975.85	Specialist
DR0031	D13	Nattapong Jindarat	doctor0031@hospital.org	62952.81	Consultant
DR0032	D04	Somchai Boonmee	doctor0032@hospital.org	119609.9	General Practitioner
DR0033	D15	Kanya Khamdee	doctor0033@hospital.org	98159.45	General Practitioner
DR0034	D17	Thanawat Wattanakul	doctor0034@hospital.org	104539.71	Specialist
DR0035	D05	Supansa Prasertkul	doctor0035@hospital.org	68316.69	Senior Specialist
DR0036	D15	Kanya Chaiyaporn	doctor0036@hospital.org	104122.42	Consultant
DR0037	D07	Warut Saelim	doctor0037@hospital.org	114283.31	Senior Specialist
DR0038	D12	Jirawat Chantarangsu	doctor0038@hospital.org	86649.61	Senior Specialist
DR0039	D08	Kanya Panyarat	doctor0039@hospital.org	44583.39	Senior Specialist
DR0040	D18	Anan Saengthong	doctor0040@hospital.org	120577.6	Senior Specialist
DR0041	D09	Kanya Wattanakul	doctor0041@hospital.org	99970.17	Senior Specialist
DR0042	D13	Patchara Buranapong	doctor0042@hospital.org	102390.73	Consultant
DR0043	D09	Kanya Thongchai	doctor0043@hospital.org	107676.81	Consultant
DR0044	D02	Narin Khamdee	doctor0044@hospital.org	117868.52	Senior Specialist
DR0045	D18	Thanawat Chaiyaporn	doctor0045@hospital.org	81027.14	Senior Specialist
DR0046	D12	Jirawat Meesuk	doctor0046@hospital.org	124136.44	General Practitioner
DR0047	D03	Kanya Khamdee	doctor0047@hospital.org	113505.38	Specialist
DR0048	D13	Chalerm Phromma	doctor0048@hospital.org	35000	Consultant
DR0049	D08	Narin Buranapong	doctor0049@hospital.org	88644.01	Senior Specialist
DR0050	D01	Chalerm Kittisak	doctor0050@hospital.org	87316.52	Consultant
DR0051	D20	Supansa Chuenchom	doctor0051@hospital.org	66100.95	Consultant
DR0052	D07	Warut Boonmee	doctor0052@hospital.org	158181.16	Specialist
DR0053	D03	Ratchanon Phromma	doctor0053@hospital.org	103046.97	General Practitioner
DR0054	D16	Anan Meesuk	doctor0054@hospital.org	97242.96	Specialist
DR0055	D08	Nattapong Phromma	doctor0055@hospital.org	96919.2	General Practitioner
DR0056	D12	Ratchanon Srisuk	doctor0056@hospital.org	121416.4	Consultant
DR0057	D09	Nattapong Srisuk	doctor0057@hospital.org	85586.95	Specialist
DR0058	D14	Nicha Panyarat	doctor0058@hospital.org	54305.13	General Practitioner
DR0059	D03	Kanya Prasertkul	doctor0059@hospital.org	93641.29	Consultant
DR0060	D12	Chalerm Sukjai	doctor0060@hospital.org	100354.02	Specialist
DR0061	D16	Siriporn Panyarat	doctor0061@hospital.org	54691.93	Consultant
DR0062	D16	Ratchanon Prasertkul	doctor0062@hospital.org	115981.78	Consultant
DR0063	D05	Kanya Buranapong	doctor0063@hospital.org	80881.49	Specialist
DR0064	D03	Suda Wattanakul	doctor0064@hospital.org	72744.88	Specialist
DR0065	D16	Pimchanok Srisuk	doctor0065@hospital.org	92934.43	Specialist
DR0066	D15	Mali Prasertkul	doctor0066@hospital.org	113723.6	Senior Specialist
DR0067	D02	Thanawat Khamdee	doctor0067@hospital.org	85948.68	Consultant
DR0068	D13	Mali Khamdee	doctor0068@hospital.org	88359.25	Consultant
DR0069	D01	Mali Kittisak	doctor0069@hospital.org	120150.29	General Practitioner
DR0070	D02	Patchara Srisuk	doctor0070@hospital.org	118719.49	Consultant
DR0071	D05	Patchara Meesuk	doctor0071@hospital.org	123090.34	General Practitioner
DR0072	D06	Nicha Phromma	doctor0072@hospital.org	158728.19	Specialist
DR0073	D03	Mali Chantarangsu	doctor0073@hospital.org	115617.35	Consultant
DR0074	D07	Pimchanok Saelim	doctor0074@hospital.org	102722.01	Specialist
DR0075	D03	Preecha Rattanapong	doctor0075@hospital.org	50832.44	Senior Specialist
DR0076	D14	Anan Prasertkul	doctor0076@hospital.org	60035.01	Senior Specialist
DR0077	D19	Ratchanon Phromma	doctor0077@hospital.org	750000.0	General Practitioner
DR0078	D06	Mali Meesuk	doctor0078@hospital.org	72737.0	Senior Specialist
DR0079	D04	Pimchanok Kittisak	doctor0079@hospital.org	137364.46	General Practitioner
DR0080	D11	Nattapong Phromma	doctor0080@hospital.org	81080.97	Consultant
DR0081	D09	Preecha Kittisak	doctor0081@hospital.org	64981.36	Specialist
DR0082	D02	Ploy Phromma	doctor0082@hospital.org	79924.24	Senior Specialist
DR0083	D05	Ploy Rattanapong	doctor0083@hospital.org	112091.69	Senior Specialist
DR0084	D14	Warut Rattanapong	doctor0084@hospital.org	92032.04	General Practitioner
DR0085	D13	Kittiya Rattanapong	doctor0085@hospital.org	108520.62	Specialist
DR0086	D01	Siriporn Panyarat	doctor0086@hospital.org	92544.79	Specialist
DR0087	D05	Narin Khamdee	doctor0087@hospital.org	91909.18	General Practitioner
DR0088	D02	Supansa Saelim	doctor0088@hospital.org	73087.45	Specialist
DR0089	D06	Patchara Chuenchom	doctor0089@hospital.org	104601.02	General Practitioner
DR0090	D16	Supansa Srisuk	doctor0090@hospital.org	115828.01	Consultant
DR0091	D08	Suda Chaiyaporn	doctor0091@hospital.org	150643.16	General Practitioner
DR0092	D07	Thanawat Thongchai	doctor0092@hospital.org	92340.18	General Practitioner
DR0093	D12	Chalerm Prasertkul	doctor0093@hospital.org	35000	General Practitioner
DR0094	D04	Ratchanon Panyarat	doctor0094@hospital.org	107141.58	General Practitioner
DR0095	D08	Kanya Thongchai	doctor0095@hospital.org	111433.48	Consultant
DR0096	D18	Warut Chaiyaporn	doctor0096@hospital.org	84286.45	General Practitioner
DR0097	D13	Kittiya Chuenchom	doctor0097@hospital.org	99429.31	General Practitioner
DR0098	D09	Nicha Boonmee	doctor0098@hospital.org	97139.44	Specialist
DR0099	D13	Anan Boonmee	doctor0099@hospital.org	121978.66	General Practitioner
DR0100	D18	Kittiya Buranapong	doctor0100@hospital.org	103295.88	General Practitioner
DR0101	D08	Warut Sukjai	doctor0101@hospital.org	140835.44	General Practitioner
DR0102	D05	Nicha Buranapong	doctor0102@hospital.org	152298.72	Consultant
DR0103	D14	Ratchanon Phromma	doctor0103@hospital.org	65761.54	Consultant
DR0104	D11	Jirawat Jindarat	doctor0104@hospital.org	96661.28	Senior Specialist
DR0105	D19	Patchara Chantarangsu	doctor0105@hospital.org	91321.42	Senior Specialist
DR0106	D14	Jirawat Chantarangsu	doctor0106@hospital.org	111741.35	Senior Specialist
DR0107	D15	Thanawat Boonmee	doctor0107@hospital.org	84017.52	Senior Specialist
DR0108	D07	Pimchanok Wongsa	doctor0108@hospital.org	92435.57	Consultant
DR0109	D08	Pimchanok Chaiyaporn	doctor0109@hospital.org	96774.95	Senior Specialist
DR0110	D15	Nicha Chuenchom	doctor0110@hospital.org	147491.08	Specialist
DR0111	D18	Kittiya Phromma	doctor0111@hospital.org	106234.87	General Practitioner
DR0112	D09	Supansa Chuenchom	doctor0112@hospital.org	103543.02	General Practitioner
DR0113	D08	Mali Chantarangsu	\N	105902.17	Senior Specialist
DR0114	D13	Warut Sukjai	doctor0114@hospital.org	89921.83	Senior Specialist
DR0115	D17	Patchara Kittisak	doctor0115@hospital.org	110182.63	Senior Specialist
DR0116	D15	Narin Srisuk	doctor0116@hospital.org	145954.63	Senior Specialist
DR0117	D06	Anan Srisuk	doctor0117@hospital.org	101312.54	General Practitioner
DR0118	D11	Kanya Wattanakul	doctor0118@hospital.org	73140.29	Specialist
DR0119	D01	Warut Chuenchom	doctor0119@hospital.org	115507.54	Senior Specialist
DR0120	D17	Nattapong Srisuk	doctor0120@hospital.org	65242.9	General Practitioner
DR0121	D10	Patchara Srisuk	doctor0121@hospital.org	57968.92	General Practitioner
DR0122	D12	Kittiya Srisuk	doctor0122@hospital.org	99131.53	Consultant
DR0123	D01	Chalerm Jindarat	doctor0123@hospital.org	86278.42	General Practitioner
DR0124	D10	Suda Buranapong	doctor0124@hospital.org	110523.33	Consultant
DR0125	D20	Kanya Thongchai	doctor0125@hospital.org	46091.73	Consultant
DR0126	D18	Patchara Wattanakul	doctor0126@hospital.org	99727.23	Specialist
DR0127	D01	Ratchanon Boonmee	doctor0127@hospital.org	108275.71	General Practitioner
DR0128	D08	Warut Buranapong	doctor0128@hospital.org	87094.35	Specialist
DR0129	D16	Jirawat Panyarat	doctor0129@hospital.org	102605.45	Specialist
DR0130	D11	Mali Meesuk	doctor0130@hospital.org	106980.47	General Practitioner
DR0131	D06	Kanya Khamdee	doctor0131@hospital.org	90733.05	Consultant
DR0132	D01	Siriporn Rattanapong	doctor0132@hospital.org	135816.98	General Practitioner
DR0133	D01	Siriporn Saengthong	doctor0133@hospital.org	120962.01	Specialist
DR0134	D12	Ploy Jindarat	doctor0134@hospital.org	52196.0	General Practitioner
DR0135	D06	Ratchanon Jindarat	doctor0135@hospital.org	53609.05	Senior Specialist
DR0136	D04	Kittiya Wongsa	doctor0136@hospital.org	108670.26	Senior Specialist
DR0137	D06	Warut Saelim	doctor0137@hospital.org	116202.96	Senior Specialist
DR0138	D05	Ratchanon Meesuk	doctor0138@hospital.org	89324.4	Specialist
DR0139	D16	Warut Chuenchom	doctor0139@hospital.org	100756.75	Specialist
DR0140	D14	Anan Rattanapong	doctor0140@hospital.org	96127.38	Consultant
DR0141	D10	Somchai Khamdee	doctor0141@hospital.org	78489.34	Specialist
DR0142	D10	Chalerm Saengthong	doctor0142@hospital.org	47831.26	Senior Specialist
DR0143	D08	Pimchanok Saelim	doctor0143@hospital.org	137569.03	General Practitioner
DR0144	D07	Pimchanok Wattanakul	doctor0144@hospital.org	40986.59	General Practitioner
DR0145	D03	Nattapong Jindarat	doctor0145@hospital.org	65854.17	Consultant
DR0146	D08	Kittiya Srisuk	doctor0146@hospital.org	115147.79	General Practitioner
DR0147	D19	Kanya Meesuk	doctor0147@hospital.org	68421.41	Specialist
DR0148	D18	Pimchanok Saelim	doctor0148@hospital.org	36883.56	Specialist
DR0149	D03	Nicha Jindarat	doctor0149@hospital.org	100929.93	Specialist
DR0150	D14	Nicha Jindarat	doctor0150@hospital.org	82048.25	Consultant
DR0151	D10	Jirawat Srisuk	doctor0151@hospital.org	100300.91	General Practitioner
DR0152	D17	Narin Srisuk	doctor0152@hospital.org	81307.3	Consultant
DR0153	D09	Narin Buranapong	doctor0153@hospital.org	98849.2	Consultant
DR0154	D06	Somchai Wongsa	doctor0154@hospital.org	182109.87	Consultant
DR0155	D09	Preecha Thongchai	doctor0155@hospital.org	74125.33	Consultant
DR0156	D13	Nattapong Saengthong	doctor0156@hospital.org	109390.48	Specialist
DR0157	D05	Patchara Khamdee	doctor0157@hospital.org	64383.54	Senior Specialist
DR0158	D16	Warut Rattanapong	doctor0158@hospital.org	61040.32	Consultant
DR0159	D01	Chalerm Chuenchom	doctor0159@hospital.org	61464.61	Specialist
DR0160	D16	Somchai Kittisak	doctor0160@hospital.org	95822.93	Specialist
DR0161	D13	Pimchanok Khamdee	doctor0161@hospital.org	35000	General Practitioner
DR0162	D10	Pimchanok Buranapong	doctor0162@hospital.org	103953.56	Specialist
DR0163	D18	Chalerm Prasertkul	doctor0163@hospital.org	98471.72	Specialist
DR0164	D17	Patchara Jindarat	doctor0164@hospital.org	85258.93	Senior Specialist
DR0165	D17	Kanya Boonmee	doctor0165@hospital.org	71197.79	Specialist
DR0166	D11	Anan Meesuk	doctor0166@hospital.org	93322.77	General Practitioner
DR0167	D06	Thanawat Phromma	doctor0167@hospital.org	81233.1	General Practitioner
DR0168	D10	Ratchanon Saengthong	doctor0168@hospital.org	94500.14	General Practitioner
DR0169	D16	Nattapong Boonmee	doctor0169@hospital.org	110432.98	Consultant
DR0170	D10	Kanya Saengthong	doctor0170@hospital.org	95122.88	General Practitioner
DR0171	D14	Ploy Chuenchom	doctor0171@hospital.org	64342.14	Specialist
DR0172	D02	Chalerm Rattanapong	doctor0172@hospital.org	77539.47	Specialist
DR0173	D15	Pimchanok Wattanakul	doctor0173@hospital.org	113595.75	Consultant
DR0174	D15	Thanawat Panyarat	doctor0174@hospital.org	62021.08	Senior Specialist
DR0175	D09	Suda Chantarangsu	doctor0175@hospital.org	70846.72	Specialist
DR0176	D09	Supansa Saengthong	doctor0176@hospital.org	37116.66	Specialist
DR0177	D06	Jirawat Panyarat	doctor0177@hospital.org	83114.44	Senior Specialist
DR0178	D09	Nicha Kittisak	doctor0178@hospital.org	103025.52	Specialist
DR0179	D12	Suda Chuenchom	doctor0179@hospital.org	158160.52	Senior Specialist
DR0180	D07	Preecha Saengthong	doctor0180@hospital.org	159330.75	Consultant
DR0181	D08	Preecha Srisuk	doctor0181@hospital.org	107970.26	General Practitioner
DR0182	D02	Ratchanon Wattanakul	doctor0182@hospital.org	93093.39	Senior Specialist
DR0183	D07	Anan Jindarat	doctor0183@hospital.org	126942.14	Consultant
DR0184	D06	Thanawat Chuenchom	doctor0184@hospital.org	121082.78	Specialist
DR0185	D06	Preecha Panyarat	doctor0185@hospital.org	50714.62	Senior Specialist
DR0186	D07	Thanawat Prasertkul	doctor0186@hospital.org	127162.9	Senior Specialist
DR0187	D18	Siriporn Chaiyaporn	doctor0187@hospital.org	112408.19	General Practitioner
DR0188	D15	Narin Rattanapong	doctor0188@hospital.org	100952.1	Consultant
DR0189	D03	Kanya Boonmee	doctor0189@hospital.org	58414.49	Senior Specialist
DR0190	D04	Supansa Kittisak	doctor0190@hospital.org	64825.69	Senior Specialist
DR0191	D01	Supansa Sukjai	doctor0191@hospital.org	114193.64	General Practitioner
DR0192	D09	Nattapong Buranapong	doctor0192@hospital.org	81226.61	Specialist
DR0193	D08	Siriporn Thongchai	doctor0193@hospital.org	75279.87	General Practitioner
DR0194	D06	Narin Saelim	doctor0194@hospital.org	124957.96	General Practitioner
DR0195	D03	Preecha Jindarat	doctor0195@hospital.org	95762.68	Consultant
DR0196	D03	Kanya Chaiyaporn	doctor0196@hospital.org	67575.77	Consultant
DR0197	D16	Ratchanon Kittisak	doctor0197@hospital.org	108928.23	Specialist
DR0198	D18	Kanya Boonmee	doctor0198@hospital.org	92543.18	General Practitioner
DR0199	D20	Patchara Chaiyaporn	doctor0199@hospital.org	133176.38	Senior Specialist
DR0200	D11	Kittiya Boonmee	doctor0200@hospital.org	78252.58	Senior Specialist
DR0201	D04	Kanya Srisuk	doctor0201@hospital.org	81579.41	Specialist
DR0202	D18	Ratchanon Wattanakul	doctor0202@hospital.org	81279.82	Consultant
DR0203	D13	Warut Sukjai	doctor0203@hospital.org	87967.38	Consultant
DR0204	D01	Anan Saengthong	doctor0204@hospital.org	94854.15	Specialist
DR0205	D04	Nicha Saelim	doctor0205@hospital.org	95418.4	General Practitioner
DR0206	D02	Kanya Rattanapong	doctor0206@hospital.org	117902.54	Specialist
DR0207	D05	Thanawat Phromma	doctor0207@hospital.org	91138.52	Consultant
DR0208	D07	Patchara Buranapong	doctor0208@hospital.org	127727.67	Senior Specialist
DR0209	D15	Warut Sukjai	doctor0209@hospital.org	82709.27	General Practitioner
DR0210	D07	Suda Chantarangsu	doctor0210@hospital.org	72596.63	Specialist
DR0211	D18	Narin Srisuk	doctor0211@hospital.org	132718.07	General Practitioner
DR0212	D01	Ratchanon Meesuk	doctor0212@hospital.org	131861.81	General Practitioner
DR0213	D02	Thanawat Srisuk	doctor0213@hospital.org	95931.57	Consultant
DR0214	D04	Suda Wongsa	doctor0214@hospital.org	63351.97	Consultant
DR0215	D10	Supansa Buranapong	doctor0215@hospital.org	79808.02	General Practitioner
DR0216	D10	Nicha Wongsa	doctor0216@hospital.org	102768.15	General Practitioner
DR0217	D18	Ratchanon Saengthong	doctor0217@hospital.org	72893.17	Senior Specialist
DR0218	D14	Thanawat Panyarat	doctor0218@hospital.org	84461.15	Specialist
DR0219	D08	Mali Meesuk	doctor0219@hospital.org	132176.94	Consultant
DR0220	D16	Ploy Chantarangsu	doctor0220@hospital.org	126176.59	Consultant
DR0221	D05	Somchai Chaiyaporn	doctor0221@hospital.org	94149.51	Senior Specialist
DR0222	D13	Thanawat Chantarangsu	doctor0222@hospital.org	118184.76	Specialist
DR0223	D05	Suda Chantarangsu	doctor0223@hospital.org	121428.88	Specialist
DR0224	D17	Jirawat Phromma	doctor0224@hospital.org	88659.37	Senior Specialist
DR0225	D13	Supansa Chantarangsu	doctor0225@hospital.org	60888.61	Consultant
DR0226	D20	Ploy Rattanapong	doctor0226@hospital.org	129435.32	Senior Specialist
DR0227	D05	Pimchanok Meesuk	doctor0227@hospital.org	123076.33	General Practitioner
DR0228	D11	Siriporn Kittisak	doctor0228@hospital.org	152478.9	Specialist
DR0229	D09	Nicha Panyarat	doctor0229@hospital.org	60799.47	Specialist
DR0230	D20	Narin Srisuk	doctor0230@hospital.org	130706.39	Senior Specialist
DR0231	D03	Patchara Wattanakul	doctor0231@hospital.org	93908.13	General Practitioner
DR0232	D04	Patchara Meesuk	doctor0232@hospital.org	149121.58	Consultant
DR0233	D11	Nicha Meesuk	doctor0233@hospital.org	67590.46	Consultant
DR0234	D13	Ratchanon Prasertkul	doctor0234@hospital.org	115483.86	Specialist
DR0235	D06	Suda Saengthong	doctor0235@hospital.org	50922.71	General Practitioner
DR0236	D17	Somchai Kittisak	doctor0236@hospital.org	83010.76	Specialist
DR0237	D04	Siriporn Jindarat	doctor0237@hospital.org	64195.74	General Practitioner
DR0238	D10	Patchara Sukjai	doctor0238@hospital.org	133245.63	Consultant
DR0239	D05	Siriporn Khamdee	doctor0239@hospital.org	103943.23	Consultant
DR0240	D13	Pimchanok Panyarat	doctor0240@hospital.org	35000	Consultant
DR0241	D19	Pimchanok Wattanakul	doctor0241@hospital.org	79256.97	Specialist
DR0242	D04	Somchai Kittisak	doctor0242@hospital.org	102236.16	Consultant
DR0243	D05	Kittiya Rattanapong	doctor0243@hospital.org	93813.08	General Practitioner
DR0244	D11	Kanya Khamdee	doctor0244@hospital.org	79426.91	Senior Specialist
DR0245	D11	Thanawat Saengthong	doctor0245@hospital.org	125659.68	Specialist
DR0246	D14	Nicha Khamdee	doctor0246@hospital.org	101047.8	Consultant
DR0247	D08	Pimchanok Jindarat	doctor0247@hospital.org	82085.43	Senior Specialist
DR0248	D05	Kanya Saelim	doctor0248@hospital.org	127110.64	Specialist
DR0249	D01	Kittiya Wattanakul	doctor0249@hospital.org	54382.04	Senior Specialist
DR0250	D18	Ploy Saelim	doctor0250@hospital.org	125480.91	Specialist
DR0251	D19	Jirawat Wongsa	doctor0251@hospital.org	101313.29	Specialist
DR0252	D18	Ratchanon Meesuk	doctor0252@hospital.org	70318.29	General Practitioner
DR0253	D08	Kittiya Sukjai	doctor0253@hospital.org	35000	Senior Specialist
DR0254	D20	Ploy Wongsa	doctor0254@hospital.org	101495.3	Specialist
DR0255	D19	Somchai Prasertkul	doctor0255@hospital.org	90382.47	General Practitioner
DR0256	D01	Ploy Chaiyaporn	doctor0256@hospital.org	126344.17	Senior Specialist
DR0257	D13	Warut Wongsa	doctor0257@hospital.org	82755.68	Specialist
DR0258	D07	Preecha Buranapong	doctor0258@hospital.org	90517.76	Senior Specialist
DR0259	D18	Narin Prasertkul	doctor0259@hospital.org	106984.92	Senior Specialist
DR0260	D05	Mali Saengthong	doctor0260@hospital.org	83399.98	General Practitioner
DR0261	D14	Pimchanok Saengthong	doctor0261@hospital.org	76439.83	Consultant
DR0262	D14	Chalerm Chuenchom	doctor0262@hospital.org	87314.01	Senior Specialist
DR0263	D03	Nicha Jindarat	doctor0263@hospital.org	122451.22	Specialist
DR0264	D07	Nicha Wongsa	doctor0264@hospital.org	53227.27	Senior Specialist
DR0265	D03	Nattapong Wattanakul	doctor0265@hospital.org	56990.26	Senior Specialist
DR0266	D17	Jirawat Chantarangsu	doctor0266@hospital.org	123380.44	Specialist
DR0267	D19	Mali Chaiyaporn	doctor0267@hospital.org	63499.01	General Practitioner
DR0268	D05	Nicha Wattanakul	doctor0268@hospital.org	125596.14	Senior Specialist
DR0269	D09	Nattapong Prasertkul	doctor0269@hospital.org	132932.93	General Practitioner
DR0270	D17	Ploy Jindarat	doctor0270@hospital.org	83294.29	Senior Specialist
DR0271	D18	Nattapong Wattanakul	doctor0271@hospital.org	61821.89	General Practitioner
DR0272	D03	Mali Srisuk	doctor0272@hospital.org	112689.0	Specialist
DR0273	D19	Patchara Meesuk	doctor0273@hospital.org	67644.39	General Practitioner
DR0274	D06	Patchara Chaiyaporn	doctor0274@hospital.org	88039.63	General Practitioner
DR0275	D05	Ploy Saengthong	doctor0275@hospital.org	49776.61	General Practitioner
DR0276	D01	Siriporn Saengthong	doctor0276@hospital.org	118507.13	Senior Specialist
DR0277	D05	Chalerm Wongsa	doctor0277@hospital.org	93304.97	General Practitioner
DR0278	D19	Chalerm Buranapong	doctor0278@hospital.org	90291.4	General Practitioner
DR0279	D20	Anan Rattanapong	doctor0279@hospital.org	50687.78	Consultant
DR0280	D08	Kanya Jindarat	doctor0280@hospital.org	109048.33	Consultant
DR0281	D07	Suda Chaiyaporn	doctor0281@hospital.org	131565.22	Specialist
DR0282	D10	Warut Rattanapong	doctor0282@hospital.org	61745.13	General Practitioner
DR0283	D14	Kanya Wattanakul	doctor0283@hospital.org	83448.59	General Practitioner
DR0284	D08	Preecha Thongchai	doctor0284@hospital.org	99784.01	Senior Specialist
DR0285	D18	Kanya Phromma	doctor0285@hospital.org	101263.83	Senior Specialist
DR0286	D04	Patchara Prasertkul	doctor0286@hospital.org	83811.59	Consultant
DR0287	D03	Kanya Phromma	doctor0287@hospital.org	62988.02	Senior Specialist
DR0288	D07	Thanawat Panyarat	doctor0288@hospital.org	107976.19	Senior Specialist
DR0289	D09	Narin Prasertkul	doctor0289@hospital.org	156655.27	General Practitioner
DR0290	D04	Supansa Prasertkul	doctor0290@hospital.org	105088.96	Consultant
DR0291	D17	Ratchanon Saengthong	doctor0291@hospital.org	139477.15	Specialist
DR0292	D14	Jirawat Wattanakul	doctor0292@hospital.org	89381.93	Senior Specialist
DR0293	D03	Jirawat Buranapong	doctor0293@hospital.org	35000	Specialist
DR0294	D05	Mali Wattanakul	doctor0294@hospital.org	130116.54	Consultant
DR0295	D15	Suda Wongsa	doctor0295@hospital.org	89692.57	General Practitioner
DR0296	D14	Narin Jindarat	doctor0296@hospital.org	58279.96	Senior Specialist
DR0297	D19	Suda Saengthong	doctor0297@hospital.org	127132.05	General Practitioner
DR0298	D03	Chalerm Prasertkul	doctor0298@hospital.org	72472.01	Senior Specialist
DR0299	D03	Chalerm Chaiyaporn	doctor0299@hospital.org	57281.34	Consultant
DR0300	D06	Ratchanon Chuenchom	doctor0300@hospital.org	114259.23	Consultant
DR0301	D06	Patchara Chuenchom	doctor0301@hospital.org	102266.66	Consultant
DR0302	D08	Thanawat Panyarat	doctor0302@hospital.org	113537.9	Specialist
DR0303	D12	Warut Meesuk	doctor0303@hospital.org	127953.51	General Practitioner
DR0304	D10	Mali Thongchai	doctor0304@hospital.org	94025.6	General Practitioner
DR0305	D16	Somchai Prasertkul	doctor0305@hospital.org	77135.88	Senior Specialist
DR0306	D05	Nattapong Boonmee	doctor0306@hospital.org	79450.47	General Practitioner
DR0307	D04	Thanawat Boonmee	doctor0307@hospital.org	98584.01	Senior Specialist
DR0308	D03	Siriporn Meesuk	doctor0308@hospital.org	60511.1	Consultant
DR0309	D11	Suda Wattanakul	doctor0309@hospital.org	132056.37	Consultant
DR0310	D12	Thanawat Khamdee	doctor0310@hospital.org	133767.92	Consultant
DR0311	D15	Kanya Buranapong	doctor0311@hospital.org	121213.05	Specialist
DR0312	D19	Jirawat Jindarat	doctor0312@hospital.org	82150.78	General Practitioner
DR0313	D01	Chalerm Phromma	doctor0313@hospital.org	128781.97	Specialist
DR0314	D05	Somchai Kittisak	doctor0314@hospital.org	134628.76	Consultant
DR0315	D01	Pimchanok Chantarangsu	doctor0315@hospital.org	143257.47	Specialist
DR0316	D03	Patchara Thongchai	doctor0316@hospital.org	74087.0	Specialist
DR0317	D14	Narin Wattanakul	doctor0317@hospital.org	81083.55	Consultant
DR0318	D17	Preecha Sukjai	doctor0318@hospital.org	94413.2	Consultant
DR0319	D09	Suda Sukjai	doctor0319@hospital.org	104881.12	Specialist
DR0320	D05	Suda Rattanapong	doctor0320@hospital.org	80204.04	Senior Specialist
DR0321	D12	Anan Jindarat	doctor0321@hospital.org	108837.26	Consultant
DR0322	D09	Kanya Wongsa	doctor0322@hospital.org	78848.07	Specialist
DR0323	D12	Nattapong Chuenchom	doctor0323@hospital.org	62732.03	General Practitioner
DR0324	D09	Siriporn Panyarat	doctor0324@hospital.org	53760.46	Specialist
DR0325	D01	Kanya Kittisak	doctor0325@hospital.org	130837.13	Senior Specialist
DR0326	D20	Ratchanon Chaiyaporn	doctor0326@hospital.org	106054.59	Senior Specialist
DR0327	D16	Warut Kittisak	doctor0327@hospital.org	113908.76	Specialist
DR0328	D12	Supansa Jindarat	doctor0328@hospital.org	80341.41	Senior Specialist
DR0329	D01	Patchara Chaiyaporn	doctor0329@hospital.org	86727.31	Senior Specialist
DR0330	D12	Warut Chuenchom	doctor0330@hospital.org	95598.63	Specialist
DR0331	D02	Patchara Chaiyaporn	doctor0331@hospital.org	179853.52	Senior Specialist
DR0332	D13	Pimchanok Panyarat	doctor0332@hospital.org	131152.57	Consultant
DR0333	D03	Nicha Saelim	doctor0333@hospital.org	50960.32	General Practitioner
DR0334	D14	Ploy Chuenchom	doctor0334@hospital.org	85900.88	Senior Specialist
DR0335	D09	Nattapong Panyarat	doctor0335@hospital.org	80517.74	General Practitioner
DR0336	D01	Jirawat Chantarangsu	doctor0336@hospital.org	96455.3	Consultant
DR0337	D09	Nicha Rattanapong	doctor0337@hospital.org	74573.93	Specialist
DR0338	D01	Somchai Rattanapong	doctor0338@hospital.org	139839.13	Senior Specialist
DR0339	D03	Nicha Jindarat	doctor0339@hospital.org	84329.95	Senior Specialist
DR0340	D18	Somchai Wongsa	doctor0340@hospital.org	72974.76	Consultant
DR0341	D12	Pimchanok Panyarat	doctor0341@hospital.org	40298.87	Specialist
DR0342	D12	Chalerm Jindarat	doctor0342@hospital.org	133990.84	General Practitioner
DR0343	D12	Ploy Wongsa	doctor0343@hospital.org	94279.11	Specialist
DR0344	D14	Kittiya Sukjai	doctor0344@hospital.org	84631.27	General Practitioner
DR0345	D09	Thanawat Boonmee	doctor0345@hospital.org	128695.84	Senior Specialist
DR0346	D10	Patchara Chaiyaporn	doctor0346@hospital.org	56364.16	Senior Specialist
DR0347	D13	Suda Saelim	doctor0347@hospital.org	94838.44	General Practitioner
DR0348	D09	Siriporn Wattanakul	doctor0348@hospital.org	61154.61	Consultant
DR0349	D04	Nicha Chantarangsu	doctor0349@hospital.org	83364.92	Senior Specialist
DR0350	D16	Thanawat Rattanapong	doctor0350@hospital.org	73293.45	Senior Specialist
DR0351	D11	Suda Chuenchom	doctor0351@hospital.org	140599.85	Specialist
DR0352	D18	Jirawat Khamdee	doctor0352@hospital.org	102278.63	Senior Specialist
DR0353	D08	Preecha Khamdee	doctor0353@hospital.org	85431.09	Specialist
DR0354	D16	Mali Boonmee	doctor0354@hospital.org	81563.33	Senior Specialist
DR0355	D19	Pimchanok Chantarangsu	doctor0355@hospital.org	99496.06	General Practitioner
DR0356	D18	Pimchanok Sukjai	doctor0356@hospital.org	65616.14	General Practitioner
DR0357	D15	Jirawat Chaiyaporn	doctor0357@hospital.org	177237.69	General Practitioner
DR0358	D17	Patchara Chuenchom	doctor0358@hospital.org	48065.55	General Practitioner
DR0359	D04	Ploy Kittisak	doctor0359@hospital.org	118488.82	Senior Specialist
DR0360	D17	Nattapong Thongchai	doctor0360@hospital.org	103375.77	Specialist
DR0361	D16	Preecha Phromma	doctor0361@hospital.org	85447.85	Specialist
DR0362	D05	Mali Saelim	doctor0362@hospital.org	118464.55	Specialist
DR0363	D20	Preecha Rattanapong	doctor0363@hospital.org	78901.33	Senior Specialist
DR0364	D04	Supansa Thongchai	doctor0364@hospital.org	79599.73	Consultant
DR0365	D10	Thanawat Wongsa	doctor0365@hospital.org	79678.25	Specialist
DR0366	D01	Supansa Sukjai	doctor0366@hospital.org	117787.58	Consultant
DR0367	D15	Warut Chuenchom	doctor0367@hospital.org	35000	Specialist
DR0368	D05	Mali Phromma	doctor0368@hospital.org	86101.32	Consultant
DR0369	D08	Nicha Thongchai	doctor0369@hospital.org	108991.81	Consultant
DR0370	D09	Anan Wattanakul	doctor0370@hospital.org	58846.88	General Practitioner
DR0371	D05	Kanya Sukjai	doctor0371@hospital.org	118659.63	General Practitioner
DR0372	D09	Patchara Khamdee	doctor0372@hospital.org	45992.21	Consultant
DR0373	D11	Suda Kittisak	doctor0373@hospital.org	80226.04	Consultant
DR0374	D13	Anan Panyarat	doctor0374@hospital.org	96391.84	Specialist
DR0375	D11	Narin Saelim	doctor0375@hospital.org	71548.31	Senior Specialist
DR0376	D02	Narin Buranapong	doctor0376@hospital.org	117328.55	Consultant
DR0377	D08	Supansa Saengthong	doctor0377@hospital.org	130304.3	Consultant
DR0378	D09	Nattapong Buranapong	doctor0378@hospital.org	83507.99	General Practitioner
DR0379	D10	Narin Prasertkul	doctor0379@hospital.org	100110.37	General Practitioner
DR0380	D02	Ratchanon Saelim	doctor0380@hospital.org	97422.36	Consultant
DR0381	D09	Kanya Chaiyaporn	doctor0381@hospital.org	100903.02	General Practitioner
DR0382	D15	Suda Srisuk	doctor0382@hospital.org	130132.06	Specialist
DR0383	D08	Jirawat Buranapong	doctor0383@hospital.org	131508.33	Senior Specialist
DR0384	D06	Kanya Chuenchom	doctor0384@hospital.org	88385.38	Senior Specialist
DR0385	D07	Thanawat Rattanapong	doctor0385@hospital.org	92657.13	Senior Specialist
DR0386	D04	Pimchanok Chuenchom	doctor0386@hospital.org	83602.87	Senior Specialist
DR0387	D09	Supansa Saelim	doctor0387@hospital.org	65933.23	Specialist
DR0388	D05	Suda Khamdee	doctor0388@hospital.org	126355.18	Senior Specialist
DR0389	D06	Nattapong Thongchai	doctor0389@hospital.org	113867.66	Senior Specialist
DR0390	D09	Patchara Kittisak	doctor0390@hospital.org	105519.21	Senior Specialist
DR0391	D09	Nattapong Kittisak	doctor0391@hospital.org	56358.79	Consultant
DR0392	D20	Anan Wattanakul	doctor0392@hospital.org	120841.15	General Practitioner
DR0393	D17	Mali Prasertkul	doctor0393@hospital.org	97314.38	General Practitioner
DR0394	D05	Mali Saengthong	doctor0394@hospital.org	87154.43	Consultant
DR0395	D04	Chalerm Prasertkul	doctor0395@hospital.org	72400.31	Consultant
DR0396	D17	Warut Chuenchom	doctor0396@hospital.org	101361.98	Consultant
DR0397	D20	Warut Wongsa	doctor0397@hospital.org	98037.27	Senior Specialist
DR0398	D06	Kanya Khamdee	doctor0398@hospital.org	35000	Specialist
DR0399	D13	Narin Prasertkul	doctor0399@hospital.org	130743.84	Consultant
DR0400	D15	Warut Rattanapong	doctor0400@hospital.org	55868.46	Specialist
DR0401	D10	Mali Prasertkul	doctor0401@hospital.org	102424.23	General Practitioner
DR0402	D14	Pimchanok Srisuk	doctor0402@hospital.org	95982.17	Specialist
DR0403	D12	Siriporn Saengthong	doctor0403@hospital.org	106157.79	Consultant
DR0404	D18	Ploy Srisuk	doctor0404@hospital.org	91828.01	Consultant
DR0405	D03	Narin Chantarangsu	doctor0405@hospital.org	94633.38	Senior Specialist
DR0406	D12	Kittiya Sukjai	doctor0406@hospital.org	94716.99	General Practitioner
DR0407	D14	Warut Kittisak	doctor0407@hospital.org	101718.19	Consultant
DR0408	D05	Kittiya Sukjai	doctor0408@hospital.org	138545.97	Senior Specialist
DR0409	D07	Pimchanok Wongsa	doctor0409@hospital.org	72079.53	Consultant
DR0410	D10	Supansa Phromma	doctor0410@hospital.org	88792.62	Consultant
DR0411	D04	Preecha Thongchai	doctor0411@hospital.org	139036.0	Consultant
DR0412	D02	Ratchanon Kittisak	doctor0412@hospital.org	95732.27	Specialist
DR0413	D05	Warut Prasertkul	doctor0413@hospital.org	123135.47	Senior Specialist
DR0414	D18	Narin Wattanakul	doctor0414@hospital.org	57758.83	Consultant
DR0415	D18	Kittiya Srisuk	doctor0415@hospital.org	87885.08	General Practitioner
DR0416	D11	Suda Saengthong	doctor0416@hospital.org	96521.86	Specialist
DR0417	D04	Patchara Chuenchom	doctor0417@hospital.org	46328.1	General Practitioner
DR0418	D10	Preecha Rattanapong	doctor0418@hospital.org	117957.8	General Practitioner
DR0419	D01	Preecha Rattanapong	doctor0419@hospital.org	93119.88	Senior Specialist
DR0420	D16	Thanawat Chuenchom	doctor0420@hospital.org	101272.64	Senior Specialist
DR0421	D18	Nattapong Saengthong	doctor0421@hospital.org	51567.94	Consultant
DR0422	D19	Pimchanok Chaiyaporn	doctor0422@hospital.org	89447.92	General Practitioner
DR0423	D12	Ploy Srisuk	doctor0423@hospital.org	148665.59	General Practitioner
DR0424	D14	Ratchanon Jindarat	doctor0424@hospital.org	51076.96	Specialist
DR0425	D17	Siriporn Kittisak	doctor0425@hospital.org	113620.4	Senior Specialist
DR0426	D01	Anan Meesuk	doctor0426@hospital.org	51110.39	Senior Specialist
DR0427	D10	Mali Chuenchom	doctor0427@hospital.org	76901.39	General Practitioner
DR0428	D19	Suda Chuenchom	doctor0428@hospital.org	50332.35	Senior Specialist
DR0429	D03	Suda Chantarangsu	doctor0429@hospital.org	109891.4	Senior Specialist
DR0430	D10	Somchai Rattanapong	doctor0430@hospital.org	60560.21	Consultant
DR0431	D06	Patchara Khamdee	doctor0431@hospital.org	44078.58	Consultant
DR0432	D17	Siriporn Wongsa	doctor0432@hospital.org	75266.24	Specialist
DR0433	D11	Supansa Saelim	doctor0433@hospital.org	109294.47	Senior Specialist
DR0434	D01	Narin Sukjai	doctor0434@hospital.org	42287.94	Senior Specialist
DR0435	D09	Anan Wattanakul	doctor0435@hospital.org	57176.07	General Practitioner
DR0436	D09	Chalerm Thongchai	doctor0436@hospital.org	123563.02	Senior Specialist
DR0437	D18	Warut Chantarangsu	doctor0437@hospital.org	56043.79	Senior Specialist
DR0438	D10	Somchai Chaiyaporn	doctor0438@hospital.org	118972.86	Senior Specialist
DR0439	D12	Nattapong Buranapong	doctor0439@hospital.org	99553.39	Senior Specialist
DR0440	D06	Kittiya Boonmee	doctor0440@hospital.org	87996.55	Specialist
DR0441	D09	Ploy Buranapong	doctor0441@hospital.org	127962.13	Specialist
DR0442	D15	Nattapong Wongsa	doctor0442@hospital.org	109380.24	Senior Specialist
DR0443	D08	Ploy Sukjai	doctor0443@hospital.org	160302.38	Specialist
DR0444	D20	Anan Saengthong	doctor0444@hospital.org	84483.55	Consultant
DR0445	D18	Ratchanon Saengthong	doctor0445@hospital.org	120551.17	Specialist
DR0446	D05	Ploy Wattanakul	doctor0446@hospital.org	66145.14	Specialist
DR0447	D11	Somchai Srisuk	doctor0447@hospital.org	89852.45	Senior Specialist
DR0448	D02	Pimchanok Thongchai	doctor0448@hospital.org	91783.03	General Practitioner
DR0449	D01	Somchai Srisuk	doctor0449@hospital.org	40884.88	General Practitioner
DR0450	D06	Ploy Thongchai	doctor0450@hospital.org	77292.08	Specialist
DR0451	D05	Thanawat Wattanakul	doctor0451@hospital.org	119506.64	General Practitioner
DR0452	D12	Pimchanok Buranapong	doctor0452@hospital.org	130295.57	Specialist
DR0453	D09	Anan Meesuk	doctor0453@hospital.org	136237.54	Consultant
DR0454	D11	Jirawat Boonmee	doctor0454@hospital.org	111706.12	Senior Specialist
DR0455	D09	Nicha Chantarangsu	doctor0455@hospital.org	84165.09	Specialist
DR0456	D19	Pimchanok Buranapong	doctor0456@hospital.org	59078.2	Senior Specialist
DR0457	D18	Anan Boonmee	doctor0457@hospital.org	81969.31	Specialist
DR0458	D07	Warut Srisuk	doctor0458@hospital.org	112055.11	Consultant
DR0459	D10	Ploy Prasertkul	doctor0459@hospital.org	121826.71	Consultant
DR0460	D06	Supansa Wattanakul	doctor0460@hospital.org	107282.73	Senior Specialist
DR0461	D17	Siriporn Meesuk	doctor0461@hospital.org	72520.94	Specialist
DR0462	D03	Kittiya Wongsa	doctor0462@hospital.org	88254.41	Specialist
DR0463	D04	Chalerm Chaiyaporn	doctor0463@hospital.org	132735.73	General Practitioner
DR0464	D16	Thanawat Wongsa	doctor0464@hospital.org	64088.91	Senior Specialist
DR0465	D07	Kittiya Jindarat	doctor0465@hospital.org	111662.68	Senior Specialist
DR0466	D14	Supansa Saelim	doctor0466@hospital.org	106503.13	Consultant
DR0467	D10	Kanya Meesuk	doctor0467@hospital.org	120949.52	General Practitioner
DR0468	D07	Somchai Srisuk	doctor0468@hospital.org	110213.09	General Practitioner
DR0469	D10	Patchara Thongchai	doctor0469@hospital.org	67013.98	Specialist
DR0470	D12	Narin Jindarat	doctor0470@hospital.org	109495.71	General Practitioner
DR0471	D19	Narin Sukjai	doctor0471@hospital.org	76398.21	Senior Specialist
DR0472	D03	Suda Panyarat	doctor0472@hospital.org	71765.52	Consultant
DR0473	D12	Anan Saelim	doctor0473@hospital.org	93463.22	Consultant
DR0474	D03	Preecha Srisuk	doctor0474@hospital.org	143296.07	Consultant
DR0475	D02	Nattapong Jindarat	doctor0475@hospital.org	120416.44	Specialist
DR0476	D18	Chalerm Meesuk	doctor0476@hospital.org	106334.79	Consultant
DR0477	D13	Anan Srisuk	doctor0477@hospital.org	44279.93	Specialist
DR0478	D19	Nicha Rattanapong	doctor0478@hospital.org	132238.64	Senior Specialist
DR0479	D10	Nicha Jindarat	doctor0479@hospital.org	134226.91	Consultant
DR0480	D08	Kittiya Phromma	doctor0480@hospital.org	124427.67	General Practitioner
DR0481	D19	Siriporn Meesuk	doctor0481@hospital.org	153175.17	General Practitioner
DR0482	D03	Ploy Rattanapong	doctor0482@hospital.org	79640.79	Specialist
DR0483	D12	Patchara Meesuk	doctor0483@hospital.org	105517.32	Specialist
DR0484	D11	Pimchanok Boonmee	doctor0484@hospital.org	66985.44	Specialist
DR0485	D14	Anan Phromma	doctor0485@hospital.org	103436.56	Consultant
DR0486	D12	Thanawat Jindarat	doctor0486@hospital.org	135097.59	General Practitioner
DR0487	D14	Kittiya Chuenchom	doctor0487@hospital.org	127392.67	Consultant
DR0488	D16	Suda Jindarat	doctor0488@hospital.org	101028.05	Consultant
DR0489	D09	Ploy Meesuk	doctor0489@hospital.org	102045.16	General Practitioner
DR0490	D03	Anan Chuenchom	doctor0490@hospital.org	131889.74	Consultant
DR0491	D07	Nattapong Chaiyaporn	doctor0491@hospital.org	137078.29	Senior Specialist
DR0492	D06	Nicha Chantarangsu	doctor0492@hospital.org	171603.96	Consultant
DR0493	D01	Pimchanok Buranapong	doctor0493@hospital.org	133473.34	General Practitioner
DR0494	D03	Nicha Buranapong	doctor0494@hospital.org	102504.03	Specialist
DR0495	D20	Jirawat Chantarangsu	doctor0495@hospital.org	119896.54	Specialist
DR0496	D09	Jirawat Sukjai	doctor0496@hospital.org	68619.08	Consultant
DR0497	D02	Preecha Chaiyaporn	doctor0497@hospital.org	99734.34	General Practitioner
DR0498	D12	Pimchanok Sukjai	doctor0498@hospital.org	67852.75	Senior Specialist
DR0499	D13	Kanya Wongsa	doctor0499@hospital.org	92857.67	Senior Specialist
DR0500	D05	Nattapong Thongchai	doctor0500@hospital.org	106616.12	Consultant
DR0501	D19	Warut Wongsa	doctor0501@hospital.org	750000.0	Senior Specialist
DR0502	D15	Jirawat Saelim	doctor0502@hospital.org	101550.48	Specialist
DR0503	D03	Narin Srisuk	doctor0503@hospital.org	99657.59	Consultant
DR0504	D06	Kanya Khamdee	doctor0504@hospital.org	112865.45	Senior Specialist
DR0505	D11	Patchara Buranapong	doctor0505@hospital.org	76533.13	Specialist
DR0506	D20	Kittiya Chuenchom	doctor0506@hospital.org	98085.02	Senior Specialist
DR0507	D04	Thanawat Phromma	doctor0507@hospital.org	100854.49	Consultant
DR0508	D10	Supansa Kittisak	doctor0508@hospital.org	120859.85	Senior Specialist
DR0509	D01	Ratchanon Chuenchom	doctor0509@hospital.org	90636.0	General Practitioner
DR0510	D03	Thanawat Boonmee	doctor0510@hospital.org	128087.11	Senior Specialist
DR0511	D17	Supansa Phromma	doctor0511@hospital.org	111452.2	Senior Specialist
DR0512	D12	Suda Kittisak	doctor0512@hospital.org	109557.82	Senior Specialist
DR0513	D07	Ratchanon Khamdee	doctor0513@hospital.org	83784.97	Consultant
DR0514	D18	Preecha Saengthong	doctor0514@hospital.org	35000	Specialist
DR0515	D18	Narin Khamdee	doctor0515@hospital.org	81595.72	General Practitioner
DR0516	D17	Siriporn Kittisak	doctor0516@hospital.org	96610.3	Specialist
DR0517	D05	Nicha Meesuk	doctor0517@hospital.org	103983.25	Consultant
DR0518	D12	Chalerm Prasertkul	doctor0518@hospital.org	120151.96	General Practitioner
DR0519	D14	Nicha Wattanakul	doctor0519@hospital.org	126931.76	General Practitioner
DR0520	D08	Supansa Kittisak	doctor0520@hospital.org	105568.6	Consultant
DR0521	D05	Supansa Wongsa	doctor0521@hospital.org	134346.57	Consultant
DR0522	D20	Ploy Sukjai	doctor0522@hospital.org	94335.92	General Practitioner
DR0523	D19	Kittiya Panyarat	doctor0523@hospital.org	91446.09	General Practitioner
DR0524	D10	Suda Wongsa	doctor0524@hospital.org	35000	General Practitioner
DR0525	D19	Patchara Khamdee	doctor0525@hospital.org	63199.29	General Practitioner
DR0526	D14	Somchai Phromma	doctor0526@hospital.org	115273.0	Senior Specialist
DR0527	D03	Siriporn Rattanapong	doctor0527@hospital.org	110513.18	General Practitioner
DR0528	D13	Anan Chuenchom	doctor0528@hospital.org	119134.66	Consultant
DR0529	D20	Somchai Chantarangsu	doctor0529@hospital.org	132829.63	Consultant
DR0530	D15	Mali Rattanapong	doctor0530@hospital.org	79889.3	Specialist
DR0531	D01	Chalerm Saengthong	doctor0531@hospital.org	35000	Specialist
DR0532	D16	Suda Sukjai	doctor0532@hospital.org	93098.75	Senior Specialist
DR0533	D13	Warut Thongchai	doctor0533@hospital.org	119346.0	Senior Specialist
DR0534	D13	Narin Saengthong	doctor0534@hospital.org	138621.68	General Practitioner
DR0535	D12	Ratchanon Rattanapong	doctor0535@hospital.org	100135.2	Consultant
DR0536	D02	Kittiya Thongchai	doctor0536@hospital.org	89206.16	General Practitioner
DR0537	D20	Kittiya Srisuk	doctor0537@hospital.org	127277.65	Senior Specialist
DR0538	D20	Siriporn Sukjai	doctor0538@hospital.org	104111.16	Consultant
DR0539	D14	Ploy Chaiyaporn	doctor0539@hospital.org	118385.37	Senior Specialist
DR0540	D11	Suda Saelim	doctor0540@hospital.org	137028.17	Senior Specialist
DR0541	D18	Siriporn Rattanapong	doctor0541@hospital.org	37238.46	General Practitioner
DR0542	D06	Mali Boonmee	doctor0542@hospital.org	94539.35	Specialist
DR0543	D14	Nattapong Buranapong	doctor0543@hospital.org	76683.05	General Practitioner
DR0544	D12	Ploy Thongchai	doctor0544@hospital.org	80389.69	Consultant
DR0545	D14	Narin Kittisak	doctor0545@hospital.org	145189.07	Senior Specialist
DR0546	D17	Ploy Chantarangsu	doctor0546@hospital.org	98549.32	Senior Specialist
DR0547	D08	Ploy Jindarat	doctor0547@hospital.org	91342.92	Consultant
DR0548	D04	Ratchanon Wattanakul	doctor0548@hospital.org	96735.99	General Practitioner
DR0549	D18	Chalerm Srisuk	doctor0549@hospital.org	35000	Specialist
DR0550	D06	Mali Rattanapong	doctor0550@hospital.org	88253.26	General Practitioner
DR0551	D03	Pimchanok Meesuk	doctor0551@hospital.org	116519.86	Specialist
DR0552	D19	Supansa Chaiyaporn	doctor0552@hospital.org	117471.96	General Practitioner
DR0553	D13	Pimchanok Chantarangsu	doctor0553@hospital.org	130361.5	Specialist
DR0554	D13	Pimchanok Kittisak	doctor0554@hospital.org	81307.97	General Practitioner
DR0555	D10	Kittiya Chantarangsu	doctor0555@hospital.org	80113.5	Specialist
DR0556	D18	Nattapong Kittisak	doctor0556@hospital.org	100663.04	Specialist
DR0557	D06	Supansa Wattanakul	doctor0557@hospital.org	121948.28	Senior Specialist
DR0558	D08	Kittiya Khamdee	doctor0558@hospital.org	61929.8	Consultant
DR0559	D12	Nattapong Jindarat	doctor0559@hospital.org	95943.78	Specialist
DR0560	D01	Preecha Rattanapong	doctor0560@hospital.org	68187.55	Senior Specialist
DR0561	D17	Warut Meesuk	doctor0561@hospital.org	115098.63	Consultant
DR0562	D12	Warut Panyarat	doctor0562@hospital.org	95182.37	General Practitioner
DR0563	D06	Chalerm Chaiyaporn	doctor0563@hospital.org	119967.25	Senior Specialist
DR0564	D07	Ploy Khamdee	doctor0564@hospital.org	86044.03	Specialist
DR0565	D04	Somchai Saelim	doctor0565@hospital.org	90242.1	Senior Specialist
DR0566	D04	Suda Rattanapong	doctor0566@hospital.org	39587.22	General Practitioner
DR0567	D07	Ratchanon Saelim	doctor0567@hospital.org	72661.23	Senior Specialist
DR0568	D20	Ratchanon Saengthong	doctor0568@hospital.org	91372.25	General Practitioner
DR0569	D10	Preecha Meesuk	doctor0569@hospital.org	96638.64	Specialist
DR0570	D17	Pimchanok Srisuk	doctor0570@hospital.org	134264.8	Consultant
DR0571	D14	Jirawat Saelim	doctor0571@hospital.org	108295.28	Specialist
DR0572	D20	Thanawat Wattanakul	doctor0572@hospital.org	101608.9	Consultant
DR0573	D07	Suda Meesuk	doctor0573@hospital.org	120534.85	Consultant
DR0574	D10	Jirawat Phromma	doctor0574@hospital.org	85084.12	Specialist
DR0575	D16	Kanya Panyarat	doctor0575@hospital.org	73637.6	Senior Specialist
DR0576	D03	Nicha Panyarat	doctor0576@hospital.org	51993.67	General Practitioner
DR0577	D13	Kanya Boonmee	doctor0577@hospital.org	98750.27	Senior Specialist
DR0578	D03	Thanawat Thongchai	doctor0578@hospital.org	120408.55	Senior Specialist
DR0579	D16	Narin Jindarat	doctor0579@hospital.org	84923.73	Consultant
DR0580	D15	Jirawat Buranapong	doctor0580@hospital.org	67321.39	Specialist
DR0581	D14	Ratchanon Prasertkul	doctor0581@hospital.org	138204.4	Senior Specialist
DR0582	D05	Chalerm Chantarangsu	doctor0582@hospital.org	86897.26	General Practitioner
DR0583	D12	Narin Kittisak	doctor0583@hospital.org	67064.9	General Practitioner
DR0584	D12	Pimchanok Sukjai	doctor0584@hospital.org	62173.85	Senior Specialist
DR0585	D13	Narin Boonmee	doctor0585@hospital.org	107380.46	General Practitioner
DR0586	D11	Patchara Chuenchom	doctor0586@hospital.org	79414.3	Senior Specialist
DR0587	D02	Preecha Chaiyaporn	doctor0587@hospital.org	95685.67	Senior Specialist
DR0588	D13	Mali Boonmee	doctor0588@hospital.org	93355.66	Specialist
DR0589	D20	Jirawat Saelim	doctor0589@hospital.org	141000.31	General Practitioner
DR0590	D08	Preecha Chaiyaporn	doctor0590@hospital.org	35000	Senior Specialist
DR0591	D20	Supansa Saengthong	doctor0591@hospital.org	108907.57	General Practitioner
DR0592	D03	Chalerm Wongsa	doctor0592@hospital.org	122956.9	General Practitioner
DR0593	D17	Ploy Phromma	doctor0593@hospital.org	100467.79	Consultant
DR0594	D06	Siriporn Buranapong	doctor0594@hospital.org	81221.85	General Practitioner
DR0595	D12	Jirawat Thongchai	doctor0595@hospital.org	96486.57	Consultant
DR0596	D04	Preecha Jindarat	doctor0596@hospital.org	62833.28	General Practitioner
DR0597	D12	Thanawat Chaiyaporn	doctor0597@hospital.org	58641.34	Specialist
DR0598	D03	Thanawat Jindarat	doctor0598@hospital.org	124351.51	General Practitioner
DR0599	D09	Nattapong Chuenchom	doctor0599@hospital.org	99953.35	General Practitioner
DR0600	D11	Jirawat Kittisak	doctor0600@hospital.org	83378.25	Senior Specialist
DR0601	D10	Mali Buranapong	doctor0601@hospital.org	89230.51	Senior Specialist
DR0602	D09	Siriporn Chantarangsu	doctor0602@hospital.org	114733.19	Specialist
DR0603	D06	Anan Wattanakul	doctor0603@hospital.org	72034.9	Specialist
DR0604	D19	Ploy Chuenchom	doctor0604@hospital.org	102784.36	Consultant
DR0605	D20	Thanawat Rattanapong	doctor0605@hospital.org	36681.98	Consultant
DR0606	D19	Pimchanok Boonmee	doctor0606@hospital.org	87069.99	Senior Specialist
DR0607	D10	Ratchanon Thongchai	doctor0607@hospital.org	78456.23	Consultant
DR0608	D03	Mali Panyarat	doctor0608@hospital.org	78009.2	Specialist
DR0609	D17	Thanawat Sukjai	doctor0609@hospital.org	121338.28	General Practitioner
DR0610	D09	Warut Panyarat	doctor0610@hospital.org	136198.47	Consultant
DR0611	D19	Siriporn Panyarat	doctor0611@hospital.org	87510.52	Senior Specialist
DR0612	D06	Kanya Jindarat	doctor0612@hospital.org	120627.28	General Practitioner
DR0613	D04	Siriporn Chaiyaporn	doctor0613@hospital.org	60130.07	Specialist
DR0614	D03	Nicha Saelim	\N	86306.03	Consultant
DR0615	D14	Ploy Khamdee	doctor0615@hospital.org	124031.22	Senior Specialist
DR0616	D15	Mali Wongsa	doctor0616@hospital.org	69822.78	Consultant
DR0617	D07	Somchai Jindarat	doctor0617@hospital.org	128201.86	Consultant
DR0618	D13	Preecha Panyarat	doctor0618@hospital.org	138334.33	Senior Specialist
DR0619	D19	Pimchanok Saelim	doctor0619@hospital.org	125556.53	Senior Specialist
DR0620	D15	Kittiya Kittisak	doctor0620@hospital.org	67675.6	Specialist
DR0621	D09	Kittiya Buranapong	doctor0621@hospital.org	99375.44	Specialist
DR0622	D02	Mali Saelim	doctor0622@hospital.org	124399.17	Senior Specialist
DR0623	D14	Kanya Rattanapong	doctor0623@hospital.org	99515.2	General Practitioner
DR0624	D08	Warut Meesuk	doctor0624@hospital.org	87952.69	General Practitioner
DR0625	D02	Chalerm Saengthong	doctor0625@hospital.org	74923.29	Consultant
DR0626	D05	Siriporn Jindarat	doctor0626@hospital.org	133519.97	Senior Specialist
DR0627	D02	Warut Kittisak	doctor0627@hospital.org	129664.28	Senior Specialist
DR0628	D03	Narin Chuenchom	doctor0628@hospital.org	120695.85	Specialist
DR0629	D20	Anan Panyarat	doctor0629@hospital.org	138017.37	Specialist
DR0630	D18	Suda Prasertkul	doctor0630@hospital.org	131879.98	Senior Specialist
DR0631	D11	Ratchanon Chaiyaporn	doctor0631@hospital.org	108955.39	Specialist
DR0632	D04	Patchara Wongsa	doctor0632@hospital.org	99316.86	Specialist
DR0633	D09	Jirawat Meesuk	doctor0633@hospital.org	62538.2	Specialist
DR0634	D10	Siriporn Kittisak	doctor0634@hospital.org	109272.56	Consultant
DR0635	D07	Nicha Kittisak	doctor0635@hospital.org	48983.62	Consultant
DR0636	D07	Kanya Chantarangsu	doctor0636@hospital.org	125560.78	Consultant
DR0637	D20	Suda Wongsa	doctor0637@hospital.org	102413.49	Consultant
DR0638	D19	Somchai Chaiyaporn	doctor0638@hospital.org	131549.41	General Practitioner
DR0639	D07	Narin Rattanapong	doctor0639@hospital.org	112392.88	Specialist
DR0640	D19	Kittiya Jindarat	doctor0640@hospital.org	79441.84	Consultant
DR0641	D20	Siriporn Chantarangsu	doctor0641@hospital.org	73455.53	Consultant
DR0642	D13	Somchai Boonmee	doctor0642@hospital.org	80767.96	Senior Specialist
DR0643	D07	Nicha Khamdee	doctor0643@hospital.org	66484.81	Specialist
DR0644	D13	Jirawat Prasertkul	doctor0644@hospital.org	35000	General Practitioner
DR0645	D15	Somchai Chuenchom	doctor0645@hospital.org	116702.54	Consultant
DR0646	D18	Kittiya Sukjai	doctor0646@hospital.org	98638.68	Senior Specialist
DR0647	D18	Chalerm Panyarat	doctor0647@hospital.org	126154.83	General Practitioner
DR0648	D12	Chalerm Wattanakul	doctor0648@hospital.org	115645.88	Consultant
DR0649	D04	Preecha Buranapong	doctor0649@hospital.org	87216.08	Consultant
DR0650	D07	Suda Kittisak	doctor0650@hospital.org	111546.94	Senior Specialist
DR0651	D05	Nicha Prasertkul	doctor0651@hospital.org	74490.84	Specialist
DR0652	D02	Nattapong Jindarat	doctor0652@hospital.org	83645.39	Consultant
DR0653	D05	Siriporn Buranapong	doctor0653@hospital.org	84128.34	General Practitioner
DR0654	D02	Warut Saelim	doctor0654@hospital.org	75915.66	Senior Specialist
DR0655	D09	Supansa Rattanapong	doctor0655@hospital.org	101125.22	Specialist
DR0656	D14	Thanawat Saengthong	doctor0656@hospital.org	149350.29	Specialist
DR0657	D13	Pimchanok Chaiyaporn	doctor0657@hospital.org	116624.43	Specialist
DR0658	D09	Kittiya Jindarat	doctor0658@hospital.org	124382.5	General Practitioner
DR0659	D11	Narin Srisuk	doctor0659@hospital.org	80144.62	Specialist
DR0660	D03	Somchai Chuenchom	doctor0660@hospital.org	134360.9	Consultant
DR0661	D10	Chalerm Khamdee	doctor0661@hospital.org	41887.52	Specialist
DR0662	D09	Narin Srisuk	doctor0662@hospital.org	106954.35	General Practitioner
DR0663	D07	Narin Srisuk	doctor0663@hospital.org	37704.26	General Practitioner
DR0664	D17	Supansa Wongsa	doctor0664@hospital.org	59791.3	General Practitioner
DR0665	D06	Kittiya Phromma	doctor0665@hospital.org	101434.21	Specialist
DR0666	D15	Ratchanon Buranapong	doctor0666@hospital.org	117902.22	Consultant
DR0667	D07	Kanya Meesuk	doctor0667@hospital.org	117855.29	General Practitioner
DR0668	D06	Warut Khamdee	doctor0668@hospital.org	92499.49	Specialist
DR0669	D06	Pimchanok Srisuk	doctor0669@hospital.org	78645.34	Consultant
DR0670	D10	Kanya Boonmee	doctor0670@hospital.org	76720.67	Consultant
DR0671	D07	Kittiya Jindarat	doctor0671@hospital.org	69899.8	General Practitioner
DR0672	D14	Kittiya Chantarangsu	doctor0672@hospital.org	138907.15	Senior Specialist
DR0673	D01	Nattapong Boonmee	doctor0673@hospital.org	83789.55	Consultant
DR0674	D04	Warut Chuenchom	doctor0674@hospital.org	150149.27	Consultant
DR0675	D19	Mali Chuenchom	doctor0675@hospital.org	66908.93	Specialist
DR0676	D14	Thanawat Saengthong	doctor0676@hospital.org	117043.13	Consultant
DR0677	D15	Kanya Thongchai	doctor0677@hospital.org	49461.97	Senior Specialist
DR0678	D04	Kittiya Boonmee	doctor0678@hospital.org	81514.84	Consultant
DR0679	D07	Kanya Khamdee	doctor0679@hospital.org	100017.65	Specialist
DR0680	D12	Jirawat Chuenchom	doctor0680@hospital.org	102392.6	Specialist
DR0681	D12	Ratchanon Boonmee	doctor0681@hospital.org	127787.97	Specialist
DR0682	D08	Anan Srisuk	doctor0682@hospital.org	94557.51	Senior Specialist
DR0683	D17	Nattapong Panyarat	doctor0683@hospital.org	100055.09	Consultant
DR0684	D17	Chalerm Jindarat	doctor0684@hospital.org	108973.53	Consultant
DR0685	D13	Anan Chuenchom	doctor0685@hospital.org	114400.78	Consultant
DR0686	D10	Patchara Prasertkul	doctor0686@hospital.org	128620.02	Senior Specialist
DR0687	D11	Pimchanok Kittisak	doctor0687@hospital.org	65435.14	Senior Specialist
DR0688	D15	Pimchanok Sukjai	doctor0688@hospital.org	131518.4	Senior Specialist
DR0689	D08	Ratchanon Buranapong	doctor0689@hospital.org	99599.82	Specialist
DR0690	D16	Kanya Wongsa	doctor0690@hospital.org	139663.15	General Practitioner
DR0691	D02	Anan Panyarat	doctor0691@hospital.org	150572.68	Specialist
DR0692	D16	Preecha Khamdee	doctor0692@hospital.org	66340.79	General Practitioner
DR0693	D05	Anan Phromma	doctor0693@hospital.org	102210.52	Specialist
DR0694	D10	Thanawat Saelim	doctor0694@hospital.org	125016.31	Specialist
DR0695	D02	Preecha Khamdee	doctor0695@hospital.org	104306.45	Consultant
DR0696	D01	Somchai Saengthong	doctor0696@hospital.org	127515.44	Senior Specialist
DR0697	D07	Mali Chaiyaporn	doctor0697@hospital.org	86493.41	General Practitioner
DR0698	D18	Somchai Sukjai	doctor0698@hospital.org	90609.01	Specialist
DR0699	D02	Somchai Meesuk	doctor0699@hospital.org	106068.79	General Practitioner
DR0700	D18	Anan Prasertkul	doctor0700@hospital.org	107388.65	Senior Specialist
DR0701	D16	Supansa Rattanapong	doctor0701@hospital.org	69984.4	General Practitioner
DR0702	D04	Preecha Rattanapong	doctor0702@hospital.org	99117.28	Specialist
DR0703	D08	Preecha Prasertkul	doctor0703@hospital.org	64107.78	Specialist
DR0704	D04	Anan Phromma	doctor0704@hospital.org	56646.29	Consultant
DR0705	D14	Anan Chaiyaporn	doctor0705@hospital.org	104338.62	Specialist
DR0706	D02	Narin Boonmee	doctor0706@hospital.org	110808.78	Consultant
DR0707	D06	Nicha Chantarangsu	doctor0707@hospital.org	109579.63	Specialist
DR0708	D02	Pimchanok Chantarangsu	doctor0708@hospital.org	99384.94	Senior Specialist
DR0709	D01	Pimchanok Wongsa	doctor0709@hospital.org	134109.23	Specialist
DR0710	D04	Siriporn Jindarat	doctor0710@hospital.org	93447.64	Consultant
DR0711	D06	Jirawat Wongsa	doctor0711@hospital.org	94438.71	Senior Specialist
DR0712	D05	Ploy Wattanakul	doctor0712@hospital.org	59442.74	Specialist
DR0713	D17	Thanawat Prasertkul	doctor0713@hospital.org	73260.99	Consultant
DR0714	D03	Siriporn Jindarat	doctor0714@hospital.org	42448.1	Specialist
DR0715	D12	Patchara Boonmee	doctor0715@hospital.org	157308.7	General Practitioner
DR0716	D10	Thanawat Saelim	doctor0716@hospital.org	73178.92	General Practitioner
DR0717	D17	Suda Wattanakul	doctor0717@hospital.org	100319.26	Consultant
DR0718	D08	Suda Rattanapong	doctor0718@hospital.org	104023.81	General Practitioner
DR0719	D06	Kittiya Wongsa	doctor0719@hospital.org	108043.89	Specialist
DR0720	D01	Ratchanon Saelim	doctor0720@hospital.org	83592.1	Senior Specialist
DR0721	D20	Suda Boonmee	doctor0721@hospital.org	88554.72	Specialist
DR0722	D18	Patchara Thongchai	doctor0722@hospital.org	116066.12	General Practitioner
DR0723	D04	Pimchanok Boonmee	doctor0723@hospital.org	89693.78	Specialist
DR0724	D14	Narin Thongchai	doctor0724@hospital.org	128934.97	Specialist
DR0725	D18	Chalerm Wongsa	doctor0725@hospital.org	100938.95	Consultant
DR0726	D06	Somchai Prasertkul	doctor0726@hospital.org	63122.27	Consultant
DR0727	D05	Kittiya Srisuk	doctor0727@hospital.org	90129.3	General Practitioner
DR0728	D15	Nattapong Jindarat	doctor0728@hospital.org	46360.85	Consultant
DR0729	D06	Siriporn Buranapong	doctor0729@hospital.org	104823.24	Specialist
DR0730	D11	Jirawat Wongsa	doctor0730@hospital.org	66500.95	Specialist
DR0731	D19	Chalerm Buranapong	doctor0731@hospital.org	78508.75	Specialist
DR0732	D01	Suda Saengthong	doctor0732@hospital.org	119297.41	Consultant
DR0733	D08	Nattapong Srisuk	doctor0733@hospital.org	96867.99	Senior Specialist
DR0734	D03	Chalerm Prasertkul	doctor0734@hospital.org	136748.31	Specialist
DR0735	D02	Chalerm Kittisak	doctor0735@hospital.org	81951.76	Specialist
DR0736	D07	Siriporn Chantarangsu	doctor0736@hospital.org	53692.98	Consultant
DR0737	D12	Supansa Srisuk	doctor0737@hospital.org	73930.59	Consultant
DR0738	D18	Warut Meesuk	doctor0738@hospital.org	45143.32	Consultant
DR0739	D09	Mali Chantarangsu	doctor0739@hospital.org	84635.04	Senior Specialist
DR0740	D09	Kittiya Phromma	doctor0740@hospital.org	94195.33	Senior Specialist
DR0741	D06	Pimchanok Wattanakul	doctor0741@hospital.org	45280.43	Senior Specialist
DR0742	D18	Narin Rattanapong	doctor0742@hospital.org	74324.56	General Practitioner
DR0743	D04	Somchai Wattanakul	doctor0743@hospital.org	60211.39	Specialist
DR0744	D16	Suda Panyarat	doctor0744@hospital.org	98703.37	Consultant
DR0745	D08	Siriporn Saengthong	doctor0745@hospital.org	75466.74	Specialist
DR0746	D08	Chalerm Saengthong	doctor0746@hospital.org	106077.27	Specialist
DR0747	D05	Narin Buranapong	doctor0747@hospital.org	123624.93	Specialist
DR0748	D09	Thanawat Meesuk	doctor0748@hospital.org	114673.77	General Practitioner
DR0749	D03	Thanawat Wongsa	doctor0749@hospital.org	79894.49	General Practitioner
DR0750	D12	Kittiya Chantarangsu	doctor0750@hospital.org	113763.92	Consultant
DR0751	D16	Pimchanok Meesuk	doctor0751@hospital.org	94643.26	Consultant
DR0752	D03	Somchai Panyarat	doctor0752@hospital.org	129689.77	Consultant
DR0753	D15	Ploy Chaiyaporn	doctor0753@hospital.org	140334.86	Consultant
DR0754	D12	Suda Sukjai	doctor0754@hospital.org	83802.7	Specialist
DR0755	D06	Ploy Buranapong	doctor0755@hospital.org	129485.12	General Practitioner
DR0756	D05	Ploy Khamdee	doctor0756@hospital.org	141231.94	Specialist
DR0757	D03	Kittiya Khamdee	doctor0757@hospital.org	95777.44	Consultant
DR0758	D15	Ratchanon Panyarat	doctor0758@hospital.org	134851.97	Specialist
DR0759	D08	Ratchanon Jindarat	doctor0759@hospital.org	114791.4	Specialist
DR0760	D19	Chalerm Boonmee	doctor0760@hospital.org	64791.26	General Practitioner
DR0761	D12	Thanawat Thongchai	doctor0761@hospital.org	113672.71	Specialist
DR0762	D02	Ratchanon Jindarat	doctor0762@hospital.org	41174.77	Senior Specialist
DR0763	D03	Warut Phromma	doctor0763@hospital.org	118176.77	Senior Specialist
DR0764	D15	Supansa Kittisak	doctor0764@hospital.org	107928.02	General Practitioner
DR0765	D04	Ploy Panyarat	doctor0765@hospital.org	116273.71	General Practitioner
DR0766	D04	Jirawat Buranapong	doctor0766@hospital.org	112197.3	Consultant
DR0767	D12	Pimchanok Srisuk	doctor0767@hospital.org	113714.02	Senior Specialist
DR0768	D14	Pimchanok Jindarat	doctor0768@hospital.org	110585.37	Senior Specialist
DR0769	D17	Suda Chantarangsu	doctor0769@hospital.org	103528.14	Specialist
DR0770	D01	Chalerm Khamdee	doctor0770@hospital.org	108432.7	Consultant
DR0771	D08	Kittiya Wattanakul	doctor0771@hospital.org	93841.49	Senior Specialist
DR0772	D02	Pimchanok Chuenchom	doctor0772@hospital.org	75593.12	Consultant
DR0773	D01	Somchai Saengthong	doctor0773@hospital.org	86173.44	Specialist
DR0774	D09	Pimchanok Jindarat	doctor0774@hospital.org	72489.43	Consultant
DR0775	D02	Nattapong Saengthong	doctor0775@hospital.org	104840.48	Senior Specialist
DR0776	D09	Warut Rattanapong	doctor0776@hospital.org	59637.67	Consultant
DR0777	D04	Supansa Wongsa	doctor0777@hospital.org	76375.76	General Practitioner
DR0778	D08	Thanawat Prasertkul	doctor0778@hospital.org	105211.82	Specialist
DR0779	D04	Kittiya Thongchai	doctor0779@hospital.org	92112.81	General Practitioner
DR0780	D18	Ploy Chuenchom	doctor0780@hospital.org	90908.05	Consultant
DR0781	D09	Jirawat Phromma	doctor0781@hospital.org	129241.79	Specialist
DR0782	D07	Anan Phromma	doctor0782@hospital.org	145669.1	Specialist
DR0783	D16	Narin Meesuk	doctor0783@hospital.org	73272.68	Senior Specialist
DR0784	D12	Supansa Buranapong	doctor0784@hospital.org	106186.16	Consultant
DR0785	D06	Kanya Chuenchom	doctor0785@hospital.org	155630.51	Specialist
DR0786	D16	Suda Chaiyaporn	doctor0786@hospital.org	63059.51	Specialist
DR0787	D18	Supansa Chantarangsu	doctor0787@hospital.org	120332.26	Specialist
DR0788	D07	Suda Chaiyaporn	doctor0788@hospital.org	86640.45	Specialist
DR0789	D08	Nattapong Meesuk	doctor0789@hospital.org	131442.66	Specialist
DR0790	D01	Mali Chaiyaporn	doctor0790@hospital.org	134809.66	Specialist
DR0791	D04	Somchai Prasertkul	doctor0791@hospital.org	84908.44	General Practitioner
DR0792	D14	Suda Buranapong	doctor0792@hospital.org	95788.16	Senior Specialist
DR0793	D08	Kanya Wongsa	doctor0793@hospital.org	110110.35	Senior Specialist
DR0794	D20	Kanya Thongchai	doctor0794@hospital.org	139540.22	Specialist
DR0795	D01	Kittiya Meesuk	doctor0795@hospital.org	96119.56	Specialist
DR0796	D02	Jirawat Khamdee	doctor0796@hospital.org	87663.66	Consultant
DR0797	D13	Ploy Chantarangsu	doctor0797@hospital.org	99874.1	Specialist
DR0798	D16	Mali Panyarat	doctor0798@hospital.org	97715.92	General Practitioner
DR0799	D20	Suda Saelim	doctor0799@hospital.org	121550.5	General Practitioner
DR0800	D06	Narin Rattanapong	doctor0800@hospital.org	86215.8	Specialist
\.


--
-- TOC entry 3680 (class 0 OID 16506)
-- Dependencies: 221
-- Data for Name: stg_hospital_branches; Type: TABLE DATA; Schema: public; Owner: postgres
--

