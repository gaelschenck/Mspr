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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 17:39:27.79742	2025-06-29 17:39:27.79742
2	Albania	Europe	\N	2025-06-29 17:39:27.80484	2025-06-29 17:39:27.80484
3	Algeria	Africa	\N	2025-06-29 17:39:27.812091	2025-06-29 17:39:27.812091
4	Angola	Africa	\N	2025-06-29 17:39:27.819397	2025-06-29 17:39:27.819397
5	Argentina	Americas	\N	2025-06-29 17:39:27.827983	2025-06-29 17:39:27.827983
6	Armenia	Europe	\N	2025-06-29 17:39:27.83487	2025-06-29 17:39:27.83487
7	Australia	Western Pacific	\N	2025-06-29 17:39:27.842564	2025-06-29 17:39:27.842564
8	Austria	Europe	\N	2025-06-29 17:39:27.85007	2025-06-29 17:39:27.85007
9	Azerbaijan	Europe	\N	2025-06-29 17:39:27.859412	2025-06-29 17:39:27.859412
10	Bahamas	Americas	\N	2025-06-29 17:39:27.866282	2025-06-29 17:39:27.866282
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 17:39:27.869356	2025-06-29 17:39:27.869356
12	Bangladesh	South-East Asia	\N	2025-06-29 17:39:27.872331	2025-06-29 17:39:27.872331
13	Barbados	Americas	\N	2025-06-29 17:39:27.877305	2025-06-29 17:39:27.877305
14	Belarus	Europe	\N	2025-06-29 17:39:27.884346	2025-06-29 17:39:27.884346
15	Belgium	Europe	\N	2025-06-29 17:39:27.891037	2025-06-29 17:39:27.891037
16	Belize	Americas	\N	2025-06-29 17:39:27.89872	2025-06-29 17:39:27.89872
17	Benin	Africa	\N	2025-06-29 17:39:27.905627	2025-06-29 17:39:27.905627
18	Bhutan	South-East Asia	\N	2025-06-29 17:39:27.912104	2025-06-29 17:39:27.912104
19	Bolivia	Americas	\N	2025-06-29 17:39:27.919818	2025-06-29 17:39:27.919818
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 17:39:27.927246	2025-06-29 17:39:27.927246
21	Botswana	Africa	\N	2025-06-29 17:39:27.933762	2025-06-29 17:39:27.933762
22	Brazil	Americas	\N	2025-06-29 17:39:27.941634	2025-06-29 17:39:27.941634
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 17:39:27.948386	2025-06-29 17:39:27.948386
24	Bulgaria	Europe	\N	2025-06-29 17:39:27.95524	2025-06-29 17:39:27.95524
25	Burkina Faso	Africa	\N	2025-06-29 17:39:27.961922	2025-06-29 17:39:27.961922
26	Burundi	Africa	\N	2025-06-29 17:39:27.968675	2025-06-29 17:39:27.968675
27	Cabo Verde	Africa	\N	2025-06-29 17:39:27.981726	2025-06-29 17:39:27.981726
28	Cambodia	Western Pacific	\N	2025-06-29 17:39:28.122681	2025-06-29 17:39:28.122681
29	Cameroon	Africa	\N	2025-06-29 17:39:28.131339	2025-06-29 17:39:28.131339
30	Canada	Americas	\N	2025-06-29 17:39:28.138528	2025-06-29 17:39:28.138528
31	Central African Republic	Africa	\N	2025-06-29 17:39:28.145477	2025-06-29 17:39:28.145477
32	Chad	Africa	\N	2025-06-29 17:39:28.152537	2025-06-29 17:39:28.152537
33	Chile	Americas	\N	2025-06-29 17:39:28.160083	2025-06-29 17:39:28.160083
34	China	Western Pacific	\N	2025-06-29 17:39:28.167316	2025-06-29 17:39:28.167316
35	Colombia	Americas	\N	2025-06-29 17:39:28.173953	2025-06-29 17:39:28.173953
36	Comoros	Africa	\N	2025-06-29 17:39:28.180509	2025-06-29 17:39:28.180509
37	Congo	Americas	\N	2025-06-29 17:39:28.187079	2025-06-29 17:39:28.187079
38	Costa Rica	Americas	\N	2025-06-29 17:39:28.193528	2025-06-29 17:39:28.193528
39	Côte d'Ivoire	Africa	\N	2025-06-29 17:39:28.203777	2025-06-29 17:39:28.203777
40	Croatia	Europe	\N	2025-06-29 17:39:28.210921	2025-06-29 17:39:28.210921
41	Cuba	Americas	\N	2025-06-29 17:39:28.217843	2025-06-29 17:39:28.217843
42	Cyprus	Europe	\N	2025-06-29 17:39:28.22809	2025-06-29 17:39:28.22809
43	Czechia	Europe	\N	2025-06-29 17:39:28.23512	2025-06-29 17:39:28.23512
44	North Korea	Western Pacific	\N	2025-06-29 17:39:28.241661	2025-06-29 17:39:28.241661
45	DR Congo	Africa	\N	2025-06-29 17:39:28.252291	2025-06-29 17:39:28.252291
46	Denmark	Europe	\N	2025-06-29 17:39:28.260527	2025-06-29 17:39:28.260527
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 17:39:28.267244	2025-06-29 17:39:28.267244
48	Dominican Republic	Americas	\N	2025-06-29 17:39:28.275402	2025-06-29 17:39:28.275402
49	Ecuador	Americas	\N	2025-06-29 17:39:28.281762	2025-06-29 17:39:28.281762
50	Egypt	Eastern Mediterranean	\N	2025-06-29 17:39:28.288133	2025-06-29 17:39:28.288133
51	El Salvador	Americas	\N	2025-06-29 17:39:28.294574	2025-06-29 17:39:28.294574
52	Equatorial Guinea	Africa	\N	2025-06-29 17:39:28.300964	2025-06-29 17:39:28.300964
53	Eritrea	Africa	\N	2025-06-29 17:39:28.307306	2025-06-29 17:39:28.307306
54	Estonia	Europe	\N	2025-06-29 17:39:28.315148	2025-06-29 17:39:28.315148
55	Eswatini	Africa	\N	2025-06-29 17:39:28.321634	2025-06-29 17:39:28.321634
56	Ethiopia	Africa	\N	2025-06-29 17:39:28.32834	2025-06-29 17:39:28.32834
57	Fiji	Western Pacific	\N	2025-06-29 17:39:28.335122	2025-06-29 17:39:28.335122
58	Finland	Europe	\N	2025-06-29 17:39:28.34162	2025-06-29 17:39:28.34162
59	France	Europe	\N	2025-06-29 17:39:28.348501	2025-06-29 17:39:28.348501
60	Gabon	Africa	\N	2025-06-29 17:39:28.355144	2025-06-29 17:39:28.355144
61	Gambia	Africa	\N	2025-06-29 17:39:28.362207	2025-06-29 17:39:28.362207
62	Georgia	Europe	\N	2025-06-29 17:39:28.369001	2025-06-29 17:39:28.369001
63	Germany	Europe	\N	2025-06-29 17:39:28.376159	2025-06-29 17:39:28.376159
64	Ghana	Africa	\N	2025-06-29 17:39:28.382772	2025-06-29 17:39:28.382772
65	Greece	Europe	\N	2025-06-29 17:39:28.390204	2025-06-29 17:39:28.390204
66	Guatemala	Americas	\N	2025-06-29 17:39:28.397137	2025-06-29 17:39:28.397137
67	Guinea	Africa	\N	2025-06-29 17:39:28.404055	2025-06-29 17:39:28.404055
68	Guinea-Bissau	Africa	\N	2025-06-29 17:39:28.410928	2025-06-29 17:39:28.410928
69	Guyana	Americas	\N	2025-06-29 17:39:28.41589	2025-06-29 17:39:28.41589
70	Haiti	Americas	\N	2025-06-29 17:39:28.426988	2025-06-29 17:39:28.426988
71	Honduras	Americas	\N	2025-06-29 17:39:28.431826	2025-06-29 17:39:28.431826
72	Hungary	Europe	\N	2025-06-29 17:39:28.439415	2025-06-29 17:39:28.439415
73	Iceland	Europe	\N	2025-06-29 17:39:28.446364	2025-06-29 17:39:28.446364
74	India	South-East Asia	\N	2025-06-29 17:39:28.45315	2025-06-29 17:39:28.45315
75	Indonesia	South-East Asia	\N	2025-06-29 17:39:28.46019	2025-06-29 17:39:28.46019
76	Iran	Eastern Mediterranean	\N	2025-06-29 17:39:28.466954	2025-06-29 17:39:28.466954
77	Ireland	Europe	\N	2025-06-29 17:39:28.475018	2025-06-29 17:39:28.475018
78	Israel	Europe	\N	2025-06-29 17:39:28.48172	2025-06-29 17:39:28.48172
79	Italy	Europe	\N	2025-06-29 17:39:28.488459	2025-06-29 17:39:28.488459
80	Jamaica	Americas	\N	2025-06-29 17:39:28.495251	2025-06-29 17:39:28.495251
81	Japan	Western Pacific	\N	2025-06-29 17:39:28.501816	2025-06-29 17:39:28.501816
82	Jordan	Eastern Mediterranean	\N	2025-06-29 17:39:28.508063	2025-06-29 17:39:28.508063
83	Kazakhstan	Europe	\N	2025-06-29 17:39:28.51466	2025-06-29 17:39:28.51466
84	Kenya	Africa	\N	2025-06-29 17:39:28.521299	2025-06-29 17:39:28.521299
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 17:39:28.531664	2025-06-29 17:39:28.531664
86	Kyrgyzstan	Europe	\N	2025-06-29 17:39:28.539936	2025-06-29 17:39:28.539936
87	Laos	Western Pacific	\N	2025-06-29 17:39:28.546404	2025-06-29 17:39:28.546404
88	Latvia	Europe	\N	2025-06-29 17:39:28.552964	2025-06-29 17:39:28.552964
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 17:39:28.559369	2025-06-29 17:39:28.559369
90	Lesotho	Africa	\N	2025-06-29 17:39:28.565983	2025-06-29 17:39:28.565983
91	Liberia	Africa	\N	2025-06-29 17:39:28.572689	2025-06-29 17:39:28.572689
92	Libya	Eastern Mediterranean	\N	2025-06-29 17:39:28.579918	2025-06-29 17:39:28.579918
93	Lithuania	Europe	\N	2025-06-29 17:39:28.58703	2025-06-29 17:39:28.58703
94	Luxembourg	Europe	\N	2025-06-29 17:39:28.594826	2025-06-29 17:39:28.594826
95	Madagascar	Africa	\N	2025-06-29 17:39:28.601623	2025-06-29 17:39:28.601623
96	Malawi	Africa	\N	2025-06-29 17:39:28.608496	2025-06-29 17:39:28.608496
97	Malaysia	Western Pacific	\N	2025-06-29 17:39:28.615964	2025-06-29 17:39:28.615964
98	Maldives	South-East Asia	\N	2025-06-29 17:39:28.625268	2025-06-29 17:39:28.625268
99	Mali	Africa	\N	2025-06-29 17:39:28.63197	2025-06-29 17:39:28.63197
100	Malta	Europe	\N	2025-06-29 17:39:28.637512	2025-06-29 17:39:28.637512
101	Mauritania	Africa	\N	2025-06-29 17:39:28.645506	2025-06-29 17:39:28.645506
102	Mauritius	Africa	\N	2025-06-29 17:39:28.650133	2025-06-29 17:39:28.650133
103	Mexico	Americas	\N	2025-06-29 17:39:28.655801	2025-06-29 17:39:28.655801
104	Mongolia	Western Pacific	\N	2025-06-29 17:39:28.663982	2025-06-29 17:39:28.663982
105	Montenegro	Europe	\N	2025-06-29 17:39:28.672322	2025-06-29 17:39:28.672322
106	Morocco	Eastern Mediterranean	\N	2025-06-29 17:39:28.679268	2025-06-29 17:39:28.679268
107	Mozambique	Africa	\N	2025-06-29 17:39:28.686099	2025-06-29 17:39:28.686099
108	Myanmar	South-East Asia	\N	2025-06-29 17:39:28.692666	2025-06-29 17:39:28.692666
109	Namibia	Africa	\N	2025-06-29 17:39:28.700692	2025-06-29 17:39:28.700692
110	Nepal	South-East Asia	\N	2025-06-29 17:39:28.707465	2025-06-29 17:39:28.707465
111	Netherlands	Europe	\N	2025-06-29 17:39:28.716537	2025-06-29 17:39:28.716537
112	New Zealand	Western Pacific	\N	2025-06-29 17:39:28.722614	2025-06-29 17:39:28.722614
113	Nicaragua	Americas	\N	2025-06-29 17:39:28.728741	2025-06-29 17:39:28.728741
114	Niger	Africa	\N	2025-06-29 17:39:28.735248	2025-06-29 17:39:28.735248
115	Nigeria	Africa	\N	2025-06-29 17:39:28.741602	2025-06-29 17:39:28.741602
116	Norway	Europe	\N	2025-06-29 17:39:28.752299	2025-06-29 17:39:28.752299
117	Oman	Eastern Mediterranean	\N	2025-06-29 17:39:28.75865	2025-06-29 17:39:28.75865
118	Pakistan	Eastern Mediterranean	\N	2025-06-29 17:39:28.764736	2025-06-29 17:39:28.764736
119	Panama	Americas	\N	2025-06-29 17:39:28.770557	2025-06-29 17:39:28.770557
120	Papua New Guinea	Western Pacific	\N	2025-06-29 17:39:28.776446	2025-06-29 17:39:28.776446
121	Paraguay	Americas	\N	2025-06-29 17:39:28.782893	2025-06-29 17:39:28.782893
122	Peru	Americas	\N	2025-06-29 17:39:28.789109	2025-06-29 17:39:28.789109
123	Philippines	Western Pacific	\N	2025-06-29 17:39:28.795113	2025-06-29 17:39:28.795113
124	Poland	Europe	\N	2025-06-29 17:39:28.801433	2025-06-29 17:39:28.801433
125	Portugal	Europe	\N	2025-06-29 17:39:28.807438	2025-06-29 17:39:28.807438
126	Qatar	Eastern Mediterranean	\N	2025-06-29 17:39:28.813432	2025-06-29 17:39:28.813432
127	South Korea	Western Pacific	\N	2025-06-29 17:39:28.819491	2025-06-29 17:39:28.819491
128	Moldova	Europe	\N	2025-06-29 17:39:28.82552	2025-06-29 17:39:28.82552
129	North Macedonia	Europe	\N	2025-06-29 17:39:28.833574	2025-06-29 17:39:28.833574
130	Romania	Europe	\N	2025-06-29 17:39:28.839737	2025-06-29 17:39:28.839737
131	Russia	Europe	\N	2025-06-29 17:39:28.84549	2025-06-29 17:39:28.84549
132	Rwanda	Africa	\N	2025-06-29 17:39:28.851403	2025-06-29 17:39:28.851403
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-29 17:39:28.85736	2025-06-29 17:39:28.85736
134	Senegal	Africa	\N	2025-06-29 17:39:28.863305	2025-06-29 17:39:28.863305
135	Serbia	Europe	\N	2025-06-29 17:39:28.869257	2025-06-29 17:39:28.869257
136	Sierra Leone	Africa	\N	2025-06-29 17:39:28.875173	2025-06-29 17:39:28.875173
137	Singapore	Western Pacific	\N	2025-06-29 17:39:28.881034	2025-06-29 17:39:28.881034
138	Slovakia	Europe	\N	2025-06-29 17:39:28.886976	2025-06-29 17:39:28.886976
139	Slovenia	Europe	\N	2025-06-29 17:39:28.902993	2025-06-29 17:39:28.902993
140	Somalia	Eastern Mediterranean	\N	2025-06-29 17:39:28.912381	2025-06-29 17:39:28.912381
141	South Africa	Africa	\N	2025-06-29 17:39:28.925448	2025-06-29 17:39:28.925448
142	South Sudan	Africa	\N	2025-06-29 17:39:28.936408	2025-06-29 17:39:28.936408
143	Spain	Europe	\N	2025-06-29 17:39:28.955013	2025-06-29 17:39:28.955013
144	Sri Lanka	South-East Asia	\N	2025-06-29 17:39:28.968099	2025-06-29 17:39:28.968099
145	Sudan	Eastern Mediterranean	\N	2025-06-29 17:39:28.978762	2025-06-29 17:39:28.978762
146	Suriname	Americas	\N	2025-06-29 17:39:28.993082	2025-06-29 17:39:28.993082
147	Sweden	Europe	\N	2025-06-29 17:39:29.00478	2025-06-29 17:39:29.00478
148	Switzerland	Europe	\N	2025-06-29 17:39:29.016598	2025-06-29 17:39:29.016598
149	Syria	Eastern Mediterranean	\N	2025-06-29 17:39:29.029116	2025-06-29 17:39:29.029116
150	Tajikistan	Europe	\N	2025-06-29 17:39:29.041475	2025-06-29 17:39:29.041475
151	Thailand	South-East Asia	\N	2025-06-29 17:39:29.055396	2025-06-29 17:39:29.055396
152	Timor-Leste	South-East Asia	\N	2025-06-29 17:39:29.065102	2025-06-29 17:39:29.065102
153	Togo	Africa	\N	2025-06-29 17:39:29.078121	2025-06-29 17:39:29.078121
154	Trinidad and Tobago	Americas	\N	2025-06-29 17:39:29.088533	2025-06-29 17:39:29.088533
155	Tunisia	Eastern Mediterranean	\N	2025-06-29 17:39:29.0981	2025-06-29 17:39:29.0981
156	Turkey	Europe	\N	2025-06-29 17:39:29.109854	2025-06-29 17:39:29.109854
157	Turkmenistan	Europe	\N	2025-06-29 17:39:29.120533	2025-06-29 17:39:29.120533
158	Uganda	Africa	\N	2025-06-29 17:39:29.134251	2025-06-29 17:39:29.134251
159	Ukraine	Europe	\N	2025-06-29 17:39:29.145009	2025-06-29 17:39:29.145009
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-29 17:39:29.154584	2025-06-29 17:39:29.154584
161	United Kingdom	Europe	\N	2025-06-29 17:39:29.163305	2025-06-29 17:39:29.163305
162	Tanzania	Africa	\N	2025-06-29 17:39:29.17392	2025-06-29 17:39:29.17392
163	United States	Americas	\N	2025-06-29 17:39:29.183379	2025-06-29 17:39:29.183379
164	Uruguay	Americas	\N	2025-06-29 17:39:29.192981	2025-06-29 17:39:29.192981
165	Uzbekistan	Europe	\N	2025-06-29 17:39:29.210254	2025-06-29 17:39:29.210254
166	Venezuela	Americas	\N	2025-06-29 17:39:29.219709	2025-06-29 17:39:29.219709
167	Viet Nam	Western Pacific	\N	2025-06-29 17:39:29.229344	2025-06-29 17:39:29.229344
168	Yemen	Eastern Mediterranean	\N	2025-06-29 17:39:29.238925	2025-06-29 17:39:29.238925
169	Zambia	Africa	\N	2025-06-29 17:39:29.248647	2025-06-29 17:39:29.248647
170	Zimbabwe	Africa	\N	2025-06-29 17:39:29.260545	2025-06-29 17:39:29.260545
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.273113	2025-06-29 17:39:29.273113
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.321137	2025-06-29 17:39:29.321137
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.33523	2025-06-29 17:39:29.33523
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.353732	2025-06-29 17:39:29.353732
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.364924	2025-06-29 17:39:29.364924
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.381675	2025-06-29 17:39:29.381675
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.393668	2025-06-29 17:39:29.393668
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.406431	2025-06-29 17:39:29.406431
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.430385	2025-06-29 17:39:29.430385
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.45246	2025-06-29 17:39:29.45246
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.463904	2025-06-29 17:39:29.463904
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.489782	2025-06-29 17:39:29.489782
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.507068	2025-06-29 17:39:29.507068
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.517519	2025-06-29 17:39:29.517519
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.529422	2025-06-29 17:39:29.529422
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.540135	2025-06-29 17:39:29.540135
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.551565	2025-06-29 17:39:29.551565
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.562602	2025-06-29 17:39:29.562602
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.576329	2025-06-29 17:39:29.576329
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.588404	2025-06-29 17:39:29.588404
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.600796	2025-06-29 17:39:29.600796
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.612043	2025-06-29 17:39:29.612043
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.624939	2025-06-29 17:39:29.624939
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.638606	2025-06-29 17:39:29.638606
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.655007	2025-06-29 17:39:29.655007
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.669269	2025-06-29 17:39:29.669269
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.686867	2025-06-29 17:39:29.686867
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.706787	2025-06-29 17:39:29.706787
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.728142	2025-06-29 17:39:29.728142
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.747558	2025-06-29 17:39:29.747558
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.763027	2025-06-29 17:39:29.763027
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.777303	2025-06-29 17:39:29.777303
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.795244	2025-06-29 17:39:29.795244
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.814962	2025-06-29 17:39:29.814962
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.836556	2025-06-29 17:39:29.836556
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.848793	2025-06-29 17:39:29.848793
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.869279	2025-06-29 17:39:29.869279
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.902924	2025-06-29 17:39:29.902924
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.919918	2025-06-29 17:39:29.919918
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.953371	2025-06-29 17:39:29.953371
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.971868	2025-06-29 17:39:29.971868
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.982709	2025-06-29 17:39:29.982709
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:29.995273	2025-06-29 17:39:29.995273
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.007506	2025-06-29 17:39:30.007506
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.021867	2025-06-29 17:39:30.021867
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.034727	2025-06-29 17:39:30.034727
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.053051	2025-06-29 17:39:30.053051
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.063116	2025-06-29 17:39:30.063116
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.074299	2025-06-29 17:39:30.074299
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.085871	2025-06-29 17:39:30.085871
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.098215	2025-06-29 17:39:30.098215
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.115411	2025-06-29 17:39:30.115411
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.126937	2025-06-29 17:39:30.126937
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.145662	2025-06-29 17:39:30.145662
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.15485	2025-06-29 17:39:30.15485
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.175824	2025-06-29 17:39:30.175824
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.192138	2025-06-29 17:39:30.192138
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.2039	2025-06-29 17:39:30.2039
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.216179	2025-06-29 17:39:30.216179
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.228894	2025-06-29 17:39:30.228894
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.240007	2025-06-29 17:39:30.240007
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.260096	2025-06-29 17:39:30.260096
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.2764	2025-06-29 17:39:30.2764
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.29156	2025-06-29 17:39:30.29156
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.318192	2025-06-29 17:39:30.318192
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.341949	2025-06-29 17:39:30.341949
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.367049	2025-06-29 17:39:30.367049
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.394076	2025-06-29 17:39:30.394076
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.408354	2025-06-29 17:39:30.408354
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.4354	2025-06-29 17:39:30.4354
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.45254	2025-06-29 17:39:30.45254
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.463901	2025-06-29 17:39:30.463901
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.477305	2025-06-29 17:39:30.477305
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.490943	2025-06-29 17:39:30.490943
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.506371	2025-06-29 17:39:30.506371
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.522874	2025-06-29 17:39:30.522874
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.545402	2025-06-29 17:39:30.545402
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.558409	2025-06-29 17:39:30.558409
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.58299	2025-06-29 17:39:30.58299
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.596142	2025-06-29 17:39:30.596142
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.615199	2025-06-29 17:39:30.615199
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.642463	2025-06-29 17:39:30.642463
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.661125	2025-06-29 17:39:30.661125
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.672971	2025-06-29 17:39:30.672971
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.684052	2025-06-29 17:39:30.684052
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.694834	2025-06-29 17:39:30.694834
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.707798	2025-06-29 17:39:30.707798
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.717364	2025-06-29 17:39:30.717364
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.726919	2025-06-29 17:39:30.726919
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.74008	2025-06-29 17:39:30.74008
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.752718	2025-06-29 17:39:30.752718
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.763016	2025-06-29 17:39:30.763016
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.776628	2025-06-29 17:39:30.776628
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.788779	2025-06-29 17:39:30.788779
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.800538	2025-06-29 17:39:30.800538
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.813624	2025-06-29 17:39:30.813624
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.831119	2025-06-29 17:39:30.831119
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.843323	2025-06-29 17:39:30.843323
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.854699	2025-06-29 17:39:30.854699
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.865801	2025-06-29 17:39:30.865801
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.882855	2025-06-29 17:39:30.882855
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.896366	2025-06-29 17:39:30.896366
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.907115	2025-06-29 17:39:30.907115
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.919678	2025-06-29 17:39:30.919678
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.933883	2025-06-29 17:39:30.933883
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.944002	2025-06-29 17:39:30.944002
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.953866	2025-06-29 17:39:30.953866
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.965637	2025-06-29 17:39:30.965637
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.978893	2025-06-29 17:39:30.978893
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:30.995631	2025-06-29 17:39:30.995631
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.011116	2025-06-29 17:39:31.011116
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.022427	2025-06-29 17:39:31.022427
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.035326	2025-06-29 17:39:31.035326
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.047491	2025-06-29 17:39:31.047491
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.062785	2025-06-29 17:39:31.062785
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.073523	2025-06-29 17:39:31.073523
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.088835	2025-06-29 17:39:31.088835
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.099756	2025-06-29 17:39:31.099756
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.110755	2025-06-29 17:39:31.110755
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.125101	2025-06-29 17:39:31.125101
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.141692	2025-06-29 17:39:31.141692
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.15622	2025-06-29 17:39:31.15622
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.167266	2025-06-29 17:39:31.167266
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.177567	2025-06-29 17:39:31.177567
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.187415	2025-06-29 17:39:31.187415
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.196464	2025-06-29 17:39:31.196464
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.206938	2025-06-29 17:39:31.206938
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.216367	2025-06-29 17:39:31.216367
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.228721	2025-06-29 17:39:31.228721
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.241173	2025-06-29 17:39:31.241173
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.253084	2025-06-29 17:39:31.253084
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.265884	2025-06-29 17:39:31.265884
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.277883	2025-06-29 17:39:31.277883
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.287025	2025-06-29 17:39:31.287025
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.299089	2025-06-29 17:39:31.299089
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.310842	2025-06-29 17:39:31.310842
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.323235	2025-06-29 17:39:31.323235
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.339789	2025-06-29 17:39:31.339789
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.355402	2025-06-29 17:39:31.355402
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.370261	2025-06-29 17:39:31.370261
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.382752	2025-06-29 17:39:31.382752
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.3992	2025-06-29 17:39:31.3992
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.411031	2025-06-29 17:39:31.411031
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.423244	2025-06-29 17:39:31.423244
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.438253	2025-06-29 17:39:31.438253
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.459117	2025-06-29 17:39:31.459117
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.475094	2025-06-29 17:39:31.475094
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.496118	2025-06-29 17:39:31.496118
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.524733	2025-06-29 17:39:31.524733
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.539372	2025-06-29 17:39:31.539372
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.552555	2025-06-29 17:39:31.552555
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.565283	2025-06-29 17:39:31.565283
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.577409	2025-06-29 17:39:31.577409
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.5875	2025-06-29 17:39:31.5875
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.599139	2025-06-29 17:39:31.599139
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.610961	2025-06-29 17:39:31.610961
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.621754	2025-06-29 17:39:31.621754
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.634656	2025-06-29 17:39:31.634656
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.646839	2025-06-29 17:39:31.646839
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.657944	2025-06-29 17:39:31.657944
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.674785	2025-06-29 17:39:31.674785
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.685069	2025-06-29 17:39:31.685069
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.698027	2025-06-29 17:39:31.698027
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.711399	2025-06-29 17:39:31.711399
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.722593	2025-06-29 17:39:31.722593
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.736625	2025-06-29 17:39:31.736625
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.748635	2025-06-29 17:39:31.748635
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.761962	2025-06-29 17:39:31.761962
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.772632	2025-06-29 17:39:31.772632
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.783142	2025-06-29 17:39:31.783142
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.794749	2025-06-29 17:39:31.794749
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.804773	2025-06-29 17:39:31.804773
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.820138	2025-06-29 17:39:31.820138
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.835003	2025-06-29 17:39:31.835003
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.847185	2025-06-29 17:39:31.847185
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.860538	2025-06-29 17:39:31.860538
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.87168	2025-06-29 17:39:31.87168
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.884952	2025-06-29 17:39:31.884952
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.901118	2025-06-29 17:39:31.901118
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.915548	2025-06-29 17:39:31.915548
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.925531	2025-06-29 17:39:31.925531
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.936413	2025-06-29 17:39:31.936413
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.947538	2025-06-29 17:39:31.947538
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.958231	2025-06-29 17:39:31.958231
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.970131	2025-06-29 17:39:31.970131
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.983426	2025-06-29 17:39:31.983426
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:31.997582	2025-06-29 17:39:31.997582
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.010268	2025-06-29 17:39:32.010268
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.024918	2025-06-29 17:39:32.024918
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.038556	2025-06-29 17:39:32.038556
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.05106	2025-06-29 17:39:32.05106
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.06312	2025-06-29 17:39:32.06312
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.080646	2025-06-29 17:39:32.080646
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.090283	2025-06-29 17:39:32.090283
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.10053	2025-06-29 17:39:32.10053
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.110968	2025-06-29 17:39:32.110968
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.121687	2025-06-29 17:39:32.121687
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.132929	2025-06-29 17:39:32.132929
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.14383	2025-06-29 17:39:32.14383
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.155662	2025-06-29 17:39:32.155662
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.170068	2025-06-29 17:39:32.170068
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.182178	2025-06-29 17:39:32.182178
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.192741	2025-06-29 17:39:32.192741
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.204447	2025-06-29 17:39:32.204447
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.218266	2025-06-29 17:39:32.218266
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.236159	2025-06-29 17:39:32.236159
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.254705	2025-06-29 17:39:32.254705
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.274816	2025-06-29 17:39:32.274816
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.299122	2025-06-29 17:39:32.299122
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.313821	2025-06-29 17:39:32.313821
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.331639	2025-06-29 17:39:32.331639
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.346543	2025-06-29 17:39:32.346543
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.361385	2025-06-29 17:39:32.361385
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.386546	2025-06-29 17:39:32.386546
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.396638	2025-06-29 17:39:32.396638
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.40885	2025-06-29 17:39:32.40885
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.424256	2025-06-29 17:39:32.424256
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.466371	2025-06-29 17:39:32.466371
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.487528	2025-06-29 17:39:32.487528
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.521437	2025-06-29 17:39:32.521437
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.537852	2025-06-29 17:39:32.537852
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.563517	2025-06-29 17:39:32.563517
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.576805	2025-06-29 17:39:32.576805
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.589109	2025-06-29 17:39:32.589109
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.611813	2025-06-29 17:39:32.611813
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.628525	2025-06-29 17:39:32.628525
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.645258	2025-06-29 17:39:32.645258
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.668461	2025-06-29 17:39:32.668461
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.681097	2025-06-29 17:39:32.681097
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.692735	2025-06-29 17:39:32.692735
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.705664	2025-06-29 17:39:32.705664
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.718371	2025-06-29 17:39:32.718371
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.733612	2025-06-29 17:39:32.733612
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.754529	2025-06-29 17:39:32.754529
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.773728	2025-06-29 17:39:32.773728
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.788085	2025-06-29 17:39:32.788085
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.808393	2025-06-29 17:39:32.808393
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.833844	2025-06-29 17:39:32.833844
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.846289	2025-06-29 17:39:32.846289
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.86303	2025-06-29 17:39:32.86303
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.876927	2025-06-29 17:39:32.876927
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.897863	2025-06-29 17:39:32.897863
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.921428	2025-06-29 17:39:32.921428
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.935416	2025-06-29 17:39:32.935416
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.965062	2025-06-29 17:39:32.965062
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.978128	2025-06-29 17:39:32.978128
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:32.991429	2025-06-29 17:39:32.991429
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.013313	2025-06-29 17:39:33.013313
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.025706	2025-06-29 17:39:33.025706
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.041846	2025-06-29 17:39:33.041846
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.05597	2025-06-29 17:39:33.05597
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.072207	2025-06-29 17:39:33.072207
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.083276	2025-06-29 17:39:33.083276
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.099134	2025-06-29 17:39:33.099134
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.113675	2025-06-29 17:39:33.113675
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.125933	2025-06-29 17:39:33.125933
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.139154	2025-06-29 17:39:33.139154
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.150544	2025-06-29 17:39:33.150544
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.163166	2025-06-29 17:39:33.163166
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.178791	2025-06-29 17:39:33.178791
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.191659	2025-06-29 17:39:33.191659
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.203031	2025-06-29 17:39:33.203031
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.219288	2025-06-29 17:39:33.219288
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.232296	2025-06-29 17:39:33.232296
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.255702	2025-06-29 17:39:33.255702
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.271603	2025-06-29 17:39:33.271603
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.281652	2025-06-29 17:39:33.281652
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.308446	2025-06-29 17:39:33.308446
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.364045	2025-06-29 17:39:33.364045
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.446778	2025-06-29 17:39:33.446778
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.501328	2025-06-29 17:39:33.501328
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.522335	2025-06-29 17:39:33.522335
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.549798	2025-06-29 17:39:33.549798
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.591424	2025-06-29 17:39:33.591424
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.619441	2025-06-29 17:39:33.619441
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.635752	2025-06-29 17:39:33.635752
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.664367	2025-06-29 17:39:33.664367
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.681711	2025-06-29 17:39:33.681711
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.707996	2025-06-29 17:39:33.707996
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.722705	2025-06-29 17:39:33.722705
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.735504	2025-06-29 17:39:33.735504
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.75388	2025-06-29 17:39:33.75388
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.768518	2025-06-29 17:39:33.768518
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.785064	2025-06-29 17:39:33.785064
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.813176	2025-06-29 17:39:33.813176
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.82372	2025-06-29 17:39:33.82372
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.837156	2025-06-29 17:39:33.837156
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.856211	2025-06-29 17:39:33.856211
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.900625	2025-06-29 17:39:33.900625
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.927178	2025-06-29 17:39:33.927178
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 17:39:33.94486	2025-06-29 17:39:33.94486
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 17:39:27.756305
2	ART Coverage	\N	\N	2025-06-29 17:39:27.764101
3	People Living with HIV	\N	\N	2025-06-29 17:39:27.77033
4	HIV-related Deaths	\N	\N	2025-06-29 17:39:27.776696
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 17:39:27.783548
6	ART Pediatric Coverage	\N	\N	2025-06-29 17:39:27.790824
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$/vWsCoV0OBYRnlFOQB7Kq.gzw4HpEJN0relocjjHBeUwEiUoMnWdm	admin	0	2025-06-29 17:39:27.734712	2025-06-29 17:39:27.734712
2	userch	$2b$12$U2zUF6EvWuFcn/8zufkpPeMRNzSmYyeEvuIzOvxj8gJfdRnNKQK3.	user	0	2025-06-29 17:39:27.740843	2025-06-29 17:39:27.740843
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

