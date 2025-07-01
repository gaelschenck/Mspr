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
1	Afghanistan	Eastern Mediterranean	\N	2025-07-01 04:24:25.637957	2025-07-01 04:24:25.637957
2	Albania	Europe	\N	2025-07-01 04:24:25.641316	2025-07-01 04:24:25.641316
3	Algeria	Africa	\N	2025-07-01 04:24:25.644497	2025-07-01 04:24:25.644497
4	Angola	Africa	\N	2025-07-01 04:24:25.64845	2025-07-01 04:24:25.64845
5	Argentina	Americas	\N	2025-07-01 04:24:25.662401	2025-07-01 04:24:25.662401
6	Armenia	Europe	\N	2025-07-01 04:24:25.665077	2025-07-01 04:24:25.665077
7	Australia	Western Pacific	\N	2025-07-01 04:24:25.667656	2025-07-01 04:24:25.667656
8	Austria	Europe	\N	2025-07-01 04:24:25.670421	2025-07-01 04:24:25.670421
9	Azerbaijan	Europe	\N	2025-07-01 04:24:25.674661	2025-07-01 04:24:25.674661
10	Bahamas	Americas	\N	2025-07-01 04:24:25.67859	2025-07-01 04:24:25.67859
11	Bahrain	Eastern Mediterranean	\N	2025-07-01 04:24:25.681129	2025-07-01 04:24:25.681129
12	Bangladesh	South-East Asia	\N	2025-07-01 04:24:25.68367	2025-07-01 04:24:25.68367
13	Barbados	Americas	\N	2025-07-01 04:24:25.686223	2025-07-01 04:24:25.686223
14	Belarus	Europe	\N	2025-07-01 04:24:25.688814	2025-07-01 04:24:25.688814
15	Belgium	Europe	\N	2025-07-01 04:24:25.691586	2025-07-01 04:24:25.691586
16	Belize	Americas	\N	2025-07-01 04:24:25.694266	2025-07-01 04:24:25.694266
17	Benin	Africa	\N	2025-07-01 04:24:25.69681	2025-07-01 04:24:25.69681
18	Bhutan	South-East Asia	\N	2025-07-01 04:24:25.703831	2025-07-01 04:24:25.703831
19	Bolivia	Americas	\N	2025-07-01 04:24:25.710733	2025-07-01 04:24:25.710733
20	Bosnia and Herzegovina	Europe	\N	2025-07-01 04:24:25.71469	2025-07-01 04:24:25.71469
21	Botswana	Africa	\N	2025-07-01 04:24:25.717441	2025-07-01 04:24:25.717441
22	Brazil	Americas	\N	2025-07-01 04:24:25.720343	2025-07-01 04:24:25.720343
23	Brunei Darussalam	Western Pacific	\N	2025-07-01 04:24:25.724007	2025-07-01 04:24:25.724007
24	Bulgaria	Europe	\N	2025-07-01 04:24:25.727812	2025-07-01 04:24:25.727812
25	Burkina Faso	Africa	\N	2025-07-01 04:24:25.730353	2025-07-01 04:24:25.730353
26	Burundi	Africa	\N	2025-07-01 04:24:25.73283	2025-07-01 04:24:25.73283
27	Cabo Verde	Africa	\N	2025-07-01 04:24:25.735273	2025-07-01 04:24:25.735273
28	Cambodia	Western Pacific	\N	2025-07-01 04:24:25.737809	2025-07-01 04:24:25.737809
29	Cameroon	Africa	\N	2025-07-01 04:24:25.740512	2025-07-01 04:24:25.740512
30	Canada	Americas	\N	2025-07-01 04:24:25.743024	2025-07-01 04:24:25.743024
31	Central African Republic	Africa	\N	2025-07-01 04:24:25.745694	2025-07-01 04:24:25.745694
32	Chad	Africa	\N	2025-07-01 04:24:25.748212	2025-07-01 04:24:25.748212
33	Chile	Americas	\N	2025-07-01 04:24:25.750698	2025-07-01 04:24:25.750698
34	China	Western Pacific	\N	2025-07-01 04:24:25.753231	2025-07-01 04:24:25.753231
35	Colombia	Americas	\N	2025-07-01 04:24:25.75578	2025-07-01 04:24:25.75578
36	Comoros	Africa	\N	2025-07-01 04:24:25.758289	2025-07-01 04:24:25.758289
37	Congo	Americas	\N	2025-07-01 04:24:25.760776	2025-07-01 04:24:25.760776
38	Costa Rica	Americas	\N	2025-07-01 04:24:25.763305	2025-07-01 04:24:25.763305
39	Côte d'Ivoire	Africa	\N	2025-07-01 04:24:25.765891	2025-07-01 04:24:25.765891
40	Croatia	Europe	\N	2025-07-01 04:24:25.76859	2025-07-01 04:24:25.76859
41	Cuba	Americas	\N	2025-07-01 04:24:25.771421	2025-07-01 04:24:25.771421
42	Cyprus	Europe	\N	2025-07-01 04:24:25.774556	2025-07-01 04:24:25.774556
43	Czechia	Europe	\N	2025-07-01 04:24:25.778174	2025-07-01 04:24:25.778174
44	North Korea	Western Pacific	\N	2025-07-01 04:24:25.780906	2025-07-01 04:24:25.780906
45	DR Congo	Africa	\N	2025-07-01 04:24:25.78345	2025-07-01 04:24:25.78345
46	Denmark	Europe	\N	2025-07-01 04:24:25.785942	2025-07-01 04:24:25.785942
47	Djibouti	Eastern Mediterranean	\N	2025-07-01 04:24:25.788466	2025-07-01 04:24:25.788466
48	Dominican Republic	Americas	\N	2025-07-01 04:24:25.792464	2025-07-01 04:24:25.792464
49	Ecuador	Americas	\N	2025-07-01 04:24:25.796573	2025-07-01 04:24:25.796573
50	Egypt	Eastern Mediterranean	\N	2025-07-01 04:24:25.800334	2025-07-01 04:24:25.800334
51	El Salvador	Americas	\N	2025-07-01 04:24:25.802915	2025-07-01 04:24:25.802915
52	Equatorial Guinea	Africa	\N	2025-07-01 04:24:25.805467	2025-07-01 04:24:25.805467
53	Eritrea	Africa	\N	2025-07-01 04:24:25.809216	2025-07-01 04:24:25.809216
54	Estonia	Europe	\N	2025-07-01 04:24:25.813033	2025-07-01 04:24:25.813033
55	Eswatini	Africa	\N	2025-07-01 04:24:25.815622	2025-07-01 04:24:25.815622
56	Ethiopia	Africa	\N	2025-07-01 04:24:25.818154	2025-07-01 04:24:25.818154
57	Fiji	Western Pacific	\N	2025-07-01 04:24:25.820585	2025-07-01 04:24:25.820585
58	Finland	Europe	\N	2025-07-01 04:24:25.82329	2025-07-01 04:24:25.82329
59	France	Europe	\N	2025-07-01 04:24:25.826048	2025-07-01 04:24:25.826048
60	Gabon	Africa	\N	2025-07-01 04:24:25.829066	2025-07-01 04:24:25.829066
61	Gambia	Africa	\N	2025-07-01 04:24:25.833216	2025-07-01 04:24:25.833216
62	Georgia	Europe	\N	2025-07-01 04:24:25.836055	2025-07-01 04:24:25.836055
63	Germany	Europe	\N	2025-07-01 04:24:25.838846	2025-07-01 04:24:25.838846
64	Ghana	Africa	\N	2025-07-01 04:24:25.842505	2025-07-01 04:24:25.842505
65	Greece	Europe	\N	2025-07-01 04:24:25.845545	2025-07-01 04:24:25.845545
66	Guatemala	Americas	\N	2025-07-01 04:24:25.849222	2025-07-01 04:24:25.849222
67	Guinea	Africa	\N	2025-07-01 04:24:25.851898	2025-07-01 04:24:25.851898
68	Guinea-Bissau	Africa	\N	2025-07-01 04:24:25.854372	2025-07-01 04:24:25.854372
69	Guyana	Americas	\N	2025-07-01 04:24:25.858237	2025-07-01 04:24:25.858237
70	Haiti	Americas	\N	2025-07-01 04:24:25.862048	2025-07-01 04:24:25.862048
71	Honduras	Americas	\N	2025-07-01 04:24:25.864993	2025-07-01 04:24:25.864993
72	Hungary	Europe	\N	2025-07-01 04:24:25.867502	2025-07-01 04:24:25.867502
73	Iceland	Europe	\N	2025-07-01 04:24:25.869944	2025-07-01 04:24:25.869944
74	India	South-East Asia	\N	2025-07-01 04:24:25.872454	2025-07-01 04:24:25.872454
75	Indonesia	South-East Asia	\N	2025-07-01 04:24:25.874973	2025-07-01 04:24:25.874973
76	Iran	Eastern Mediterranean	\N	2025-07-01 04:24:25.877463	2025-07-01 04:24:25.877463
77	Ireland	Europe	\N	2025-07-01 04:24:25.879982	2025-07-01 04:24:25.879982
78	Israel	Europe	\N	2025-07-01 04:24:25.882563	2025-07-01 04:24:25.882563
79	Italy	Europe	\N	2025-07-01 04:24:25.885038	2025-07-01 04:24:25.885038
80	Jamaica	Americas	\N	2025-07-01 04:24:25.887649	2025-07-01 04:24:25.887649
81	Japan	Western Pacific	\N	2025-07-01 04:24:25.890582	2025-07-01 04:24:25.890582
82	Jordan	Eastern Mediterranean	\N	2025-07-01 04:24:25.893031	2025-07-01 04:24:25.893031
83	Kazakhstan	Europe	\N	2025-07-01 04:24:25.895476	2025-07-01 04:24:25.895476
84	Kenya	Africa	\N	2025-07-01 04:24:25.897953	2025-07-01 04:24:25.897953
85	Kuwait	Eastern Mediterranean	\N	2025-07-01 04:24:25.900446	2025-07-01 04:24:25.900446
86	Kyrgyzstan	Europe	\N	2025-07-01 04:24:25.904318	2025-07-01 04:24:25.904318
87	Laos	Western Pacific	\N	2025-07-01 04:24:25.908026	2025-07-01 04:24:25.908026
88	Latvia	Europe	\N	2025-07-01 04:24:25.911099	2025-07-01 04:24:25.911099
89	Lebanon	Eastern Mediterranean	\N	2025-07-01 04:24:25.91369	2025-07-01 04:24:25.91369
90	Lesotho	Africa	\N	2025-07-01 04:24:25.916209	2025-07-01 04:24:25.916209
91	Liberia	Africa	\N	2025-07-01 04:24:25.918729	2025-07-01 04:24:25.918729
92	Libya	Eastern Mediterranean	\N	2025-07-01 04:24:25.92119	2025-07-01 04:24:25.92119
93	Lithuania	Europe	\N	2025-07-01 04:24:25.923649	2025-07-01 04:24:25.923649
94	Luxembourg	Europe	\N	2025-07-01 04:24:25.926143	2025-07-01 04:24:25.926143
95	Madagascar	Africa	\N	2025-07-01 04:24:25.928603	2025-07-01 04:24:25.928603
96	Malawi	Africa	\N	2025-07-01 04:24:25.931084	2025-07-01 04:24:25.931084
97	Malaysia	Western Pacific	\N	2025-07-01 04:24:25.934813	2025-07-01 04:24:25.934813
98	Maldives	South-East Asia	\N	2025-07-01 04:24:25.938809	2025-07-01 04:24:25.938809
99	Mali	Africa	\N	2025-07-01 04:24:25.942815	2025-07-01 04:24:25.942815
100	Malta	Europe	\N	2025-07-01 04:24:25.945543	2025-07-01 04:24:25.945543
101	Mauritania	Africa	\N	2025-07-01 04:24:25.948138	2025-07-01 04:24:25.948138
102	Mauritius	Africa	\N	2025-07-01 04:24:25.953037	2025-07-01 04:24:25.953037
103	Mexico	Americas	\N	2025-07-01 04:24:25.956551	2025-07-01 04:24:25.956551
104	Mongolia	Western Pacific	\N	2025-07-01 04:24:25.959335	2025-07-01 04:24:25.959335
105	Montenegro	Europe	\N	2025-07-01 04:24:25.962121	2025-07-01 04:24:25.962121
106	Morocco	Eastern Mediterranean	\N	2025-07-01 04:24:25.964848	2025-07-01 04:24:25.964848
107	Mozambique	Africa	\N	2025-07-01 04:24:25.967583	2025-07-01 04:24:25.967583
108	Myanmar	South-East Asia	\N	2025-07-01 04:24:25.971434	2025-07-01 04:24:25.971434
109	Namibia	Africa	\N	2025-07-01 04:24:25.975637	2025-07-01 04:24:25.975637
110	Nepal	South-East Asia	\N	2025-07-01 04:24:25.979751	2025-07-01 04:24:25.979751
111	Netherlands	Europe	\N	2025-07-01 04:24:25.982478	2025-07-01 04:24:25.982478
112	New Zealand	Western Pacific	\N	2025-07-01 04:24:25.984991	2025-07-01 04:24:25.984991
113	Nicaragua	Americas	\N	2025-07-01 04:24:25.989012	2025-07-01 04:24:25.989012
114	Niger	Africa	\N	2025-07-01 04:24:25.993075	2025-07-01 04:24:25.993075
115	Nigeria	Africa	\N	2025-07-01 04:24:25.997198	2025-07-01 04:24:25.997198
116	Norway	Europe	\N	2025-07-01 04:24:25.999952	2025-07-01 04:24:25.999952
117	Oman	Eastern Mediterranean	\N	2025-07-01 04:24:26.002827	2025-07-01 04:24:26.002827
118	Pakistan	Eastern Mediterranean	\N	2025-07-01 04:24:26.006724	2025-07-01 04:24:26.006724
119	Panama	Americas	\N	2025-07-01 04:24:26.010877	2025-07-01 04:24:26.010877
120	Papua New Guinea	Western Pacific	\N	2025-07-01 04:24:26.013549	2025-07-01 04:24:26.013549
121	Paraguay	Americas	\N	2025-07-01 04:24:26.015985	2025-07-01 04:24:26.015985
122	Peru	Americas	\N	2025-07-01 04:24:26.018401	2025-07-01 04:24:26.018401
123	Philippines	Western Pacific	\N	2025-07-01 04:24:26.020781	2025-07-01 04:24:26.020781
124	Poland	Europe	\N	2025-07-01 04:24:26.023393	2025-07-01 04:24:26.023393
125	Portugal	Europe	\N	2025-07-01 04:24:26.026067	2025-07-01 04:24:26.026067
126	Qatar	Eastern Mediterranean	\N	2025-07-01 04:24:26.028721	2025-07-01 04:24:26.028721
127	South Korea	Western Pacific	\N	2025-07-01 04:24:26.032332	2025-07-01 04:24:26.032332
128	Moldova	Europe	\N	2025-07-01 04:24:26.035217	2025-07-01 04:24:26.035217
129	North Macedonia	Europe	\N	2025-07-01 04:24:26.037689	2025-07-01 04:24:26.037689
130	Romania	Europe	\N	2025-07-01 04:24:26.040166	2025-07-01 04:24:26.040166
131	Russia	Europe	\N	2025-07-01 04:24:26.042713	2025-07-01 04:24:26.042713
132	Rwanda	Africa	\N	2025-07-01 04:24:26.0454	2025-07-01 04:24:26.0454
133	Saudi Arabia	Eastern Mediterranean	\N	2025-07-01 04:24:26.048029	2025-07-01 04:24:26.048029
134	Senegal	Africa	\N	2025-07-01 04:24:26.051637	2025-07-01 04:24:26.051637
135	Serbia	Europe	\N	2025-07-01 04:24:26.054227	2025-07-01 04:24:26.054227
136	Sierra Leone	Africa	\N	2025-07-01 04:24:26.056661	2025-07-01 04:24:26.056661
137	Singapore	Western Pacific	\N	2025-07-01 04:24:26.059139	2025-07-01 04:24:26.059139
138	Slovakia	Europe	\N	2025-07-01 04:24:26.061718	2025-07-01 04:24:26.061718
139	Slovenia	Europe	\N	2025-07-01 04:24:26.064386	2025-07-01 04:24:26.064386
140	Somalia	Eastern Mediterranean	\N	2025-07-01 04:24:26.068328	2025-07-01 04:24:26.068328
141	South Africa	Africa	\N	2025-07-01 04:24:26.070909	2025-07-01 04:24:26.070909
142	South Sudan	Africa	\N	2025-07-01 04:24:26.073798	2025-07-01 04:24:26.073798
143	Spain	Europe	\N	2025-07-01 04:24:26.076685	2025-07-01 04:24:26.076685
144	Sri Lanka	South-East Asia	\N	2025-07-01 04:24:26.080029	2025-07-01 04:24:26.080029
145	Sudan	Eastern Mediterranean	\N	2025-07-01 04:24:26.082899	2025-07-01 04:24:26.082899
146	Suriname	Americas	\N	2025-07-01 04:24:26.085746	2025-07-01 04:24:26.085746
147	Sweden	Europe	\N	2025-07-01 04:24:26.088718	2025-07-01 04:24:26.088718
148	Switzerland	Europe	\N	2025-07-01 04:24:26.092958	2025-07-01 04:24:26.092958
149	Syria	Eastern Mediterranean	\N	2025-07-01 04:24:26.098158	2025-07-01 04:24:26.098158
150	Tajikistan	Europe	\N	2025-07-01 04:24:26.101495	2025-07-01 04:24:26.101495
151	Thailand	South-East Asia	\N	2025-07-01 04:24:26.104313	2025-07-01 04:24:26.104313
152	Timor-Leste	South-East Asia	\N	2025-07-01 04:24:26.107813	2025-07-01 04:24:26.107813
153	Togo	Africa	\N	2025-07-01 04:24:26.112558	2025-07-01 04:24:26.112558
154	Trinidad and Tobago	Americas	\N	2025-07-01 04:24:26.115966	2025-07-01 04:24:26.115966
155	Tunisia	Eastern Mediterranean	\N	2025-07-01 04:24:26.11928	2025-07-01 04:24:26.11928
156	Turkey	Europe	\N	2025-07-01 04:24:26.123747	2025-07-01 04:24:26.123747
157	Turkmenistan	Europe	\N	2025-07-01 04:24:26.127282	2025-07-01 04:24:26.127282
158	Uganda	Africa	\N	2025-07-01 04:24:26.130503	2025-07-01 04:24:26.130503
159	Ukraine	Europe	\N	2025-07-01 04:24:26.133648	2025-07-01 04:24:26.133648
160	United Arab Emirates	Eastern Mediterranean	\N	2025-07-01 04:24:26.137137	2025-07-01 04:24:26.137137
161	United Kingdom	Europe	\N	2025-07-01 04:24:26.140816	2025-07-01 04:24:26.140816
162	Tanzania	Africa	\N	2025-07-01 04:24:26.144212	2025-07-01 04:24:26.144212
163	United States	Americas	\N	2025-07-01 04:24:26.147122	2025-07-01 04:24:26.147122
164	Uruguay	Americas	\N	2025-07-01 04:24:26.151442	2025-07-01 04:24:26.151442
165	Uzbekistan	Europe	\N	2025-07-01 04:24:26.156345	2025-07-01 04:24:26.156345
166	Venezuela	Americas	\N	2025-07-01 04:24:26.159677	2025-07-01 04:24:26.159677
167	Viet Nam	Western Pacific	\N	2025-07-01 04:24:26.162539	2025-07-01 04:24:26.162539
168	Yemen	Eastern Mediterranean	\N	2025-07-01 04:24:26.165404	2025-07-01 04:24:26.165404
169	Zambia	Africa	\N	2025-07-01 04:24:26.168571	2025-07-01 04:24:26.168571
170	Zimbabwe	Africa	\N	2025-07-01 04:24:26.171815	2025-07-01 04:24:26.171815
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.176384	2025-07-01 04:24:26.176384
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.181779	2025-07-01 04:24:26.181779
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.186325	2025-07-01 04:24:26.186325
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.191534	2025-07-01 04:24:26.191534
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.195221	2025-07-01 04:24:26.195221
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.198517	2025-07-01 04:24:26.198517
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.201687	2025-07-01 04:24:26.201687
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.204703	2025-07-01 04:24:26.204703
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.207712	2025-07-01 04:24:26.207712
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.210737	2025-07-01 04:24:26.210737
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.214948	2025-07-01 04:24:26.214948
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.218176	2025-07-01 04:24:26.218176
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.221851	2025-07-01 04:24:26.221851
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.225033	2025-07-01 04:24:26.225033
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.228076	2025-07-01 04:24:26.228076
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.23233	2025-07-01 04:24:26.23233
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.237198	2025-07-01 04:24:26.237198
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.241737	2025-07-01 04:24:26.241737
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.244813	2025-07-01 04:24:26.244813
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.248127	2025-07-01 04:24:26.248127
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.251231	2025-07-01 04:24:26.251231
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.255884	2025-07-01 04:24:26.255884
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.259453	2025-07-01 04:24:26.259453
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.263182	2025-07-01 04:24:26.263182
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.267751	2025-07-01 04:24:26.267751
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.270784	2025-07-01 04:24:26.270784
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.273745	2025-07-01 04:24:26.273745
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.27674	2025-07-01 04:24:26.27674
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.279806	2025-07-01 04:24:26.279806
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.282877	2025-07-01 04:24:26.282877
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.285814	2025-07-01 04:24:26.285814
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.288753	2025-07-01 04:24:26.288753
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.291749	2025-07-01 04:24:26.291749
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.294747	2025-07-01 04:24:26.294747
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.297709	2025-07-01 04:24:26.297709
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.300895	2025-07-01 04:24:26.300895
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.30425	2025-07-01 04:24:26.30425
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.308633	2025-07-01 04:24:26.308633
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.311982	2025-07-01 04:24:26.311982
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.315009	2025-07-01 04:24:26.315009
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.317948	2025-07-01 04:24:26.317948
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.321181	2025-07-01 04:24:26.321181
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.324589	2025-07-01 04:24:26.324589
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.328213	2025-07-01 04:24:26.328213
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.331406	2025-07-01 04:24:26.331406
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.334459	2025-07-01 04:24:26.334459
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.33794	2025-07-01 04:24:26.33794
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.340931	2025-07-01 04:24:26.340931
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.344015	2025-07-01 04:24:26.344015
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.34789	2025-07-01 04:24:26.34789
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.351264	2025-07-01 04:24:26.351264
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.354267	2025-07-01 04:24:26.354267
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.357509	2025-07-01 04:24:26.357509
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.36143	2025-07-01 04:24:26.36143
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.364527	2025-07-01 04:24:26.364527
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.367505	2025-07-01 04:24:26.367505
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.370797	2025-07-01 04:24:26.370797
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.374087	2025-07-01 04:24:26.374087
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.377409	2025-07-01 04:24:26.377409
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.380749	2025-07-01 04:24:26.380749
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.415452	2025-07-01 04:24:26.415452
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.41909	2025-07-01 04:24:26.41909
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.422643	2025-07-01 04:24:26.422643
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.426089	2025-07-01 04:24:26.426089
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.429465	2025-07-01 04:24:26.429465
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.484326	2025-07-01 04:24:26.484326
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.491626	2025-07-01 04:24:26.491626
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.501594	2025-07-01 04:24:26.501594
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.514669	2025-07-01 04:24:26.514669
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.552085	2025-07-01 04:24:26.552085
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.55576	2025-07-01 04:24:26.55576
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.558751	2025-07-01 04:24:26.558751
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.561906	2025-07-01 04:24:26.561906
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.56495	2025-07-01 04:24:26.56495
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.56803	2025-07-01 04:24:26.56803
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.571057	2025-07-01 04:24:26.571057
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.574065	2025-07-01 04:24:26.574065
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.577132	2025-07-01 04:24:26.577132
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.580131	2025-07-01 04:24:26.580131
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.583539	2025-07-01 04:24:26.583539
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.587042	2025-07-01 04:24:26.587042
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.59041	2025-07-01 04:24:26.59041
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.625131	2025-07-01 04:24:26.625131
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.638331	2025-07-01 04:24:26.638331
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.641767	2025-07-01 04:24:26.641767
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.645205	2025-07-01 04:24:26.645205
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.649588	2025-07-01 04:24:26.649588
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.684254	2025-07-01 04:24:26.684254
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.687766	2025-07-01 04:24:26.687766
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.691084	2025-07-01 04:24:26.691084
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.69436	2025-07-01 04:24:26.69436
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.697677	2025-07-01 04:24:26.697677
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.70081	2025-07-01 04:24:26.70081
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.735356	2025-07-01 04:24:26.735356
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.739956	2025-07-01 04:24:26.739956
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.743061	2025-07-01 04:24:26.743061
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.746094	2025-07-01 04:24:26.746094
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.749144	2025-07-01 04:24:26.749144
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.752184	2025-07-01 04:24:26.752184
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.755248	2025-07-01 04:24:26.755248
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.758274	2025-07-01 04:24:26.758274
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.761382	2025-07-01 04:24:26.761382
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.764715	2025-07-01 04:24:26.764715
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.768181	2025-07-01 04:24:26.768181
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.771672	2025-07-01 04:24:26.771672
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.806452	2025-07-01 04:24:26.806452
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.810024	2025-07-01 04:24:26.810024
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.813437	2025-07-01 04:24:26.813437
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.817052	2025-07-01 04:24:26.817052
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.820511	2025-07-01 04:24:26.820511
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.854981	2025-07-01 04:24:26.854981
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.858345	2025-07-01 04:24:26.858345
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.862675	2025-07-01 04:24:26.862675
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.867662	2025-07-01 04:24:26.867662
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.870927	2025-07-01 04:24:26.870927
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.873855	2025-07-01 04:24:26.873855
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.876811	2025-07-01 04:24:26.876811
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.879799	2025-07-01 04:24:26.879799
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.882826	2025-07-01 04:24:26.882826
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.886107	2025-07-01 04:24:26.886107
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.889179	2025-07-01 04:24:26.889179
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.892176	2025-07-01 04:24:26.892176
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.895206	2025-07-01 04:24:26.895206
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.89813	2025-07-01 04:24:26.89813
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.901078	2025-07-01 04:24:26.901078
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.904403	2025-07-01 04:24:26.904403
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.938836	2025-07-01 04:24:26.938836
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.94238	2025-07-01 04:24:26.94238
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.946841	2025-07-01 04:24:26.946841
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.951687	2025-07-01 04:24:26.951687
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.955355	2025-07-01 04:24:26.955355
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.989665	2025-07-01 04:24:26.989665
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.993293	2025-07-01 04:24:26.993293
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:26.996617	2025-07-01 04:24:26.996617
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.000013	2025-07-01 04:24:27.000013
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.00468	2025-07-01 04:24:27.00468
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.03918	2025-07-01 04:24:27.03918
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.049702	2025-07-01 04:24:27.049702
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.054704	2025-07-01 04:24:27.054704
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.05794	2025-07-01 04:24:27.05794
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.061189	2025-07-01 04:24:27.061189
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.064486	2025-07-01 04:24:27.064486
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.068129	2025-07-01 04:24:27.068129
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.072375	2025-07-01 04:24:27.072375
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.107299	2025-07-01 04:24:27.107299
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.111024	2025-07-01 04:24:27.111024
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.114536	2025-07-01 04:24:27.114536
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.117661	2025-07-01 04:24:27.117661
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.121109	2025-07-01 04:24:27.121109
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.124479	2025-07-01 04:24:27.124479
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.159193	2025-07-01 04:24:27.159193
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.162846	2025-07-01 04:24:27.162846
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.166365	2025-07-01 04:24:27.166365
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.177893	2025-07-01 04:24:27.177893
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.181164	2025-07-01 04:24:27.181164
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.221861	2025-07-01 04:24:27.221861
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.241581	2025-07-01 04:24:27.241581
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.261583	2025-07-01 04:24:27.261583
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.276071	2025-07-01 04:24:27.276071
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.284215	2025-07-01 04:24:27.284215
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.287837	2025-07-01 04:24:27.287837
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.320198	2025-07-01 04:24:27.320198
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.323836	2025-07-01 04:24:27.323836
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.327249	2025-07-01 04:24:27.327249
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.330794	2025-07-01 04:24:27.330794
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.334373	2025-07-01 04:24:27.334373
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.359036	2025-07-01 04:24:27.359036
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.362421	2025-07-01 04:24:27.362421
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.365629	2025-07-01 04:24:27.365629
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.368748	2025-07-01 04:24:27.368748
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.373173	2025-07-01 04:24:27.373173
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.376783	2025-07-01 04:24:27.376783
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.380167	2025-07-01 04:24:27.380167
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.383621	2025-07-01 04:24:27.383621
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.387084	2025-07-01 04:24:27.387084
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.391387	2025-07-01 04:24:27.391387
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.394985	2025-07-01 04:24:27.394985
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.398323	2025-07-01 04:24:27.398323
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.401443	2025-07-01 04:24:27.401443
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.404587	2025-07-01 04:24:27.404587
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.407992	2025-07-01 04:24:27.407992
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.411327	2025-07-01 04:24:27.411327
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.414858	2025-07-01 04:24:27.414858
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.418429	2025-07-01 04:24:27.418429
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.421567	2025-07-01 04:24:27.421567
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.424687	2025-07-01 04:24:27.424687
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.427797	2025-07-01 04:24:27.427797
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.431525	2025-07-01 04:24:27.431525
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.434705	2025-07-01 04:24:27.434705
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.437954	2025-07-01 04:24:27.437954
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.441168	2025-07-01 04:24:27.441168
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.44441	2025-07-01 04:24:27.44441
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.447457	2025-07-01 04:24:27.447457
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.45047	2025-07-01 04:24:27.45047
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.453783	2025-07-01 04:24:27.453783
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.458129	2025-07-01 04:24:27.458129
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.461552	2025-07-01 04:24:27.461552
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.464884	2025-07-01 04:24:27.464884
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.468122	2025-07-01 04:24:27.468122
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.471229	2025-07-01 04:24:27.471229
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.47564	2025-07-01 04:24:27.47564
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.479015	2025-07-01 04:24:27.479015
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.482371	2025-07-01 04:24:27.482371
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.485512	2025-07-01 04:24:27.485512
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.488593	2025-07-01 04:24:27.488593
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.491688	2025-07-01 04:24:27.491688
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.495108	2025-07-01 04:24:27.495108
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.498458	2025-07-01 04:24:27.498458
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.501617	2025-07-01 04:24:27.501617
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.508248	2025-07-01 04:24:27.508248
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.511259	2025-07-01 04:24:27.511259
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.514349	2025-07-01 04:24:27.514349
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.517575	2025-07-01 04:24:27.517575
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.520833	2025-07-01 04:24:27.520833
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.523843	2025-07-01 04:24:27.523843
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.526639	2025-07-01 04:24:27.526639
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.529483	2025-07-01 04:24:27.529483
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.532336	2025-07-01 04:24:27.532336
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.535326	2025-07-01 04:24:27.535326
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.538656	2025-07-01 04:24:27.538656
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.54318	2025-07-01 04:24:27.54318
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.546705	2025-07-01 04:24:27.546705
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.550052	2025-07-01 04:24:27.550052
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.553387	2025-07-01 04:24:27.553387
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.556641	2025-07-01 04:24:27.556641
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.561015	2025-07-01 04:24:27.561015
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.564523	2025-07-01 04:24:27.564523
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.5681	2025-07-01 04:24:27.5681
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.571097	2025-07-01 04:24:27.571097
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.574508	2025-07-01 04:24:27.574508
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.577408	2025-07-01 04:24:27.577408
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.580459	2025-07-01 04:24:27.580459
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.583857	2025-07-01 04:24:27.583857
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.587177	2025-07-01 04:24:27.587177
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.590238	2025-07-01 04:24:27.590238
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.593049	2025-07-01 04:24:27.593049
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.595818	2025-07-01 04:24:27.595818
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.599053	2025-07-01 04:24:27.599053
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.602192	2025-07-01 04:24:27.602192
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.605214	2025-07-01 04:24:27.605214
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.608652	2025-07-01 04:24:27.608652
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.61205	2025-07-01 04:24:27.61205
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.616793	2025-07-01 04:24:27.616793
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.619672	2025-07-01 04:24:27.619672
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.622482	2025-07-01 04:24:27.622482
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.626718	2025-07-01 04:24:27.626718
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.630114	2025-07-01 04:24:27.630114
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.633521	2025-07-01 04:24:27.633521
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.636724	2025-07-01 04:24:27.636724
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.63987	2025-07-01 04:24:27.63987
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.644334	2025-07-01 04:24:27.644334
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.647665	2025-07-01 04:24:27.647665
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.650825	2025-07-01 04:24:27.650825
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.653981	2025-07-01 04:24:27.653981
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.657286	2025-07-01 04:24:27.657286
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.660422	2025-07-01 04:24:27.660422
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.664967	2025-07-01 04:24:27.664967
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.669406	2025-07-01 04:24:27.669406
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.672131	2025-07-01 04:24:27.672131
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.674978	2025-07-01 04:24:27.674978
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.677826	2025-07-01 04:24:27.677826
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.680624	2025-07-01 04:24:27.680624
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.683753	2025-07-01 04:24:27.683753
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.686905	2025-07-01 04:24:27.686905
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.690582	2025-07-01 04:24:27.690582
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.694277	2025-07-01 04:24:27.694277
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.697542	2025-07-01 04:24:27.697542
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.701835	2025-07-01 04:24:27.701835
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.705178	2025-07-01 04:24:27.705178
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.70856	2025-07-01 04:24:27.70856
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.71196	2025-07-01 04:24:27.71196
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.715138	2025-07-01 04:24:27.715138
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.71844	2025-07-01 04:24:27.71844
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.72148	2025-07-01 04:24:27.72148
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.724247	2025-07-01 04:24:27.724247
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.726981	2025-07-01 04:24:27.726981
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.729837	2025-07-01 04:24:27.729837
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.732853	2025-07-01 04:24:27.732853
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.735634	2025-07-01 04:24:27.735634
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.738341	2025-07-01 04:24:27.738341
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.74117	2025-07-01 04:24:27.74117
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.743957	2025-07-01 04:24:27.743957
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.746707	2025-07-01 04:24:27.746707
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.749562	2025-07-01 04:24:27.749562
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.752342	2025-07-01 04:24:27.752342
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.755276	2025-07-01 04:24:27.755276
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.758147	2025-07-01 04:24:27.758147
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.761335	2025-07-01 04:24:27.761335
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.76437	2025-07-01 04:24:27.76437
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.767309	2025-07-01 04:24:27.767309
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.77047	2025-07-01 04:24:27.77047
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.774241	2025-07-01 04:24:27.774241
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.778192	2025-07-01 04:24:27.778192
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.781609	2025-07-01 04:24:27.781609
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.784614	2025-07-01 04:24:27.784614
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.787854	2025-07-01 04:24:27.787854
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.791273	2025-07-01 04:24:27.791273
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.794404	2025-07-01 04:24:27.794404
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.797297	2025-07-01 04:24:27.797297
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.800189	2025-07-01 04:24:27.800189
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.803341	2025-07-01 04:24:27.803341
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.80612	2025-07-01 04:24:27.80612
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.808881	2025-07-01 04:24:27.808881
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:27.811735	2025-07-01 04:24:27.811735
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.814503	2025-07-01 04:24:27.814503
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.817248	2025-07-01 04:24:27.817248
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.819954	2025-07-01 04:24:27.819954
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.822764	2025-07-01 04:24:27.822764
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.825712	2025-07-01 04:24:27.825712
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.828567	2025-07-01 04:24:27.828567
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.831375	2025-07-01 04:24:27.831375
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.834231	2025-07-01 04:24:27.834231
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.838556	2025-07-01 04:24:27.838556
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.84285	2025-07-01 04:24:27.84285
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.846276	2025-07-01 04:24:27.846276
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.849634	2025-07-01 04:24:27.849634
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.852744	2025-07-01 04:24:27.852744
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.856281	2025-07-01 04:24:27.856281
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.859789	2025-07-01 04:24:27.859789
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.863203	2025-07-01 04:24:27.863203
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.866191	2025-07-01 04:24:27.866191
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.869081	2025-07-01 04:24:27.869081
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.871976	2025-07-01 04:24:27.871976
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.874924	2025-07-01 04:24:27.874924
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.877852	2025-07-01 04:24:27.877852
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.88071	2025-07-01 04:24:27.88071
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.883589	2025-07-01 04:24:27.883589
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.886423	2025-07-01 04:24:27.886423
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.890623	2025-07-01 04:24:27.890623
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.89396	2025-07-01 04:24:27.89396
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.896899	2025-07-01 04:24:27.896899
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.900197	2025-07-01 04:24:27.900197
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.903446	2025-07-01 04:24:27.903446
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.90772	2025-07-01 04:24:27.90772
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.911047	2025-07-01 04:24:27.911047
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.914353	2025-07-01 04:24:27.914353
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.917437	2025-07-01 04:24:27.917437
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.920643	2025-07-01 04:24:27.920643
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.923683	2025-07-01 04:24:27.923683
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.927036	2025-07-01 04:24:27.927036
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.930387	2025-07-01 04:24:27.930387
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.933965	2025-07-01 04:24:27.933965
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.936979	2025-07-01 04:24:27.936979
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.940244	2025-07-01 04:24:27.940244
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.946366	2025-07-01 04:24:27.946366
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.951108	2025-07-01 04:24:27.951108
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.956142	2025-07-01 04:24:27.956142
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.964886	2025-07-01 04:24:27.964886
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.969375	2025-07-01 04:24:27.969375
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.973824	2025-07-01 04:24:27.973824
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.977423	2025-07-01 04:24:27.977423
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.982569	2025-07-01 04:24:27.982569
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.988814	2025-07-01 04:24:27.988814
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.993751	2025-07-01 04:24:27.993751
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:27.997106	2025-07-01 04:24:27.997106
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.000447	2025-07-01 04:24:28.000447
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.003815	2025-07-01 04:24:28.003815
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.007172	2025-07-01 04:24:28.007172
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.010713	2025-07-01 04:24:28.010713
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.014468	2025-07-01 04:24:28.014468
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.017696	2025-07-01 04:24:28.017696
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.020711	2025-07-01 04:24:28.020711
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.023589	2025-07-01 04:24:28.023589
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.026385	2025-07-01 04:24:28.026385
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.029136	2025-07-01 04:24:28.029136
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.031834	2025-07-01 04:24:28.031834
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.035767	2025-07-01 04:24:28.035767
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.038788	2025-07-01 04:24:28.038788
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.041656	2025-07-01 04:24:28.041656
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.044526	2025-07-01 04:24:28.044526
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.047338	2025-07-01 04:24:28.047338
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.050416	2025-07-01 04:24:28.050416
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.053439	2025-07-01 04:24:28.053439
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.056686	2025-07-01 04:24:28.056686
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.059927	2025-07-01 04:24:28.059927
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.063706	2025-07-01 04:24:28.063706
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.067048	2025-07-01 04:24:28.067048
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.070259	2025-07-01 04:24:28.070259
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.073788	2025-07-01 04:24:28.073788
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.077834	2025-07-01 04:24:28.077834
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.08107	2025-07-01 04:24:28.08107
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.084101	2025-07-01 04:24:28.084101
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.087339	2025-07-01 04:24:28.087339
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.090952	2025-07-01 04:24:28.090952
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.094726	2025-07-01 04:24:28.094726
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.097967	2025-07-01 04:24:28.097967
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.10085	2025-07-01 04:24:28.10085
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.103789	2025-07-01 04:24:28.103789
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.106665	2025-07-01 04:24:28.106665
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.109512	2025-07-01 04:24:28.109512
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.112371	2025-07-01 04:24:28.112371
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.115715	2025-07-01 04:24:28.115715
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.11855	2025-07-01 04:24:28.11855
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.121766	2025-07-01 04:24:28.121766
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.126447	2025-07-01 04:24:28.126447
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.129801	2025-07-01 04:24:28.129801
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.132745	2025-07-01 04:24:28.132745
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.135741	2025-07-01 04:24:28.135741
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.13907	2025-07-01 04:24:28.13907
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.142581	2025-07-01 04:24:28.142581
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.146394	2025-07-01 04:24:28.146394
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.149617	2025-07-01 04:24:28.149617
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.152564	2025-07-01 04:24:28.152564
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.155556	2025-07-01 04:24:28.155556
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.15868	2025-07-01 04:24:28.15868
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.16183	2025-07-01 04:24:28.16183
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.16501	2025-07-01 04:24:28.16501
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.167926	2025-07-01 04:24:28.167926
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.171228	2025-07-01 04:24:28.171228
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.173965	2025-07-01 04:24:28.173965
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.178173	2025-07-01 04:24:28.178173
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.18141	2025-07-01 04:24:28.18141
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.187953	2025-07-01 04:24:28.187953
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.190999	2025-07-01 04:24:28.190999
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.194062	2025-07-01 04:24:28.194062
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.19705	2025-07-01 04:24:28.19705
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.200162	2025-07-01 04:24:28.200162
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.203381	2025-07-01 04:24:28.203381
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.207711	2025-07-01 04:24:28.207711
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.211391	2025-07-01 04:24:28.211391
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.214683	2025-07-01 04:24:28.214683
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.261429	2025-07-01 04:24:28.261429
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.268899	2025-07-01 04:24:28.268899
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.272592	2025-07-01 04:24:28.272592
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.27599	2025-07-01 04:24:28.27599
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.279228	2025-07-01 04:24:28.279228
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.283649	2025-07-01 04:24:28.283649
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.287227	2025-07-01 04:24:28.287227
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.290601	2025-07-01 04:24:28.290601
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.293901	2025-07-01 04:24:28.293901
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.297201	2025-07-01 04:24:28.297201
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.301721	2025-07-01 04:24:28.301721
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.305194	2025-07-01 04:24:28.305194
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.308477	2025-07-01 04:24:28.308477
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.311643	2025-07-01 04:24:28.311643
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.314638	2025-07-01 04:24:28.314638
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.3178	2025-07-01 04:24:28.3178
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.321248	2025-07-01 04:24:28.321248
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.324287	2025-07-01 04:24:28.324287
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.32718	2025-07-01 04:24:28.32718
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.331188	2025-07-01 04:24:28.331188
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.334192	2025-07-01 04:24:28.334192
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.337368	2025-07-01 04:24:28.337368
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.340539	2025-07-01 04:24:28.340539
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.343569	2025-07-01 04:24:28.343569
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.346501	2025-07-01 04:24:28.346501
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.350887	2025-07-01 04:24:28.350887
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.354351	2025-07-01 04:24:28.354351
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.357708	2025-07-01 04:24:28.357708
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.361373	2025-07-01 04:24:28.361373
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.364847	2025-07-01 04:24:28.364847
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.369262	2025-07-01 04:24:28.369262
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.372666	2025-07-01 04:24:28.372666
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.375948	2025-07-01 04:24:28.375948
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.379293	2025-07-01 04:24:28.379293
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.38224	2025-07-01 04:24:28.38224
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.385331	2025-07-01 04:24:28.385331
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.388769	2025-07-01 04:24:28.388769
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.392356	2025-07-01 04:24:28.392356
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.395731	2025-07-01 04:24:28.395731
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.398643	2025-07-01 04:24:28.398643
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.401574	2025-07-01 04:24:28.401574
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.404884	2025-07-01 04:24:28.404884
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.407942	2025-07-01 04:24:28.407942
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.411015	2025-07-01 04:24:28.411015
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.413794	2025-07-01 04:24:28.413794
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.416856	2025-07-01 04:24:28.416856
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.421154	2025-07-01 04:24:28.421154
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.424524	2025-07-01 04:24:28.424524
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.42777	2025-07-01 04:24:28.42777
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.431006	2025-07-01 04:24:28.431006
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.434334	2025-07-01 04:24:28.434334
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.438745	2025-07-01 04:24:28.438745
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.442167	2025-07-01 04:24:28.442167
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.444977	2025-07-01 04:24:28.444977
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.44775	2025-07-01 04:24:28.44775
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.450693	2025-07-01 04:24:28.450693
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.453715	2025-07-01 04:24:28.453715
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.457807	2025-07-01 04:24:28.457807
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.460756	2025-07-01 04:24:28.460756
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.463942	2025-07-01 04:24:28.463942
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.467528	2025-07-01 04:24:28.467528
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.471159	2025-07-01 04:24:28.471159
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.474839	2025-07-01 04:24:28.474839
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.477939	2025-07-01 04:24:28.477939
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.481074	2025-07-01 04:24:28.481074
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.484006	2025-07-01 04:24:28.484006
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.487044	2025-07-01 04:24:28.487044
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.490203	2025-07-01 04:24:28.490203
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.493754	2025-07-01 04:24:28.493754
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.497113	2025-07-01 04:24:28.497113
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.500315	2025-07-01 04:24:28.500315
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.503815	2025-07-01 04:24:28.503815
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.507025	2025-07-01 04:24:28.507025
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.539608	2025-07-01 04:24:28.539608
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.544601	2025-07-01 04:24:28.544601
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.548747	2025-07-01 04:24:28.548747
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.552136	2025-07-01 04:24:28.552136
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.555578	2025-07-01 04:24:28.555578
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.559001	2025-07-01 04:24:28.559001
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.561993	2025-07-01 04:24:28.561993
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.565048	2025-07-01 04:24:28.565048
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.59944	2025-07-01 04:24:28.59944
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.604771	2025-07-01 04:24:28.604771
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.610321	2025-07-01 04:24:28.610321
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.613334	2025-07-01 04:24:28.613334
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.616184	2025-07-01 04:24:28.616184
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.618952	2025-07-01 04:24:28.618952
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.622035	2025-07-01 04:24:28.622035
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.634125	2025-07-01 04:24:28.634125
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.637523	2025-07-01 04:24:28.637523
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.6407	2025-07-01 04:24:28.6407
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.643868	2025-07-01 04:24:28.643868
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.647092	2025-07-01 04:24:28.647092
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.67107	2025-07-01 04:24:28.67107
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.674827	2025-07-01 04:24:28.674827
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.678521	2025-07-01 04:24:28.678521
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.682295	2025-07-01 04:24:28.682295
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.685524	2025-07-01 04:24:28.685524
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.708433	2025-07-01 04:24:28.708433
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.712117	2025-07-01 04:24:28.712117
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.71549	2025-07-01 04:24:28.71549
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.720057	2025-07-01 04:24:28.720057
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.723528	2025-07-01 04:24:28.723528
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.727091	2025-07-01 04:24:28.727091
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.746666	2025-07-01 04:24:28.746666
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.75001	2025-07-01 04:24:28.75001
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.753038	2025-07-01 04:24:28.753038
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.75627	2025-07-01 04:24:28.75627
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.75905	2025-07-01 04:24:28.75905
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.762294	2025-07-01 04:24:28.762294
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.765934	2025-07-01 04:24:28.765934
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.769972	2025-07-01 04:24:28.769972
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.799901	2025-07-01 04:24:28.799901
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.803963	2025-07-01 04:24:28.803963
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.807482	2025-07-01 04:24:28.807482
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.811304	2025-07-01 04:24:28.811304
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.815315	2025-07-01 04:24:28.815315
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.818763	2025-07-01 04:24:28.818763
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.821939	2025-07-01 04:24:28.821939
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.825162	2025-07-01 04:24:28.825162
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.829513	2025-07-01 04:24:28.829513
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.833048	2025-07-01 04:24:28.833048
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.837784	2025-07-01 04:24:28.837784
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.841262	2025-07-01 04:24:28.841262
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.844165	2025-07-01 04:24:28.844165
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.847201	2025-07-01 04:24:28.847201
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.850487	2025-07-01 04:24:28.850487
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.855231	2025-07-01 04:24:28.855231
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.859027	2025-07-01 04:24:28.859027
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.86251	2025-07-01 04:24:28.86251
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.866573	2025-07-01 04:24:28.866573
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.870513	2025-07-01 04:24:28.870513
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.873885	2025-07-01 04:24:28.873885
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.878444	2025-07-01 04:24:28.878444
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.881906	2025-07-01 04:24:28.881906
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.885582	2025-07-01 04:24:28.885582
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.888779	2025-07-01 04:24:28.888779
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.892011	2025-07-01 04:24:28.892011
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.896648	2025-07-01 04:24:28.896648
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.90026	2025-07-01 04:24:28.90026
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.904787	2025-07-01 04:24:28.904787
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.908589	2025-07-01 04:24:28.908589
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.911706	2025-07-01 04:24:28.911706
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.914824	2025-07-01 04:24:28.914824
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.918058	2025-07-01 04:24:28.918058
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.921792	2025-07-01 04:24:28.921792
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.92454	2025-07-01 04:24:28.92454
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.927502	2025-07-01 04:24:28.927502
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.931921	2025-07-01 04:24:28.931921
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.937076	2025-07-01 04:24:28.937076
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.94053	2025-07-01 04:24:28.94053
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.943804	2025-07-01 04:24:28.943804
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.946883	2025-07-01 04:24:28.946883
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.950163	2025-07-01 04:24:28.950163
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.954943	2025-07-01 04:24:28.954943
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.958585	2025-07-01 04:24:28.958585
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.962283	2025-07-01 04:24:28.962283
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.965694	2025-07-01 04:24:28.965694
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.968765	2025-07-01 04:24:28.968765
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.971972	2025-07-01 04:24:28.971972
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.975505	2025-07-01 04:24:28.975505
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.979507	2025-07-01 04:24:28.979507
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.983379	2025-07-01 04:24:28.983379
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.987033	2025-07-01 04:24:28.987033
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.99036	2025-07-01 04:24:28.99036
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.993701	2025-07-01 04:24:28.993701
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:28.996976	2025-07-01 04:24:28.996976
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.000863	2025-07-01 04:24:29.000863
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.004682	2025-07-01 04:24:29.004682
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.008346	2025-07-01 04:24:29.008346
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.01202	2025-07-01 04:24:29.01202
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.015026	2025-07-01 04:24:29.015026
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.018036	2025-07-01 04:24:29.018036
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.021125	2025-07-01 04:24:29.021125
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.024093	2025-07-01 04:24:29.024093
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.027525	2025-07-01 04:24:29.027525
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.030956	2025-07-01 04:24:29.030956
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.035645	2025-07-01 04:24:29.035645
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.039427	2025-07-01 04:24:29.039427
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.043009	2025-07-01 04:24:29.043009
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.046413	2025-07-01 04:24:29.046413
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.049628	2025-07-01 04:24:29.049628
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.053033	2025-07-01 04:24:29.053033
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.056855	2025-07-01 04:24:29.056855
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.060506	2025-07-01 04:24:29.060506
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.064276	2025-07-01 04:24:29.064276
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.067777	2025-07-01 04:24:29.067777
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.071029	2025-07-01 04:24:29.071029
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.075697	2025-07-01 04:24:29.075697
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.079561	2025-07-01 04:24:29.079561
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.083156	2025-07-01 04:24:29.083156
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.086941	2025-07-01 04:24:29.086941
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.093874	2025-07-01 04:24:29.093874
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.100912	2025-07-01 04:24:29.100912
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.105537	2025-07-01 04:24:29.105537
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.108532	2025-07-01 04:24:29.108532
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.111428	2025-07-01 04:24:29.111428
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.11666	2025-07-01 04:24:29.11666
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.12184	2025-07-01 04:24:29.12184
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.129259	2025-07-01 04:24:29.129259
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.133418	2025-07-01 04:24:29.133418
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.137066	2025-07-01 04:24:29.137066
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.140572	2025-07-01 04:24:29.140572
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.143902	2025-07-01 04:24:29.143902
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.147021	2025-07-01 04:24:29.147021
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.150139	2025-07-01 04:24:29.150139
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.153978	2025-07-01 04:24:29.153978
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.157849	2025-07-01 04:24:29.157849
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.161172	2025-07-01 04:24:29.161172
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.164645	2025-07-01 04:24:29.164645
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.168361	2025-07-01 04:24:29.168361
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.171655	2025-07-01 04:24:29.171655
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.175523	2025-07-01 04:24:29.175523
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.178977	2025-07-01 04:24:29.178977
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.182216	2025-07-01 04:24:29.182216
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.18532	2025-07-01 04:24:29.18532
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.188433	2025-07-01 04:24:29.188433
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.191596	2025-07-01 04:24:29.191596
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.194486	2025-07-01 04:24:29.194486
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.197583	2025-07-01 04:24:29.197583
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.200685	2025-07-01 04:24:29.200685
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.203879	2025-07-01 04:24:29.203879
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.207097	2025-07-01 04:24:29.207097
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.210375	2025-07-01 04:24:29.210375
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.214902	2025-07-01 04:24:29.214902
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.218492	2025-07-01 04:24:29.218492
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.221475	2025-07-01 04:24:29.221475
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.224449	2025-07-01 04:24:29.224449
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.227424	2025-07-01 04:24:29.227424
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.231945	2025-07-01 04:24:29.231945
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.235849	2025-07-01 04:24:29.235849
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.239437	2025-07-01 04:24:29.239437
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.242986	2025-07-01 04:24:29.242986
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.246209	2025-07-01 04:24:29.246209
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.250609	2025-07-01 04:24:29.250609
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.254883	2025-07-01 04:24:29.254883
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.258433	2025-07-01 04:24:29.258433
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.261831	2025-07-01 04:24:29.261831
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.265049	2025-07-01 04:24:29.265049
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.268062	2025-07-01 04:24:29.268062
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.271301	2025-07-01 04:24:29.271301
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.274577	2025-07-01 04:24:29.274577
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.277751	2025-07-01 04:24:29.277751
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.280895	2025-07-01 04:24:29.280895
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.284491	2025-07-01 04:24:29.284491
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.288456	2025-07-01 04:24:29.288456
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.292388	2025-07-01 04:24:29.292388
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.297224	2025-07-01 04:24:29.297224
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.301015	2025-07-01 04:24:29.301015
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.304667	2025-07-01 04:24:29.304667
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.308383	2025-07-01 04:24:29.308383
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.312236	2025-07-01 04:24:29.312236
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.315608	2025-07-01 04:24:29.315608
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.322116	2025-07-01 04:24:29.322116
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.325635	2025-07-01 04:24:29.325635
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.330712	2025-07-01 04:24:29.330712
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.333949	2025-07-01 04:24:29.333949
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.337478	2025-07-01 04:24:29.337478
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.342075	2025-07-01 04:24:29.342075
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.345838	2025-07-01 04:24:29.345838
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.349084	2025-07-01 04:24:29.349084
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.352155	2025-07-01 04:24:29.352155
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.355251	2025-07-01 04:24:29.355251
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.359589	2025-07-01 04:24:29.359589
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.364647	2025-07-01 04:24:29.364647
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.368808	2025-07-01 04:24:29.368808
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.37358	2025-07-01 04:24:29.37358
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.377377	2025-07-01 04:24:29.377377
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.380852	2025-07-01 04:24:29.380852
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.384282	2025-07-01 04:24:29.384282
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.388107	2025-07-01 04:24:29.388107
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.391992	2025-07-01 04:24:29.391992
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.396886	2025-07-01 04:24:29.396886
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.400472	2025-07-01 04:24:29.400472
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.403931	2025-07-01 04:24:29.403931
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.408031	2025-07-01 04:24:29.408031
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.411725	2025-07-01 04:24:29.411725
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.41847	2025-07-01 04:24:29.41847
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.422246	2025-07-01 04:24:29.422246
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.425356	2025-07-01 04:24:29.425356
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.428627	2025-07-01 04:24:29.428627
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.43197	2025-07-01 04:24:29.43197
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.446674	2025-07-01 04:24:29.446674
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.449964	2025-07-01 04:24:29.449964
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.453208	2025-07-01 04:24:29.453208
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.456509	2025-07-01 04:24:29.456509
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.4596	2025-07-01 04:24:29.4596
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.462843	2025-07-01 04:24:29.462843
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.46618	2025-07-01 04:24:29.46618
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.469425	2025-07-01 04:24:29.469425
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.472517	2025-07-01 04:24:29.472517
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.476202	2025-07-01 04:24:29.476202
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.480199	2025-07-01 04:24:29.480199
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.483885	2025-07-01 04:24:29.483885
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.487288	2025-07-01 04:24:29.487288
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.490811	2025-07-01 04:24:29.490811
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.494706	2025-07-01 04:24:29.494706
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.518412	2025-07-01 04:24:29.518412
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.522404	2025-07-01 04:24:29.522404
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:29.525979	2025-07-01 04:24:29.525979
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.529515	2025-07-01 04:24:29.529515
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.532671	2025-07-01 04:24:29.532671
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.535742	2025-07-01 04:24:29.535742
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.539082	2025-07-01 04:24:29.539082
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.542243	2025-07-01 04:24:29.542243
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.545259	2025-07-01 04:24:29.545259
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.548603	2025-07-01 04:24:29.548603
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.551976	2025-07-01 04:24:29.551976
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.555593	2025-07-01 04:24:29.555593
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.559311	2025-07-01 04:24:29.559311
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.562713	2025-07-01 04:24:29.562713
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.565943	2025-07-01 04:24:29.565943
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.569211	2025-07-01 04:24:29.569211
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.573051	2025-07-01 04:24:29.573051
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.577073	2025-07-01 04:24:29.577073
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.580581	2025-07-01 04:24:29.580581
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.583833	2025-07-01 04:24:29.583833
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.587348	2025-07-01 04:24:29.587348
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.591384	2025-07-01 04:24:29.591384
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.595351	2025-07-01 04:24:29.595351
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.59895	2025-07-01 04:24:29.59895
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.602227	2025-07-01 04:24:29.602227
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.606193	2025-07-01 04:24:29.606193
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.609527	2025-07-01 04:24:29.609527
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.612745	2025-07-01 04:24:29.612745
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.615618	2025-07-01 04:24:29.615618
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.618721	2025-07-01 04:24:29.618721
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.623958	2025-07-01 04:24:29.623958
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.627194	2025-07-01 04:24:29.627194
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.631796	2025-07-01 04:24:29.631796
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.636738	2025-07-01 04:24:29.636738
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.641949	2025-07-01 04:24:29.641949
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.644937	2025-07-01 04:24:29.644937
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.648027	2025-07-01 04:24:29.648027
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.651595	2025-07-01 04:24:29.651595
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.654951	2025-07-01 04:24:29.654951
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.658384	2025-07-01 04:24:29.658384
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.661646	2025-07-01 04:24:29.661646
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.669618	2025-07-01 04:24:29.669618
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.672757	2025-07-01 04:24:29.672757
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.675811	2025-07-01 04:24:29.675811
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.679454	2025-07-01 04:24:29.679454
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.682995	2025-07-01 04:24:29.682995
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.686051	2025-07-01 04:24:29.686051
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.697125	2025-07-01 04:24:29.697125
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.700297	2025-07-01 04:24:29.700297
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.703341	2025-07-01 04:24:29.703341
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.70653	2025-07-01 04:24:29.70653
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.709656	2025-07-01 04:24:29.709656
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.71269	2025-07-01 04:24:29.71269
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.715773	2025-07-01 04:24:29.715773
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.719131	2025-07-01 04:24:29.719131
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.722757	2025-07-01 04:24:29.722757
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.729874	2025-07-01 04:24:29.729874
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.734806	2025-07-01 04:24:29.734806
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.738089	2025-07-01 04:24:29.738089
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.741475	2025-07-01 04:24:29.741475
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.744887	2025-07-01 04:24:29.744887
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.749715	2025-07-01 04:24:29.749715
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.753408	2025-07-01 04:24:29.753408
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.756898	2025-07-01 04:24:29.756898
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.760578	2025-07-01 04:24:29.760578
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.764072	2025-07-01 04:24:29.764072
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.786045	2025-07-01 04:24:29.786045
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.789668	2025-07-01 04:24:29.789668
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.793377	2025-07-01 04:24:29.793377
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.796623	2025-07-01 04:24:29.796623
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.800357	2025-07-01 04:24:29.800357
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.804133	2025-07-01 04:24:29.804133
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.807466	2025-07-01 04:24:29.807466
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.810679	2025-07-01 04:24:29.810679
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.81384	2025-07-01 04:24:29.81384
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.817167	2025-07-01 04:24:29.817167
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.820552	2025-07-01 04:24:29.820552
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.82391	2025-07-01 04:24:29.82391
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.827089	2025-07-01 04:24:29.827089
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.830568	2025-07-01 04:24:29.830568
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.833784	2025-07-01 04:24:29.833784
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.837372	2025-07-01 04:24:29.837372
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.842358	2025-07-01 04:24:29.842358
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.845649	2025-07-01 04:24:29.845649
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.848845	2025-07-01 04:24:29.848845
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.851888	2025-07-01 04:24:29.851888
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.85506	2025-07-01 04:24:29.85506
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.859145	2025-07-01 04:24:29.859145
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.862593	2025-07-01 04:24:29.862593
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.866119	2025-07-01 04:24:29.866119
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.869472	2025-07-01 04:24:29.869472
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.872644	2025-07-01 04:24:29.872644
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.878279	2025-07-01 04:24:29.878279
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.88179	2025-07-01 04:24:29.88179
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.884771	2025-07-01 04:24:29.884771
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.888283	2025-07-01 04:24:29.888283
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.891481	2025-07-01 04:24:29.891481
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.894668	2025-07-01 04:24:29.894668
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.89788	2025-07-01 04:24:29.89788
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.901103	2025-07-01 04:24:29.901103
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.904322	2025-07-01 04:24:29.904322
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.907567	2025-07-01 04:24:29.907567
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.91082	2025-07-01 04:24:29.91082
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.919323	2025-07-01 04:24:29.919323
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.923197	2025-07-01 04:24:29.923197
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.926499	2025-07-01 04:24:29.926499
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.929925	2025-07-01 04:24:29.929925
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.933105	2025-07-01 04:24:29.933105
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.936878	2025-07-01 04:24:29.936878
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.949173	2025-07-01 04:24:29.949173
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.952574	2025-07-01 04:24:29.952574
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.957011	2025-07-01 04:24:29.957011
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.960106	2025-07-01 04:24:29.960106
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.963327	2025-07-01 04:24:29.963327
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.966323	2025-07-01 04:24:29.966323
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.969493	2025-07-01 04:24:29.969493
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.972738	2025-07-01 04:24:29.972738
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.976066	2025-07-01 04:24:29.976066
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.979621	2025-07-01 04:24:29.979621
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.982715	2025-07-01 04:24:29.982715
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.985906	2025-07-01 04:24:29.985906
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.988985	2025-07-01 04:24:29.988985
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.992307	2025-07-01 04:24:29.992307
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.995683	2025-07-01 04:24:29.995683
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:29.998938	2025-07-01 04:24:29.998938
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.002109	2025-07-01 04:24:30.002109
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.005995	2025-07-01 04:24:30.005995
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.009859	2025-07-01 04:24:30.009859
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.013033	2025-07-01 04:24:30.013033
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.017641	2025-07-01 04:24:30.017641
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.021349	2025-07-01 04:24:30.021349
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.024928	2025-07-01 04:24:30.024928
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.028651	2025-07-01 04:24:30.028651
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.033417	2025-07-01 04:24:30.033417
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.037016	2025-07-01 04:24:30.037016
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.040542	2025-07-01 04:24:30.040542
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.043958	2025-07-01 04:24:30.043958
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.048744	2025-07-01 04:24:30.048744
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.051924	2025-07-01 04:24:30.051924
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.055017	2025-07-01 04:24:30.055017
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.05836	2025-07-01 04:24:30.05836
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.061627	2025-07-01 04:24:30.061627
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.064885	2025-07-01 04:24:30.064885
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.068217	2025-07-01 04:24:30.068217
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.071376	2025-07-01 04:24:30.071376
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.07494	2025-07-01 04:24:30.07494
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.078006	2025-07-01 04:24:30.078006
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.081265	2025-07-01 04:24:30.081265
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.084629	2025-07-01 04:24:30.084629
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.087808	2025-07-01 04:24:30.087808
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.091187	2025-07-01 04:24:30.091187
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.0956	2025-07-01 04:24:30.0956
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.099396	2025-07-01 04:24:30.099396
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.102501	2025-07-01 04:24:30.102501
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.105898	2025-07-01 04:24:30.105898
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.10901	2025-07-01 04:24:30.10901
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.113114	2025-07-01 04:24:30.113114
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.116763	2025-07-01 04:24:30.116763
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.120042	2025-07-01 04:24:30.120042
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.123208	2025-07-01 04:24:30.123208
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.126481	2025-07-01 04:24:30.126481
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.129536	2025-07-01 04:24:30.129536
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.132448	2025-07-01 04:24:30.132448
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.135293	2025-07-01 04:24:30.135293
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.13811	2025-07-01 04:24:30.13811
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.140927	2025-07-01 04:24:30.140927
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.143823	2025-07-01 04:24:30.143823
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.146893	2025-07-01 04:24:30.146893
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.149816	2025-07-01 04:24:30.149816
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.15275	2025-07-01 04:24:30.15275
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.156096	2025-07-01 04:24:30.156096
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.159115	2025-07-01 04:24:30.159115
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.162143	2025-07-01 04:24:30.162143
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.165193	2025-07-01 04:24:30.165193
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.169682	2025-07-01 04:24:30.169682
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.174677	2025-07-01 04:24:30.174677
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.178312	2025-07-01 04:24:30.178312
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.212977	2025-07-01 04:24:30.212977
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.216718	2025-07-01 04:24:30.216718
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.220518	2025-07-01 04:24:30.220518
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.224379	2025-07-01 04:24:30.224379
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.228018	2025-07-01 04:24:30.228018
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.233508	2025-07-01 04:24:30.233508
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.236996	2025-07-01 04:24:30.236996
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.240439	2025-07-01 04:24:30.240439
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.24393	2025-07-01 04:24:30.24393
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.247072	2025-07-01 04:24:30.247072
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.250139	2025-07-01 04:24:30.250139
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.253138	2025-07-01 04:24:30.253138
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.256277	2025-07-01 04:24:30.256277
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.259325	2025-07-01 04:24:30.259325
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.262494	2025-07-01 04:24:30.262494
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.265545	2025-07-01 04:24:30.265545
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.268903	2025-07-01 04:24:30.268903
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.272473	2025-07-01 04:24:30.272473
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.275629	2025-07-01 04:24:30.275629
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.278756	2025-07-01 04:24:30.278756
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.282095	2025-07-01 04:24:30.282095
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.285839	2025-07-01 04:24:30.285839
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.295365	2025-07-01 04:24:30.295365
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.299114	2025-07-01 04:24:30.299114
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.302381	2025-07-01 04:24:30.302381
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.305668	2025-07-01 04:24:30.305668
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.309661	2025-07-01 04:24:30.309661
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.344246	2025-07-01 04:24:30.344246
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.347567	2025-07-01 04:24:30.347567
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.350927	2025-07-01 04:24:30.350927
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.353865	2025-07-01 04:24:30.353865
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.357044	2025-07-01 04:24:30.357044
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.360169	2025-07-01 04:24:30.360169
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.363213	2025-07-01 04:24:30.363213
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.366094	2025-07-01 04:24:30.366094
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.369054	2025-07-01 04:24:30.369054
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.372334	2025-07-01 04:24:30.372334
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.375404	2025-07-01 04:24:30.375404
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.378919	2025-07-01 04:24:30.378919
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.382107	2025-07-01 04:24:30.382107
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.385422	2025-07-01 04:24:30.385422
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.388857	2025-07-01 04:24:30.388857
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.423867	2025-07-01 04:24:30.423867
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.427684	2025-07-01 04:24:30.427684
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.431164	2025-07-01 04:24:30.431164
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.434896	2025-07-01 04:24:30.434896
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.438406	2025-07-01 04:24:30.438406
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.441944	2025-07-01 04:24:30.441944
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.476634	2025-07-01 04:24:30.476634
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.480692	2025-07-01 04:24:30.480692
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.484305	2025-07-01 04:24:30.484305
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.487777	2025-07-01 04:24:30.487777
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.491126	2025-07-01 04:24:30.491126
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.494799	2025-07-01 04:24:30.494799
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.498061	2025-07-01 04:24:30.498061
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.501342	2025-07-01 04:24:30.501342
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.504933	2025-07-01 04:24:30.504933
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.508421	2025-07-01 04:24:30.508421
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.525784	2025-07-01 04:24:30.525784
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.52917	2025-07-01 04:24:30.52917
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.532627	2025-07-01 04:24:30.532627
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.535907	2025-07-01 04:24:30.535907
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.539131	2025-07-01 04:24:30.539131
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.543819	2025-07-01 04:24:30.543819
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.547638	2025-07-01 04:24:30.547638
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.552914	2025-07-01 04:24:30.552914
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.556084	2025-07-01 04:24:30.556084
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.559678	2025-07-01 04:24:30.559678
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.563274	2025-07-01 04:24:30.563274
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.597794	2025-07-01 04:24:30.597794
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.601667	2025-07-01 04:24:30.601667
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.60529	2025-07-01 04:24:30.60529
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.608813	2025-07-01 04:24:30.608813
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.611709	2025-07-01 04:24:30.611709
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.61475	2025-07-01 04:24:30.61475
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.617912	2025-07-01 04:24:30.617912
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.620904	2025-07-01 04:24:30.620904
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.624181	2025-07-01 04:24:30.624181
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.627133	2025-07-01 04:24:30.627133
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.630431	2025-07-01 04:24:30.630431
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.634657	2025-07-01 04:24:30.634657
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.643033	2025-07-01 04:24:30.643033
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.698623	2025-07-01 04:24:30.698623
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.702142	2025-07-01 04:24:30.702142
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.705646	2025-07-01 04:24:30.705646
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.74048	2025-07-01 04:24:30.74048
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.744065	2025-07-01 04:24:30.744065
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.748871	2025-07-01 04:24:30.748871
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.753701	2025-07-01 04:24:30.753701
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.758715	2025-07-01 04:24:30.758715
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.762245	2025-07-01 04:24:30.762245
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.767386	2025-07-01 04:24:30.767386
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.771805	2025-07-01 04:24:30.771805
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.77681	2025-07-01 04:24:30.77681
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.780486	2025-07-01 04:24:30.780486
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.783826	2025-07-01 04:24:30.783826
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.786873	2025-07-01 04:24:30.786873
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.789882	2025-07-01 04:24:30.789882
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.794431	2025-07-01 04:24:30.794431
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.799958	2025-07-01 04:24:30.799958
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.802991	2025-07-01 04:24:30.802991
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.806426	2025-07-01 04:24:30.806426
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.80975	2025-07-01 04:24:30.80975
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.813692	2025-07-01 04:24:30.813692
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.817119	2025-07-01 04:24:30.817119
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.820608	2025-07-01 04:24:30.820608
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.823904	2025-07-01 04:24:30.823904
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.846517	2025-07-01 04:24:30.846517
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.850128	2025-07-01 04:24:30.850128
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.85446	2025-07-01 04:24:30.85446
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.858016	2025-07-01 04:24:30.858016
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.861628	2025-07-01 04:24:30.861628
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.864672	2025-07-01 04:24:30.864672
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.867867	2025-07-01 04:24:30.867867
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.87101	2025-07-01 04:24:30.87101
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.873889	2025-07-01 04:24:30.873889
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.877207	2025-07-01 04:24:30.877207
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.880517	2025-07-01 04:24:30.880517
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.885231	2025-07-01 04:24:30.885231
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.88838	2025-07-01 04:24:30.88838
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.891518	2025-07-01 04:24:30.891518
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.894714	2025-07-01 04:24:30.894714
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.898003	2025-07-01 04:24:30.898003
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.901893	2025-07-01 04:24:30.901893
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.905405	2025-07-01 04:24:30.905405
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.908463	2025-07-01 04:24:30.908463
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.912009	2025-07-01 04:24:30.912009
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.915338	2025-07-01 04:24:30.915338
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.918949	2025-07-01 04:24:30.918949
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.922577	2025-07-01 04:24:30.922577
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.925895	2025-07-01 04:24:30.925895
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.928972	2025-07-01 04:24:30.928972
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.932309	2025-07-01 04:24:30.932309
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.940391	2025-07-01 04:24:30.940391
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.94395	2025-07-01 04:24:30.94395
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.947069	2025-07-01 04:24:30.947069
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.950155	2025-07-01 04:24:30.950155
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.953025	2025-07-01 04:24:30.953025
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.955937	2025-07-01 04:24:30.955937
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.959206	2025-07-01 04:24:30.959206
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.962308	2025-07-01 04:24:30.962308
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.965446	2025-07-01 04:24:30.965446
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.968348	2025-07-01 04:24:30.968348
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.971916	2025-07-01 04:24:30.971916
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.974802	2025-07-01 04:24:30.974802
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.979137	2025-07-01 04:24:30.979137
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.982674	2025-07-01 04:24:30.982674
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.985865	2025-07-01 04:24:30.985865
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.990331	2025-07-01 04:24:30.990331
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.994188	2025-07-01 04:24:30.994188
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:30.997772	2025-07-01 04:24:30.997772
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.00118	2025-07-01 04:24:31.00118
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.004684	2025-07-01 04:24:31.004684
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.008393	2025-07-01 04:24:31.008393
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.014091	2025-07-01 04:24:31.014091
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.01771	2025-07-01 04:24:31.01771
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.021496	2025-07-01 04:24:31.021496
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.024712	2025-07-01 04:24:31.024712
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.028347	2025-07-01 04:24:31.028347
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.035693	2025-07-01 04:24:31.035693
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.038685	2025-07-01 04:24:31.038685
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.041606	2025-07-01 04:24:31.041606
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.044695	2025-07-01 04:24:31.044695
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.047935	2025-07-01 04:24:31.047935
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.051101	2025-07-01 04:24:31.051101
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.054127	2025-07-01 04:24:31.054127
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.058759	2025-07-01 04:24:31.058759
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.062513	2025-07-01 04:24:31.062513
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.065875	2025-07-01 04:24:31.065875
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.06907	2025-07-01 04:24:31.06907
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.072113	2025-07-01 04:24:31.072113
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.075609	2025-07-01 04:24:31.075609
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.079315	2025-07-01 04:24:31.079315
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.082905	2025-07-01 04:24:31.082905
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.087385	2025-07-01 04:24:31.087385
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.091052	2025-07-01 04:24:31.091052
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.09445	2025-07-01 04:24:31.09445
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.099184	2025-07-01 04:24:31.099184
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.103113	2025-07-01 04:24:31.103113
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.106461	2025-07-01 04:24:31.106461
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.111212	2025-07-01 04:24:31.111212
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.115043	2025-07-01 04:24:31.115043
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.118199	2025-07-01 04:24:31.118199
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.122173	2025-07-01 04:24:31.122173
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.125359	2025-07-01 04:24:31.125359
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.128723	2025-07-01 04:24:31.128723
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.133062	2025-07-01 04:24:31.133062
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.136205	2025-07-01 04:24:31.136205
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.139404	2025-07-01 04:24:31.139404
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.142818	2025-07-01 04:24:31.142818
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.146368	2025-07-01 04:24:31.146368
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.149332	2025-07-01 04:24:31.149332
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.152184	2025-07-01 04:24:31.152184
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.157862	2025-07-01 04:24:31.157862
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.160954	2025-07-01 04:24:31.160954
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.164104	2025-07-01 04:24:31.164104
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.167841	2025-07-01 04:24:31.167841
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.172203	2025-07-01 04:24:31.172203
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.175258	2025-07-01 04:24:31.175258
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.17833	2025-07-01 04:24:31.17833
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.181522	2025-07-01 04:24:31.181522
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.184914	2025-07-01 04:24:31.184914
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.188794	2025-07-01 04:24:31.188794
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.192287	2025-07-01 04:24:31.192287
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.195216	2025-07-01 04:24:31.195216
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.198338	2025-07-01 04:24:31.198338
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.202735	2025-07-01 04:24:31.202735
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.207794	2025-07-01 04:24:31.207794
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.211377	2025-07-01 04:24:31.211377
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.214804	2025-07-01 04:24:31.214804
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.218011	2025-07-01 04:24:31.218011
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.222415	2025-07-01 04:24:31.222415
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.226063	2025-07-01 04:24:31.226063
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.229129	2025-07-01 04:24:31.229129
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.232113	2025-07-01 04:24:31.232113
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.23512	2025-07-01 04:24:31.23512
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.238208	2025-07-01 04:24:31.238208
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.241287	2025-07-01 04:24:31.241287
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.244713	2025-07-01 04:24:31.244713
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.24808	2025-07-01 04:24:31.24808
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.251152	2025-07-01 04:24:31.251152
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.254418	2025-07-01 04:24:31.254418
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.257347	2025-07-01 04:24:31.257347
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.260697	2025-07-01 04:24:31.260697
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.264083	2025-07-01 04:24:31.264083
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.267862	2025-07-01 04:24:31.267862
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.270889	2025-07-01 04:24:31.270889
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.27391	2025-07-01 04:24:31.27391
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.27697	2025-07-01 04:24:31.27697
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.280209	2025-07-01 04:24:31.280209
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.283488	2025-07-01 04:24:31.283488
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.286441	2025-07-01 04:24:31.286441
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.289609	2025-07-01 04:24:31.289609
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.293191	2025-07-01 04:24:31.293191
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.29645	2025-07-01 04:24:31.29645
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.29966	2025-07-01 04:24:31.29966
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.302818	2025-07-01 04:24:31.302818
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.305995	2025-07-01 04:24:31.305995
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.309399	2025-07-01 04:24:31.309399
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.313242	2025-07-01 04:24:31.313242
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.317877	2025-07-01 04:24:31.317877
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.321376	2025-07-01 04:24:31.321376
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.324509	2025-07-01 04:24:31.324509
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.327838	2025-07-01 04:24:31.327838
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.331255	2025-07-01 04:24:31.331255
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.335308	2025-07-01 04:24:31.335308
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.339162	2025-07-01 04:24:31.339162
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.342394	2025-07-01 04:24:31.342394
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.345716	2025-07-01 04:24:31.345716
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.348923	2025-07-01 04:24:31.348923
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.352162	2025-07-01 04:24:31.352162
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.356607	2025-07-01 04:24:31.356607
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.361843	2025-07-01 04:24:31.361843
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.365478	2025-07-01 04:24:31.365478
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.368752	2025-07-01 04:24:31.368752
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.372499	2025-07-01 04:24:31.372499
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.376862	2025-07-01 04:24:31.376862
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.380381	2025-07-01 04:24:31.380381
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.383799	2025-07-01 04:24:31.383799
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.387296	2025-07-01 04:24:31.387296
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.390391	2025-07-01 04:24:31.390391
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.393531	2025-07-01 04:24:31.393531
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.396651	2025-07-01 04:24:31.396651
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.399878	2025-07-01 04:24:31.399878
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.403333	2025-07-01 04:24:31.403333
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.40662	2025-07-01 04:24:31.40662
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.411265	2025-07-01 04:24:31.411265
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.414953	2025-07-01 04:24:31.414953
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.418059	2025-07-01 04:24:31.418059
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.421186	2025-07-01 04:24:31.421186
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.424185	2025-07-01 04:24:31.424185
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.427466	2025-07-01 04:24:31.427466
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.431153	2025-07-01 04:24:31.431153
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.434838	2025-07-01 04:24:31.434838
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.438541	2025-07-01 04:24:31.438541
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.441777	2025-07-01 04:24:31.441777
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.444919	2025-07-01 04:24:31.444919
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.448326	2025-07-01 04:24:31.448326
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.451907	2025-07-01 04:24:31.451907
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.45572	2025-07-01 04:24:31.45572
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.458763	2025-07-01 04:24:31.458763
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.461735	2025-07-01 04:24:31.461735
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.464921	2025-07-01 04:24:31.464921
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.468187	2025-07-01 04:24:31.468187
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.471324	2025-07-01 04:24:31.471324
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.474451	2025-07-01 04:24:31.474451
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.477595	2025-07-01 04:24:31.477595
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.48081	2025-07-01 04:24:31.48081
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.484168	2025-07-01 04:24:31.484168
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.487601	2025-07-01 04:24:31.487601
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.490852	2025-07-01 04:24:31.490852
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.494177	2025-07-01 04:24:31.494177
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.498575	2025-07-01 04:24:31.498575
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.502194	2025-07-01 04:24:31.502194
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.50537	2025-07-01 04:24:31.50537
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.50896	2025-07-01 04:24:31.50896
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.513532	2025-07-01 04:24:31.513532
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.517469	2025-07-01 04:24:31.517469
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.520997	2025-07-01 04:24:31.520997
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.524272	2025-07-01 04:24:31.524272
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.528838	2025-07-01 04:24:31.528838
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.532033	2025-07-01 04:24:31.532033
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.535152	2025-07-01 04:24:31.535152
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.538364	2025-07-01 04:24:31.538364
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.541485	2025-07-01 04:24:31.541485
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.544604	2025-07-01 04:24:31.544604
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.547523	2025-07-01 04:24:31.547523
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.550735	2025-07-01 04:24:31.550735
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.553883	2025-07-01 04:24:31.553883
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.55816	2025-07-01 04:24:31.55816
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.561754	2025-07-01 04:24:31.561754
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.564958	2025-07-01 04:24:31.564958
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.5685	2025-07-01 04:24:31.5685
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.571625	2025-07-01 04:24:31.571625
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.575149	2025-07-01 04:24:31.575149
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.578682	2025-07-01 04:24:31.578682
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.58347	2025-07-01 04:24:31.58347
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.587949	2025-07-01 04:24:31.587949
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.591375	2025-07-01 04:24:31.591375
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.594686	2025-07-01 04:24:31.594686
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.598627	2025-07-01 04:24:31.598627
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.603452	2025-07-01 04:24:31.603452
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.61438	2025-07-01 04:24:31.61438
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.618154	2025-07-01 04:24:31.618154
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.621972	2025-07-01 04:24:31.621972
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.625064	2025-07-01 04:24:31.625064
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.630295	2025-07-01 04:24:31.630295
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.63325	2025-07-01 04:24:31.63325
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.636299	2025-07-01 04:24:31.636299
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.639255	2025-07-01 04:24:31.639255
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.642305	2025-07-01 04:24:31.642305
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.645047	2025-07-01 04:24:31.645047
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.647772	2025-07-01 04:24:31.647772
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.650623	2025-07-01 04:24:31.650623
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.653332	2025-07-01 04:24:31.653332
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.656371	2025-07-01 04:24:31.656371
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.659365	2025-07-01 04:24:31.659365
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.66431	2025-07-01 04:24:31.66431
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.667598	2025-07-01 04:24:31.667598
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.670995	2025-07-01 04:24:31.670995
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.674469	2025-07-01 04:24:31.674469
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.677968	2025-07-01 04:24:31.677968
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.681281	2025-07-01 04:24:31.681281
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.68504	2025-07-01 04:24:31.68504
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.688515	2025-07-01 04:24:31.688515
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.692164	2025-07-01 04:24:31.692164
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.695083	2025-07-01 04:24:31.695083
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.698854	2025-07-01 04:24:31.698854
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.701937	2025-07-01 04:24:31.701937
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.707102	2025-07-01 04:24:31.707102
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.711742	2025-07-01 04:24:31.711742
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.714617	2025-07-01 04:24:31.714617
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.717809	2025-07-01 04:24:31.717809
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.720904	2025-07-01 04:24:31.720904
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.723944	2025-07-01 04:24:31.723944
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.7272	2025-07-01 04:24:31.7272
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.730459	2025-07-01 04:24:31.730459
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.733604	2025-07-01 04:24:31.733604
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.736735	2025-07-01 04:24:31.736735
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.73973	2025-07-01 04:24:31.73973
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.74268	2025-07-01 04:24:31.74268
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.745848	2025-07-01 04:24:31.745848
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.749232	2025-07-01 04:24:31.749232
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.752442	2025-07-01 04:24:31.752442
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.756263	2025-07-01 04:24:31.756263
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.759695	2025-07-01 04:24:31.759695
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.763588	2025-07-01 04:24:31.763588
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.767416	2025-07-01 04:24:31.767416
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.772396	2025-07-01 04:24:31.772396
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.77564	2025-07-01 04:24:31.77564
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.778936	2025-07-01 04:24:31.778936
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.78207	2025-07-01 04:24:31.78207
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.785174	2025-07-01 04:24:31.785174
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.788367	2025-07-01 04:24:31.788367
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.791669	2025-07-01 04:24:31.791669
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.794886	2025-07-01 04:24:31.794886
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.798067	2025-07-01 04:24:31.798067
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.801154	2025-07-01 04:24:31.801154
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:31.804208	2025-07-01 04:24:31.804208
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.807367	2025-07-01 04:24:31.807367
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.810361	2025-07-01 04:24:31.810361
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.813388	2025-07-01 04:24:31.813388
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.816435	2025-07-01 04:24:31.816435
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.81969	2025-07-01 04:24:31.81969
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.822963	2025-07-01 04:24:31.822963
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.826215	2025-07-01 04:24:31.826215
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.829799	2025-07-01 04:24:31.829799
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.832916	2025-07-01 04:24:31.832916
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.835846	2025-07-01 04:24:31.835846
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.839342	2025-07-01 04:24:31.839342
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.842792	2025-07-01 04:24:31.842792
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.846181	2025-07-01 04:24:31.846181
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.849128	2025-07-01 04:24:31.849128
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.852609	2025-07-01 04:24:31.852609
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.856204	2025-07-01 04:24:31.856204
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.859319	2025-07-01 04:24:31.859319
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.86256	2025-07-01 04:24:31.86256
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.865497	2025-07-01 04:24:31.865497
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.868586	2025-07-01 04:24:31.868586
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.871869	2025-07-01 04:24:31.871869
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.874945	2025-07-01 04:24:31.874945
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.87837	2025-07-01 04:24:31.87837
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.881536	2025-07-01 04:24:31.881536
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.884588	2025-07-01 04:24:31.884588
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.88775	2025-07-01 04:24:31.88775
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.89083	2025-07-01 04:24:31.89083
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.894074	2025-07-01 04:24:31.894074
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.897183	2025-07-01 04:24:31.897183
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.900479	2025-07-01 04:24:31.900479
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.903765	2025-07-01 04:24:31.903765
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.907902	2025-07-01 04:24:31.907902
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.912479	2025-07-01 04:24:31.912479
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.915968	2025-07-01 04:24:31.915968
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.919108	2025-07-01 04:24:31.919108
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.92222	2025-07-01 04:24:31.92222
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.925639	2025-07-01 04:24:31.925639
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.929031	2025-07-01 04:24:31.929031
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.932811	2025-07-01 04:24:31.932811
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.937398	2025-07-01 04:24:31.937398
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.940587	2025-07-01 04:24:31.940587
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.943575	2025-07-01 04:24:31.943575
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.946417	2025-07-01 04:24:31.946417
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.949529	2025-07-01 04:24:31.949529
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.952608	2025-07-01 04:24:31.952608
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.955566	2025-07-01 04:24:31.955566
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.958455	2025-07-01 04:24:31.958455
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.961317	2025-07-01 04:24:31.961317
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.96457	2025-07-01 04:24:31.96457
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.967993	2025-07-01 04:24:31.967993
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.971369	2025-07-01 04:24:31.971369
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.974518	2025-07-01 04:24:31.974518
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.977883	2025-07-01 04:24:31.977883
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.981056	2025-07-01 04:24:31.981056
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.984587	2025-07-01 04:24:31.984587
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.987666	2025-07-01 04:24:31.987666
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.990649	2025-07-01 04:24:31.990649
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.993934	2025-07-01 04:24:31.993934
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:31.997842	2025-07-01 04:24:31.997842
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.00212	2025-07-01 04:24:32.00212
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.006478	2025-07-01 04:24:32.006478
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.010732	2025-07-01 04:24:32.010732
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.015	2025-07-01 04:24:32.015
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.01818	2025-07-01 04:24:32.01818
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.021136	2025-07-01 04:24:32.021136
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.024068	2025-07-01 04:24:32.024068
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.026887	2025-07-01 04:24:32.026887
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.029944	2025-07-01 04:24:32.029944
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.033277	2025-07-01 04:24:32.033277
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.036565	2025-07-01 04:24:32.036565
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.039685	2025-07-01 04:24:32.039685
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.042828	2025-07-01 04:24:32.042828
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.045864	2025-07-01 04:24:32.045864
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.049656	2025-07-01 04:24:32.049656
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.053492	2025-07-01 04:24:32.053492
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.056844	2025-07-01 04:24:32.056844
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.060332	2025-07-01 04:24:32.060332
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.063547	2025-07-01 04:24:32.063547
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.067098	2025-07-01 04:24:32.067098
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.070457	2025-07-01 04:24:32.070457
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.074001	2025-07-01 04:24:32.074001
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.076849	2025-07-01 04:24:32.076849
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.079814	2025-07-01 04:24:32.079814
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.08267	2025-07-01 04:24:32.08267
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.085735	2025-07-01 04:24:32.085735
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.088779	2025-07-01 04:24:32.088779
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.09202	2025-07-01 04:24:32.09202
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.095207	2025-07-01 04:24:32.095207
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.098285	2025-07-01 04:24:32.098285
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.10125	2025-07-01 04:24:32.10125
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.104452	2025-07-01 04:24:32.104452
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.10747	2025-07-01 04:24:32.10747
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.11075	2025-07-01 04:24:32.11075
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.113885	2025-07-01 04:24:32.113885
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.116976	2025-07-01 04:24:32.116976
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.120874	2025-07-01 04:24:32.120874
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.12418	2025-07-01 04:24:32.12418
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.127512	2025-07-01 04:24:32.127512
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.130663	2025-07-01 04:24:32.130663
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.133797	2025-07-01 04:24:32.133797
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.137397	2025-07-01 04:24:32.137397
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.140563	2025-07-01 04:24:32.140563
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.144443	2025-07-01 04:24:32.144443
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.148516	2025-07-01 04:24:32.148516
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.152498	2025-07-01 04:24:32.152498
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.156478	2025-07-01 04:24:32.156478
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.160233	2025-07-01 04:24:32.160233
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.163748	2025-07-01 04:24:32.163748
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.168094	2025-07-01 04:24:32.168094
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.171849	2025-07-01 04:24:32.171849
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.175717	2025-07-01 04:24:32.175717
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.179421	2025-07-01 04:24:32.179421
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.182881	2025-07-01 04:24:32.182881
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.18612	2025-07-01 04:24:32.18612
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.189385	2025-07-01 04:24:32.189385
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.192998	2025-07-01 04:24:32.192998
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.196525	2025-07-01 04:24:32.196525
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.202217	2025-07-01 04:24:32.202217
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.205754	2025-07-01 04:24:32.205754
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.208982	2025-07-01 04:24:32.208982
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.212281	2025-07-01 04:24:32.212281
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.215601	2025-07-01 04:24:32.215601
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.219198	2025-07-01 04:24:32.219198
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.222946	2025-07-01 04:24:32.222946
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.2275	2025-07-01 04:24:32.2275
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.230906	2025-07-01 04:24:32.230906
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.234238	2025-07-01 04:24:32.234238
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.239191	2025-07-01 04:24:32.239191
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.2443	2025-07-01 04:24:32.2443
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.249508	2025-07-01 04:24:32.249508
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.25363	2025-07-01 04:24:32.25363
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.25748	2025-07-01 04:24:32.25748
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.26233	2025-07-01 04:24:32.26233
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.265751	2025-07-01 04:24:32.265751
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.269328	2025-07-01 04:24:32.269328
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.273082	2025-07-01 04:24:32.273082
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.276773	2025-07-01 04:24:32.276773
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.281247	2025-07-01 04:24:32.281247
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.28508	2025-07-01 04:24:32.28508
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.28865	2025-07-01 04:24:32.28865
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.292064	2025-07-01 04:24:32.292064
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.295676	2025-07-01 04:24:32.295676
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.300352	2025-07-01 04:24:32.300352
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.305615	2025-07-01 04:24:32.305615
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.309738	2025-07-01 04:24:32.309738
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.313246	2025-07-01 04:24:32.313246
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.316928	2025-07-01 04:24:32.316928
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.321071	2025-07-01 04:24:32.321071
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.32511	2025-07-01 04:24:32.32511
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.330155	2025-07-01 04:24:32.330155
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.334963	2025-07-01 04:24:32.334963
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.339069	2025-07-01 04:24:32.339069
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.34315	2025-07-01 04:24:32.34315
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.347071	2025-07-01 04:24:32.347071
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.353097	2025-07-01 04:24:32.353097
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.357041	2025-07-01 04:24:32.357041
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.360409	2025-07-01 04:24:32.360409
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.366811	2025-07-01 04:24:32.366811
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.373086	2025-07-01 04:24:32.373086
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.385465	2025-07-01 04:24:32.385465
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.39502	2025-07-01 04:24:32.39502
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.401757	2025-07-01 04:24:32.401757
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.405372	2025-07-01 04:24:32.405372
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.408979	2025-07-01 04:24:32.408979
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.41254	2025-07-01 04:24:32.41254
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.416013	2025-07-01 04:24:32.416013
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.419292	2025-07-01 04:24:32.419292
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.422718	2025-07-01 04:24:32.422718
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.426607	2025-07-01 04:24:32.426607
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.4302	2025-07-01 04:24:32.4302
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.43475	2025-07-01 04:24:32.43475
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.438697	2025-07-01 04:24:32.438697
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.442421	2025-07-01 04:24:32.442421
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.446223	2025-07-01 04:24:32.446223
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.449876	2025-07-01 04:24:32.449876
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.453394	2025-07-01 04:24:32.453394
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.45688	2025-07-01 04:24:32.45688
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.460517	2025-07-01 04:24:32.460517
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.464034	2025-07-01 04:24:32.464034
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.467942	2025-07-01 04:24:32.467942
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.471888	2025-07-01 04:24:32.471888
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.475594	2025-07-01 04:24:32.475594
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.478993	2025-07-01 04:24:32.478993
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.484522	2025-07-01 04:24:32.484522
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.488249	2025-07-01 04:24:32.488249
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.491722	2025-07-01 04:24:32.491722
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.495143	2025-07-01 04:24:32.495143
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.498482	2025-07-01 04:24:32.498482
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.501808	2025-07-01 04:24:32.501808
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.505148	2025-07-01 04:24:32.505148
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.508387	2025-07-01 04:24:32.508387
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.511804	2025-07-01 04:24:32.511804
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.515541	2025-07-01 04:24:32.515541
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.518932	2025-07-01 04:24:32.518932
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.522506	2025-07-01 04:24:32.522506
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.525957	2025-07-01 04:24:32.525957
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.529423	2025-07-01 04:24:32.529423
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.532731	2025-07-01 04:24:32.532731
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.536294	2025-07-01 04:24:32.536294
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.539612	2025-07-01 04:24:32.539612
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.542863	2025-07-01 04:24:32.542863
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.546319	2025-07-01 04:24:32.546319
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.549804	2025-07-01 04:24:32.549804
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.552991	2025-07-01 04:24:32.552991
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.556488	2025-07-01 04:24:32.556488
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.562177	2025-07-01 04:24:32.562177
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.565377	2025-07-01 04:24:32.565377
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.568697	2025-07-01 04:24:32.568697
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.571824	2025-07-01 04:24:32.571824
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.575055	2025-07-01 04:24:32.575055
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.578075	2025-07-01 04:24:32.578075
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.581264	2025-07-01 04:24:32.581264
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.584527	2025-07-01 04:24:32.584527
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.587739	2025-07-01 04:24:32.587739
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.590859	2025-07-01 04:24:32.590859
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.594006	2025-07-01 04:24:32.594006
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.597484	2025-07-01 04:24:32.597484
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.600809	2025-07-01 04:24:32.600809
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.604237	2025-07-01 04:24:32.604237
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.607632	2025-07-01 04:24:32.607632
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.610863	2025-07-01 04:24:32.610863
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.614261	2025-07-01 04:24:32.614261
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.617719	2025-07-01 04:24:32.617719
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.621676	2025-07-01 04:24:32.621676
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.628821	2025-07-01 04:24:32.628821
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.634031	2025-07-01 04:24:32.634031
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.639265	2025-07-01 04:24:32.639265
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.642491	2025-07-01 04:24:32.642491
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.645851	2025-07-01 04:24:32.645851
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.649315	2025-07-01 04:24:32.649315
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.652587	2025-07-01 04:24:32.652587
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.655795	2025-07-01 04:24:32.655795
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.659106	2025-07-01 04:24:32.659106
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.662307	2025-07-01 04:24:32.662307
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.665512	2025-07-01 04:24:32.665512
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.668843	2025-07-01 04:24:32.668843
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.671975	2025-07-01 04:24:32.671975
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.675111	2025-07-01 04:24:32.675111
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.678123	2025-07-01 04:24:32.678123
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.681369	2025-07-01 04:24:32.681369
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.685123	2025-07-01 04:24:32.685123
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.688488	2025-07-01 04:24:32.688488
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.693837	2025-07-01 04:24:32.693837
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.698326	2025-07-01 04:24:32.698326
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.701745	2025-07-01 04:24:32.701745
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.705139	2025-07-01 04:24:32.705139
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.708706	2025-07-01 04:24:32.708706
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.713054	2025-07-01 04:24:32.713054
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.71629	2025-07-01 04:24:32.71629
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.719713	2025-07-01 04:24:32.719713
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.722929	2025-07-01 04:24:32.722929
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.726139	2025-07-01 04:24:32.726139
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.729621	2025-07-01 04:24:32.729621
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.732733	2025-07-01 04:24:32.732733
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.73581	2025-07-01 04:24:32.73581
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.738941	2025-07-01 04:24:32.738941
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.741962	2025-07-01 04:24:32.741962
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.744915	2025-07-01 04:24:32.744915
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.74815	2025-07-01 04:24:32.74815
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.751597	2025-07-01 04:24:32.751597
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.754745	2025-07-01 04:24:32.754745
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.75789	2025-07-01 04:24:32.75789
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.761131	2025-07-01 04:24:32.761131
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.764843	2025-07-01 04:24:32.764843
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.768831	2025-07-01 04:24:32.768831
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.772258	2025-07-01 04:24:32.772258
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.775461	2025-07-01 04:24:32.775461
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.778721	2025-07-01 04:24:32.778721
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.782411	2025-07-01 04:24:32.782411
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.786037	2025-07-01 04:24:32.786037
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.789423	2025-07-01 04:24:32.789423
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.792813	2025-07-01 04:24:32.792813
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.796128	2025-07-01 04:24:32.796128
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.799481	2025-07-01 04:24:32.799481
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.803204	2025-07-01 04:24:32.803204
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.806702	2025-07-01 04:24:32.806702
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.810128	2025-07-01 04:24:32.810128
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.813919	2025-07-01 04:24:32.813919
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.817428	2025-07-01 04:24:32.817428
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.820779	2025-07-01 04:24:32.820779
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.824076	2025-07-01 04:24:32.824076
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.827266	2025-07-01 04:24:32.827266
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.830885	2025-07-01 04:24:32.830885
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.834794	2025-07-01 04:24:32.834794
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.838297	2025-07-01 04:24:32.838297
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.841633	2025-07-01 04:24:32.841633
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.845157	2025-07-01 04:24:32.845157
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.86195	2025-07-01 04:24:32.86195
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.865545	2025-07-01 04:24:32.865545
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.868928	2025-07-01 04:24:32.868928
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.8724	2025-07-01 04:24:32.8724
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.87579	2025-07-01 04:24:32.87579
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.878813	2025-07-01 04:24:32.878813
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.88412	2025-07-01 04:24:32.88412
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.88746	2025-07-01 04:24:32.88746
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.890729	2025-07-01 04:24:32.890729
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.893955	2025-07-01 04:24:32.893955
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.896912	2025-07-01 04:24:32.896912
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.931152	2025-07-01 04:24:32.931152
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.934405	2025-07-01 04:24:32.934405
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.938131	2025-07-01 04:24:32.938131
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.941817	2025-07-01 04:24:32.941817
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.94577	2025-07-01 04:24:32.94577
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.961735	2025-07-01 04:24:32.961735
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.965738	2025-07-01 04:24:32.965738
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.969565	2025-07-01 04:24:32.969565
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.973448	2025-07-01 04:24:32.973448
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.976608	2025-07-01 04:24:32.976608
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.979728	2025-07-01 04:24:32.979728
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.988405	2025-07-01 04:24:32.988405
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.991923	2025-07-01 04:24:32.991923
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.995384	2025-07-01 04:24:32.995384
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:32.998711	2025-07-01 04:24:32.998711
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.002261	2025-07-01 04:24:33.002261
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.007033	2025-07-01 04:24:33.007033
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.010737	2025-07-01 04:24:33.010737
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.014305	2025-07-01 04:24:33.014305
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.01773	2025-07-01 04:24:33.01773
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.020903	2025-07-01 04:24:33.020903
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.024253	2025-07-01 04:24:33.024253
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.028957	2025-07-01 04:24:33.028957
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.032144	2025-07-01 04:24:33.032144
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.035424	2025-07-01 04:24:33.035424
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.039962	2025-07-01 04:24:33.039962
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.044807	2025-07-01 04:24:33.044807
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.048474	2025-07-01 04:24:33.048474
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.051781	2025-07-01 04:24:33.051781
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.054881	2025-07-01 04:24:33.054881
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.057807	2025-07-01 04:24:33.057807
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.062072	2025-07-01 04:24:33.062072
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.065792	2025-07-01 04:24:33.065792
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.069271	2025-07-01 04:24:33.069271
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.073305	2025-07-01 04:24:33.073305
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.076309	2025-07-01 04:24:33.076309
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.079417	2025-07-01 04:24:33.079417
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.08228	2025-07-01 04:24:33.08228
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.085236	2025-07-01 04:24:33.085236
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.088071	2025-07-01 04:24:33.088071
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.091091	2025-07-01 04:24:33.091091
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.094371	2025-07-01 04:24:33.094371
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.09719	2025-07-01 04:24:33.09719
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.100377	2025-07-01 04:24:33.100377
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.103544	2025-07-01 04:24:33.103544
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.106731	2025-07-01 04:24:33.106731
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.109734	2025-07-01 04:24:33.109734
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.11876	2025-07-01 04:24:33.11876
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.122217	2025-07-01 04:24:33.122217
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.125428	2025-07-01 04:24:33.125428
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.12879	2025-07-01 04:24:33.12879
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.132143	2025-07-01 04:24:33.132143
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.135474	2025-07-01 04:24:33.135474
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.161872	2025-07-01 04:24:33.161872
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.166316	2025-07-01 04:24:33.166316
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.169947	2025-07-01 04:24:33.169947
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.173497	2025-07-01 04:24:33.173497
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.177726	2025-07-01 04:24:33.177726
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.181022	2025-07-01 04:24:33.181022
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.184263	2025-07-01 04:24:33.184263
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.187503	2025-07-01 04:24:33.187503
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.190604	2025-07-01 04:24:33.190604
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.229608	2025-07-01 04:24:33.229608
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.233193	2025-07-01 04:24:33.233193
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.264428	2025-07-01 04:24:33.264428
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.269633	2025-07-01 04:24:33.269633
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.273339	2025-07-01 04:24:33.273339
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.27721	2025-07-01 04:24:33.27721
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.28081	2025-07-01 04:24:33.28081
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.284589	2025-07-01 04:24:33.284589
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.319355	2025-07-01 04:24:33.319355
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.323117	2025-07-01 04:24:33.323117
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.326831	2025-07-01 04:24:33.326831
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.330655	2025-07-01 04:24:33.330655
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.336632	2025-07-01 04:24:33.336632
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.339714	2025-07-01 04:24:33.339714
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.374455	2025-07-01 04:24:33.374455
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.379754	2025-07-01 04:24:33.379754
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.38564	2025-07-01 04:24:33.38564
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.420318	2025-07-01 04:24:33.420318
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.424365	2025-07-01 04:24:33.424365
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.427502	2025-07-01 04:24:33.427502
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.43098	2025-07-01 04:24:33.43098
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.434802	2025-07-01 04:24:33.434802
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.438107	2025-07-01 04:24:33.438107
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.441619	2025-07-01 04:24:33.441619
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.444917	2025-07-01 04:24:33.444917
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.468305	2025-07-01 04:24:33.468305
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.472076	2025-07-01 04:24:33.472076
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.475395	2025-07-01 04:24:33.475395
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.478857	2025-07-01 04:24:33.478857
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.482233	2025-07-01 04:24:33.482233
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.485875	2025-07-01 04:24:33.485875
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.489238	2025-07-01 04:24:33.489238
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.524437	2025-07-01 04:24:33.524437
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.528941	2025-07-01 04:24:33.528941
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.532478	2025-07-01 04:24:33.532478
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.535859	2025-07-01 04:24:33.535859
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.539617	2025-07-01 04:24:33.539617
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.543509	2025-07-01 04:24:33.543509
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.578316	2025-07-01 04:24:33.578316
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:33.581924	2025-07-01 04:24:33.581924
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.585565	2025-07-01 04:24:33.585565
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.589627	2025-07-01 04:24:33.589627
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.592593	2025-07-01 04:24:33.592593
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.596846	2025-07-01 04:24:33.596846
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.600136	2025-07-01 04:24:33.600136
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.603021	2025-07-01 04:24:33.603021
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.606211	2025-07-01 04:24:33.606211
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.640509	2025-07-01 04:24:33.640509
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.647956	2025-07-01 04:24:33.647956
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.651589	2025-07-01 04:24:33.651589
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.655033	2025-07-01 04:24:33.655033
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.658441	2025-07-01 04:24:33.658441
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.662155	2025-07-01 04:24:33.662155
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.665474	2025-07-01 04:24:33.665474
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.686786	2025-07-01 04:24:33.686786
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.692485	2025-07-01 04:24:33.692485
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.697071	2025-07-01 04:24:33.697071
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.700414	2025-07-01 04:24:33.700414
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.703894	2025-07-01 04:24:33.703894
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.723183	2025-07-01 04:24:33.723183
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.726657	2025-07-01 04:24:33.726657
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.730147	2025-07-01 04:24:33.730147
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.733561	2025-07-01 04:24:33.733561
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.737096	2025-07-01 04:24:33.737096
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.771769	2025-07-01 04:24:33.771769
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.775635	2025-07-01 04:24:33.775635
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.779231	2025-07-01 04:24:33.779231
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.782665	2025-07-01 04:24:33.782665
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.786017	2025-07-01 04:24:33.786017
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.820506	2025-07-01 04:24:33.820506
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.824367	2025-07-01 04:24:33.824367
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.827967	2025-07-01 04:24:33.827967
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.831766	2025-07-01 04:24:33.831766
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.835687	2025-07-01 04:24:33.835687
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.839629	2025-07-01 04:24:33.839629
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.847531	2025-07-01 04:24:33.847531
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.852442	2025-07-01 04:24:33.852442
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.857287	2025-07-01 04:24:33.857287
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.860979	2025-07-01 04:24:33.860979
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.864039	2025-07-01 04:24:33.864039
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.868395	2025-07-01 04:24:33.868395
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.871776	2025-07-01 04:24:33.871776
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.876174	2025-07-01 04:24:33.876174
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.87983	2025-07-01 04:24:33.87983
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.883493	2025-07-01 04:24:33.883493
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.88687	2025-07-01 04:24:33.88687
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.890159	2025-07-01 04:24:33.890159
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.896264	2025-07-01 04:24:33.896264
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.899505	2025-07-01 04:24:33.899505
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.903775	2025-07-01 04:24:33.903775
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.907207	2025-07-01 04:24:33.907207
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.910304	2025-07-01 04:24:33.910304
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.914721	2025-07-01 04:24:33.914721
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.919364	2025-07-01 04:24:33.919364
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.922766	2025-07-01 04:24:33.922766
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.925983	2025-07-01 04:24:33.925983
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.928833	2025-07-01 04:24:33.928833
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.932073	2025-07-01 04:24:33.932073
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.936628	2025-07-01 04:24:33.936628
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.940571	2025-07-01 04:24:33.940571
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.943691	2025-07-01 04:24:33.943691
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.946724	2025-07-01 04:24:33.946724
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.949792	2025-07-01 04:24:33.949792
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.95435	2025-07-01 04:24:33.95435
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.959073	2025-07-01 04:24:33.959073
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.962481	2025-07-01 04:24:33.962481
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.965672	2025-07-01 04:24:33.965672
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.969636	2025-07-01 04:24:33.969636
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.978562	2025-07-01 04:24:33.978562
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.981996	2025-07-01 04:24:33.981996
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.985236	2025-07-01 04:24:33.985236
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.988515	2025-07-01 04:24:33.988515
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.991353	2025-07-01 04:24:33.991353
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.99429	2025-07-01 04:24:33.99429
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:33.9977	2025-07-01 04:24:33.9977
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.001106	2025-07-01 04:24:34.001106
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.004352	2025-07-01 04:24:34.004352
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.007227	2025-07-01 04:24:34.007227
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.010248	2025-07-01 04:24:34.010248
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.013731	2025-07-01 04:24:34.013731
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.017298	2025-07-01 04:24:34.017298
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.020698	2025-07-01 04:24:34.020698
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.023746	2025-07-01 04:24:34.023746
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.026589	2025-07-01 04:24:34.026589
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.030134	2025-07-01 04:24:34.030134
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.033707	2025-07-01 04:24:34.033707
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.037093	2025-07-01 04:24:34.037093
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.040239	2025-07-01 04:24:34.040239
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.044624	2025-07-01 04:24:34.044624
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.048501	2025-07-01 04:24:34.048501
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.052277	2025-07-01 04:24:34.052277
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.055406	2025-07-01 04:24:34.055406
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.05846	2025-07-01 04:24:34.05846
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.061953	2025-07-01 04:24:34.061953
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.065611	2025-07-01 04:24:34.065611
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.068647	2025-07-01 04:24:34.068647
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.071445	2025-07-01 04:24:34.071445
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.074367	2025-07-01 04:24:34.074367
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.077333	2025-07-01 04:24:34.077333
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.080419	2025-07-01 04:24:34.080419
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.083763	2025-07-01 04:24:34.083763
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.08717	2025-07-01 04:24:34.08717
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.090567	2025-07-01 04:24:34.090567
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.093483	2025-07-01 04:24:34.093483
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.096721	2025-07-01 04:24:34.096721
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.100163	2025-07-01 04:24:34.100163
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.103794	2025-07-01 04:24:34.103794
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.107161	2025-07-01 04:24:34.107161
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.110292	2025-07-01 04:24:34.110292
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.113611	2025-07-01 04:24:34.113611
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.116968	2025-07-01 04:24:34.116968
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.120593	2025-07-01 04:24:34.120593
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.123689	2025-07-01 04:24:34.123689
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.127178	2025-07-01 04:24:34.127178
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.130263	2025-07-01 04:24:34.130263
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.133694	2025-07-01 04:24:34.133694
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.137337	2025-07-01 04:24:34.137337
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.140618	2025-07-01 04:24:34.140618
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.14352	2025-07-01 04:24:34.14352
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.146872	2025-07-01 04:24:34.146872
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.149957	2025-07-01 04:24:34.149957
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.153128	2025-07-01 04:24:34.153128
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.15644	2025-07-01 04:24:34.15644
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.159308	2025-07-01 04:24:34.159308
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.162521	2025-07-01 04:24:34.162521
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.165817	2025-07-01 04:24:34.165817
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.168878	2025-07-01 04:24:34.168878
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.171691	2025-07-01 04:24:34.171691
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.175688	2025-07-01 04:24:34.175688
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.179105	2025-07-01 04:24:34.179105
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.182049	2025-07-01 04:24:34.182049
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.185332	2025-07-01 04:24:34.185332
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.188495	2025-07-01 04:24:34.188495
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.191725	2025-07-01 04:24:34.191725
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.194695	2025-07-01 04:24:34.194695
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.198856	2025-07-01 04:24:34.198856
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.202503	2025-07-01 04:24:34.202503
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.20593	2025-07-01 04:24:34.20593
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.209322	2025-07-01 04:24:34.209322
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.213924	2025-07-01 04:24:34.213924
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.21745	2025-07-01 04:24:34.21745
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.220821	2025-07-01 04:24:34.220821
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.224921	2025-07-01 04:24:34.224921
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.228076	2025-07-01 04:24:34.228076
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.231092	2025-07-01 04:24:34.231092
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.234068	2025-07-01 04:24:34.234068
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.238443	2025-07-01 04:24:34.238443
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.241895	2025-07-01 04:24:34.241895
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.246048	2025-07-01 04:24:34.246048
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.249442	2025-07-01 04:24:34.249442
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.252761	2025-07-01 04:24:34.252761
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.257094	2025-07-01 04:24:34.257094
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.260375	2025-07-01 04:24:34.260375
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.263229	2025-07-01 04:24:34.263229
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.267562	2025-07-01 04:24:34.267562
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.270893	2025-07-01 04:24:34.270893
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.273656	2025-07-01 04:24:34.273656
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.276659	2025-07-01 04:24:34.276659
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.279863	2025-07-01 04:24:34.279863
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.28414	2025-07-01 04:24:34.28414
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.287755	2025-07-01 04:24:34.287755
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.290573	2025-07-01 04:24:34.290573
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.294787	2025-07-01 04:24:34.294787
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.298197	2025-07-01 04:24:34.298197
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.301916	2025-07-01 04:24:34.301916
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.3051	2025-07-01 04:24:34.3051
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.308178	2025-07-01 04:24:34.308178
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.312344	2025-07-01 04:24:34.312344
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.315918	2025-07-01 04:24:34.315918
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.319632	2025-07-01 04:24:34.319632
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.322774	2025-07-01 04:24:34.322774
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.325645	2025-07-01 04:24:34.325645
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.339173	2025-07-01 04:24:34.339173
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.342836	2025-07-01 04:24:34.342836
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.345744	2025-07-01 04:24:34.345744
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.348729	2025-07-01 04:24:34.348729
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.352	2025-07-01 04:24:34.352
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.355199	2025-07-01 04:24:34.355199
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.359567	2025-07-01 04:24:34.359567
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.364104	2025-07-01 04:24:34.364104
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.367573	2025-07-01 04:24:34.367573
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.370659	2025-07-01 04:24:34.370659
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.37371	2025-07-01 04:24:34.37371
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.376889	2025-07-01 04:24:34.376889
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.37999	2025-07-01 04:24:34.37999
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.383062	2025-07-01 04:24:34.383062
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.385811	2025-07-01 04:24:34.385811
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.388855	2025-07-01 04:24:34.388855
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.391568	2025-07-01 04:24:34.391568
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.394714	2025-07-01 04:24:34.394714
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.398111	2025-07-01 04:24:34.398111
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.401304	2025-07-01 04:24:34.401304
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.404573	2025-07-01 04:24:34.404573
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.40879	2025-07-01 04:24:34.40879
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.412091	2025-07-01 04:24:34.412091
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.41522	2025-07-01 04:24:34.41522
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.418665	2025-07-01 04:24:34.418665
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.421817	2025-07-01 04:24:34.421817
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.425013	2025-07-01 04:24:34.425013
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.428418	2025-07-01 04:24:34.428418
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.431575	2025-07-01 04:24:34.431575
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.434953	2025-07-01 04:24:34.434953
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.438249	2025-07-01 04:24:34.438249
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.441398	2025-07-01 04:24:34.441398
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.44466	2025-07-01 04:24:34.44466
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.448174	2025-07-01 04:24:34.448174
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.451361	2025-07-01 04:24:34.451361
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.454558	2025-07-01 04:24:34.454558
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.458008	2025-07-01 04:24:34.458008
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.461973	2025-07-01 04:24:34.461973
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.465033	2025-07-01 04:24:34.465033
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.468102	2025-07-01 04:24:34.468102
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.47144	2025-07-01 04:24:34.47144
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.474554	2025-07-01 04:24:34.474554
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.478167	2025-07-01 04:24:34.478167
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.481011	2025-07-01 04:24:34.481011
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.484027	2025-07-01 04:24:34.484027
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.487568	2025-07-01 04:24:34.487568
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.490691	2025-07-01 04:24:34.490691
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.493665	2025-07-01 04:24:34.493665
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.497168	2025-07-01 04:24:34.497168
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.500367	2025-07-01 04:24:34.500367
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.503735	2025-07-01 04:24:34.503735
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.506979	2025-07-01 04:24:34.506979
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.510415	2025-07-01 04:24:34.510415
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.52381	2025-07-01 04:24:34.52381
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.527355	2025-07-01 04:24:34.527355
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.53068	2025-07-01 04:24:34.53068
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.534093	2025-07-01 04:24:34.534093
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.53804	2025-07-01 04:24:34.53804
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.541289	2025-07-01 04:24:34.541289
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.551433	2025-07-01 04:24:34.551433
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.556548	2025-07-01 04:24:34.556548
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.559969	2025-07-01 04:24:34.559969
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.563409	2025-07-01 04:24:34.563409
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.567961	2025-07-01 04:24:34.567961
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.570895	2025-07-01 04:24:34.570895
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.5738	2025-07-01 04:24:34.5738
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.576812	2025-07-01 04:24:34.576812
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.579705	2025-07-01 04:24:34.579705
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.582382	2025-07-01 04:24:34.582382
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.585315	2025-07-01 04:24:34.585315
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.588356	2025-07-01 04:24:34.588356
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.591827	2025-07-01 04:24:34.591827
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.596907	2025-07-01 04:24:34.596907
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.602896	2025-07-01 04:24:34.602896
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.607693	2025-07-01 04:24:34.607693
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.611131	2025-07-01 04:24:34.611131
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.614683	2025-07-01 04:24:34.614683
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.617988	2025-07-01 04:24:34.617988
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.621388	2025-07-01 04:24:34.621388
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.62545	2025-07-01 04:24:34.62545
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.628658	2025-07-01 04:24:34.628658
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.631833	2025-07-01 04:24:34.631833
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.634516	2025-07-01 04:24:34.634516
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.637516	2025-07-01 04:24:34.637516
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.640375	2025-07-01 04:24:34.640375
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.643736	2025-07-01 04:24:34.643736
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.647152	2025-07-01 04:24:34.647152
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.650178	2025-07-01 04:24:34.650178
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.652945	2025-07-01 04:24:34.652945
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.65557	2025-07-01 04:24:34.65557
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.658637	2025-07-01 04:24:34.658637
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.661805	2025-07-01 04:24:34.661805
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.664859	2025-07-01 04:24:34.664859
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.668535	2025-07-01 04:24:34.668535
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.671513	2025-07-01 04:24:34.671513
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.67457	2025-07-01 04:24:34.67457
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.677483	2025-07-01 04:24:34.677483
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.68058	2025-07-01 04:24:34.68058
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.683954	2025-07-01 04:24:34.683954
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.687377	2025-07-01 04:24:34.687377
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.690626	2025-07-01 04:24:34.690626
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.694291	2025-07-01 04:24:34.694291
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.697664	2025-07-01 04:24:34.697664
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.70134	2025-07-01 04:24:34.70134
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.704379	2025-07-01 04:24:34.704379
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.707334	2025-07-01 04:24:34.707334
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.710391	2025-07-01 04:24:34.710391
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.714155	2025-07-01 04:24:34.714155
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.717335	2025-07-01 04:24:34.717335
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.720157	2025-07-01 04:24:34.720157
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.722891	2025-07-01 04:24:34.722891
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.726358	2025-07-01 04:24:34.726358
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.730032	2025-07-01 04:24:34.730032
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.733299	2025-07-01 04:24:34.733299
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.736728	2025-07-01 04:24:34.736728
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.740069	2025-07-01 04:24:34.740069
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.743411	2025-07-01 04:24:34.743411
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.746724	2025-07-01 04:24:34.746724
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.750387	2025-07-01 04:24:34.750387
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.754383	2025-07-01 04:24:34.754383
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.758151	2025-07-01 04:24:34.758151
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.761571	2025-07-01 04:24:34.761571
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.765251	2025-07-01 04:24:34.765251
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.768788	2025-07-01 04:24:34.768788
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.771966	2025-07-01 04:24:34.771966
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.775137	2025-07-01 04:24:34.775137
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.778042	2025-07-01 04:24:34.778042
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.780942	2025-07-01 04:24:34.780942
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.784223	2025-07-01 04:24:34.784223
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.788006	2025-07-01 04:24:34.788006
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.791422	2025-07-01 04:24:34.791422
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.794811	2025-07-01 04:24:34.794811
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.798921	2025-07-01 04:24:34.798921
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.80219	2025-07-01 04:24:34.80219
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.806014	2025-07-01 04:24:34.806014
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.809625	2025-07-01 04:24:34.809625
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.813245	2025-07-01 04:24:34.813245
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.817165	2025-07-01 04:24:34.817165
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.824323	2025-07-01 04:24:34.824323
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.827528	2025-07-01 04:24:34.827528
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.830783	2025-07-01 04:24:34.830783
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.834373	2025-07-01 04:24:34.834373
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.85497	2025-07-01 04:24:34.85497
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.859145	2025-07-01 04:24:34.859145
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.862961	2025-07-01 04:24:34.862961
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.866549	2025-07-01 04:24:34.866549
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.870364	2025-07-01 04:24:34.870364
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.873433	2025-07-01 04:24:34.873433
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.876666	2025-07-01 04:24:34.876666
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.879912	2025-07-01 04:24:34.879912
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.883182	2025-07-01 04:24:34.883182
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.916162	2025-07-01 04:24:34.916162
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.919802	2025-07-01 04:24:34.919802
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.922983	2025-07-01 04:24:34.922983
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.92624	2025-07-01 04:24:34.92624
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.929371	2025-07-01 04:24:34.929371
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.942016	2025-07-01 04:24:34.942016
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.945261	2025-07-01 04:24:34.945261
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.949035	2025-07-01 04:24:34.949035
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.952608	2025-07-01 04:24:34.952608
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.956189	2025-07-01 04:24:34.956189
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.975542	2025-07-01 04:24:34.975542
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.978926	2025-07-01 04:24:34.978926
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.982107	2025-07-01 04:24:34.982107
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.98617	2025-07-01 04:24:34.98617
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.989435	2025-07-01 04:24:34.989435
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.993507	2025-07-01 04:24:34.993507
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:34.996931	2025-07-01 04:24:34.996931
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.000391	2025-07-01 04:24:35.000391
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.003766	2025-07-01 04:24:35.003766
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.007352	2025-07-01 04:24:35.007352
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.010521	2025-07-01 04:24:35.010521
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.014203	2025-07-01 04:24:35.014203
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.024575	2025-07-01 04:24:35.024575
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.028516	2025-07-01 04:24:35.028516
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.032102	2025-07-01 04:24:35.032102
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.035704	2025-07-01 04:24:35.035704
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.039288	2025-07-01 04:24:35.039288
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.042923	2025-07-01 04:24:35.042923
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.068532	2025-07-01 04:24:35.068532
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.073141	2025-07-01 04:24:35.073141
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.076813	2025-07-01 04:24:35.076813
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.080689	2025-07-01 04:24:35.080689
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.0841	2025-07-01 04:24:35.0841
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.087548	2025-07-01 04:24:35.087548
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.090916	2025-07-01 04:24:35.090916
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.094233	2025-07-01 04:24:35.094233
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.114665	2025-07-01 04:24:35.114665
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.118696	2025-07-01 04:24:35.118696
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.121951	2025-07-01 04:24:35.121951
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.125164	2025-07-01 04:24:35.125164
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.128772	2025-07-01 04:24:35.128772
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.132208	2025-07-01 04:24:35.132208
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.143671	2025-07-01 04:24:35.143671
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.147362	2025-07-01 04:24:35.147362
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.150802	2025-07-01 04:24:35.150802
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.155143	2025-07-01 04:24:35.155143
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.159039	2025-07-01 04:24:35.159039
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.162085	2025-07-01 04:24:35.162085
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.165105	2025-07-01 04:24:35.165105
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.168743	2025-07-01 04:24:35.168743
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.171707	2025-07-01 04:24:35.171707
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.174588	2025-07-01 04:24:35.174588
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.177573	2025-07-01 04:24:35.177573
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.180653	2025-07-01 04:24:35.180653
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.184149	2025-07-01 04:24:35.184149
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.187318	2025-07-01 04:24:35.187318
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.190361	2025-07-01 04:24:35.190361
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.193351	2025-07-01 04:24:35.193351
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.19744	2025-07-01 04:24:35.19744
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.200893	2025-07-01 04:24:35.200893
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.204359	2025-07-01 04:24:35.204359
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.207732	2025-07-01 04:24:35.207732
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.210825	2025-07-01 04:24:35.210825
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.221168	2025-07-01 04:24:35.221168
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.224928	2025-07-01 04:24:35.224928
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.228276	2025-07-01 04:24:35.228276
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.231882	2025-07-01 04:24:35.231882
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.234983	2025-07-01 04:24:35.234983
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.2385	2025-07-01 04:24:35.2385
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.241879	2025-07-01 04:24:35.241879
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.24532	2025-07-01 04:24:35.24532
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.248603	2025-07-01 04:24:35.248603
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.251804	2025-07-01 04:24:35.251804
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.254892	2025-07-01 04:24:35.254892
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.257863	2025-07-01 04:24:35.257863
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.261308	2025-07-01 04:24:35.261308
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.26459	2025-07-01 04:24:35.26459
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.267777	2025-07-01 04:24:35.267777
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.271048	2025-07-01 04:24:35.271048
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.275412	2025-07-01 04:24:35.275412
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.279087	2025-07-01 04:24:35.279087
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.282618	2025-07-01 04:24:35.282618
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.285856	2025-07-01 04:24:35.285856
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.288977	2025-07-01 04:24:35.288977
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.293609	2025-07-01 04:24:35.293609
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.297262	2025-07-01 04:24:35.297262
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.300628	2025-07-01 04:24:35.300628
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.304288	2025-07-01 04:24:35.304288
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.307674	2025-07-01 04:24:35.307674
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.325962	2025-07-01 04:24:35.325962
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.329687	2025-07-01 04:24:35.329687
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.333164	2025-07-01 04:24:35.333164
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.337103	2025-07-01 04:24:35.337103
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.341323	2025-07-01 04:24:35.341323
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.344416	2025-07-01 04:24:35.344416
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.348258	2025-07-01 04:24:35.348258
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.351292	2025-07-01 04:24:35.351292
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.354747	2025-07-01 04:24:35.354747
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.358511	2025-07-01 04:24:35.358511
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.392931	2025-07-01 04:24:35.392931
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.396262	2025-07-01 04:24:35.396262
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.399447	2025-07-01 04:24:35.399447
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.402813	2025-07-01 04:24:35.402813
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.406451	2025-07-01 04:24:35.406451
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.441341	2025-07-01 04:24:35.441341
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.445742	2025-07-01 04:24:35.445742
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.449227	2025-07-01 04:24:35.449227
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.452474	2025-07-01 04:24:35.452474
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.455813	2025-07-01 04:24:35.455813
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.480895	2025-07-01 04:24:35.480895
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.484275	2025-07-01 04:24:35.484275
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.487452	2025-07-01 04:24:35.487452
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.490665	2025-07-01 04:24:35.490665
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.493971	2025-07-01 04:24:35.493971
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.497828	2025-07-01 04:24:35.497828
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.532324	2025-07-01 04:24:35.532324
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.535824	2025-07-01 04:24:35.535824
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.539978	2025-07-01 04:24:35.539978
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.543327	2025-07-01 04:24:35.543327
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.546673	2025-07-01 04:24:35.546673
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.549987	2025-07-01 04:24:35.549987
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.553436	2025-07-01 04:24:35.553436
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.556888	2025-07-01 04:24:35.556888
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.560195	2025-07-01 04:24:35.560195
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.594328	2025-07-01 04:24:35.594328
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.597479	2025-07-01 04:24:35.597479
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.600685	2025-07-01 04:24:35.600685
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.603921	2025-07-01 04:24:35.603921
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.60751	2025-07-01 04:24:35.60751
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.610567	2025-07-01 04:24:35.610567
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.645648	2025-07-01 04:24:35.645648
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.649296	2025-07-01 04:24:35.649296
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.654758	2025-07-01 04:24:35.654758
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.658141	2025-07-01 04:24:35.658141
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.661525	2025-07-01 04:24:35.661525
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.66481	2025-07-01 04:24:35.66481
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.68483	2025-07-01 04:24:35.68483
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.688767	2025-07-01 04:24:35.688767
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.692268	2025-07-01 04:24:35.692268
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.695882	2025-07-01 04:24:35.695882
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.699102	2025-07-01 04:24:35.699102
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.702349	2025-07-01 04:24:35.702349
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.712542	2025-07-01 04:24:35.712542
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.718011	2025-07-01 04:24:35.718011
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.723703	2025-07-01 04:24:35.723703
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.75841	2025-07-01 04:24:35.75841
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.762243	2025-07-01 04:24:35.762243
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.766078	2025-07-01 04:24:35.766078
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.769582	2025-07-01 04:24:35.769582
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.772921	2025-07-01 04:24:35.772921
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.776173	2025-07-01 04:24:35.776173
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.779737	2025-07-01 04:24:35.779737
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.78354	2025-07-01 04:24:35.78354
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.787524	2025-07-01 04:24:35.787524
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.791052	2025-07-01 04:24:35.791052
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.794644	2025-07-01 04:24:35.794644
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.828976	2025-07-01 04:24:35.828976
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.832932	2025-07-01 04:24:35.832932
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.836929	2025-07-01 04:24:35.836929
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.840937	2025-07-01 04:24:35.840937
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.844409	2025-07-01 04:24:35.844409
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.858434	2025-07-01 04:24:35.858434
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.862206	2025-07-01 04:24:35.862206
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.865939	2025-07-01 04:24:35.865939
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.869491	2025-07-01 04:24:35.869491
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.872791	2025-07-01 04:24:35.872791
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.875992	2025-07-01 04:24:35.875992
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.879151	2025-07-01 04:24:35.879151
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.88264	2025-07-01 04:24:35.88264
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.885926	2025-07-01 04:24:35.885926
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.889035	2025-07-01 04:24:35.889035
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.892592	2025-07-01 04:24:35.892592
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.895995	2025-07-01 04:24:35.895995
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.899382	2025-07-01 04:24:35.899382
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.902374	2025-07-01 04:24:35.902374
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.905485	2025-07-01 04:24:35.905485
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.908547	2025-07-01 04:24:35.908547
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.912107	2025-07-01 04:24:35.912107
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.9153	2025-07-01 04:24:35.9153
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.921068	2025-07-01 04:24:35.921068
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.924624	2025-07-01 04:24:35.924624
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.928022	2025-07-01 04:24:35.928022
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.931794	2025-07-01 04:24:35.931794
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.935541	2025-07-01 04:24:35.935541
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.950769	2025-07-01 04:24:35.950769
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.958101	2025-07-01 04:24:35.958101
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.963646	2025-07-01 04:24:35.963646
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.970477	2025-07-01 04:24:35.970477
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.975028	2025-07-01 04:24:35.975028
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.978341	2025-07-01 04:24:35.978341
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.981438	2025-07-01 04:24:35.981438
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.984663	2025-07-01 04:24:35.984663
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.988123	2025-07-01 04:24:35.988123
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.991035	2025-07-01 04:24:35.991035
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.994033	2025-07-01 04:24:35.994033
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:35.997186	2025-07-01 04:24:35.997186
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.000261	2025-07-01 04:24:36.000261
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.004399	2025-07-01 04:24:36.004399
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.007556	2025-07-01 04:24:36.007556
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.010908	2025-07-01 04:24:36.010908
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.014951	2025-07-01 04:24:36.014951
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.018559	2025-07-01 04:24:36.018559
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.02869	2025-07-01 04:24:36.02869
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.031855	2025-07-01 04:24:36.031855
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.03507	2025-07-01 04:24:36.03507
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.038128	2025-07-01 04:24:36.038128
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.041412	2025-07-01 04:24:36.041412
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.061081	2025-07-01 04:24:36.061081
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.065248	2025-07-01 04:24:36.065248
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.06859	2025-07-01 04:24:36.06859
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.071903	2025-07-01 04:24:36.071903
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.076163	2025-07-01 04:24:36.076163
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.080736	2025-07-01 04:24:36.080736
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.087399	2025-07-01 04:24:36.087399
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.090563	2025-07-01 04:24:36.090563
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.093873	2025-07-01 04:24:36.093873
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.097138	2025-07-01 04:24:36.097138
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.100767	2025-07-01 04:24:36.100767
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.104458	2025-07-01 04:24:36.104458
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.107544	2025-07-01 04:24:36.107544
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.11063	2025-07-01 04:24:36.11063
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.113863	2025-07-01 04:24:36.113863
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.117317	2025-07-01 04:24:36.117317
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.120604	2025-07-01 04:24:36.120604
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.123882	2025-07-01 04:24:36.123882
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.127057	2025-07-01 04:24:36.127057
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.130348	2025-07-01 04:24:36.130348
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.133721	2025-07-01 04:24:36.133721
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.137396	2025-07-01 04:24:36.137396
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.141825	2025-07-01 04:24:36.141825
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.145303	2025-07-01 04:24:36.145303
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.148729	2025-07-01 04:24:36.148729
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:36.15219	2025-07-01 04:24:36.15219
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.172267	2025-07-01 04:24:36.172267
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.176698	2025-07-01 04:24:36.176698
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.179765	2025-07-01 04:24:36.179765
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.183139	2025-07-01 04:24:36.183139
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.186123	2025-07-01 04:24:36.186123
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.189344	2025-07-01 04:24:36.189344
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.192484	2025-07-01 04:24:36.192484
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.195532	2025-07-01 04:24:36.195532
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.198979	2025-07-01 04:24:36.198979
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.202377	2025-07-01 04:24:36.202377
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.205412	2025-07-01 04:24:36.205412
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.208416	2025-07-01 04:24:36.208416
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.228563	2025-07-01 04:24:36.228563
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.232169	2025-07-01 04:24:36.232169
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.236432	2025-07-01 04:24:36.236432
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.240044	2025-07-01 04:24:36.240044
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.243378	2025-07-01 04:24:36.243378
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.246365	2025-07-01 04:24:36.246365
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.249683	2025-07-01 04:24:36.249683
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.252943	2025-07-01 04:24:36.252943
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.256072	2025-07-01 04:24:36.256072
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.259392	2025-07-01 04:24:36.259392
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.262821	2025-07-01 04:24:36.262821
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.266287	2025-07-01 04:24:36.266287
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.270134	2025-07-01 04:24:36.270134
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.273746	2025-07-01 04:24:36.273746
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.277107	2025-07-01 04:24:36.277107
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.280688	2025-07-01 04:24:36.280688
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.284151	2025-07-01 04:24:36.284151
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.287552	2025-07-01 04:24:36.287552
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.290817	2025-07-01 04:24:36.290817
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.293926	2025-07-01 04:24:36.293926
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.298487	2025-07-01 04:24:36.298487
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.301797	2025-07-01 04:24:36.301797
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.305566	2025-07-01 04:24:36.305566
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.309024	2025-07-01 04:24:36.309024
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.312378	2025-07-01 04:24:36.312378
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.315848	2025-07-01 04:24:36.315848
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.319365	2025-07-01 04:24:36.319365
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.322651	2025-07-01 04:24:36.322651
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.325892	2025-07-01 04:24:36.325892
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.330253	2025-07-01 04:24:36.330253
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.333913	2025-07-01 04:24:36.333913
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.338109	2025-07-01 04:24:36.338109
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.341523	2025-07-01 04:24:36.341523
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.344694	2025-07-01 04:24:36.344694
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.349009	2025-07-01 04:24:36.349009
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.352568	2025-07-01 04:24:36.352568
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.356008	2025-07-01 04:24:36.356008
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.360292	2025-07-01 04:24:36.360292
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.363675	2025-07-01 04:24:36.363675
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.367162	2025-07-01 04:24:36.367162
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.370512	2025-07-01 04:24:36.370512
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.373713	2025-07-01 04:24:36.373713
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.376771	2025-07-01 04:24:36.376771
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.380949	2025-07-01 04:24:36.380949
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.384426	2025-07-01 04:24:36.384426
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.388166	2025-07-01 04:24:36.388166
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.391381	2025-07-01 04:24:36.391381
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.395042	2025-07-01 04:24:36.395042
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.403507	2025-07-01 04:24:36.403507
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.406753	2025-07-01 04:24:36.406753
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.410036	2025-07-01 04:24:36.410036
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.414575	2025-07-01 04:24:36.414575
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.418359	2025-07-01 04:24:36.418359
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.421916	2025-07-01 04:24:36.421916
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.425134	2025-07-01 04:24:36.425134
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.428364	2025-07-01 04:24:36.428364
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.432002	2025-07-01 04:24:36.432002
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.435358	2025-07-01 04:24:36.435358
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.438718	2025-07-01 04:24:36.438718
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.44199	2025-07-01 04:24:36.44199
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.445285	2025-07-01 04:24:36.445285
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.448393	2025-07-01 04:24:36.448393
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.451995	2025-07-01 04:24:36.451995
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.45554	2025-07-01 04:24:36.45554
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.461137	2025-07-01 04:24:36.461137
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.464523	2025-07-01 04:24:36.464523
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.467574	2025-07-01 04:24:36.467574
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.4705	2025-07-01 04:24:36.4705
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.473426	2025-07-01 04:24:36.473426
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.476306	2025-07-01 04:24:36.476306
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.487289	2025-07-01 04:24:36.487289
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.490821	2025-07-01 04:24:36.490821
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.49433	2025-07-01 04:24:36.49433
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.497752	2025-07-01 04:24:36.497752
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.501117	2025-07-01 04:24:36.501117
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.504601	2025-07-01 04:24:36.504601
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.508157	2025-07-01 04:24:36.508157
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.511832	2025-07-01 04:24:36.511832
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.515124	2025-07-01 04:24:36.515124
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.51905	2025-07-01 04:24:36.51905
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.522343	2025-07-01 04:24:36.522343
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.526036	2025-07-01 04:24:36.526036
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.530045	2025-07-01 04:24:36.530045
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.533072	2025-07-01 04:24:36.533072
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.536019	2025-07-01 04:24:36.536019
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.540755	2025-07-01 04:24:36.540755
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.544497	2025-07-01 04:24:36.544497
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.547451	2025-07-01 04:24:36.547451
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.55085	2025-07-01 04:24:36.55085
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.555452	2025-07-01 04:24:36.555452
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.559142	2025-07-01 04:24:36.559142
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.562437	2025-07-01 04:24:36.562437
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.566894	2025-07-01 04:24:36.566894
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.570945	2025-07-01 04:24:36.570945
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.580285	2025-07-01 04:24:36.580285
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.586639	2025-07-01 04:24:36.586639
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.599459	2025-07-01 04:24:36.599459
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.605754	2025-07-01 04:24:36.605754
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.612013	2025-07-01 04:24:36.612013
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.61787	2025-07-01 04:24:36.61787
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.623479	2025-07-01 04:24:36.623479
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.629653	2025-07-01 04:24:36.629653
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.63402	2025-07-01 04:24:36.63402
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.639875	2025-07-01 04:24:36.639875
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.644815	2025-07-01 04:24:36.644815
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.649125	2025-07-01 04:24:36.649125
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.652035	2025-07-01 04:24:36.652035
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.654967	2025-07-01 04:24:36.654967
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.657724	2025-07-01 04:24:36.657724
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.660541	2025-07-01 04:24:36.660541
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.663143	2025-07-01 04:24:36.663143
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.666209	2025-07-01 04:24:36.666209
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.6704	2025-07-01 04:24:36.6704
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.674064	2025-07-01 04:24:36.674064
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.678477	2025-07-01 04:24:36.678477
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.684603	2025-07-01 04:24:36.684603
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.689721	2025-07-01 04:24:36.689721
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.692812	2025-07-01 04:24:36.692812
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.695983	2025-07-01 04:24:36.695983
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.698939	2025-07-01 04:24:36.698939
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.702116	2025-07-01 04:24:36.702116
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.705725	2025-07-01 04:24:36.705725
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.709071	2025-07-01 04:24:36.709071
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.713238	2025-07-01 04:24:36.713238
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.717206	2025-07-01 04:24:36.717206
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.720533	2025-07-01 04:24:36.720533
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.723504	2025-07-01 04:24:36.723504
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.726653	2025-07-01 04:24:36.726653
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.729881	2025-07-01 04:24:36.729881
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.73294	2025-07-01 04:24:36.73294
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.737239	2025-07-01 04:24:36.737239
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.740718	2025-07-01 04:24:36.740718
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.74401	2025-07-01 04:24:36.74401
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.747165	2025-07-01 04:24:36.747165
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.750218	2025-07-01 04:24:36.750218
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.754674	2025-07-01 04:24:36.754674
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.758633	2025-07-01 04:24:36.758633
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.761806	2025-07-01 04:24:36.761806
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.765093	2025-07-01 04:24:36.765093
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.768585	2025-07-01 04:24:36.768585
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.772038	2025-07-01 04:24:36.772038
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.775449	2025-07-01 04:24:36.775449
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.778656	2025-07-01 04:24:36.778656
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.78175	2025-07-01 04:24:36.78175
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.785023	2025-07-01 04:24:36.785023
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.788097	2025-07-01 04:24:36.788097
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.791417	2025-07-01 04:24:36.791417
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.794608	2025-07-01 04:24:36.794608
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.797692	2025-07-01 04:24:36.797692
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.800569	2025-07-01 04:24:36.800569
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.803314	2025-07-01 04:24:36.803314
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.806115	2025-07-01 04:24:36.806115
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.809031	2025-07-01 04:24:36.809031
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.811799	2025-07-01 04:24:36.811799
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.814666	2025-07-01 04:24:36.814666
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.817443	2025-07-01 04:24:36.817443
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.821745	2025-07-01 04:24:36.821745
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.826539	2025-07-01 04:24:36.826539
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.83	2025-07-01 04:24:36.83
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.832999	2025-07-01 04:24:36.832999
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.835951	2025-07-01 04:24:36.835951
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.839282	2025-07-01 04:24:36.839282
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.842484	2025-07-01 04:24:36.842484
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.845983	2025-07-01 04:24:36.845983
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.848986	2025-07-01 04:24:36.848986
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.851812	2025-07-01 04:24:36.851812
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.855055	2025-07-01 04:24:36.855055
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.858943	2025-07-01 04:24:36.858943
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.862147	2025-07-01 04:24:36.862147
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.865	2025-07-01 04:24:36.865
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.868289	2025-07-01 04:24:36.868289
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.871919	2025-07-01 04:24:36.871919
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.875465	2025-07-01 04:24:36.875465
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.879061	2025-07-01 04:24:36.879061
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.882386	2025-07-01 04:24:36.882386
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.885645	2025-07-01 04:24:36.885645
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.889377	2025-07-01 04:24:36.889377
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.893268	2025-07-01 04:24:36.893268
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.89665	2025-07-01 04:24:36.89665
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.900092	2025-07-01 04:24:36.900092
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.903329	2025-07-01 04:24:36.903329
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.906914	2025-07-01 04:24:36.906914
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.910059	2025-07-01 04:24:36.910059
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.913501	2025-07-01 04:24:36.913501
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.916866	2025-07-01 04:24:36.916866
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.919892	2025-07-01 04:24:36.919892
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.92274	2025-07-01 04:24:36.92274
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.925597	2025-07-01 04:24:36.925597
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.92845	2025-07-01 04:24:36.92845
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.931389	2025-07-01 04:24:36.931389
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.934657	2025-07-01 04:24:36.934657
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.938467	2025-07-01 04:24:36.938467
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.942052	2025-07-01 04:24:36.942052
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.945467	2025-07-01 04:24:36.945467
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.949557	2025-07-01 04:24:36.949557
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.958067	2025-07-01 04:24:36.958067
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.961426	2025-07-01 04:24:36.961426
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.964681	2025-07-01 04:24:36.964681
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.968066	2025-07-01 04:24:36.968066
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.971682	2025-07-01 04:24:36.971682
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.978226	2025-07-01 04:24:36.978226
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.981966	2025-07-01 04:24:36.981966
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.984895	2025-07-01 04:24:36.984895
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.987749	2025-07-01 04:24:36.987749
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.990555	2025-07-01 04:24:36.990555
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.993489	2025-07-01 04:24:36.993489
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.996519	2025-07-01 04:24:36.996519
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:36.999233	2025-07-01 04:24:36.999233
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.002001	2025-07-01 04:24:37.002001
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.005216	2025-07-01 04:24:37.005216
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.008387	2025-07-01 04:24:37.008387
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.011502	2025-07-01 04:24:37.011502
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.014604	2025-07-01 04:24:37.014604
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.017851	2025-07-01 04:24:37.017851
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.020929	2025-07-01 04:24:37.020929
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.023777	2025-07-01 04:24:37.023777
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.026693	2025-07-01 04:24:37.026693
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.030064	2025-07-01 04:24:37.030064
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.033461	2025-07-01 04:24:37.033461
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.03661	2025-07-01 04:24:37.03661
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.039996	2025-07-01 04:24:37.039996
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.043153	2025-07-01 04:24:37.043153
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.046535	2025-07-01 04:24:37.046535
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.049423	2025-07-01 04:24:37.049423
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.052128	2025-07-01 04:24:37.052128
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.054953	2025-07-01 04:24:37.054953
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.058084	2025-07-01 04:24:37.058084
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.065284	2025-07-01 04:24:37.065284
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.06827	2025-07-01 04:24:37.06827
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.071201	2025-07-01 04:24:37.071201
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.075758	2025-07-01 04:24:37.075758
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.079171	2025-07-01 04:24:37.079171
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.082437	2025-07-01 04:24:37.082437
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.085441	2025-07-01 04:24:37.085441
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.088678	2025-07-01 04:24:37.088678
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.09265	2025-07-01 04:24:37.09265
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.096331	2025-07-01 04:24:37.096331
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.099249	2025-07-01 04:24:37.099249
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.102573	2025-07-01 04:24:37.102573
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.105489	2025-07-01 04:24:37.105489
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.108798	2025-07-01 04:24:37.108798
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.111995	2025-07-01 04:24:37.111995
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.114922	2025-07-01 04:24:37.114922
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.118517	2025-07-01 04:24:37.118517
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.122104	2025-07-01 04:24:37.122104
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.125724	2025-07-01 04:24:37.125724
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.129223	2025-07-01 04:24:37.129223
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.132546	2025-07-01 04:24:37.132546
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.136026	2025-07-01 04:24:37.136026
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.139192	2025-07-01 04:24:37.139192
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.143614	2025-07-01 04:24:37.143614
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.149034	2025-07-01 04:24:37.149034
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.151928	2025-07-01 04:24:37.151928
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.155111	2025-07-01 04:24:37.155111
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.158316	2025-07-01 04:24:37.158316
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.161805	2025-07-01 04:24:37.161805
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.165306	2025-07-01 04:24:37.165306
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.168702	2025-07-01 04:24:37.168702
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.171889	2025-07-01 04:24:37.171889
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.175231	2025-07-01 04:24:37.175231
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.178453	2025-07-01 04:24:37.178453
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.182724	2025-07-01 04:24:37.182724
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.187574	2025-07-01 04:24:37.187574
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.191322	2025-07-01 04:24:37.191322
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.195134	2025-07-01 04:24:37.195134
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.198623	2025-07-01 04:24:37.198623
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.202026	2025-07-01 04:24:37.202026
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.205471	2025-07-01 04:24:37.205471
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.208851	2025-07-01 04:24:37.208851
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.212301	2025-07-01 04:24:37.212301
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.215848	2025-07-01 04:24:37.215848
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.219486	2025-07-01 04:24:37.219486
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.222999	2025-07-01 04:24:37.222999
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.244104	2025-07-01 04:24:37.244104
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.248068	2025-07-01 04:24:37.248068
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.251642	2025-07-01 04:24:37.251642
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.255081	2025-07-01 04:24:37.255081
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.258741	2025-07-01 04:24:37.258741
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.262086	2025-07-01 04:24:37.262086
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.265224	2025-07-01 04:24:37.265224
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.268521	2025-07-01 04:24:37.268521
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:37.271768	2025-07-01 04:24:37.271768
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-07-01 04:24:25.62012
2	ART Coverage	\N	\N	2025-07-01 04:24:25.623034
3	People Living with HIV	\N	\N	2025-07-01 04:24:25.625764
4	HIV-related Deaths	\N	\N	2025-07-01 04:24:25.629551
5	HIV Cases Adults 15-49	\N	\N	2025-07-01 04:24:25.632147
6	ART Pediatric Coverage	\N	\N	2025-07-01 04:24:25.634969
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminus	$2b$12$8qDaG2FCucGhf/ttTpppK.qS62EFm9AmHpkKTJG0JQceLq9C6MUqa	admin	0	2025-07-01 04:24:25.61093	2025-07-01 04:24:25.61093
2	userus	$2b$12$1Qkh3kX3iGb41Lo7epRFBegJJZ9DdJ6m0JV9hJ8Fo6hQKEgRsz4Ea	user	0	2025-07-01 04:24:25.614115	2025-07-01 04:24:25.614115
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 170, true);


--
-- Name: etl_metadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etl_metadata_id_seq', 1, false);


--
-- Name: health_indicators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_indicators_id_seq', 6800, true);


--
-- Name: indicator_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.indicator_types_id_seq', 6, true);


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

