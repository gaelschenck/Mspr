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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 16:26:09.544037	2025-06-29 16:26:09.544037
2	Albania	Europe	\N	2025-06-29 16:26:09.579867	2025-06-29 16:26:09.579867
3	Algeria	Africa	\N	2025-06-29 16:26:09.596444	2025-06-29 16:26:09.596444
4	Angola	Africa	\N	2025-06-29 16:26:09.60904	2025-06-29 16:26:09.60904
5	Argentina	Americas	\N	2025-06-29 16:26:09.621856	2025-06-29 16:26:09.621856
6	Armenia	Europe	\N	2025-06-29 16:26:09.632771	2025-06-29 16:26:09.632771
7	Australia	Western Pacific	\N	2025-06-29 16:26:09.650832	2025-06-29 16:26:09.650832
8	Austria	Europe	\N	2025-06-29 16:26:09.666095	2025-06-29 16:26:09.666095
9	Azerbaijan	Europe	\N	2025-06-29 16:26:09.681312	2025-06-29 16:26:09.681312
10	Bahamas	Americas	\N	2025-06-29 16:26:09.714705	2025-06-29 16:26:09.714705
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 16:26:09.735782	2025-06-29 16:26:09.735782
12	Bangladesh	South-East Asia	\N	2025-06-29 16:26:09.751861	2025-06-29 16:26:09.751861
13	Barbados	Americas	\N	2025-06-29 16:26:09.763355	2025-06-29 16:26:09.763355
14	Belarus	Europe	\N	2025-06-29 16:26:09.78168	2025-06-29 16:26:09.78168
15	Belgium	Europe	\N	2025-06-29 16:26:09.805339	2025-06-29 16:26:09.805339
16	Belize	Americas	\N	2025-06-29 16:26:09.814121	2025-06-29 16:26:09.814121
17	Benin	Africa	\N	2025-06-29 16:26:09.842716	2025-06-29 16:26:09.842716
18	Bhutan	South-East Asia	\N	2025-06-29 16:26:09.865646	2025-06-29 16:26:09.865646
19	Bolivia	Americas	\N	2025-06-29 16:26:09.891634	2025-06-29 16:26:09.891634
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 16:26:09.902761	2025-06-29 16:26:09.902761
21	Botswana	Africa	\N	2025-06-29 16:26:09.923359	2025-06-29 16:26:09.923359
22	Brazil	Americas	\N	2025-06-29 16:26:09.937222	2025-06-29 16:26:09.937222
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 16:26:09.95157	2025-06-29 16:26:09.95157
24	Bulgaria	Europe	\N	2025-06-29 16:26:09.965348	2025-06-29 16:26:09.965348
25	Burkina Faso	Africa	\N	2025-06-29 16:26:09.982311	2025-06-29 16:26:09.982311
26	Burundi	Africa	\N	2025-06-29 16:26:09.998263	2025-06-29 16:26:09.998263
27	Cabo Verde	Africa	\N	2025-06-29 16:26:10.014787	2025-06-29 16:26:10.014787
28	Cambodia	Western Pacific	\N	2025-06-29 16:26:10.026143	2025-06-29 16:26:10.026143
29	Cameroon	Africa	\N	2025-06-29 16:26:10.056247	2025-06-29 16:26:10.056247
30	Canada	Americas	\N	2025-06-29 16:26:10.073454	2025-06-29 16:26:10.073454
31	Central African Republic	Africa	\N	2025-06-29 16:26:10.094952	2025-06-29 16:26:10.094952
32	Chad	Africa	\N	2025-06-29 16:26:10.104893	2025-06-29 16:26:10.104893
33	Chile	Americas	\N	2025-06-29 16:26:10.12512	2025-06-29 16:26:10.12512
34	China	Western Pacific	\N	2025-06-29 16:26:10.151486	2025-06-29 16:26:10.151486
35	Colombia	Americas	\N	2025-06-29 16:26:10.185888	2025-06-29 16:26:10.185888
36	Comoros	Africa	\N	2025-06-29 16:26:10.205717	2025-06-29 16:26:10.205717
37	Congo	Americas	\N	2025-06-29 16:26:10.217678	2025-06-29 16:26:10.217678
38	Costa Rica	Americas	\N	2025-06-29 16:26:10.23401	2025-06-29 16:26:10.23401
39	Côte d'Ivoire	Africa	\N	2025-06-29 16:26:10.24531	2025-06-29 16:26:10.24531
40	Croatia	Europe	\N	2025-06-29 16:26:10.256382	2025-06-29 16:26:10.256382
41	Cuba	Americas	\N	2025-06-29 16:26:10.274477	2025-06-29 16:26:10.274477
42	Cyprus	Europe	\N	2025-06-29 16:26:10.286976	2025-06-29 16:26:10.286976
43	Czechia	Europe	\N	2025-06-29 16:26:10.30303	2025-06-29 16:26:10.30303
44	North Korea	Western Pacific	\N	2025-06-29 16:26:10.317352	2025-06-29 16:26:10.317352
45	DR Congo	Africa	\N	2025-06-29 16:26:10.330238	2025-06-29 16:26:10.330238
46	Denmark	Europe	\N	2025-06-29 16:26:10.34068	2025-06-29 16:26:10.34068
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 16:26:10.357809	2025-06-29 16:26:10.357809
48	Dominican Republic	Americas	\N	2025-06-29 16:26:10.369234	2025-06-29 16:26:10.369234
49	Ecuador	Americas	\N	2025-06-29 16:26:10.381028	2025-06-29 16:26:10.381028
50	Egypt	Eastern Mediterranean	\N	2025-06-29 16:26:10.397533	2025-06-29 16:26:10.397533
51	El Salvador	Americas	\N	2025-06-29 16:26:10.410445	2025-06-29 16:26:10.410445
52	Equatorial Guinea	Africa	\N	2025-06-29 16:26:10.422784	2025-06-29 16:26:10.422784
53	Eritrea	Africa	\N	2025-06-29 16:26:10.436388	2025-06-29 16:26:10.436388
54	Estonia	Europe	\N	2025-06-29 16:26:10.459132	2025-06-29 16:26:10.459132
55	Eswatini	Africa	\N	2025-06-29 16:26:10.489324	2025-06-29 16:26:10.489324
56	Ethiopia	Africa	\N	2025-06-29 16:26:10.504188	2025-06-29 16:26:10.504188
57	Fiji	Western Pacific	\N	2025-06-29 16:26:10.51554	2025-06-29 16:26:10.51554
58	Finland	Europe	\N	2025-06-29 16:26:10.53108	2025-06-29 16:26:10.53108
59	France	Europe	\N	2025-06-29 16:26:10.548278	2025-06-29 16:26:10.548278
60	Gabon	Africa	\N	2025-06-29 16:26:10.571312	2025-06-29 16:26:10.571312
61	Gambia	Africa	\N	2025-06-29 16:26:10.585539	2025-06-29 16:26:10.585539
62	Georgia	Europe	\N	2025-06-29 16:26:10.603227	2025-06-29 16:26:10.603227
63	Germany	Europe	\N	2025-06-29 16:26:10.629036	2025-06-29 16:26:10.629036
64	Ghana	Africa	\N	2025-06-29 16:26:10.643734	2025-06-29 16:26:10.643734
65	Greece	Europe	\N	2025-06-29 16:26:10.673071	2025-06-29 16:26:10.673071
66	Guatemala	Americas	\N	2025-06-29 16:26:10.690722	2025-06-29 16:26:10.690722
67	Guinea	Africa	\N	2025-06-29 16:26:10.709008	2025-06-29 16:26:10.709008
68	Guinea-Bissau	Africa	\N	2025-06-29 16:26:10.728928	2025-06-29 16:26:10.728928
69	Guyana	Americas	\N	2025-06-29 16:26:10.763217	2025-06-29 16:26:10.763217
70	Haiti	Americas	\N	2025-06-29 16:26:10.794288	2025-06-29 16:26:10.794288
71	Honduras	Americas	\N	2025-06-29 16:26:10.819979	2025-06-29 16:26:10.819979
72	Hungary	Europe	\N	2025-06-29 16:26:10.842579	2025-06-29 16:26:10.842579
73	Iceland	Europe	\N	2025-06-29 16:26:10.864266	2025-06-29 16:26:10.864266
74	India	South-East Asia	\N	2025-06-29 16:26:10.874384	2025-06-29 16:26:10.874384
75	Indonesia	South-East Asia	\N	2025-06-29 16:26:10.889911	2025-06-29 16:26:10.889911
76	Iran	Eastern Mediterranean	\N	2025-06-29 16:26:10.907889	2025-06-29 16:26:10.907889
77	Ireland	Europe	\N	2025-06-29 16:26:10.929246	2025-06-29 16:26:10.929246
78	Israel	Europe	\N	2025-06-29 16:26:10.941405	2025-06-29 16:26:10.941405
79	Italy	Europe	\N	2025-06-29 16:26:10.972831	2025-06-29 16:26:10.972831
80	Jamaica	Americas	\N	2025-06-29 16:26:10.991214	2025-06-29 16:26:10.991214
81	Japan	Western Pacific	\N	2025-06-29 16:26:11.006448	2025-06-29 16:26:11.006448
82	Jordan	Eastern Mediterranean	\N	2025-06-29 16:26:11.024976	2025-06-29 16:26:11.024976
83	Kazakhstan	Europe	\N	2025-06-29 16:26:11.037633	2025-06-29 16:26:11.037633
84	Kenya	Africa	\N	2025-06-29 16:26:11.060395	2025-06-29 16:26:11.060395
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 16:26:11.078495	2025-06-29 16:26:11.078495
86	Kyrgyzstan	Europe	\N	2025-06-29 16:26:11.093018	2025-06-29 16:26:11.093018
87	Laos	Western Pacific	\N	2025-06-29 16:26:11.104976	2025-06-29 16:26:11.104976
88	Latvia	Europe	\N	2025-06-29 16:26:11.139132	2025-06-29 16:26:11.139132
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 16:26:11.160659	2025-06-29 16:26:11.160659
90	Lesotho	Africa	\N	2025-06-29 16:26:11.191044	2025-06-29 16:26:11.191044
91	Liberia	Africa	\N	2025-06-29 16:26:11.201434	2025-06-29 16:26:11.201434
92	Libya	Eastern Mediterranean	\N	2025-06-29 16:26:11.222523	2025-06-29 16:26:11.222523
93	Lithuania	Europe	\N	2025-06-29 16:26:11.228349	2025-06-29 16:26:11.228349
94	Luxembourg	Europe	\N	2025-06-29 16:26:11.232045	2025-06-29 16:26:11.232045
95	Madagascar	Africa	\N	2025-06-29 16:26:11.2386	2025-06-29 16:26:11.2386
96	Malawi	Africa	\N	2025-06-29 16:26:11.244101	2025-06-29 16:26:11.244101
97	Malaysia	Western Pacific	\N	2025-06-29 16:26:11.24861	2025-06-29 16:26:11.24861
98	Maldives	South-East Asia	\N	2025-06-29 16:26:11.259609	2025-06-29 16:26:11.259609
99	Mali	Africa	\N	2025-06-29 16:26:11.264744	2025-06-29 16:26:11.264744
100	Malta	Europe	\N	2025-06-29 16:26:11.269894	2025-06-29 16:26:11.269894
101	Mauritania	Africa	\N	2025-06-29 16:26:11.278756	2025-06-29 16:26:11.278756
102	Mauritius	Africa	\N	2025-06-29 16:26:11.282951	2025-06-29 16:26:11.282951
103	Mexico	Americas	\N	2025-06-29 16:26:11.289081	2025-06-29 16:26:11.289081
104	Mongolia	Western Pacific	\N	2025-06-29 16:26:11.293601	2025-06-29 16:26:11.293601
105	Montenegro	Europe	\N	2025-06-29 16:26:11.297302	2025-06-29 16:26:11.297302
106	Morocco	Eastern Mediterranean	\N	2025-06-29 16:26:11.301975	2025-06-29 16:26:11.301975
107	Mozambique	Africa	\N	2025-06-29 16:26:11.307022	2025-06-29 16:26:11.307022
108	Myanmar	South-East Asia	\N	2025-06-29 16:26:11.312156	2025-06-29 16:26:11.312156
109	Namibia	Africa	\N	2025-06-29 16:26:11.318105	2025-06-29 16:26:11.318105
110	Nepal	South-East Asia	\N	2025-06-29 16:26:11.322686	2025-06-29 16:26:11.322686
111	Netherlands	Europe	\N	2025-06-29 16:26:11.328059	2025-06-29 16:26:11.328059
112	New Zealand	Western Pacific	\N	2025-06-29 16:26:11.33281	2025-06-29 16:26:11.33281
113	Nicaragua	Americas	\N	2025-06-29 16:26:11.337709	2025-06-29 16:26:11.337709
114	Niger	Africa	\N	2025-06-29 16:26:11.343019	2025-06-29 16:26:11.343019
115	Nigeria	Africa	\N	2025-06-29 16:26:11.347815	2025-06-29 16:26:11.347815
116	Norway	Europe	\N	2025-06-29 16:26:11.352766	2025-06-29 16:26:11.352766
117	Oman	Eastern Mediterranean	\N	2025-06-29 16:26:11.35796	2025-06-29 16:26:11.35796
118	Pakistan	Eastern Mediterranean	\N	2025-06-29 16:26:11.362698	2025-06-29 16:26:11.362698
119	Panama	Americas	\N	2025-06-29 16:26:11.368105	2025-06-29 16:26:11.368105
120	Papua New Guinea	Western Pacific	\N	2025-06-29 16:26:11.373845	2025-06-29 16:26:11.373845
121	Paraguay	Americas	\N	2025-06-29 16:26:11.38885	2025-06-29 16:26:11.38885
122	Peru	Americas	\N	2025-06-29 16:26:11.393718	2025-06-29 16:26:11.393718
123	Philippines	Western Pacific	\N	2025-06-29 16:26:11.398415	2025-06-29 16:26:11.398415
124	Poland	Europe	\N	2025-06-29 16:26:11.41846	2025-06-29 16:26:11.41846
125	Portugal	Europe	\N	2025-06-29 16:26:11.422135	2025-06-29 16:26:11.422135
126	Qatar	Eastern Mediterranean	\N	2025-06-29 16:26:11.427401	2025-06-29 16:26:11.427401
127	South Korea	Western Pacific	\N	2025-06-29 16:26:11.432243	2025-06-29 16:26:11.432243
128	Moldova	Europe	\N	2025-06-29 16:26:11.437669	2025-06-29 16:26:11.437669
129	North Macedonia	Europe	\N	2025-06-29 16:26:11.442667	2025-06-29 16:26:11.442667
130	Romania	Europe	\N	2025-06-29 16:26:11.447377	2025-06-29 16:26:11.447377
131	Russia	Europe	\N	2025-06-29 16:26:11.452254	2025-06-29 16:26:11.452254
132	Rwanda	Africa	\N	2025-06-29 16:26:11.457027	2025-06-29 16:26:11.457027
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-29 16:26:11.46447	2025-06-29 16:26:11.46447
134	Senegal	Africa	\N	2025-06-29 16:26:11.469807	2025-06-29 16:26:11.469807
135	Serbia	Europe	\N	2025-06-29 16:26:11.474744	2025-06-29 16:26:11.474744
136	Sierra Leone	Africa	\N	2025-06-29 16:26:11.480761	2025-06-29 16:26:11.480761
137	Singapore	Western Pacific	\N	2025-06-29 16:26:11.485363	2025-06-29 16:26:11.485363
138	Slovakia	Europe	\N	2025-06-29 16:26:11.489969	2025-06-29 16:26:11.489969
139	Slovenia	Europe	\N	2025-06-29 16:26:11.496653	2025-06-29 16:26:11.496653
140	Somalia	Eastern Mediterranean	\N	2025-06-29 16:26:11.502151	2025-06-29 16:26:11.502151
141	South Africa	Africa	\N	2025-06-29 16:26:11.507617	2025-06-29 16:26:11.507617
142	South Sudan	Africa	\N	2025-06-29 16:26:11.519326	2025-06-29 16:26:11.519326
143	Spain	Europe	\N	2025-06-29 16:26:11.539989	2025-06-29 16:26:11.539989
144	Sri Lanka	South-East Asia	\N	2025-06-29 16:26:11.560865	2025-06-29 16:26:11.560865
145	Sudan	Eastern Mediterranean	\N	2025-06-29 16:26:11.061516	2025-06-29 16:26:11.061516
146	Suriname	Americas	\N	2025-06-29 16:26:10.149921	2025-06-29 16:26:10.149921
147	Sweden	Europe	\N	2025-06-29 16:26:10.16309	2025-06-29 16:26:10.16309
148	Switzerland	Europe	\N	2025-06-29 16:26:10.169233	2025-06-29 16:26:10.169233
149	Syria	Eastern Mediterranean	\N	2025-06-29 16:26:10.188891	2025-06-29 16:26:10.188891
150	Tajikistan	Europe	\N	2025-06-29 16:26:10.194668	2025-06-29 16:26:10.194668
151	Thailand	South-East Asia	\N	2025-06-29 16:26:10.200371	2025-06-29 16:26:10.200371
152	Timor-Leste	South-East Asia	\N	2025-06-29 16:26:10.206642	2025-06-29 16:26:10.206642
153	Togo	Africa	\N	2025-06-29 16:26:10.213304	2025-06-29 16:26:10.213304
154	Trinidad and Tobago	Americas	\N	2025-06-29 16:26:10.22025	2025-06-29 16:26:10.22025
155	Tunisia	Eastern Mediterranean	\N	2025-06-29 16:26:10.229091	2025-06-29 16:26:10.229091
156	Turkey	Europe	\N	2025-06-29 16:26:10.235348	2025-06-29 16:26:10.235348
157	Turkmenistan	Europe	\N	2025-06-29 16:26:10.24239	2025-06-29 16:26:10.24239
158	Uganda	Africa	\N	2025-06-29 16:26:10.248682	2025-06-29 16:26:10.248682
159	Ukraine	Europe	\N	2025-06-29 16:26:10.254868	2025-06-29 16:26:10.254868
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-29 16:26:10.261179	2025-06-29 16:26:10.261179
161	United Kingdom	Europe	\N	2025-06-29 16:26:10.273559	2025-06-29 16:26:10.273559
162	Tanzania	Africa	\N	2025-06-29 16:26:10.284305	2025-06-29 16:26:10.284305
163	United States	Americas	\N	2025-06-29 16:26:10.293655	2025-06-29 16:26:10.293655
164	Uruguay	Americas	\N	2025-06-29 16:26:10.300666	2025-06-29 16:26:10.300666
165	Uzbekistan	Europe	\N	2025-06-29 16:26:10.306835	2025-06-29 16:26:10.306835
166	Venezuela	Americas	\N	2025-06-29 16:26:10.317332	2025-06-29 16:26:10.317332
167	Viet Nam	Western Pacific	\N	2025-06-29 16:26:10.328389	2025-06-29 16:26:10.328389
168	Yemen	Eastern Mediterranean	\N	2025-06-29 16:26:10.34841	2025-06-29 16:26:10.34841
169	Zambia	Africa	\N	2025-06-29 16:26:10.368375	2025-06-29 16:26:10.368375
170	Zimbabwe	Africa	\N	2025-06-29 16:26:10.388169	2025-06-29 16:26:10.388169
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.391419	2025-06-29 16:26:10.391419
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.400705	2025-06-29 16:26:10.400705
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.406918	2025-06-29 16:26:10.406918
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.411362	2025-06-29 16:26:10.411362
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.414533	2025-06-29 16:26:10.414533
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.417562	2025-06-29 16:26:10.417562
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.422641	2025-06-29 16:26:10.422641
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.427449	2025-06-29 16:26:10.427449
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.431782	2025-06-29 16:26:10.431782
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.437081	2025-06-29 16:26:10.437081
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.443505	2025-06-29 16:26:10.443505
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.448397	2025-06-29 16:26:10.448397
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.453375	2025-06-29 16:26:10.453375
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.459349	2025-06-29 16:26:10.459349
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.497148	2025-06-29 16:26:10.497148
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.50191	2025-06-29 16:26:10.50191
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.506723	2025-06-29 16:26:10.506723
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.539713	2025-06-29 16:26:10.539713
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.544729	2025-06-29 16:26:10.544729
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.550192	2025-06-29 16:26:10.550192
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.568416	2025-06-29 16:26:10.568416
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.573498	2025-06-29 16:26:10.573498
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.578265	2025-06-29 16:26:10.578265
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.582955	2025-06-29 16:26:10.582955
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.587873	2025-06-29 16:26:10.587873
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.592306	2025-06-29 16:26:10.592306
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.596778	2025-06-29 16:26:10.596778
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.601733	2025-06-29 16:26:10.601733
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.607178	2025-06-29 16:26:10.607178
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.617124	2025-06-29 16:26:10.617124
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.622874	2025-06-29 16:26:10.622874
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.660962	2025-06-29 16:26:10.660962
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.666636	2025-06-29 16:26:10.666636
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.672086	2025-06-29 16:26:10.672086
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.710413	2025-06-29 16:26:10.710413
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.716464	2025-06-29 16:26:10.716464
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.722244	2025-06-29 16:26:10.722244
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.758235	2025-06-29 16:26:10.758235
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.778277	2025-06-29 16:26:10.778277
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.783466	2025-06-29 16:26:10.783466
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.789975	2025-06-29 16:26:10.789975
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.798224	2025-06-29 16:26:10.798224
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.818251	2025-06-29 16:26:10.818251
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.838317	2025-06-29 16:26:10.838317
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.847353	2025-06-29 16:26:10.847353
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.8684	2025-06-29 16:26:10.8684
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.873488	2025-06-29 16:26:10.873488
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.878387	2025-06-29 16:26:10.878387
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.884834	2025-06-29 16:26:10.884834
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.889314	2025-06-29 16:26:10.889314
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.89391	2025-06-29 16:26:10.89391
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.899586	2025-06-29 16:26:10.899586
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.90414	2025-06-29 16:26:10.90414
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.909176	2025-06-29 16:26:10.909176
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.914825	2025-06-29 16:26:10.914825
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.925467	2025-06-29 16:26:10.925467
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.933619	2025-06-29 16:26:10.933619
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.959555	2025-06-29 16:26:10.959555
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.973138	2025-06-29 16:26:10.973138
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.985609	2025-06-29 16:26:10.985609
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:10.999409	2025-06-29 16:26:10.999409
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.014284	2025-06-29 16:26:11.014284
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.029846	2025-06-29 16:26:11.029846
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.041836	2025-06-29 16:26:11.041836
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.05818	2025-06-29 16:26:11.05818
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.071852	2025-06-29 16:26:11.071852
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.08547	2025-06-29 16:26:11.08547
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.102286	2025-06-29 16:26:11.102286
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.138499	2025-06-29 16:26:11.138499
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.149681	2025-06-29 16:26:11.149681
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.162746	2025-06-29 16:26:11.162746
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.179761	2025-06-29 16:26:11.179761
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.190937	2025-06-29 16:26:11.190937
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.206365	2025-06-29 16:26:11.206365
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.224735	2025-06-29 16:26:11.224735
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.24104	2025-06-29 16:26:11.24104
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.263921	2025-06-29 16:26:11.263921
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.276308	2025-06-29 16:26:11.276308
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.289614	2025-06-29 16:26:11.289614
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.301151	2025-06-29 16:26:11.301151
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.314581	2025-06-29 16:26:11.314581
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.326726	2025-06-29 16:26:11.326726
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.338853	2025-06-29 16:26:11.338853
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.351347	2025-06-29 16:26:11.351347
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.362591	2025-06-29 16:26:11.362591
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.373416	2025-06-29 16:26:11.373416
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.384139	2025-06-29 16:26:11.384139
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.402443	2025-06-29 16:26:11.402443
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.422187	2025-06-29 16:26:11.422187
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.435175	2025-06-29 16:26:11.435175
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.449393	2025-06-29 16:26:11.449393
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.462269	2025-06-29 16:26:11.462269
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.473354	2025-06-29 16:26:11.473354
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.485655	2025-06-29 16:26:11.485655
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.50198	2025-06-29 16:26:11.50198
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.516658	2025-06-29 16:26:11.516658
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.539208	2025-06-29 16:26:11.539208
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.557535	2025-06-29 16:26:11.557535
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.571969	2025-06-29 16:26:11.571969
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.589244	2025-06-29 16:26:11.589244
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.612036	2025-06-29 16:26:11.612036
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.630671	2025-06-29 16:26:11.630671
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.64345	2025-06-29 16:26:11.64345
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.658509	2025-06-29 16:26:11.658509
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.673252	2025-06-29 16:26:11.673252
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.683695	2025-06-29 16:26:11.683695
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.700544	2025-06-29 16:26:11.700544
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.72067	2025-06-29 16:26:11.72067
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.737305	2025-06-29 16:26:11.737305
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.751833	2025-06-29 16:26:11.751833
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.764953	2025-06-29 16:26:11.764953
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.787052	2025-06-29 16:26:11.787052
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.809741	2025-06-29 16:26:11.809741
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.83618	2025-06-29 16:26:11.83618
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.85272	2025-06-29 16:26:11.85272
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.875864	2025-06-29 16:26:11.875864
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.899318	2025-06-29 16:26:11.899318
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.922991	2025-06-29 16:26:11.922991
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.958967	2025-06-29 16:26:11.958967
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:11.980698	2025-06-29 16:26:11.980698
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.002004	2025-06-29 16:26:12.002004
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.034779	2025-06-29 16:26:12.034779
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.060496	2025-06-29 16:26:12.060496
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.08897	2025-06-29 16:26:12.08897
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.105345	2025-06-29 16:26:12.105345
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.122739	2025-06-29 16:26:12.122739
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.135294	2025-06-29 16:26:12.135294
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.147763	2025-06-29 16:26:12.147763
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.16342	2025-06-29 16:26:12.16342
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.225293	2025-06-29 16:26:12.225293
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.250955	2025-06-29 16:26:12.250955
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.278779	2025-06-29 16:26:12.278779
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.296152	2025-06-29 16:26:12.296152
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.316392	2025-06-29 16:26:12.316392
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.328546	2025-06-29 16:26:12.328546
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.348818	2025-06-29 16:26:12.348818
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.370496	2025-06-29 16:26:12.370496
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.386924	2025-06-29 16:26:12.386924
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.40117	2025-06-29 16:26:12.40117
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.420709	2025-06-29 16:26:12.420709
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.437257	2025-06-29 16:26:12.437257
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.453089	2025-06-29 16:26:12.453089
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.464548	2025-06-29 16:26:12.464548
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.476135	2025-06-29 16:26:12.476135
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.494327	2025-06-29 16:26:12.494327
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.539645	2025-06-29 16:26:12.539645
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.551723	2025-06-29 16:26:12.551723
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.572432	2025-06-29 16:26:12.572432
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.683651	2025-06-29 16:26:12.683651
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.714347	2025-06-29 16:26:12.714347
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.731004	2025-06-29 16:26:12.731004
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.748184	2025-06-29 16:26:12.748184
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.772904	2025-06-29 16:26:12.772904
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.793112	2025-06-29 16:26:12.793112
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.817393	2025-06-29 16:26:12.817393
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.828527	2025-06-29 16:26:12.828527
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.844805	2025-06-29 16:26:12.844805
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.859748	2025-06-29 16:26:12.859748
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.870456	2025-06-29 16:26:12.870456
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.882873	2025-06-29 16:26:12.882873
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.898941	2025-06-29 16:26:12.898941
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.91119	2025-06-29 16:26:12.91119
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.930574	2025-06-29 16:26:12.930574
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.943761	2025-06-29 16:26:12.943761
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.95424	2025-06-29 16:26:12.95424
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.969017	2025-06-29 16:26:12.969017
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.979424	2025-06-29 16:26:12.979424
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:12.990293	2025-06-29 16:26:12.990293
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.006789	2025-06-29 16:26:13.006789
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.018877	2025-06-29 16:26:13.018877
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.035392	2025-06-29 16:26:13.035392
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.045523	2025-06-29 16:26:13.045523
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.062493	2025-06-29 16:26:13.062493
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.076376	2025-06-29 16:26:13.076376
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.088323	2025-06-29 16:26:13.088323
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.102243	2025-06-29 16:26:13.102243
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.115427	2025-06-29 16:26:13.115427
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.138013	2025-06-29 16:26:13.138013
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.148825	2025-06-29 16:26:13.148825
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.159752	2025-06-29 16:26:13.159752
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.170408	2025-06-29 16:26:13.170408
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.182192	2025-06-29 16:26:13.182192
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.195139	2025-06-29 16:26:13.195139
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.209703	2025-06-29 16:26:13.209703
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.224281	2025-06-29 16:26:13.224281
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.247656	2025-06-29 16:26:13.247656
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.259627	2025-06-29 16:26:13.259627
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.271046	2025-06-29 16:26:13.271046
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.283159	2025-06-29 16:26:13.283159
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.295957	2025-06-29 16:26:13.295957
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.31107	2025-06-29 16:26:13.31107
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.325788	2025-06-29 16:26:13.325788
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.335969	2025-06-29 16:26:13.335969
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.372596	2025-06-29 16:26:13.372596
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.384949	2025-06-29 16:26:13.384949
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.400177	2025-06-29 16:26:13.400177
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.418796	2025-06-29 16:26:13.418796
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.432907	2025-06-29 16:26:13.432907
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.449383	2025-06-29 16:26:13.449383
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.462233	2025-06-29 16:26:13.462233
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.474924	2025-06-29 16:26:13.474924
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.485454	2025-06-29 16:26:13.485454
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.49728	2025-06-29 16:26:13.49728
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.516636	2025-06-29 16:26:13.516636
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.535489	2025-06-29 16:26:13.535489
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.549432	2025-06-29 16:26:13.549432
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.562954	2025-06-29 16:26:13.562954
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.574172	2025-06-29 16:26:13.574172
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.586441	2025-06-29 16:26:13.586441
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.596237	2025-06-29 16:26:13.596237
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.606188	2025-06-29 16:26:13.606188
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.617357	2025-06-29 16:26:13.617357
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.626928	2025-06-29 16:26:13.626928
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.636724	2025-06-29 16:26:13.636724
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.64624	2025-06-29 16:26:13.64624
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.657356	2025-06-29 16:26:13.657356
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.669357	2025-06-29 16:26:13.669357
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.682701	2025-06-29 16:26:13.682701
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.692875	2025-06-29 16:26:13.692875
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.704565	2025-06-29 16:26:13.704565
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.714692	2025-06-29 16:26:13.714692
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.725614	2025-06-29 16:26:13.725614
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.735372	2025-06-29 16:26:13.735372
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.748775	2025-06-29 16:26:13.748775
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.759071	2025-06-29 16:26:13.759071
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.770115	2025-06-29 16:26:13.770115
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.786895	2025-06-29 16:26:13.786895
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.801107	2025-06-29 16:26:13.801107
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.811086	2025-06-29 16:26:13.811086
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.82297	2025-06-29 16:26:13.82297
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.83792	2025-06-29 16:26:13.83792
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.848993	2025-06-29 16:26:13.848993
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.861959	2025-06-29 16:26:13.861959
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.87256	2025-06-29 16:26:13.87256
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.882367	2025-06-29 16:26:13.882367
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.896059	2025-06-29 16:26:13.896059
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.909829	2025-06-29 16:26:13.909829
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.923584	2025-06-29 16:26:13.923584
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.934026	2025-06-29 16:26:13.934026
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.945605	2025-06-29 16:26:13.945605
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.956382	2025-06-29 16:26:13.956382
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.977434	2025-06-29 16:26:13.977434
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:13.989545	2025-06-29 16:26:13.989545
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.00441	2025-06-29 16:26:14.00441
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.026928	2025-06-29 16:26:14.026928
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.052136	2025-06-29 16:26:14.052136
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.076797	2025-06-29 16:26:14.076797
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.100386	2025-06-29 16:26:14.100386
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.124904	2025-06-29 16:26:14.124904
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.150856	2025-06-29 16:26:14.150856
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.163829	2025-06-29 16:26:14.163829
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.175583	2025-06-29 16:26:14.175583
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.188623	2025-06-29 16:26:14.188623
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.200016	2025-06-29 16:26:14.200016
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.219522	2025-06-29 16:26:14.219522
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.233114	2025-06-29 16:26:14.233114
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.242932	2025-06-29 16:26:14.242932
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.255385	2025-06-29 16:26:14.255385
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.265189	2025-06-29 16:26:14.265189
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.279375	2025-06-29 16:26:14.279375
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.29325	2025-06-29 16:26:14.29325
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.308835	2025-06-29 16:26:14.308835
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.319421	2025-06-29 16:26:14.319421
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.331938	2025-06-29 16:26:14.331938
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.345382	2025-06-29 16:26:14.345382
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.35785	2025-06-29 16:26:14.35785
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.370487	2025-06-29 16:26:14.370487
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.383677	2025-06-29 16:26:14.383677
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.406452	2025-06-29 16:26:14.406452
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.454139	2025-06-29 16:26:14.454139
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.481522	2025-06-29 16:26:14.481522
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.497817	2025-06-29 16:26:14.497817
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.519059	2025-06-29 16:26:14.519059
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.529003	2025-06-29 16:26:14.529003
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.539171	2025-06-29 16:26:14.539171
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.548486	2025-06-29 16:26:14.548486
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.559666	2025-06-29 16:26:14.559666
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.572517	2025-06-29 16:26:14.572517
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.583129	2025-06-29 16:26:14.583129
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.594445	2025-06-29 16:26:14.594445
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.606641	2025-06-29 16:26:14.606641
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.619719	2025-06-29 16:26:14.619719
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.632352	2025-06-29 16:26:14.632352
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.643064	2025-06-29 16:26:14.643064
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.655091	2025-06-29 16:26:14.655091
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.665742	2025-06-29 16:26:14.665742
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.676049	2025-06-29 16:26:14.676049
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.68781	2025-06-29 16:26:14.68781
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.698077	2025-06-29 16:26:14.698077
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.709011	2025-06-29 16:26:14.709011
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.722305	2025-06-29 16:26:14.722305
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.734717	2025-06-29 16:26:14.734717
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.750532	2025-06-29 16:26:14.750532
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.765504	2025-06-29 16:26:14.765504
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.779557	2025-06-29 16:26:14.779557
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.791241	2025-06-29 16:26:14.791241
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.80371	2025-06-29 16:26:14.80371
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.81501	2025-06-29 16:26:14.81501
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.828621	2025-06-29 16:26:14.828621
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.841802	2025-06-29 16:26:14.841802
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.851841	2025-06-29 16:26:14.851841
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.863392	2025-06-29 16:26:14.863392
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.882488	2025-06-29 16:26:14.882488
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:26:14.89615	2025-06-29 16:26:14.89615
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.909555	2025-06-29 16:26:14.909555
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.924422	2025-06-29 16:26:14.924422
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.936333	2025-06-29 16:26:14.936333
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.951911	2025-06-29 16:26:14.951911
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.962446	2025-06-29 16:26:14.962446
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.973348	2025-06-29 16:26:14.973348
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.985838	2025-06-29 16:26:14.985838
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.000145	2025-06-29 16:26:15.000145
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.010082	2025-06-29 16:26:15.010082
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.028613	2025-06-29 16:26:15.028613
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.043496	2025-06-29 16:26:15.043496
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.055799	2025-06-29 16:26:15.055799
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.069918	2025-06-29 16:26:15.069918
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.08099	2025-06-29 16:26:15.08099
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.092617	2025-06-29 16:26:15.092617
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.103463	2025-06-29 16:26:15.103463
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.116145	2025-06-29 16:26:15.116145
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.130278	2025-06-29 16:26:15.130278
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.143556	2025-06-29 16:26:15.143556
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.154211	2025-06-29 16:26:15.154211
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.164406	2025-06-29 16:26:15.164406
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.17521	2025-06-29 16:26:15.17521
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.190339	2025-06-29 16:26:15.190339
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.200217	2025-06-29 16:26:15.200217
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.214254	2025-06-29 16:26:15.214254
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.22573	2025-06-29 16:26:15.22573
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.241614	2025-06-29 16:26:15.241614
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.253746	2025-06-29 16:26:15.253746
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.266185	2025-06-29 16:26:15.266185
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.278922	2025-06-29 16:26:15.278922
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.290922	2025-06-29 16:26:15.290922
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.302327	2025-06-29 16:26:15.302327
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.312474	2025-06-29 16:26:15.312474
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.327534	2025-06-29 16:26:15.327534
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.348593	2025-06-29 16:26:15.348593
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.359768	2025-06-29 16:26:15.359768
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.369943	2025-06-29 16:26:15.369943
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.382205	2025-06-29 16:26:15.382205
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.396742	2025-06-29 16:26:15.396742
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.410191	2025-06-29 16:26:15.410191
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.423648	2025-06-29 16:26:15.423648
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.439772	2025-06-29 16:26:15.439772
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.451306	2025-06-29 16:26:15.451306
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.466851	2025-06-29 16:26:15.466851
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.482231	2025-06-29 16:26:15.482231
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.498787	2025-06-29 16:26:15.498787
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.531707	2025-06-29 16:26:15.531707
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.555961	2025-06-29 16:26:15.555961
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.585522	2025-06-29 16:26:15.585522
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.620173	2025-06-29 16:26:15.620173
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.640032	2025-06-29 16:26:15.640032
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.676098	2025-06-29 16:26:15.676098
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.689857	2025-06-29 16:26:15.689857
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.717559	2025-06-29 16:26:15.717559
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.74672	2025-06-29 16:26:15.74672
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.763875	2025-06-29 16:26:15.763875
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.774532	2025-06-29 16:26:15.774532
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.810676	2025-06-29 16:26:15.810676
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.824316	2025-06-29 16:26:15.824316
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.844788	2025-06-29 16:26:15.844788
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.861836	2025-06-29 16:26:15.861836
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.871255	2025-06-29 16:26:15.871255
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.885262	2025-06-29 16:26:15.885262
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.91226	2025-06-29 16:26:15.91226
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.925584	2025-06-29 16:26:15.925584
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.94101	2025-06-29 16:26:15.94101
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.955655	2025-06-29 16:26:15.955655
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.973045	2025-06-29 16:26:15.973045
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.983846	2025-06-29 16:26:15.983846
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.998161	2025-06-29 16:26:15.998161
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.016612	2025-06-29 16:26:16.016612
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.043003	2025-06-29 16:26:16.043003
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.053996	2025-06-29 16:26:16.053996
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.071501	2025-06-29 16:26:16.071501
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.0846	2025-06-29 16:26:16.0846
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.098019	2025-06-29 16:26:16.098019
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.114502	2025-06-29 16:26:16.114502
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.138604	2025-06-29 16:26:16.138604
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.157098	2025-06-29 16:26:16.157098
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.174036	2025-06-29 16:26:16.174036
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.187212	2025-06-29 16:26:16.187212
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.198515	2025-06-29 16:26:16.198515
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.209912	2025-06-29 16:26:16.209912
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.222878	2025-06-29 16:26:16.222878
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.23845	2025-06-29 16:26:16.23845
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.257874	2025-06-29 16:26:16.257874
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.26979	2025-06-29 16:26:16.26979
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.296108	2025-06-29 16:26:16.296108
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.311574	2025-06-29 16:26:16.311574
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.333651	2025-06-29 16:26:16.333651
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.352025	2025-06-29 16:26:16.352025
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.372924	2025-06-29 16:26:16.372924
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.399143	2025-06-29 16:26:16.399143
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.413078	2025-06-29 16:26:16.413078
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.426594	2025-06-29 16:26:16.426594
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.43985	2025-06-29 16:26:16.43985
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.452387	2025-06-29 16:26:16.452387
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.463739	2025-06-29 16:26:16.463739
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.478707	2025-06-29 16:26:16.478707
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.489161	2025-06-29 16:26:16.489161
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.570048	2025-06-29 16:26:16.570048
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.671034	2025-06-29 16:26:16.671034
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.799373	2025-06-29 16:26:16.799373
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.839447	2025-06-29 16:26:16.839447
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.891483	2025-06-29 16:26:16.891483
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.907384	2025-06-29 16:26:16.907384
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.922938	2025-06-29 16:26:16.922938
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.956367	2025-06-29 16:26:16.956367
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.993216	2025-06-29 16:26:16.993216
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.054526	2025-06-29 16:26:17.054526
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.06374	2025-06-29 16:26:17.06374
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.074509	2025-06-29 16:26:17.074509
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.085532	2025-06-29 16:26:17.085532
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.096745	2025-06-29 16:26:17.096745
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.110445	2025-06-29 16:26:17.110445
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.12263	2025-06-29 16:26:17.12263
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.136852	2025-06-29 16:26:17.136852
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.148833	2025-06-29 16:26:17.148833
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.16835	2025-06-29 16:26:17.16835
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.203635	2025-06-29 16:26:17.203635
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.328409	2025-06-29 16:26:17.328409
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.339696	2025-06-29 16:26:17.339696
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.352048	2025-06-29 16:26:17.352048
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.361931	2025-06-29 16:26:17.361931
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.37182	2025-06-29 16:26:17.37182
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.381117	2025-06-29 16:26:17.381117
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.391278	2025-06-29 16:26:17.391278
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.401807	2025-06-29 16:26:17.401807
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.411661	2025-06-29 16:26:17.411661
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.424682	2025-06-29 16:26:17.424682
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.434929	2025-06-29 16:26:17.434929
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.445547	2025-06-29 16:26:17.445547
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.458856	2025-06-29 16:26:17.458856
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.468869	2025-06-29 16:26:17.468869
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.479994	2025-06-29 16:26:17.479994
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.494066	2025-06-29 16:26:17.494066
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.506421	2025-06-29 16:26:17.506421
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.517107	2025-06-29 16:26:17.517107
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.533575	2025-06-29 16:26:17.533575
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.549405	2025-06-29 16:26:17.549405
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.562359	2025-06-29 16:26:17.562359
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.588602	2025-06-29 16:26:17.588602
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.603453	2025-06-29 16:26:17.603453
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.620251	2025-06-29 16:26:17.620251
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.631064	2025-06-29 16:26:17.631064
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.643383	2025-06-29 16:26:17.643383
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.663169	2025-06-29 16:26:17.663169
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.676154	2025-06-29 16:26:17.676154
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.691993	2025-06-29 16:26:17.691993
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.702348	2025-06-29 16:26:17.702348
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.713338	2025-06-29 16:26:17.713338
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.732831	2025-06-29 16:26:17.732831
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.755434	2025-06-29 16:26:17.755434
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.767881	2025-06-29 16:26:17.767881
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.778773	2025-06-29 16:26:17.778773
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.789653	2025-06-29 16:26:17.789653
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.803731	2025-06-29 16:26:17.803731
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.815864	2025-06-29 16:26:17.815864
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.828742	2025-06-29 16:26:17.828742
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.83981	2025-06-29 16:26:17.83981
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.849606	2025-06-29 16:26:17.849606
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.866472	2025-06-29 16:26:17.866472
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.879385	2025-06-29 16:26:17.879385
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.889931	2025-06-29 16:26:17.889931
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.912901	2025-06-29 16:26:17.912901
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.925281	2025-06-29 16:26:17.925281
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.938516	2025-06-29 16:26:17.938516
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.953941	2025-06-29 16:26:17.953941
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.965219	2025-06-29 16:26:17.965219
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.977811	2025-06-29 16:26:17.977811
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.988814	2025-06-29 16:26:17.988814
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.999458	2025-06-29 16:26:17.999458
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.018996	2025-06-29 16:26:18.018996
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.032417	2025-06-29 16:26:18.032417
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.053522	2025-06-29 16:26:18.053522
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.070256	2025-06-29 16:26:18.070256
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.084156	2025-06-29 16:26:18.084156
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.099336	2025-06-29 16:26:18.099336
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.110733	2025-06-29 16:26:18.110733
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.121413	2025-06-29 16:26:18.121413
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.136638	2025-06-29 16:26:18.136638
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.159474	2025-06-29 16:26:18.159474
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.174771	2025-06-29 16:26:18.174771
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.196377	2025-06-29 16:26:18.196377
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.230853	2025-06-29 16:26:18.230853
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.25313	2025-06-29 16:26:18.25313
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.280245	2025-06-29 16:26:18.280245
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.289443	2025-06-29 16:26:18.289443
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.300795	2025-06-29 16:26:18.300795
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.310591	2025-06-29 16:26:18.310591
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.324817	2025-06-29 16:26:18.324817
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.336357	2025-06-29 16:26:18.336357
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.35178	2025-06-29 16:26:18.35178
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.363623	2025-06-29 16:26:18.363623
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.382135	2025-06-29 16:26:18.382135
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.393944	2025-06-29 16:26:18.393944
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.405711	2025-06-29 16:26:18.405711
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.417201	2025-06-29 16:26:18.417201
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.428883	2025-06-29 16:26:18.428883
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.443632	2025-06-29 16:26:18.443632
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.453462	2025-06-29 16:26:18.453462
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.463813	2025-06-29 16:26:18.463813
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.507638	2025-06-29 16:26:18.507638
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.519399	2025-06-29 16:26:18.519399
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.530848	2025-06-29 16:26:18.530848
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.541298	2025-06-29 16:26:18.541298
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.552425	2025-06-29 16:26:18.552425
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.561958	2025-06-29 16:26:18.561958
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.571944	2025-06-29 16:26:18.571944
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.586538	2025-06-29 16:26:18.586538
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.600368	2025-06-29 16:26:18.600368
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.61211	2025-06-29 16:26:18.61211
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.623427	2025-06-29 16:26:18.623427
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.641022	2025-06-29 16:26:18.641022
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.658412	2025-06-29 16:26:18.658412
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.672541	2025-06-29 16:26:18.672541
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.696269	2025-06-29 16:26:18.696269
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.711354	2025-06-29 16:26:18.711354
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.722467	2025-06-29 16:26:18.722467
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.737501	2025-06-29 16:26:18.737501
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.748905	2025-06-29 16:26:18.748905
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.76836	2025-06-29 16:26:18.76836
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.784739	2025-06-29 16:26:18.784739
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.799012	2025-06-29 16:26:18.799012
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.818977	2025-06-29 16:26:18.818977
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.8318	2025-06-29 16:26:18.8318
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.845991	2025-06-29 16:26:18.845991
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.85871	2025-06-29 16:26:18.85871
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.870251	2025-06-29 16:26:18.870251
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.880916	2025-06-29 16:26:18.880916
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.891801	2025-06-29 16:26:18.891801
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.91146	2025-06-29 16:26:18.91146
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.941896	2025-06-29 16:26:18.941896
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.956735	2025-06-29 16:26:18.956735
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.970159	2025-06-29 16:26:18.970159
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.992212	2025-06-29 16:26:18.992212
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.001944	2025-06-29 16:26:19.001944
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.021525	2025-06-29 16:26:19.021525
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.030658	2025-06-29 16:26:19.030658
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.042325	2025-06-29 16:26:19.042325
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.052286	2025-06-29 16:26:19.052286
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.063395	2025-06-29 16:26:19.063395
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.074337	2025-06-29 16:26:19.074337
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.085467	2025-06-29 16:26:19.085467
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.103519	2025-06-29 16:26:19.103519
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.115931	2025-06-29 16:26:19.115931
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.128084	2025-06-29 16:26:19.128084
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.139136	2025-06-29 16:26:19.139136
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.151014	2025-06-29 16:26:19.151014
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.163197	2025-06-29 16:26:19.163197
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.178989	2025-06-29 16:26:19.178989
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.190051	2025-06-29 16:26:19.190051
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.207327	2025-06-29 16:26:19.207327
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.218061	2025-06-29 16:26:19.218061
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.231394	2025-06-29 16:26:19.231394
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.247843	2025-06-29 16:26:19.247843
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.274932	2025-06-29 16:26:19.274932
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.286708	2025-06-29 16:26:19.286708
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.3018	2025-06-29 16:26:19.3018
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.313395	2025-06-29 16:26:19.313395
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.325046	2025-06-29 16:26:19.325046
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.33627	2025-06-29 16:26:19.33627
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.349245	2025-06-29 16:26:19.349245
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.363354	2025-06-29 16:26:19.363354
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.375328	2025-06-29 16:26:19.375328
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.390091	2025-06-29 16:26:19.390091
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.406754	2025-06-29 16:26:19.406754
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.420534	2025-06-29 16:26:19.420534
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.432169	2025-06-29 16:26:19.432169
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.44449	2025-06-29 16:26:19.44449
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.45751	2025-06-29 16:26:19.45751
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.469115	2025-06-29 16:26:19.469115
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.486909	2025-06-29 16:26:19.486909
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.501504	2025-06-29 16:26:19.501504
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.545754	2025-06-29 16:26:19.545754
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.571204	2025-06-29 16:26:19.571204
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.581904	2025-06-29 16:26:19.581904
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.619941	2025-06-29 16:26:19.619941
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.643143	2025-06-29 16:26:19.643143
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.664237	2025-06-29 16:26:19.664237
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.685955	2025-06-29 16:26:19.685955
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.697101	2025-06-29 16:26:19.697101
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.733525	2025-06-29 16:26:19.733525
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.753609	2025-06-29 16:26:19.753609
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.763007	2025-06-29 16:26:19.763007
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.791266	2025-06-29 16:26:19.791266
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.826749	2025-06-29 16:26:19.826749
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.864718	2025-06-29 16:26:19.864718
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.886284	2025-06-29 16:26:19.886284
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.899305	2025-06-29 16:26:19.899305
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.91192	2025-06-29 16:26:19.91192
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.925263	2025-06-29 16:26:19.925263
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.937901	2025-06-29 16:26:19.937901
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.95728	2025-06-29 16:26:19.95728
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.976339	2025-06-29 16:26:19.976339
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.99316	2025-06-29 16:26:19.99316
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.01032	2025-06-29 16:26:20.01032
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.031247	2025-06-29 16:26:20.031247
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.049284	2025-06-29 16:26:20.049284
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.065403	2025-06-29 16:26:20.065403
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.088415	2025-06-29 16:26:20.088415
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.105696	2025-06-29 16:26:20.105696
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.11704	2025-06-29 16:26:20.11704
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.130061	2025-06-29 16:26:20.130061
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.143652	2025-06-29 16:26:20.143652
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.158761	2025-06-29 16:26:20.158761
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.172029	2025-06-29 16:26:20.172029
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.183228	2025-06-29 16:26:20.183228
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.195212	2025-06-29 16:26:20.195212
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.211005	2025-06-29 16:26:20.211005
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.226779	2025-06-29 16:26:20.226779
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.237375	2025-06-29 16:26:20.237375
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.248102	2025-06-29 16:26:20.248102
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.261302	2025-06-29 16:26:20.261302
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.269846	2025-06-29 16:26:20.269846
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.28072	2025-06-29 16:26:20.28072
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.304111	2025-06-29 16:26:20.304111
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.320294	2025-06-29 16:26:20.320294
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.332767	2025-06-29 16:26:20.332767
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.349648	2025-06-29 16:26:20.349648
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.369321	2025-06-29 16:26:20.369321
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.390516	2025-06-29 16:26:20.390516
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.402029	2025-06-29 16:26:20.402029
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.421233	2025-06-29 16:26:20.421233
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.433019	2025-06-29 16:26:20.433019
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.443376	2025-06-29 16:26:20.443376
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.45557	2025-06-29 16:26:20.45557
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.476764	2025-06-29 16:26:20.476764
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.496195	2025-06-29 16:26:20.496195
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.520666	2025-06-29 16:26:20.520666
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.541627	2025-06-29 16:26:20.541627
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.595942	2025-06-29 16:26:20.595942
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.616081	2025-06-29 16:26:20.616081
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.629874	2025-06-29 16:26:20.629874
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.643626	2025-06-29 16:26:20.643626
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.660369	2025-06-29 16:26:20.660369
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.676843	2025-06-29 16:26:20.676843
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.689466	2025-06-29 16:26:20.689466
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.700737	2025-06-29 16:26:20.700737
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.711425	2025-06-29 16:26:20.711425
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.722769	2025-06-29 16:26:20.722769
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.746661	2025-06-29 16:26:20.746661
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.765349	2025-06-29 16:26:20.765349
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.779308	2025-06-29 16:26:20.779308
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.792743	2025-06-29 16:26:20.792743
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.803087	2025-06-29 16:26:20.803087
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.813996	2025-06-29 16:26:20.813996
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.825023	2025-06-29 16:26:20.825023
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.837376	2025-06-29 16:26:20.837376
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.850186	2025-06-29 16:26:20.850186
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.894675	2025-06-29 16:26:20.894675
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.906254	2025-06-29 16:26:20.906254
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.921886	2025-06-29 16:26:20.921886
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.935718	2025-06-29 16:26:20.935718
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.947605	2025-06-29 16:26:20.947605
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.960041	2025-06-29 16:26:20.960041
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.969331	2025-06-29 16:26:20.969331
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:20.981655	2025-06-29 16:26:20.981655
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.003067	2025-06-29 16:26:21.003067
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.01634	2025-06-29 16:26:21.01634
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.02794	2025-06-29 16:26:21.02794
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.046336	2025-06-29 16:26:21.046336
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.060667	2025-06-29 16:26:21.060667
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.07234	2025-06-29 16:26:21.07234
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.082061	2025-06-29 16:26:21.082061
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.09159	2025-06-29 16:26:21.09159
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.101261	2025-06-29 16:26:21.101261
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.111156	2025-06-29 16:26:21.111156
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.12304	2025-06-29 16:26:21.12304
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.134218	2025-06-29 16:26:21.134218
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.146334	2025-06-29 16:26:21.146334
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.159891	2025-06-29 16:26:21.159891
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.171718	2025-06-29 16:26:21.171718
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.181764	2025-06-29 16:26:21.181764
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.196116	2025-06-29 16:26:21.196116
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.206662	2025-06-29 16:26:21.206662
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.217855	2025-06-29 16:26:21.217855
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.227318	2025-06-29 16:26:21.227318
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.238454	2025-06-29 16:26:21.238454
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.248582	2025-06-29 16:26:21.248582
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.26118	2025-06-29 16:26:21.26118
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.271601	2025-06-29 16:26:21.271601
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.282561	2025-06-29 16:26:21.282561
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.293139	2025-06-29 16:26:21.293139
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.304245	2025-06-29 16:26:21.304245
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.314079	2025-06-29 16:26:21.314079
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.329211	2025-06-29 16:26:21.329211
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.342084	2025-06-29 16:26:21.342084
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.35792	2025-06-29 16:26:21.35792
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.371512	2025-06-29 16:26:21.371512
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.383435	2025-06-29 16:26:21.383435
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.392466	2025-06-29 16:26:21.392466
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.402689	2025-06-29 16:26:21.402689
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.414589	2025-06-29 16:26:21.414589
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.427304	2025-06-29 16:26:21.427304
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.435802	2025-06-29 16:26:21.435802
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.44531	2025-06-29 16:26:21.44531
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.453712	2025-06-29 16:26:21.453712
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.46384	2025-06-29 16:26:21.46384
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.475542	2025-06-29 16:26:21.475542
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.488001	2025-06-29 16:26:21.488001
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.501882	2025-06-29 16:26:21.501882
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.515982	2025-06-29 16:26:21.515982
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.531827	2025-06-29 16:26:21.531827
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.544229	2025-06-29 16:26:21.544229
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.548076	2025-06-29 16:26:21.548076
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.553409	2025-06-29 16:26:21.553409
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.556555	2025-06-29 16:26:21.556555
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.56122	2025-06-29 16:26:21.56122
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.568408	2025-06-29 16:26:21.568408
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.573947	2025-06-29 16:26:21.573947
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.583427	2025-06-29 16:26:21.583427
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.589762	2025-06-29 16:26:21.589762
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.596679	2025-06-29 16:26:21.596679
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.602952	2025-06-29 16:26:21.602952
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.610581	2025-06-29 16:26:21.610581
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:26:21.613877	2025-06-29 16:26:21.613877
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.617153	2025-06-29 16:26:21.617153
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.620622	2025-06-29 16:26:21.620622
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.623865	2025-06-29 16:26:21.623865
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.627263	2025-06-29 16:26:21.627263
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.630638	2025-06-29 16:26:21.630638
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.633926	2025-06-29 16:26:21.633926
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.637327	2025-06-29 16:26:21.637327
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.643321	2025-06-29 16:26:21.643321
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.647154	2025-06-29 16:26:21.647154
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.652907	2025-06-29 16:26:21.652907
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.656415	2025-06-29 16:26:21.656415
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.659957	2025-06-29 16:26:21.659957
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.665175	2025-06-29 16:26:21.665175
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.668894	2025-06-29 16:26:21.668894
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.674063	2025-06-29 16:26:21.674063
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.677127	2025-06-29 16:26:21.677127
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.680241	2025-06-29 16:26:21.680241
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.68348	2025-06-29 16:26:21.68348
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.686176	2025-06-29 16:26:21.686176
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.692035	2025-06-29 16:26:21.692035
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.694786	2025-06-29 16:26:21.694786
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.700715	2025-06-29 16:26:21.700715
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.703804	2025-06-29 16:26:21.703804
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.706934	2025-06-29 16:26:21.706934
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.710152	2025-06-29 16:26:21.710152
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.714993	2025-06-29 16:26:21.714993
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.719575	2025-06-29 16:26:21.719575
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.722875	2025-06-29 16:26:21.722875
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.726611	2025-06-29 16:26:21.726611
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.729946	2025-06-29 16:26:21.729946
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.737062	2025-06-29 16:26:21.737062
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.742371	2025-06-29 16:26:21.742371
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.745631	2025-06-29 16:26:21.745631
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.748837	2025-06-29 16:26:21.748837
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.75187	2025-06-29 16:26:21.75187
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.76829	2025-06-29 16:26:21.76829
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.791271	2025-06-29 16:26:21.791271
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.808139	2025-06-29 16:26:21.808139
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.81702	2025-06-29 16:26:21.81702
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.828169	2025-06-29 16:26:21.828169
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.838334	2025-06-29 16:26:21.838334
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.868308	2025-06-29 16:26:21.868308
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.879957	2025-06-29 16:26:21.879957
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.88566	2025-06-29 16:26:21.88566
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.888976	2025-06-29 16:26:21.888976
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.892288	2025-06-29 16:26:21.892288
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.895661	2025-06-29 16:26:21.895661
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.898937	2025-06-29 16:26:21.898937
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.90252	2025-06-29 16:26:21.90252
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.907504	2025-06-29 16:26:21.907504
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.912581	2025-06-29 16:26:21.912581
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.917519	2025-06-29 16:26:21.917519
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.923814	2025-06-29 16:26:21.923814
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.929094	2025-06-29 16:26:21.929094
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.935865	2025-06-29 16:26:21.935865
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.940198	2025-06-29 16:26:21.940198
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.943426	2025-06-29 16:26:21.943426
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.949939	2025-06-29 16:26:21.949939
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.956441	2025-06-29 16:26:21.956441
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.964114	2025-06-29 16:26:21.964114
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.969866	2025-06-29 16:26:21.969866
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.972951	2025-06-29 16:26:21.972951
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.976201	2025-06-29 16:26:21.976201
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.980343	2025-06-29 16:26:21.980343
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.98466	2025-06-29 16:26:21.98466
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.988396	2025-06-29 16:26:21.988396
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.99141	2025-06-29 16:26:21.99141
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.994403	2025-06-29 16:26:21.994403
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:21.997199	2025-06-29 16:26:21.997199
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.000101	2025-06-29 16:26:22.000101
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.003007	2025-06-29 16:26:22.003007
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.005962	2025-06-29 16:26:22.005962
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.00883	2025-06-29 16:26:22.00883
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.011569	2025-06-29 16:26:22.011569
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.014507	2025-06-29 16:26:22.014507
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.017429	2025-06-29 16:26:22.017429
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.02053	2025-06-29 16:26:22.02053
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.023526	2025-06-29 16:26:22.023526
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.026471	2025-06-29 16:26:22.026471
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.031028	2025-06-29 16:26:22.031028
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.034278	2025-06-29 16:26:22.034278
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.037901	2025-06-29 16:26:22.037901
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.041364	2025-06-29 16:26:22.041364
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.044687	2025-06-29 16:26:22.044687
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.049351	2025-06-29 16:26:22.049351
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.052645	2025-06-29 16:26:22.052645
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.055884	2025-06-29 16:26:22.055884
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.058693	2025-06-29 16:26:22.058693
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.061555	2025-06-29 16:26:22.061555
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.065998	2025-06-29 16:26:22.065998
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.069577	2025-06-29 16:26:22.069577
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.073108	2025-06-29 16:26:22.073108
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.076155	2025-06-29 16:26:22.076155
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.078864	2025-06-29 16:26:22.078864
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.082157	2025-06-29 16:26:22.082157
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.085314	2025-06-29 16:26:22.085314
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.089631	2025-06-29 16:26:22.089631
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.092674	2025-06-29 16:26:22.092674
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.097096	2025-06-29 16:26:22.097096
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.100555	2025-06-29 16:26:22.100555
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.103489	2025-06-29 16:26:22.103489
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.106449	2025-06-29 16:26:22.106449
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.109572	2025-06-29 16:26:22.109572
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.113825	2025-06-29 16:26:22.113825
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.116836	2025-06-29 16:26:22.116836
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.119625	2025-06-29 16:26:22.119625
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.122459	2025-06-29 16:26:22.122459
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.125315	2025-06-29 16:26:22.125315
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.129419	2025-06-29 16:26:22.129419
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.132534	2025-06-29 16:26:22.132534
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.135896	2025-06-29 16:26:22.135896
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.138968	2025-06-29 16:26:22.138968
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.143136	2025-06-29 16:26:22.143136
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.146077	2025-06-29 16:26:22.146077
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.149127	2025-06-29 16:26:22.149127
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.151823	2025-06-29 16:26:22.151823
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.154435	2025-06-29 16:26:22.154435
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.157058	2025-06-29 16:26:22.157058
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.159705	2025-06-29 16:26:22.159705
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.16271	2025-06-29 16:26:22.16271
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.165691	2025-06-29 16:26:22.165691
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.168555	2025-06-29 16:26:22.168555
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.173104	2025-06-29 16:26:22.173104
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.176234	2025-06-29 16:26:22.176234
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.179309	2025-06-29 16:26:22.179309
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.182265	2025-06-29 16:26:22.182265
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.185218	2025-06-29 16:26:22.185218
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.189377	2025-06-29 16:26:22.189377
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.192296	2025-06-29 16:26:22.192296
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.195239	2025-06-29 16:26:22.195239
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.198297	2025-06-29 16:26:22.198297
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.201263	2025-06-29 16:26:22.201263
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.205678	2025-06-29 16:26:22.205678
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.208894	2025-06-29 16:26:22.208894
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.212311	2025-06-29 16:26:22.212311
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.222075	2025-06-29 16:26:22.222075
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.225322	2025-06-29 16:26:22.225322
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.229951	2025-06-29 16:26:22.229951
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.235364	2025-06-29 16:26:22.235364
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.241583	2025-06-29 16:26:22.241583
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.244939	2025-06-29 16:26:22.244939
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.250324	2025-06-29 16:26:22.250324
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.254209	2025-06-29 16:26:22.254209
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.258108	2025-06-29 16:26:22.258108
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.261143	2025-06-29 16:26:22.261143
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.264021	2025-06-29 16:26:22.264021
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.26718	2025-06-29 16:26:22.26718
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.271454	2025-06-29 16:26:22.271454
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.274453	2025-06-29 16:26:22.274453
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.278806	2025-06-29 16:26:22.278806
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.281896	2025-06-29 16:26:22.281896
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.284907	2025-06-29 16:26:22.284907
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.289007	2025-06-29 16:26:22.289007
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.292083	2025-06-29 16:26:22.292083
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.295499	2025-06-29 16:26:22.295499
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.300195	2025-06-29 16:26:22.300195
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.306945	2025-06-29 16:26:22.306945
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.31197	2025-06-29 16:26:22.31197
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.317293	2025-06-29 16:26:22.317293
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.32207	2025-06-29 16:26:22.32207
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.327522	2025-06-29 16:26:22.327522
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.336401	2025-06-29 16:26:22.336401
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.341083	2025-06-29 16:26:22.341083
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.344247	2025-06-29 16:26:22.344247
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.350829	2025-06-29 16:26:22.350829
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.354005	2025-06-29 16:26:22.354005
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.35714	2025-06-29 16:26:22.35714
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.36025	2025-06-29 16:26:22.36025
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.364509	2025-06-29 16:26:22.364509
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.370846	2025-06-29 16:26:22.370846
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.374155	2025-06-29 16:26:22.374155
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.377348	2025-06-29 16:26:22.377348
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.413347	2025-06-29 16:26:22.413347
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.418439	2025-06-29 16:26:22.418439
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.42393	2025-06-29 16:26:22.42393
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.428918	2025-06-29 16:26:22.428918
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.434191	2025-06-29 16:26:22.434191
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.439697	2025-06-29 16:26:22.439697
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.477762	2025-06-29 16:26:22.477762
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.483628	2025-06-29 16:26:22.483628
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.507914	2025-06-29 16:26:22.507914
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.512531	2025-06-29 16:26:22.512531
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.519389	2025-06-29 16:26:22.519389
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.526953	2025-06-29 16:26:22.526953
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.532917	2025-06-29 16:26:22.532917
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.538258	2025-06-29 16:26:22.538258
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.547502	2025-06-29 16:26:22.547502
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.555554	2025-06-29 16:26:22.555554
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.565855	2025-06-29 16:26:22.565855
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.569071	2025-06-29 16:26:22.569071
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.579159	2025-06-29 16:26:22.579159
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.620047	2025-06-29 16:26:22.620047
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.622919	2025-06-29 16:26:22.622919
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.625649	2025-06-29 16:26:22.625649
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.62855	2025-06-29 16:26:22.62855
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.632761	2025-06-29 16:26:22.632761
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.635644	2025-06-29 16:26:22.635644
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.638432	2025-06-29 16:26:22.638432
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.642026	2025-06-29 16:26:22.642026
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.644731	2025-06-29 16:26:22.644731
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.680816	2025-06-29 16:26:22.680816
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.683743	2025-06-29 16:26:22.683743
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.686603	2025-06-29 16:26:22.686603
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.690937	2025-06-29 16:26:22.690937
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.693816	2025-06-29 16:26:22.693816
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.696768	2025-06-29 16:26:22.696768
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.701635	2025-06-29 16:26:22.701635
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.710779	2025-06-29 16:26:22.710779
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.719422	2025-06-29 16:26:22.719422
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.727911	2025-06-29 16:26:22.727911
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.737313	2025-06-29 16:26:22.737313
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.760017	2025-06-29 16:26:22.760017
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.769736	2025-06-29 16:26:22.769736
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.778873	2025-06-29 16:26:22.778873
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.790805	2025-06-29 16:26:22.790805
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.801708	2025-06-29 16:26:22.801708
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.812296	2025-06-29 16:26:22.812296
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.821956	2025-06-29 16:26:22.821956
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.837639	2025-06-29 16:26:22.837639
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.85046	2025-06-29 16:26:22.85046
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.859681	2025-06-29 16:26:22.859681
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.870521	2025-06-29 16:26:22.870521
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.880838	2025-06-29 16:26:22.880838
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.8905	2025-06-29 16:26:22.8905
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.899724	2025-06-29 16:26:22.899724
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.909536	2025-06-29 16:26:22.909536
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.918907	2025-06-29 16:26:22.918907
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.929758	2025-06-29 16:26:22.929758
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.942484	2025-06-29 16:26:22.942484
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.953196	2025-06-29 16:26:22.953196
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.964082	2025-06-29 16:26:22.964082
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.974153	2025-06-29 16:26:22.974153
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.985988	2025-06-29 16:26:22.985988
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:22.997058	2025-06-29 16:26:22.997058
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.00954	2025-06-29 16:26:23.00954
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.020067	2025-06-29 16:26:23.020067
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.040041	2025-06-29 16:26:23.040041
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.050629	2025-06-29 16:26:23.050629
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.060653	2025-06-29 16:26:23.060653
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.070275	2025-06-29 16:26:23.070275
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.079788	2025-06-29 16:26:23.079788
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.089497	2025-06-29 16:26:23.089497
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.09902	2025-06-29 16:26:23.09902
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.109401	2025-06-29 16:26:23.109401
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.120743	2025-06-29 16:26:23.120743
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.13135	2025-06-29 16:26:23.13135
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.142858	2025-06-29 16:26:23.142858
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.152609	2025-06-29 16:26:23.152609
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.162342	2025-06-29 16:26:23.162342
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.171066	2025-06-29 16:26:23.171066
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.181572	2025-06-29 16:26:23.181572
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.19336	2025-06-29 16:26:23.19336
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.205395	2025-06-29 16:26:23.205395
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.21539	2025-06-29 16:26:23.21539
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.227039	2025-06-29 16:26:23.227039
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.239727	2025-06-29 16:26:23.239727
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.255155	2025-06-29 16:26:23.255155
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.278307	2025-06-29 16:26:23.278307
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.291627	2025-06-29 16:26:23.291627
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.303956	2025-06-29 16:26:23.303956
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.315698	2025-06-29 16:26:23.315698
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.32668	2025-06-29 16:26:23.32668
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.338396	2025-06-29 16:26:23.338396
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.348567	2025-06-29 16:26:23.348567
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.358604	2025-06-29 16:26:23.358604
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.368633	2025-06-29 16:26:23.368633
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.378395	2025-06-29 16:26:23.378395
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.390035	2025-06-29 16:26:23.390035
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.400524	2025-06-29 16:26:23.400524
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.410747	2025-06-29 16:26:23.410747
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.420933	2025-06-29 16:26:23.420933
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.434296	2025-06-29 16:26:23.434296
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.44512	2025-06-29 16:26:23.44512
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.455005	2025-06-29 16:26:23.455005
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.464742	2025-06-29 16:26:23.464742
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.47472	2025-06-29 16:26:23.47472
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.486357	2025-06-29 16:26:23.486357
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.499557	2025-06-29 16:26:23.499557
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.509653	2025-06-29 16:26:23.509653
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.520359	2025-06-29 16:26:23.520359
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.532341	2025-06-29 16:26:23.532341
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.542594	2025-06-29 16:26:23.542594
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.555826	2025-06-29 16:26:23.555826
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.603794	2025-06-29 16:26:23.603794
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.620881	2025-06-29 16:26:23.620881
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.634894	2025-06-29 16:26:23.634894
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.645135	2025-06-29 16:26:23.645135
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.654951	2025-06-29 16:26:23.654951
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.665273	2025-06-29 16:26:23.665273
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.67512	2025-06-29 16:26:23.67512
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.685935	2025-06-29 16:26:23.685935
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.696062	2025-06-29 16:26:23.696062
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.707252	2025-06-29 16:26:23.707252
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.719144	2025-06-29 16:26:23.719144
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.732287	2025-06-29 16:26:23.732287
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.742429	2025-06-29 16:26:23.742429
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.75436	2025-06-29 16:26:23.75436
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.767825	2025-06-29 16:26:23.767825
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.777882	2025-06-29 16:26:23.777882
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.78784	2025-06-29 16:26:23.78784
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.79779	2025-06-29 16:26:23.79779
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.808849	2025-06-29 16:26:23.808849
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.818309	2025-06-29 16:26:23.818309
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.827864	2025-06-29 16:26:23.827864
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.83873	2025-06-29 16:26:23.83873
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.848019	2025-06-29 16:26:23.848019
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.857499	2025-06-29 16:26:23.857499
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.869242	2025-06-29 16:26:23.869242
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.887126	2025-06-29 16:26:23.887126
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.897298	2025-06-29 16:26:23.897298
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.907845	2025-06-29 16:26:23.907845
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.917036	2025-06-29 16:26:23.917036
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.929105	2025-06-29 16:26:23.929105
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.938557	2025-06-29 16:26:23.938557
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.949138	2025-06-29 16:26:23.949138
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.959166	2025-06-29 16:26:23.959166
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.980426	2025-06-29 16:26:23.980426
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:23.990589	2025-06-29 16:26:23.990589
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.002006	2025-06-29 16:26:24.002006
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.014831	2025-06-29 16:26:24.014831
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.028063	2025-06-29 16:26:24.028063
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.039573	2025-06-29 16:26:24.039573
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.055766	2025-06-29 16:26:24.055766
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.070006	2025-06-29 16:26:24.070006
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.080335	2025-06-29 16:26:24.080335
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.090446	2025-06-29 16:26:24.090446
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.09971	2025-06-29 16:26:24.09971
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.110486	2025-06-29 16:26:24.110486
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.119672	2025-06-29 16:26:24.119672
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.12941	2025-06-29 16:26:24.12941
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.143632	2025-06-29 16:26:24.143632
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.15528	2025-06-29 16:26:24.15528
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.169861	2025-06-29 16:26:24.169861
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.181409	2025-06-29 16:26:24.181409
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.202813	2025-06-29 16:26:24.202813
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.21534	2025-06-29 16:26:24.21534
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.225619	2025-06-29 16:26:24.225619
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.243511	2025-06-29 16:26:24.243511
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.253846	2025-06-29 16:26:24.253846
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.26451	2025-06-29 16:26:24.26451
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.30878	2025-06-29 16:26:24.30878
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.329064	2025-06-29 16:26:24.329064
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.345776	2025-06-29 16:26:24.345776
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.357818	2025-06-29 16:26:24.357818
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.369142	2025-06-29 16:26:24.369142
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.381373	2025-06-29 16:26:24.381373
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.391128	2025-06-29 16:26:24.391128
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.402143	2025-06-29 16:26:24.402143
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.425404	2025-06-29 16:26:24.425404
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.441312	2025-06-29 16:26:24.441312
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.452146	2025-06-29 16:26:24.452146
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.465068	2025-06-29 16:26:24.465068
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.482596	2025-06-29 16:26:24.482596
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.496865	2025-06-29 16:26:24.496865
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.510631	2025-06-29 16:26:24.510631
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.528097	2025-06-29 16:26:24.528097
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.546969	2025-06-29 16:26:24.546969
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.556964	2025-06-29 16:26:24.556964
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.566766	2025-06-29 16:26:24.566766
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.581511	2025-06-29 16:26:24.581511
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.618348	2025-06-29 16:26:24.618348
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.648784	2025-06-29 16:26:24.648784
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.661151	2025-06-29 16:26:24.661151
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.679904	2025-06-29 16:26:24.679904
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.700405	2025-06-29 16:26:24.700405
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.714039	2025-06-29 16:26:24.714039
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.7247	2025-06-29 16:26:24.7247
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.73922	2025-06-29 16:26:24.73922
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.749175	2025-06-29 16:26:24.749175
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.758776	2025-06-29 16:26:24.758776
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.768474	2025-06-29 16:26:24.768474
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.779406	2025-06-29 16:26:24.779406
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.789602	2025-06-29 16:26:24.789602
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.800316	2025-06-29 16:26:24.800316
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.809611	2025-06-29 16:26:24.809611
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.819999	2025-06-29 16:26:24.819999
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.84845	2025-06-29 16:26:24.84845
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.859683	2025-06-29 16:26:24.859683
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.871601	2025-06-29 16:26:24.871601
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.886887	2025-06-29 16:26:24.886887
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.909677	2025-06-29 16:26:24.909677
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.929721	2025-06-29 16:26:24.929721
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.958604	2025-06-29 16:26:24.958604
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.976955	2025-06-29 16:26:24.976955
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.987017	2025-06-29 16:26:24.987017
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:24.99842	2025-06-29 16:26:24.99842
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.008313	2025-06-29 16:26:25.008313
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.031219	2025-06-29 16:26:25.031219
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.050499	2025-06-29 16:26:25.050499
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.064973	2025-06-29 16:26:25.064973
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.075619	2025-06-29 16:26:25.075619
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.092908	2025-06-29 16:26:25.092908
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.106379	2025-06-29 16:26:25.106379
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.139958	2025-06-29 16:26:25.139958
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.15034	2025-06-29 16:26:25.15034
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.161698	2025-06-29 16:26:25.161698
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.178419	2025-06-29 16:26:25.178419
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.199305	2025-06-29 16:26:25.199305
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.209958	2025-06-29 16:26:25.209958
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.233745	2025-06-29 16:26:25.233745
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.263004	2025-06-29 16:26:25.263004
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.282254	2025-06-29 16:26:25.282254
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.296291	2025-06-29 16:26:25.296291
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.312347	2025-06-29 16:26:25.312347
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.323925	2025-06-29 16:26:25.323925
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.334796	2025-06-29 16:26:25.334796
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.348819	2025-06-29 16:26:25.348819
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.360661	2025-06-29 16:26:25.360661
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.372497	2025-06-29 16:26:25.372497
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.385382	2025-06-29 16:26:25.385382
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.402319	2025-06-29 16:26:25.402319
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.426375	2025-06-29 16:26:25.426375
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.442677	2025-06-29 16:26:25.442677
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.452791	2025-06-29 16:26:25.452791
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.463288	2025-06-29 16:26:25.463288
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.47464	2025-06-29 16:26:25.47464
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.492172	2025-06-29 16:26:25.492172
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.503595	2025-06-29 16:26:25.503595
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.523669	2025-06-29 16:26:25.523669
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.559083	2025-06-29 16:26:25.559083
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.57979	2025-06-29 16:26:25.57979
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.602899	2025-06-29 16:26:25.602899
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.620054	2025-06-29 16:26:25.620054
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.638771	2025-06-29 16:26:25.638771
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.648811	2025-06-29 16:26:25.648811
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.674028	2025-06-29 16:26:25.674028
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.694416	2025-06-29 16:26:25.694416
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.704758	2025-06-29 16:26:25.704758
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.718625	2025-06-29 16:26:25.718625
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.729626	2025-06-29 16:26:25.729626
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.740677	2025-06-29 16:26:25.740677
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.750538	2025-06-29 16:26:25.750538
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.760806	2025-06-29 16:26:25.760806
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.770431	2025-06-29 16:26:25.770431
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.780148	2025-06-29 16:26:25.780148
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.793336	2025-06-29 16:26:25.793336
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.807408	2025-06-29 16:26:25.807408
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.830443	2025-06-29 16:26:25.830443
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.845704	2025-06-29 16:26:25.845704
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.859747	2025-06-29 16:26:25.859747
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.887705	2025-06-29 16:26:25.887705
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.904086	2025-06-29 16:26:25.904086
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.922489	2025-06-29 16:26:25.922489
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.937284	2025-06-29 16:26:25.937284
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.954839	2025-06-29 16:26:25.954839
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.968766	2025-06-29 16:26:25.968766
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.978947	2025-06-29 16:26:25.978947
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:25.999727	2025-06-29 16:26:25.999727
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.014397	2025-06-29 16:26:26.014397
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.029121	2025-06-29 16:26:26.029121
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.039869	2025-06-29 16:26:26.039869
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.054698	2025-06-29 16:26:26.054698
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.073947	2025-06-29 16:26:26.073947
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.090847	2025-06-29 16:26:26.090847
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.111902	2025-06-29 16:26:26.111902
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.133679	2025-06-29 16:26:26.133679
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.151396	2025-06-29 16:26:26.151396
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.167386	2025-06-29 16:26:26.167386
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.194461	2025-06-29 16:26:26.194461
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.217214	2025-06-29 16:26:26.217214
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.230831	2025-06-29 16:26:26.230831
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.247364	2025-06-29 16:26:26.247364
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.319521	2025-06-29 16:26:26.319521
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.375737	2025-06-29 16:26:26.375737
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.409297	2025-06-29 16:26:26.409297
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.447145	2025-06-29 16:26:26.447145
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.465365	2025-06-29 16:26:26.465365
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.480885	2025-06-29 16:26:26.480885
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.503125	2025-06-29 16:26:26.503125
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.518623	2025-06-29 16:26:26.518623
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.531424	2025-06-29 16:26:26.531424
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.543677	2025-06-29 16:26:26.543677
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.55433	2025-06-29 16:26:26.55433
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.565564	2025-06-29 16:26:26.565564
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.57576	2025-06-29 16:26:26.57576
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.588351	2025-06-29 16:26:26.588351
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.598524	2025-06-29 16:26:26.598524
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.610714	2025-06-29 16:26:26.610714
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.630141	2025-06-29 16:26:26.630141
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.649251	2025-06-29 16:26:26.649251
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.661613	2025-06-29 16:26:26.661613
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.67103	2025-06-29 16:26:26.67103
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.683553	2025-06-29 16:26:26.683553
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.695626	2025-06-29 16:26:26.695626
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.706678	2025-06-29 16:26:26.706678
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.716355	2025-06-29 16:26:26.716355
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.726744	2025-06-29 16:26:26.726744
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.73727	2025-06-29 16:26:26.73727
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.748892	2025-06-29 16:26:26.748892
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.758815	2025-06-29 16:26:26.758815
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.774004	2025-06-29 16:26:26.774004
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.786985	2025-06-29 16:26:26.786985
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.798007	2025-06-29 16:26:26.798007
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.808749	2025-06-29 16:26:26.808749
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.818583	2025-06-29 16:26:26.818583
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.828897	2025-06-29 16:26:26.828897
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.841259	2025-06-29 16:26:26.841259
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.866901	2025-06-29 16:26:26.866901
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.877454	2025-06-29 16:26:26.877454
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.899485	2025-06-29 16:26:26.899485
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.921811	2025-06-29 16:26:26.921811
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.947049	2025-06-29 16:26:26.947049
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.960271	2025-06-29 16:26:26.960271
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.979496	2025-06-29 16:26:26.979496
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:26.992129	2025-06-29 16:26:26.992129
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.005778	2025-06-29 16:26:27.005778
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.026484	2025-06-29 16:26:27.026484
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.04021	2025-06-29 16:26:27.04021
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.057061	2025-06-29 16:26:27.057061
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.079093	2025-06-29 16:26:27.079093
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.095817	2025-06-29 16:26:27.095817
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.109445	2025-06-29 16:26:27.109445
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.126102	2025-06-29 16:26:27.126102
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.145201	2025-06-29 16:26:27.145201
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.157263	2025-06-29 16:26:27.157263
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.198518	2025-06-29 16:26:27.198518
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.229976	2025-06-29 16:26:27.229976
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.26138	2025-06-29 16:26:27.26138
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.27726	2025-06-29 16:26:27.27726
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.292821	2025-06-29 16:26:27.292821
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.312561	2025-06-29 16:26:27.312561
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.326029	2025-06-29 16:26:27.326029
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.34104	2025-06-29 16:26:27.34104
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.351755	2025-06-29 16:26:27.351755
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.366026	2025-06-29 16:26:27.366026
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.405509	2025-06-29 16:26:27.405509
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.425678	2025-06-29 16:26:27.425678
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.448712	2025-06-29 16:26:27.448712
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.457862	2025-06-29 16:26:27.457862
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.469962	2025-06-29 16:26:27.469962
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.485114	2025-06-29 16:26:27.485114
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.50186	2025-06-29 16:26:27.50186
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.526763	2025-06-29 16:26:27.526763
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.544572	2025-06-29 16:26:27.544572
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.560391	2025-06-29 16:26:27.560391
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.576666	2025-06-29 16:26:27.576666
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.594725	2025-06-29 16:26:27.594725
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.618529	2025-06-29 16:26:27.618529
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.644372	2025-06-29 16:26:27.644372
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.701128	2025-06-29 16:26:27.701128
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.719547	2025-06-29 16:26:27.719547
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.73997	2025-06-29 16:26:27.73997
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.76032	2025-06-29 16:26:27.76032
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.782743	2025-06-29 16:26:27.782743
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.815073	2025-06-29 16:26:27.815073
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.858927	2025-06-29 16:26:27.858927
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.874294	2025-06-29 16:26:27.874294
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.894374	2025-06-29 16:26:27.894374
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.90566	2025-06-29 16:26:27.90566
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.926293	2025-06-29 16:26:27.926293
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.943259	2025-06-29 16:26:27.943259
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.968756	2025-06-29 16:26:27.968756
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:27.98556	2025-06-29 16:26:27.98556
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.023425	2025-06-29 16:26:28.023425
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.074175	2025-06-29 16:26:28.074175
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.097309	2025-06-29 16:26:28.097309
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.116327	2025-06-29 16:26:28.116327
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.150099	2025-06-29 16:26:28.150099
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.179598	2025-06-29 16:26:28.179598
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.192949	2025-06-29 16:26:28.192949
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.24831	2025-06-29 16:26:28.24831
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.267079	2025-06-29 16:26:28.267079
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.314831	2025-06-29 16:26:28.314831
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.346942	2025-06-29 16:26:28.346942
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.362095	2025-06-29 16:26:28.362095
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.377387	2025-06-29 16:26:28.377387
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.446547	2025-06-29 16:26:28.446547
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.475588	2025-06-29 16:26:28.475588
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.501828	2025-06-29 16:26:28.501828
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.53909	2025-06-29 16:26:28.53909
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.555925	2025-06-29 16:26:28.555925
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.570926	2025-06-29 16:26:28.570926
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.598432	2025-06-29 16:26:28.598432
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.613984	2025-06-29 16:26:28.613984
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.641841	2025-06-29 16:26:28.641841
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.672564	2025-06-29 16:26:28.672564
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.699858	2025-06-29 16:26:28.699858
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.720548	2025-06-29 16:26:28.720548
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.735161	2025-06-29 16:26:28.735161
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.762991	2025-06-29 16:26:28.762991
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.781278	2025-06-29 16:26:28.781278
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.798332	2025-06-29 16:26:28.798332
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.808943	2025-06-29 16:26:28.808943
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.819583	2025-06-29 16:26:28.819583
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.832011	2025-06-29 16:26:28.832011
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.852816	2025-06-29 16:26:28.852816
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.864732	2025-06-29 16:26:28.864732
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.881836	2025-06-29 16:26:28.881836
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.896172	2025-06-29 16:26:28.896172
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.914304	2025-06-29 16:26:28.914304
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.926565	2025-06-29 16:26:28.926565
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.94681	2025-06-29 16:26:28.94681
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.956524	2025-06-29 16:26:28.956524
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.970705	2025-06-29 16:26:28.970705
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.980784	2025-06-29 16:26:28.980784
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:28.995303	2025-06-29 16:26:28.995303
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.013188	2025-06-29 16:26:29.013188
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.031749	2025-06-29 16:26:29.031749
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.062964	2025-06-29 16:26:29.062964
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.076304	2025-06-29 16:26:29.076304
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.093683	2025-06-29 16:26:29.093683
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.122379	2025-06-29 16:26:29.122379
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.140657	2025-06-29 16:26:29.140657
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.161192	2025-06-29 16:26:29.161192
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.181265	2025-06-29 16:26:29.181265
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.201837	2025-06-29 16:26:29.201837
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.214603	2025-06-29 16:26:29.214603
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.228525	2025-06-29 16:26:29.228525
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.240785	2025-06-29 16:26:29.240785
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.25443	2025-06-29 16:26:29.25443
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.27886	2025-06-29 16:26:29.27886
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.291539	2025-06-29 16:26:29.291539
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.316575	2025-06-29 16:26:29.316575
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.337121	2025-06-29 16:26:29.337121
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.358384	2025-06-29 16:26:29.358384
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.380525	2025-06-29 16:26:29.380525
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.397799	2025-06-29 16:26:29.397799
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.409644	2025-06-29 16:26:29.409644
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.420522	2025-06-29 16:26:29.420522
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.430062	2025-06-29 16:26:29.430062
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.442803	2025-06-29 16:26:29.442803
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.456022	2025-06-29 16:26:29.456022
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.467985	2025-06-29 16:26:29.467985
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.481419	2025-06-29 16:26:29.481419
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.496039	2025-06-29 16:26:29.496039
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.52462	2025-06-29 16:26:29.52462
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.539437	2025-06-29 16:26:29.539437
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.555367	2025-06-29 16:26:29.555367
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.570597	2025-06-29 16:26:29.570597
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.586187	2025-06-29 16:26:29.586187
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.603101	2025-06-29 16:26:29.603101
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.624629	2025-06-29 16:26:29.624629
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.636004	2025-06-29 16:26:29.636004
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.651463	2025-06-29 16:26:29.651463
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.68105	2025-06-29 16:26:29.68105
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.697838	2025-06-29 16:26:29.697838
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.708997	2025-06-29 16:26:29.708997
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.719562	2025-06-29 16:26:29.719562
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.729338	2025-06-29 16:26:29.729338
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.739217	2025-06-29 16:26:29.739217
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.75157	2025-06-29 16:26:29.75157
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.762173	2025-06-29 16:26:29.762173
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.785426	2025-06-29 16:26:29.785426
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.806402	2025-06-29 16:26:29.806402
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.816867	2025-06-29 16:26:29.816867
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.831738	2025-06-29 16:26:29.831738
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.843878	2025-06-29 16:26:29.843878
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.855743	2025-06-29 16:26:29.855743
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.86907	2025-06-29 16:26:29.86907
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.878904	2025-06-29 16:26:29.878904
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.891856	2025-06-29 16:26:29.891856
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.904983	2025-06-29 16:26:29.904983
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.914595	2025-06-29 16:26:29.914595
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.929624	2025-06-29 16:26:29.929624
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.941369	2025-06-29 16:26:29.941369
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.952368	2025-06-29 16:26:29.952368
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.966612	2025-06-29 16:26:29.966612
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.978787	2025-06-29 16:26:29.978787
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:29.989388	2025-06-29 16:26:29.989388
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.000703	2025-06-29 16:26:30.000703
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.012411	2025-06-29 16:26:30.012411
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.027634	2025-06-29 16:26:30.027634
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.03803	2025-06-29 16:26:30.03803
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.048296	2025-06-29 16:26:30.048296
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.083586	2025-06-29 16:26:30.083586
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.096842	2025-06-29 16:26:30.096842
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.119392	2025-06-29 16:26:30.119392
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.132902	2025-06-29 16:26:30.132902
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.142736	2025-06-29 16:26:30.142736
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.15466	2025-06-29 16:26:30.15466
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.169371	2025-06-29 16:26:30.169371
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.178802	2025-06-29 16:26:30.178802
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.1912	2025-06-29 16:26:30.1912
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.201186	2025-06-29 16:26:30.201186
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.210526	2025-06-29 16:26:30.210526
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.221284	2025-06-29 16:26:30.221284
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.246651	2025-06-29 16:26:30.246651
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.259439	2025-06-29 16:26:30.259439
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.272291	2025-06-29 16:26:30.272291
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.282552	2025-06-29 16:26:30.282552
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.295987	2025-06-29 16:26:30.295987
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.308431	2025-06-29 16:26:30.308431
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.329834	2025-06-29 16:26:30.329834
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.34216	2025-06-29 16:26:30.34216
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.354355	2025-06-29 16:26:30.354355
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.364683	2025-06-29 16:26:30.364683
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.379514	2025-06-29 16:26:30.379514
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.399187	2025-06-29 16:26:30.399187
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.41563	2025-06-29 16:26:30.41563
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.435073	2025-06-29 16:26:30.435073
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.44589	2025-06-29 16:26:30.44589
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.477918	2025-06-29 16:26:30.477918
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.513488	2025-06-29 16:26:30.513488
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.525452	2025-06-29 16:26:30.525452
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.551834	2025-06-29 16:26:30.551834
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.566749	2025-06-29 16:26:30.566749
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.577514	2025-06-29 16:26:30.577514
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.596516	2025-06-29 16:26:30.596516
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.636977	2025-06-29 16:26:30.636977
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.655467	2025-06-29 16:26:30.655467
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.676423	2025-06-29 16:26:30.676423
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.700397	2025-06-29 16:26:30.700397
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.713443	2025-06-29 16:26:30.713443
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.735081	2025-06-29 16:26:30.735081
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.752435	2025-06-29 16:26:30.752435
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.775308	2025-06-29 16:26:30.775308
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.789845	2025-06-29 16:26:30.789845
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.801536	2025-06-29 16:26:30.801536
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.813301	2025-06-29 16:26:30.813301
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.826785	2025-06-29 16:26:30.826785
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.853913	2025-06-29 16:26:30.853913
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.871037	2025-06-29 16:26:30.871037
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.897495	2025-06-29 16:26:30.897495
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.920665	2025-06-29 16:26:30.920665
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.941819	2025-06-29 16:26:30.941819
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.958187	2025-06-29 16:26:30.958187
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:30.975525	2025-06-29 16:26:30.975525
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.000321	2025-06-29 16:26:31.000321
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.039111	2025-06-29 16:26:31.039111
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.056547	2025-06-29 16:26:31.056547
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.079371	2025-06-29 16:26:31.079371
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.104508	2025-06-29 16:26:31.104508
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.13922	2025-06-29 16:26:31.13922
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.168542	2025-06-29 16:26:31.168542
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.189128	2025-06-29 16:26:31.189128
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.205214	2025-06-29 16:26:31.205214
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.229157	2025-06-29 16:26:31.229157
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.248673	2025-06-29 16:26:31.248673
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.280344	2025-06-29 16:26:31.280344
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.310063	2025-06-29 16:26:31.310063
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.34318	2025-06-29 16:26:31.34318
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.356014	2025-06-29 16:26:31.356014
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.373845	2025-06-29 16:26:31.373845
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.386333	2025-06-29 16:26:31.386333
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.398813	2025-06-29 16:26:31.398813
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.412544	2025-06-29 16:26:31.412544
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.442208	2025-06-29 16:26:31.442208
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.452793	2025-06-29 16:26:31.452793
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.498352	2025-06-29 16:26:31.498352
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.51611	2025-06-29 16:26:31.51611
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.554079	2025-06-29 16:26:31.554079
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.585444	2025-06-29 16:26:31.585444
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.601288	2025-06-29 16:26:31.601288
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.632462	2025-06-29 16:26:31.632462
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.67154	2025-06-29 16:26:31.67154
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.698462	2025-06-29 16:26:31.698462
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.713044	2025-06-29 16:26:31.713044
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.730501	2025-06-29 16:26:31.730501
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.743898	2025-06-29 16:26:31.743898
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.770171	2025-06-29 16:26:31.770171
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.796173	2025-06-29 16:26:31.796173
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.807099	2025-06-29 16:26:31.807099
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.835003	2025-06-29 16:26:31.835003
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.853584	2025-06-29 16:26:31.853584
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.871557	2025-06-29 16:26:31.871557
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.885445	2025-06-29 16:26:31.885445
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.898918	2025-06-29 16:26:31.898918
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.912242	2025-06-29 16:26:31.912242
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.936214	2025-06-29 16:26:31.936214
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.956854	2025-06-29 16:26:31.956854
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:31.990039	2025-06-29 16:26:31.990039
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.005789	2025-06-29 16:26:32.005789
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.023528	2025-06-29 16:26:32.023528
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.053601	2025-06-29 16:26:32.053601
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.090064	2025-06-29 16:26:32.090064
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.129436	2025-06-29 16:26:32.129436
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.155685	2025-06-29 16:26:32.155685
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.179951	2025-06-29 16:26:32.179951
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.198558	2025-06-29 16:26:32.198558
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.216596	2025-06-29 16:26:32.216596
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.229352	2025-06-29 16:26:32.229352
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.245863	2025-06-29 16:26:32.245863
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.262953	2025-06-29 16:26:32.262953
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.277357	2025-06-29 16:26:32.277357
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.303163	2025-06-29 16:26:32.303163
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.314889	2025-06-29 16:26:32.314889
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.324643	2025-06-29 16:26:32.324643
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.340155	2025-06-29 16:26:32.340155
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.350363	2025-06-29 16:26:32.350363
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.364592	2025-06-29 16:26:32.364592
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.383918	2025-06-29 16:26:32.383918
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.398573	2025-06-29 16:26:32.398573
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.412589	2025-06-29 16:26:32.412589
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.428322	2025-06-29 16:26:32.428322
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.439837	2025-06-29 16:26:32.439837
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.462246	2025-06-29 16:26:32.462246
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.480982	2025-06-29 16:26:32.480982
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.496188	2025-06-29 16:26:32.496188
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.509138	2025-06-29 16:26:32.509138
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.524381	2025-06-29 16:26:32.524381
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.546794	2025-06-29 16:26:32.546794
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.567513	2025-06-29 16:26:32.567513
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.588498	2025-06-29 16:26:32.588498
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.617164	2025-06-29 16:26:32.617164
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.635926	2025-06-29 16:26:32.635926
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.659332	2025-06-29 16:26:32.659332
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.701492	2025-06-29 16:26:32.701492
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.754451	2025-06-29 16:26:32.754451
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.772102	2025-06-29 16:26:32.772102
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.799387	2025-06-29 16:26:32.799387
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.820064	2025-06-29 16:26:32.820064
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.84975	2025-06-29 16:26:32.84975
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.861729	2025-06-29 16:26:32.861729
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.873706	2025-06-29 16:26:32.873706
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.884188	2025-06-29 16:26:32.884188
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.895109	2025-06-29 16:26:32.895109
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.907821	2025-06-29 16:26:32.907821
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.91817	2025-06-29 16:26:32.91817
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.935387	2025-06-29 16:26:32.935387
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.94957	2025-06-29 16:26:32.94957
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:32.967549	2025-06-29 16:26:32.967549
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.004587	2025-06-29 16:26:33.004587
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.016068	2025-06-29 16:26:33.016068
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.027857	2025-06-29 16:26:33.027857
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.039702	2025-06-29 16:26:33.039702
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.051029	2025-06-29 16:26:33.051029
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.069549	2025-06-29 16:26:33.069549
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.081446	2025-06-29 16:26:33.081446
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.099933	2025-06-29 16:26:33.099933
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.128417	2025-06-29 16:26:33.128417
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.146623	2025-06-29 16:26:33.146623
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.169748	2025-06-29 16:26:33.169748
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.194142	2025-06-29 16:26:33.194142
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.211787	2025-06-29 16:26:33.211787
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.229989	2025-06-29 16:26:33.229989
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.258071	2025-06-29 16:26:33.258071
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.284363	2025-06-29 16:26:33.284363
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.304841	2025-06-29 16:26:33.304841
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.325547	2025-06-29 16:26:33.325547
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.329298	2025-06-29 16:26:33.329298
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.334621	2025-06-29 16:26:33.334621
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.341913	2025-06-29 16:26:33.341913
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.345137	2025-06-29 16:26:33.345137
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.348223	2025-06-29 16:26:33.348223
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.351875	2025-06-29 16:26:33.351875
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.35522	2025-06-29 16:26:33.35522
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.358397	2025-06-29 16:26:33.358397
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.361537	2025-06-29 16:26:33.361537
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.364547	2025-06-29 16:26:33.364547
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.367577	2025-06-29 16:26:33.367577
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.370963	2025-06-29 16:26:33.370963
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.375501	2025-06-29 16:26:33.375501
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.378543	2025-06-29 16:26:33.378543
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.381578	2025-06-29 16:26:33.381578
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.384962	2025-06-29 16:26:33.384962
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.389575	2025-06-29 16:26:33.389575
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.395617	2025-06-29 16:26:33.395617
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.398713	2025-06-29 16:26:33.398713
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.403602	2025-06-29 16:26:33.403602
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.407679	2025-06-29 16:26:33.407679
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.413009	2025-06-29 16:26:33.413009
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.416161	2025-06-29 16:26:33.416161
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.4301	2025-06-29 16:26:33.4301
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.433148	2025-06-29 16:26:33.433148
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.436338	2025-06-29 16:26:33.436338
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.439507	2025-06-29 16:26:33.439507
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.442591	2025-06-29 16:26:33.442591
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.445876	2025-06-29 16:26:33.445876
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.449061	2025-06-29 16:26:33.449061
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.452192	2025-06-29 16:26:33.452192
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.455236	2025-06-29 16:26:33.455236
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.458043	2025-06-29 16:26:33.458043
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.460934	2025-06-29 16:26:33.460934
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.464269	2025-06-29 16:26:33.464269
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.467233	2025-06-29 16:26:33.467233
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.470113	2025-06-29 16:26:33.470113
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.474389	2025-06-29 16:26:33.474389
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.478083	2025-06-29 16:26:33.478083
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.481018	2025-06-29 16:26:33.481018
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.484058	2025-06-29 16:26:33.484058
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.487115	2025-06-29 16:26:33.487115
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.498332	2025-06-29 16:26:33.498332
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.538362	2025-06-29 16:26:33.538362
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.558255	2025-06-29 16:26:33.558255
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.572758	2025-06-29 16:26:33.572758
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.588162	2025-06-29 16:26:33.588162
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.6084	2025-06-29 16:26:33.6084
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.614274	2025-06-29 16:26:33.614274
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.617967	2025-06-29 16:26:33.617967
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.621345	2025-06-29 16:26:33.621345
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.624398	2025-06-29 16:26:33.624398
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.62749	2025-06-29 16:26:33.62749
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.630551	2025-06-29 16:26:33.630551
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.633718	2025-06-29 16:26:33.633718
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.637042	2025-06-29 16:26:33.637042
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.640032	2025-06-29 16:26:33.640032
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.643075	2025-06-29 16:26:33.643075
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.646051	2025-06-29 16:26:33.646051
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.648986	2025-06-29 16:26:33.648986
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.653796	2025-06-29 16:26:33.653796
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.656836	2025-06-29 16:26:33.656836
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.65979	2025-06-29 16:26:33.65979
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.663616	2025-06-29 16:26:33.663616
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.666579	2025-06-29 16:26:33.666579
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.671598	2025-06-29 16:26:33.671598
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.675145	2025-06-29 16:26:33.675145
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.678245	2025-06-29 16:26:33.678245
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.681094	2025-06-29 16:26:33.681094
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.683927	2025-06-29 16:26:33.683927
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.687022	2025-06-29 16:26:33.687022
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.690041	2025-06-29 16:26:33.690041
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.693149	2025-06-29 16:26:33.693149
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.696287	2025-06-29 16:26:33.696287
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.699219	2025-06-29 16:26:33.699219
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.702307	2025-06-29 16:26:33.702307
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.70551	2025-06-29 16:26:33.70551
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.708531	2025-06-29 16:26:33.708531
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.711475	2025-06-29 16:26:33.711475
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.714301	2025-06-29 16:26:33.714301
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.718608	2025-06-29 16:26:33.718608
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.722019	2025-06-29 16:26:33.722019
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.72526	2025-06-29 16:26:33.72526
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.728246	2025-06-29 16:26:33.728246
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.731036	2025-06-29 16:26:33.731036
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.735229	2025-06-29 16:26:33.735229
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.738276	2025-06-29 16:26:33.738276
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.741141	2025-06-29 16:26:33.741141
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.744017	2025-06-29 16:26:33.744017
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.74676	2025-06-29 16:26:33.74676
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.749463	2025-06-29 16:26:33.749463
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.754065	2025-06-29 16:26:33.754065
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.758931	2025-06-29 16:26:33.758931
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.762335	2025-06-29 16:26:33.762335
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.765306	2025-06-29 16:26:33.765306
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.768324	2025-06-29 16:26:33.768324
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.7719	2025-06-29 16:26:33.7719
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.775137	2025-06-29 16:26:33.775137
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.779355	2025-06-29 16:26:33.779355
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.782469	2025-06-29 16:26:33.782469
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.785613	2025-06-29 16:26:33.785613
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.788301	2025-06-29 16:26:33.788301
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.792224	2025-06-29 16:26:33.792224
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.795037	2025-06-29 16:26:33.795037
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.797909	2025-06-29 16:26:33.797909
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.800905	2025-06-29 16:26:33.800905
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.803624	2025-06-29 16:26:33.803624
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.807131	2025-06-29 16:26:33.807131
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.810115	2025-06-29 16:26:33.810115
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.813181	2025-06-29 16:26:33.813181
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.816313	2025-06-29 16:26:33.816313
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.819752	2025-06-29 16:26:33.819752
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.823073	2025-06-29 16:26:33.823073
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.827786	2025-06-29 16:26:33.827786
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.831325	2025-06-29 16:26:33.831325
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.835337	2025-06-29 16:26:33.835337
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.83878	2025-06-29 16:26:33.83878
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.841988	2025-06-29 16:26:33.841988
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.84541	2025-06-29 16:26:33.84541
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.848822	2025-06-29 16:26:33.848822
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.852011	2025-06-29 16:26:33.852011
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.857975	2025-06-29 16:26:33.857975
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.861454	2025-06-29 16:26:33.861454
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:33.865182	2025-06-29 16:26:33.865182
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.869073	2025-06-29 16:26:33.869073
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.873567	2025-06-29 16:26:33.873567
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.876885	2025-06-29 16:26:33.876885
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.880602	2025-06-29 16:26:33.880602
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.883765	2025-06-29 16:26:33.883765
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.888562	2025-06-29 16:26:33.888562
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.893243	2025-06-29 16:26:33.893243
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.896198	2025-06-29 16:26:33.896198
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.903516	2025-06-29 16:26:33.903516
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.90792	2025-06-29 16:26:33.90792
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.911107	2025-06-29 16:26:33.911107
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.914487	2025-06-29 16:26:33.914487
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.917767	2025-06-29 16:26:33.917767
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.922064	2025-06-29 16:26:33.922064
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.925373	2025-06-29 16:26:33.925373
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.928366	2025-06-29 16:26:33.928366
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.931727	2025-06-29 16:26:33.931727
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.935371	2025-06-29 16:26:33.935371
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.938463	2025-06-29 16:26:33.938463
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.942077	2025-06-29 16:26:33.942077
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.945823	2025-06-29 16:26:33.945823
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.949329	2025-06-29 16:26:33.949329
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.953621	2025-06-29 16:26:33.953621
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.957226	2025-06-29 16:26:33.957226
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.960731	2025-06-29 16:26:33.960731
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.963653	2025-06-29 16:26:33.963653
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.966829	2025-06-29 16:26:33.966829
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.970028	2025-06-29 16:26:33.970028
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.973219	2025-06-29 16:26:33.973219
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.976234	2025-06-29 16:26:33.976234
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.979161	2025-06-29 16:26:33.979161
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.982471	2025-06-29 16:26:33.982471
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.985707	2025-06-29 16:26:33.985707
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.988953	2025-06-29 16:26:33.988953
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.99411	2025-06-29 16:26:33.99411
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:33.999572	2025-06-29 16:26:33.999572
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.003128	2025-06-29 16:26:34.003128
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.006442	2025-06-29 16:26:34.006442
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.009571	2025-06-29 16:26:34.009571
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.0132	2025-06-29 16:26:34.0132
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.016014	2025-06-29 16:26:34.016014
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.018755	2025-06-29 16:26:34.018755
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.021586	2025-06-29 16:26:34.021586
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.024538	2025-06-29 16:26:34.024538
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.02742	2025-06-29 16:26:34.02742
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.030349	2025-06-29 16:26:34.030349
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.033352	2025-06-29 16:26:34.033352
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.03643	2025-06-29 16:26:34.03643
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.039343	2025-06-29 16:26:34.039343
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.043787	2025-06-29 16:26:34.043787
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.04716	2025-06-29 16:26:34.04716
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.050743	2025-06-29 16:26:34.050743
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.054096	2025-06-29 16:26:34.054096
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.05809	2025-06-29 16:26:34.05809
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.061845	2025-06-29 16:26:34.061845
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.066374	2025-06-29 16:26:34.066374
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.069794	2025-06-29 16:26:34.069794
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.073001	2025-06-29 16:26:34.073001
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.07638	2025-06-29 16:26:34.07638
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.079609	2025-06-29 16:26:34.079609
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.085625	2025-06-29 16:26:34.085625
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.089732	2025-06-29 16:26:34.089732
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.093037	2025-06-29 16:26:34.093037
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.097042	2025-06-29 16:26:34.097042
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.10137	2025-06-29 16:26:34.10137
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.109236	2025-06-29 16:26:34.109236
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.114461	2025-06-29 16:26:34.114461
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.120071	2025-06-29 16:26:34.120071
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.124061	2025-06-29 16:26:34.124061
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.128186	2025-06-29 16:26:34.128186
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.132381	2025-06-29 16:26:34.132381
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.140247	2025-06-29 16:26:34.140247
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.149356	2025-06-29 16:26:34.149356
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.156697	2025-06-29 16:26:34.156697
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.16017	2025-06-29 16:26:34.16017
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.163873	2025-06-29 16:26:34.163873
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.16745	2025-06-29 16:26:34.16745
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.171998	2025-06-29 16:26:34.171998
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.176634	2025-06-29 16:26:34.176634
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.181155	2025-06-29 16:26:34.181155
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.185422	2025-06-29 16:26:34.185422
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.188934	2025-06-29 16:26:34.188934
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.192178	2025-06-29 16:26:34.192178
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.195311	2025-06-29 16:26:34.195311
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.198627	2025-06-29 16:26:34.198627
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.201754	2025-06-29 16:26:34.201754
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.204824	2025-06-29 16:26:34.204824
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.209374	2025-06-29 16:26:34.209374
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.212409	2025-06-29 16:26:34.212409
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.215159	2025-06-29 16:26:34.215159
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.21943	2025-06-29 16:26:34.21943
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.222524	2025-06-29 16:26:34.222524
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.226297	2025-06-29 16:26:34.226297
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.229178	2025-06-29 16:26:34.229178
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.232032	2025-06-29 16:26:34.232032
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.235103	2025-06-29 16:26:34.235103
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.238165	2025-06-29 16:26:34.238165
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.241843	2025-06-29 16:26:34.241843
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.244931	2025-06-29 16:26:34.244931
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.248508	2025-06-29 16:26:34.248508
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.251813	2025-06-29 16:26:34.251813
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.255358	2025-06-29 16:26:34.255358
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.258936	2025-06-29 16:26:34.258936
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.262319	2025-06-29 16:26:34.262319
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.26541	2025-06-29 16:26:34.26541
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.268643	2025-06-29 16:26:34.268643
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.271835	2025-06-29 16:26:34.271835
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.275001	2025-06-29 16:26:34.275001
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.278378	2025-06-29 16:26:34.278378
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.281939	2025-06-29 16:26:34.281939
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.285188	2025-06-29 16:26:34.285188
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.288953	2025-06-29 16:26:34.288953
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.292278	2025-06-29 16:26:34.292278
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.295634	2025-06-29 16:26:34.295634
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.298749	2025-06-29 16:26:34.298749
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.301655	2025-06-29 16:26:34.301655
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.304467	2025-06-29 16:26:34.304467
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.308534	2025-06-29 16:26:34.308534
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.31156	2025-06-29 16:26:34.31156
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.314214	2025-06-29 16:26:34.314214
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.316808	2025-06-29 16:26:34.316808
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.31936	2025-06-29 16:26:34.31936
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.3234	2025-06-29 16:26:34.3234
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.326202	2025-06-29 16:26:34.326202
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.329309	2025-06-29 16:26:34.329309
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.332148	2025-06-29 16:26:34.332148
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.335042	2025-06-29 16:26:34.335042
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.338056	2025-06-29 16:26:34.338056
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.341104	2025-06-29 16:26:34.341104
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.344215	2025-06-29 16:26:34.344215
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.347446	2025-06-29 16:26:34.347446
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.3508	2025-06-29 16:26:34.3508
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.353657	2025-06-29 16:26:34.353657
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.356559	2025-06-29 16:26:34.356559
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.359661	2025-06-29 16:26:34.359661
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.362867	2025-06-29 16:26:34.362867
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.365858	2025-06-29 16:26:34.365858
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.368533	2025-06-29 16:26:34.368533
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.372714	2025-06-29 16:26:34.372714
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.375904	2025-06-29 16:26:34.375904
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.378698	2025-06-29 16:26:34.378698
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.381685	2025-06-29 16:26:34.381685
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.384423	2025-06-29 16:26:34.384423
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.389009	2025-06-29 16:26:34.389009
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.392245	2025-06-29 16:26:34.392245
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.39667	2025-06-29 16:26:34.39667
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.399924	2025-06-29 16:26:34.399924
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.402983	2025-06-29 16:26:34.402983
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.405766	2025-06-29 16:26:34.405766
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.40845	2025-06-29 16:26:34.40845
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.411106	2025-06-29 16:26:34.411106
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.41407	2025-06-29 16:26:34.41407
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.419747	2025-06-29 16:26:34.419747
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.422795	2025-06-29 16:26:34.422795
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.425804	2025-06-29 16:26:34.425804
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.429981	2025-06-29 16:26:34.429981
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.4331	2025-06-29 16:26:34.4331
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.435804	2025-06-29 16:26:34.435804
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.438543	2025-06-29 16:26:34.438543
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.441484	2025-06-29 16:26:34.441484
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.450427	2025-06-29 16:26:34.450427
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.453358	2025-06-29 16:26:34.453358
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.456294	2025-06-29 16:26:34.456294
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.459425	2025-06-29 16:26:34.459425
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.462292	2025-06-29 16:26:34.462292
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.465198	2025-06-29 16:26:34.465198
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.469571	2025-06-29 16:26:34.469571
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.472786	2025-06-29 16:26:34.472786
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.475574	2025-06-29 16:26:34.475574
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.478342	2025-06-29 16:26:34.478342
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.482943	2025-06-29 16:26:34.482943
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.496194	2025-06-29 16:26:34.496194
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.515298	2025-06-29 16:26:34.515298
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.528114	2025-06-29 16:26:34.528114
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.54473	2025-06-29 16:26:34.54473
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.558609	2025-06-29 16:26:34.558609
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.570045	2025-06-29 16:26:34.570045
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.593495	2025-06-29 16:26:34.593495
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.607067	2025-06-29 16:26:34.607067
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.623978	2025-06-29 16:26:34.623978
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.63522	2025-06-29 16:26:34.63522
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.645272	2025-06-29 16:26:34.645272
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.656777	2025-06-29 16:26:34.656777
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.667549	2025-06-29 16:26:34.667549
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.678943	2025-06-29 16:26:34.678943
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.68849	2025-06-29 16:26:34.68849
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.699862	2025-06-29 16:26:34.699862
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.711183	2025-06-29 16:26:34.711183
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.721112	2025-06-29 16:26:34.721112
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.733298	2025-06-29 16:26:34.733298
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.743973	2025-06-29 16:26:34.743973
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.757831	2025-06-29 16:26:34.757831
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.774601	2025-06-29 16:26:34.774601
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.787109	2025-06-29 16:26:34.787109
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.798743	2025-06-29 16:26:34.798743
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.811946	2025-06-29 16:26:34.811946
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.823177	2025-06-29 16:26:34.823177
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.834078	2025-06-29 16:26:34.834078
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.848001	2025-06-29 16:26:34.848001
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.860207	2025-06-29 16:26:34.860207
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.874914	2025-06-29 16:26:34.874914
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.889424	2025-06-29 16:26:34.889424
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.902611	2025-06-29 16:26:34.902611
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.914266	2025-06-29 16:26:34.914266
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.931505	2025-06-29 16:26:34.931505
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.952178	2025-06-29 16:26:34.952178
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.965843	2025-06-29 16:26:34.965843
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:34.98863	2025-06-29 16:26:34.98863
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.002087	2025-06-29 16:26:35.002087
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.014946	2025-06-29 16:26:35.014946
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.026077	2025-06-29 16:26:35.026077
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.039382	2025-06-29 16:26:35.039382
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.050483	2025-06-29 16:26:35.050483
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.062381	2025-06-29 16:26:35.062381
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.073858	2025-06-29 16:26:35.073858
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.087553	2025-06-29 16:26:35.087553
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.102715	2025-06-29 16:26:35.102715
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.116111	2025-06-29 16:26:35.116111
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.127408	2025-06-29 16:26:35.127408
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.137395	2025-06-29 16:26:35.137395
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.152733	2025-06-29 16:26:35.152733
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.162882	2025-06-29 16:26:35.162882
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.175995	2025-06-29 16:26:35.175995
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.188478	2025-06-29 16:26:35.188478
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.200474	2025-06-29 16:26:35.200474
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.216497	2025-06-29 16:26:35.216497
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.227987	2025-06-29 16:26:35.227987
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.241523	2025-06-29 16:26:35.241523
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.253083	2025-06-29 16:26:35.253083
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.264771	2025-06-29 16:26:35.264771
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.27531	2025-06-29 16:26:35.27531
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.294804	2025-06-29 16:26:35.294804
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.310207	2025-06-29 16:26:35.310207
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.325438	2025-06-29 16:26:35.325438
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.342477	2025-06-29 16:26:35.342477
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.35923	2025-06-29 16:26:35.35923
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.373199	2025-06-29 16:26:35.373199
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.387786	2025-06-29 16:26:35.387786
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.406474	2025-06-29 16:26:35.406474
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.417561	2025-06-29 16:26:35.417561
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.438177	2025-06-29 16:26:35.438177
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.475771	2025-06-29 16:26:35.475771
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.502169	2025-06-29 16:26:35.502169
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.542698	2025-06-29 16:26:35.542698
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.557103	2025-06-29 16:26:35.557103
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.596645	2025-06-29 16:26:35.596645
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.622375	2025-06-29 16:26:35.622375
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.645089	2025-06-29 16:26:35.645089
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.6583	2025-06-29 16:26:35.6583
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.670732	2025-06-29 16:26:35.670732
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.681652	2025-06-29 16:26:35.681652
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.699669	2025-06-29 16:26:35.699669
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.710213	2025-06-29 16:26:35.710213
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.721233	2025-06-29 16:26:35.721233
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.731622	2025-06-29 16:26:35.731622
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.743375	2025-06-29 16:26:35.743375
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.754043	2025-06-29 16:26:35.754043
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.765096	2025-06-29 16:26:35.765096
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.775339	2025-06-29 16:26:35.775339
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.785895	2025-06-29 16:26:35.785895
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.802277	2025-06-29 16:26:35.802277
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.8134	2025-06-29 16:26:35.8134
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.827064	2025-06-29 16:26:35.827064
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.840454	2025-06-29 16:26:35.840454
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.850224	2025-06-29 16:26:35.850224
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.869377	2025-06-29 16:26:35.869377
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.880894	2025-06-29 16:26:35.880894
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.898289	2025-06-29 16:26:35.898289
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.92308	2025-06-29 16:26:35.92308
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.938227	2025-06-29 16:26:35.938227
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.951469	2025-06-29 16:26:35.951469
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.96463	2025-06-29 16:26:35.96463
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.977993	2025-06-29 16:26:35.977993
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:35.991063	2025-06-29 16:26:35.991063
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.002653	2025-06-29 16:26:36.002653
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.019894	2025-06-29 16:26:36.019894
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.035403	2025-06-29 16:26:36.035403
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.05054	2025-06-29 16:26:36.05054
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.066873	2025-06-29 16:26:36.066873
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.088202	2025-06-29 16:26:36.088202
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.129762	2025-06-29 16:26:36.129762
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.151635	2025-06-29 16:26:36.151635
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.163379	2025-06-29 16:26:36.163379
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.175205	2025-06-29 16:26:36.175205
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.185535	2025-06-29 16:26:36.185535
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.201336	2025-06-29 16:26:36.201336
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.218898	2025-06-29 16:26:36.218898
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.23061	2025-06-29 16:26:36.23061
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.244559	2025-06-29 16:26:36.244559
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.255554	2025-06-29 16:26:36.255554
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.26685	2025-06-29 16:26:36.26685
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.286461	2025-06-29 16:26:36.286461
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.304583	2025-06-29 16:26:36.304583
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.322133	2025-06-29 16:26:36.322133
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.337312	2025-06-29 16:26:36.337312
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.363858	2025-06-29 16:26:36.363858
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.375916	2025-06-29 16:26:36.375916
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.427003	2025-06-29 16:26:36.427003
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.485832	2025-06-29 16:26:36.485832
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.535268	2025-06-29 16:26:36.535268
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.550007	2025-06-29 16:26:36.550007
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.570588	2025-06-29 16:26:36.570588
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.590157	2025-06-29 16:26:36.590157
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.619337	2025-06-29 16:26:36.619337
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.65394	2025-06-29 16:26:36.65394
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.673603	2025-06-29 16:26:36.673603
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.690433	2025-06-29 16:26:36.690433
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.708708	2025-06-29 16:26:36.708708
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.732219	2025-06-29 16:26:36.732219
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.745116	2025-06-29 16:26:36.745116
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.755743	2025-06-29 16:26:36.755743
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.768253	2025-06-29 16:26:36.768253
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.782576	2025-06-29 16:26:36.782576
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.799235	2025-06-29 16:26:36.799235
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.812097	2025-06-29 16:26:36.812097
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.825995	2025-06-29 16:26:36.825995
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.840344	2025-06-29 16:26:36.840344
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.855849	2025-06-29 16:26:36.855849
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.869301	2025-06-29 16:26:36.869301
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.891494	2025-06-29 16:26:36.891494
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.904152	2025-06-29 16:26:36.904152
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.91691	2025-06-29 16:26:36.91691
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.932643	2025-06-29 16:26:36.932643
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.948886	2025-06-29 16:26:36.948886
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.959975	2025-06-29 16:26:36.959975
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.972853	2025-06-29 16:26:36.972853
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.98363	2025-06-29 16:26:36.98363
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:36.998062	2025-06-29 16:26:36.998062
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.009378	2025-06-29 16:26:37.009378
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.029396	2025-06-29 16:26:37.029396
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.043494	2025-06-29 16:26:37.043494
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.066318	2025-06-29 16:26:37.066318
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.086857	2025-06-29 16:26:37.086857
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.106056	2025-06-29 16:26:37.106056
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.120044	2025-06-29 16:26:37.120044
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.138067	2025-06-29 16:26:37.138067
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.152157	2025-06-29 16:26:37.152157
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.166296	2025-06-29 16:26:37.166296
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.178917	2025-06-29 16:26:37.178917
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.189221	2025-06-29 16:26:37.189221
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.199957	2025-06-29 16:26:37.199957
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.212314	2025-06-29 16:26:37.212314
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.222397	2025-06-29 16:26:37.222397
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.233021	2025-06-29 16:26:37.233021
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.24501	2025-06-29 16:26:37.24501
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.263127	2025-06-29 16:26:37.263127
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.283823	2025-06-29 16:26:37.283823
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.299064	2025-06-29 16:26:37.299064
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.31054	2025-06-29 16:26:37.31054
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.328417	2025-06-29 16:26:37.328417
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.339445	2025-06-29 16:26:37.339445
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.351098	2025-06-29 16:26:37.351098
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.36196	2025-06-29 16:26:37.36196
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.372081	2025-06-29 16:26:37.372081
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.38211	2025-06-29 16:26:37.38211
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.393479	2025-06-29 16:26:37.393479
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.402415	2025-06-29 16:26:37.402415
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.412202	2025-06-29 16:26:37.412202
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.422119	2025-06-29 16:26:37.422119
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.432148	2025-06-29 16:26:37.432148
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.442815	2025-06-29 16:26:37.442815
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.451887	2025-06-29 16:26:37.451887
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.463764	2025-06-29 16:26:37.463764
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.487482	2025-06-29 16:26:37.487482
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.499248	2025-06-29 16:26:37.499248
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.514463	2025-06-29 16:26:37.514463
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.542067	2025-06-29 16:26:37.542067
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.554871	2025-06-29 16:26:37.554871
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.56547	2025-06-29 16:26:37.56547
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.57835	2025-06-29 16:26:37.57835
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.5945	2025-06-29 16:26:37.5945
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.612287	2025-06-29 16:26:37.612287
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.633388	2025-06-29 16:26:37.633388
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.64923	2025-06-29 16:26:37.64923
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.659375	2025-06-29 16:26:37.659375
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.671573	2025-06-29 16:26:37.671573
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.682156	2025-06-29 16:26:37.682156
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.6922	2025-06-29 16:26:37.6922
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.702664	2025-06-29 16:26:37.702664
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.711639	2025-06-29 16:26:37.711639
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.720895	2025-06-29 16:26:37.720895
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.730936	2025-06-29 16:26:37.730936
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.739493	2025-06-29 16:26:37.739493
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.751014	2025-06-29 16:26:37.751014
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:37.760729	2025-06-29 16:26:37.760729
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 16:26:09.412
2	ART Coverage	\N	\N	2025-06-29 16:26:09.445324
3	People Living with HIV	\N	\N	2025-06-29 16:26:09.46382
4	HIV-related Deaths	\N	\N	2025-06-29 16:26:09.473805
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 16:26:09.484919
6	ART Pediatric Coverage	\N	\N	2025-06-29 16:26:09.512965
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminus	$2b$12$8qDaG2FCucGhf/ttTpppK.qS62EFm9AmHpkKTJG0JQceLq9C6MUqa	admin	0	2025-06-29 16:26:09.270752	2025-06-29 16:26:09.270752
2	userus	$2b$12$1Qkh3kX3iGb41Lo7epRFBegJJZ9DdJ6m0JV9hJ8Fo6hQKEgRsz4Ea	user	0	2025-06-29 16:26:09.320522	2025-06-29 16:26:09.320522
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

