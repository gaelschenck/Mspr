--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    who_region character varying(100),
    iso_code character varying(3),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_seq OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: etl_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etl_metadata (
    id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    processing_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    records_processed integer,
    records_success integer,
    records_failed integer,
    processing_duration_seconds numeric(10,2),
    notes text
);


ALTER TABLE public.etl_metadata OWNER TO postgres;

--
-- Name: etl_metadata_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etl_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.etl_metadata_id_seq OWNER TO postgres;

--
-- Name: etl_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etl_metadata_id_seq OWNED BY public.etl_metadata.id;


--
-- Name: health_indicators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_indicators (
    id integer NOT NULL,
    country_id integer NOT NULL,
    indicator_type_id integer NOT NULL,
    year integer DEFAULT 2023,
    value_type character varying(100) NOT NULL,
    value numeric(15,2),
    value_text character varying(255),
    confidence_min numeric(15,2),
    confidence_max numeric(15,2),
    confidence_median numeric(15,2),
    data_quality character varying(50) DEFAULT 'good'::character varying,
    source_file character varying(255),
    raw_value_text text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.health_indicators OWNER TO postgres;

--
-- Name: health_indicators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_indicators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_indicators_id_seq OWNER TO postgres;

--
-- Name: health_indicators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_indicators_id_seq OWNED BY public.health_indicators.id;


--
-- Name: indicator_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.indicator_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    unit character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.indicator_types OWNER TO postgres;

--
-- Name: indicator_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.indicator_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.indicator_types_id_seq OWNER TO postgres;

--
-- Name: indicator_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.indicator_types_id_seq OWNED BY public.indicator_types.id;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    hashed_password character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'user'::character varying NOT NULL,
    rgpd_accept integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- Name: utilisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_seq OWNER TO postgres;

--
-- Name: utilisateur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: etl_metadata id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etl_metadata ALTER COLUMN id SET DEFAULT nextval('public.etl_metadata_id_seq'::regclass);


--
-- Name: health_indicators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_indicators ALTER COLUMN id SET DEFAULT nextval('public.health_indicators_id_seq'::regclass);


--
-- Name: indicator_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indicator_types ALTER COLUMN id SET DEFAULT nextval('public.indicator_types_id_seq'::regclass);


--
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, name, who_region, iso_code, created_at, updated_at) FROM stdin;
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 17:39:27.754121	2025-06-29 17:39:27.754121
2	Albania	Europe	\N	2025-06-29 17:39:27.761709	2025-06-29 17:39:27.761709
3	Algeria	Africa	\N	2025-06-29 17:39:27.768338	2025-06-29 17:39:27.768338
4	Angola	Africa	\N	2025-06-29 17:39:27.774526	2025-06-29 17:39:27.774526
5	Argentina	Americas	\N	2025-06-29 17:39:27.78147	2025-06-29 17:39:27.78147
6	Armenia	Europe	\N	2025-06-29 17:39:27.788572	2025-06-29 17:39:27.788572
7	Australia	Western Pacific	\N	2025-06-29 17:39:27.795342	2025-06-29 17:39:27.795342
8	Austria	Europe	\N	2025-06-29 17:39:27.802574	2025-06-29 17:39:27.802574
9	Azerbaijan	Europe	\N	2025-06-29 17:39:27.809361	2025-06-29 17:39:27.809361
10	Bahamas	Americas	\N	2025-06-29 17:39:27.817301	2025-06-29 17:39:27.817301
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 17:39:27.825912	2025-06-29 17:39:27.825912
12	Bangladesh	South-East Asia	\N	2025-06-29 17:39:27.832588	2025-06-29 17:39:27.832588
13	Barbados	Americas	\N	2025-06-29 17:39:27.840541	2025-06-29 17:39:27.840541
14	Belarus	Europe	\N	2025-06-29 17:39:27.848084	2025-06-29 17:39:27.848084
15	Belgium	Europe	\N	2025-06-29 17:39:27.857109	2025-06-29 17:39:27.857109
16	Belize	Americas	\N	2025-06-29 17:39:27.866028	2025-06-29 17:39:27.866028
17	Benin	Africa	\N	2025-06-29 17:39:27.86922	2025-06-29 17:39:27.86922
18	Bhutan	South-East Asia	\N	2025-06-29 17:39:27.872243	2025-06-29 17:39:27.872243
19	Bolivia	Americas	\N	2025-06-29 17:39:27.875135	2025-06-29 17:39:27.875135
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 17:39:27.882124	2025-06-29 17:39:27.882124
21	Botswana	Africa	\N	2025-06-29 17:39:27.888838	2025-06-29 17:39:27.888838
22	Brazil	Americas	\N	2025-06-29 17:39:27.895218	2025-06-29 17:39:27.895218
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 17:39:27.903451	2025-06-29 17:39:27.903451
24	Bulgaria	Europe	\N	2025-06-29 17:39:27.90994	2025-06-29 17:39:27.90994
25	Burkina Faso	Africa	\N	2025-06-29 17:39:27.916288	2025-06-29 17:39:27.916288
26	Burundi	Africa	\N	2025-06-29 17:39:27.924838	2025-06-29 17:39:27.924838
27	Cabo Verde	Africa	\N	2025-06-29 17:39:27.931534	2025-06-29 17:39:27.931534
28	Cambodia	Western Pacific	\N	2025-06-29 17:39:27.938116	2025-06-29 17:39:27.938116
29	Cameroon	Africa	\N	2025-06-29 17:39:27.945911	2025-06-29 17:39:27.945911
30	Canada	Americas	\N	2025-06-29 17:39:27.952822	2025-06-29 17:39:27.952822
31	Central African Republic	Africa	\N	2025-06-29 17:39:27.959671	2025-06-29 17:39:27.959671
32	Chad	Africa	\N	2025-06-29 17:39:27.966352	2025-06-29 17:39:27.966352
33	Chile	Americas	\N	2025-06-29 17:39:27.973738	2025-06-29 17:39:27.973738
34	China	Western Pacific	\N	2025-06-29 17:39:28.119265	2025-06-29 17:39:28.119265
35	Colombia	Americas	\N	2025-06-29 17:39:28.128997	2025-06-29 17:39:28.128997
36	Comoros	Africa	\N	2025-06-29 17:39:28.135969	2025-06-29 17:39:28.135969
37	Congo	Americas	\N	2025-06-29 17:39:28.143134	2025-06-29 17:39:28.143134
38	Costa Rica	Americas	\N	2025-06-29 17:39:28.1502	2025-06-29 17:39:28.1502
39	Côte d'Ivoire	Africa	\N	2025-06-29 17:39:28.157929	2025-06-29 17:39:28.157929
40	Croatia	Europe	\N	2025-06-29 17:39:28.164506	2025-06-29 17:39:28.164506
41	Cuba	Americas	\N	2025-06-29 17:39:28.171795	2025-06-29 17:39:28.171795
42	Cyprus	Europe	\N	2025-06-29 17:39:28.178282	2025-06-29 17:39:28.178282
43	Czechia	Europe	\N	2025-06-29 17:39:28.18487	2025-06-29 17:39:28.18487
44	North Korea	Western Pacific	\N	2025-06-29 17:39:28.191351	2025-06-29 17:39:28.191351
45	DR Congo	Africa	\N	2025-06-29 17:39:28.200654	2025-06-29 17:39:28.200654
46	Denmark	Europe	\N	2025-06-29 17:39:28.208743	2025-06-29 17:39:28.208743
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 17:39:28.215411	2025-06-29 17:39:28.215411
48	Dominican Republic	Americas	\N	2025-06-29 17:39:28.226014	2025-06-29 17:39:28.226014
49	Ecuador	Americas	\N	2025-06-29 17:39:28.232749	2025-06-29 17:39:28.232749
50	Egypt	Eastern Mediterranean	\N	2025-06-29 17:39:28.239474	2025-06-29 17:39:28.239474
51	El Salvador	Americas	\N	2025-06-29 17:39:28.2452	2025-06-29 17:39:28.2452
52	Equatorial Guinea	Africa	\N	2025-06-29 17:39:28.250165	2025-06-29 17:39:28.250165
53	Eritrea	Africa	\N	2025-06-29 17:39:28.258065	2025-06-29 17:39:28.258065
54	Estonia	Europe	\N	2025-06-29 17:39:28.264858	2025-06-29 17:39:28.264858
55	Eswatini	Africa	\N	2025-06-29 17:39:28.273286	2025-06-29 17:39:28.273286
56	Ethiopia	Africa	\N	2025-06-29 17:39:28.27957	2025-06-29 17:39:28.27957
57	Fiji	Western Pacific	\N	2025-06-29 17:39:28.286063	2025-06-29 17:39:28.286063
58	Finland	Europe	\N	2025-06-29 17:39:28.292388	2025-06-29 17:39:28.292388
59	France	Europe	\N	2025-06-29 17:39:28.298869	2025-06-29 17:39:28.298869
60	Gabon	Africa	\N	2025-06-29 17:39:28.305247	2025-06-29 17:39:28.305247
61	Gambia	Africa	\N	2025-06-29 17:39:28.313126	2025-06-29 17:39:28.313126
62	Georgia	Europe	\N	2025-06-29 17:39:28.319321	2025-06-29 17:39:28.319321
63	Germany	Europe	\N	2025-06-29 17:39:28.326034	2025-06-29 17:39:28.326034
64	Ghana	Africa	\N	2025-06-29 17:39:28.332799	2025-06-29 17:39:28.332799
65	Greece	Europe	\N	2025-06-29 17:39:28.339323	2025-06-29 17:39:28.339323
66	Guatemala	Americas	\N	2025-06-29 17:39:28.346365	2025-06-29 17:39:28.346365
67	Guinea	Africa	\N	2025-06-29 17:39:28.352987	2025-06-29 17:39:28.352987
68	Guinea-Bissau	Africa	\N	2025-06-29 17:39:28.359905	2025-06-29 17:39:28.359905
69	Guyana	Americas	\N	2025-06-29 17:39:28.366667	2025-06-29 17:39:28.366667
70	Haiti	Americas	\N	2025-06-29 17:39:28.373746	2025-06-29 17:39:28.373746
71	Honduras	Americas	\N	2025-06-29 17:39:28.380539	2025-06-29 17:39:28.380539
72	Hungary	Europe	\N	2025-06-29 17:39:28.387473	2025-06-29 17:39:28.387473
73	Iceland	Europe	\N	2025-06-29 17:39:28.394858	2025-06-29 17:39:28.394858
74	India	South-East Asia	\N	2025-06-29 17:39:28.401778	2025-06-29 17:39:28.401778
75	Indonesia	South-East Asia	\N	2025-06-29 17:39:28.408801	2025-06-29 17:39:28.408801
76	Iran	Eastern Mediterranean	\N	2025-06-29 17:39:28.422344	2025-06-29 17:39:28.422344
77	Ireland	Europe	\N	2025-06-29 17:39:28.429483	2025-06-29 17:39:28.429483
78	Israel	Europe	\N	2025-06-29 17:39:28.436506	2025-06-29 17:39:28.436506
79	Italy	Europe	\N	2025-06-29 17:39:28.443932	2025-06-29 17:39:28.443932
80	Jamaica	Americas	\N	2025-06-29 17:39:28.450848	2025-06-29 17:39:28.450848
81	Japan	Western Pacific	\N	2025-06-29 17:39:28.457701	2025-06-29 17:39:28.457701
82	Jordan	Eastern Mediterranean	\N	2025-06-29 17:39:28.464661	2025-06-29 17:39:28.464661
83	Kazakhstan	Europe	\N	2025-06-29 17:39:28.471446	2025-06-29 17:39:28.471446
84	Kenya	Africa	\N	2025-06-29 17:39:28.479463	2025-06-29 17:39:28.479463
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 17:39:28.486297	2025-06-29 17:39:28.486297
86	Kyrgyzstan	Europe	\N	2025-06-29 17:39:28.492981	2025-06-29 17:39:28.492981
87	Laos	Western Pacific	\N	2025-06-29 17:39:28.499711	2025-06-29 17:39:28.499711
88	Latvia	Europe	\N	2025-06-29 17:39:28.506042	2025-06-29 17:39:28.506042
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 17:39:28.51245	2025-06-29 17:39:28.51245
90	Lesotho	Africa	\N	2025-06-29 17:39:28.519075	2025-06-29 17:39:28.519075
91	Liberia	Africa	\N	2025-06-29 17:39:28.525503	2025-06-29 17:39:28.525503
92	Libya	Eastern Mediterranean	\N	2025-06-29 17:39:28.537697	2025-06-29 17:39:28.537697
93	Lithuania	Europe	\N	2025-06-29 17:39:28.544227	2025-06-29 17:39:28.544227
94	Luxembourg	Europe	\N	2025-06-29 17:39:28.550737	2025-06-29 17:39:28.550737
95	Madagascar	Africa	\N	2025-06-29 17:39:28.557435	2025-06-29 17:39:28.557435
96	Malawi	Africa	\N	2025-06-29 17:39:28.563649	2025-06-29 17:39:28.563649
97	Malaysia	Western Pacific	\N	2025-06-29 17:39:28.570413	2025-06-29 17:39:28.570413
98	Maldives	South-East Asia	\N	2025-06-29 17:39:28.57757	2025-06-29 17:39:28.57757
99	Mali	Africa	\N	2025-06-29 17:39:28.584447	2025-06-29 17:39:28.584447
100	Malta	Europe	\N	2025-06-29 17:39:28.591654	2025-06-29 17:39:28.591654
101	Mauritania	Africa	\N	2025-06-29 17:39:28.599419	2025-06-29 17:39:28.599419
102	Mauritius	Africa	\N	2025-06-29 17:39:28.606162	2025-06-29 17:39:28.606162
103	Mexico	Americas	\N	2025-06-29 17:39:28.613276	2025-06-29 17:39:28.613276
104	Mongolia	Western Pacific	\N	2025-06-29 17:39:28.620612	2025-06-29 17:39:28.620612
105	Montenegro	Europe	\N	2025-06-29 17:39:28.629787	2025-06-29 17:39:28.629787
106	Morocco	Eastern Mediterranean	\N	2025-06-29 17:39:28.639696	2025-06-29 17:39:28.639696
107	Mozambique	Africa	\N	2025-06-29 17:39:28.647925	2025-06-29 17:39:28.647925
\.


--
-- Data for Name: etl_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etl_metadata (id, file_name, processing_date, records_processed, records_success, records_failed, processing_duration_seconds, notes) FROM stdin;
\.


--
-- Data for Name: health_indicators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file, raw_value_text, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 17:39:27.711208
2	ART Coverage	\N	\N	2025-06-29 17:39:27.722784
3	People Living with HIV	\N	\N	2025-06-29 17:39:27.732621
4	HIV-related Deaths	\N	\N	2025-06-29 17:39:27.73882
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 17:39:27.744916
6	ART Pediatric Coverage	\N	\N	2025-06-29 17:39:27.749246
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminus	$2b$12$8qDaG2FCucGhf/ttTpppK.qS62EFm9AmHpkKTJG0JQceLq9C6MUqa	admin	0	2025-06-29 17:39:27.660869	2025-06-29 17:39:27.660869
2	userus	$2b$12$1Qkh3kX3iGb41Lo7epRFBegJJZ9DdJ6m0JV9hJ8Fo6hQKEgRsz4Ea	user	0	2025-06-29 17:39:27.681282	2025-06-29 17:39:27.681282
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 1, false);


--
-- Name: etl_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etl_metadata_id_seq', 1, false);


--
-- Name: health_indicators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_indicators_id_seq', 1, false);


--
-- Name: indicator_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.indicator_types_id_seq', 1, false);


--
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 2, true);


--
-- Name: countries countries_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_key UNIQUE (name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: etl_metadata etl_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etl_metadata
    ADD CONSTRAINT etl_metadata_pkey PRIMARY KEY (id);


--
-- Name: health_indicators health_indicators_country_id_indicator_type_id_value_type_y_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_indicators
    ADD CONSTRAINT health_indicators_country_id_indicator_type_id_value_type_y_key UNIQUE (country_id, indicator_type_id, value_type, year);


--
-- Name: health_indicators health_indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_indicators
    ADD CONSTRAINT health_indicators_pkey PRIMARY KEY (id);


--
-- Name: indicator_types indicator_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indicator_types
    ADD CONSTRAINT indicator_types_name_key UNIQUE (name);


--
-- Name: indicator_types indicator_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.indicator_types
    ADD CONSTRAINT indicator_types_pkey PRIMARY KEY (id);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: utilisateur utilisateur_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_username_key UNIQUE (username);


--
-- Name: idx_countries_region; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_countries_region ON public.countries USING btree (who_region);


--
-- Name: idx_health_indicators_country; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_health_indicators_country ON public.health_indicators USING btree (country_id);


--
-- Name: idx_health_indicators_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_health_indicators_type ON public.health_indicators USING btree (indicator_type_id);


--
-- Name: idx_health_indicators_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_health_indicators_year ON public.health_indicators USING btree (year);


--
-- Name: idx_utilisateur_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_utilisateur_role ON public.utilisateur USING btree (role);


--
-- Name: idx_utilisateur_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_utilisateur_username ON public.utilisateur USING btree (username);


--
-- Name: health_indicators health_indicators_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_indicators
    ADD CONSTRAINT health_indicators_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: health_indicators health_indicators_indicator_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_indicators
    ADD CONSTRAINT health_indicators_indicator_type_id_fkey FOREIGN KEY (indicator_type_id) REFERENCES public.indicator_types(id);


--
-- PostgreSQL database dump complete
--

