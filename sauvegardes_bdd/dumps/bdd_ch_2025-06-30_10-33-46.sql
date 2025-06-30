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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-30 08:30:38.759891	2025-06-30 08:30:38.759891
2	Albania	Europe	\N	2025-06-30 08:30:38.764156	2025-06-30 08:30:38.764156
3	Algeria	Africa	\N	2025-06-30 08:30:38.766858	2025-06-30 08:30:38.766858
4	Angola	Africa	\N	2025-06-30 08:30:38.773218	2025-06-30 08:30:38.773218
5	Argentina	Americas	\N	2025-06-30 08:30:38.777482	2025-06-30 08:30:38.777482
6	Armenia	Europe	\N	2025-06-30 08:30:38.781927	2025-06-30 08:30:38.781927
7	Australia	Western Pacific	\N	2025-06-30 08:30:38.786177	2025-06-30 08:30:38.786177
8	Austria	Europe	\N	2025-06-30 08:30:38.788851	2025-06-30 08:30:38.788851
9	Azerbaijan	Europe	\N	2025-06-30 08:30:38.791801	2025-06-30 08:30:38.791801
10	Bahamas	Americas	\N	2025-06-30 08:30:38.794621	2025-06-30 08:30:38.794621
11	Bahrain	Eastern Mediterranean	\N	2025-06-30 08:30:38.797358	2025-06-30 08:30:38.797358
12	Bangladesh	South-East Asia	\N	2025-06-30 08:30:38.800217	2025-06-30 08:30:38.800217
13	Barbados	Americas	\N	2025-06-30 08:30:38.802919	2025-06-30 08:30:38.802919
14	Belarus	Europe	\N	2025-06-30 08:30:38.807473	2025-06-30 08:30:38.807473
15	Belgium	Europe	\N	2025-06-30 08:30:38.810183	2025-06-30 08:30:38.810183
16	Belize	Americas	\N	2025-06-30 08:30:38.812824	2025-06-30 08:30:38.812824
17	Benin	Africa	\N	2025-06-30 08:30:38.815408	2025-06-30 08:30:38.815408
18	Bhutan	South-East Asia	\N	2025-06-30 08:30:38.818104	2025-06-30 08:30:38.818104
19	Bolivia	Americas	\N	2025-06-30 08:30:38.820881	2025-06-30 08:30:38.820881
20	Bosnia and Herzegovina	Europe	\N	2025-06-30 08:30:38.825202	2025-06-30 08:30:38.825202
21	Botswana	Africa	\N	2025-06-30 08:30:38.827974	2025-06-30 08:30:38.827974
22	Brazil	Americas	\N	2025-06-30 08:30:38.830691	2025-06-30 08:30:38.830691
23	Brunei Darussalam	Western Pacific	\N	2025-06-30 08:30:38.833265	2025-06-30 08:30:38.833265
24	Bulgaria	Europe	\N	2025-06-30 08:30:38.837798	2025-06-30 08:30:38.837798
25	Burkina Faso	Africa	\N	2025-06-30 08:30:38.840636	2025-06-30 08:30:38.840636
26	Burundi	Africa	\N	2025-06-30 08:30:38.844702	2025-06-30 08:30:38.844702
27	Cabo Verde	Africa	\N	2025-06-30 08:30:38.849241	2025-06-30 08:30:38.849241
28	Cambodia	Western Pacific	\N	2025-06-30 08:30:38.853898	2025-06-30 08:30:38.853898
29	Cameroon	Africa	\N	2025-06-30 08:30:38.858683	2025-06-30 08:30:38.858683
30	Canada	Americas	\N	2025-06-30 08:30:38.861567	2025-06-30 08:30:38.861567
31	Central African Republic	Africa	\N	2025-06-30 08:30:38.866054	2025-06-30 08:30:38.866054
32	Chad	Africa	\N	2025-06-30 08:30:38.868781	2025-06-30 08:30:38.868781
33	Chile	Americas	\N	2025-06-30 08:30:38.87158	2025-06-30 08:30:38.87158
34	China	Western Pacific	\N	2025-06-30 08:30:38.874454	2025-06-30 08:30:38.874454
35	Colombia	Americas	\N	2025-06-30 08:30:38.879375	2025-06-30 08:30:38.879375
36	Comoros	Africa	\N	2025-06-30 08:30:38.884255	2025-06-30 08:30:38.884255
37	Congo	Americas	\N	2025-06-30 08:30:38.887141	2025-06-30 08:30:38.887141
38	Costa Rica	Americas	\N	2025-06-30 08:30:38.891816	2025-06-30 08:30:38.891816
39	Côte d'Ivoire	Africa	\N	2025-06-30 08:30:38.894647	2025-06-30 08:30:38.894647
40	Croatia	Europe	\N	2025-06-30 08:30:38.897496	2025-06-30 08:30:38.897496
41	Cuba	Americas	\N	2025-06-30 08:30:38.9019	2025-06-30 08:30:38.9019
42	Cyprus	Europe	\N	2025-06-30 08:30:38.904686	2025-06-30 08:30:38.904686
43	Czechia	Europe	\N	2025-06-30 08:30:38.907471	2025-06-30 08:30:38.907471
44	North Korea	Western Pacific	\N	2025-06-30 08:30:38.910946	2025-06-30 08:30:38.910946
45	DR Congo	Africa	\N	2025-06-30 08:30:38.913814	2025-06-30 08:30:38.913814
46	Denmark	Europe	\N	2025-06-30 08:30:38.91825	2025-06-30 08:30:38.91825
47	Djibouti	Eastern Mediterranean	\N	2025-06-30 08:30:38.922422	2025-06-30 08:30:38.922422
48	Dominican Republic	Americas	\N	2025-06-30 08:30:38.925164	2025-06-30 08:30:38.925164
49	Ecuador	Americas	\N	2025-06-30 08:30:38.927935	2025-06-30 08:30:38.927935
50	Egypt	Eastern Mediterranean	\N	2025-06-30 08:30:38.930649	2025-06-30 08:30:38.930649
51	El Salvador	Americas	\N	2025-06-30 08:30:38.935739	2025-06-30 08:30:38.935739
52	Equatorial Guinea	Africa	\N	2025-06-30 08:30:38.941954	2025-06-30 08:30:38.941954
53	Eritrea	Africa	\N	2025-06-30 08:30:38.950638	2025-06-30 08:30:38.950638
54	Estonia	Europe	\N	2025-06-30 08:30:38.953596	2025-06-30 08:30:38.953596
55	Eswatini	Africa	\N	2025-06-30 08:30:38.956599	2025-06-30 08:30:38.956599
56	Ethiopia	Africa	\N	2025-06-30 08:30:38.959547	2025-06-30 08:30:38.959547
57	Fiji	Western Pacific	\N	2025-06-30 08:30:38.964686	2025-06-30 08:30:38.964686
58	Finland	Europe	\N	2025-06-30 08:30:38.972637	2025-06-30 08:30:38.972637
59	France	Europe	\N	2025-06-30 08:30:38.978917	2025-06-30 08:30:38.978917
60	Gabon	Africa	\N	2025-06-30 08:30:38.983796	2025-06-30 08:30:38.983796
61	Gambia	Africa	\N	2025-06-30 08:30:38.987913	2025-06-30 08:30:38.987913
62	Georgia	Europe	\N	2025-06-30 08:30:38.994351	2025-06-30 08:30:38.994351
63	Germany	Europe	\N	2025-06-30 08:30:39.000759	2025-06-30 08:30:39.000759
64	Ghana	Africa	\N	2025-06-30 08:30:39.005199	2025-06-30 08:30:39.005199
65	Greece	Europe	\N	2025-06-30 08:30:39.009441	2025-06-30 08:30:39.009441
66	Guatemala	Americas	\N	2025-06-30 08:30:39.01852	2025-06-30 08:30:39.01852
67	Guinea	Africa	\N	2025-06-30 08:30:39.032436	2025-06-30 08:30:39.032436
68	Guinea-Bissau	Africa	\N	2025-06-30 08:30:39.045388	2025-06-30 08:30:39.045388
69	Guyana	Americas	\N	2025-06-30 08:30:39.056037	2025-06-30 08:30:39.056037
70	Haiti	Americas	\N	2025-06-30 08:30:39.064487	2025-06-30 08:30:39.064487
71	Honduras	Americas	\N	2025-06-30 08:30:39.068592	2025-06-30 08:30:39.068592
72	Hungary	Europe	\N	2025-06-30 08:30:39.073313	2025-06-30 08:30:39.073313
73	Iceland	Europe	\N	2025-06-30 08:30:39.077556	2025-06-30 08:30:39.077556
74	India	South-East Asia	\N	2025-06-30 08:30:39.082388	2025-06-30 08:30:39.082388
75	Indonesia	South-East Asia	\N	2025-06-30 08:30:39.088529	2025-06-30 08:30:39.088529
76	Iran	Eastern Mediterranean	\N	2025-06-30 08:30:39.093463	2025-06-30 08:30:39.093463
77	Ireland	Europe	\N	2025-06-30 08:30:39.096474	2025-06-30 08:30:39.096474
78	Israel	Europe	\N	2025-06-30 08:30:39.09952	2025-06-30 08:30:39.09952
79	Italy	Europe	\N	2025-06-30 08:30:39.10484	2025-06-30 08:30:39.10484
80	Jamaica	Americas	\N	2025-06-30 08:30:39.109415	2025-06-30 08:30:39.109415
81	Japan	Western Pacific	\N	2025-06-30 08:30:39.112352	2025-06-30 08:30:39.112352
82	Jordan	Eastern Mediterranean	\N	2025-06-30 08:30:39.116648	2025-06-30 08:30:39.116648
83	Kazakhstan	Europe	\N	2025-06-30 08:30:39.11956	2025-06-30 08:30:39.11956
84	Kenya	Africa	\N	2025-06-30 08:30:39.122582	2025-06-30 08:30:39.122582
85	Kuwait	Eastern Mediterranean	\N	2025-06-30 08:30:39.125385	2025-06-30 08:30:39.125385
86	Kyrgyzstan	Europe	\N	2025-06-30 08:30:39.127982	2025-06-30 08:30:39.127982
87	Laos	Western Pacific	\N	2025-06-30 08:30:39.130667	2025-06-30 08:30:39.130667
88	Latvia	Europe	\N	2025-06-30 08:30:39.134259	2025-06-30 08:30:39.134259
89	Lebanon	Eastern Mediterranean	\N	2025-06-30 08:30:39.137038	2025-06-30 08:30:39.137038
90	Lesotho	Africa	\N	2025-06-30 08:30:39.139547	2025-06-30 08:30:39.139547
91	Liberia	Africa	\N	2025-06-30 08:30:39.142503	2025-06-30 08:30:39.142503
92	Libya	Eastern Mediterranean	\N	2025-06-30 08:30:39.145279	2025-06-30 08:30:39.145279
93	Lithuania	Europe	\N	2025-06-30 08:30:39.148243	2025-06-30 08:30:39.148243
94	Luxembourg	Europe	\N	2025-06-30 08:30:39.150842	2025-06-30 08:30:39.150842
95	Madagascar	Africa	\N	2025-06-30 08:30:39.153658	2025-06-30 08:30:39.153658
96	Malawi	Africa	\N	2025-06-30 08:30:39.158486	2025-06-30 08:30:39.158486
97	Malaysia	Western Pacific	\N	2025-06-30 08:30:39.162678	2025-06-30 08:30:39.162678
98	Maldives	South-East Asia	\N	2025-06-30 08:30:39.167359	2025-06-30 08:30:39.167359
99	Mali	Africa	\N	2025-06-30 08:30:39.173211	2025-06-30 08:30:39.173211
100	Malta	Europe	\N	2025-06-30 08:30:39.175905	2025-06-30 08:30:39.175905
101	Mauritania	Africa	\N	2025-06-30 08:30:39.178507	2025-06-30 08:30:39.178507
102	Mauritius	Africa	\N	2025-06-30 08:30:39.18118	2025-06-30 08:30:39.18118
103	Mexico	Americas	\N	2025-06-30 08:30:39.18388	2025-06-30 08:30:39.18388
104	Mongolia	Western Pacific	\N	2025-06-30 08:30:39.186534	2025-06-30 08:30:39.186534
105	Montenegro	Europe	\N	2025-06-30 08:30:39.190289	2025-06-30 08:30:39.190289
106	Morocco	Eastern Mediterranean	\N	2025-06-30 08:30:39.192955	2025-06-30 08:30:39.192955
107	Mozambique	Africa	\N	2025-06-30 08:30:39.19716	2025-06-30 08:30:39.19716
108	Myanmar	South-East Asia	\N	2025-06-30 08:30:39.199879	2025-06-30 08:30:39.199879
109	Namibia	Africa	\N	2025-06-30 08:30:39.202592	2025-06-30 08:30:39.202592
110	Nepal	South-East Asia	\N	2025-06-30 08:30:39.205314	2025-06-30 08:30:39.205314
111	Netherlands	Europe	\N	2025-06-30 08:30:39.208042	2025-06-30 08:30:39.208042
112	New Zealand	Western Pacific	\N	2025-06-30 08:30:39.210696	2025-06-30 08:30:39.210696
113	Nicaragua	Americas	\N	2025-06-30 08:30:39.213416	2025-06-30 08:30:39.213416
114	Niger	Africa	\N	2025-06-30 08:30:39.218285	2025-06-30 08:30:39.218285
115	Nigeria	Africa	\N	2025-06-30 08:30:39.222771	2025-06-30 08:30:39.222771
116	Norway	Europe	\N	2025-06-30 08:30:39.227456	2025-06-30 08:30:39.227456
117	Oman	Eastern Mediterranean	\N	2025-06-30 08:30:39.232464	2025-06-30 08:30:39.232464
118	Pakistan	Eastern Mediterranean	\N	2025-06-30 08:30:39.24588	2025-06-30 08:30:39.24588
119	Panama	Americas	\N	2025-06-30 08:30:39.289133	2025-06-30 08:30:39.289133
120	Papua New Guinea	Western Pacific	\N	2025-06-30 08:30:39.305062	2025-06-30 08:30:39.305062
121	Paraguay	Americas	\N	2025-06-30 08:30:39.324321	2025-06-30 08:30:39.324321
122	Peru	Americas	\N	2025-06-30 08:30:39.346211	2025-06-30 08:30:39.346211
123	Philippines	Western Pacific	\N	2025-06-30 08:30:39.363127	2025-06-30 08:30:39.363127
124	Poland	Europe	\N	2025-06-30 08:30:39.376903	2025-06-30 08:30:39.376903
125	Portugal	Europe	\N	2025-06-30 08:30:39.390477	2025-06-30 08:30:39.390477
126	Qatar	Eastern Mediterranean	\N	2025-06-30 08:30:39.399378	2025-06-30 08:30:39.399378
127	South Korea	Western Pacific	\N	2025-06-30 08:30:39.402172	2025-06-30 08:30:39.402172
128	Moldova	Europe	\N	2025-06-30 08:30:39.407827	2025-06-30 08:30:39.407827
129	North Macedonia	Europe	\N	2025-06-30 08:30:39.415608	2025-06-30 08:30:39.415608
130	Romania	Europe	\N	2025-06-30 08:30:39.418283	2025-06-30 08:30:39.418283
131	Russia	Europe	\N	2025-06-30 08:30:39.422492	2025-06-30 08:30:39.422492
132	Rwanda	Africa	\N	2025-06-30 08:30:39.426921	2025-06-30 08:30:39.426921
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-30 08:30:39.431549	2025-06-30 08:30:39.431549
134	Senegal	Africa	\N	2025-06-30 08:30:39.43999	2025-06-30 08:30:39.43999
135	Serbia	Europe	\N	2025-06-30 08:30:39.448121	2025-06-30 08:30:39.448121
136	Sierra Leone	Africa	\N	2025-06-30 08:30:39.454579	2025-06-30 08:30:39.454579
137	Singapore	Western Pacific	\N	2025-06-30 08:30:39.459261	2025-06-30 08:30:39.459261
138	Slovakia	Europe	\N	2025-06-30 08:30:39.466891	2025-06-30 08:30:39.466891
139	Slovenia	Europe	\N	2025-06-30 08:30:39.478302	2025-06-30 08:30:39.478302
140	Somalia	Eastern Mediterranean	\N	2025-06-30 08:30:39.48308	2025-06-30 08:30:39.48308
141	South Africa	Africa	\N	2025-06-30 08:30:39.487431	2025-06-30 08:30:39.487431
142	South Sudan	Africa	\N	2025-06-30 08:30:39.491879	2025-06-30 08:30:39.491879
143	Spain	Europe	\N	2025-06-30 08:30:39.496039	2025-06-30 08:30:39.496039
144	Sri Lanka	South-East Asia	\N	2025-06-30 08:30:39.501737	2025-06-30 08:30:39.501737
145	Sudan	Eastern Mediterranean	\N	2025-06-30 08:30:39.506093	2025-06-30 08:30:39.506093
146	Suriname	Americas	\N	2025-06-30 08:30:39.508615	2025-06-30 08:30:39.508615
147	Sweden	Europe	\N	2025-06-30 08:30:39.514094	2025-06-30 08:30:39.514094
148	Switzerland	Europe	\N	2025-06-30 08:30:39.518557	2025-06-30 08:30:39.518557
149	Syria	Eastern Mediterranean	\N	2025-06-30 08:30:39.521083	2025-06-30 08:30:39.521083
150	Tajikistan	Europe	\N	2025-06-30 08:30:39.523804	2025-06-30 08:30:39.523804
151	Thailand	South-East Asia	\N	2025-06-30 08:30:39.528198	2025-06-30 08:30:39.528198
152	Timor-Leste	South-East Asia	\N	2025-06-30 08:30:39.531214	2025-06-30 08:30:39.531214
153	Togo	Africa	\N	2025-06-30 08:30:39.535842	2025-06-30 08:30:39.535842
154	Trinidad and Tobago	Americas	\N	2025-06-30 08:30:39.538818	2025-06-30 08:30:39.538818
155	Tunisia	Eastern Mediterranean	\N	2025-06-30 08:30:39.543446	2025-06-30 08:30:39.543446
156	Turkey	Europe	\N	2025-06-30 08:30:39.546333	2025-06-30 08:30:39.546333
157	Turkmenistan	Europe	\N	2025-06-30 08:30:39.549302	2025-06-30 08:30:39.549302
158	Uganda	Africa	\N	2025-06-30 08:30:39.552128	2025-06-30 08:30:39.552128
159	Ukraine	Europe	\N	2025-06-30 08:30:39.555065	2025-06-30 08:30:39.555065
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-30 08:30:39.561301	2025-06-30 08:30:39.561301
161	United Kingdom	Europe	\N	2025-06-30 08:30:39.564864	2025-06-30 08:30:39.564864
162	Tanzania	Africa	\N	2025-06-30 08:30:39.569071	2025-06-30 08:30:39.569071
163	United States	Americas	\N	2025-06-30 08:30:39.573732	2025-06-30 08:30:39.573732
164	Uruguay	Americas	\N	2025-06-30 08:30:39.57811	2025-06-30 08:30:39.57811
165	Uzbekistan	Europe	\N	2025-06-30 08:30:39.58486	2025-06-30 08:30:39.58486
166	Venezuela	Americas	\N	2025-06-30 08:30:39.58759	2025-06-30 08:30:39.58759
167	Viet Nam	Western Pacific	\N	2025-06-30 08:30:39.591838	2025-06-30 08:30:39.591838
168	Yemen	Eastern Mediterranean	\N	2025-06-30 08:30:39.595952	2025-06-30 08:30:39.595952
169	Zambia	Africa	\N	2025-06-30 08:30:39.599224	2025-06-30 08:30:39.599224
170	Zimbabwe	Africa	\N	2025-06-30 08:30:39.603227	2025-06-30 08:30:39.603227
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.607783	2025-06-30 08:30:39.607783
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.615798	2025-06-30 08:30:39.615798
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.621914	2025-06-30 08:30:39.621914
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.626292	2025-06-30 08:30:39.626292
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.630962	2025-06-30 08:30:39.630962
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.636003	2025-06-30 08:30:39.636003
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.640237	2025-06-30 08:30:39.640237
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.644733	2025-06-30 08:30:39.644733
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.649047	2025-06-30 08:30:39.649047
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.657378	2025-06-30 08:30:39.657378
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.661775	2025-06-30 08:30:39.661775
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.668021	2025-06-30 08:30:39.668021
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.670671	2025-06-30 08:30:39.670671
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.673241	2025-06-30 08:30:39.673241
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.677424	2025-06-30 08:30:39.677424
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.679914	2025-06-30 08:30:39.679914
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.683961	2025-06-30 08:30:39.683961
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.68654	2025-06-30 08:30:39.68654
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.689246	2025-06-30 08:30:39.689246
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.691794	2025-06-30 08:30:39.691794
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.696294	2025-06-30 08:30:39.696294
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.699003	2025-06-30 08:30:39.699003
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.701682	2025-06-30 08:30:39.701682
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.706006	2025-06-30 08:30:39.706006
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.710379	2025-06-30 08:30:39.710379
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.714696	2025-06-30 08:30:39.714696
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.717446	2025-06-30 08:30:39.717446
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.720132	2025-06-30 08:30:39.720132
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.722926	2025-06-30 08:30:39.722926
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.725606	2025-06-30 08:30:39.725606
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.732027	2025-06-30 08:30:39.732027
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.736619	2025-06-30 08:30:39.736619
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.739355	2025-06-30 08:30:39.739355
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.742012	2025-06-30 08:30:39.742012
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.746349	2025-06-30 08:30:39.746349
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.74901	2025-06-30 08:30:39.74901
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.751676	2025-06-30 08:30:39.751676
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.754348	2025-06-30 08:30:39.754348
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.756841	2025-06-30 08:30:39.756841
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.760965	2025-06-30 08:30:39.760965
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.765292	2025-06-30 08:30:39.765292
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.771627	2025-06-30 08:30:39.771627
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.775952	2025-06-30 08:30:39.775952
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.780195	2025-06-30 08:30:39.780195
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.784447	2025-06-30 08:30:39.784447
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.790448	2025-06-30 08:30:39.790448
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.79475	2025-06-30 08:30:39.79475
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.799424	2025-06-30 08:30:39.799424
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.806004	2025-06-30 08:30:39.806004
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.810517	2025-06-30 08:30:39.810517
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.816629	2025-06-30 08:30:39.816629
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.820578	2025-06-30 08:30:39.820578
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.82728	2025-06-30 08:30:39.82728
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.831104	2025-06-30 08:30:39.831104
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.835499	2025-06-30 08:30:39.835499
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.839704	2025-06-30 08:30:39.839704
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.842431	2025-06-30 08:30:39.842431
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.848675	2025-06-30 08:30:39.848675
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.855481	2025-06-30 08:30:39.855481
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.858238	2025-06-30 08:30:39.858238
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.862447	2025-06-30 08:30:39.862447
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.866537	2025-06-30 08:30:39.866537
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.870795	2025-06-30 08:30:39.870795
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.87696	2025-06-30 08:30:39.87696
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.881497	2025-06-30 08:30:39.881497
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.884215	2025-06-30 08:30:39.884215
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.886927	2025-06-30 08:30:39.886927
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.889742	2025-06-30 08:30:39.889742
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.892417	2025-06-30 08:30:39.892417
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.89672	2025-06-30 08:30:39.89672
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.899444	2025-06-30 08:30:39.899444
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.901926	2025-06-30 08:30:39.901926
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.90456	2025-06-30 08:30:39.90456
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.907262	2025-06-30 08:30:39.907262
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.909885	2025-06-30 08:30:39.909885
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.912444	2025-06-30 08:30:39.912444
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.915146	2025-06-30 08:30:39.915146
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.91951	2025-06-30 08:30:39.91951
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.923872	2025-06-30 08:30:39.923872
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.927827	2025-06-30 08:30:39.927827
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.935631	2025-06-30 08:30:39.935631
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.939748	2025-06-30 08:30:39.939748
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.942547	2025-06-30 08:30:39.942547
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.94516	2025-06-30 08:30:39.94516
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.949288	2025-06-30 08:30:39.949288
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.953853	2025-06-30 08:30:39.953853
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.958018	2025-06-30 08:30:39.958018
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.962002	2025-06-30 08:30:39.962002
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.966907	2025-06-30 08:30:39.966907
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.970672	2025-06-30 08:30:39.970672
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.975234	2025-06-30 08:30:39.975234
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.979418	2025-06-30 08:30:39.979418
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.983973	2025-06-30 08:30:39.983973
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.989944	2025-06-30 08:30:39.989944
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.994051	2025-06-30 08:30:39.994051
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:39.998452	2025-06-30 08:30:39.998452
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.004828	2025-06-30 08:30:40.004828
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.010929	2025-06-30 08:30:40.010929
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.015048	2025-06-30 08:30:40.015048
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.019293	2025-06-30 08:30:40.019293
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.025899	2025-06-30 08:30:40.025899
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.029852	2025-06-30 08:30:40.029852
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.037699	2025-06-30 08:30:40.037699
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.040428	2025-06-30 08:30:40.040428
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.046793	2025-06-30 08:30:40.046793
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.051381	2025-06-30 08:30:40.051381
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.056074	2025-06-30 08:30:40.056074
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.06022	2025-06-30 08:30:40.06022
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.063018	2025-06-30 08:30:40.063018
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.065702	2025-06-30 08:30:40.065702
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.069624	2025-06-30 08:30:40.069624
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.073885	2025-06-30 08:30:40.073885
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.078185	2025-06-30 08:30:40.078185
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.081146	2025-06-30 08:30:40.081146
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.083804	2025-06-30 08:30:40.083804
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.086343	2025-06-30 08:30:40.086343
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.088944	2025-06-30 08:30:40.088944
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.091606	2025-06-30 08:30:40.091606
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.094426	2025-06-30 08:30:40.094426
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.097107	2025-06-30 08:30:40.097107
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.101277	2025-06-30 08:30:40.101277
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.103871	2025-06-30 08:30:40.103871
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.106419	2025-06-30 08:30:40.106419
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.110955	2025-06-30 08:30:40.110955
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.113842	2025-06-30 08:30:40.113842
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.116605	2025-06-30 08:30:40.116605
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.119255	2025-06-30 08:30:40.119255
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.12205	2025-06-30 08:30:40.12205
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.124686	2025-06-30 08:30:40.124686
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.127413	2025-06-30 08:30:40.127413
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.132	2025-06-30 08:30:40.132
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.134833	2025-06-30 08:30:40.134833
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.137917	2025-06-30 08:30:40.137917
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.142421	2025-06-30 08:30:40.142421
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.146648	2025-06-30 08:30:40.146648
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.151133	2025-06-30 08:30:40.151133
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.155915	2025-06-30 08:30:40.155915
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.160139	2025-06-30 08:30:40.160139
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.16441	2025-06-30 08:30:40.16441
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.167368	2025-06-30 08:30:40.167368
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.170184	2025-06-30 08:30:40.170184
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.172926	2025-06-30 08:30:40.172926
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.175706	2025-06-30 08:30:40.175706
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.178361	2025-06-30 08:30:40.178361
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.180956	2025-06-30 08:30:40.180956
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.183795	2025-06-30 08:30:40.183795
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.186595	2025-06-30 08:30:40.186595
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.189237	2025-06-30 08:30:40.189237
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.191964	2025-06-30 08:30:40.191964
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.196601	2025-06-30 08:30:40.196601
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.200818	2025-06-30 08:30:40.200818
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.204702	2025-06-30 08:30:40.204702
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.209342	2025-06-30 08:30:40.209342
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.213286	2025-06-30 08:30:40.213286
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.217855	2025-06-30 08:30:40.217855
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.224336	2025-06-30 08:30:40.224336
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.228245	2025-06-30 08:30:40.228245
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.232759	2025-06-30 08:30:40.232759
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.23684	2025-06-30 08:30:40.23684
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.243364	2025-06-30 08:30:40.243364
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.247487	2025-06-30 08:30:40.247487
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.250122	2025-06-30 08:30:40.250122
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.252803	2025-06-30 08:30:40.252803
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.255385	2025-06-30 08:30:40.255385
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.258089	2025-06-30 08:30:40.258089
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.260854	2025-06-30 08:30:40.260854
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.263469	2025-06-30 08:30:40.263469
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.265983	2025-06-30 08:30:40.265983
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.268545	2025-06-30 08:30:40.268545
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.271059	2025-06-30 08:30:40.271059
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.273613	2025-06-30 08:30:40.273613
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.276237	2025-06-30 08:30:40.276237
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.278971	2025-06-30 08:30:40.278971
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.281597	2025-06-30 08:30:40.281597
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.284279	2025-06-30 08:30:40.284279
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.286984	2025-06-30 08:30:40.286984
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.291437	2025-06-30 08:30:40.291437
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.294157	2025-06-30 08:30:40.294157
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.296897	2025-06-30 08:30:40.296897
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.299477	2025-06-30 08:30:40.299477
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.305389	2025-06-30 08:30:40.305389
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.331053	2025-06-30 08:30:40.331053
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.335548	2025-06-30 08:30:40.335548
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.340128	2025-06-30 08:30:40.340128
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.346275	2025-06-30 08:30:40.346275
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.350705	2025-06-30 08:30:40.350705
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.353453	2025-06-30 08:30:40.353453
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.359729	2025-06-30 08:30:40.359729
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.365899	2025-06-30 08:30:40.365899
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.370041	2025-06-30 08:30:40.370041
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.376443	2025-06-30 08:30:40.376443
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.382422	2025-06-30 08:30:40.382422
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.385056	2025-06-30 08:30:40.385056
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.391522	2025-06-30 08:30:40.391522
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.395696	2025-06-30 08:30:40.395696
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.401752	2025-06-30 08:30:40.401752
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.41164	2025-06-30 08:30:40.41164
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.419077	2025-06-30 08:30:40.419077
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.424866	2025-06-30 08:30:40.424866
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.427284	2025-06-30 08:30:40.427284
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.433512	2025-06-30 08:30:40.433512
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.441243	2025-06-30 08:30:40.441243
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.445975	2025-06-30 08:30:40.445975
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.450794	2025-06-30 08:30:40.450794
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.455664	2025-06-30 08:30:40.455664
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.458509	2025-06-30 08:30:40.458509
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.464105	2025-06-30 08:30:40.464105
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.470097	2025-06-30 08:30:40.470097
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.474604	2025-06-30 08:30:40.474604
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.477786	2025-06-30 08:30:40.477786
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.484217	2025-06-30 08:30:40.484217
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.486938	2025-06-30 08:30:40.486938
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.49106	2025-06-30 08:30:40.49106
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.499264	2025-06-30 08:30:40.499264
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.50327	2025-06-30 08:30:40.50327
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.507802	2025-06-30 08:30:40.507802
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.51212	2025-06-30 08:30:40.51212
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.516736	2025-06-30 08:30:40.516736
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.521534	2025-06-30 08:30:40.521534
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.528268	2025-06-30 08:30:40.528268
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.531188	2025-06-30 08:30:40.531188
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.535578	2025-06-30 08:30:40.535578
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.544211	2025-06-30 08:30:40.544211
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.548095	2025-06-30 08:30:40.548095
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.552762	2025-06-30 08:30:40.552762
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.559174	2025-06-30 08:30:40.559174
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.562068	2025-06-30 08:30:40.562068
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.565231	2025-06-30 08:30:40.565231
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.567855	2025-06-30 08:30:40.567855
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.577427	2025-06-30 08:30:40.577427
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.580066	2025-06-30 08:30:40.580066
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.582846	2025-06-30 08:30:40.582846
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.585695	2025-06-30 08:30:40.585695
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.591532	2025-06-30 08:30:40.591532
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.597611	2025-06-30 08:30:40.597611
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.600138	2025-06-30 08:30:40.600138
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.609575	2025-06-30 08:30:40.609575
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.613687	2025-06-30 08:30:40.613687
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.622926	2025-06-30 08:30:40.622926
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.625421	2025-06-30 08:30:40.625421
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.631974	2025-06-30 08:30:40.631974
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.637287	2025-06-30 08:30:40.637287
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.641445	2025-06-30 08:30:40.641445
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.645427	2025-06-30 08:30:40.645427
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.649599	2025-06-30 08:30:40.649599
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.653993	2025-06-30 08:30:40.653993
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.658206	2025-06-30 08:30:40.658206
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.66256	2025-06-30 08:30:40.66256
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.668351	2025-06-30 08:30:40.668351
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.674411	2025-06-30 08:30:40.674411
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.679043	2025-06-30 08:30:40.679043
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.686178	2025-06-30 08:30:40.686178
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.688852	2025-06-30 08:30:40.688852
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.691743	2025-06-30 08:30:40.691743
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.696108	2025-06-30 08:30:40.696108
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.698848	2025-06-30 08:30:40.698848
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.70425	2025-06-30 08:30:40.70425
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.709805	2025-06-30 08:30:40.709805
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.717212	2025-06-30 08:30:40.717212
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.721541	2025-06-30 08:30:40.721541
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.72572	2025-06-30 08:30:40.72572
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.732828	2025-06-30 08:30:40.732828
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.735471	2025-06-30 08:30:40.735471
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.738037	2025-06-30 08:30:40.738037
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.742165	2025-06-30 08:30:40.742165
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.746353	2025-06-30 08:30:40.746353
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.749182	2025-06-30 08:30:40.749182
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.753494	2025-06-30 08:30:40.753494
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.756175	2025-06-30 08:30:40.756175
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.763533	2025-06-30 08:30:40.763533
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.767705	2025-06-30 08:30:40.767705
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.777514	2025-06-30 08:30:40.777514
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.784945	2025-06-30 08:30:40.784945
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.789231	2025-06-30 08:30:40.789231
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.792076	2025-06-30 08:30:40.792076
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.796534	2025-06-30 08:30:40.796534
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.801013	2025-06-30 08:30:40.801013
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.806736	2025-06-30 08:30:40.806736
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.811172	2025-06-30 08:30:40.811172
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.813684	2025-06-30 08:30:40.813684
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.824886	2025-06-30 08:30:40.824886
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.828747	2025-06-30 08:30:40.828747
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.831476	2025-06-30 08:30:40.831476
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.912144	2025-06-30 08:30:40.912144
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.945698	2025-06-30 08:30:40.945698
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.94869	2025-06-30 08:30:40.94869
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.951566	2025-06-30 08:30:40.951566
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.959389	2025-06-30 08:30:40.959389
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.963202	2025-06-30 08:30:40.963202
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.967231	2025-06-30 08:30:40.967231
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.973273	2025-06-30 08:30:40.973273
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.975923	2025-06-30 08:30:40.975923
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.980553	2025-06-30 08:30:40.980553
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.984913	2025-06-30 08:30:40.984913
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.992224	2025-06-30 08:30:40.992224
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:40.99647	2025-06-30 08:30:40.99647
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.000575	2025-06-30 08:30:41.000575
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.007691	2025-06-30 08:30:41.007691
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.010303	2025-06-30 08:30:41.010303
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.013257	2025-06-30 08:30:41.013257
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.021275	2025-06-30 08:30:41.021275
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.024157	2025-06-30 08:30:41.024157
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.026782	2025-06-30 08:30:41.026782
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:41.029363	2025-06-30 08:30:41.029363
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.033917	2025-06-30 08:30:41.033917
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.038168	2025-06-30 08:30:41.038168
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.040914	2025-06-30 08:30:41.040914
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.043626	2025-06-30 08:30:41.043626
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.050002	2025-06-30 08:30:41.050002
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.057442	2025-06-30 08:30:41.057442
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.060317	2025-06-30 08:30:41.060317
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.072177	2025-06-30 08:30:41.072177
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.076109	2025-06-30 08:30:41.076109
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.080774	2025-06-30 08:30:41.080774
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.089791	2025-06-30 08:30:41.089791
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.098197	2025-06-30 08:30:41.098197
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.102584	2025-06-30 08:30:41.102584
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.106658	2025-06-30 08:30:41.106658
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.114266	2025-06-30 08:30:41.114266
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.119029	2025-06-30 08:30:41.119029
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.127298	2025-06-30 08:30:41.127298
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.131471	2025-06-30 08:30:41.131471
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.134409	2025-06-30 08:30:41.134409
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.140655	2025-06-30 08:30:41.140655
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.143419	2025-06-30 08:30:41.143419
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.146268	2025-06-30 08:30:41.146268
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.150835	2025-06-30 08:30:41.150835
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.157149	2025-06-30 08:30:41.157149
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.162863	2025-06-30 08:30:41.162863
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.166826	2025-06-30 08:30:41.166826
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.172983	2025-06-30 08:30:41.172983
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.177228	2025-06-30 08:30:41.177228
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.179773	2025-06-30 08:30:41.179773
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.182448	2025-06-30 08:30:41.182448
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.188948	2025-06-30 08:30:41.188948
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.196823	2025-06-30 08:30:41.196823
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.203269	2025-06-30 08:30:41.203269
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.205945	2025-06-30 08:30:41.205945
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.20891	2025-06-30 08:30:41.20891
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.213235	2025-06-30 08:30:41.213235
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.223171	2025-06-30 08:30:41.223171
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.227243	2025-06-30 08:30:41.227243
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.235447	2025-06-30 08:30:41.235447
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.23827	2025-06-30 08:30:41.23827
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.242724	2025-06-30 08:30:41.242724
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.25277	2025-06-30 08:30:41.25277
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.256932	2025-06-30 08:30:41.256932
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.26507	2025-06-30 08:30:41.26507
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.269494	2025-06-30 08:30:41.269494
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.274292	2025-06-30 08:30:41.274292
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.278727	2025-06-30 08:30:41.278727
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.28336	2025-06-30 08:30:41.28336
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.286094	2025-06-30 08:30:41.286094
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.290249	2025-06-30 08:30:41.290249
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.294143	2025-06-30 08:30:41.294143
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.301719	2025-06-30 08:30:41.301719
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.304712	2025-06-30 08:30:41.304712
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.311174	2025-06-30 08:30:41.311174
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.315908	2025-06-30 08:30:41.315908
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.319912	2025-06-30 08:30:41.319912
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.323927	2025-06-30 08:30:41.323927
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.328258	2025-06-30 08:30:41.328258
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.332805	2025-06-30 08:30:41.332805
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.342956	2025-06-30 08:30:41.342956
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.345773	2025-06-30 08:30:41.345773
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.349006	2025-06-30 08:30:41.349006
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.355564	2025-06-30 08:30:41.355564
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.358738	2025-06-30 08:30:41.358738
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.364935	2025-06-30 08:30:41.364935
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.367689	2025-06-30 08:30:41.367689
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.378818	2025-06-30 08:30:41.378818
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.38681	2025-06-30 08:30:41.38681
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.389613	2025-06-30 08:30:41.389613
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.394133	2025-06-30 08:30:41.394133
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.398532	2025-06-30 08:30:41.398532
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.406511	2025-06-30 08:30:41.406511
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.411287	2025-06-30 08:30:41.411287
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.415495	2025-06-30 08:30:41.415495
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.421636	2025-06-30 08:30:41.421636
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.426542	2025-06-30 08:30:41.426542
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.434998	2025-06-30 08:30:41.434998
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.440895	2025-06-30 08:30:41.440895
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.44677	2025-06-30 08:30:41.44677
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.452531	2025-06-30 08:30:41.452531
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.458454	2025-06-30 08:30:41.458454
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.464702	2025-06-30 08:30:41.464702
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.468805	2025-06-30 08:30:41.468805
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.475359	2025-06-30 08:30:41.475359
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.481193	2025-06-30 08:30:41.481193
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.487027	2025-06-30 08:30:41.487027
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.492853	2025-06-30 08:30:41.492853
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.495566	2025-06-30 08:30:41.495566
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.501115	2025-06-30 08:30:41.501115
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.505078	2025-06-30 08:30:41.505078
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.511432	2025-06-30 08:30:41.511432
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.517198	2025-06-30 08:30:41.517198
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.523323	2025-06-30 08:30:41.523323
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.529374	2025-06-30 08:30:41.529374
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.533575	2025-06-30 08:30:41.533575
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.542182	2025-06-30 08:30:41.542182
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.548085	2025-06-30 08:30:41.548085
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.554071	2025-06-30 08:30:41.554071
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.559955	2025-06-30 08:30:41.559955
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.56574	2025-06-30 08:30:41.56574
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.569949	2025-06-30 08:30:41.569949
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.576316	2025-06-30 08:30:41.576316
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.58238	2025-06-30 08:30:41.58238
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.590387	2025-06-30 08:30:41.590387
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.596342	2025-06-30 08:30:41.596342
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.602187	2025-06-30 08:30:41.602187
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.608031	2025-06-30 08:30:41.608031
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.611901	2025-06-30 08:30:41.611901
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.614595	2025-06-30 08:30:41.614595
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.620387	2025-06-30 08:30:41.620387
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.624588	2025-06-30 08:30:41.624588
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.628754	2025-06-30 08:30:41.628754
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.633025	2025-06-30 08:30:41.633025
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.637132	2025-06-30 08:30:41.637132
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.64141	2025-06-30 08:30:41.64141
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.64568	2025-06-30 08:30:41.64568
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.651918	2025-06-30 08:30:41.651918
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.655975	2025-06-30 08:30:41.655975
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.660201	2025-06-30 08:30:41.660201
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.664717	2025-06-30 08:30:41.664717
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.670644	2025-06-30 08:30:41.670644
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.674735	2025-06-30 08:30:41.674735
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.678594	2025-06-30 08:30:41.678594
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.681349	2025-06-30 08:30:41.681349
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.683999	2025-06-30 08:30:41.683999
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.686606	2025-06-30 08:30:41.686606
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.689116	2025-06-30 08:30:41.689116
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.693503	2025-06-30 08:30:41.693503
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.699338	2025-06-30 08:30:41.699338
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.703652	2025-06-30 08:30:41.703652
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.707937	2025-06-30 08:30:41.707937
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.713945	2025-06-30 08:30:41.713945
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.719825	2025-06-30 08:30:41.719825
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.725835	2025-06-30 08:30:41.725835
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.731766	2025-06-30 08:30:41.731766
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.737695	2025-06-30 08:30:41.737695
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.743368	2025-06-30 08:30:41.743368
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.749527	2025-06-30 08:30:41.749527
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.757377	2025-06-30 08:30:41.757377
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.761416	2025-06-30 08:30:41.761416
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.769841	2025-06-30 08:30:41.769841
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.773898	2025-06-30 08:30:41.773898
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.776705	2025-06-30 08:30:41.776705
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.781295	2025-06-30 08:30:41.781295
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.78792	2025-06-30 08:30:41.78792
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.794176	2025-06-30 08:30:41.794176
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.796793	2025-06-30 08:30:41.796793
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.803003	2025-06-30 08:30:41.803003
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.807581	2025-06-30 08:30:41.807581
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.812122	2025-06-30 08:30:41.812122
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.81656	2025-06-30 08:30:41.81656
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.820868	2025-06-30 08:30:41.820868
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.825241	2025-06-30 08:30:41.825241
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.829428	2025-06-30 08:30:41.829428
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.833577	2025-06-30 08:30:41.833577
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.837877	2025-06-30 08:30:41.837877
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.842312	2025-06-30 08:30:41.842312
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.846768	2025-06-30 08:30:41.846768
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.851181	2025-06-30 08:30:41.851181
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.855441	2025-06-30 08:30:41.855441
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.859379	2025-06-30 08:30:41.859379
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.863444	2025-06-30 08:30:41.863444
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.867673	2025-06-30 08:30:41.867673
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.872315	2025-06-30 08:30:41.872315
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.876697	2025-06-30 08:30:41.876697
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.881225	2025-06-30 08:30:41.881225
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.885862	2025-06-30 08:30:41.885862
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.890222	2025-06-30 08:30:41.890222
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.894704	2025-06-30 08:30:41.894704
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.899211	2025-06-30 08:30:41.899211
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.90389	2025-06-30 08:30:41.90389
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.908332	2025-06-30 08:30:41.908332
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.912676	2025-06-30 08:30:41.912676
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.917104	2025-06-30 08:30:41.917104
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.921513	2025-06-30 08:30:41.921513
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.925801	2025-06-30 08:30:41.925801
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.929962	2025-06-30 08:30:41.929962
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.934426	2025-06-30 08:30:41.934426
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.938705	2025-06-30 08:30:41.938705
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.943337	2025-06-30 08:30:41.943337
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.947871	2025-06-30 08:30:41.947871
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.954149	2025-06-30 08:30:41.954149
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.960254	2025-06-30 08:30:41.960254
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.966403	2025-06-30 08:30:41.966403
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.972559	2025-06-30 08:30:41.972559
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.978584	2025-06-30 08:30:41.978584
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.985125	2025-06-30 08:30:41.985125
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.991688	2025-06-30 08:30:41.991688
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:41.999798	2025-06-30 08:30:41.999798
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.006069	2025-06-30 08:30:42.006069
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.012018	2025-06-30 08:30:42.012018
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.018202	2025-06-30 08:30:42.018202
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.021078	2025-06-30 08:30:42.021078
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.023811	2025-06-30 08:30:42.023811
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.030358	2025-06-30 08:30:42.030358
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.034667	2025-06-30 08:30:42.034667
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.039045	2025-06-30 08:30:42.039045
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.043511	2025-06-30 08:30:42.043511
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.047914	2025-06-30 08:30:42.047914
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.052476	2025-06-30 08:30:42.052476
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.057149	2025-06-30 08:30:42.057149
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.065701	2025-06-30 08:30:42.065701
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.091179	2025-06-30 08:30:42.091179
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.097286	2025-06-30 08:30:42.097286
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.101479	2025-06-30 08:30:42.101479
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.104007	2025-06-30 08:30:42.104007
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.109524	2025-06-30 08:30:42.109524
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.113408	2025-06-30 08:30:42.113408
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.123193	2025-06-30 08:30:42.123193
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.128545	2025-06-30 08:30:42.128545
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.132484	2025-06-30 08:30:42.132484
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.136565	2025-06-30 08:30:42.136565
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.14144	2025-06-30 08:30:42.14144
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.148291	2025-06-30 08:30:42.148291
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.155808	2025-06-30 08:30:42.155808
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.160119	2025-06-30 08:30:42.160119
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.164486	2025-06-30 08:30:42.164486
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.170269	2025-06-30 08:30:42.170269
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.175934	2025-06-30 08:30:42.175934
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.181623	2025-06-30 08:30:42.181623
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.18747	2025-06-30 08:30:42.18747
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.195594	2025-06-30 08:30:42.195594
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.201191	2025-06-30 08:30:42.201191
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.209004	2025-06-30 08:30:42.209004
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.216689	2025-06-30 08:30:42.216689
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.219551	2025-06-30 08:30:42.219551
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.225248	2025-06-30 08:30:42.225248
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.235874	2025-06-30 08:30:42.235874
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.241646	2025-06-30 08:30:42.241646
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.248289	2025-06-30 08:30:42.248289
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.254155	2025-06-30 08:30:42.254155
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.262806	2025-06-30 08:30:42.262806
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.268663	2025-06-30 08:30:42.268663
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.274525	2025-06-30 08:30:42.274525
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.280203	2025-06-30 08:30:42.280203
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.287992	2025-06-30 08:30:42.287992
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.295502	2025-06-30 08:30:42.295502
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.303211	2025-06-30 08:30:42.303211
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.310588	2025-06-30 08:30:42.310588
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.316775	2025-06-30 08:30:42.316775
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.324224	2025-06-30 08:30:42.324224
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.329934	2025-06-30 08:30:42.329934
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.337757	2025-06-30 08:30:42.337757
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.343481	2025-06-30 08:30:42.343481
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.351291	2025-06-30 08:30:42.351291
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.357245	2025-06-30 08:30:42.357245
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.364286	2025-06-30 08:30:42.364286
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.370244	2025-06-30 08:30:42.370244
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.375988	2025-06-30 08:30:42.375988
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.38184	2025-06-30 08:30:42.38184
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.385761	2025-06-30 08:30:42.385761
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.39193	2025-06-30 08:30:42.39193
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.399018	2025-06-30 08:30:42.399018
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.40634	2025-06-30 08:30:42.40634
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.413739	2025-06-30 08:30:42.413739
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.420407	2025-06-30 08:30:42.420407
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.429364	2025-06-30 08:30:42.429364
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.436029	2025-06-30 08:30:42.436029
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.460378	2025-06-30 08:30:42.460378
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.467123	2025-06-30 08:30:42.467123
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.472261	2025-06-30 08:30:42.472261
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.478629	2025-06-30 08:30:42.478629
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.485654	2025-06-30 08:30:42.485654
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.504463	2025-06-30 08:30:42.504463
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.51089	2025-06-30 08:30:42.51089
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.517427	2025-06-30 08:30:42.517427
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.524373	2025-06-30 08:30:42.524373
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.531197	2025-06-30 08:30:42.531197
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.537871	2025-06-30 08:30:42.537871
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.54554	2025-06-30 08:30:42.54554
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.5521	2025-06-30 08:30:42.5521
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.559047	2025-06-30 08:30:42.559047
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.565538	2025-06-30 08:30:42.565538
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.572461	2025-06-30 08:30:42.572461
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.579178	2025-06-30 08:30:42.579178
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.585956	2025-06-30 08:30:42.585956
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.592682	2025-06-30 08:30:42.592682
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.599619	2025-06-30 08:30:42.599619
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.607752	2025-06-30 08:30:42.607752
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.615159	2025-06-30 08:30:42.615159
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.623491	2025-06-30 08:30:42.623491
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.630087	2025-06-30 08:30:42.630087
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.636594	2025-06-30 08:30:42.636594
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.656117	2025-06-30 08:30:42.656117
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.671524	2025-06-30 08:30:42.671524
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.681376	2025-06-30 08:30:42.681376
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.688303	2025-06-30 08:30:42.688303
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.694865	2025-06-30 08:30:42.694865
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.701219	2025-06-30 08:30:42.701219
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.709427	2025-06-30 08:30:42.709427
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.716307	2025-06-30 08:30:42.716307
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.722425	2025-06-30 08:30:42.722425
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.729293	2025-06-30 08:30:42.729293
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.736613	2025-06-30 08:30:42.736613
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.74432	2025-06-30 08:30:42.74432
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.750846	2025-06-30 08:30:42.750846
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.757485	2025-06-30 08:30:42.757485
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.764473	2025-06-30 08:30:42.764473
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.771247	2025-06-30 08:30:42.771247
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.778355	2025-06-30 08:30:42.778355
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.785512	2025-06-30 08:30:42.785512
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.793219	2025-06-30 08:30:42.793219
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.800285	2025-06-30 08:30:42.800285
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.808732	2025-06-30 08:30:42.808732
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.816896	2025-06-30 08:30:42.816896
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.823532	2025-06-30 08:30:42.823532
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.836885	2025-06-30 08:30:42.836885
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.843191	2025-06-30 08:30:42.843191
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.850402	2025-06-30 08:30:42.850402
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.857948	2025-06-30 08:30:42.857948
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.867835	2025-06-30 08:30:42.867835
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.877158	2025-06-30 08:30:42.877158
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.885578	2025-06-30 08:30:42.885578
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.892538	2025-06-30 08:30:42.892538
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.899176	2025-06-30 08:30:42.899176
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.9061	2025-06-30 08:30:42.9061
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.913061	2025-06-30 08:30:42.913061
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.920806	2025-06-30 08:30:42.920806
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.928144	2025-06-30 08:30:42.928144
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.942786	2025-06-30 08:30:42.942786
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.950054	2025-06-30 08:30:42.950054
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.959137	2025-06-30 08:30:42.959137
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.974925	2025-06-30 08:30:42.974925
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:42.982998	2025-06-30 08:30:42.982998
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.016608	2025-06-30 08:30:43.016608
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.027135	2025-06-30 08:30:43.027135
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.034622	2025-06-30 08:30:43.034622
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.043714	2025-06-30 08:30:43.043714
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.051651	2025-06-30 08:30:43.051651
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.060176	2025-06-30 08:30:43.060176
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.066922	2025-06-30 08:30:43.066922
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.07349	2025-06-30 08:30:43.07349
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.080317	2025-06-30 08:30:43.080317
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.087198	2025-06-30 08:30:43.087198
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.09423	2025-06-30 08:30:43.09423
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.101411	2025-06-30 08:30:43.101411
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.108332	2025-06-30 08:30:43.108332
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.115283	2025-06-30 08:30:43.115283
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.124278	2025-06-30 08:30:43.124278
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.13258	2025-06-30 08:30:43.13258
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.172609	2025-06-30 08:30:43.172609
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.223695	2025-06-30 08:30:43.223695
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.285358	2025-06-30 08:30:43.285358
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.323987	2025-06-30 08:30:43.323987
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.330936	2025-06-30 08:30:43.330936
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.33787	2025-06-30 08:30:43.33787
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.344997	2025-06-30 08:30:43.344997
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.38432	2025-06-30 08:30:43.38432
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.392779	2025-06-30 08:30:43.392779
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.40174	2025-06-30 08:30:43.40174
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.40906	2025-06-30 08:30:43.40906
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.417831	2025-06-30 08:30:43.417831
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.437539	2025-06-30 08:30:43.437539
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.454063	2025-06-30 08:30:43.454063
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.487281	2025-06-30 08:30:43.487281
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.532638	2025-06-30 08:30:43.532638
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.541245	2025-06-30 08:30:43.541245
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.559345	2025-06-30 08:30:43.559345
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.60631	2025-06-30 08:30:43.60631
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.638647	2025-06-30 08:30:43.638647
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.645957	2025-06-30 08:30:43.645957
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.653083	2025-06-30 08:30:43.653083
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.659986	2025-06-30 08:30:43.659986
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.666951	2025-06-30 08:30:43.666951
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.674564	2025-06-30 08:30:43.674564
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.683294	2025-06-30 08:30:43.683294
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.693312	2025-06-30 08:30:43.693312
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.701696	2025-06-30 08:30:43.701696
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.708942	2025-06-30 08:30:43.708942
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.716389	2025-06-30 08:30:43.716389
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.723403	2025-06-30 08:30:43.723403
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.730467	2025-06-30 08:30:43.730467
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.737308	2025-06-30 08:30:43.737308
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.745381	2025-06-30 08:30:43.745381
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.753069	2025-06-30 08:30:43.753069
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.760104	2025-06-30 08:30:43.760104
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.77534	2025-06-30 08:30:43.77534
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.792102	2025-06-30 08:30:43.792102
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.799021	2025-06-30 08:30:43.799021
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.805658	2025-06-30 08:30:43.805658
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.815134	2025-06-30 08:30:43.815134
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.824057	2025-06-30 08:30:43.824057
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.832098	2025-06-30 08:30:43.832098
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.850567	2025-06-30 08:30:43.850567
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.865966	2025-06-30 08:30:43.865966
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.873361	2025-06-30 08:30:43.873361
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.880203	2025-06-30 08:30:43.880203
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.88819	2025-06-30 08:30:43.88819
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.895324	2025-06-30 08:30:43.895324
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.902446	2025-06-30 08:30:43.902446
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.911539	2025-06-30 08:30:43.911539
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.920317	2025-06-30 08:30:43.920317
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.927232	2025-06-30 08:30:43.927232
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.93557	2025-06-30 08:30:43.93557
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.942581	2025-06-30 08:30:43.942581
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.94988	2025-06-30 08:30:43.94988
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.957711	2025-06-30 08:30:43.957711
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.964225	2025-06-30 08:30:43.964225
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.970856	2025-06-30 08:30:43.970856
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.978198	2025-06-30 08:30:43.978198
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:43.98588	2025-06-30 08:30:43.98588
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.007892	2025-06-30 08:30:44.007892
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.014398	2025-06-30 08:30:44.014398
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.02081	2025-06-30 08:30:44.02081
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.028629	2025-06-30 08:30:44.028629
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.038916	2025-06-30 08:30:44.038916
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.045605	2025-06-30 08:30:44.045605
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.053322	2025-06-30 08:30:44.053322
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.060069	2025-06-30 08:30:44.060069
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.0989	2025-06-30 08:30:44.0989
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.111859	2025-06-30 08:30:44.111859
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.140462	2025-06-30 08:30:44.140462
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.149647	2025-06-30 08:30:44.149647
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.166716	2025-06-30 08:30:44.166716
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.17321	2025-06-30 08:30:44.17321
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.180117	2025-06-30 08:30:44.180117
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:44.187347	2025-06-30 08:30:44.187347
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.195348	2025-06-30 08:30:44.195348
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.202073	2025-06-30 08:30:44.202073
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.218718	2025-06-30 08:30:44.218718
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.228738	2025-06-30 08:30:44.228738
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.236199	2025-06-30 08:30:44.236199
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.243653	2025-06-30 08:30:44.243653
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.250994	2025-06-30 08:30:44.250994
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.258172	2025-06-30 08:30:44.258172
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.268038	2025-06-30 08:30:44.268038
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.275348	2025-06-30 08:30:44.275348
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.283554	2025-06-30 08:30:44.283554
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.2906	2025-06-30 08:30:44.2906
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.297336	2025-06-30 08:30:44.297336
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.304418	2025-06-30 08:30:44.304418
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.313031	2025-06-30 08:30:44.313031
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.360746	2025-06-30 08:30:44.360746
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.368005	2025-06-30 08:30:44.368005
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.375273	2025-06-30 08:30:44.375273
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.382012	2025-06-30 08:30:44.382012
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.394206	2025-06-30 08:30:44.394206
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.401941	2025-06-30 08:30:44.401941
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.410377	2025-06-30 08:30:44.410377
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.418561	2025-06-30 08:30:44.418561
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.426001	2025-06-30 08:30:44.426001
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.432684	2025-06-30 08:30:44.432684
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.441392	2025-06-30 08:30:44.441392
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.448501	2025-06-30 08:30:44.448501
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.455766	2025-06-30 08:30:44.455766
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.463967	2025-06-30 08:30:44.463967
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.471488	2025-06-30 08:30:44.471488
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.480037	2025-06-30 08:30:44.480037
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.490088	2025-06-30 08:30:44.490088
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.498109	2025-06-30 08:30:44.498109
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.506033	2025-06-30 08:30:44.506033
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.512771	2025-06-30 08:30:44.512771
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.520453	2025-06-30 08:30:44.520453
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.528562	2025-06-30 08:30:44.528562
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.536689	2025-06-30 08:30:44.536689
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.544067	2025-06-30 08:30:44.544067
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.551174	2025-06-30 08:30:44.551174
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.559627	2025-06-30 08:30:44.559627
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.566402	2025-06-30 08:30:44.566402
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.57469	2025-06-30 08:30:44.57469
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.583258	2025-06-30 08:30:44.583258
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.590618	2025-06-30 08:30:44.590618
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.597657	2025-06-30 08:30:44.597657
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.61631	2025-06-30 08:30:44.61631
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.668231	2025-06-30 08:30:44.668231
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.687415	2025-06-30 08:30:44.687415
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.697069	2025-06-30 08:30:44.697069
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.704073	2025-06-30 08:30:44.704073
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.716702	2025-06-30 08:30:44.716702
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.723562	2025-06-30 08:30:44.723562
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.731433	2025-06-30 08:30:44.731433
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.739916	2025-06-30 08:30:44.739916
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.748137	2025-06-30 08:30:44.748137
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.754753	2025-06-30 08:30:44.754753
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.763616	2025-06-30 08:30:44.763616
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.770926	2025-06-30 08:30:44.770926
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.778493	2025-06-30 08:30:44.778493
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.786288	2025-06-30 08:30:44.786288
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.793565	2025-06-30 08:30:44.793565
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.801629	2025-06-30 08:30:44.801629
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.809222	2025-06-30 08:30:44.809222
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.816786	2025-06-30 08:30:44.816786
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.824418	2025-06-30 08:30:44.824418
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.833265	2025-06-30 08:30:44.833265
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.846355	2025-06-30 08:30:44.846355
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.853766	2025-06-30 08:30:44.853766
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.86177	2025-06-30 08:30:44.86177
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.87044	2025-06-30 08:30:44.87044
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.877472	2025-06-30 08:30:44.877472
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.88475	2025-06-30 08:30:44.88475
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.891838	2025-06-30 08:30:44.891838
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.899513	2025-06-30 08:30:44.899513
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.907055	2025-06-30 08:30:44.907055
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.9143	2025-06-30 08:30:44.9143
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.922105	2025-06-30 08:30:44.922105
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.930114	2025-06-30 08:30:44.930114
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.937744	2025-06-30 08:30:44.937744
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.945742	2025-06-30 08:30:44.945742
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.954148	2025-06-30 08:30:44.954148
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.962736	2025-06-30 08:30:44.962736
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.971298	2025-06-30 08:30:44.971298
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.978852	2025-06-30 08:30:44.978852
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.986611	2025-06-30 08:30:44.986611
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:44.99571	2025-06-30 08:30:44.99571
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.006767	2025-06-30 08:30:45.006767
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.015915	2025-06-30 08:30:45.015915
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.023693	2025-06-30 08:30:45.023693
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.032054	2025-06-30 08:30:45.032054
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.039501	2025-06-30 08:30:45.039501
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.047215	2025-06-30 08:30:45.047215
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.055783	2025-06-30 08:30:45.055783
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.072125	2025-06-30 08:30:45.072125
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.081974	2025-06-30 08:30:45.081974
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.088905	2025-06-30 08:30:45.088905
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.096896	2025-06-30 08:30:45.096896
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.103643	2025-06-30 08:30:45.103643
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.12167	2025-06-30 08:30:45.12167
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.143538	2025-06-30 08:30:45.143538
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.151791	2025-06-30 08:30:45.151791
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.160244	2025-06-30 08:30:45.160244
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.166615	2025-06-30 08:30:45.166615
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.17371	2025-06-30 08:30:45.17371
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.181282	2025-06-30 08:30:45.181282
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.189588	2025-06-30 08:30:45.189588
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.197453	2025-06-30 08:30:45.197453
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.206799	2025-06-30 08:30:45.206799
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.214227	2025-06-30 08:30:45.214227
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.221407	2025-06-30 08:30:45.221407
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.228864	2025-06-30 08:30:45.228864
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.253266	2025-06-30 08:30:45.253266
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.261618	2025-06-30 08:30:45.261618
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.268516	2025-06-30 08:30:45.268516
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.275843	2025-06-30 08:30:45.275843
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.282423	2025-06-30 08:30:45.282423
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.289679	2025-06-30 08:30:45.289679
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.300811	2025-06-30 08:30:45.300811
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.309	2025-06-30 08:30:45.309
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.317903	2025-06-30 08:30:45.317903
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.329645	2025-06-30 08:30:45.329645
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.338831	2025-06-30 08:30:45.338831
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.346209	2025-06-30 08:30:45.346209
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.355182	2025-06-30 08:30:45.355182
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.362134	2025-06-30 08:30:45.362134
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.381077	2025-06-30 08:30:45.381077
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.398463	2025-06-30 08:30:45.398463
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.40627	2025-06-30 08:30:45.40627
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.41338	2025-06-30 08:30:45.41338
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.420349	2025-06-30 08:30:45.420349
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.42899	2025-06-30 08:30:45.42899
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.437391	2025-06-30 08:30:45.437391
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.445001	2025-06-30 08:30:45.445001
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.452639	2025-06-30 08:30:45.452639
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.460868	2025-06-30 08:30:45.460868
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.46856	2025-06-30 08:30:45.46856
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.491199	2025-06-30 08:30:45.491199
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.504138	2025-06-30 08:30:45.504138
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.545735	2025-06-30 08:30:45.545735
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.552174	2025-06-30 08:30:45.552174
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.560589	2025-06-30 08:30:45.560589
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.567718	2025-06-30 08:30:45.567718
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.575347	2025-06-30 08:30:45.575347
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.582755	2025-06-30 08:30:45.582755
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.590734	2025-06-30 08:30:45.590734
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.598176	2025-06-30 08:30:45.598176
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.606997	2025-06-30 08:30:45.606997
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.614089	2025-06-30 08:30:45.614089
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.620721	2025-06-30 08:30:45.620721
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.629193	2025-06-30 08:30:45.629193
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.637065	2025-06-30 08:30:45.637065
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.645147	2025-06-30 08:30:45.645147
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.652412	2025-06-30 08:30:45.652412
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.660115	2025-06-30 08:30:45.660115
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.667329	2025-06-30 08:30:45.667329
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.674461	2025-06-30 08:30:45.674461
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.683737	2025-06-30 08:30:45.683737
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.692351	2025-06-30 08:30:45.692351
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.699445	2025-06-30 08:30:45.699445
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.706449	2025-06-30 08:30:45.706449
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.714419	2025-06-30 08:30:45.714419
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.730089	2025-06-30 08:30:45.730089
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.738155	2025-06-30 08:30:45.738155
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.746326	2025-06-30 08:30:45.746326
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.754482	2025-06-30 08:30:45.754482
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.77713	2025-06-30 08:30:45.77713
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.785131	2025-06-30 08:30:45.785131
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.792668	2025-06-30 08:30:45.792668
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.800608	2025-06-30 08:30:45.800608
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.832997	2025-06-30 08:30:45.832997
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.840856	2025-06-30 08:30:45.840856
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.889819	2025-06-30 08:30:45.889819
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.897365	2025-06-30 08:30:45.897365
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.935679	2025-06-30 08:30:45.935679
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.943099	2025-06-30 08:30:45.943099
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.979033	2025-06-30 08:30:45.979033
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.986017	2025-06-30 08:30:45.986017
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:45.993349	2025-06-30 08:30:45.993349
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.001459	2025-06-30 08:30:46.001459
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.00881	2025-06-30 08:30:46.00881
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.015694	2025-06-30 08:30:46.015694
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.024239	2025-06-30 08:30:46.024239
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.033108	2025-06-30 08:30:46.033108
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.041016	2025-06-30 08:30:46.041016
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.050734	2025-06-30 08:30:46.050734
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.059217	2025-06-30 08:30:46.059217
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.068642	2025-06-30 08:30:46.068642
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.07847	2025-06-30 08:30:46.07847
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.085999	2025-06-30 08:30:46.085999
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.092833	2025-06-30 08:30:46.092833
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.100481	2025-06-30 08:30:46.100481
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.110218	2025-06-30 08:30:46.110218
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.119292	2025-06-30 08:30:46.119292
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.134234	2025-06-30 08:30:46.134234
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.141239	2025-06-30 08:30:46.141239
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.16218	2025-06-30 08:30:46.16218
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.208555	2025-06-30 08:30:46.208555
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.237321	2025-06-30 08:30:46.237321
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.247702	2025-06-30 08:30:46.247702
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.255359	2025-06-30 08:30:46.255359
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.263208	2025-06-30 08:30:46.263208
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.271548	2025-06-30 08:30:46.271548
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.29703	2025-06-30 08:30:46.29703
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.304272	2025-06-30 08:30:46.304272
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.312924	2025-06-30 08:30:46.312924
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.335394	2025-06-30 08:30:46.335394
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.344242	2025-06-30 08:30:46.344242
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.372188	2025-06-30 08:30:46.372188
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.380047	2025-06-30 08:30:46.380047
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.409734	2025-06-30 08:30:46.409734
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.429851	2025-06-30 08:30:46.429851
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.438939	2025-06-30 08:30:46.438939
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.457625	2025-06-30 08:30:46.457625
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.465492	2025-06-30 08:30:46.465492
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.473586	2025-06-30 08:30:46.473586
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.480608	2025-06-30 08:30:46.480608
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.489208	2025-06-30 08:30:46.489208
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.556239	2025-06-30 08:30:46.556239
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.565082	2025-06-30 08:30:46.565082
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.572353	2025-06-30 08:30:46.572353
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.592857	2025-06-30 08:30:46.592857
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.6094	2025-06-30 08:30:46.6094
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.617571	2025-06-30 08:30:46.617571
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.625426	2025-06-30 08:30:46.625426
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.63456	2025-06-30 08:30:46.63456
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.641914	2025-06-30 08:30:46.641914
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.650481	2025-06-30 08:30:46.650481
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.658314	2025-06-30 08:30:46.658314
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.666879	2025-06-30 08:30:46.666879
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.72049	2025-06-30 08:30:46.72049
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.81063	2025-06-30 08:30:46.81063
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.870683	2025-06-30 08:30:46.870683
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.878241	2025-06-30 08:30:46.878241
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.886714	2025-06-30 08:30:46.886714
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.925194	2025-06-30 08:30:46.925194
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.933056	2025-06-30 08:30:46.933056
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.972589	2025-06-30 08:30:46.972589
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.980711	2025-06-30 08:30:46.980711
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.988785	2025-06-30 08:30:46.988785
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:46.996292	2025-06-30 08:30:46.996292
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.010394	2025-06-30 08:30:47.010394
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.018221	2025-06-30 08:30:47.018221
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.036783	2025-06-30 08:30:47.036783
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.045288	2025-06-30 08:30:47.045288
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.079761	2025-06-30 08:30:47.079761
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.087081	2025-06-30 08:30:47.087081
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.096627	2025-06-30 08:30:47.096627
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.127035	2025-06-30 08:30:47.127035
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.135019	2025-06-30 08:30:47.135019
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.165271	2025-06-30 08:30:47.165271
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.182381	2025-06-30 08:30:47.182381
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.205208	2025-06-30 08:30:47.205208
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.215078	2025-06-30 08:30:47.215078
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.237728	2025-06-30 08:30:47.237728
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.245717	2025-06-30 08:30:47.245717
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.286557	2025-06-30 08:30:47.286557
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.303695	2025-06-30 08:30:47.303695
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.311553	2025-06-30 08:30:47.311553
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.319907	2025-06-30 08:30:47.319907
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.327667	2025-06-30 08:30:47.327667
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.338014	2025-06-30 08:30:47.338014
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.345522	2025-06-30 08:30:47.345522
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.356494	2025-06-30 08:30:47.356494
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.363942	2025-06-30 08:30:47.363942
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.380109	2025-06-30 08:30:47.380109
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.390658	2025-06-30 08:30:47.390658
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.399666	2025-06-30 08:30:47.399666
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.408615	2025-06-30 08:30:47.408615
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.415799	2025-06-30 08:30:47.415799
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.464258	2025-06-30 08:30:47.464258
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.503479	2025-06-30 08:30:47.503479
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.514663	2025-06-30 08:30:47.514663
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.554582	2025-06-30 08:30:47.554582
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.562262	2025-06-30 08:30:47.562262
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.571105	2025-06-30 08:30:47.571105
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.579122	2025-06-30 08:30:47.579122
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.588125	2025-06-30 08:30:47.588125
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.612125	2025-06-30 08:30:47.612125
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.62064	2025-06-30 08:30:47.62064
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.659849	2025-06-30 08:30:47.659849
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.668916	2025-06-30 08:30:47.668916
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.707768	2025-06-30 08:30:47.707768
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.718584	2025-06-30 08:30:47.718584
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.772021	2025-06-30 08:30:47.772021
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.783612	2025-06-30 08:30:47.783612
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.824707	2025-06-30 08:30:47.824707
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.834965	2025-06-30 08:30:47.834965
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.842211	2025-06-30 08:30:47.842211
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.850378	2025-06-30 08:30:47.850378
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.858065	2025-06-30 08:30:47.858065
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.869429	2025-06-30 08:30:47.869429
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.876547	2025-06-30 08:30:47.876547
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.892285	2025-06-30 08:30:47.892285
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.90078	2025-06-30 08:30:47.90078
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.908933	2025-06-30 08:30:47.908933
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.91825	2025-06-30 08:30:47.91825
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.939603	2025-06-30 08:30:47.939603
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.957852	2025-06-30 08:30:47.957852
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.965047	2025-06-30 08:30:47.965047
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.97434	2025-06-30 08:30:47.97434
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.983181	2025-06-30 08:30:47.983181
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.992141	2025-06-30 08:30:47.992141
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:47.999797	2025-06-30 08:30:47.999797
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.006957	2025-06-30 08:30:48.006957
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.015451	2025-06-30 08:30:48.015451
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.024621	2025-06-30 08:30:48.024621
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.034968	2025-06-30 08:30:48.034968
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.042923	2025-06-30 08:30:48.042923
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.051249	2025-06-30 08:30:48.051249
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.058421	2025-06-30 08:30:48.058421
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.067062	2025-06-30 08:30:48.067062
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.076161	2025-06-30 08:30:48.076161
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.08416	2025-06-30 08:30:48.08416
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.096849	2025-06-30 08:30:48.096849
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.119991	2025-06-30 08:30:48.119991
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.127945	2025-06-30 08:30:48.127945
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.135735	2025-06-30 08:30:48.135735
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.226454	2025-06-30 08:30:48.226454
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.248553	2025-06-30 08:30:48.248553
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.302369	2025-06-30 08:30:48.302369
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.3094	2025-06-30 08:30:48.3094
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.330649	2025-06-30 08:30:48.330649
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.343467	2025-06-30 08:30:48.343467
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.365482	2025-06-30 08:30:48.365482
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.373679	2025-06-30 08:30:48.373679
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.383045	2025-06-30 08:30:48.383045
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.391253	2025-06-30 08:30:48.391253
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.398853	2025-06-30 08:30:48.398853
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.40852	2025-06-30 08:30:48.40852
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.415585	2025-06-30 08:30:48.415585
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.426519	2025-06-30 08:30:48.426519
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.440129	2025-06-30 08:30:48.440129
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.447873	2025-06-30 08:30:48.447873
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.45934	2025-06-30 08:30:48.45934
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.474475	2025-06-30 08:30:48.474475
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.497817	2025-06-30 08:30:48.497817
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.505874	2025-06-30 08:30:48.505874
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.518731	2025-06-30 08:30:48.518731
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.52664	2025-06-30 08:30:48.52664
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.533825	2025-06-30 08:30:48.533825
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.541009	2025-06-30 08:30:48.541009
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.550406	2025-06-30 08:30:48.550406
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.558949	2025-06-30 08:30:48.558949
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.566906	2025-06-30 08:30:48.566906
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.580037	2025-06-30 08:30:48.580037
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.587515	2025-06-30 08:30:48.587515
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.596921	2025-06-30 08:30:48.596921
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.607416	2025-06-30 08:30:48.607416
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.615313	2025-06-30 08:30:48.615313
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.623248	2025-06-30 08:30:48.623248
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.631829	2025-06-30 08:30:48.631829
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.639052	2025-06-30 08:30:48.639052
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.647025	2025-06-30 08:30:48.647025
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.660268	2025-06-30 08:30:48.660268
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.668877	2025-06-30 08:30:48.668877
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.679011	2025-06-30 08:30:48.679011
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.687175	2025-06-30 08:30:48.687175
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.69719	2025-06-30 08:30:48.69719
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.705969	2025-06-30 08:30:48.705969
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.71457	2025-06-30 08:30:48.71457
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.722164	2025-06-30 08:30:48.722164
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.72933	2025-06-30 08:30:48.72933
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.738192	2025-06-30 08:30:48.738192
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.745749	2025-06-30 08:30:48.745749
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.754164	2025-06-30 08:30:48.754164
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.763381	2025-06-30 08:30:48.763381
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.772389	2025-06-30 08:30:48.772389
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.780158	2025-06-30 08:30:48.780158
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.789558	2025-06-30 08:30:48.789558
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.79741	2025-06-30 08:30:48.79741
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.806547	2025-06-30 08:30:48.806547
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.816011	2025-06-30 08:30:48.816011
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.824745	2025-06-30 08:30:48.824745
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.833072	2025-06-30 08:30:48.833072
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.840141	2025-06-30 08:30:48.840141
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.847863	2025-06-30 08:30:48.847863
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.857204	2025-06-30 08:30:48.857204
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.872865	2025-06-30 08:30:48.872865
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.880985	2025-06-30 08:30:48.880985
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.892377	2025-06-30 08:30:48.892377
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.899873	2025-06-30 08:30:48.899873
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.916338	2025-06-30 08:30:48.916338
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.94293	2025-06-30 08:30:48.94293
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.958195	2025-06-30 08:30:48.958195
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.96728	2025-06-30 08:30:48.96728
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.974743	2025-06-30 08:30:48.974743
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.984098	2025-06-30 08:30:48.984098
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:48.99397	2025-06-30 08:30:48.99397
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.003027	2025-06-30 08:30:49.003027
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.012838	2025-06-30 08:30:49.012838
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.021332	2025-06-30 08:30:49.021332
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.030053	2025-06-30 08:30:49.030053
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.038704	2025-06-30 08:30:49.038704
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.076317	2025-06-30 08:30:49.076317
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.116336	2025-06-30 08:30:49.116336
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.126166	2025-06-30 08:30:49.126166
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.133691	2025-06-30 08:30:49.133691
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.154823	2025-06-30 08:30:49.154823
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.164867	2025-06-30 08:30:49.164867
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.179593	2025-06-30 08:30:49.179593
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.188806	2025-06-30 08:30:49.188806
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.202369	2025-06-30 08:30:49.202369
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.212259	2025-06-30 08:30:49.212259
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.220266	2025-06-30 08:30:49.220266
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.229155	2025-06-30 08:30:49.229155
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.236393	2025-06-30 08:30:49.236393
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.246764	2025-06-30 08:30:49.246764
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.255633	2025-06-30 08:30:49.255633
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.262845	2025-06-30 08:30:49.262845
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.271255	2025-06-30 08:30:49.271255
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.283681	2025-06-30 08:30:49.283681
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.29179	2025-06-30 08:30:49.29179
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.299043	2025-06-30 08:30:49.299043
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.308665	2025-06-30 08:30:49.308665
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.316329	2025-06-30 08:30:49.316329
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.323683	2025-06-30 08:30:49.323683
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.333646	2025-06-30 08:30:49.333646
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.341059	2025-06-30 08:30:49.341059
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.348995	2025-06-30 08:30:49.348995
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.356236	2025-06-30 08:30:49.356236
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.364999	2025-06-30 08:30:49.364999
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.373095	2025-06-30 08:30:49.373095
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.380832	2025-06-30 08:30:49.380832
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.389709	2025-06-30 08:30:49.389709
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.396903	2025-06-30 08:30:49.396903
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.403828	2025-06-30 08:30:49.403828
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.412617	2025-06-30 08:30:49.412617
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.420485	2025-06-30 08:30:49.420485
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.429888	2025-06-30 08:30:49.429888
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.438495	2025-06-30 08:30:49.438495
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.445679	2025-06-30 08:30:49.445679
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.454744	2025-06-30 08:30:49.454744
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.462706	2025-06-30 08:30:49.462706
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.470543	2025-06-30 08:30:49.470543
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.479537	2025-06-30 08:30:49.479537
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.486691	2025-06-30 08:30:49.486691
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.503617	2025-06-30 08:30:49.503617
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.513435	2025-06-30 08:30:49.513435
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.521695	2025-06-30 08:30:49.521695
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.52859	2025-06-30 08:30:49.52859
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.536341	2025-06-30 08:30:49.536341
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.547685	2025-06-30 08:30:49.547685
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.555266	2025-06-30 08:30:49.555266
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.567724	2025-06-30 08:30:49.567724
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.575162	2025-06-30 08:30:49.575162
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.591013	2025-06-30 08:30:49.591013
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.599556	2025-06-30 08:30:49.599556
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.606375	2025-06-30 08:30:49.606375
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.613367	2025-06-30 08:30:49.613367
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.620782	2025-06-30 08:30:49.620782
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.629696	2025-06-30 08:30:49.629696
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.639075	2025-06-30 08:30:49.639075
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.645713	2025-06-30 08:30:49.645713
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.652926	2025-06-30 08:30:49.652926
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.659692	2025-06-30 08:30:49.659692
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.667193	2025-06-30 08:30:49.667193
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.674753	2025-06-30 08:30:49.674753
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.681794	2025-06-30 08:30:49.681794
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.688544	2025-06-30 08:30:49.688544
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.695909	2025-06-30 08:30:49.695909
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.715145	2025-06-30 08:30:49.715145
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.768178	2025-06-30 08:30:49.768178
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.787488	2025-06-30 08:30:49.787488
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.795078	2025-06-30 08:30:49.795078
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.80227	2025-06-30 08:30:49.80227
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.811737	2025-06-30 08:30:49.811737
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.819377	2025-06-30 08:30:49.819377
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.854778	2025-06-30 08:30:49.854778
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.893903	2025-06-30 08:30:49.893903
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.901267	2025-06-30 08:30:49.901267
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.908856	2025-06-30 08:30:49.908856
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.922011	2025-06-30 08:30:49.922011
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.929836	2025-06-30 08:30:49.929836
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.940901	2025-06-30 08:30:49.940901
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.948551	2025-06-30 08:30:49.948551
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.957826	2025-06-30 08:30:49.957826
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.964646	2025-06-30 08:30:49.964646
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.971965	2025-06-30 08:30:49.971965
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.979469	2025-06-30 08:30:49.979469
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.987497	2025-06-30 08:30:49.987497
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:49.99565	2025-06-30 08:30:49.99565
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.002725	2025-06-30 08:30:50.002725
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.010706	2025-06-30 08:30:50.010706
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.018025	2025-06-30 08:30:50.018025
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.039562	2025-06-30 08:30:50.039562
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.047142	2025-06-30 08:30:50.047142
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.077387	2025-06-30 08:30:50.077387
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.084829	2025-06-30 08:30:50.084829
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.093721	2025-06-30 08:30:50.093721
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.102096	2025-06-30 08:30:50.102096
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.109643	2025-06-30 08:30:50.109643
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.117343	2025-06-30 08:30:50.117343
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.125778	2025-06-30 08:30:50.125778
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.133452	2025-06-30 08:30:50.133452
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.140665	2025-06-30 08:30:50.140665
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.163154	2025-06-30 08:30:50.163154
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.169982	2025-06-30 08:30:50.169982
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.177202	2025-06-30 08:30:50.177202
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.184382	2025-06-30 08:30:50.184382
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.193131	2025-06-30 08:30:50.193131
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.200983	2025-06-30 08:30:50.200983
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.226713	2025-06-30 08:30:50.226713
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.234802	2025-06-30 08:30:50.234802
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.245249	2025-06-30 08:30:50.245249
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.256405	2025-06-30 08:30:50.256405
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.263915	2025-06-30 08:30:50.263915
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.31397	2025-06-30 08:30:50.31397
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.324277	2025-06-30 08:30:50.324277
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.335902	2025-06-30 08:30:50.335902
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.343187	2025-06-30 08:30:50.343187
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.357216	2025-06-30 08:30:50.357216
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.36616	2025-06-30 08:30:50.36616
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.373858	2025-06-30 08:30:50.373858
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.385006	2025-06-30 08:30:50.385006
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.392664	2025-06-30 08:30:50.392664
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.399733	2025-06-30 08:30:50.399733
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.408281	2025-06-30 08:30:50.408281
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.415504	2025-06-30 08:30:50.415504
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.422796	2025-06-30 08:30:50.422796
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.433796	2025-06-30 08:30:50.433796
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.442883	2025-06-30 08:30:50.442883
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.449824	2025-06-30 08:30:50.449824
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.459429	2025-06-30 08:30:50.459429
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.467521	2025-06-30 08:30:50.467521
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.475015	2025-06-30 08:30:50.475015
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.482525	2025-06-30 08:30:50.482525
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.49014	2025-06-30 08:30:50.49014
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.49807	2025-06-30 08:30:50.49807
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.50516	2025-06-30 08:30:50.50516
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.512594	2025-06-30 08:30:50.512594
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.519904	2025-06-30 08:30:50.519904
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.528168	2025-06-30 08:30:50.528168
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.535097	2025-06-30 08:30:50.535097
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.542856	2025-06-30 08:30:50.542856
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.552526	2025-06-30 08:30:50.552526
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.563898	2025-06-30 08:30:50.563898
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.571184	2025-06-30 08:30:50.571184
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.57848	2025-06-30 08:30:50.57848
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.58565	2025-06-30 08:30:50.58565
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.594305	2025-06-30 08:30:50.594305
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.601788	2025-06-30 08:30:50.601788
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.609041	2025-06-30 08:30:50.609041
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.617726	2025-06-30 08:30:50.617726
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.626414	2025-06-30 08:30:50.626414
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.635261	2025-06-30 08:30:50.635261
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.642607	2025-06-30 08:30:50.642607
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.653862	2025-06-30 08:30:50.653862
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.663531	2025-06-30 08:30:50.663531
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.671062	2025-06-30 08:30:50.671062
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.67935	2025-06-30 08:30:50.67935
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.687389	2025-06-30 08:30:50.687389
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:50.694964	2025-06-30 08:30:50.694964
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.702418	2025-06-30 08:30:50.702418
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.711104	2025-06-30 08:30:50.711104
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.720481	2025-06-30 08:30:50.720481
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.728451	2025-06-30 08:30:50.728451
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.738399	2025-06-30 08:30:50.738399
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.75723	2025-06-30 08:30:50.75723
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.794211	2025-06-30 08:30:50.794211
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.804233	2025-06-30 08:30:50.804233
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.811669	2025-06-30 08:30:50.811669
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.819059	2025-06-30 08:30:50.819059
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.828324	2025-06-30 08:30:50.828324
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.838716	2025-06-30 08:30:50.838716
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.845626	2025-06-30 08:30:50.845626
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.884811	2025-06-30 08:30:50.884811
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.895714	2025-06-30 08:30:50.895714
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.903121	2025-06-30 08:30:50.903121
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.910536	2025-06-30 08:30:50.910536
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.917795	2025-06-30 08:30:50.917795
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.927334	2025-06-30 08:30:50.927334
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.934994	2025-06-30 08:30:50.934994
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.952583	2025-06-30 08:30:50.952583
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.961997	2025-06-30 08:30:50.961997
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.969982	2025-06-30 08:30:50.969982
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.978703	2025-06-30 08:30:50.978703
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.985298	2025-06-30 08:30:50.985298
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:50.993865	2025-06-30 08:30:50.993865
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.001451	2025-06-30 08:30:51.001451
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.010187	2025-06-30 08:30:51.010187
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.02767	2025-06-30 08:30:51.02767
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.036379	2025-06-30 08:30:51.036379
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.051724	2025-06-30 08:30:51.051724
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.059182	2025-06-30 08:30:51.059182
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.068361	2025-06-30 08:30:51.068361
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.075768	2025-06-30 08:30:51.075768
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.083184	2025-06-30 08:30:51.083184
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.091355	2025-06-30 08:30:51.091355
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.104509	2025-06-30 08:30:51.104509
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.112716	2025-06-30 08:30:51.112716
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.121089	2025-06-30 08:30:51.121089
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.128245	2025-06-30 08:30:51.128245
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.13841	2025-06-30 08:30:51.13841
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.157884	2025-06-30 08:30:51.157884
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.183454	2025-06-30 08:30:51.183454
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.19288	2025-06-30 08:30:51.19288
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.200565	2025-06-30 08:30:51.200565
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.209351	2025-06-30 08:30:51.209351
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.219392	2025-06-30 08:30:51.219392
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.226484	2025-06-30 08:30:51.226484
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.235062	2025-06-30 08:30:51.235062
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.242272	2025-06-30 08:30:51.242272
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.261722	2025-06-30 08:30:51.261722
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.269497	2025-06-30 08:30:51.269497
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.278008	2025-06-30 08:30:51.278008
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.299859	2025-06-30 08:30:51.299859
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.308245	2025-06-30 08:30:51.308245
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.315689	2025-06-30 08:30:51.315689
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.324549	2025-06-30 08:30:51.324549
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.335193	2025-06-30 08:30:51.335193
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.342565	2025-06-30 08:30:51.342565
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.349879	2025-06-30 08:30:51.349879
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.357473	2025-06-30 08:30:51.357473
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.371367	2025-06-30 08:30:51.371367
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.37863	2025-06-30 08:30:51.37863
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.386801	2025-06-30 08:30:51.386801
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.395459	2025-06-30 08:30:51.395459
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.403691	2025-06-30 08:30:51.403691
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.411257	2025-06-30 08:30:51.411257
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.420215	2025-06-30 08:30:51.420215
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.430377	2025-06-30 08:30:51.430377
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.438688	2025-06-30 08:30:51.438688
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.447838	2025-06-30 08:30:51.447838
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.457364	2025-06-30 08:30:51.457364
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.466234	2025-06-30 08:30:51.466234
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.474212	2025-06-30 08:30:51.474212
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.484838	2025-06-30 08:30:51.484838
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.493773	2025-06-30 08:30:51.493773
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.504369	2025-06-30 08:30:51.504369
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.512533	2025-06-30 08:30:51.512533
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.519645	2025-06-30 08:30:51.519645
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.527348	2025-06-30 08:30:51.527348
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.536289	2025-06-30 08:30:51.536289
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.545699	2025-06-30 08:30:51.545699
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.553067	2025-06-30 08:30:51.553067
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.570145	2025-06-30 08:30:51.570145
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.578796	2025-06-30 08:30:51.578796
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.602042	2025-06-30 08:30:51.602042
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.616003	2025-06-30 08:30:51.616003
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.625055	2025-06-30 08:30:51.625055
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.63484	2025-06-30 08:30:51.63484
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.648247	2025-06-30 08:30:51.648247
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.656217	2025-06-30 08:30:51.656217
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.664505	2025-06-30 08:30:51.664505
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.673037	2025-06-30 08:30:51.673037
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.684635	2025-06-30 08:30:51.684635
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.692923	2025-06-30 08:30:51.692923
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.71095	2025-06-30 08:30:51.71095
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.720593	2025-06-30 08:30:51.720593
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.731039	2025-06-30 08:30:51.731039
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.740284	2025-06-30 08:30:51.740284
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.74905	2025-06-30 08:30:51.74905
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.758122	2025-06-30 08:30:51.758122
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.766314	2025-06-30 08:30:51.766314
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.774479	2025-06-30 08:30:51.774479
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.78354	2025-06-30 08:30:51.78354
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.791654	2025-06-30 08:30:51.791654
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.799396	2025-06-30 08:30:51.799396
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.807961	2025-06-30 08:30:51.807961
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.829646	2025-06-30 08:30:51.829646
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.846825	2025-06-30 08:30:51.846825
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.85427	2025-06-30 08:30:51.85427
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.861643	2025-06-30 08:30:51.861643
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.882211	2025-06-30 08:30:51.882211
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.890789	2025-06-30 08:30:51.890789
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.899072	2025-06-30 08:30:51.899072
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.907513	2025-06-30 08:30:51.907513
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.924284	2025-06-30 08:30:51.924284
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.931894	2025-06-30 08:30:51.931894
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.93967	2025-06-30 08:30:51.93967
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.948276	2025-06-30 08:30:51.948276
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.974153	2025-06-30 08:30:51.974153
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:51.981256	2025-06-30 08:30:51.981256
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.01574	2025-06-30 08:30:52.01574
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.023888	2025-06-30 08:30:52.023888
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.031991	2025-06-30 08:30:52.031991
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.03936	2025-06-30 08:30:52.03936
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.050409	2025-06-30 08:30:52.050409
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.058815	2025-06-30 08:30:52.058815
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.066526	2025-06-30 08:30:52.066526
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.074516	2025-06-30 08:30:52.074516
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.084274	2025-06-30 08:30:52.084274
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.092883	2025-06-30 08:30:52.092883
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.102913	2025-06-30 08:30:52.102913
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.109515	2025-06-30 08:30:52.109515
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.117457	2025-06-30 08:30:52.117457
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.125832	2025-06-30 08:30:52.125832
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.134796	2025-06-30 08:30:52.134796
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.145631	2025-06-30 08:30:52.145631
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.152924	2025-06-30 08:30:52.152924
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.159732	2025-06-30 08:30:52.159732
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.168158	2025-06-30 08:30:52.168158
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.180961	2025-06-30 08:30:52.180961
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.189997	2025-06-30 08:30:52.189997
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.198265	2025-06-30 08:30:52.198265
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.205997	2025-06-30 08:30:52.205997
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.223332	2025-06-30 08:30:52.223332
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.230204	2025-06-30 08:30:52.230204
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.237676	2025-06-30 08:30:52.237676
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.244173	2025-06-30 08:30:52.244173
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.251081	2025-06-30 08:30:52.251081
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.260312	2025-06-30 08:30:52.260312
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.271342	2025-06-30 08:30:52.271342
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.280964	2025-06-30 08:30:52.280964
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.310906	2025-06-30 08:30:52.310906
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.361099	2025-06-30 08:30:52.361099
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.374727	2025-06-30 08:30:52.374727
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.396071	2025-06-30 08:30:52.396071
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.420201	2025-06-30 08:30:52.420201
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.463968	2025-06-30 08:30:52.463968
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.479527	2025-06-30 08:30:52.479527
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.487045	2025-06-30 08:30:52.487045
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.495812	2025-06-30 08:30:52.495812
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.517196	2025-06-30 08:30:52.517196
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.524395	2025-06-30 08:30:52.524395
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.533467	2025-06-30 08:30:52.533467
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.542793	2025-06-30 08:30:52.542793
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.55014	2025-06-30 08:30:52.55014
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.556895	2025-06-30 08:30:52.556895
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.564795	2025-06-30 08:30:52.564795
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.574621	2025-06-30 08:30:52.574621
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.582505	2025-06-30 08:30:52.582505
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.590625	2025-06-30 08:30:52.590625
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.59833	2025-06-30 08:30:52.59833
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.615535	2025-06-30 08:30:52.615535
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.623254	2025-06-30 08:30:52.623254
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.630383	2025-06-30 08:30:52.630383
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.640764	2025-06-30 08:30:52.640764
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.648055	2025-06-30 08:30:52.648055
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.657084	2025-06-30 08:30:52.657084
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.664237	2025-06-30 08:30:52.664237
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.672489	2025-06-30 08:30:52.672489
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.680647	2025-06-30 08:30:52.680647
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.698729	2025-06-30 08:30:52.698729
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.746382	2025-06-30 08:30:52.746382
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.770321	2025-06-30 08:30:52.770321
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.777677	2025-06-30 08:30:52.777677
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.786446	2025-06-30 08:30:52.786446
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.795019	2025-06-30 08:30:52.795019
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.802217	2025-06-30 08:30:52.802217
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.818768	2025-06-30 08:30:52.818768
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.827605	2025-06-30 08:30:52.827605
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.835971	2025-06-30 08:30:52.835971
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.842981	2025-06-30 08:30:52.842981
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.850467	2025-06-30 08:30:52.850467
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.859383	2025-06-30 08:30:52.859383
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.866398	2025-06-30 08:30:52.866398
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.877637	2025-06-30 08:30:52.877637
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.889542	2025-06-30 08:30:52.889542
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.898559	2025-06-30 08:30:52.898559
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.906256	2025-06-30 08:30:52.906256
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.916553	2025-06-30 08:30:52.916553
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.923299	2025-06-30 08:30:52.923299
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.930765	2025-06-30 08:30:52.930765
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.941979	2025-06-30 08:30:52.941979
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.949494	2025-06-30 08:30:52.949494
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.979601	2025-06-30 08:30:52.979601
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.986968	2025-06-30 08:30:52.986968
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:52.99811	2025-06-30 08:30:52.99811
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.005578	2025-06-30 08:30:53.005578
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.01457	2025-06-30 08:30:53.01457
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.022912	2025-06-30 08:30:53.022912
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.031241	2025-06-30 08:30:53.031241
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.039039	2025-06-30 08:30:53.039039
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.048593	2025-06-30 08:30:53.048593
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.058606	2025-06-30 08:30:53.058606
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.065925	2025-06-30 08:30:53.065925
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.077568	2025-06-30 08:30:53.077568
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.08464	2025-06-30 08:30:53.08464
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.094875	2025-06-30 08:30:53.094875
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.104704	2025-06-30 08:30:53.104704
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.112688	2025-06-30 08:30:53.112688
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.130182	2025-06-30 08:30:53.130182
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.134065	2025-06-30 08:30:53.134065
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.14183	2025-06-30 08:30:53.14183
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.150811	2025-06-30 08:30:53.150811
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.158031	2025-06-30 08:30:53.158031
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.165794	2025-06-30 08:30:53.165794
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.173502	2025-06-30 08:30:53.173502
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.184496	2025-06-30 08:30:53.184496
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.193793	2025-06-30 08:30:53.193793
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.202236	2025-06-30 08:30:53.202236
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.210484	2025-06-30 08:30:53.210484
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.219828	2025-06-30 08:30:53.219828
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.228686	2025-06-30 08:30:53.228686
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.236364	2025-06-30 08:30:53.236364
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.243262	2025-06-30 08:30:53.243262
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.251115	2025-06-30 08:30:53.251115
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.258578	2025-06-30 08:30:53.258578
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.271208	2025-06-30 08:30:53.271208
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.279277	2025-06-30 08:30:53.279277
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.286698	2025-06-30 08:30:53.286698
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.296282	2025-06-30 08:30:53.296282
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.303499	2025-06-30 08:30:53.303499
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.31169	2025-06-30 08:30:53.31169
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.321599	2025-06-30 08:30:53.321599
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.330416	2025-06-30 08:30:53.330416
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.337614	2025-06-30 08:30:53.337614
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.344489	2025-06-30 08:30:53.344489
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.353068	2025-06-30 08:30:53.353068
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.360544	2025-06-30 08:30:53.360544
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.369004	2025-06-30 08:30:53.369004
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.37687	2025-06-30 08:30:53.37687
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.385526	2025-06-30 08:30:53.385526
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.393609	2025-06-30 08:30:53.393609
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.40317	2025-06-30 08:30:53.40317
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.41033	2025-06-30 08:30:53.41033
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.420177	2025-06-30 08:30:53.420177
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.427864	2025-06-30 08:30:53.427864
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.435581	2025-06-30 08:30:53.435581
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.443569	2025-06-30 08:30:53.443569
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.450812	2025-06-30 08:30:53.450812
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.458107	2025-06-30 08:30:53.458107
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.468506	2025-06-30 08:30:53.468506
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.476811	2025-06-30 08:30:53.476811
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.485803	2025-06-30 08:30:53.485803
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.49423	2025-06-30 08:30:53.49423
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.503607	2025-06-30 08:30:53.503607
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.511767	2025-06-30 08:30:53.511767
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.519533	2025-06-30 08:30:53.519533
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.527038	2025-06-30 08:30:53.527038
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.535608	2025-06-30 08:30:53.535608
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.542845	2025-06-30 08:30:53.542845
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.550742	2025-06-30 08:30:53.550742
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.558941	2025-06-30 08:30:53.558941
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.567394	2025-06-30 08:30:53.567394
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.606808	2025-06-30 08:30:53.606808
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.616068	2025-06-30 08:30:53.616068
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.656633	2025-06-30 08:30:53.656633
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.66717	2025-06-30 08:30:53.66717
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.676017	2025-06-30 08:30:53.676017
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.714797	2025-06-30 08:30:53.714797
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.722736	2025-06-30 08:30:53.722736
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.761694	2025-06-30 08:30:53.761694
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.770533	2025-06-30 08:30:53.770533
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.780424	2025-06-30 08:30:53.780424
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.788598	2025-06-30 08:30:53.788598
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.79554	2025-06-30 08:30:53.79554
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.803435	2025-06-30 08:30:53.803435
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.810862	2025-06-30 08:30:53.810862
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.819249	2025-06-30 08:30:53.819249
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.826481	2025-06-30 08:30:53.826481
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.83469	2025-06-30 08:30:53.83469
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.843231	2025-06-30 08:30:53.843231
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.851146	2025-06-30 08:30:53.851146
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.859703	2025-06-30 08:30:53.859703
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.866697	2025-06-30 08:30:53.866697
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.875205	2025-06-30 08:30:53.875205
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.882061	2025-06-30 08:30:53.882061
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.895074	2025-06-30 08:30:53.895074
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.903679	2025-06-30 08:30:53.903679
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.911141	2025-06-30 08:30:53.911141
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.919769	2025-06-30 08:30:53.919769
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.927578	2025-06-30 08:30:53.927578
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.936367	2025-06-30 08:30:53.936367
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.944926	2025-06-30 08:30:53.944926
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.952673	2025-06-30 08:30:53.952673
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.961487	2025-06-30 08:30:53.961487
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.968802	2025-06-30 08:30:53.968802
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.976658	2025-06-30 08:30:53.976658
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.983747	2025-06-30 08:30:53.983747
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:53.993443	2025-06-30 08:30:53.993443
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.001926	2025-06-30 08:30:54.001926
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.012664	2025-06-30 08:30:54.012664
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.020521	2025-06-30 08:30:54.020521
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.030154	2025-06-30 08:30:54.030154
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.039128	2025-06-30 08:30:54.039128
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.04826	2025-06-30 08:30:54.04826
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.057179	2025-06-30 08:30:54.057179
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.064186	2025-06-30 08:30:54.064186
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.071778	2025-06-30 08:30:54.071778
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.080553	2025-06-30 08:30:54.080553
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.087409	2025-06-30 08:30:54.087409
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.095042	2025-06-30 08:30:54.095042
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.10455	2025-06-30 08:30:54.10455
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.111731	2025-06-30 08:30:54.111731
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.119107	2025-06-30 08:30:54.119107
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.128536	2025-06-30 08:30:54.128536
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.135852	2025-06-30 08:30:54.135852
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.143435	2025-06-30 08:30:54.143435
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.150149	2025-06-30 08:30:54.150149
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.157661	2025-06-30 08:30:54.157661
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.165264	2025-06-30 08:30:54.165264
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.172062	2025-06-30 08:30:54.172062
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.180581	2025-06-30 08:30:54.180581
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.190748	2025-06-30 08:30:54.190748
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.199588	2025-06-30 08:30:54.199588
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.207109	2025-06-30 08:30:54.207109
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.214232	2025-06-30 08:30:54.214232
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.221213	2025-06-30 08:30:54.221213
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.230381	2025-06-30 08:30:54.230381
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.237248	2025-06-30 08:30:54.237248
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.248618	2025-06-30 08:30:54.248618
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.258197	2025-06-30 08:30:54.258197
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.265603	2025-06-30 08:30:54.265603
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.273256	2025-06-30 08:30:54.273256
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.286283	2025-06-30 08:30:54.286283
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.292842	2025-06-30 08:30:54.292842
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.299932	2025-06-30 08:30:54.299932
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.308785	2025-06-30 08:30:54.308785
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.318746	2025-06-30 08:30:54.318746
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.32648	2025-06-30 08:30:54.32648
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.333603	2025-06-30 08:30:54.333603
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.342564	2025-06-30 08:30:54.342564
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.351123	2025-06-30 08:30:54.351123
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.359173	2025-06-30 08:30:54.359173
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.366493	2025-06-30 08:30:54.366493
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.375154	2025-06-30 08:30:54.375154
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.385679	2025-06-30 08:30:54.385679
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.395483	2025-06-30 08:30:54.395483
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.403107	2025-06-30 08:30:54.403107
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.41104	2025-06-30 08:30:54.41104
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.418411	2025-06-30 08:30:54.418411
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.42552	2025-06-30 08:30:54.42552
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.445898	2025-06-30 08:30:54.445898
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.460874	2025-06-30 08:30:54.460874
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.469798	2025-06-30 08:30:54.469798
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.477133	2025-06-30 08:30:54.477133
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.516949	2025-06-30 08:30:54.516949
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.523864	2025-06-30 08:30:54.523864
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.552615	2025-06-30 08:30:54.552615
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.560571	2025-06-30 08:30:54.560571
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.568306	2025-06-30 08:30:54.568306
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.577313	2025-06-30 08:30:54.577313
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.584096	2025-06-30 08:30:54.584096
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.591142	2025-06-30 08:30:54.591142
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.601141	2025-06-30 08:30:54.601141
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.608785	2025-06-30 08:30:54.608785
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.630897	2025-06-30 08:30:54.630897
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.637685	2025-06-30 08:30:54.637685
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.647168	2025-06-30 08:30:54.647168
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.654782	2025-06-30 08:30:54.654782
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.662039	2025-06-30 08:30:54.662039
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.671033	2025-06-30 08:30:54.671033
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.679047	2025-06-30 08:30:54.679047
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.686039	2025-06-30 08:30:54.686039
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.693661	2025-06-30 08:30:54.693661
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.701045	2025-06-30 08:30:54.701045
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.711778	2025-06-30 08:30:54.711778
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.724103	2025-06-30 08:30:54.724103
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.733145	2025-06-30 08:30:54.733145
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.741331	2025-06-30 08:30:54.741331
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.749429	2025-06-30 08:30:54.749429
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.757855	2025-06-30 08:30:54.757855
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.766963	2025-06-30 08:30:54.766963
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.774591	2025-06-30 08:30:54.774591
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.804339	2025-06-30 08:30:54.804339
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.811233	2025-06-30 08:30:54.811233
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.820083	2025-06-30 08:30:54.820083
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.826678	2025-06-30 08:30:54.826678
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.833712	2025-06-30 08:30:54.833712
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:54.841189	2025-06-30 08:30:54.841189
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.849727	2025-06-30 08:30:54.849727
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.857177	2025-06-30 08:30:54.857177
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.86597	2025-06-30 08:30:54.86597
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.875341	2025-06-30 08:30:54.875341
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.883642	2025-06-30 08:30:54.883642
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.892299	2025-06-30 08:30:54.892299
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.900022	2025-06-30 08:30:54.900022
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.907731	2025-06-30 08:30:54.907731
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.918039	2025-06-30 08:30:54.918039
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.925078	2025-06-30 08:30:54.925078
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.933287	2025-06-30 08:30:54.933287
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.942164	2025-06-30 08:30:54.942164
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.954437	2025-06-30 08:30:54.954437
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.961951	2025-06-30 08:30:54.961951
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.970696	2025-06-30 08:30:54.970696
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.979539	2025-06-30 08:30:54.979539
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.988206	2025-06-30 08:30:54.988206
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:54.996461	2025-06-30 08:30:54.996461
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.004142	2025-06-30 08:30:55.004142
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.036075	2025-06-30 08:30:55.036075
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.044269	2025-06-30 08:30:55.044269
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.051768	2025-06-30 08:30:55.051768
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.059287	2025-06-30 08:30:55.059287
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.068484	2025-06-30 08:30:55.068484
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.077612	2025-06-30 08:30:55.077612
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.086912	2025-06-30 08:30:55.086912
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.09604	2025-06-30 08:30:55.09604
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.103631	2025-06-30 08:30:55.103631
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.109559	2025-06-30 08:30:55.109559
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.119258	2025-06-30 08:30:55.119258
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.127041	2025-06-30 08:30:55.127041
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.134845	2025-06-30 08:30:55.134845
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.141855	2025-06-30 08:30:55.141855
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.151445	2025-06-30 08:30:55.151445
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.159187	2025-06-30 08:30:55.159187
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.168341	2025-06-30 08:30:55.168341
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.177592	2025-06-30 08:30:55.177592
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.185355	2025-06-30 08:30:55.185355
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.193733	2025-06-30 08:30:55.193733
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.201492	2025-06-30 08:30:55.201492
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.208606	2025-06-30 08:30:55.208606
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.217432	2025-06-30 08:30:55.217432
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.2566	2025-06-30 08:30:55.2566
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.265248	2025-06-30 08:30:55.265248
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.273188	2025-06-30 08:30:55.273188
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.281053	2025-06-30 08:30:55.281053
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.295162	2025-06-30 08:30:55.295162
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.302819	2025-06-30 08:30:55.302819
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.31055	2025-06-30 08:30:55.31055
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.318528	2025-06-30 08:30:55.318528
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.326937	2025-06-30 08:30:55.326937
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.334694	2025-06-30 08:30:55.334694
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.343273	2025-06-30 08:30:55.343273
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.350402	2025-06-30 08:30:55.350402
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.363226	2025-06-30 08:30:55.363226
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.370787	2025-06-30 08:30:55.370787
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.379556	2025-06-30 08:30:55.379556
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.386741	2025-06-30 08:30:55.386741
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.394376	2025-06-30 08:30:55.394376
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.404954	2025-06-30 08:30:55.404954
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.411726	2025-06-30 08:30:55.411726
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.425946	2025-06-30 08:30:55.425946
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.434148	2025-06-30 08:30:55.434148
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.440798	2025-06-30 08:30:55.440798
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.449049	2025-06-30 08:30:55.449049
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.458158	2025-06-30 08:30:55.458158
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.466091	2025-06-30 08:30:55.466091
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.476725	2025-06-30 08:30:55.476725
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.484739	2025-06-30 08:30:55.484739
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.494147	2025-06-30 08:30:55.494147
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.502621	2025-06-30 08:30:55.502621
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.519495	2025-06-30 08:30:55.519495
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.52666	2025-06-30 08:30:55.52666
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.565655	2025-06-30 08:30:55.565655
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.604972	2025-06-30 08:30:55.604972
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.613705	2025-06-30 08:30:55.613705
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.621411	2025-06-30 08:30:55.621411
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.660745	2025-06-30 08:30:55.660745
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.669164	2025-06-30 08:30:55.669164
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.676164	2025-06-30 08:30:55.676164
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.684933	2025-06-30 08:30:55.684933
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.710382	2025-06-30 08:30:55.710382
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.719536	2025-06-30 08:30:55.719536
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.758151	2025-06-30 08:30:55.758151
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.767238	2025-06-30 08:30:55.767238
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.77786	2025-06-30 08:30:55.77786
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.785456	2025-06-30 08:30:55.785456
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.826306	2025-06-30 08:30:55.826306
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.833519	2025-06-30 08:30:55.833519
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.841133	2025-06-30 08:30:55.841133
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.880165	2025-06-30 08:30:55.880165
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.888937	2025-06-30 08:30:55.888937
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.90526	2025-06-30 08:30:55.90526
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.950409	2025-06-30 08:30:55.950409
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.962656	2025-06-30 08:30:55.962656
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:55.986514	2025-06-30 08:30:55.986514
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.000356	2025-06-30 08:30:56.000356
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.013602	2025-06-30 08:30:56.013602
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.027684	2025-06-30 08:30:56.027684
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.041449	2025-06-30 08:30:56.041449
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.054547	2025-06-30 08:30:56.054547
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.068856	2025-06-30 08:30:56.068856
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.082474	2025-06-30 08:30:56.082474
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.095474	2025-06-30 08:30:56.095474
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.110423	2025-06-30 08:30:56.110423
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.123416	2025-06-30 08:30:56.123416
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.158917	2025-06-30 08:30:56.158917
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.179364	2025-06-30 08:30:56.179364
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.189046	2025-06-30 08:30:56.189046
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.199986	2025-06-30 08:30:56.199986
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.212642	2025-06-30 08:30:56.212642
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.226421	2025-06-30 08:30:56.226421
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.240084	2025-06-30 08:30:56.240084
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.254119	2025-06-30 08:30:56.254119
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.269487	2025-06-30 08:30:56.269487
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.28889	2025-06-30 08:30:56.28889
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.308598	2025-06-30 08:30:56.308598
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.318021	2025-06-30 08:30:56.318021
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.331532	2025-06-30 08:30:56.331532
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.344506	2025-06-30 08:30:56.344506
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.360646	2025-06-30 08:30:56.360646
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.373686	2025-06-30 08:30:56.373686
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.395305	2025-06-30 08:30:56.395305
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.403789	2025-06-30 08:30:56.403789
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.414162	2025-06-30 08:30:56.414162
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.427563	2025-06-30 08:30:56.427563
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.451374	2025-06-30 08:30:56.451374
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.471104	2025-06-30 08:30:56.471104
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.478426	2025-06-30 08:30:56.478426
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.485521	2025-06-30 08:30:56.485521
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.539885	2025-06-30 08:30:56.539885
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.546913	2025-06-30 08:30:56.546913
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.554794	2025-06-30 08:30:56.554794
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.562079	2025-06-30 08:30:56.562079
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.57081	2025-06-30 08:30:56.57081
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.588783	2025-06-30 08:30:56.588783
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.596444	2025-06-30 08:30:56.596444
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.604025	2025-06-30 08:30:56.604025
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.61074	2025-06-30 08:30:56.61074
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.618434	2025-06-30 08:30:56.618434
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.626537	2025-06-30 08:30:56.626537
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.636801	2025-06-30 08:30:56.636801
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.644854	2025-06-30 08:30:56.644854
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.651697	2025-06-30 08:30:56.651697
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.660411	2025-06-30 08:30:56.660411
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.670813	2025-06-30 08:30:56.670813
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.689884	2025-06-30 08:30:56.689884
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.695931	2025-06-30 08:30:56.695931
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.704669	2025-06-30 08:30:56.704669
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.712668	2025-06-30 08:30:56.712668
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.720033	2025-06-30 08:30:56.720033
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.728301	2025-06-30 08:30:56.728301
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.73555	2025-06-30 08:30:56.73555
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.743104	2025-06-30 08:30:56.743104
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.750182	2025-06-30 08:30:56.750182
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.759516	2025-06-30 08:30:56.759516
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.769199	2025-06-30 08:30:56.769199
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.777201	2025-06-30 08:30:56.777201
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.785857	2025-06-30 08:30:56.785857
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.794778	2025-06-30 08:30:56.794778
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.805066	2025-06-30 08:30:56.805066
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.812643	2025-06-30 08:30:56.812643
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.841829	2025-06-30 08:30:56.841829
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.851223	2025-06-30 08:30:56.851223
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.860152	2025-06-30 08:30:56.860152
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.870162	2025-06-30 08:30:56.870162
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.879384	2025-06-30 08:30:56.879384
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.889713	2025-06-30 08:30:56.889713
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.897005	2025-06-30 08:30:56.897005
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.90535	2025-06-30 08:30:56.90535
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.912272	2025-06-30 08:30:56.912272
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.920752	2025-06-30 08:30:56.920752
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.928592	2025-06-30 08:30:56.928592
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.943366	2025-06-30 08:30:56.943366
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.952664	2025-06-30 08:30:56.952664
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.960209	2025-06-30 08:30:56.960209
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.9679	2025-06-30 08:30:56.9679
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.975813	2025-06-30 08:30:56.975813
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:56.99217	2025-06-30 08:30:56.99217
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.000852	2025-06-30 08:30:57.000852
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.010557	2025-06-30 08:30:57.010557
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.017942	2025-06-30 08:30:57.017942
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.026267	2025-06-30 08:30:57.026267
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.052797	2025-06-30 08:30:57.052797
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.059577	2025-06-30 08:30:57.059577
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.070207	2025-06-30 08:30:57.070207
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.077762	2025-06-30 08:30:57.077762
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.086328	2025-06-30 08:30:57.086328
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.096203	2025-06-30 08:30:57.096203
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.103348	2025-06-30 08:30:57.103348
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.11135	2025-06-30 08:30:57.11135
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.12114	2025-06-30 08:30:57.12114
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.128537	2025-06-30 08:30:57.128537
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.136438	2025-06-30 08:30:57.136438
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.143574	2025-06-30 08:30:57.143574
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.157536	2025-06-30 08:30:57.157536
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.165133	2025-06-30 08:30:57.165133
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.17433	2025-06-30 08:30:57.17433
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.182825	2025-06-30 08:30:57.182825
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.190342	2025-06-30 08:30:57.190342
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.198261	2025-06-30 08:30:57.198261
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.206181	2025-06-30 08:30:57.206181
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.214395	2025-06-30 08:30:57.214395
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.223623	2025-06-30 08:30:57.223623
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.230891	2025-06-30 08:30:57.230891
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.239854	2025-06-30 08:30:57.239854
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.247911	2025-06-30 08:30:57.247911
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.255592	2025-06-30 08:30:57.255592
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.263285	2025-06-30 08:30:57.263285
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.270746	2025-06-30 08:30:57.270746
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.278453	2025-06-30 08:30:57.278453
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.285996	2025-06-30 08:30:57.285996
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.29923	2025-06-30 08:30:57.29923
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.306942	2025-06-30 08:30:57.306942
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.313907	2025-06-30 08:30:57.313907
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.322172	2025-06-30 08:30:57.322172
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.328572	2025-06-30 08:30:57.328572
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.336308	2025-06-30 08:30:57.336308
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.343253	2025-06-30 08:30:57.343253
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.351668	2025-06-30 08:30:57.351668
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.361263	2025-06-30 08:30:57.361263
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.368561	2025-06-30 08:30:57.368561
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.37716	2025-06-30 08:30:57.37716
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.386937	2025-06-30 08:30:57.386937
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.395086	2025-06-30 08:30:57.395086
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.402205	2025-06-30 08:30:57.402205
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.40955	2025-06-30 08:30:57.40955
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.416525	2025-06-30 08:30:57.416525
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.429237	2025-06-30 08:30:57.429237
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.436229	2025-06-30 08:30:57.436229
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.446603	2025-06-30 08:30:57.446603
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.453762	2025-06-30 08:30:57.453762
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.461238	2025-06-30 08:30:57.461238
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.473932	2025-06-30 08:30:57.473932
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.481217	2025-06-30 08:30:57.481217
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.488491	2025-06-30 08:30:57.488491
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.496185	2025-06-30 08:30:57.496185
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.516374	2025-06-30 08:30:57.516374
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.524012	2025-06-30 08:30:57.524012
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.531786	2025-06-30 08:30:57.531786
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.539401	2025-06-30 08:30:57.539401
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.557002	2025-06-30 08:30:57.557002
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.564384	2025-06-30 08:30:57.564384
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.60285	2025-06-30 08:30:57.60285
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.610389	2025-06-30 08:30:57.610389
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.618389	2025-06-30 08:30:57.618389
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.656847	2025-06-30 08:30:57.656847
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.664305	2025-06-30 08:30:57.664305
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.671253	2025-06-30 08:30:57.671253
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.679762	2025-06-30 08:30:57.679762
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.6874	2025-06-30 08:30:57.6874
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.695293	2025-06-30 08:30:57.695293
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.70538	2025-06-30 08:30:57.70538
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.717788	2025-06-30 08:30:57.717788
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.725132	2025-06-30 08:30:57.725132
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.733092	2025-06-30 08:30:57.733092
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.74259	2025-06-30 08:30:57.74259
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.752774	2025-06-30 08:30:57.752774
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.760436	2025-06-30 08:30:57.760436
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.767941	2025-06-30 08:30:57.767941
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.77683	2025-06-30 08:30:57.77683
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.784519	2025-06-30 08:30:57.784519
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.791874	2025-06-30 08:30:57.791874
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.800933	2025-06-30 08:30:57.800933
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.809295	2025-06-30 08:30:57.809295
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.816884	2025-06-30 08:30:57.816884
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.826069	2025-06-30 08:30:57.826069
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.833164	2025-06-30 08:30:57.833164
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.842474	2025-06-30 08:30:57.842474
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.869216	2025-06-30 08:30:57.869216
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.878356	2025-06-30 08:30:57.878356
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.886678	2025-06-30 08:30:57.886678
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.912889	2025-06-30 08:30:57.912889
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.919929	2025-06-30 08:30:57.919929
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.92738	2025-06-30 08:30:57.92738
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.935523	2025-06-30 08:30:57.935523
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.943041	2025-06-30 08:30:57.943041
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.963006	2025-06-30 08:30:57.963006
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.972053	2025-06-30 08:30:57.972053
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.980117	2025-06-30 08:30:57.980117
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.98709	2025-06-30 08:30:57.98709
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:57.995948	2025-06-30 08:30:57.995948
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.003313	2025-06-30 08:30:58.003313
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.011381	2025-06-30 08:30:58.011381
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.019363	2025-06-30 08:30:58.019363
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.026347	2025-06-30 08:30:58.026347
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.034114	2025-06-30 08:30:58.034114
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.043139	2025-06-30 08:30:58.043139
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.050547	2025-06-30 08:30:58.050547
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.089185	2025-06-30 08:30:58.089185
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.09701	2025-06-30 08:30:58.09701
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.113208	2025-06-30 08:30:58.113208
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.120707	2025-06-30 08:30:58.120707
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.128177	2025-06-30 08:30:58.128177
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.1368	2025-06-30 08:30:58.1368
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.153537	2025-06-30 08:30:58.153537
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.168104	2025-06-30 08:30:58.168104
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.182694	2025-06-30 08:30:58.182694
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.197298	2025-06-30 08:30:58.197298
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.206854	2025-06-30 08:30:58.206854
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.216546	2025-06-30 08:30:58.216546
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.233898	2025-06-30 08:30:58.233898
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.254332	2025-06-30 08:30:58.254332
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.285867	2025-06-30 08:30:58.285867
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.302857	2025-06-30 08:30:58.302857
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.321181	2025-06-30 08:30:58.321181
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.333687	2025-06-30 08:30:58.333687
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.37466	2025-06-30 08:30:58.37466
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.394349	2025-06-30 08:30:58.394349
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.403028	2025-06-30 08:30:58.403028
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.441552	2025-06-30 08:30:58.441552
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.45475	2025-06-30 08:30:58.45475
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.473322	2025-06-30 08:30:58.473322
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.492657	2025-06-30 08:30:58.492657
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.515241	2025-06-30 08:30:58.515241
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.529163	2025-06-30 08:30:58.529163
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.554834	2025-06-30 08:30:58.554834
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.572206	2025-06-30 08:30:58.572206
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.586697	2025-06-30 08:30:58.586697
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.605745	2025-06-30 08:30:58.605745
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.629151	2025-06-30 08:30:58.629151
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.646262	2025-06-30 08:30:58.646262
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.6537	2025-06-30 08:30:58.6537
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.670435	2025-06-30 08:30:58.670435
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.679303	2025-06-30 08:30:58.679303
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.68709	2025-06-30 08:30:58.68709
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.695478	2025-06-30 08:30:58.695478
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.70288	2025-06-30 08:30:58.70288
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.711549	2025-06-30 08:30:58.711549
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.720205	2025-06-30 08:30:58.720205
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.72733	2025-06-30 08:30:58.72733
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.736497	2025-06-30 08:30:58.736497
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.744469	2025-06-30 08:30:58.744469
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.763733	2025-06-30 08:30:58.763733
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.770814	2025-06-30 08:30:58.770814
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.778518	2025-06-30 08:30:58.778518
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.787283	2025-06-30 08:30:58.787283
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.794973	2025-06-30 08:30:58.794973
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.825993	2025-06-30 08:30:58.825993
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.832992	2025-06-30 08:30:58.832992
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.841196	2025-06-30 08:30:58.841196
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.85591	2025-06-30 08:30:58.85591
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.865759	2025-06-30 08:30:58.865759
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.873131	2025-06-30 08:30:58.873131
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.88063	2025-06-30 08:30:58.88063
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.888734	2025-06-30 08:30:58.888734
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.89565	2025-06-30 08:30:58.89565
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.903139	2025-06-30 08:30:58.903139
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.910944	2025-06-30 08:30:58.910944
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.933806	2025-06-30 08:30:58.933806
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.94118	2025-06-30 08:30:58.94118
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.94872	2025-06-30 08:30:58.94872
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.957923	2025-06-30 08:30:58.957923
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.9651	2025-06-30 08:30:58.9651
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.972177	2025-06-30 08:30:58.972177
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.977234	2025-06-30 08:30:58.977234
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.984177	2025-06-30 08:30:58.984177
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:58.994226	2025-06-30 08:30:58.994226
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.001586	2025-06-30 08:30:59.001586
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.009129	2025-06-30 08:30:59.009129
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.016175	2025-06-30 08:30:59.016175
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.025762	2025-06-30 08:30:59.025762
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.034683	2025-06-30 08:30:59.034683
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.041709	2025-06-30 08:30:59.041709
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.050557	2025-06-30 08:30:59.050557
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.05887	2025-06-30 08:30:59.05887
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.067279	2025-06-30 08:30:59.067279
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.074633	2025-06-30 08:30:59.074633
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.081153	2025-06-30 08:30:59.081153
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.088795	2025-06-30 08:30:59.088795
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.097377	2025-06-30 08:30:59.097377
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.106095	2025-06-30 08:30:59.106095
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.113077	2025-06-30 08:30:59.113077
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.121052	2025-06-30 08:30:59.121052
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.128398	2025-06-30 08:30:59.128398
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.137046	2025-06-30 08:30:59.137046
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.144063	2025-06-30 08:30:59.144063
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.179578	2025-06-30 08:30:59.179578
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.186846	2025-06-30 08:30:59.186846
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.194082	2025-06-30 08:30:59.194082
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.203395	2025-06-30 08:30:59.203395
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.211272	2025-06-30 08:30:59.211272
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.220059	2025-06-30 08:30:59.220059
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.227544	2025-06-30 08:30:59.227544
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.235267	2025-06-30 08:30:59.235267
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.242232	2025-06-30 08:30:59.242232
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.250822	2025-06-30 08:30:59.250822
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.261861	2025-06-30 08:30:59.261861
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.269717	2025-06-30 08:30:59.269717
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.27793	2025-06-30 08:30:59.27793
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.285665	2025-06-30 08:30:59.285665
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.293481	2025-06-30 08:30:59.293481
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.301319	2025-06-30 08:30:59.301319
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.312158	2025-06-30 08:30:59.312158
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.321468	2025-06-30 08:30:59.321468
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.329196	2025-06-30 08:30:59.329196
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.33718	2025-06-30 08:30:59.33718
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.344404	2025-06-30 08:30:59.344404
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.355849	2025-06-30 08:30:59.355849
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.363126	2025-06-30 08:30:59.363126
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.370649	2025-06-30 08:30:59.370649
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.37967	2025-06-30 08:30:59.37967
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.388369	2025-06-30 08:30:59.388369
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.396268	2025-06-30 08:30:59.396268
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.405066	2025-06-30 08:30:59.405066
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.412378	2025-06-30 08:30:59.412378
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.420448	2025-06-30 08:30:59.420448
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.428132	2025-06-30 08:30:59.428132
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.435749	2025-06-30 08:30:59.435749
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.442619	2025-06-30 08:30:59.442619
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.451444	2025-06-30 08:30:59.451444
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.458832	2025-06-30 08:30:59.458832
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.467495	2025-06-30 08:30:59.467495
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.475404	2025-06-30 08:30:59.475404
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.484747	2025-06-30 08:30:59.484747
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.500528	2025-06-30 08:30:59.500528
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.509358	2025-06-30 08:30:59.509358
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.517149	2025-06-30 08:30:59.517149
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.525893	2025-06-30 08:30:59.525893
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.534897	2025-06-30 08:30:59.534897
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.542149	2025-06-30 08:30:59.542149
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.550312	2025-06-30 08:30:59.550312
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.557954	2025-06-30 08:30:59.557954
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.565722	2025-06-30 08:30:59.565722
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.573661	2025-06-30 08:30:59.573661
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.583676	2025-06-30 08:30:59.583676
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.590985	2025-06-30 08:30:59.590985
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.598427	2025-06-30 08:30:59.598427
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.60628	2025-06-30 08:30:59.60628
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.614888	2025-06-30 08:30:59.614888
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.622224	2025-06-30 08:30:59.622224
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.63031	2025-06-30 08:30:59.63031
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.641679	2025-06-30 08:30:59.641679
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.65088	2025-06-30 08:30:59.65088
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.658184	2025-06-30 08:30:59.658184
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.666397	2025-06-30 08:30:59.666397
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.674318	2025-06-30 08:30:59.674318
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.682693	2025-06-30 08:30:59.682693
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.690831	2025-06-30 08:30:59.690831
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.708417	2025-06-30 08:30:59.708417
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.715564	2025-06-30 08:30:59.715564
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.724539	2025-06-30 08:30:59.724539
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.731305	2025-06-30 08:30:59.731305
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.769881	2025-06-30 08:30:59.769881
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.776386	2025-06-30 08:30:59.776386
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.813421	2025-06-30 08:30:59.813421
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.820588	2025-06-30 08:30:59.820588
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.828472	2025-06-30 08:30:59.828472
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.83492	2025-06-30 08:30:59.83492
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.842609	2025-06-30 08:30:59.842609
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.851234	2025-06-30 08:30:59.851234
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.858928	2025-06-30 08:30:59.858928
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.875218	2025-06-30 08:30:59.875218
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.882383	2025-06-30 08:30:59.882383
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.889281	2025-06-30 08:30:59.889281
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.900893	2025-06-30 08:30:59.900893
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.918004	2025-06-30 08:30:59.918004
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.931668	2025-06-30 08:30:59.931668
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.953979	2025-06-30 08:30:59.953979
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.967829	2025-06-30 08:30:59.967829
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.983038	2025-06-30 08:30:59.983038
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:30:59.99639	2025-06-30 08:30:59.99639
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.010057	2025-06-30 08:31:00.010057
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.023354	2025-06-30 08:31:00.023354
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.037902	2025-06-30 08:31:00.037902
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.051051	2025-06-30 08:31:00.051051
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.0638	2025-06-30 08:31:00.0638
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.077805	2025-06-30 08:31:00.077805
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.090417	2025-06-30 08:31:00.090417
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.104471	2025-06-30 08:31:00.104471
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.119209	2025-06-30 08:31:00.119209
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.144512	2025-06-30 08:31:00.144512
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.158887	2025-06-30 08:31:00.158887
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.171027	2025-06-30 08:31:00.171027
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.187059	2025-06-30 08:31:00.187059
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.201974	2025-06-30 08:31:00.201974
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.214334	2025-06-30 08:31:00.214334
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.226873	2025-06-30 08:31:00.226873
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.242216	2025-06-30 08:31:00.242216
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.255979	2025-06-30 08:31:00.255979
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.268835	2025-06-30 08:31:00.268835
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.282344	2025-06-30 08:31:00.282344
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.295994	2025-06-30 08:31:00.295994
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.310565	2025-06-30 08:31:00.310565
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.324602	2025-06-30 08:31:00.324602
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.336467	2025-06-30 08:31:00.336467
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.352882	2025-06-30 08:31:00.352882
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.364779	2025-06-30 08:31:00.364779
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.378298	2025-06-30 08:31:00.378298
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.393348	2025-06-30 08:31:00.393348
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.400174	2025-06-30 08:31:00.400174
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.407316	2025-06-30 08:31:00.407316
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.414783	2025-06-30 08:31:00.414783
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.423797	2025-06-30 08:31:00.423797
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.430936	2025-06-30 08:31:00.430936
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.438729	2025-06-30 08:31:00.438729
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.448497	2025-06-30 08:31:00.448497
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.463788	2025-06-30 08:31:00.463788
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.471285	2025-06-30 08:31:00.471285
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.478455	2025-06-30 08:31:00.478455
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.486311	2025-06-30 08:31:00.486311
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.493473	2025-06-30 08:31:00.493473
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.506078	2025-06-30 08:31:00.506078
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.514166	2025-06-30 08:31:00.514166
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.522673	2025-06-30 08:31:00.522673
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.558621	2025-06-30 08:31:00.558621
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.56979	2025-06-30 08:31:00.56979
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.580222	2025-06-30 08:31:00.580222
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.587245	2025-06-30 08:31:00.587245
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.598842	2025-06-30 08:31:00.598842
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.607923	2025-06-30 08:31:00.607923
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.617828	2025-06-30 08:31:00.617828
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.626868	2025-06-30 08:31:00.626868
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.633873	2025-06-30 08:31:00.633873
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.644632	2025-06-30 08:31:00.644632
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.651032	2025-06-30 08:31:00.651032
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.658442	2025-06-30 08:31:00.658442
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.665916	2025-06-30 08:31:00.665916
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.673589	2025-06-30 08:31:00.673589
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.680781	2025-06-30 08:31:00.680781
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.692733	2025-06-30 08:31:00.692733
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.701999	2025-06-30 08:31:00.701999
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.709146	2025-06-30 08:31:00.709146
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.71673	2025-06-30 08:31:00.71673
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.724613	2025-06-30 08:31:00.724613
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.732496	2025-06-30 08:31:00.732496
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.740063	2025-06-30 08:31:00.740063
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.746629	2025-06-30 08:31:00.746629
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.754813	2025-06-30 08:31:00.754813
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.793517	2025-06-30 08:31:00.793517
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.800842	2025-06-30 08:31:00.800842
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.809387	2025-06-30 08:31:00.809387
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.817386	2025-06-30 08:31:00.817386
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.827359	2025-06-30 08:31:00.827359
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.845687	2025-06-30 08:31:00.845687
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.852972	2025-06-30 08:31:00.852972
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.862001	2025-06-30 08:31:00.862001
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.86993	2025-06-30 08:31:00.86993
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.879088	2025-06-30 08:31:00.879088
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.888242	2025-06-30 08:31:00.888242
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.897408	2025-06-30 08:31:00.897408
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.90477	2025-06-30 08:31:00.90477
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.913201	2025-06-30 08:31:00.913201
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.919722	2025-06-30 08:31:00.919722
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.929185	2025-06-30 08:31:00.929185
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.943464	2025-06-30 08:31:00.943464
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.952063	2025-06-30 08:31:00.952063
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.982151	2025-06-30 08:31:00.982151
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:00.98974	2025-06-30 08:31:00.98974
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.020659	2025-06-30 08:31:01.020659
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.029149	2025-06-30 08:31:01.029149
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.036603	2025-06-30 08:31:01.036603
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.053225	2025-06-30 08:31:01.053225
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.062057	2025-06-30 08:31:01.062057
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.099686	2025-06-30 08:31:01.099686
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:01.108957	2025-06-30 08:31:01.108957
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.116601	2025-06-30 08:31:01.116601
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.124141	2025-06-30 08:31:01.124141
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.134931	2025-06-30 08:31:01.134931
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.14565	2025-06-30 08:31:01.14565
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.166941	2025-06-30 08:31:01.166941
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.187018	2025-06-30 08:31:01.187018
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.201236	2025-06-30 08:31:01.201236
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.213771	2025-06-30 08:31:01.213771
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.227109	2025-06-30 08:31:01.227109
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.271564	2025-06-30 08:31:01.271564
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.283787	2025-06-30 08:31:01.283787
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.297943	2025-06-30 08:31:01.297943
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.309873	2025-06-30 08:31:01.309873
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.322992	2025-06-30 08:31:01.322992
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.335054	2025-06-30 08:31:01.335054
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.347961	2025-06-30 08:31:01.347961
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.361241	2025-06-30 08:31:01.361241
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.373736	2025-06-30 08:31:01.373736
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.387483	2025-06-30 08:31:01.387483
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.400403	2025-06-30 08:31:01.400403
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.439425	2025-06-30 08:31:01.439425
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.45217	2025-06-30 08:31:01.45217
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.46804	2025-06-30 08:31:01.46804
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.500046	2025-06-30 08:31:01.500046
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.516978	2025-06-30 08:31:01.516978
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.530215	2025-06-30 08:31:01.530215
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.551986	2025-06-30 08:31:01.551986
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.564316	2025-06-30 08:31:01.564316
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.578249	2025-06-30 08:31:01.578249
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.607451	2025-06-30 08:31:01.607451
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.623299	2025-06-30 08:31:01.623299
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.637056	2025-06-30 08:31:01.637056
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.652997	2025-06-30 08:31:01.652997
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.666323	2025-06-30 08:31:01.666323
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.680077	2025-06-30 08:31:01.680077
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.712836	2025-06-30 08:31:01.712836
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.727038	2025-06-30 08:31:01.727038
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.749836	2025-06-30 08:31:01.749836
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.762843	2025-06-30 08:31:01.762843
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.781611	2025-06-30 08:31:01.781611
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.795071	2025-06-30 08:31:01.795071
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.806998	2025-06-30 08:31:01.806998
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.820454	2025-06-30 08:31:01.820454
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.834327	2025-06-30 08:31:01.834327
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.850136	2025-06-30 08:31:01.850136
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.863936	2025-06-30 08:31:01.863936
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.876951	2025-06-30 08:31:01.876951
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.891356	2025-06-30 08:31:01.891356
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.898699	2025-06-30 08:31:01.898699
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.92404	2025-06-30 08:31:01.92404
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.933985	2025-06-30 08:31:01.933985
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.942836	2025-06-30 08:31:01.942836
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.951414	2025-06-30 08:31:01.951414
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.958302	2025-06-30 08:31:01.958302
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.96766	2025-06-30 08:31:01.96766
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.975386	2025-06-30 08:31:01.975386
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.984213	2025-06-30 08:31:01.984213
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:01.99224	2025-06-30 08:31:01.99224
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.001018	2025-06-30 08:31:02.001018
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.012006	2025-06-30 08:31:02.012006
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.032538	2025-06-30 08:31:02.032538
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.038933	2025-06-30 08:31:02.038933
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.048013	2025-06-30 08:31:02.048013
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.057464	2025-06-30 08:31:02.057464
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.066138	2025-06-30 08:31:02.066138
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.074847	2025-06-30 08:31:02.074847
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.084389	2025-06-30 08:31:02.084389
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.092053	2025-06-30 08:31:02.092053
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.101519	2025-06-30 08:31:02.101519
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.108778	2025-06-30 08:31:02.108778
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.116779	2025-06-30 08:31:02.116779
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.124693	2025-06-30 08:31:02.124693
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.140042	2025-06-30 08:31:02.140042
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.159389	2025-06-30 08:31:02.159389
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.167737	2025-06-30 08:31:02.167737
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.177192	2025-06-30 08:31:02.177192
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.184655	2025-06-30 08:31:02.184655
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.195603	2025-06-30 08:31:02.195603
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.202782	2025-06-30 08:31:02.202782
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.215912	2025-06-30 08:31:02.215912
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.223946	2025-06-30 08:31:02.223946
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.235426	2025-06-30 08:31:02.235426
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.246952	2025-06-30 08:31:02.246952
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.263566	2025-06-30 08:31:02.263566
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.271796	2025-06-30 08:31:02.271796
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.301516	2025-06-30 08:31:02.301516
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.309455	2025-06-30 08:31:02.309455
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.318191	2025-06-30 08:31:02.318191
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.337192	2025-06-30 08:31:02.337192
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.345089	2025-06-30 08:31:02.345089
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.377678	2025-06-30 08:31:02.377678
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.388478	2025-06-30 08:31:02.388478
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.421283	2025-06-30 08:31:02.421283
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.446044	2025-06-30 08:31:02.446044
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.471063	2025-06-30 08:31:02.471063
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.497161	2025-06-30 08:31:02.497161
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.514999	2025-06-30 08:31:02.514999
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.537127	2025-06-30 08:31:02.537127
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.556507	2025-06-30 08:31:02.556507
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.596156	2025-06-30 08:31:02.596156
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.6176	2025-06-30 08:31:02.6176
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.639659	2025-06-30 08:31:02.639659
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.648675	2025-06-30 08:31:02.648675
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.661752	2025-06-30 08:31:02.661752
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.671191	2025-06-30 08:31:02.671191
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.681449	2025-06-30 08:31:02.681449
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.69401	2025-06-30 08:31:02.69401
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.703694	2025-06-30 08:31:02.703694
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.716811	2025-06-30 08:31:02.716811
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.729247	2025-06-30 08:31:02.729247
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.73909	2025-06-30 08:31:02.73909
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.749143	2025-06-30 08:31:02.749143
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.759284	2025-06-30 08:31:02.759284
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.768079	2025-06-30 08:31:02.768079
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.778381	2025-06-30 08:31:02.778381
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.786713	2025-06-30 08:31:02.786713
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.796658	2025-06-30 08:31:02.796658
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.806983	2025-06-30 08:31:02.806983
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.816009	2025-06-30 08:31:02.816009
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.824913	2025-06-30 08:31:02.824913
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.834246	2025-06-30 08:31:02.834246
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.845411	2025-06-30 08:31:02.845411
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.855868	2025-06-30 08:31:02.855868
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.865374	2025-06-30 08:31:02.865374
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.876601	2025-06-30 08:31:02.876601
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.890584	2025-06-30 08:31:02.890584
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.901523	2025-06-30 08:31:02.901523
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.913525	2025-06-30 08:31:02.913525
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.923156	2025-06-30 08:31:02.923156
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.932497	2025-06-30 08:31:02.932497
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.940503	2025-06-30 08:31:02.940503
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.950898	2025-06-30 08:31:02.950898
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.95808	2025-06-30 08:31:02.95808
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.96566	2025-06-30 08:31:02.96566
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.977792	2025-06-30 08:31:02.977792
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.988133	2025-06-30 08:31:02.988133
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:02.997867	2025-06-30 08:31:02.997867
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.039387	2025-06-30 08:31:03.039387
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.048695	2025-06-30 08:31:03.048695
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.058498	2025-06-30 08:31:03.058498
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.069345	2025-06-30 08:31:03.069345
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.080149	2025-06-30 08:31:03.080149
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.08899	2025-06-30 08:31:03.08899
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.09889	2025-06-30 08:31:03.09889
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.10974	2025-06-30 08:31:03.10974
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.12035	2025-06-30 08:31:03.12035
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.14123	2025-06-30 08:31:03.14123
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.15209	2025-06-30 08:31:03.15209
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.16521	2025-06-30 08:31:03.16521
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.175779	2025-06-30 08:31:03.175779
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.186176	2025-06-30 08:31:03.186176
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.197183	2025-06-30 08:31:03.197183
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.206547	2025-06-30 08:31:03.206547
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.213908	2025-06-30 08:31:03.213908
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.221509	2025-06-30 08:31:03.221509
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.229153	2025-06-30 08:31:03.229153
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.237536	2025-06-30 08:31:03.237536
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.248139	2025-06-30 08:31:03.248139
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.256549	2025-06-30 08:31:03.256549
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.266862	2025-06-30 08:31:03.266862
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.275645	2025-06-30 08:31:03.275645
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.284965	2025-06-30 08:31:03.284965
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.292994	2025-06-30 08:31:03.292994
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.302019	2025-06-30 08:31:03.302019
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.313362	2025-06-30 08:31:03.313362
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.32159	2025-06-30 08:31:03.32159
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.329332	2025-06-30 08:31:03.329332
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.338569	2025-06-30 08:31:03.338569
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.346501	2025-06-30 08:31:03.346501
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.356362	2025-06-30 08:31:03.356362
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.365816	2025-06-30 08:31:03.365816
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.374907	2025-06-30 08:31:03.374907
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.384282	2025-06-30 08:31:03.384282
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.392141	2025-06-30 08:31:03.392141
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.399189	2025-06-30 08:31:03.399189
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.434201	2025-06-30 08:31:03.434201
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.449064	2025-06-30 08:31:03.449064
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.460848	2025-06-30 08:31:03.460848
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.46873	2025-06-30 08:31:03.46873
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.477138	2025-06-30 08:31:03.477138
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.485686	2025-06-30 08:31:03.485686
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.493762	2025-06-30 08:31:03.493762
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.532867	2025-06-30 08:31:03.532867
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.54091	2025-06-30 08:31:03.54091
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.54966	2025-06-30 08:31:03.54966
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.559302	2025-06-30 08:31:03.559302
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.568222	2025-06-30 08:31:03.568222
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.578171	2025-06-30 08:31:03.578171
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.590882	2025-06-30 08:31:03.590882
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.598146	2025-06-30 08:31:03.598146
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.60737	2025-06-30 08:31:03.60737
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.615558	2025-06-30 08:31:03.615558
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.623135	2025-06-30 08:31:03.623135
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.631207	2025-06-30 08:31:03.631207
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.647972	2025-06-30 08:31:03.647972
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.661193	2025-06-30 08:31:03.661193
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.67398	2025-06-30 08:31:03.67398
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.690255	2025-06-30 08:31:03.690255
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.704085	2025-06-30 08:31:03.704085
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.73118	2025-06-30 08:31:03.73118
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.744196	2025-06-30 08:31:03.744196
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.757987	2025-06-30 08:31:03.757987
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.771292	2025-06-30 08:31:03.771292
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.816444	2025-06-30 08:31:03.816444
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.830553	2025-06-30 08:31:03.830553
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.873244	2025-06-30 08:31:03.873244
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.888297	2025-06-30 08:31:03.888297
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.902735	2025-06-30 08:31:03.902735
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.931337	2025-06-30 08:31:03.931337
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.944467	2025-06-30 08:31:03.944467
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.957662	2025-06-30 08:31:03.957662
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.971259	2025-06-30 08:31:03.971259
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:03.987082	2025-06-30 08:31:03.987082
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.001015	2025-06-30 08:31:04.001015
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.020149	2025-06-30 08:31:04.020149
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.033658	2025-06-30 08:31:04.033658
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.057563	2025-06-30 08:31:04.057563
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.072733	2025-06-30 08:31:04.072733
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.088422	2025-06-30 08:31:04.088422
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.102157	2025-06-30 08:31:04.102157
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.115122	2025-06-30 08:31:04.115122
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.130753	2025-06-30 08:31:04.130753
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.145535	2025-06-30 08:31:04.145535
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.159603	2025-06-30 08:31:04.159603
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.172519	2025-06-30 08:31:04.172519
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.188269	2025-06-30 08:31:04.188269
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.201136	2025-06-30 08:31:04.201136
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.2144	2025-06-30 08:31:04.2144
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.226765	2025-06-30 08:31:04.226765
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.240343	2025-06-30 08:31:04.240343
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.255273	2025-06-30 08:31:04.255273
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.269677	2025-06-30 08:31:04.269677
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.288086	2025-06-30 08:31:04.288086
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.302716	2025-06-30 08:31:04.302716
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.317815	2025-06-30 08:31:04.317815
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.332314	2025-06-30 08:31:04.332314
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.347458	2025-06-30 08:31:04.347458
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.360673	2025-06-30 08:31:04.360673
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.378662	2025-06-30 08:31:04.378662
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.395541	2025-06-30 08:31:04.395541
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.405508	2025-06-30 08:31:04.405508
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.415963	2025-06-30 08:31:04.415963
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.424712	2025-06-30 08:31:04.424712
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.432217	2025-06-30 08:31:04.432217
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.440043	2025-06-30 08:31:04.440043
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.473261	2025-06-30 08:31:04.473261
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.484021	2025-06-30 08:31:04.484021
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.491392	2025-06-30 08:31:04.491392
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.499207	2025-06-30 08:31:04.499207
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.506791	2025-06-30 08:31:04.506791
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.514332	2025-06-30 08:31:04.514332
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.546023	2025-06-30 08:31:04.546023
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.552858	2025-06-30 08:31:04.552858
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.56112	2025-06-30 08:31:04.56112
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.570204	2025-06-30 08:31:04.570204
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.578997	2025-06-30 08:31:04.578997
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.587621	2025-06-30 08:31:04.587621
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.598405	2025-06-30 08:31:04.598405
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.610908	2025-06-30 08:31:04.610908
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.618029	2025-06-30 08:31:04.618029
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.624823	2025-06-30 08:31:04.624823
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.633368	2025-06-30 08:31:04.633368
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.640169	2025-06-30 08:31:04.640169
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.646883	2025-06-30 08:31:04.646883
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.654387	2025-06-30 08:31:04.654387
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.661531	2025-06-30 08:31:04.661531
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.669558	2025-06-30 08:31:04.669558
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.676245	2025-06-30 08:31:04.676245
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.68439	2025-06-30 08:31:04.68439
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.691622	2025-06-30 08:31:04.691622
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.699543	2025-06-30 08:31:04.699543
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.706552	2025-06-30 08:31:04.706552
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.715987	2025-06-30 08:31:04.715987
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.722825	2025-06-30 08:31:04.722825
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.731589	2025-06-30 08:31:04.731589
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.741087	2025-06-30 08:31:04.741087
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.748391	2025-06-30 08:31:04.748391
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.757058	2025-06-30 08:31:04.757058
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.764539	2025-06-30 08:31:04.764539
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.773962	2025-06-30 08:31:04.773962
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.782247	2025-06-30 08:31:04.782247
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.790011	2025-06-30 08:31:04.790011
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.797676	2025-06-30 08:31:04.797676
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.805375	2025-06-30 08:31:04.805375
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.81336	2025-06-30 08:31:04.81336
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.82931	2025-06-30 08:31:04.82931
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.837729	2025-06-30 08:31:04.837729
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.845229	2025-06-30 08:31:04.845229
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.854468	2025-06-30 08:31:04.854468
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.862001	2025-06-30 08:31:04.862001
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.869624	2025-06-30 08:31:04.869624
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.879044	2025-06-30 08:31:04.879044
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.888092	2025-06-30 08:31:04.888092
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:04.895274	2025-06-30 08:31:04.895274
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-30 08:30:38.729164
2	ART Coverage	\N	\N	2025-06-30 08:30:38.734157
3	People Living with HIV	\N	\N	2025-06-30 08:30:38.738621
4	HIV-related Deaths	\N	\N	2025-06-30 08:30:38.743531
5	HIV Cases Adults 15-49	\N	\N	2025-06-30 08:30:38.748315
6	ART Pediatric Coverage	\N	\N	2025-06-30 08:30:38.75358
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$/vWsCoV0OBYRnlFOQB7Kq.gzw4HpEJN0relocjjHBeUwEiUoMnWdm	admin	0	2025-06-30 08:30:38.718279	2025-06-30 08:30:38.718279
2	userch	$2b$12$U2zUF6EvWuFcn/8zufkpPeMRNzSmYyeEvuIzOvxj8gJfdRnNKQK3.	user	0	2025-06-30 08:30:38.721521	2025-06-30 08:30:38.721521
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

