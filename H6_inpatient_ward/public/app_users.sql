CREATE TABLE public.app_users (
    user_id text NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    password_algorithm text NOT NULL,
    role_name text NOT NULL,
    account_status text NOT NULL,
    last_login timestamp with time zone
);


ALTER TABLE public.app_users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16460)
-- Name: beds; Type: TABLE; Schema: public; Owner: postgres
--

COPY public.app_users (user_id, username, password_hash, password_algorithm, role_name, account_status, last_login) FROM stdin;
\.


--
-- TOC entry 3676 (class 0 OID 16460)
-- Dependencies: 217
-- Data for Name: beds; Type: TABLE DATA; Schema: public; Owner: postgres
--

