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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 16:25:37.452207	2025-06-29 16:25:37.452207
2	Albania	Europe	\N	2025-06-29 16:25:37.471979	2025-06-29 16:25:37.471979
3	Algeria	Africa	\N	2025-06-29 16:25:37.480099	2025-06-29 16:25:37.480099
4	Angola	Africa	\N	2025-06-29 16:25:37.502645	2025-06-29 16:25:37.502645
5	Argentina	Americas	\N	2025-06-29 16:25:37.511479	2025-06-29 16:25:37.511479
6	Armenia	Europe	\N	2025-06-29 16:25:37.526322	2025-06-29 16:25:37.526322
7	Australia	Western Pacific	\N	2025-06-29 16:25:37.536029	2025-06-29 16:25:37.536029
8	Austria	Europe	\N	2025-06-29 16:25:37.548418	2025-06-29 16:25:37.548418
9	Azerbaijan	Europe	\N	2025-06-29 16:25:37.55758	2025-06-29 16:25:37.55758
10	Bahamas	Americas	\N	2025-06-29 16:25:37.599595	2025-06-29 16:25:37.599595
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 16:25:37.610362	2025-06-29 16:25:37.610362
12	Bangladesh	South-East Asia	\N	2025-06-29 16:25:37.650633	2025-06-29 16:25:37.650633
13	Barbados	Americas	\N	2025-06-29 16:25:37.657778	2025-06-29 16:25:37.657778
14	Belarus	Europe	\N	2025-06-29 16:25:37.666965	2025-06-29 16:25:37.666965
15	Belgium	Europe	\N	2025-06-29 16:25:37.678439	2025-06-29 16:25:37.678439
16	Belize	Americas	\N	2025-06-29 16:25:37.690166	2025-06-29 16:25:37.690166
17	Benin	Africa	\N	2025-06-29 16:25:37.706464	2025-06-29 16:25:37.706464
18	Bhutan	South-East Asia	\N	2025-06-29 16:25:37.713285	2025-06-29 16:25:37.713285
19	Bolivia	Americas	\N	2025-06-29 16:25:37.745129	2025-06-29 16:25:37.745129
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 16:25:37.787891	2025-06-29 16:25:37.787891
21	Botswana	Africa	\N	2025-06-29 16:25:37.800928	2025-06-29 16:25:37.800928
22	Brazil	Americas	\N	2025-06-29 16:25:37.815471	2025-06-29 16:25:37.815471
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 16:25:37.898727	2025-06-29 16:25:37.898727
24	Bulgaria	Europe	\N	2025-06-29 16:25:37.910872	2025-06-29 16:25:37.910872
25	Burkina Faso	Africa	\N	2025-06-29 16:25:37.941637	2025-06-29 16:25:37.941637
26	Burundi	Africa	\N	2025-06-29 16:25:37.952858	2025-06-29 16:25:37.952858
27	Cabo Verde	Africa	\N	2025-06-29 16:25:37.966934	2025-06-29 16:25:37.966934
28	Cambodia	Western Pacific	\N	2025-06-29 16:25:37.984726	2025-06-29 16:25:37.984726
29	Cameroon	Africa	\N	2025-06-29 16:25:37.998862	2025-06-29 16:25:37.998862
30	Canada	Americas	\N	2025-06-29 16:25:38.01197	2025-06-29 16:25:38.01197
31	Central African Republic	Africa	\N	2025-06-29 16:25:38.016316	2025-06-29 16:25:38.016316
32	Chad	Africa	\N	2025-06-29 16:25:38.026209	2025-06-29 16:25:38.026209
33	Chile	Americas	\N	2025-06-29 16:25:38.036745	2025-06-29 16:25:38.036745
34	China	Western Pacific	\N	2025-06-29 16:25:38.047379	2025-06-29 16:25:38.047379
35	Colombia	Americas	\N	2025-06-29 16:25:38.062347	2025-06-29 16:25:38.062347
36	Comoros	Africa	\N	2025-06-29 16:25:38.076946	2025-06-29 16:25:38.076946
37	Congo	Americas	\N	2025-06-29 16:25:38.086039	2025-06-29 16:25:38.086039
38	Costa Rica	Americas	\N	2025-06-29 16:25:38.094959	2025-06-29 16:25:38.094959
39	Côte d'Ivoire	Africa	\N	2025-06-29 16:25:38.103471	2025-06-29 16:25:38.103471
40	Croatia	Europe	\N	2025-06-29 16:25:38.112967	2025-06-29 16:25:38.112967
41	Cuba	Americas	\N	2025-06-29 16:25:38.125036	2025-06-29 16:25:38.125036
42	Cyprus	Europe	\N	2025-06-29 16:25:38.1382	2025-06-29 16:25:38.1382
43	Czechia	Europe	\N	2025-06-29 16:25:38.141288	2025-06-29 16:25:38.141288
44	North Korea	Western Pacific	\N	2025-06-29 16:25:38.152031	2025-06-29 16:25:38.152031
45	DR Congo	Africa	\N	2025-06-29 16:25:38.163932	2025-06-29 16:25:38.163932
46	Denmark	Europe	\N	2025-06-29 16:25:38.171357	2025-06-29 16:25:38.171357
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 16:25:38.214379	2025-06-29 16:25:38.214379
48	Dominican Republic	Americas	\N	2025-06-29 16:25:38.225165	2025-06-29 16:25:38.225165
49	Ecuador	Americas	\N	2025-06-29 16:25:38.268826	2025-06-29 16:25:38.268826
50	Egypt	Eastern Mediterranean	\N	2025-06-29 16:25:38.313714	2025-06-29 16:25:38.313714
51	El Salvador	Americas	\N	2025-06-29 16:25:38.324324	2025-06-29 16:25:38.324324
52	Equatorial Guinea	Africa	\N	2025-06-29 16:25:38.336608	2025-06-29 16:25:38.336608
53	Eritrea	Africa	\N	2025-06-29 16:25:38.380277	2025-06-29 16:25:38.380277
54	Estonia	Europe	\N	2025-06-29 16:25:38.392018	2025-06-29 16:25:38.392018
55	Eswatini	Africa	\N	2025-06-29 16:25:38.414398	2025-06-29 16:25:38.414398
56	Ethiopia	Africa	\N	2025-06-29 16:25:38.426454	2025-06-29 16:25:38.426454
57	Fiji	Western Pacific	\N	2025-06-29 16:25:38.436983	2025-06-29 16:25:38.436983
58	Finland	Europe	\N	2025-06-29 16:25:38.464344	2025-06-29 16:25:38.464344
59	France	Europe	\N	2025-06-29 16:25:38.474114	2025-06-29 16:25:38.474114
60	Gabon	Africa	\N	2025-06-29 16:25:38.48671	2025-06-29 16:25:38.48671
61	Gambia	Africa	\N	2025-06-29 16:25:38.498697	2025-06-29 16:25:38.498697
62	Georgia	Europe	\N	2025-06-29 16:25:38.508819	2025-06-29 16:25:38.508819
63	Germany	Europe	\N	2025-06-29 16:25:38.520752	2025-06-29 16:25:38.520752
64	Ghana	Africa	\N	2025-06-29 16:25:38.531162	2025-06-29 16:25:38.531162
65	Greece	Europe	\N	2025-06-29 16:25:38.541556	2025-06-29 16:25:38.541556
66	Guatemala	Americas	\N	2025-06-29 16:25:38.5522	2025-06-29 16:25:38.5522
67	Guinea	Africa	\N	2025-06-29 16:25:38.56397	2025-06-29 16:25:38.56397
68	Guinea-Bissau	Africa	\N	2025-06-29 16:25:38.575489	2025-06-29 16:25:38.575489
69	Guyana	Americas	\N	2025-06-29 16:25:38.587735	2025-06-29 16:25:38.587735
70	Haiti	Americas	\N	2025-06-29 16:25:38.599141	2025-06-29 16:25:38.599141
71	Honduras	Americas	\N	2025-06-29 16:25:38.611156	2025-06-29 16:25:38.611156
72	Hungary	Europe	\N	2025-06-29 16:25:38.623251	2025-06-29 16:25:38.623251
73	Iceland	Europe	\N	2025-06-29 16:25:38.635139	2025-06-29 16:25:38.635139
74	India	South-East Asia	\N	2025-06-29 16:25:38.650762	2025-06-29 16:25:38.650762
75	Indonesia	South-East Asia	\N	2025-06-29 16:25:38.686959	2025-06-29 16:25:38.686959
76	Iran	Eastern Mediterranean	\N	2025-06-29 16:25:38.697377	2025-06-29 16:25:38.697377
77	Ireland	Europe	\N	2025-06-29 16:25:38.707663	2025-06-29 16:25:38.707663
78	Israel	Europe	\N	2025-06-29 16:25:38.717866	2025-06-29 16:25:38.717866
79	Italy	Europe	\N	2025-06-29 16:25:38.729077	2025-06-29 16:25:38.729077
80	Jamaica	Americas	\N	2025-06-29 16:25:38.742199	2025-06-29 16:25:38.742199
81	Japan	Western Pacific	\N	2025-06-29 16:25:38.752713	2025-06-29 16:25:38.752713
82	Jordan	Eastern Mediterranean	\N	2025-06-29 16:25:38.763284	2025-06-29 16:25:38.763284
83	Kazakhstan	Europe	\N	2025-06-29 16:25:38.777362	2025-06-29 16:25:38.777362
84	Kenya	Africa	\N	2025-06-29 16:25:38.79313	2025-06-29 16:25:38.79313
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 16:25:38.803917	2025-06-29 16:25:38.803917
86	Kyrgyzstan	Europe	\N	2025-06-29 16:25:38.819875	2025-06-29 16:25:38.819875
87	Laos	Western Pacific	\N	2025-06-29 16:25:38.831609	2025-06-29 16:25:38.831609
88	Latvia	Europe	\N	2025-06-29 16:25:38.844277	2025-06-29 16:25:38.844277
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 16:25:38.855998	2025-06-29 16:25:38.855998
90	Lesotho	Africa	\N	2025-06-29 16:25:38.867182	2025-06-29 16:25:38.867182
91	Liberia	Africa	\N	2025-06-29 16:25:38.91621	2025-06-29 16:25:38.91621
92	Libya	Eastern Mediterranean	\N	2025-06-29 16:25:38.936696	2025-06-29 16:25:38.936696
93	Lithuania	Europe	\N	2025-06-29 16:25:38.946749	2025-06-29 16:25:38.946749
94	Luxembourg	Europe	\N	2025-06-29 16:25:38.959887	2025-06-29 16:25:38.959887
95	Madagascar	Africa	\N	2025-06-29 16:25:38.971085	2025-06-29 16:25:38.971085
96	Malawi	Africa	\N	2025-06-29 16:25:38.98192	2025-06-29 16:25:38.98192
97	Malaysia	Western Pacific	\N	2025-06-29 16:25:38.992114	2025-06-29 16:25:38.992114
98	Maldives	South-East Asia	\N	2025-06-29 16:25:38.999976	2025-06-29 16:25:38.999976
99	Mali	Africa	\N	2025-06-29 16:25:39.010653	2025-06-29 16:25:39.010653
100	Malta	Europe	\N	2025-06-29 16:25:39.021005	2025-06-29 16:25:39.021005
101	Mauritania	Africa	\N	2025-06-29 16:25:39.030248	2025-06-29 16:25:39.030248
102	Mauritius	Africa	\N	2025-06-29 16:25:39.041352	2025-06-29 16:25:39.041352
103	Mexico	Americas	\N	2025-06-29 16:25:39.052042	2025-06-29 16:25:39.052042
104	Mongolia	Western Pacific	\N	2025-06-29 16:25:39.063704	2025-06-29 16:25:39.063704
105	Montenegro	Europe	\N	2025-06-29 16:25:39.073645	2025-06-29 16:25:39.073645
106	Morocco	Eastern Mediterranean	\N	2025-06-29 16:25:39.080762	2025-06-29 16:25:39.080762
107	Mozambique	Africa	\N	2025-06-29 16:25:39.089987	2025-06-29 16:25:39.089987
108	Myanmar	South-East Asia	\N	2025-06-29 16:25:39.101117	2025-06-29 16:25:39.101117
109	Namibia	Africa	\N	2025-06-29 16:25:39.111833	2025-06-29 16:25:39.111833
110	Nepal	South-East Asia	\N	2025-06-29 16:25:39.122525	2025-06-29 16:25:39.122525
111	Netherlands	Europe	\N	2025-06-29 16:25:39.132417	2025-06-29 16:25:39.132417
112	New Zealand	Western Pacific	\N	2025-06-29 16:25:39.145326	2025-06-29 16:25:39.145326
113	Nicaragua	Americas	\N	2025-06-29 16:25:39.153821	2025-06-29 16:25:39.153821
114	Niger	Africa	\N	2025-06-29 16:25:39.165668	2025-06-29 16:25:39.165668
115	Nigeria	Africa	\N	2025-06-29 16:25:39.177189	2025-06-29 16:25:39.177189
116	Norway	Europe	\N	2025-06-29 16:25:39.189521	2025-06-29 16:25:39.189521
117	Oman	Eastern Mediterranean	\N	2025-06-29 16:25:39.207176	2025-06-29 16:25:39.207176
118	Pakistan	Eastern Mediterranean	\N	2025-06-29 16:25:39.219779	2025-06-29 16:25:39.219779
119	Panama	Americas	\N	2025-06-29 16:25:39.231934	2025-06-29 16:25:39.231934
120	Papua New Guinea	Western Pacific	\N	2025-06-29 16:25:39.244375	2025-06-29 16:25:39.244375
121	Paraguay	Americas	\N	2025-06-29 16:25:39.258537	2025-06-29 16:25:39.258537
122	Peru	Americas	\N	2025-06-29 16:25:39.266578	2025-06-29 16:25:39.266578
123	Philippines	Western Pacific	\N	2025-06-29 16:25:39.275938	2025-06-29 16:25:39.275938
124	Poland	Europe	\N	2025-06-29 16:25:39.28708	2025-06-29 16:25:39.28708
125	Portugal	Europe	\N	2025-06-29 16:25:39.298626	2025-06-29 16:25:39.298626
126	Qatar	Eastern Mediterranean	\N	2025-06-29 16:25:39.310322	2025-06-29 16:25:39.310322
127	South Korea	Western Pacific	\N	2025-06-29 16:25:39.323028	2025-06-29 16:25:39.323028
128	Moldova	Europe	\N	2025-06-29 16:25:39.33357	2025-06-29 16:25:39.33357
129	North Macedonia	Europe	\N	2025-06-29 16:25:39.344584	2025-06-29 16:25:39.344584
130	Romania	Europe	\N	2025-06-29 16:25:39.354985	2025-06-29 16:25:39.354985
131	Russia	Europe	\N	2025-06-29 16:25:39.368393	2025-06-29 16:25:39.368393
132	Rwanda	Africa	\N	2025-06-29 16:25:39.380967	2025-06-29 16:25:39.380967
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-29 16:25:39.391871	2025-06-29 16:25:39.391871
134	Senegal	Africa	\N	2025-06-29 16:25:39.403589	2025-06-29 16:25:39.403589
135	Serbia	Europe	\N	2025-06-29 16:25:39.415377	2025-06-29 16:25:39.415377
136	Sierra Leone	Africa	\N	2025-06-29 16:25:39.427596	2025-06-29 16:25:39.427596
137	Singapore	Western Pacific	\N	2025-06-29 16:25:39.452857	2025-06-29 16:25:39.452857
138	Slovakia	Europe	\N	2025-06-29 16:25:39.46281	2025-06-29 16:25:39.46281
139	Slovenia	Europe	\N	2025-06-29 16:25:39.478708	2025-06-29 16:25:39.478708
140	Somalia	Eastern Mediterranean	\N	2025-06-29 16:25:39.488809	2025-06-29 16:25:39.488809
141	South Africa	Africa	\N	2025-06-29 16:25:39.504002	2025-06-29 16:25:39.504002
142	South Sudan	Africa	\N	2025-06-29 16:25:39.530937	2025-06-29 16:25:39.530937
143	Spain	Europe	\N	2025-06-29 16:25:39.54156	2025-06-29 16:25:39.54156
144	Sri Lanka	South-East Asia	\N	2025-06-29 16:25:39.571703	2025-06-29 16:25:39.571703
145	Sudan	Eastern Mediterranean	\N	2025-06-29 16:25:39.582694	2025-06-29 16:25:39.582694
146	Suriname	Americas	\N	2025-06-29 16:25:39.594749	2025-06-29 16:25:39.594749
147	Sweden	Europe	\N	2025-06-29 16:25:39.606015	2025-06-29 16:25:39.606015
148	Switzerland	Europe	\N	2025-06-29 16:25:39.650588	2025-06-29 16:25:39.650588
149	Syria	Eastern Mediterranean	\N	2025-06-29 16:25:39.661849	2025-06-29 16:25:39.661849
150	Tajikistan	Europe	\N	2025-06-29 16:25:39.69867	2025-06-29 16:25:39.69867
151	Thailand	South-East Asia	\N	2025-06-29 16:25:39.70888	2025-06-29 16:25:39.70888
152	Timor-Leste	South-East Asia	\N	2025-06-29 16:25:39.729172	2025-06-29 16:25:39.729172
153	Togo	Africa	\N	2025-06-29 16:25:39.747328	2025-06-29 16:25:39.747328
154	Trinidad and Tobago	Americas	\N	2025-06-29 16:25:39.75979	2025-06-29 16:25:39.75979
155	Tunisia	Eastern Mediterranean	\N	2025-06-29 16:25:39.776496	2025-06-29 16:25:39.776496
156	Turkey	Europe	\N	2025-06-29 16:25:39.787023	2025-06-29 16:25:39.787023
157	Turkmenistan	Europe	\N	2025-06-29 16:25:39.833884	2025-06-29 16:25:39.833884
158	Uganda	Africa	\N	2025-06-29 16:25:39.850396	2025-06-29 16:25:39.850396
159	Ukraine	Europe	\N	2025-06-29 16:25:39.861234	2025-06-29 16:25:39.861234
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-29 16:25:39.873106	2025-06-29 16:25:39.873106
161	United Kingdom	Europe	\N	2025-06-29 16:25:39.884127	2025-06-29 16:25:39.884127
162	Tanzania	Africa	\N	2025-06-29 16:25:39.913613	2025-06-29 16:25:39.913613
163	United States	Americas	\N	2025-06-29 16:25:39.925319	2025-06-29 16:25:39.925319
164	Uruguay	Americas	\N	2025-06-29 16:25:39.935754	2025-06-29 16:25:39.935754
165	Uzbekistan	Europe	\N	2025-06-29 16:25:39.947518	2025-06-29 16:25:39.947518
166	Venezuela	Americas	\N	2025-06-29 16:25:39.990341	2025-06-29 16:25:39.990341
167	Viet Nam	Western Pacific	\N	2025-06-29 16:25:40.001029	2025-06-29 16:25:40.001029
168	Yemen	Eastern Mediterranean	\N	2025-06-29 16:25:40.026593	2025-06-29 16:25:40.026593
169	Zambia	Africa	\N	2025-06-29 16:25:40.036926	2025-06-29 16:25:40.036926
170	Zimbabwe	Africa	\N	2025-06-29 16:25:40.047016	2025-06-29 16:25:40.047016
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.076497	2025-06-29 16:25:40.076497
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.119131	2025-06-29 16:25:40.119131
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.129689	2025-06-29 16:25:40.129689
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.171635	2025-06-29 16:25:40.171635
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.182123	2025-06-29 16:25:40.182123
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.196345	2025-06-29 16:25:40.196345
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.229847	2025-06-29 16:25:40.229847
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.252181	2025-06-29 16:25:40.252181
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.262493	2025-06-29 16:25:40.262493
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.273486	2025-06-29 16:25:40.273486
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.294557	2025-06-29 16:25:40.294557
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.305811	2025-06-29 16:25:40.305811
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.339226	2025-06-29 16:25:40.339226
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.382066	2025-06-29 16:25:40.382066
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.393136	2025-06-29 16:25:40.393136
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.403812	2025-06-29 16:25:40.403812
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.434665	2025-06-29 16:25:40.434665
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.44854	2025-06-29 16:25:40.44854
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.480521	2025-06-29 16:25:40.480521
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.491452	2025-06-29 16:25:40.491452
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.535378	2025-06-29 16:25:40.535378
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.558946	2025-06-29 16:25:40.558946
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.570963	2025-06-29 16:25:40.570963
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.581112	2025-06-29 16:25:40.581112
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.59301	2025-06-29 16:25:40.59301
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.603945	2025-06-29 16:25:40.603945
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.615095	2025-06-29 16:25:40.615095
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.62587	2025-06-29 16:25:40.62587
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.637388	2025-06-29 16:25:40.637388
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.647606	2025-06-29 16:25:40.647606
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.658203	2025-06-29 16:25:40.658203
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.701997	2025-06-29 16:25:40.701997
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.712667	2025-06-29 16:25:40.712667
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.755646	2025-06-29 16:25:40.755646
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.766661	2025-06-29 16:25:40.766661
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.80602	2025-06-29 16:25:40.80602
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.816322	2025-06-29 16:25:40.816322
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.826595	2025-06-29 16:25:40.826595
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.838428	2025-06-29 16:25:40.838428
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.850246	2025-06-29 16:25:40.850246
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.860768	2025-06-29 16:25:40.860768
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.871924	2025-06-29 16:25:40.871924
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.886232	2025-06-29 16:25:40.886232
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.897339	2025-06-29 16:25:40.897339
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.90737	2025-06-29 16:25:40.90737
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.917708	2025-06-29 16:25:40.917708
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.931296	2025-06-29 16:25:40.931296
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.942063	2025-06-29 16:25:40.942063
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.954226	2025-06-29 16:25:40.954226
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.964649	2025-06-29 16:25:40.964649
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.977302	2025-06-29 16:25:40.977302
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.988596	2025-06-29 16:25:40.988596
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:40.998991	2025-06-29 16:25:40.998991
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.009377	2025-06-29 16:25:41.009377
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.037775	2025-06-29 16:25:41.037775
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.047771	2025-06-29 16:25:41.047771
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.069449	2025-06-29 16:25:41.069449
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.112783	2025-06-29 16:25:41.112783
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.125765	2025-06-29 16:25:41.125765
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.170922	2025-06-29 16:25:41.170922
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.181154	2025-06-29 16:25:41.181154
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.207535	2025-06-29 16:25:41.207535
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.218816	2025-06-29 16:25:41.218816
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.228983	2025-06-29 16:25:41.228983
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.239503	2025-06-29 16:25:41.239503
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.261344	2025-06-29 16:25:41.261344
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.273006	2025-06-29 16:25:41.273006
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.299957	2025-06-29 16:25:41.299957
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.310347	2025-06-29 16:25:41.310347
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.357161	2025-06-29 16:25:41.357161
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.368548	2025-06-29 16:25:41.368548
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.441711	2025-06-29 16:25:41.441711
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.456807	2025-06-29 16:25:41.456807
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.467881	2025-06-29 16:25:41.467881
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.485266	2025-06-29 16:25:41.485266
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.49731	2025-06-29 16:25:41.49731
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.507617	2025-06-29 16:25:41.507617
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.518388	2025-06-29 16:25:41.518388
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.536252	2025-06-29 16:25:41.536252
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.55169	2025-06-29 16:25:41.55169
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.591732	2025-06-29 16:25:41.591732
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.603604	2025-06-29 16:25:41.603604
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.611339	2025-06-29 16:25:41.611339
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.656181	2025-06-29 16:25:41.656181
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.663249	2025-06-29 16:25:41.663249
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.675162	2025-06-29 16:25:41.675162
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.684806	2025-06-29 16:25:41.684806
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.6956	2025-06-29 16:25:41.6956
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.738413	2025-06-29 16:25:41.738413
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.749032	2025-06-29 16:25:41.749032
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.792994	2025-06-29 16:25:41.792994
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.804258	2025-06-29 16:25:41.804258
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.813783	2025-06-29 16:25:41.813783
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.825486	2025-06-29 16:25:41.825486
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.836774	2025-06-29 16:25:41.836774
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.848311	2025-06-29 16:25:41.848311
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.892369	2025-06-29 16:25:41.892369
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.904272	2025-06-29 16:25:41.904272
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.932388	2025-06-29 16:25:41.932388
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.942671	2025-06-29 16:25:41.942671
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.986017	2025-06-29 16:25:41.986017
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.996643	2025-06-29 16:25:41.996643
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.040529	2025-06-29 16:25:42.040529
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.051588	2025-06-29 16:25:42.051588
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.062896	2025-06-29 16:25:42.062896
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.074124	2025-06-29 16:25:42.074124
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.127271	2025-06-29 16:25:42.127271
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.138478	2025-06-29 16:25:42.138478
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.182029	2025-06-29 16:25:42.182029
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.225968	2025-06-29 16:25:42.225968
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.237129	2025-06-29 16:25:42.237129
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.28095	2025-06-29 16:25:42.28095
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.291465	2025-06-29 16:25:42.291465
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.302042	2025-06-29 16:25:42.302042
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.344186	2025-06-29 16:25:42.344186
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.359961	2025-06-29 16:25:42.359961
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.372894	2025-06-29 16:25:42.372894
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.416238	2025-06-29 16:25:42.416238
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.42435	2025-06-29 16:25:42.42435
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.437344	2025-06-29 16:25:42.437344
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.480754	2025-06-29 16:25:42.480754
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.491455	2025-06-29 16:25:42.491455
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.534462	2025-06-29 16:25:42.534462
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.544903	2025-06-29 16:25:42.544903
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.555256	2025-06-29 16:25:42.555256
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.585694	2025-06-29 16:25:42.585694
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.597124	2025-06-29 16:25:42.597124
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.607635	2025-06-29 16:25:42.607635
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.619025	2025-06-29 16:25:42.619025
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.654384	2025-06-29 16:25:42.654384
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.666002	2025-06-29 16:25:42.666002
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.709931	2025-06-29 16:25:42.709931
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.720499	2025-06-29 16:25:42.720499
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.764108	2025-06-29 16:25:42.764108
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.806839	2025-06-29 16:25:42.806839
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.816356	2025-06-29 16:25:42.816356
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.850862	2025-06-29 16:25:42.850862
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.861244	2025-06-29 16:25:42.861244
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.871474	2025-06-29 16:25:42.871474
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.8823	2025-06-29 16:25:42.8823
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.893492	2025-06-29 16:25:42.893492
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.909421	2025-06-29 16:25:42.909421
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.922893	2025-06-29 16:25:42.922893
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.932829	2025-06-29 16:25:42.932829
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.942736	2025-06-29 16:25:42.942736
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.95317	2025-06-29 16:25:42.95317
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.964552	2025-06-29 16:25:42.964552
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.973984	2025-06-29 16:25:42.973984
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.984494	2025-06-29 16:25:42.984494
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.995957	2025-06-29 16:25:42.995957
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.006555	2025-06-29 16:25:43.006555
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.018212	2025-06-29 16:25:43.018212
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.029108	2025-06-29 16:25:43.029108
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.040234	2025-06-29 16:25:43.040234
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.510504	2025-06-29 16:25:42.510504
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.589958	2025-06-29 16:25:41.589958
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.601932	2025-06-29 16:25:41.601932
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.616466	2025-06-29 16:25:41.616466
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.632282	2025-06-29 16:25:41.632282
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.64483	2025-06-29 16:25:41.64483
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.661848	2025-06-29 16:25:41.661848
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.678923	2025-06-29 16:25:41.678923
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.69591	2025-06-29 16:25:41.69591
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.711907	2025-06-29 16:25:41.711907
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.723773	2025-06-29 16:25:41.723773
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.737919	2025-06-29 16:25:41.737919
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.761473	2025-06-29 16:25:41.761473
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.77819	2025-06-29 16:25:41.77819
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.787661	2025-06-29 16:25:41.787661
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.798964	2025-06-29 16:25:41.798964
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.809957	2025-06-29 16:25:41.809957
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.821809	2025-06-29 16:25:41.821809
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.833034	2025-06-29 16:25:41.833034
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.843875	2025-06-29 16:25:41.843875
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.853951	2025-06-29 16:25:41.853951
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.863032	2025-06-29 16:25:41.863032
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.872911	2025-06-29 16:25:41.872911
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.883275	2025-06-29 16:25:41.883275
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.893885	2025-06-29 16:25:41.893885
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.904974	2025-06-29 16:25:41.904974
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.914856	2025-06-29 16:25:41.914856
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.926796	2025-06-29 16:25:41.926796
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.936172	2025-06-29 16:25:41.936172
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.945248	2025-06-29 16:25:41.945248
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.954759	2025-06-29 16:25:41.954759
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.96517	2025-06-29 16:25:41.96517
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.974435	2025-06-29 16:25:41.974435
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.987623	2025-06-29 16:25:41.987623
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:41.998758	2025-06-29 16:25:41.998758
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.011144	2025-06-29 16:25:42.011144
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.023214	2025-06-29 16:25:42.023214
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.034687	2025-06-29 16:25:42.034687
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.045604	2025-06-29 16:25:42.045604
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.059351	2025-06-29 16:25:42.059351
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.07265	2025-06-29 16:25:42.07265
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.08379	2025-06-29 16:25:42.08379
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.094216	2025-06-29 16:25:42.094216
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.106096	2025-06-29 16:25:42.106096
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.11661	2025-06-29 16:25:42.11661
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.125904	2025-06-29 16:25:42.125904
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.137483	2025-06-29 16:25:42.137483
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.15335	2025-06-29 16:25:42.15335
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.163352	2025-06-29 16:25:42.163352
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.173159	2025-06-29 16:25:42.173159
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.184117	2025-06-29 16:25:42.184117
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.193804	2025-06-29 16:25:42.193804
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.204231	2025-06-29 16:25:42.204231
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.213875	2025-06-29 16:25:42.213875
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.223502	2025-06-29 16:25:42.223502
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.234627	2025-06-29 16:25:42.234627
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.246745	2025-06-29 16:25:42.246745
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.257926	2025-06-29 16:25:42.257926
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.26985	2025-06-29 16:25:42.26985
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.289963	2025-06-29 16:25:42.289963
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.302209	2025-06-29 16:25:42.302209
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.315589	2025-06-29 16:25:42.315589
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.326915	2025-06-29 16:25:42.326915
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.338121	2025-06-29 16:25:42.338121
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.348112	2025-06-29 16:25:42.348112
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.358571	2025-06-29 16:25:42.358571
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.368345	2025-06-29 16:25:42.368345
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.378882	2025-06-29 16:25:42.378882
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.390097	2025-06-29 16:25:42.390097
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.420805	2025-06-29 16:25:42.420805
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.430918	2025-06-29 16:25:42.430918
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.441644	2025-06-29 16:25:42.441644
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.457963	2025-06-29 16:25:42.457963
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.46792	2025-06-29 16:25:42.46792
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.477877	2025-06-29 16:25:42.477877
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.50773	2025-06-29 16:25:42.50773
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.517398	2025-06-29 16:25:42.517398
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.528528	2025-06-29 16:25:42.528528
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.54014	2025-06-29 16:25:42.54014
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.553943	2025-06-29 16:25:42.553943
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.564452	2025-06-29 16:25:42.564452
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.575988	2025-06-29 16:25:42.575988
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.587047	2025-06-29 16:25:42.587047
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.599992	2025-06-29 16:25:42.599992
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.612882	2025-06-29 16:25:42.612882
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.622578	2025-06-29 16:25:42.622578
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.636329	2025-06-29 16:25:42.636329
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.648699	2025-06-29 16:25:42.648699
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.658285	2025-06-29 16:25:42.658285
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.667973	2025-06-29 16:25:42.667973
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.678161	2025-06-29 16:25:42.678161
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.688986	2025-06-29 16:25:42.688986
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.69852	2025-06-29 16:25:42.69852
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.709258	2025-06-29 16:25:42.709258
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.719065	2025-06-29 16:25:42.719065
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.733261	2025-06-29 16:25:42.733261
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.742983	2025-06-29 16:25:42.742983
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.755519	2025-06-29 16:25:42.755519
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.766167	2025-06-29 16:25:42.766167
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.775831	2025-06-29 16:25:42.775831
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.785279	2025-06-29 16:25:42.785279
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.796687	2025-06-29 16:25:42.796687
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.806266	2025-06-29 16:25:42.806266
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.815598	2025-06-29 16:25:42.815598
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.826812	2025-06-29 16:25:42.826812
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.837203	2025-06-29 16:25:42.837203
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.849117	2025-06-29 16:25:42.849117
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.859772	2025-06-29 16:25:42.859772
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.871179	2025-06-29 16:25:42.871179
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.881716	2025-06-29 16:25:42.881716
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.892251	2025-06-29 16:25:42.892251
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.904312	2025-06-29 16:25:42.904312
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.916519	2025-06-29 16:25:42.916519
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.928973	2025-06-29 16:25:42.928973
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.940744	2025-06-29 16:25:42.940744
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.950473	2025-06-29 16:25:42.950473
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.962469	2025-06-29 16:25:42.962469
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.97237	2025-06-29 16:25:42.97237
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.983518	2025-06-29 16:25:42.983518
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:42.99465	2025-06-29 16:25:42.99465
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.004424	2025-06-29 16:25:43.004424
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.014326	2025-06-29 16:25:43.014326
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.025401	2025-06-29 16:25:43.025401
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.034703	2025-06-29 16:25:43.034703
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.045829	2025-06-29 16:25:43.045829
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.05599	2025-06-29 16:25:43.05599
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.065917	2025-06-29 16:25:43.065917
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.075145	2025-06-29 16:25:43.075145
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.087706	2025-06-29 16:25:43.087706
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.099567	2025-06-29 16:25:43.099567
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.110868	2025-06-29 16:25:43.110868
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.123634	2025-06-29 16:25:43.123634
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.134123	2025-06-29 16:25:43.134123
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.145655	2025-06-29 16:25:43.145655
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.156236	2025-06-29 16:25:43.156236
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.166556	2025-06-29 16:25:43.166556
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.177115	2025-06-29 16:25:43.177115
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.190257	2025-06-29 16:25:43.190257
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.202101	2025-06-29 16:25:43.202101
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.212706	2025-06-29 16:25:43.212706
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.222726	2025-06-29 16:25:43.222726
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.233482	2025-06-29 16:25:43.233482
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.243974	2025-06-29 16:25:43.243974
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.25424	2025-06-29 16:25:43.25424
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.26467	2025-06-29 16:25:43.26467
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.275225	2025-06-29 16:25:43.275225
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.286165	2025-06-29 16:25:43.286165
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.297245	2025-06-29 16:25:43.297245
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.309546	2025-06-29 16:25:43.309546
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:43.320172	2025-06-29 16:25:43.320172
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.330732	2025-06-29 16:25:43.330732
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.342111	2025-06-29 16:25:43.342111
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.37641	2025-06-29 16:25:43.37641
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.410401	2025-06-29 16:25:43.410401
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.422562	2025-06-29 16:25:43.422562
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.466076	2025-06-29 16:25:43.466076
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.477554	2025-06-29 16:25:43.477554
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.522313	2025-06-29 16:25:43.522313
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.53223	2025-06-29 16:25:43.53223
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.556578	2025-06-29 16:25:43.556578
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.600148	2025-06-29 16:25:43.600148
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.609135	2025-06-29 16:25:43.609135
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.617021	2025-06-29 16:25:43.617021
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.62703	2025-06-29 16:25:43.62703
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.669457	2025-06-29 16:25:43.669457
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.680219	2025-06-29 16:25:43.680219
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.72411	2025-06-29 16:25:43.72411
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.734574	2025-06-29 16:25:43.734574
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.766428	2025-06-29 16:25:43.766428
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.799004	2025-06-29 16:25:43.799004
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.810385	2025-06-29 16:25:43.810385
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.832348	2025-06-29 16:25:43.832348
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.876716	2025-06-29 16:25:43.876716
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.921005	2025-06-29 16:25:43.921005
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.9321	2025-06-29 16:25:43.9321
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.975747	2025-06-29 16:25:43.975747
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:43.987884	2025-06-29 16:25:43.987884
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.034098	2025-06-29 16:25:44.034098
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.048906	2025-06-29 16:25:44.048906
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.086845	2025-06-29 16:25:44.086845
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.134519	2025-06-29 16:25:44.134519
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.146267	2025-06-29 16:25:44.146267
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.167735	2025-06-29 16:25:44.167735
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.178015	2025-06-29 16:25:44.178015
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.192876	2025-06-29 16:25:44.192876
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.203526	2025-06-29 16:25:44.203526
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.247735	2025-06-29 16:25:44.247735
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.294879	2025-06-29 16:25:44.294879
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.308242	2025-06-29 16:25:44.308242
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.353974	2025-06-29 16:25:44.353974
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.371594	2025-06-29 16:25:44.371594
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.382138	2025-06-29 16:25:44.382138
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.394548	2025-06-29 16:25:44.394548
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.412727	2025-06-29 16:25:44.412727
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.427287	2025-06-29 16:25:44.427287
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.447759	2025-06-29 16:25:44.447759
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.460426	2025-06-29 16:25:44.460426
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.470745	2025-06-29 16:25:44.470745
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.480783	2025-06-29 16:25:44.480783
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.490845	2025-06-29 16:25:44.490845
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.500763	2025-06-29 16:25:44.500763
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.546638	2025-06-29 16:25:44.546638
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.628426	2025-06-29 16:25:44.628426
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.652086	2025-06-29 16:25:44.652086
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.678626	2025-06-29 16:25:44.678626
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.720432	2025-06-29 16:25:44.720432
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.756871	2025-06-29 16:25:44.756871
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.825028	2025-06-29 16:25:44.825028
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.959886	2025-06-29 16:25:44.959886
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:44.993124	2025-06-29 16:25:44.993124
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.026322	2025-06-29 16:25:45.026322
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.083595	2025-06-29 16:25:45.083595
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.114186	2025-06-29 16:25:45.114186
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.137969	2025-06-29 16:25:45.137969
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.177881	2025-06-29 16:25:45.177881
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.19913	2025-06-29 16:25:45.19913
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.292754	2025-06-29 16:25:45.292754
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.322957	2025-06-29 16:25:45.322957
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.335012	2025-06-29 16:25:45.335012
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.353121	2025-06-29 16:25:45.353121
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.374647	2025-06-29 16:25:45.374647
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.394928	2025-06-29 16:25:45.394928
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.422287	2025-06-29 16:25:45.422287
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.51105	2025-06-29 16:25:45.51105
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.672981	2025-06-29 16:25:45.672981
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.690921	2025-06-29 16:25:45.690921
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.766011	2025-06-29 16:25:45.766011
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.833952	2025-06-29 16:25:45.833952
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.850505	2025-06-29 16:25:45.850505
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.884306	2025-06-29 16:25:45.884306
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.90991	2025-06-29 16:25:45.90991
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.944943	2025-06-29 16:25:45.944943
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:45.969979	2025-06-29 16:25:45.969979
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.048454	2025-06-29 16:25:46.048454
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.106081	2025-06-29 16:25:46.106081
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.118291	2025-06-29 16:25:46.118291
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.167776	2025-06-29 16:25:46.167776
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.183072	2025-06-29 16:25:46.183072
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.240924	2025-06-29 16:25:46.240924
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.376347	2025-06-29 16:25:46.376347
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.390022	2025-06-29 16:25:46.390022
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.405534	2025-06-29 16:25:46.405534
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.426352	2025-06-29 16:25:46.426352
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.440924	2025-06-29 16:25:46.440924
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.451752	2025-06-29 16:25:46.451752
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.467482	2025-06-29 16:25:46.467482
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.495752	2025-06-29 16:25:46.495752
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.536694	2025-06-29 16:25:46.536694
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.575925	2025-06-29 16:25:46.575925
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.59937	2025-06-29 16:25:46.59937
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.617244	2025-06-29 16:25:46.617244
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.761343	2025-06-29 16:25:46.761343
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.81215	2025-06-29 16:25:46.81215
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.827825	2025-06-29 16:25:46.827825
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.857355	2025-06-29 16:25:46.857355
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:46.888563	2025-06-29 16:25:46.888563
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.017245	2025-06-29 16:25:47.017245
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.038832	2025-06-29 16:25:47.038832
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.059777	2025-06-29 16:25:47.059777
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.102043	2025-06-29 16:25:47.102043
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.125712	2025-06-29 16:25:47.125712
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.144256	2025-06-29 16:25:47.144256
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.167916	2025-06-29 16:25:47.167916
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.215341	2025-06-29 16:25:47.215341
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.322178	2025-06-29 16:25:47.322178
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.368326	2025-06-29 16:25:47.368326
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.386859	2025-06-29 16:25:47.386859
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.413682	2025-06-29 16:25:47.413682
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.458158	2025-06-29 16:25:47.458158
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.475669	2025-06-29 16:25:47.475669
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.496362	2025-06-29 16:25:47.496362
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.515484	2025-06-29 16:25:47.515484
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.534442	2025-06-29 16:25:47.534442
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.547873	2025-06-29 16:25:47.547873
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.569814	2025-06-29 16:25:47.569814
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.590716	2025-06-29 16:25:47.590716
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.609257	2025-06-29 16:25:47.609257
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.650783	2025-06-29 16:25:47.650783
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.693678	2025-06-29 16:25:47.693678
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.728106	2025-06-29 16:25:47.728106
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.770535	2025-06-29 16:25:47.770535
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.813928	2025-06-29 16:25:47.813928
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.823707	2025-06-29 16:25:47.823707
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.846711	2025-06-29 16:25:47.846711
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.891461	2025-06-29 16:25:47.891461
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.911381	2025-06-29 16:25:47.911381
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.949293	2025-06-29 16:25:47.949293
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:47.994513	2025-06-29 16:25:47.994513
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.027417	2025-06-29 16:25:48.027417
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.155685	2025-06-29 16:25:48.155685
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.362621	2025-06-29 16:25:48.362621
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.399628	2025-06-29 16:25:48.399628
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.437495	2025-06-29 16:25:48.437495
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.526129	2025-06-29 16:25:48.526129
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.545389	2025-06-29 16:25:48.545389
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.605641	2025-06-29 16:25:48.605641
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.622511	2025-06-29 16:25:48.622511
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.676734	2025-06-29 16:25:48.676734
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.713842	2025-06-29 16:25:48.713842
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.783534	2025-06-29 16:25:48.783534
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.803372	2025-06-29 16:25:48.803372
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.81608	2025-06-29 16:25:48.81608
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.831735	2025-06-29 16:25:48.831735
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.846179	2025-06-29 16:25:48.846179
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.86607	2025-06-29 16:25:48.86607
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.878779	2025-06-29 16:25:48.878779
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.894652	2025-06-29 16:25:48.894652
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.920094	2025-06-29 16:25:48.920094
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.93613	2025-06-29 16:25:48.93613
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.951867	2025-06-29 16:25:48.951867
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.967026	2025-06-29 16:25:48.967026
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:48.988241	2025-06-29 16:25:48.988241
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.000094	2025-06-29 16:25:49.000094
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.013196	2025-06-29 16:25:49.013196
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.041729	2025-06-29 16:25:49.041729
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.099318	2025-06-29 16:25:49.099318
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.112252	2025-06-29 16:25:49.112252
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.126254	2025-06-29 16:25:49.126254
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.213659	2025-06-29 16:25:49.213659
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.239372	2025-06-29 16:25:49.239372
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.253689	2025-06-29 16:25:49.253689
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.265048	2025-06-29 16:25:49.265048
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.281131	2025-06-29 16:25:49.281131
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.316897	2025-06-29 16:25:49.316897
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.348376	2025-06-29 16:25:49.348376
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.431136	2025-06-29 16:25:49.431136
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.455314	2025-06-29 16:25:49.455314
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.477373	2025-06-29 16:25:49.477373
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.528292	2025-06-29 16:25:49.528292
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.543158	2025-06-29 16:25:49.543158
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.553762	2025-06-29 16:25:49.553762
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.585347	2025-06-29 16:25:49.585347
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.607809	2025-06-29 16:25:49.607809
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.633882	2025-06-29 16:25:49.633882
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.654354	2025-06-29 16:25:49.654354
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.66871	2025-06-29 16:25:49.66871
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.693386	2025-06-29 16:25:49.693386
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.708728	2025-06-29 16:25:49.708728
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.723941	2025-06-29 16:25:49.723941
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.742126	2025-06-29 16:25:49.742126
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.756487	2025-06-29 16:25:49.756487
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.7693	2025-06-29 16:25:49.7693
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.803408	2025-06-29 16:25:49.803408
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.837022	2025-06-29 16:25:49.837022
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.858207	2025-06-29 16:25:49.858207
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.92049	2025-06-29 16:25:49.92049
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.93871	2025-06-29 16:25:49.93871
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.963988	2025-06-29 16:25:49.963988
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.983282	2025-06-29 16:25:49.983282
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:49.997366	2025-06-29 16:25:49.997366
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.016673	2025-06-29 16:25:50.016673
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.039905	2025-06-29 16:25:50.039905
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.057571	2025-06-29 16:25:50.057571
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.075815	2025-06-29 16:25:50.075815
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.114564	2025-06-29 16:25:50.114564
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.144716	2025-06-29 16:25:50.144716
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.163389	2025-06-29 16:25:50.163389
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.182081	2025-06-29 16:25:50.182081
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.203324	2025-06-29 16:25:50.203324
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.218717	2025-06-29 16:25:50.218717
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.258687	2025-06-29 16:25:50.258687
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.29416	2025-06-29 16:25:50.29416
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.341826	2025-06-29 16:25:50.341826
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.365646	2025-06-29 16:25:50.365646
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.391303	2025-06-29 16:25:50.391303
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.412866	2025-06-29 16:25:50.412866
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.429458	2025-06-29 16:25:50.429458
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.447862	2025-06-29 16:25:50.447862
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.487516	2025-06-29 16:25:50.487516
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.518543	2025-06-29 16:25:50.518543
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.547275	2025-06-29 16:25:50.547275
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.581136	2025-06-29 16:25:50.581136
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.610983	2025-06-29 16:25:50.610983
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.632354	2025-06-29 16:25:50.632354
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.650045	2025-06-29 16:25:50.650045
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.726255	2025-06-29 16:25:50.726255
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.739233	2025-06-29 16:25:50.739233
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.761838	2025-06-29 16:25:50.761838
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.794659	2025-06-29 16:25:50.794659
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.820793	2025-06-29 16:25:50.820793
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.866271	2025-06-29 16:25:50.866271
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.901016	2025-06-29 16:25:50.901016
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.917857	2025-06-29 16:25:50.917857
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:50.976268	2025-06-29 16:25:50.976268
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.009602	2025-06-29 16:25:51.009602
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.024196	2025-06-29 16:25:51.024196
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.036899	2025-06-29 16:25:51.036899
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.05073	2025-06-29 16:25:51.05073
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.06658	2025-06-29 16:25:51.06658
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.085324	2025-06-29 16:25:51.085324
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.103594	2025-06-29 16:25:51.103594
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.181445	2025-06-29 16:25:51.181445
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.210891	2025-06-29 16:25:51.210891
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.228794	2025-06-29 16:25:51.228794
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.24695	2025-06-29 16:25:51.24695
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.282001	2025-06-29 16:25:51.282001
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.299835	2025-06-29 16:25:51.299835
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.313271	2025-06-29 16:25:51.313271
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.329537	2025-06-29 16:25:51.329537
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.346464	2025-06-29 16:25:51.346464
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.359205	2025-06-29 16:25:51.359205
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.374369	2025-06-29 16:25:51.374369
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.397987	2025-06-29 16:25:51.397987
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.420765	2025-06-29 16:25:51.420765
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.445449	2025-06-29 16:25:51.445449
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.536334	2025-06-29 16:25:51.536334
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.547495	2025-06-29 16:25:51.547495
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.572626	2025-06-29 16:25:51.572626
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.598897	2025-06-29 16:25:51.598897
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.629891	2025-06-29 16:25:51.629891
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.643329	2025-06-29 16:25:51.643329
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.664631	2025-06-29 16:25:51.664631
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.680422	2025-06-29 16:25:51.680422
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.693453	2025-06-29 16:25:51.693453
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.711367	2025-06-29 16:25:51.711367
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.739196	2025-06-29 16:25:51.739196
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.754313	2025-06-29 16:25:51.754313
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.764398	2025-06-29 16:25:51.764398
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.823011	2025-06-29 16:25:51.823011
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.839465	2025-06-29 16:25:51.839465
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.849722	2025-06-29 16:25:51.849722
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.872532	2025-06-29 16:25:51.872532
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.901307	2025-06-29 16:25:51.901307
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.912849	2025-06-29 16:25:51.912849
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.927271	2025-06-29 16:25:51.927271
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.94634	2025-06-29 16:25:51.94634
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.957498	2025-06-29 16:25:51.957498
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.976012	2025-06-29 16:25:51.976012
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.989332	2025-06-29 16:25:51.989332
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.00561	2025-06-29 16:25:52.00561
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.01983	2025-06-29 16:25:52.01983
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.095724	2025-06-29 16:25:52.095724
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.107875	2025-06-29 16:25:52.107875
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.11991	2025-06-29 16:25:52.11991
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.139786	2025-06-29 16:25:52.139786
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.151925	2025-06-29 16:25:52.151925
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.164702	2025-06-29 16:25:52.164702
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.177325	2025-06-29 16:25:52.177325
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.190968	2025-06-29 16:25:52.190968
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.205121	2025-06-29 16:25:52.205121
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.218244	2025-06-29 16:25:52.218244
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.233512	2025-06-29 16:25:52.233512
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.250839	2025-06-29 16:25:52.250839
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.270343	2025-06-29 16:25:52.270343
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.284921	2025-06-29 16:25:52.284921
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.302868	2025-06-29 16:25:52.302868
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.32447	2025-06-29 16:25:52.32447
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.360086	2025-06-29 16:25:52.360086
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.403149	2025-06-29 16:25:52.403149
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.41773	2025-06-29 16:25:52.41773
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.431523	2025-06-29 16:25:52.431523
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.44176	2025-06-29 16:25:52.44176
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.466202	2025-06-29 16:25:52.466202
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.485763	2025-06-29 16:25:52.485763
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.497267	2025-06-29 16:25:52.497267
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.511634	2025-06-29 16:25:52.511634
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.527431	2025-06-29 16:25:52.527431
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.551678	2025-06-29 16:25:52.551678
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.56473	2025-06-29 16:25:52.56473
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.575865	2025-06-29 16:25:52.575865
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.58904	2025-06-29 16:25:52.58904
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.600242	2025-06-29 16:25:52.600242
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.615692	2025-06-29 16:25:52.615692
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.631562	2025-06-29 16:25:52.631562
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.642917	2025-06-29 16:25:52.642917
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.657152	2025-06-29 16:25:52.657152
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.674096	2025-06-29 16:25:52.674096
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.693744	2025-06-29 16:25:52.693744
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.702971	2025-06-29 16:25:52.702971
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.72193	2025-06-29 16:25:52.72193
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.735479	2025-06-29 16:25:52.735479
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.745503	2025-06-29 16:25:52.745503
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.765286	2025-06-29 16:25:52.765286
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.792954	2025-06-29 16:25:52.792954
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.805012	2025-06-29 16:25:52.805012
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.821558	2025-06-29 16:25:52.821558
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.841112	2025-06-29 16:25:52.841112
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.855442	2025-06-29 16:25:52.855442
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.900914	2025-06-29 16:25:52.900914
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.936026	2025-06-29 16:25:52.936026
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.952016	2025-06-29 16:25:52.952016
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.961802	2025-06-29 16:25:52.961802
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.98022	2025-06-29 16:25:52.98022
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.007306	2025-06-29 16:25:53.007306
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.029347	2025-06-29 16:25:53.029347
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.053115	2025-06-29 16:25:53.053115
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.069382	2025-06-29 16:25:53.069382
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.090031	2025-06-29 16:25:53.090031
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.119197	2025-06-29 16:25:53.119197
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.142011	2025-06-29 16:25:53.142011
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.159018	2025-06-29 16:25:53.159018
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.171918	2025-06-29 16:25:53.171918
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.186797	2025-06-29 16:25:53.186797
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.216673	2025-06-29 16:25:53.216673
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.233132	2025-06-29 16:25:53.233132
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.245289	2025-06-29 16:25:53.245289
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.259151	2025-06-29 16:25:53.259151
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.280619	2025-06-29 16:25:53.280619
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.30037	2025-06-29 16:25:53.30037
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.317723	2025-06-29 16:25:53.317723
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.332795	2025-06-29 16:25:53.332795
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.34363	2025-06-29 16:25:53.34363
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.36132	2025-06-29 16:25:53.36132
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.379139	2025-06-29 16:25:53.379139
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.401301	2025-06-29 16:25:53.401301
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.4219	2025-06-29 16:25:53.4219
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.442647	2025-06-29 16:25:53.442647
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.460191	2025-06-29 16:25:53.460191
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.479028	2025-06-29 16:25:53.479028
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.496423	2025-06-29 16:25:53.496423
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.520024	2025-06-29 16:25:53.520024
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.549441	2025-06-29 16:25:53.549441
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.570706	2025-06-29 16:25:53.570706
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.591838	2025-06-29 16:25:53.591838
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.623623	2025-06-29 16:25:53.623623
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.642648	2025-06-29 16:25:53.642648
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.663356	2025-06-29 16:25:53.663356
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.678847	2025-06-29 16:25:53.678847
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.691355	2025-06-29 16:25:53.691355
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.706398	2025-06-29 16:25:53.706398
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.723823	2025-06-29 16:25:53.723823
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.744134	2025-06-29 16:25:53.744134
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.758789	2025-06-29 16:25:53.758789
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.790013	2025-06-29 16:25:53.790013
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.804347	2025-06-29 16:25:53.804347
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.816576	2025-06-29 16:25:53.816576
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.827589	2025-06-29 16:25:53.827589
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.843348	2025-06-29 16:25:53.843348
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.866005	2025-06-29 16:25:53.866005
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.881451	2025-06-29 16:25:53.881451
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.898624	2025-06-29 16:25:53.898624
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.91182	2025-06-29 16:25:53.91182
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.925764	2025-06-29 16:25:53.925764
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.941117	2025-06-29 16:25:53.941117
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.957135	2025-06-29 16:25:53.957135
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.976237	2025-06-29 16:25:53.976237
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.99638	2025-06-29 16:25:53.99638
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.019997	2025-06-29 16:25:54.019997
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.033864	2025-06-29 16:25:54.033864
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.055861	2025-06-29 16:25:54.055861
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.094469	2025-06-29 16:25:54.094469
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.107835	2025-06-29 16:25:54.107835
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.119359	2025-06-29 16:25:54.119359
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.140352	2025-06-29 16:25:54.140352
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.154992	2025-06-29 16:25:54.154992
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.175075	2025-06-29 16:25:54.175075
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.197108	2025-06-29 16:25:54.197108
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.228645	2025-06-29 16:25:54.228645
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.252301	2025-06-29 16:25:54.252301
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.286071	2025-06-29 16:25:54.286071
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.301819	2025-06-29 16:25:54.301819
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.314261	2025-06-29 16:25:54.314261
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.327824	2025-06-29 16:25:54.327824
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.346165	2025-06-29 16:25:54.346165
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.367342	2025-06-29 16:25:54.367342
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.380027	2025-06-29 16:25:54.380027
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.392342	2025-06-29 16:25:54.392342
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.405596	2025-06-29 16:25:54.405596
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.426761	2025-06-29 16:25:54.426761
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.435945	2025-06-29 16:25:54.435945
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.454013	2025-06-29 16:25:54.454013
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.480942	2025-06-29 16:25:54.480942
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.502663	2025-06-29 16:25:54.502663
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.540763	2025-06-29 16:25:54.540763
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.561795	2025-06-29 16:25:54.561795
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.58273	2025-06-29 16:25:54.58273
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.594035	2025-06-29 16:25:54.594035
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.62303	2025-06-29 16:25:54.62303
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.644074	2025-06-29 16:25:54.644074
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.660499	2025-06-29 16:25:54.660499
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.684946	2025-06-29 16:25:54.684946
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.702167	2025-06-29 16:25:54.702167
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.714359	2025-06-29 16:25:54.714359
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.738904	2025-06-29 16:25:54.738904
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.751611	2025-06-29 16:25:54.751611
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.763346	2025-06-29 16:25:54.763346
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.778307	2025-06-29 16:25:54.778307
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.800363	2025-06-29 16:25:54.800363
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.818126	2025-06-29 16:25:54.818126
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.87064	2025-06-29 16:25:54.87064
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.882418	2025-06-29 16:25:54.882418
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.893209	2025-06-29 16:25:54.893209
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.903743	2025-06-29 16:25:54.903743
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.915803	2025-06-29 16:25:54.915803
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.946912	2025-06-29 16:25:54.946912
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.975822	2025-06-29 16:25:54.975822
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:54.994861	2025-06-29 16:25:54.994861
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.013083	2025-06-29 16:25:55.013083
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.025029	2025-06-29 16:25:55.025029
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.035696	2025-06-29 16:25:55.035696
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.047202	2025-06-29 16:25:55.047202
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.064892	2025-06-29 16:25:55.064892
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.074668	2025-06-29 16:25:55.074668
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.08896	2025-06-29 16:25:55.08896
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.104351	2025-06-29 16:25:55.104351
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.122157	2025-06-29 16:25:55.122157
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.174205	2025-06-29 16:25:55.174205
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.198471	2025-06-29 16:25:55.198471
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.219941	2025-06-29 16:25:55.219941
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.235414	2025-06-29 16:25:55.235414
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.244823	2025-06-29 16:25:55.244823
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.2541	2025-06-29 16:25:55.2541
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.26269	2025-06-29 16:25:55.26269
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.27593	2025-06-29 16:25:55.27593
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.287493	2025-06-29 16:25:55.287493
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.300667	2025-06-29 16:25:55.300667
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.311123	2025-06-29 16:25:55.311123
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.320599	2025-06-29 16:25:55.320599
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.334215	2025-06-29 16:25:55.334215
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.345297	2025-06-29 16:25:55.345297
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.356415	2025-06-29 16:25:55.356415
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.37026	2025-06-29 16:25:55.37026
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.379758	2025-06-29 16:25:55.379758
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.388916	2025-06-29 16:25:55.388916
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.395895	2025-06-29 16:25:55.395895
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.409068	2025-06-29 16:25:55.409068
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.420772	2025-06-29 16:25:55.420772
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.439126	2025-06-29 16:25:55.439126
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.449216	2025-06-29 16:25:55.449216
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.454214	2025-06-29 16:25:55.454214
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.461385	2025-06-29 16:25:55.461385
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.467931	2025-06-29 16:25:55.467931
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.477548	2025-06-29 16:25:55.477548
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.489015	2025-06-29 16:25:55.489015
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.492024	2025-06-29 16:25:55.492024
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.504945	2025-06-29 16:25:55.504945
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.51648	2025-06-29 16:25:55.51648
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.525867	2025-06-29 16:25:55.525867
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.536599	2025-06-29 16:25:55.536599
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.547525	2025-06-29 16:25:55.547525
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.557979	2025-06-29 16:25:55.557979
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.563858	2025-06-29 16:25:55.563858
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.57344	2025-06-29 16:25:55.57344
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.578807	2025-06-29 16:25:55.578807
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.584359	2025-06-29 16:25:55.584359
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.591511	2025-06-29 16:25:55.591511
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.608008	2025-06-29 16:25:55.608008
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.613858	2025-06-29 16:25:55.613858
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.623262	2025-06-29 16:25:55.623262
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.635368	2025-06-29 16:25:55.635368
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.664691	2025-06-29 16:25:55.664691
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.676153	2025-06-29 16:25:55.676153
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.691494	2025-06-29 16:25:55.691494
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.719615	2025-06-29 16:25:55.719615
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.723123	2025-06-29 16:25:55.723123
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.747248	2025-06-29 16:25:55.747248
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.756344	2025-06-29 16:25:55.756344
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.76544	2025-06-29 16:25:55.76544
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.774755	2025-06-29 16:25:55.774755
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.785015	2025-06-29 16:25:55.785015
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.795785	2025-06-29 16:25:55.795785
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.809089	2025-06-29 16:25:55.809089
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.820268	2025-06-29 16:25:55.820268
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.854568	2025-06-29 16:25:55.854568
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.864276	2025-06-29 16:25:55.864276
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.884493	2025-06-29 16:25:55.884493
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.924078	2025-06-29 16:25:55.924078
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.934461	2025-06-29 16:25:55.934461
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.954251	2025-06-29 16:25:55.954251
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.962073	2025-06-29 16:25:55.962073
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.979074	2025-06-29 16:25:55.979074
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:55.989059	2025-06-29 16:25:55.989059
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.018286	2025-06-29 16:25:56.018286
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.028452	2025-06-29 16:25:56.028452
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.060983	2025-06-29 16:25:56.060983
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.071803	2025-06-29 16:25:56.071803
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.097424	2025-06-29 16:25:56.097424
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.117863	2025-06-29 16:25:56.117863
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.135366	2025-06-29 16:25:56.135366
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.14678	2025-06-29 16:25:56.14678
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.156142	2025-06-29 16:25:56.156142
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.159199	2025-06-29 16:25:56.159199
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.167219	2025-06-29 16:25:56.167219
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.174285	2025-06-29 16:25:56.174285
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.185191	2025-06-29 16:25:56.185191
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.195595	2025-06-29 16:25:56.195595
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.205778	2025-06-29 16:25:56.205778
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.216632	2025-06-29 16:25:56.216632
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.226507	2025-06-29 16:25:56.226507
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.257629	2025-06-29 16:25:56.257629
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.290859	2025-06-29 16:25:56.290859
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.314971	2025-06-29 16:25:56.314971
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.322759	2025-06-29 16:25:56.322759
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.332789	2025-06-29 16:25:56.332789
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.342203	2025-06-29 16:25:56.342203
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.356262	2025-06-29 16:25:56.356262
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.365966	2025-06-29 16:25:56.365966
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.383477	2025-06-29 16:25:56.383477
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.38682	2025-06-29 16:25:56.38682
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.393996	2025-06-29 16:25:56.393996
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.402539	2025-06-29 16:25:56.402539
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.418336	2025-06-29 16:25:56.418336
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.43058	2025-06-29 16:25:56.43058
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.437188	2025-06-29 16:25:56.437188
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.444058	2025-06-29 16:25:56.444058
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.451093	2025-06-29 16:25:56.451093
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.458126	2025-06-29 16:25:56.458126
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.469198	2025-06-29 16:25:56.469198
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.507384	2025-06-29 16:25:56.507384
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.518167	2025-06-29 16:25:56.518167
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.52584	2025-06-29 16:25:56.52584
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.539436	2025-06-29 16:25:56.539436
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.546595	2025-06-29 16:25:56.546595
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.555899	2025-06-29 16:25:56.555899
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.566422	2025-06-29 16:25:56.566422
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.583732	2025-06-29 16:25:56.583732
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.591136	2025-06-29 16:25:56.591136
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.621081	2025-06-29 16:25:56.621081
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.630701	2025-06-29 16:25:56.630701
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.647721	2025-06-29 16:25:56.647721
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.659832	2025-06-29 16:25:56.659832
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.69809	2025-06-29 16:25:56.69809
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.705941	2025-06-29 16:25:56.705941
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.732473	2025-06-29 16:25:56.732473
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.739184	2025-06-29 16:25:56.739184
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.747109	2025-06-29 16:25:56.747109
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.772212	2025-06-29 16:25:56.772212
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.776659	2025-06-29 16:25:56.776659
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.78183	2025-06-29 16:25:56.78183
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.788933	2025-06-29 16:25:56.788933
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.828729	2025-06-29 16:25:56.828729
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.836169	2025-06-29 16:25:56.836169
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.840987	2025-06-29 16:25:56.840987
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.846067	2025-06-29 16:25:56.846067
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.855653	2025-06-29 16:25:56.855653
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.860898	2025-06-29 16:25:56.860898
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.86789	2025-06-29 16:25:56.86789
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.873296	2025-06-29 16:25:56.873296
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.878603	2025-06-29 16:25:56.878603
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.883651	2025-06-29 16:25:56.883651
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.888666	2025-06-29 16:25:56.888666
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.906895	2025-06-29 16:25:56.906895
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.911571	2025-06-29 16:25:56.911571
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.918289	2025-06-29 16:25:56.918289
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.932881	2025-06-29 16:25:56.932881
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:56.994972	2025-06-29 16:25:56.994972
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.016852	2025-06-29 16:25:57.016852
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.051635	2025-06-29 16:25:57.051635
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.062336	2025-06-29 16:25:57.062336
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.066563	2025-06-29 16:25:57.066563
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.071477	2025-06-29 16:25:57.071477
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.076507	2025-06-29 16:25:57.076507
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.087294	2025-06-29 16:25:57.087294
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.112438	2025-06-29 16:25:57.112438
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.164989	2025-06-29 16:25:57.164989
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.170564	2025-06-29 16:25:57.170564
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.173959	2025-06-29 16:25:57.173959
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.178596	2025-06-29 16:25:57.178596
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.182015	2025-06-29 16:25:57.182015
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.184949	2025-06-29 16:25:57.184949
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.189632	2025-06-29 16:25:57.189632
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.193734	2025-06-29 16:25:57.193734
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.198159	2025-06-29 16:25:57.198159
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.202878	2025-06-29 16:25:57.202878
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.205948	2025-06-29 16:25:57.205948
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.212382	2025-06-29 16:25:57.212382
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.216763	2025-06-29 16:25:57.216763
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.21989	2025-06-29 16:25:57.21989
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.224242	2025-06-29 16:25:57.224242
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.227229	2025-06-29 16:25:57.227229
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.229829	2025-06-29 16:25:57.229829
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.234235	2025-06-29 16:25:57.234235
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.236866	2025-06-29 16:25:57.236866
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.239361	2025-06-29 16:25:57.239361
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.242006	2025-06-29 16:25:57.242006
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.246411	2025-06-29 16:25:57.246411
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.249514	2025-06-29 16:25:57.249514
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.252623	2025-06-29 16:25:57.252623
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.259584	2025-06-29 16:25:57.259584
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.262983	2025-06-29 16:25:57.262983
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.266028	2025-06-29 16:25:57.266028
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.269018	2025-06-29 16:25:57.269018
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.271696	2025-06-29 16:25:57.271696
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.277055	2025-06-29 16:25:57.277055
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.279861	2025-06-29 16:25:57.279861
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.285856	2025-06-29 16:25:57.285856
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.289142	2025-06-29 16:25:57.289142
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.295351	2025-06-29 16:25:57.295351
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.300086	2025-06-29 16:25:57.300086
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.304614	2025-06-29 16:25:57.304614
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.309392	2025-06-29 16:25:57.309392
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.314139	2025-06-29 16:25:57.314139
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.319356	2025-06-29 16:25:57.319356
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.322801	2025-06-29 16:25:57.322801
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.326215	2025-06-29 16:25:57.326215
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.329023	2025-06-29 16:25:57.329023
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.331827	2025-06-29 16:25:57.331827
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.334578	2025-06-29 16:25:57.334578
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.337787	2025-06-29 16:25:57.337787
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.34182	2025-06-29 16:25:57.34182
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.345604	2025-06-29 16:25:57.345604
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.349295	2025-06-29 16:25:57.349295
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.352416	2025-06-29 16:25:57.352416
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.3555	2025-06-29 16:25:57.3555
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.36081	2025-06-29 16:25:57.36081
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.363982	2025-06-29 16:25:57.363982
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.398317	2025-06-29 16:25:57.398317
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.439552	2025-06-29 16:25:57.439552
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.44267	2025-06-29 16:25:57.44267
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.451079	2025-06-29 16:25:57.451079
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.454454	2025-06-29 16:25:57.454454
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.459298	2025-06-29 16:25:57.459298
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.464384	2025-06-29 16:25:57.464384
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.469156	2025-06-29 16:25:57.469156
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.472967	2025-06-29 16:25:57.472967
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.47786	2025-06-29 16:25:57.47786
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.481184	2025-06-29 16:25:57.481184
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.485986	2025-06-29 16:25:57.485986
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.490757	2025-06-29 16:25:57.490757
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.493866	2025-06-29 16:25:57.493866
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.496569	2025-06-29 16:25:57.496569
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.504934	2025-06-29 16:25:57.504934
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.508467	2025-06-29 16:25:57.508467
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.51181	2025-06-29 16:25:57.51181
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.514911	2025-06-29 16:25:57.514911
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.517924	2025-06-29 16:25:57.517924
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.52341	2025-06-29 16:25:57.52341
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.528206	2025-06-29 16:25:57.528206
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.566716	2025-06-29 16:25:57.566716
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.715868	2025-06-29 16:25:57.715868
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.741555	2025-06-29 16:25:57.741555
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.766509	2025-06-29 16:25:57.766509
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.797944	2025-06-29 16:25:57.797944
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.812027	2025-06-29 16:25:57.812027
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:57.848926	2025-06-29 16:25:57.848926
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.009547	2025-06-29 16:25:58.009547
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.201994	2025-06-29 16:25:58.201994
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.241551	2025-06-29 16:25:58.241551
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.246962	2025-06-29 16:25:58.246962
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.285299	2025-06-29 16:25:58.285299
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.288596	2025-06-29 16:25:58.288596
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.292904	2025-06-29 16:25:58.292904
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.297308	2025-06-29 16:25:58.297308
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.300358	2025-06-29 16:25:58.300358
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.339639	2025-06-29 16:25:58.339639
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.345796	2025-06-29 16:25:58.345796
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.356326	2025-06-29 16:25:58.356326
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.360002	2025-06-29 16:25:58.360002
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.365843	2025-06-29 16:25:58.365843
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.369175	2025-06-29 16:25:58.369175
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.372254	2025-06-29 16:25:58.372254
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.382953	2025-06-29 16:25:58.382953
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.387977	2025-06-29 16:25:58.387977
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.393696	2025-06-29 16:25:58.393696
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.399374	2025-06-29 16:25:58.399374
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.435374	2025-06-29 16:25:58.435374
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.438523	2025-06-29 16:25:58.438523
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.441507	2025-06-29 16:25:58.441507
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.446072	2025-06-29 16:25:58.446072
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.451265	2025-06-29 16:25:58.451265
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.48777	2025-06-29 16:25:58.48777
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.491789	2025-06-29 16:25:58.491789
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.497117	2025-06-29 16:25:58.497117
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.502012	2025-06-29 16:25:58.502012
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.51061	2025-06-29 16:25:58.51061
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.515638	2025-06-29 16:25:58.515638
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.522886	2025-06-29 16:25:58.522886
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.561811	2025-06-29 16:25:58.561811
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.567298	2025-06-29 16:25:58.567298
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.572233	2025-06-29 16:25:58.572233
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.578347	2025-06-29 16:25:58.578347
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.58397	2025-06-29 16:25:58.58397
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.588886	2025-06-29 16:25:58.588886
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.596802	2025-06-29 16:25:58.596802
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.601753	2025-06-29 16:25:58.601753
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.606173	2025-06-29 16:25:58.606173
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.610646	2025-06-29 16:25:58.610646
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.617209	2025-06-29 16:25:58.617209
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.62238	2025-06-29 16:25:58.62238
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.629691	2025-06-29 16:25:58.629691
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.632401	2025-06-29 16:25:58.632401
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.636634	2025-06-29 16:25:58.636634
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.640339	2025-06-29 16:25:58.640339
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.652967	2025-06-29 16:25:58.652967
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.660674	2025-06-29 16:25:58.660674
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.698996	2025-06-29 16:25:58.698996
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.703984	2025-06-29 16:25:58.703984
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.707343	2025-06-29 16:25:58.707343
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.711119	2025-06-29 16:25:58.711119
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.75029	2025-06-29 16:25:58.75029
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.757024	2025-06-29 16:25:58.757024
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.763798	2025-06-29 16:25:58.763798
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.77069	2025-06-29 16:25:58.77069
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.811084	2025-06-29 16:25:58.811084
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.818816	2025-06-29 16:25:58.818816
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.826084	2025-06-29 16:25:58.826084
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.866634	2025-06-29 16:25:58.866634
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.896354	2025-06-29 16:25:58.896354
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.90675	2025-06-29 16:25:58.90675
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.913427	2025-06-29 16:25:58.913427
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.947118	2025-06-29 16:25:58.947118
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.955455	2025-06-29 16:25:58.955455
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.961826	2025-06-29 16:25:58.961826
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.970227	2025-06-29 16:25:58.970227
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:58.976184	2025-06-29 16:25:58.976184
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.015381	2025-06-29 16:25:59.015381
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.022531	2025-06-29 16:25:59.022531
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.029295	2025-06-29 16:25:59.029295
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.035495	2025-06-29 16:25:59.035495
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.041925	2025-06-29 16:25:59.041925
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.04855	2025-06-29 16:25:59.04855
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.054915	2025-06-29 16:25:59.054915
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.061972	2025-06-29 16:25:59.061972
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.068422	2025-06-29 16:25:59.068422
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.074863	2025-06-29 16:25:59.074863
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.081507	2025-06-29 16:25:59.081507
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.088276	2025-06-29 16:25:59.088276
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.095352	2025-06-29 16:25:59.095352
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.101319	2025-06-29 16:25:59.101319
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.107074	2025-06-29 16:25:59.107074
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.113181	2025-06-29 16:25:59.113181
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.118972	2025-06-29 16:25:59.118972
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.127116	2025-06-29 16:25:59.127116
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.13378	2025-06-29 16:25:59.13378
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.140006	2025-06-29 16:25:59.140006
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.148773	2025-06-29 16:25:59.148773
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.154819	2025-06-29 16:25:59.154819
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.160546	2025-06-29 16:25:59.160546
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.166926	2025-06-29 16:25:59.166926
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.177328	2025-06-29 16:25:59.177328
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.183459	2025-06-29 16:25:59.183459
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.189949	2025-06-29 16:25:59.189949
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.195989	2025-06-29 16:25:59.195989
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.202062	2025-06-29 16:25:59.202062
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.208465	2025-06-29 16:25:59.208465
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.214813	2025-06-29 16:25:59.214813
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.221603	2025-06-29 16:25:59.221603
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.228144	2025-06-29 16:25:59.228144
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.234374	2025-06-29 16:25:59.234374
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.24077	2025-06-29 16:25:59.24077
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.248247	2025-06-29 16:25:59.248247
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.25502	2025-06-29 16:25:59.25502
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.261367	2025-06-29 16:25:59.261367
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.268307	2025-06-29 16:25:59.268307
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.277103	2025-06-29 16:25:59.277103
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.283954	2025-06-29 16:25:59.283954
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.310126	2025-06-29 16:25:59.310126
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.316356	2025-06-29 16:25:59.316356
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.322657	2025-06-29 16:25:59.322657
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.332813	2025-06-29 16:25:59.332813
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.343653	2025-06-29 16:25:59.343653
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.349931	2025-06-29 16:25:59.349931
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.356526	2025-06-29 16:25:59.356526
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.362194	2025-06-29 16:25:59.362194
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.367771	2025-06-29 16:25:59.367771
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.373609	2025-06-29 16:25:59.373609
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.38192	2025-06-29 16:25:59.38192
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.389445	2025-06-29 16:25:59.389445
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.40165	2025-06-29 16:25:59.40165
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.427037	2025-06-29 16:25:59.427037
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.43528	2025-06-29 16:25:59.43528
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.440928	2025-06-29 16:25:59.440928
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.446357	2025-06-29 16:25:59.446357
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.451917	2025-06-29 16:25:59.451917
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.457243	2025-06-29 16:25:59.457243
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.462847	2025-06-29 16:25:59.462847
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.46802	2025-06-29 16:25:59.46802
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.473455	2025-06-29 16:25:59.473455
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.478762	2025-06-29 16:25:59.478762
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.483719	2025-06-29 16:25:59.483719
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.494228	2025-06-29 16:25:59.494228
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.512003	2025-06-29 16:25:59.512003
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.519518	2025-06-29 16:25:59.519518
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.530177	2025-06-29 16:25:59.530177
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.537855	2025-06-29 16:25:59.537855
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.543619	2025-06-29 16:25:59.543619
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.555794	2025-06-29 16:25:59.555794
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.573847	2025-06-29 16:25:59.573847
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.587123	2025-06-29 16:25:59.587123
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.593649	2025-06-29 16:25:59.593649
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.605787	2025-06-29 16:25:59.605787
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.611475	2025-06-29 16:25:59.611475
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.624274	2025-06-29 16:25:59.624274
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.634862	2025-06-29 16:25:59.634862
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.652241	2025-06-29 16:25:59.652241
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.658785	2025-06-29 16:25:59.658785
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.667797	2025-06-29 16:25:59.667797
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.679979	2025-06-29 16:25:59.679979
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.688984	2025-06-29 16:25:59.688984
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.69852	2025-06-29 16:25:59.69852
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.708827	2025-06-29 16:25:59.708827
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.738776	2025-06-29 16:25:59.738776
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.748834	2025-06-29 16:25:59.748834
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.79103	2025-06-29 16:25:59.79103
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.803294	2025-06-29 16:25:59.803294
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.809546	2025-06-29 16:25:59.809546
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.819159	2025-06-29 16:25:59.819159
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.857505	2025-06-29 16:25:59.857505
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.902977	2025-06-29 16:25:59.902977
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.910851	2025-06-29 16:25:59.910851
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.915813	2025-06-29 16:25:59.915813
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.923815	2025-06-29 16:25:59.923815
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.932005	2025-06-29 16:25:59.932005
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.942255	2025-06-29 16:25:59.942255
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.951782	2025-06-29 16:25:59.951782
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.95552	2025-06-29 16:25:59.95552
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.961372	2025-06-29 16:25:59.961372
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.9678	2025-06-29 16:25:59.9678
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.971366	2025-06-29 16:25:59.971366
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.976737	2025-06-29 16:25:59.976737
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.981609	2025-06-29 16:25:59.981609
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.988918	2025-06-29 16:25:59.988918
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:59.994377	2025-06-29 16:25:59.994377
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.001695	2025-06-29 16:26:00.001695
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.008097	2025-06-29 16:26:00.008097
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.012903	2025-06-29 16:26:00.012903
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.016863	2025-06-29 16:26:00.016863
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.022581	2025-06-29 16:26:00.022581
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.026834	2025-06-29 16:26:00.026834
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.030359	2025-06-29 16:26:00.030359
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.035527	2025-06-29 16:26:00.035527
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.038945	2025-06-29 16:26:00.038945
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.04384	2025-06-29 16:26:00.04384
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.047331	2025-06-29 16:26:00.047331
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.052346	2025-06-29 16:26:00.052346
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.056592	2025-06-29 16:26:00.056592
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.0614	2025-06-29 16:26:00.0614
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.066426	2025-06-29 16:26:00.066426
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.07109	2025-06-29 16:26:00.07109
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.077132	2025-06-29 16:26:00.077132
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.083212	2025-06-29 16:26:00.083212
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.089835	2025-06-29 16:26:00.089835
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.094393	2025-06-29 16:26:00.094393
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.101621	2025-06-29 16:26:00.101621
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.105794	2025-06-29 16:26:00.105794
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.110895	2025-06-29 16:26:00.110895
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.11505	2025-06-29 16:26:00.11505
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.122976	2025-06-29 16:26:00.122976
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.129904	2025-06-29 16:26:00.129904
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.135534	2025-06-29 16:26:00.135534
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.14117	2025-06-29 16:26:00.14117
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.14545	2025-06-29 16:26:00.14545
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.150654	2025-06-29 16:26:00.150654
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.156155	2025-06-29 16:26:00.156155
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.159673	2025-06-29 16:26:00.159673
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.164731	2025-06-29 16:26:00.164731
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.170476	2025-06-29 16:26:00.170476
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.177686	2025-06-29 16:26:00.177686
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.181753	2025-06-29 16:26:00.181753
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.186801	2025-06-29 16:26:00.186801
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.19316	2025-06-29 16:26:00.19316
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.198043	2025-06-29 16:26:00.198043
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.202904	2025-06-29 16:26:00.202904
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.208952	2025-06-29 16:26:00.208952
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.21421	2025-06-29 16:26:00.21421
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.219124	2025-06-29 16:26:00.219124
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.222505	2025-06-29 16:26:00.222505
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.225798	2025-06-29 16:26:00.225798
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.231329	2025-06-29 16:26:00.231329
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.236518	2025-06-29 16:26:00.236518
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.241964	2025-06-29 16:26:00.241964
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.246868	2025-06-29 16:26:00.246868
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.251237	2025-06-29 16:26:00.251237
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.255185	2025-06-29 16:26:00.255185
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.258736	2025-06-29 16:26:00.258736
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.262647	2025-06-29 16:26:00.262647
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.267786	2025-06-29 16:26:00.267786
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.274265	2025-06-29 16:26:00.274265
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.280111	2025-06-29 16:26:00.280111
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.284274	2025-06-29 16:26:00.284274
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.288203	2025-06-29 16:26:00.288203
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.291478	2025-06-29 16:26:00.291478
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.298293	2025-06-29 16:26:00.298293
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.30241	2025-06-29 16:26:00.30241
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.3061	2025-06-29 16:26:00.3061
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.309851	2025-06-29 16:26:00.309851
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.314844	2025-06-29 16:26:00.314844
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.318717	2025-06-29 16:26:00.318717
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.32236	2025-06-29 16:26:00.32236
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.326243	2025-06-29 16:26:00.326243
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.331447	2025-06-29 16:26:00.331447
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.335045	2025-06-29 16:26:00.335045
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.339054	2025-06-29 16:26:00.339054
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.344258	2025-06-29 16:26:00.344258
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.348564	2025-06-29 16:26:00.348564
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.35234	2025-06-29 16:26:00.35234
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.357607	2025-06-29 16:26:00.357607
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.364305	2025-06-29 16:26:00.364305
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.371179	2025-06-29 16:26:00.371179
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.37495	2025-06-29 16:26:00.37495
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.378572	2025-06-29 16:26:00.378572
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.382205	2025-06-29 16:26:00.382205
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.38844	2025-06-29 16:26:00.38844
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.393799	2025-06-29 16:26:00.393799
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.397527	2025-06-29 16:26:00.397527
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.403483	2025-06-29 16:26:00.403483
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.407413	2025-06-29 16:26:00.407413
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.41093	2025-06-29 16:26:00.41093
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.414585	2025-06-29 16:26:00.414585
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.418931	2025-06-29 16:26:00.418931
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.422717	2025-06-29 16:26:00.422717
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.426864	2025-06-29 16:26:00.426864
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.431597	2025-06-29 16:26:00.431597
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.435595	2025-06-29 16:26:00.435595
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.439735	2025-06-29 16:26:00.439735
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.443949	2025-06-29 16:26:00.443949
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.448153	2025-06-29 16:26:00.448153
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.452368	2025-06-29 16:26:00.452368
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.465264	2025-06-29 16:26:00.465264
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.468896	2025-06-29 16:26:00.468896
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.472612	2025-06-29 16:26:00.472612
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.477289	2025-06-29 16:26:00.477289
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.480812	2025-06-29 16:26:00.480812
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.486225	2025-06-29 16:26:00.486225
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.490385	2025-06-29 16:26:00.490385
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.496121	2025-06-29 16:26:00.496121
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.499856	2025-06-29 16:26:00.499856
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.505184	2025-06-29 16:26:00.505184
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.51058	2025-06-29 16:26:00.51058
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.514415	2025-06-29 16:26:00.514415
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.519783	2025-06-29 16:26:00.519783
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.523531	2025-06-29 16:26:00.523531
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.52877	2025-06-29 16:26:00.52877
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.532772	2025-06-29 16:26:00.532772
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.538447	2025-06-29 16:26:00.538447
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.575522	2025-06-29 16:26:00.575522
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.581118	2025-06-29 16:26:00.581118
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.585387	2025-06-29 16:26:00.585387
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.589118	2025-06-29 16:26:00.589118
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:26:00.592619	2025-06-29 16:26:00.592619
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.595998	2025-06-29 16:26:00.595998
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.601252	2025-06-29 16:26:00.601252
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.607302	2025-06-29 16:26:00.607302
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.611083	2025-06-29 16:26:00.611083
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.615457	2025-06-29 16:26:00.615457
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.650589	2025-06-29 16:26:00.650589
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.661208	2025-06-29 16:26:00.661208
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.670997	2025-06-29 16:26:00.670997
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.68257	2025-06-29 16:26:00.68257
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.694751	2025-06-29 16:26:00.694751
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.732639	2025-06-29 16:26:00.732639
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.745352	2025-06-29 16:26:00.745352
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.75675	2025-06-29 16:26:00.75675
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.769477	2025-06-29 16:26:00.769477
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.779864	2025-06-29 16:26:00.779864
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.792209	2025-06-29 16:26:00.792209
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.802961	2025-06-29 16:26:00.802961
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.813783	2025-06-29 16:26:00.813783
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.825696	2025-06-29 16:26:00.825696
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.836518	2025-06-29 16:26:00.836518
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.849127	2025-06-29 16:26:00.849127
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.861472	2025-06-29 16:26:00.861472
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.873653	2025-06-29 16:26:00.873653
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.885394	2025-06-29 16:26:00.885394
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.89763	2025-06-29 16:26:00.89763
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.908638	2025-06-29 16:26:00.908638
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.946082	2025-06-29 16:26:00.946082
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.95895	2025-06-29 16:26:00.95895
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:00.970577	2025-06-29 16:26:00.970577
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.002513	2025-06-29 16:26:01.002513
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.01819	2025-06-29 16:26:01.01819
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.03842	2025-06-29 16:26:01.03842
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.054277	2025-06-29 16:26:01.054277
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.06348	2025-06-29 16:26:01.06348
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.074704	2025-06-29 16:26:01.074704
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.1107	2025-06-29 16:26:01.1107
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.124151	2025-06-29 16:26:01.124151
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.141342	2025-06-29 16:26:01.141342
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.157169	2025-06-29 16:26:01.157169
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.167997	2025-06-29 16:26:01.167997
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.202257	2025-06-29 16:26:01.202257
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.21634	2025-06-29 16:26:01.21634
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.26792	2025-06-29 16:26:01.26792
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.278763	2025-06-29 16:26:01.278763
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.293187	2025-06-29 16:26:01.293187
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.304528	2025-06-29 16:26:01.304528
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.315129	2025-06-29 16:26:01.315129
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.324065	2025-06-29 16:26:01.324065
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.333258	2025-06-29 16:26:01.333258
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.345229	2025-06-29 16:26:01.345229
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.365636	2025-06-29 16:26:01.365636
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.381583	2025-06-29 16:26:01.381583
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.392824	2025-06-29 16:26:01.392824
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.403292	2025-06-29 16:26:01.403292
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.415395	2025-06-29 16:26:01.415395
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.427908	2025-06-29 16:26:01.427908
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.440076	2025-06-29 16:26:01.440076
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.450603	2025-06-29 16:26:01.450603
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.459806	2025-06-29 16:26:01.459806
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.469986	2025-06-29 16:26:01.469986
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.480638	2025-06-29 16:26:01.480638
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.490873	2025-06-29 16:26:01.490873
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.507434	2025-06-29 16:26:01.507434
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.518604	2025-06-29 16:26:01.518604
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.530011	2025-06-29 16:26:01.530011
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.540293	2025-06-29 16:26:01.540293
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.550281	2025-06-29 16:26:01.550281
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.563697	2025-06-29 16:26:01.563697
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.576079	2025-06-29 16:26:01.576079
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.586847	2025-06-29 16:26:01.586847
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.597708	2025-06-29 16:26:01.597708
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.612006	2025-06-29 16:26:01.612006
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.623725	2025-06-29 16:26:01.623725
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.635538	2025-06-29 16:26:01.635538
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.645434	2025-06-29 16:26:01.645434
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.656052	2025-06-29 16:26:01.656052
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.670833	2025-06-29 16:26:01.670833
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.683348	2025-06-29 16:26:01.683348
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.696127	2025-06-29 16:26:01.696127
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.707709	2025-06-29 16:26:01.707709
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.717289	2025-06-29 16:26:01.717289
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.725747	2025-06-29 16:26:01.725747
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.734701	2025-06-29 16:26:01.734701
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.74387	2025-06-29 16:26:01.74387
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.753495	2025-06-29 16:26:01.753495
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.76281	2025-06-29 16:26:01.76281
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.772372	2025-06-29 16:26:01.772372
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.782196	2025-06-29 16:26:01.782196
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.793991	2025-06-29 16:26:01.793991
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.803062	2025-06-29 16:26:01.803062
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.813377	2025-06-29 16:26:01.813377
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.822495	2025-06-29 16:26:01.822495
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.832771	2025-06-29 16:26:01.832771
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.845338	2025-06-29 16:26:01.845338
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.856487	2025-06-29 16:26:01.856487
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.870937	2025-06-29 16:26:01.870937
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.883159	2025-06-29 16:26:01.883159
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.894312	2025-06-29 16:26:01.894312
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.904308	2025-06-29 16:26:01.904308
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.915892	2025-06-29 16:26:01.915892
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.92649	2025-06-29 16:26:01.92649
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.942626	2025-06-29 16:26:01.942626
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.952445	2025-06-29 16:26:01.952445
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.963195	2025-06-29 16:26:01.963195
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.972755	2025-06-29 16:26:01.972755
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.985397	2025-06-29 16:26:01.985397
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:01.995859	2025-06-29 16:26:01.995859
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.009042	2025-06-29 16:26:02.009042
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.023017	2025-06-29 16:26:02.023017
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.042922	2025-06-29 16:26:02.042922
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.060276	2025-06-29 16:26:02.060276
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.071268	2025-06-29 16:26:02.071268
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.083249	2025-06-29 16:26:02.083249
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.094708	2025-06-29 16:26:02.094708
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.1091	2025-06-29 16:26:02.1091
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.121337	2025-06-29 16:26:02.121337
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.139738	2025-06-29 16:26:02.139738
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.152622	2025-06-29 16:26:02.152622
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.162274	2025-06-29 16:26:02.162274
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.175318	2025-06-29 16:26:02.175318
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.186127	2025-06-29 16:26:02.186127
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.196893	2025-06-29 16:26:02.196893
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.210188	2025-06-29 16:26:02.210188
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.219839	2025-06-29 16:26:02.219839
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.241921	2025-06-29 16:26:02.241921
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.25597	2025-06-29 16:26:02.25597
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.268172	2025-06-29 16:26:02.268172
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.287091	2025-06-29 16:26:02.287091
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.303143	2025-06-29 16:26:02.303143
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.314812	2025-06-29 16:26:02.314812
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.329416	2025-06-29 16:26:02.329416
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.342994	2025-06-29 16:26:02.342994
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.354623	2025-06-29 16:26:02.354623
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.369664	2025-06-29 16:26:02.369664
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.382013	2025-06-29 16:26:02.382013
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.396884	2025-06-29 16:26:02.396884
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.414083	2025-06-29 16:26:02.414083
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.425694	2025-06-29 16:26:02.425694
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.436978	2025-06-29 16:26:02.436978
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.449264	2025-06-29 16:26:02.449264
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.462766	2025-06-29 16:26:02.462766
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.481041	2025-06-29 16:26:02.481041
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.493657	2025-06-29 16:26:02.493657
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.504448	2025-06-29 16:26:02.504448
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.520103	2025-06-29 16:26:02.520103
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.533432	2025-06-29 16:26:02.533432
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.543272	2025-06-29 16:26:02.543272
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.556277	2025-06-29 16:26:02.556277
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.566392	2025-06-29 16:26:02.566392
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.583619	2025-06-29 16:26:02.583619
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.5945	2025-06-29 16:26:02.5945
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.612973	2025-06-29 16:26:02.612973
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.637318	2025-06-29 16:26:02.637318
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.650988	2025-06-29 16:26:02.650988
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.663322	2025-06-29 16:26:02.663322
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.676411	2025-06-29 16:26:02.676411
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.706697	2025-06-29 16:26:02.706697
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.718014	2025-06-29 16:26:02.718014
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.730716	2025-06-29 16:26:02.730716
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.747408	2025-06-29 16:26:02.747408
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.760513	2025-06-29 16:26:02.760513
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.774121	2025-06-29 16:26:02.774121
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.786067	2025-06-29 16:26:02.786067
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.796213	2025-06-29 16:26:02.796213
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.806875	2025-06-29 16:26:02.806875
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.8173	2025-06-29 16:26:02.8173
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.828014	2025-06-29 16:26:02.828014
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.838199	2025-06-29 16:26:02.838199
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.851015	2025-06-29 16:26:02.851015
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.864507	2025-06-29 16:26:02.864507
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.874871	2025-06-29 16:26:02.874871
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.8883	2025-06-29 16:26:02.8883
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.905826	2025-06-29 16:26:02.905826
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.925699	2025-06-29 16:26:02.925699
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:02.953531	2025-06-29 16:26:02.953531
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.000758	2025-06-29 16:26:03.000758
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.018632	2025-06-29 16:26:03.018632
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.05076	2025-06-29 16:26:03.05076
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.087478	2025-06-29 16:26:03.087478
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.105797	2025-06-29 16:26:03.105797
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.127346	2025-06-29 16:26:03.127346
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.143175	2025-06-29 16:26:03.143175
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.155877	2025-06-29 16:26:03.155877
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.170138	2025-06-29 16:26:03.170138
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.205489	2025-06-29 16:26:03.205489
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.24161	2025-06-29 16:26:03.24161
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.261848	2025-06-29 16:26:03.261848
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.274023	2025-06-29 16:26:03.274023
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.291022	2025-06-29 16:26:03.291022
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.302229	2025-06-29 16:26:03.302229
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.319698	2025-06-29 16:26:03.319698
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.332462	2025-06-29 16:26:03.332462
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.343899	2025-06-29 16:26:03.343899
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.354172	2025-06-29 16:26:03.354172
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.390319	2025-06-29 16:26:03.390319
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.402047	2025-06-29 16:26:03.402047
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.429764	2025-06-29 16:26:03.429764
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.453461	2025-06-29 16:26:03.453461
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.467426	2025-06-29 16:26:03.467426
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.478065	2025-06-29 16:26:03.478065
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.489683	2025-06-29 16:26:03.489683
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.500353	2025-06-29 16:26:03.500353
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.510429	2025-06-29 16:26:03.510429
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.522375	2025-06-29 16:26:03.522375
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.532755	2025-06-29 16:26:03.532755
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.542681	2025-06-29 16:26:03.542681
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.551679	2025-06-29 16:26:03.551679
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.563844	2025-06-29 16:26:03.563844
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.573177	2025-06-29 16:26:03.573177
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.5833	2025-06-29 16:26:03.5833
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.594615	2025-06-29 16:26:03.594615
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.603914	2025-06-29 16:26:03.603914
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.614581	2025-06-29 16:26:03.614581
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.625963	2025-06-29 16:26:03.625963
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.636195	2025-06-29 16:26:03.636195
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.646202	2025-06-29 16:26:03.646202
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.657621	2025-06-29 16:26:03.657621
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.672388	2025-06-29 16:26:03.672388
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.700529	2025-06-29 16:26:03.700529
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.711932	2025-06-29 16:26:03.711932
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.721442	2025-06-29 16:26:03.721442
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.731767	2025-06-29 16:26:03.731767
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.742776	2025-06-29 16:26:03.742776
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.75225	2025-06-29 16:26:03.75225
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.76338	2025-06-29 16:26:03.76338
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.772926	2025-06-29 16:26:03.772926
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.788937	2025-06-29 16:26:03.788937
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.800666	2025-06-29 16:26:03.800666
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.812766	2025-06-29 16:26:03.812766
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.82409	2025-06-29 16:26:03.82409
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.84002	2025-06-29 16:26:03.84002
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.852495	2025-06-29 16:26:03.852495
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.864128	2025-06-29 16:26:03.864128
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.873932	2025-06-29 16:26:03.873932
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.88425	2025-06-29 16:26:03.88425
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.893751	2025-06-29 16:26:03.893751
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.905398	2025-06-29 16:26:03.905398
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.917453	2025-06-29 16:26:03.917453
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.930577	2025-06-29 16:26:03.930577
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.941459	2025-06-29 16:26:03.941459
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.953148	2025-06-29 16:26:03.953148
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.968346	2025-06-29 16:26:03.968346
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.982344	2025-06-29 16:26:03.982344
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:03.997503	2025-06-29 16:26:03.997503
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.008802	2025-06-29 16:26:04.008802
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.019353	2025-06-29 16:26:04.019353
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.031127	2025-06-29 16:26:04.031127
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.041816	2025-06-29 16:26:04.041816
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.053741	2025-06-29 16:26:04.053741
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.063009	2025-06-29 16:26:04.063009
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.089707	2025-06-29 16:26:04.089707
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.113604	2025-06-29 16:26:04.113604
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.128691	2025-06-29 16:26:04.128691
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.140021	2025-06-29 16:26:04.140021
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.151595	2025-06-29 16:26:04.151595
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.162206	2025-06-29 16:26:04.162206
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.172591	2025-06-29 16:26:04.172591
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.183594	2025-06-29 16:26:04.183594
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.193946	2025-06-29 16:26:04.193946
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.205246	2025-06-29 16:26:04.205246
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.216061	2025-06-29 16:26:04.216061
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.226457	2025-06-29 16:26:04.226457
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.240246	2025-06-29 16:26:04.240246
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.256488	2025-06-29 16:26:04.256488
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.283178	2025-06-29 16:26:04.283178
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.30272	2025-06-29 16:26:04.30272
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.31642	2025-06-29 16:26:04.31642
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.328821	2025-06-29 16:26:04.328821
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.340469	2025-06-29 16:26:04.340469
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.353958	2025-06-29 16:26:04.353958
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.402081	2025-06-29 16:26:04.402081
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.429194	2025-06-29 16:26:04.429194
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.449298	2025-06-29 16:26:04.449298
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.46078	2025-06-29 16:26:04.46078
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.473576	2025-06-29 16:26:04.473576
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.529227	2025-06-29 16:26:04.529227
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.561566	2025-06-29 16:26:04.561566
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.580861	2025-06-29 16:26:04.580861
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.591896	2025-06-29 16:26:04.591896
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.602229	2025-06-29 16:26:04.602229
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.61308	2025-06-29 16:26:04.61308
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.65792	2025-06-29 16:26:04.65792
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.668195	2025-06-29 16:26:04.668195
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.68116	2025-06-29 16:26:04.68116
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.70047	2025-06-29 16:26:04.70047
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.717788	2025-06-29 16:26:04.717788
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.732733	2025-06-29 16:26:04.732733
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.744202	2025-06-29 16:26:04.744202
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.759579	2025-06-29 16:26:04.759579
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.777063	2025-06-29 16:26:04.777063
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.794306	2025-06-29 16:26:04.794306
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.842828	2025-06-29 16:26:04.842828
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.861206	2025-06-29 16:26:04.861206
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.878488	2025-06-29 16:26:04.878488
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.903454	2025-06-29 16:26:04.903454
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.946062	2025-06-29 16:26:04.946062
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:04.991907	2025-06-29 16:26:04.991907
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.008346	2025-06-29 16:26:05.008346
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.020647	2025-06-29 16:26:05.020647
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.038267	2025-06-29 16:26:05.038267
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.051886	2025-06-29 16:26:05.051886
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.066298	2025-06-29 16:26:05.066298
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.086134	2025-06-29 16:26:05.086134
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.10666	2025-06-29 16:26:05.10666
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.130806	2025-06-29 16:26:05.130806
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.145923	2025-06-29 16:26:05.145923
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.158733	2025-06-29 16:26:05.158733
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.1695	2025-06-29 16:26:05.1695
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.18195	2025-06-29 16:26:05.18195
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.193068	2025-06-29 16:26:05.193068
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.204027	2025-06-29 16:26:05.204027
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.220894	2025-06-29 16:26:05.220894
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.238491	2025-06-29 16:26:05.238491
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.250499	2025-06-29 16:26:05.250499
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.259959	2025-06-29 16:26:05.259959
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.270773	2025-06-29 16:26:05.270773
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.284634	2025-06-29 16:26:05.284634
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.301836	2025-06-29 16:26:05.301836
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.314181	2025-06-29 16:26:05.314181
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.325079	2025-06-29 16:26:05.325079
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.34283	2025-06-29 16:26:05.34283
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.354219	2025-06-29 16:26:05.354219
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.397432	2025-06-29 16:26:05.397432
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.409378	2025-06-29 16:26:05.409378
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.419878	2025-06-29 16:26:05.419878
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.43029	2025-06-29 16:26:05.43029
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.440773	2025-06-29 16:26:05.440773
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.48662	2025-06-29 16:26:05.48662
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.536472	2025-06-29 16:26:05.536472
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.5815	2025-06-29 16:26:05.5815
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.603112	2025-06-29 16:26:05.603112
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.617453	2025-06-29 16:26:05.617453
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.634927	2025-06-29 16:26:05.634927
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.654164	2025-06-29 16:26:05.654164
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.683364	2025-06-29 16:26:05.683364
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.696212	2025-06-29 16:26:05.696212
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.723063	2025-06-29 16:26:05.723063
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.735648	2025-06-29 16:26:05.735648
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.746469	2025-06-29 16:26:05.746469
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.771087	2025-06-29 16:26:05.771087
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.786312	2025-06-29 16:26:05.786312
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.797901	2025-06-29 16:26:05.797901
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.810027	2025-06-29 16:26:05.810027
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.82029	2025-06-29 16:26:05.82029
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.829783	2025-06-29 16:26:05.829783
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.842042	2025-06-29 16:26:05.842042
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.862348	2025-06-29 16:26:05.862348
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.899368	2025-06-29 16:26:05.899368
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.93241	2025-06-29 16:26:05.93241
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.977533	2025-06-29 16:26:05.977533
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:05.992122	2025-06-29 16:26:05.992122
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.010699	2025-06-29 16:26:06.010699
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.028541	2025-06-29 16:26:06.028541
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.079569	2025-06-29 16:26:06.079569
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.104788	2025-06-29 16:26:06.104788
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.120399	2025-06-29 16:26:06.120399
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.135519	2025-06-29 16:26:06.135519
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.160918	2025-06-29 16:26:06.160918
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.174381	2025-06-29 16:26:06.174381
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.198899	2025-06-29 16:26:06.198899
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.216021	2025-06-29 16:26:06.216021
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.230511	2025-06-29 16:26:06.230511
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.244326	2025-06-29 16:26:06.244326
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.265367	2025-06-29 16:26:06.265367
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.28394	2025-06-29 16:26:06.28394
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.295357	2025-06-29 16:26:06.295357
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.308014	2025-06-29 16:26:06.308014
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.325732	2025-06-29 16:26:06.325732
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.336951	2025-06-29 16:26:06.336951
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.363897	2025-06-29 16:26:06.363897
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.374677	2025-06-29 16:26:06.374677
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.400706	2025-06-29 16:26:06.400706
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.411208	2025-06-29 16:26:06.411208
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.426833	2025-06-29 16:26:06.426833
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.451283	2025-06-29 16:26:06.451283
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.462491	2025-06-29 16:26:06.462491
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.476851	2025-06-29 16:26:06.476851
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.496812	2025-06-29 16:26:06.496812
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.510086	2025-06-29 16:26:06.510086
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.524045	2025-06-29 16:26:06.524045
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.541486	2025-06-29 16:26:06.541486
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.551754	2025-06-29 16:26:06.551754
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.568589	2025-06-29 16:26:06.568589
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.60105	2025-06-29 16:26:06.60105
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.615533	2025-06-29 16:26:06.615533
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.630089	2025-06-29 16:26:06.630089
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.659992	2025-06-29 16:26:06.659992
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.677786	2025-06-29 16:26:06.677786
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.714751	2025-06-29 16:26:06.714751
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.729341	2025-06-29 16:26:06.729341
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.75151	2025-06-29 16:26:06.75151
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.773259	2025-06-29 16:26:06.773259
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.786485	2025-06-29 16:26:06.786485
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.805418	2025-06-29 16:26:06.805418
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.819561	2025-06-29 16:26:06.819561
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.834873	2025-06-29 16:26:06.834873
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.845712	2025-06-29 16:26:06.845712
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.855719	2025-06-29 16:26:06.855719
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.875487	2025-06-29 16:26:06.875487
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:26:06.890896	2025-06-29 16:26:06.890896
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:06.91726	2025-06-29 16:26:06.91726
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:06.947476	2025-06-29 16:26:06.947476
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:06.972539	2025-06-29 16:26:06.972539
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.072579	2025-06-29 16:26:07.072579
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.112393	2025-06-29 16:26:07.112393
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.133723	2025-06-29 16:26:07.133723
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.170715	2025-06-29 16:26:07.170715
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.204918	2025-06-29 16:26:07.204918
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.221341	2025-06-29 16:26:07.221341
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.231499	2025-06-29 16:26:07.231499
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.242543	2025-06-29 16:26:07.242543
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.253591	2025-06-29 16:26:07.253591
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.266449	2025-06-29 16:26:07.266449
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.277879	2025-06-29 16:26:07.277879
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.317912	2025-06-29 16:26:07.317912
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.34084	2025-06-29 16:26:07.34084
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.35225	2025-06-29 16:26:07.35225
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.365831	2025-06-29 16:26:07.365831
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.375565	2025-06-29 16:26:07.375565
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.386617	2025-06-29 16:26:07.386617
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.396463	2025-06-29 16:26:07.396463
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.407313	2025-06-29 16:26:07.407313
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.420129	2025-06-29 16:26:07.420129
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.43773	2025-06-29 16:26:07.43773
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.451365	2025-06-29 16:26:07.451365
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.460955	2025-06-29 16:26:07.460955
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.470716	2025-06-29 16:26:07.470716
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.48191	2025-06-29 16:26:07.48191
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.493589	2025-06-29 16:26:07.493589
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.503916	2025-06-29 16:26:07.503916
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.517064	2025-06-29 16:26:07.517064
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.530161	2025-06-29 16:26:07.530161
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.545885	2025-06-29 16:26:07.545885
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.557446	2025-06-29 16:26:07.557446
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.56821	2025-06-29 16:26:07.56821
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.582459	2025-06-29 16:26:07.582459
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.595801	2025-06-29 16:26:07.595801
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.619204	2025-06-29 16:26:07.619204
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.63597	2025-06-29 16:26:07.63597
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.673343	2025-06-29 16:26:07.673343
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.707343	2025-06-29 16:26:07.707343
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.723189	2025-06-29 16:26:07.723189
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.745982	2025-06-29 16:26:07.745982
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.786287	2025-06-29 16:26:07.786287
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.81017	2025-06-29 16:26:07.81017
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.848403	2025-06-29 16:26:07.848403
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.869673	2025-06-29 16:26:07.869673
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.883056	2025-06-29 16:26:07.883056
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.904835	2025-06-29 16:26:07.904835
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.922987	2025-06-29 16:26:07.922987
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.940394	2025-06-29 16:26:07.940394
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.950682	2025-06-29 16:26:07.950682
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.969419	2025-06-29 16:26:07.969419
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:07.985214	2025-06-29 16:26:07.985214
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.00471	2025-06-29 16:26:08.00471
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.02183	2025-06-29 16:26:08.02183
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.036854	2025-06-29 16:26:08.036854
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.089955	2025-06-29 16:26:08.089955
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.133764	2025-06-29 16:26:08.133764
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.172089	2025-06-29 16:26:08.172089
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.23985	2025-06-29 16:26:08.23985
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.279032	2025-06-29 16:26:08.279032
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.315561	2025-06-29 16:26:08.315561
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.346209	2025-06-29 16:26:08.346209
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.365499	2025-06-29 16:26:08.365499
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.390521	2025-06-29 16:26:08.390521
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.403093	2025-06-29 16:26:08.403093
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.41468	2025-06-29 16:26:08.41468
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.435425	2025-06-29 16:26:08.435425
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.452441	2025-06-29 16:26:08.452441
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.490083	2025-06-29 16:26:08.490083
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.512683	2025-06-29 16:26:08.512683
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.531553	2025-06-29 16:26:08.531553
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.553371	2025-06-29 16:26:08.553371
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.567767	2025-06-29 16:26:08.567767
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.607634	2025-06-29 16:26:08.607634
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.625175	2025-06-29 16:26:08.625175
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.653023	2025-06-29 16:26:08.653023
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.709234	2025-06-29 16:26:08.709234
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.745235	2025-06-29 16:26:08.745235
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.760824	2025-06-29 16:26:08.760824
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.800678	2025-06-29 16:26:08.800678
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.828095	2025-06-29 16:26:08.828095
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.855709	2025-06-29 16:26:08.855709
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:08.929402	2025-06-29 16:26:08.929402
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.039735	2025-06-29 16:26:09.039735
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.076124	2025-06-29 16:26:09.076124
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.133014	2025-06-29 16:26:09.133014
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.173018	2025-06-29 16:26:09.173018
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.1978	2025-06-29 16:26:09.1978
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.230938	2025-06-29 16:26:09.230938
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.264159	2025-06-29 16:26:09.264159
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.278031	2025-06-29 16:26:09.278031
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.309995	2025-06-29 16:26:09.309995
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.33844	2025-06-29 16:26:09.33844
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.374474	2025-06-29 16:26:09.374474
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.42613	2025-06-29 16:26:09.42613
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.454643	2025-06-29 16:26:09.454643
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.471049	2025-06-29 16:26:09.471049
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.494852	2025-06-29 16:26:09.494852
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.509586	2025-06-29 16:26:09.509586
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.530313	2025-06-29 16:26:09.530313
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.544824	2025-06-29 16:26:09.544824
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.561113	2025-06-29 16:26:09.561113
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.585608	2025-06-29 16:26:09.585608
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.605177	2025-06-29 16:26:09.605177
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.62198	2025-06-29 16:26:09.62198
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.643795	2025-06-29 16:26:09.643795
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.666743	2025-06-29 16:26:09.666743
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.685544	2025-06-29 16:26:09.685544
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.705476	2025-06-29 16:26:09.705476
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.720907	2025-06-29 16:26:09.720907
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.739217	2025-06-29 16:26:09.739217
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.768997	2025-06-29 16:26:09.768997
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.784481	2025-06-29 16:26:09.784481
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.79649	2025-06-29 16:26:09.79649
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.814787	2025-06-29 16:26:09.814787
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.827323	2025-06-29 16:26:09.827323
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.848139	2025-06-29 16:26:09.848139
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.8778	2025-06-29 16:26:09.8778
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.900524	2025-06-29 16:26:09.900524
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.921237	2025-06-29 16:26:09.921237
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.941947	2025-06-29 16:26:09.941947
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.955358	2025-06-29 16:26:09.955358
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:09.970183	2025-06-29 16:26:09.970183
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.001876	2025-06-29 16:26:10.001876
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.019208	2025-06-29 16:26:10.019208
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.049665	2025-06-29 16:26:10.049665
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.075028	2025-06-29 16:26:10.075028
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.089319	2025-06-29 16:26:10.089319
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.105012	2025-06-29 16:26:10.105012
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.127816	2025-06-29 16:26:10.127816
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.188937	2025-06-29 16:26:10.188937
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.206095	2025-06-29 16:26:10.206095
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.216326	2025-06-29 16:26:10.216326
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.228265	2025-06-29 16:26:10.228265
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.2426	2025-06-29 16:26:10.2426
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.254099	2025-06-29 16:26:10.254099
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.269001	2025-06-29 16:26:10.269001
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.291547	2025-06-29 16:26:10.291547
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.305297	2025-06-29 16:26:10.305297
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.321332	2025-06-29 16:26:10.321332
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.341723	2025-06-29 16:26:10.341723
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.356564	2025-06-29 16:26:10.356564
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.379115	2025-06-29 16:26:10.379115
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.395287	2025-06-29 16:26:10.395287
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.406005	2025-06-29 16:26:10.406005
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.421958	2025-06-29 16:26:10.421958
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.438553	2025-06-29 16:26:10.438553
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.459923	2025-06-29 16:26:10.459923
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.485723	2025-06-29 16:26:10.485723
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.512832	2025-06-29 16:26:10.512832
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.544133	2025-06-29 16:26:10.544133
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.562866	2025-06-29 16:26:10.562866
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.583099	2025-06-29 16:26:10.583099
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.603983	2025-06-29 16:26:10.603983
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.625398	2025-06-29 16:26:10.625398
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.645415	2025-06-29 16:26:10.645415
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.670862	2025-06-29 16:26:10.670862
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.699963	2025-06-29 16:26:10.699963
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.727872	2025-06-29 16:26:10.727872
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.753164	2025-06-29 16:26:10.753164
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.784994	2025-06-29 16:26:10.784994
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.821339	2025-06-29 16:26:10.821339
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.850586	2025-06-29 16:26:10.850586
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.865729	2025-06-29 16:26:10.865729
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.885447	2025-06-29 16:26:10.885447
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.943767	2025-06-29 16:26:10.943767
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.973073	2025-06-29 16:26:10.973073
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.992357	2025-06-29 16:26:10.992357
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.010152	2025-06-29 16:26:11.010152
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.037558	2025-06-29 16:26:11.037558
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.066943	2025-06-29 16:26:11.066943
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.112844	2025-06-29 16:26:11.112844
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.134517	2025-06-29 16:26:11.134517
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.150591	2025-06-29 16:26:11.150591
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.164468	2025-06-29 16:26:11.164468
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.17571	2025-06-29 16:26:11.17571
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.192441	2025-06-29 16:26:11.192441
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.207443	2025-06-29 16:26:11.207443
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.220248	2025-06-29 16:26:11.220248
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.228234	2025-06-29 16:26:11.228234
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.234499	2025-06-29 16:26:11.234499
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.241035	2025-06-29 16:26:11.241035
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.246515	2025-06-29 16:26:11.246515
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.251269	2025-06-29 16:26:11.251269
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.254568	2025-06-29 16:26:11.254568
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.258849	2025-06-29 16:26:11.258849
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.262333	2025-06-29 16:26:11.262333
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.267065	2025-06-29 16:26:11.267065
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.271759	2025-06-29 16:26:11.271759
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.277101	2025-06-29 16:26:11.277101
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.280453	2025-06-29 16:26:11.280453
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.285313	2025-06-29 16:26:11.285313
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.288663	2025-06-29 16:26:11.288663
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.294286	2025-06-29 16:26:11.294286
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.2996	2025-06-29 16:26:11.2996
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.304844	2025-06-29 16:26:11.304844
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.309313	2025-06-29 16:26:11.309313
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.315126	2025-06-29 16:26:11.315126
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.320232	2025-06-29 16:26:11.320232
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.325022	2025-06-29 16:26:11.325022
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.330414	2025-06-29 16:26:11.330414
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.335241	2025-06-29 16:26:11.335241
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.340353	2025-06-29 16:26:11.340353
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.345466	2025-06-29 16:26:11.345466
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.350317	2025-06-29 16:26:11.350317
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.355434	2025-06-29 16:26:11.355434
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.360366	2025-06-29 16:26:11.360366
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.365112	2025-06-29 16:26:11.365112
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.371266	2025-06-29 16:26:11.371266
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.376386	2025-06-29 16:26:11.376386
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.381204	2025-06-29 16:26:11.381204
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.384427	2025-06-29 16:26:11.384427
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.388152	2025-06-29 16:26:11.388152
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.391378	2025-06-29 16:26:11.391378
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.395981	2025-06-29 16:26:11.395981
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.400811	2025-06-29 16:26:11.400811
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.405665	2025-06-29 16:26:11.405665
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.408758	2025-06-29 16:26:11.408758
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.412143	2025-06-29 16:26:11.412143
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.415421	2025-06-29 16:26:11.415421
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.419106	2025-06-29 16:26:11.419106
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.424458	2025-06-29 16:26:11.424458
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.429738	2025-06-29 16:26:11.429738
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.43536	2025-06-29 16:26:11.43536
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.440143	2025-06-29 16:26:11.440143
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.445122	2025-06-29 16:26:11.445122
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.450089	2025-06-29 16:26:11.450089
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.45476	2025-06-29 16:26:11.45476
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.460753	2025-06-29 16:26:11.460753
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.46734	2025-06-29 16:26:11.46734
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.472644	2025-06-29 16:26:11.472644
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.477624	2025-06-29 16:26:11.477624
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.483038	2025-06-29 16:26:11.483038
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.487814	2025-06-29 16:26:11.487814
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.494032	2025-06-29 16:26:11.494032
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.499052	2025-06-29 16:26:11.499052
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.503825	2025-06-29 16:26:11.503825
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.51049	2025-06-29 16:26:11.51049
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.539528	2025-06-29 16:26:11.539528
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.549294	2025-06-29 16:26:11.549294
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.568664	2025-06-29 16:26:11.568664
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.081412	2025-06-29 16:26:11.081412
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.168373	2025-06-29 16:26:10.168373
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.188511	2025-06-29 16:26:10.188511
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.196403	2025-06-29 16:26:10.196403
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.204627	2025-06-29 16:26:10.204627
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.210994	2025-06-29 16:26:10.210994
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.218019	2025-06-29 16:26:10.218019
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.230947	2025-06-29 16:26:10.230947
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.237867	2025-06-29 16:26:10.237867
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.244377	2025-06-29 16:26:10.244377
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.25082	2025-06-29 16:26:10.25082
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.256389	2025-06-29 16:26:10.256389
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.261282	2025-06-29 16:26:10.261282
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.268313	2025-06-29 16:26:10.268313
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.285948	2025-06-29 16:26:10.285948
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.295778	2025-06-29 16:26:10.295778
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.307049	2025-06-29 16:26:10.307049
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.311833	2025-06-29 16:26:10.311833
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.321189	2025-06-29 16:26:10.321189
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.337259	2025-06-29 16:26:10.337259
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.358485	2025-06-29 16:26:10.358485
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.388322	2025-06-29 16:26:10.388322
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.393594	2025-06-29 16:26:10.393594
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.398767	2025-06-29 16:26:10.398767
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.405283	2025-06-29 16:26:10.405283
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.411435	2025-06-29 16:26:10.411435
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.414472	2025-06-29 16:26:10.414472
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.417477	2025-06-29 16:26:10.417477
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.422065	2025-06-29 16:26:10.422065
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.425385	2025-06-29 16:26:10.425385
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.429553	2025-06-29 16:26:10.429553
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.434069	2025-06-29 16:26:10.434069
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.440666	2025-06-29 16:26:10.440666
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.446083	2025-06-29 16:26:10.446083
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.450912	2025-06-29 16:26:10.450912
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.455763	2025-06-29 16:26:10.455763
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.461936	2025-06-29 16:26:10.461936
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.499664	2025-06-29 16:26:10.499664
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.504201	2025-06-29 16:26:10.504201
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.537176	2025-06-29 16:26:10.537176
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.542231	2025-06-29 16:26:10.542231
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.547425	2025-06-29 16:26:10.547425
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.565926	2025-06-29 16:26:10.565926
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.570919	2025-06-29 16:26:10.570919
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.575815	2025-06-29 16:26:10.575815
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.580469	2025-06-29 16:26:10.580469
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.585649	2025-06-29 16:26:10.585649
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.590102	2025-06-29 16:26:10.590102
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.594513	2025-06-29 16:26:10.594513
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.599536	2025-06-29 16:26:10.599536
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.60435	2025-06-29 16:26:10.60435
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.614078	2025-06-29 16:26:10.614078
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.619924	2025-06-29 16:26:10.619924
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.658204	2025-06-29 16:26:10.658204
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.663633	2025-06-29 16:26:10.663633
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.669515	2025-06-29 16:26:10.669515
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.67475	2025-06-29 16:26:10.67475
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.713503	2025-06-29 16:26:10.713503
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.719201	2025-06-29 16:26:10.719201
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.757189	2025-06-29 16:26:10.757189
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.778404	2025-06-29 16:26:10.778404
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.783827	2025-06-29 16:26:10.783827
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.790301	2025-06-29 16:26:10.790301
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.795848	2025-06-29 16:26:10.795848
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.808408	2025-06-29 16:26:10.808408
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.828466	2025-06-29 16:26:10.828466
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.84671	2025-06-29 16:26:10.84671
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.850489	2025-06-29 16:26:10.850489
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.87127	2025-06-29 16:26:10.87127
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.875674	2025-06-29 16:26:10.875674
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.881002	2025-06-29 16:26:10.881002
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.886979	2025-06-29 16:26:10.886979
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.891547	2025-06-29 16:26:10.891547
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.897318	2025-06-29 16:26:10.897318
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.901835	2025-06-29 16:26:10.901835
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.906839	2025-06-29 16:26:10.906839
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.911957	2025-06-29 16:26:10.911957
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.922791	2025-06-29 16:26:10.922791
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.928475	2025-06-29 16:26:10.928475
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.938592	2025-06-29 16:26:10.938592
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.964042	2025-06-29 16:26:10.964042
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.975838	2025-06-29 16:26:10.975838
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:10.98906	2025-06-29 16:26:10.98906
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.001862	2025-06-29 16:26:11.001862
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.028612	2025-06-29 16:26:11.028612
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.041327	2025-06-29 16:26:11.041327
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.052453	2025-06-29 16:26:11.052453
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.065095	2025-06-29 16:26:11.065095
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.079343	2025-06-29 16:26:11.079343
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.092761	2025-06-29 16:26:11.092761
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.133693	2025-06-29 16:26:11.133693
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.146212	2025-06-29 16:26:11.146212
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.158801	2025-06-29 16:26:11.158801
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.171135	2025-06-29 16:26:11.171135
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.183174	2025-06-29 16:26:11.183174
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.196642	2025-06-29 16:26:11.196642
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.213481	2025-06-29 16:26:11.213481
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.244149	2025-06-29 16:26:11.244149
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.262023	2025-06-29 16:26:11.262023
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.272804	2025-06-29 16:26:11.272804
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.283219	2025-06-29 16:26:11.283219
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.295998	2025-06-29 16:26:11.295998
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.309499	2025-06-29 16:26:11.309499
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.320434	2025-06-29 16:26:11.320434
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.332616	2025-06-29 16:26:11.332616
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.342562	2025-06-29 16:26:11.342562
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.354764	2025-06-29 16:26:11.354764
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.367985	2025-06-29 16:26:11.367985
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.380003	2025-06-29 16:26:11.380003
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.392426	2025-06-29 16:26:11.392426
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.409594	2025-06-29 16:26:11.409594
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.42649	2025-06-29 16:26:11.42649
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.43895	2025-06-29 16:26:11.43895
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.451936	2025-06-29 16:26:11.451936
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.465506	2025-06-29 16:26:11.465506
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.481329	2025-06-29 16:26:11.481329
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.499482	2025-06-29 16:26:11.499482
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.523746	2025-06-29 16:26:11.523746
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.5527	2025-06-29 16:26:11.5527
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.563715	2025-06-29 16:26:11.563715
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.580593	2025-06-29 16:26:11.580593
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.59767	2025-06-29 16:26:11.59767
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.612669	2025-06-29 16:26:11.612669
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.623186	2025-06-29 16:26:11.623186
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.635971	2025-06-29 16:26:11.635971
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.654809	2025-06-29 16:26:11.654809
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.669488	2025-06-29 16:26:11.669488
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.68082	2025-06-29 16:26:11.68082
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.698244	2025-06-29 16:26:11.698244
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.71763	2025-06-29 16:26:11.71763
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.730829	2025-06-29 16:26:11.730829
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.751182	2025-06-29 16:26:11.751182
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.772493	2025-06-29 16:26:11.772493
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.789531	2025-06-29 16:26:11.789531
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.805368	2025-06-29 16:26:11.805368
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.840926	2025-06-29 16:26:11.840926
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.857593	2025-06-29 16:26:11.857593
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.870473	2025-06-29 16:26:11.870473
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.893251	2025-06-29 16:26:11.893251
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.912591	2025-06-29 16:26:11.912591
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.937207	2025-06-29 16:26:11.937207
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:11.983331	2025-06-29 16:26:11.983331
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.006295	2025-06-29 16:26:12.006295
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.021381	2025-06-29 16:26:12.021381
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.054367	2025-06-29 16:26:12.054367
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.089055	2025-06-29 16:26:12.089055
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.10254	2025-06-29 16:26:12.10254
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.114272	2025-06-29 16:26:12.114272
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.159318	2025-06-29 16:26:12.159318
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.194505	2025-06-29 16:26:12.194505
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.216499	2025-06-29 16:26:12.216499
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.240467	2025-06-29 16:26:12.240467
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.257145	2025-06-29 16:26:12.257145
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.272719	2025-06-29 16:26:12.272719
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.305366	2025-06-29 16:26:12.305366
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.337284	2025-06-29 16:26:12.337284
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.358424	2025-06-29 16:26:12.358424
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.376667	2025-06-29 16:26:12.376667
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.392681	2025-06-29 16:26:12.392681
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.406633	2025-06-29 16:26:12.406633
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.418892	2025-06-29 16:26:12.418892
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.43732	2025-06-29 16:26:12.43732
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.450902	2025-06-29 16:26:12.450902
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.461458	2025-06-29 16:26:12.461458
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.47622	2025-06-29 16:26:12.47622
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.497559	2025-06-29 16:26:12.497559
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.518303	2025-06-29 16:26:12.518303
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.54859	2025-06-29 16:26:12.54859
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.558681	2025-06-29 16:26:12.558681
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.581275	2025-06-29 16:26:12.581275
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.601154	2025-06-29 16:26:12.601154
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.623837	2025-06-29 16:26:12.623837
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.639896	2025-06-29 16:26:12.639896
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.661883	2025-06-29 16:26:12.661883
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.698494	2025-06-29 16:26:12.698494
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.723043	2025-06-29 16:26:12.723043
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.760536	2025-06-29 16:26:12.760536
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.787416	2025-06-29 16:26:12.787416
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.808206	2025-06-29 16:26:12.808206
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.826158	2025-06-29 16:26:12.826158
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.838532	2025-06-29 16:26:12.838532
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.850778	2025-06-29 16:26:12.850778
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.860953	2025-06-29 16:26:12.860953
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.874072	2025-06-29 16:26:12.874072
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.888594	2025-06-29 16:26:12.888594
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.90208	2025-06-29 16:26:12.90208
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.916363	2025-06-29 16:26:12.916363
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.932073	2025-06-29 16:26:12.932073
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.94453	2025-06-29 16:26:12.94453
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.958349	2025-06-29 16:26:12.958349
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.96857	2025-06-29 16:26:12.96857
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.979424	2025-06-29 16:26:12.979424
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:12.989798	2025-06-29 16:26:12.989798
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.000577	2025-06-29 16:26:13.000577
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.010772	2025-06-29 16:26:13.010772
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.022709	2025-06-29 16:26:13.022709
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.037141	2025-06-29 16:26:13.037141
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.05424	2025-06-29 16:26:13.05424
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.067098	2025-06-29 16:26:13.067098
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.084048	2025-06-29 16:26:13.084048
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.095487	2025-06-29 16:26:13.095487
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.107977	2025-06-29 16:26:13.107977
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.119578	2025-06-29 16:26:13.119578
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.13222	2025-06-29 16:26:13.13222
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.143285	2025-06-29 16:26:13.143285
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.154227	2025-06-29 16:26:13.154227
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.165268	2025-06-29 16:26:13.165268
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.178166	2025-06-29 16:26:13.178166
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.192576	2025-06-29 16:26:13.192576
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.209047	2025-06-29 16:26:13.209047
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.225574	2025-06-29 16:26:13.225574
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.241733	2025-06-29 16:26:13.241733
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.25589	2025-06-29 16:26:13.25589
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.266504	2025-06-29 16:26:13.266504
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.277695	2025-06-29 16:26:13.277695
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.290486	2025-06-29 16:26:13.290486
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.300524	2025-06-29 16:26:13.300524
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.312415	2025-06-29 16:26:13.312415
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.329175	2025-06-29 16:26:13.329175
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.342826	2025-06-29 16:26:13.342826
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.371305	2025-06-29 16:26:13.371305
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.390601	2025-06-29 16:26:13.390601
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.411603	2025-06-29 16:26:13.411603
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.428063	2025-06-29 16:26:13.428063
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.441816	2025-06-29 16:26:13.441816
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.451234	2025-06-29 16:26:13.451234
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.46689	2025-06-29 16:26:13.46689
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.479181	2025-06-29 16:26:13.479181
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.490548	2025-06-29 16:26:13.490548
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.502796	2025-06-29 16:26:13.502796
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.521956	2025-06-29 16:26:13.521956
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.540896	2025-06-29 16:26:13.540896
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.555166	2025-06-29 16:26:13.555166
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.566893	2025-06-29 16:26:13.566893
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.579405	2025-06-29 16:26:13.579405
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.590594	2025-06-29 16:26:13.590594
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.600363	2025-06-29 16:26:13.600363
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.612831	2025-06-29 16:26:13.612831
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.623073	2025-06-29 16:26:13.623073
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.636961	2025-06-29 16:26:13.636961
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.647176	2025-06-29 16:26:13.647176
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.659377	2025-06-29 16:26:13.659377
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.672703	2025-06-29 16:26:13.672703
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.684321	2025-06-29 16:26:13.684321
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.695671	2025-06-29 16:26:13.695671
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.706519	2025-06-29 16:26:13.706519
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.718162	2025-06-29 16:26:13.718162
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.72904	2025-06-29 16:26:13.72904
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.741553	2025-06-29 16:26:13.741553
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.753243	2025-06-29 16:26:13.753243
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.764942	2025-06-29 16:26:13.764942
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.774893	2025-06-29 16:26:13.774893
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.787868	2025-06-29 16:26:13.787868
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.799032	2025-06-29 16:26:13.799032
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.814243	2025-06-29 16:26:13.814243
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.826048	2025-06-29 16:26:13.826048
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.837416	2025-06-29 16:26:13.837416
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.848861	2025-06-29 16:26:13.848861
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.860352	2025-06-29 16:26:13.860352
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.878351	2025-06-29 16:26:13.878351
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.894987	2025-06-29 16:26:13.894987
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.910851	2025-06-29 16:26:13.910851
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.928799	2025-06-29 16:26:13.928799
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.938829	2025-06-29 16:26:13.938829
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.950356	2025-06-29 16:26:13.950356
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.962066	2025-06-29 16:26:13.962066
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:13.977747	2025-06-29 16:26:13.977747
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.001864	2025-06-29 16:26:14.001864
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.016878	2025-06-29 16:26:14.016878
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.039807	2025-06-29 16:26:14.039807
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.071647	2025-06-29 16:26:14.071647
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.09258	2025-06-29 16:26:14.09258
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.154505	2025-06-29 16:26:14.154505
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.16375	2025-06-29 16:26:14.16375
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.179578	2025-06-29 16:26:14.179578
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.192147	2025-06-29 16:26:14.192147
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.204717	2025-06-29 16:26:14.204717
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.22033	2025-06-29 16:26:14.22033
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.23155	2025-06-29 16:26:14.23155
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.243859	2025-06-29 16:26:14.243859
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.258593	2025-06-29 16:26:14.258593
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.269642	2025-06-29 16:26:14.269642
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.281566	2025-06-29 16:26:14.281566
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.298169	2025-06-29 16:26:14.298169
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.313639	2025-06-29 16:26:14.313639
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.328979	2025-06-29 16:26:14.328979
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.341105	2025-06-29 16:26:14.341105
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.352466	2025-06-29 16:26:14.352466
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.36423	2025-06-29 16:26:14.36423
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.376288	2025-06-29 16:26:14.376288
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.398021	2025-06-29 16:26:14.398021
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.408864	2025-06-29 16:26:14.408864
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.423867	2025-06-29 16:26:14.423867
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.454379	2025-06-29 16:26:14.454379
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.474514	2025-06-29 16:26:14.474514
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.487267	2025-06-29 16:26:14.487267
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.508305	2025-06-29 16:26:14.508305
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.519466	2025-06-29 16:26:14.519466
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.532942	2025-06-29 16:26:14.532942
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.55461	2025-06-29 16:26:14.55461
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.567563	2025-06-29 16:26:14.567563
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.582851	2025-06-29 16:26:14.582851
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.59376	2025-06-29 16:26:14.59376
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.606018	2025-06-29 16:26:14.606018
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.617413	2025-06-29 16:26:14.617413
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.627399	2025-06-29 16:26:14.627399
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.638663	2025-06-29 16:26:14.638663
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.647713	2025-06-29 16:26:14.647713
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.660592	2025-06-29 16:26:14.660592
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.672131	2025-06-29 16:26:14.672131
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.682982	2025-06-29 16:26:14.682982
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.694794	2025-06-29 16:26:14.694794
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:26:14.705031	2025-06-29 16:26:14.705031
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.715473	2025-06-29 16:26:14.715473
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.730232	2025-06-29 16:26:14.730232
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.741325	2025-06-29 16:26:14.741325
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.755757	2025-06-29 16:26:14.755757
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.7673	2025-06-29 16:26:14.7673
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.778114	2025-06-29 16:26:14.778114
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.791357	2025-06-29 16:26:14.791357
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.803234	2025-06-29 16:26:14.803234
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.814551	2025-06-29 16:26:14.814551
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.827549	2025-06-29 16:26:14.827549
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.842415	2025-06-29 16:26:14.842415
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.852251	2025-06-29 16:26:14.852251
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.862445	2025-06-29 16:26:14.862445
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.876199	2025-06-29 16:26:14.876199
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.890497	2025-06-29 16:26:14.890497
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.90706	2025-06-29 16:26:14.90706
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.917805	2025-06-29 16:26:14.917805
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.928574	2025-06-29 16:26:14.928574
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.941436	2025-06-29 16:26:14.941436
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.954249	2025-06-29 16:26:14.954249
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.966239	2025-06-29 16:26:14.966239
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.979314	2025-06-29 16:26:14.979314
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:14.99433	2025-06-29 16:26:14.99433
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.01132	2025-06-29 16:26:15.01132
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.032869	2025-06-29 16:26:15.032869
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.04425	2025-06-29 16:26:15.04425
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.06009	2025-06-29 16:26:15.06009
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.077106	2025-06-29 16:26:15.077106
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.088986	2025-06-29 16:26:15.088986
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.099258	2025-06-29 16:26:15.099258
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.110572	2025-06-29 16:26:15.110572
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.125601	2025-06-29 16:26:15.125601
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.143937	2025-06-29 16:26:15.143937
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.156033	2025-06-29 16:26:15.156033
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.170933	2025-06-29 16:26:15.170933
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.183219	2025-06-29 16:26:15.183219
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.197113	2025-06-29 16:26:15.197113
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.21081	2025-06-29 16:26:15.21081
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.224304	2025-06-29 16:26:15.224304
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.235524	2025-06-29 16:26:15.235524
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.250069	2025-06-29 16:26:15.250069
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.261423	2025-06-29 16:26:15.261423
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.275003	2025-06-29 16:26:15.275003
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.289452	2025-06-29 16:26:15.289452
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.301338	2025-06-29 16:26:15.301338
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.312119	2025-06-29 16:26:15.312119
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.325424	2025-06-29 16:26:15.325424
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.34753	2025-06-29 16:26:15.34753
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.359629	2025-06-29 16:26:15.359629
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.369798	2025-06-29 16:26:15.369798
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.379701	2025-06-29 16:26:15.379701
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.393282	2025-06-29 16:26:15.393282
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.405259	2025-06-29 16:26:15.405259
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.418948	2025-06-29 16:26:15.418948
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.432594	2025-06-29 16:26:15.432594
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.444972	2025-06-29 16:26:15.444972
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.456241	2025-06-29 16:26:15.456241
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.477381	2025-06-29 16:26:15.477381
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.492623	2025-06-29 16:26:15.492623
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.514667	2025-06-29 16:26:15.514667
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.54642	2025-06-29 16:26:15.54642
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.561378	2025-06-29 16:26:15.561378
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.606768	2025-06-29 16:26:15.606768
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.621925	2025-06-29 16:26:15.621925
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.666098	2025-06-29 16:26:15.666098
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.689585	2025-06-29 16:26:15.689585
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.705689	2025-06-29 16:26:15.705689
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.719634	2025-06-29 16:26:15.719634
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.736642	2025-06-29 16:26:15.736642
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.750755	2025-06-29 16:26:15.750755
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.771672	2025-06-29 16:26:15.771672
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.788275	2025-06-29 16:26:15.788275
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.806797	2025-06-29 16:26:15.806797
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.838328	2025-06-29 16:26:15.838328
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.874357	2025-06-29 16:26:15.874357
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.891573	2025-06-29 16:26:15.891573
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.908416	2025-06-29 16:26:15.908416
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.92674	2025-06-29 16:26:15.92674
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.949666	2025-06-29 16:26:15.949666
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.961302	2025-06-29 16:26:15.961302
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.974168	2025-06-29 16:26:15.974168
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:15.98875	2025-06-29 16:26:15.98875
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.006642	2025-06-29 16:26:16.006642
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.020343	2025-06-29 16:26:16.020343
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.032082	2025-06-29 16:26:16.032082
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.044605	2025-06-29 16:26:16.044605
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.060207	2025-06-29 16:26:16.060207
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.076827	2025-06-29 16:26:16.076827
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.100062	2025-06-29 16:26:16.100062
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.116268	2025-06-29 16:26:16.116268
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.131486	2025-06-29 16:26:16.131486
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.154564	2025-06-29 16:26:16.154564
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.167637	2025-06-29 16:26:16.167637
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.180313	2025-06-29 16:26:16.180313
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.19276	2025-06-29 16:26:16.19276
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.205216	2025-06-29 16:26:16.205216
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.215963	2025-06-29 16:26:16.215963
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.22734	2025-06-29 16:26:16.22734
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.244328	2025-06-29 16:26:16.244328
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.256759	2025-06-29 16:26:16.256759
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.270206	2025-06-29 16:26:16.270206
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.287478	2025-06-29 16:26:16.287478
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.308465	2025-06-29 16:26:16.308465
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.321504	2025-06-29 16:26:16.321504
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.351103	2025-06-29 16:26:16.351103
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.377324	2025-06-29 16:26:16.377324
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.407796	2025-06-29 16:26:16.407796
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.430062	2025-06-29 16:26:16.430062
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.445518	2025-06-29 16:26:16.445518
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.459286	2025-06-29 16:26:16.459286
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.48034	2025-06-29 16:26:16.48034
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.541856	2025-06-29 16:26:16.541856
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.569932	2025-06-29 16:26:16.569932
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.854977	2025-06-29 16:26:16.854977
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.898958	2025-06-29 16:26:16.898958
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.91454	2025-06-29 16:26:16.91454
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.92681	2025-06-29 16:26:16.92681
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.954871	2025-06-29 16:26:16.954871
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:16.999803	2025-06-29 16:26:16.999803
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.030682	2025-06-29 16:26:17.030682
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.05524	2025-06-29 16:26:17.05524
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.072757	2025-06-29 16:26:17.072757
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.083659	2025-06-29 16:26:17.083659
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.096556	2025-06-29 16:26:17.096556
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.106285	2025-06-29 16:26:17.106285
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.118728	2025-06-29 16:26:17.118728
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.133816	2025-06-29 16:26:17.133816
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.150382	2025-06-29 16:26:17.150382
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.169958	2025-06-29 16:26:17.169958
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.259696	2025-06-29 16:26:17.259696
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.329542	2025-06-29 16:26:17.329542
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.341372	2025-06-29 16:26:17.341372
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.352703	2025-06-29 16:26:17.352703
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.365162	2025-06-29 16:26:17.365162
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.376062	2025-06-29 16:26:17.376062
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.385445	2025-06-29 16:26:17.385445
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.396084	2025-06-29 16:26:17.396084
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.407644	2025-06-29 16:26:17.407644
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.418597	2025-06-29 16:26:17.418597
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.431366	2025-06-29 16:26:17.431366
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.44115	2025-06-29 16:26:17.44115
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.455636	2025-06-29 16:26:17.455636
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.468358	2025-06-29 16:26:17.468358
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.479743	2025-06-29 16:26:17.479743
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.491269	2025-06-29 16:26:17.491269
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.502745	2025-06-29 16:26:17.502745
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.512525	2025-06-29 16:26:17.512525
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.525896	2025-06-29 16:26:17.525896
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.537284	2025-06-29 16:26:17.537284
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.55868	2025-06-29 16:26:17.55868
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.576806	2025-06-29 16:26:17.576806
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.599835	2025-06-29 16:26:17.599835
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.623433	2025-06-29 16:26:17.623433
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.637378	2025-06-29 16:26:17.637378
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.656166	2025-06-29 16:26:17.656166
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.671988	2025-06-29 16:26:17.671988
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.686289	2025-06-29 16:26:17.686289
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.70212	2025-06-29 16:26:17.70212
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.713229	2025-06-29 16:26:17.713229
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.734444	2025-06-29 16:26:17.734444
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.757344	2025-06-29 16:26:17.757344
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.768654	2025-06-29 16:26:17.768654
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.78116	2025-06-29 16:26:17.78116
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.793556	2025-06-29 16:26:17.793556
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.807636	2025-06-29 16:26:17.807636
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.820682	2025-06-29 16:26:17.820682
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.832903	2025-06-29 16:26:17.832903
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.844465	2025-06-29 16:26:17.844465
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.854636	2025-06-29 16:26:17.854636
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.870366	2025-06-29 16:26:17.870366
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.882503	2025-06-29 16:26:17.882503
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.90606	2025-06-29 16:26:17.90606
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.918237	2025-06-29 16:26:17.918237
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.929074	2025-06-29 16:26:17.929074
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.941193	2025-06-29 16:26:17.941193
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.952979	2025-06-29 16:26:17.952979
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.963275	2025-06-29 16:26:17.963275
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.97607	2025-06-29 16:26:17.97607
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:17.989255	2025-06-29 16:26:17.989255
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.000769	2025-06-29 16:26:18.000769
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.012047	2025-06-29 16:26:18.012047
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.022915	2025-06-29 16:26:18.022915
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.042503	2025-06-29 16:26:18.042503
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.053743	2025-06-29 16:26:18.053743
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.075436	2025-06-29 16:26:18.075436
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.093896	2025-06-29 16:26:18.093896
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.108311	2025-06-29 16:26:18.108311
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.118181	2025-06-29 16:26:18.118181
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.135015	2025-06-29 16:26:18.135015
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.169645	2025-06-29 16:26:18.169645
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.197501	2025-06-29 16:26:18.197501
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.223389	2025-06-29 16:26:18.223389
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.242015	2025-06-29 16:26:18.242015
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.268804	2025-06-29 16:26:18.268804
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.290093	2025-06-29 16:26:18.290093
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.304389	2025-06-29 16:26:18.304389
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.317657	2025-06-29 16:26:18.317657
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.335904	2025-06-29 16:26:18.335904
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.353863	2025-06-29 16:26:18.353863
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.374551	2025-06-29 16:26:18.374551
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.387405	2025-06-29 16:26:18.387405
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.398826	2025-06-29 16:26:18.398826
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.410159	2025-06-29 16:26:18.410159
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.421615	2025-06-29 16:26:18.421615
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.434565	2025-06-29 16:26:18.434565
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.447107	2025-06-29 16:26:18.447107
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.458518	2025-06-29 16:26:18.458518
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.502862	2025-06-29 16:26:18.502862
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.514273	2025-06-29 16:26:18.514273
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.524552	2025-06-29 16:26:18.524552
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.536062	2025-06-29 16:26:18.536062
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.546736	2025-06-29 16:26:18.546736
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.55914	2025-06-29 16:26:18.55914
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.571281	2025-06-29 16:26:18.571281
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.592711	2025-06-29 16:26:18.592711
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.603432	2025-06-29 16:26:18.603432
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.61674	2025-06-29 16:26:18.61674
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.628815	2025-06-29 16:26:18.628815
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.649545	2025-06-29 16:26:18.649545
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.66703	2025-06-29 16:26:18.66703
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.693122	2025-06-29 16:26:18.693122
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.706124	2025-06-29 16:26:18.706124
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.722796	2025-06-29 16:26:18.722796
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.734215	2025-06-29 16:26:18.734215
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.750427	2025-06-29 16:26:18.750427
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.763636	2025-06-29 16:26:18.763636
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.787317	2025-06-29 16:26:18.787317
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.800304	2025-06-29 16:26:18.800304
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.817865	2025-06-29 16:26:18.817865
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.830473	2025-06-29 16:26:18.830473
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.843129	2025-06-29 16:26:18.843129
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.85407	2025-06-29 16:26:18.85407
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.865639	2025-06-29 16:26:18.865639
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.875982	2025-06-29 16:26:18.875982
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.887036	2025-06-29 16:26:18.887036
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.916583	2025-06-29 16:26:18.916583
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.94499	2025-06-29 16:26:18.94499
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.961014	2025-06-29 16:26:18.961014
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:18.989213	2025-06-29 16:26:18.989213
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.004671	2025-06-29 16:26:19.004671
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.018839	2025-06-29 16:26:19.018839
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.030567	2025-06-29 16:26:19.030567
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.041828	2025-06-29 16:26:19.041828
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.058618	2025-06-29 16:26:19.058618
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.069206	2025-06-29 16:26:19.069206
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.079232	2025-06-29 16:26:19.079232
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.093059	2025-06-29 16:26:19.093059
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.107612	2025-06-29 16:26:19.107612
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.119637	2025-06-29 16:26:19.119637
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.134025	2025-06-29 16:26:19.134025
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.14695	2025-06-29 16:26:19.14695
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.160457	2025-06-29 16:26:19.160457
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.173203	2025-06-29 16:26:19.173203
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.184556	2025-06-29 16:26:19.184556
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.197272	2025-06-29 16:26:19.197272
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.209124	2025-06-29 16:26:19.209124
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.219698	2025-06-29 16:26:19.219698
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.231792	2025-06-29 16:26:19.231792
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.248788	2025-06-29 16:26:19.248788
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.264614	2025-06-29 16:26:19.264614
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.280054	2025-06-29 16:26:19.280054
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.295008	2025-06-29 16:26:19.295008
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.307217	2025-06-29 16:26:19.307217
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.320235	2025-06-29 16:26:19.320235
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.331629	2025-06-29 16:26:19.331629
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.343999	2025-06-29 16:26:19.343999
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.359104	2025-06-29 16:26:19.359104
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.371294	2025-06-29 16:26:19.371294
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.38409	2025-06-29 16:26:19.38409
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.400138	2025-06-29 16:26:19.400138
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.416835	2025-06-29 16:26:19.416835
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.428599	2025-06-29 16:26:19.428599
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.440156	2025-06-29 16:26:19.440156
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.458174	2025-06-29 16:26:19.458174
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.469115	2025-06-29 16:26:19.469115
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.494787	2025-06-29 16:26:19.494787
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.509756	2025-06-29 16:26:19.509756
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.527642	2025-06-29 16:26:19.527642
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.540567	2025-06-29 16:26:19.540567
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.569607	2025-06-29 16:26:19.569607
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.585562	2025-06-29 16:26:19.585562
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.632292	2025-06-29 16:26:19.632292
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.643818	2025-06-29 16:26:19.643818
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.662412	2025-06-29 16:26:19.662412
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.689003	2025-06-29 16:26:19.689003
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.709085	2025-06-29 16:26:19.709085
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.727008	2025-06-29 16:26:19.727008
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.746051	2025-06-29 16:26:19.746051
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.760226	2025-06-29 16:26:19.760226
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.77018	2025-06-29 16:26:19.77018
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.787109	2025-06-29 16:26:19.787109
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.804296	2025-06-29 16:26:19.804296
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.81556	2025-06-29 16:26:19.81556
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:26:19.850339	2025-06-29 16:26:19.850339
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 16:25:37.338614
2	ART Coverage	\N	\N	2025-06-29 16:25:37.344122
3	People Living with HIV	\N	\N	2025-06-29 16:25:37.353307
4	HIV-related Deaths	\N	\N	2025-06-29 16:25:37.367344
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 16:25:37.410595
6	ART Pediatric Coverage	\N	\N	2025-06-29 16:25:37.419674
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminfr	$2b$12$9X7EhmsTFOBUitABWlw9kOIjvL9ZyuEHufpq41W6wEc/X0DIRRRWi	admin	0	2025-06-29 16:25:37.243009	2025-06-29 16:25:37.243009
2	userfr	$2b$12$lpcVVMlPidgD0Hn5zRoVNuWqeBQxoMNzh24cz7Mdqwi8acBH6KCLC	user	0	2025-06-29 16:25:37.285223	2025-06-29 16:25:37.285223
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

