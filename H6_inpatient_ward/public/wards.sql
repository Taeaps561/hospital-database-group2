CREATE TABLE public.wards (
    ward_id text NOT NULL,
    department_id text NOT NULL,
    ward_name text NOT NULL,
    ward_type text NOT NULL,
    bed_capacity integer NOT NULL,
    CONSTRAINT wards_bed_capacity_check CHECK ((bed_capacity > 0))
);


ALTER TABLE public.wards OWNER TO postgres;

--
-- TOC entry 3402 (class 2604 OID 16830)
-- Name: admissions_audit audit_id; Type: DEFAULT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions_audit ALTER COLUMN audit_id SET DEFAULT nextval('hospital_h6.admissions_audit_audit_id_seq'::regclass);


--
-- TOC entry 3397 (class 2604 OID 16756)
-- Name: bed_transfers transfer_id; Type: DEFAULT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers ALTER COLUMN transfer_id SET DEFAULT nextval('hospital_h6.bed_transfers_transfer_id_seq'::regclass);


--
-- TOC entry 3399 (class 2604 OID 16787)
-- Name: emergency_access_logs log_id; Type: DEFAULT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.emergency_access_logs ALTER COLUMN log_id SET DEFAULT nextval('hospital_h6.emergency_access_logs_log_id_seq'::regclass);


--
-- TOC entry 3703 (class 0 OID 16728)
-- Dependencies: 244
-- Data for Name: admissions; Type: TABLE DATA; Schema: hospital_h6; Owner: postgres
--

COPY public.wards (ward_id, department_id, ward_name, ward_type, bed_capacity) FROM stdin;
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
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 249
-- Name: admissions_audit_audit_id_seq; Type: SEQUENCE SET; Schema: hospital_h6; Owner: postgres
--

SELECT pg_catalog.setval('hospital_h6.admissions_audit_audit_id_seq', 1, false);


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 245
-- Name: bed_transfers_transfer_id_seq; Type: SEQUENCE SET; Schema: hospital_h6; Owner: postgres
--

SELECT pg_catalog.setval('hospital_h6.bed_transfers_transfer_id_seq', 1, false);


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 247
-- Name: emergency_access_logs_log_id_seq; Type: SEQUENCE SET; Schema: hospital_h6; Owner: postgres
--

SELECT pg_catalog.setval('hospital_h6.emergency_access_logs_log_id_seq', 1, false);


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 219
-- Name: break_glass_access_audit_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.break_glass_access_audit_audit_id_seq', 1, true);


--
-- TOC entry 3491 (class 2606 OID 16736)
-- Name: admissions pk_admissions; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions
    ADD CONSTRAINT pk_admissions PRIMARY KEY (admission_id);


--
-- TOC entry 3503 (class 2606 OID 16837)
-- Name: admissions_audit pk_admissions_audit; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions_audit
    ADD CONSTRAINT pk_admissions_audit PRIMARY KEY (audit_id);


--
-- TOC entry 3497 (class 2606 OID 16762)
-- Name: bed_transfers pk_bed_transfers; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers
    ADD CONSTRAINT pk_bed_transfers PRIMARY KEY (transfer_id);


--
-- TOC entry 3484 (class 2606 OID 16722)
-- Name: beds pk_beds; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.beds
    ADD CONSTRAINT pk_beds PRIMARY KEY (bed_id);


--
-- TOC entry 3470 (class 2606 OID 16670)
-- Name: departments pk_departments; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.departments
    ADD CONSTRAINT pk_departments PRIMARY KEY (department_id);


--
-- TOC entry 3477 (class 2606 OID 16696)
-- Name: doctors pk_doctors; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.doctors
    ADD CONSTRAINT pk_doctors PRIMARY KEY (doctor_id);


--
-- TOC entry 3501 (class 2606 OID 16795)
-- Name: emergency_access_logs pk_emergency_access_logs; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.emergency_access_logs
    ADD CONSTRAINT pk_emergency_access_logs PRIMARY KEY (log_id);


--
-- TOC entry 3467 (class 2606 OID 16665)
-- Name: hospital_branches pk_hospital_branches; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.hospital_branches
    ADD CONSTRAINT pk_hospital_branches PRIMARY KEY (branch_id);


--
-- TOC entry 3474 (class 2606 OID 16686)
-- Name: patients pk_patients; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.patients
    ADD CONSTRAINT pk_patients PRIMARY KEY (patient_id);


--
-- TOC entry 3480 (class 2606 OID 16709)
-- Name: wards pk_wards; Type: CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.wards
    ADD CONSTRAINT pk_wards PRIMARY KEY (ward_id);


--
-- TOC entry 3440 (class 2606 OID 16483)
-- Name: admissions admissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions
    ADD CONSTRAINT admissions_pkey PRIMARY KEY (admission_id);


--
-- TOC entry 3463 (class 2606 OID 16627)
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3465 (class 2606 OID 16629)
-- Name: app_users app_users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_users
    ADD CONSTRAINT app_users_username_key UNIQUE (username);


--
-- TOC entry 3436 (class 2606 OID 16466)
-- Name: beds beds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT beds_pkey PRIMARY KEY (bed_id);


--
-- TOC entry 3451 (class 2606 OID 16582)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- TOC entry 3459 (class 2606 OID 16615)
-- Name: doctors doctors_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_email_key UNIQUE (email);


--
-- TOC entry 3461 (class 2606 OID 16613)
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (doctor_id);


--
-- TOC entry 3447 (class 2606 OID 16573)
-- Name: hospital_branches hospital_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_branches
    ADD CONSTRAINT hospital_branches_pkey PRIMARY KEY (branch_id);


--
-- TOC entry 3455 (class 2606 OID 16600)
-- Name: patients patients_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_email_key UNIQUE (email);


--
-- TOC entry 3457 (class 2606 OID 16598)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- TOC entry 3438 (class 2606 OID 16636)
-- Name: beds uq_beds_ward_room; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT uq_beds_ward_room UNIQUE (ward_id, room_number);


--
-- TOC entry 3453 (class 2606 OID 16584)
-- Name: departments uq_departments_branch_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT uq_departments_branch_name UNIQUE (branch_id, department_name);


--
-- TOC entry 3449 (class 2606 OID 16575)
-- Name: hospital_branches uq_hospital_branches_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospital_branches
    ADD CONSTRAINT uq_hospital_branches_name UNIQUE (branch_name);


--
-- TOC entry 3432 (class 2606 OID 16459)
-- Name: wards uq_wards_department_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wards
    ADD CONSTRAINT uq_wards_department_name UNIQUE (department_id, ward_name);


--
-- TOC entry 3434 (class 2606 OID 16457)
-- Name: wards wards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wards
    ADD CONSTRAINT wards_pkey PRIMARY KEY (ward_id);


--
-- TOC entry 3485 (class 1259 OID 16810)
-- Name: idx_admissions_bed; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_admissions_bed ON hospital_h6.admissions USING btree (bed_id);


--
-- TOC entry 3486 (class 1259 OID 16811)
-- Name: idx_admissions_dates; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_admissions_dates ON hospital_h6.admissions USING btree (admission_date, discharge_date);


--
-- TOC entry 3487 (class 1259 OID 16809)
-- Name: idx_admissions_doctor; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_admissions_doctor ON hospital_h6.admissions USING btree (attending_doctor_id);


--
-- TOC entry 3488 (class 1259 OID 16808)
-- Name: idx_admissions_patient; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_admissions_patient ON hospital_h6.admissions USING btree (patient_id);


--
-- TOC entry 3489 (class 1259 OID 16812)
-- Name: idx_admissions_status; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_admissions_status ON hospital_h6.admissions USING btree (discharge_status);


--
-- TOC entry 3493 (class 1259 OID 16813)
-- Name: idx_bed_transfers_admission; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_bed_transfers_admission ON hospital_h6.bed_transfers USING btree (admission_id);


--
-- TOC entry 3494 (class 1259 OID 16814)
-- Name: idx_bed_transfers_from_bed; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_bed_transfers_from_bed ON hospital_h6.bed_transfers USING btree (from_bed_id);


--
-- TOC entry 3495 (class 1259 OID 16815)
-- Name: idx_bed_transfers_to_bed; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_bed_transfers_to_bed ON hospital_h6.bed_transfers USING btree (to_bed_id);


--
-- TOC entry 3481 (class 1259 OID 16804)
-- Name: idx_beds_status; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_beds_status ON hospital_h6.beds USING btree (bed_status);


--
-- TOC entry 3482 (class 1259 OID 16803)
-- Name: idx_beds_ward; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_beds_ward ON hospital_h6.beds USING btree (ward_id);


--
-- TOC entry 3468 (class 1259 OID 16801)
-- Name: idx_departments_branch; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_departments_branch ON hospital_h6.departments USING btree (branch_id);


--
-- TOC entry 3475 (class 1259 OID 16807)
-- Name: idx_doctors_department; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_doctors_department ON hospital_h6.doctors USING btree (department_id);


--
-- TOC entry 3498 (class 1259 OID 16816)
-- Name: idx_eal_admission; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_eal_admission ON hospital_h6.emergency_access_logs USING btree (admission_id);


--
-- TOC entry 3499 (class 1259 OID 16817)
-- Name: idx_eal_timestamp; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_eal_timestamp ON hospital_h6.emergency_access_logs USING btree (access_timestamp);


--
-- TOC entry 3471 (class 1259 OID 16805)
-- Name: idx_patients_branch; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_patients_branch ON hospital_h6.patients USING btree (registered_branch_id);


--
-- TOC entry 3472 (class 1259 OID 16806)
-- Name: idx_patients_status; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_patients_status ON hospital_h6.patients USING btree (patient_status);


--
-- TOC entry 3478 (class 1259 OID 16802)
-- Name: idx_wards_department; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE INDEX idx_wards_department ON hospital_h6.wards USING btree (department_id);


--
-- TOC entry 3492 (class 1259 OID 16818)
-- Name: uix_admissions_bed_ongoing; Type: INDEX; Schema: hospital_h6; Owner: postgres
--

CREATE UNIQUE INDEX uix_admissions_bed_ongoing ON hospital_h6.admissions USING btree (bed_id) WHERE ((discharge_status)::text = 'Ongoing'::text);


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 3492
-- Name: INDEX uix_admissions_bed_ongoing; Type: COMMENT; Schema: hospital_h6; Owner: postgres
--

COMMENT ON INDEX hospital_h6.uix_admissions_bed_ongoing IS 'ป้องกัน Bed ถูก Admit ซ้อนกัน: เตียงเดียวกันมี Ongoing Admission ได้สูงสุด 1 ครั้ง';


--
-- TOC entry 3441 (class 1259 OID 16491)
-- Name: idx_admissions_bed_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admissions_bed_date ON public.admissions USING btree (bed_id, admission_date);


--
-- TOC entry 3442 (class 1259 OID 16490)
-- Name: idx_admissions_doctor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admissions_doctor_id ON public.admissions USING btree (attending_doctor_id);


--
-- TOC entry 3443 (class 1259 OID 16489)
-- Name: idx_admissions_patient_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admissions_patient_id ON public.admissions USING btree (patient_id);


--
-- TOC entry 3444 (class 1259 OID 16504)
-- Name: idx_break_glass_patient_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_break_glass_patient_time ON public.break_glass_access_audit USING btree (patient_id, accessed_at DESC);


--
-- TOC entry 3445 (class 1259 OID 16505)
-- Name: idx_break_glass_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_break_glass_user_time ON public.break_glass_access_audit USING btree (user_id, accessed_at DESC);


--
-- TOC entry 3527 (class 2620 OID 16839)
-- Name: admissions trg_admissions_audit; Type: TRIGGER; Schema: hospital_h6; Owner: postgres
--

CREATE TRIGGER trg_admissions_audit AFTER INSERT OR DELETE OR UPDATE ON hospital_h6.admissions FOR EACH ROW EXECUTE FUNCTION hospital_h6.fn_admissions_audit();


--
-- TOC entry 3519 (class 2606 OID 16747)
-- Name: admissions fk_admission_bed; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions
    ADD CONSTRAINT fk_admission_bed FOREIGN KEY (bed_id) REFERENCES hospital_h6.beds(bed_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3520 (class 2606 OID 16742)
-- Name: admissions fk_admission_doctor; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions
    ADD CONSTRAINT fk_admission_doctor FOREIGN KEY (attending_doctor_id) REFERENCES hospital_h6.doctors(doctor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3521 (class 2606 OID 16737)
-- Name: admissions fk_admission_patient; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.admissions
    ADD CONSTRAINT fk_admission_patient FOREIGN KEY (patient_id) REFERENCES hospital_h6.patients(patient_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3518 (class 2606 OID 16723)
-- Name: beds fk_bed_ward; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.beds
    ADD CONSTRAINT fk_bed_ward FOREIGN KEY (ward_id) REFERENCES hospital_h6.wards(ward_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3522 (class 2606 OID 16763)
-- Name: bed_transfers fk_bt_admission; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers
    ADD CONSTRAINT fk_bt_admission FOREIGN KEY (admission_id) REFERENCES hospital_h6.admissions(admission_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3523 (class 2606 OID 16768)
-- Name: bed_transfers fk_bt_from_bed; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers
    ADD CONSTRAINT fk_bt_from_bed FOREIGN KEY (from_bed_id) REFERENCES hospital_h6.beds(bed_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3524 (class 2606 OID 16773)
-- Name: bed_transfers fk_bt_to_bed; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers
    ADD CONSTRAINT fk_bt_to_bed FOREIGN KEY (to_bed_id) REFERENCES hospital_h6.beds(bed_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3525 (class 2606 OID 16778)
-- Name: bed_transfers fk_bt_transferred_by; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.bed_transfers
    ADD CONSTRAINT fk_bt_transferred_by FOREIGN KEY (transferred_by) REFERENCES hospital_h6.doctors(doctor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3514 (class 2606 OID 16671)
-- Name: departments fk_dept_branch; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.departments
    ADD CONSTRAINT fk_dept_branch FOREIGN KEY (branch_id) REFERENCES hospital_h6.hospital_branches(branch_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3516 (class 2606 OID 16697)
-- Name: doctors fk_doctor_department; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.doctors
    ADD CONSTRAINT fk_doctor_department FOREIGN KEY (department_id) REFERENCES hospital_h6.departments(department_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3526 (class 2606 OID 16796)
-- Name: emergency_access_logs fk_eal_admission; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.emergency_access_logs
    ADD CONSTRAINT fk_eal_admission FOREIGN KEY (admission_id) REFERENCES hospital_h6.admissions(admission_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3515 (class 2606 OID 16687)
-- Name: patients fk_patient_branch; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.patients
    ADD CONSTRAINT fk_patient_branch FOREIGN KEY (registered_branch_id) REFERENCES hospital_h6.hospital_branches(branch_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3517 (class 2606 OID 16710)
-- Name: wards fk_ward_department; Type: FK CONSTRAINT; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE ONLY hospital_h6.wards
    ADD CONSTRAINT fk_ward_department FOREIGN KEY (department_id) REFERENCES hospital_h6.departments(department_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3506 (class 2606 OID 16484)
-- Name: admissions fk_admissions_bed; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions
    ADD CONSTRAINT fk_admissions_bed FOREIGN KEY (bed_id) REFERENCES public.beds(bed_id);


--
-- TOC entry 3507 (class 2606 OID 16642)
-- Name: admissions fk_admissions_doctor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions
    ADD CONSTRAINT fk_admissions_doctor FOREIGN KEY (attending_doctor_id) REFERENCES public.doctors(doctor_id);


--
-- TOC entry 3508 (class 2606 OID 16637)
-- Name: admissions fk_admissions_patient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions
    ADD CONSTRAINT fk_admissions_patient FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- TOC entry 3505 (class 2606 OID 16469)
-- Name: beds fk_beds_ward; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.beds
    ADD CONSTRAINT fk_beds_ward FOREIGN KEY (ward_id) REFERENCES public.wards(ward_id);


--
-- TOC entry 3509 (class 2606 OID 16652)
-- Name: break_glass_access_audit fk_break_glass_patient; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.break_glass_access_audit
    ADD CONSTRAINT fk_break_glass_patient FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- TOC entry 3510 (class 2606 OID 16647)
-- Name: break_glass_access_audit fk_break_glass_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.break_glass_access_audit
    ADD CONSTRAINT fk_break_glass_user FOREIGN KEY (user_id) REFERENCES public.app_users(user_id);


--
-- TOC entry 3511 (class 2606 OID 16585)
-- Name: departments fk_departments_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_departments_branch FOREIGN KEY (branch_id) REFERENCES public.hospital_branches(branch_id);


--
-- TOC entry 3513 (class 2606 OID 16616)
-- Name: doctors fk_doctors_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT fk_doctors_department FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 3512 (class 2606 OID 16601)
-- Name: patients fk_patients_registered_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT fk_patients_registered_branch FOREIGN KEY (registered_branch_id) REFERENCES public.hospital_branches(branch_id);


--
-- TOC entry 3504 (class 2606 OID 16630)
-- Name: wards fk_wards_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wards
    ADD CONSTRAINT fk_wards_department FOREIGN KEY (department_id) REFERENCES public.departments(department_id);


--
-- TOC entry 3671 (class 0 OID 16728)
-- Dependencies: 244
-- Name: admissions; Type: ROW SECURITY; Schema: hospital_h6; Owner: postgres
--

ALTER TABLE hospital_h6.admissions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3674 (class 3256 OID 16825)
-- Name: admissions policy_admin_all; Type: POLICY; Schema: hospital_h6; Owner: postgres
--

CREATE POLICY policy_admin_all ON hospital_h6.admissions TO role_admin USING (true) WITH CHECK (true);


--
-- TOC entry 3673 (class 3256 OID 16824)
-- Name: admissions policy_doctor_own_admissions; Type: POLICY; Schema: hospital_h6; Owner: postgres
--

CREATE POLICY policy_doctor_own_admissions ON hospital_h6.admissions FOR SELECT TO role_doctor USING (((attending_doctor_id)::text = current_setting('app.current_doctor_id'::text, true)));


--
-- TOC entry 3672 (class 3256 OID 16823)
-- Name: admissions policy_nurse_ward_isolation; Type: POLICY; Schema: hospital_h6; Owner: postgres
--

CREATE POLICY policy_nurse_ward_isolation ON hospital_h6.admissions FOR SELECT TO role_nurse USING ((bed_id IN ( SELECT b.bed_id
   FROM hospital_h6.beds b
  WHERE ((b.ward_id)::text = current_setting('app.current_ward_id'::text, true)))));


--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA hospital_h6; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA hospital_h6 TO role_nurse;
GRANT USAGE ON SCHEMA hospital_h6 TO role_doctor;
GRANT USAGE ON SCHEMA hospital_h6 TO role_admin;
GRANT USAGE ON SCHEMA hospital_h6 TO role_billing_staff;


--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 263
-- Name: FUNCTION record_break_glass_access(p_user_id text, p_patient_id text, p_access_reason text, p_access_purpose text, p_source_ip inet); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.record_break_glass_access(p_user_id text, p_patient_id text, p_access_reason text, p_access_purpose text, p_source_ip inet) FROM PUBLIC;
GRANT ALL ON FUNCTION public.record_break_glass_access(p_user_id text, p_patient_id text, p_access_reason text, p_access_purpose text, p_source_ip inet) TO clinical_app;


--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE admissions; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT ON TABLE hospital_h6.admissions TO role_nurse;
GRANT SELECT,INSERT ON TABLE hospital_h6.admissions TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.admissions TO role_admin;


--
-- TOC entry 3725 (class 0 OID 0)
-- Dependencies: 244 3724
-- Name: COLUMN admissions.discharge_date; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT UPDATE(discharge_date) ON TABLE hospital_h6.admissions TO role_doctor;


--
-- TOC entry 3726 (class 0 OID 0)
-- Dependencies: 244 3724
-- Name: COLUMN admissions.discharge_status; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT UPDATE(discharge_status) ON TABLE hospital_h6.admissions TO role_doctor;


--
-- TOC entry 3727 (class 0 OID 0)
-- Dependencies: 244 3724
-- Name: COLUMN admissions.length_of_stay_days; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT UPDATE(length_of_stay_days) ON TABLE hospital_h6.admissions TO role_doctor;


--
-- TOC entry 3729 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE admissions_audit; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE hospital_h6.admissions_audit TO role_admin;
GRANT INSERT ON TABLE hospital_h6.admissions_audit TO role_nurse;
GRANT INSERT ON TABLE hospital_h6.admissions_audit TO role_doctor;


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE bed_transfers; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT ON TABLE hospital_h6.bed_transfers TO role_nurse;
GRANT SELECT,INSERT ON TABLE hospital_h6.bed_transfers TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.bed_transfers TO role_admin;


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE beds; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT ON TABLE hospital_h6.beds TO role_nurse;
GRANT SELECT ON TABLE hospital_h6.beds TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.beds TO role_admin;


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 243 3742
-- Name: COLUMN beds.bed_status; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT UPDATE(bed_status) ON TABLE hospital_h6.beds TO role_nurse;


--
-- TOC entry 3752 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE emergency_access_logs; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT INSERT ON TABLE hospital_h6.emergency_access_logs TO role_nurse;
GRANT INSERT ON TABLE hospital_h6.emergency_access_logs TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.emergency_access_logs TO role_admin;


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE patients; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT ON TABLE hospital_h6.patients TO role_nurse;
GRANT SELECT ON TABLE hospital_h6.patients TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.patients TO role_admin;


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE wards; Type: ACL; Schema: hospital_h6; Owner: postgres
--

GRANT SELECT ON TABLE hospital_h6.wards TO role_nurse;
GRANT SELECT ON TABLE hospital_h6.wards TO role_doctor;
GRANT SELECT ON TABLE hospital_h6.wards TO role_admin;


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE break_glass_access_audit; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.break_glass_access_audit TO clinical_auditor;


