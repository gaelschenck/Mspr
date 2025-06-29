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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 16:25:16.999387	2025-06-29 16:25:16.999387
2	Albania	Europe	\N	2025-06-29 16:25:17.051835	2025-06-29 16:25:17.051835
3	Algeria	Africa	\N	2025-06-29 16:25:17.069228	2025-06-29 16:25:17.069228
4	Angola	Africa	\N	2025-06-29 16:25:17.080408	2025-06-29 16:25:17.080408
5	Argentina	Americas	\N	2025-06-29 16:25:17.089057	2025-06-29 16:25:17.089057
6	Armenia	Europe	\N	2025-06-29 16:25:17.119643	2025-06-29 16:25:17.119643
7	Australia	Western Pacific	\N	2025-06-29 16:25:17.132673	2025-06-29 16:25:17.132673
8	Austria	Europe	\N	2025-06-29 16:25:17.174431	2025-06-29 16:25:17.174431
9	Azerbaijan	Europe	\N	2025-06-29 16:25:17.187439	2025-06-29 16:25:17.187439
10	Bahamas	Americas	\N	2025-06-29 16:25:17.196955	2025-06-29 16:25:17.196955
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 16:25:17.20968	2025-06-29 16:25:17.20968
12	Bangladesh	South-East Asia	\N	2025-06-29 16:25:17.218745	2025-06-29 16:25:17.218745
13	Barbados	Americas	\N	2025-06-29 16:25:17.230871	2025-06-29 16:25:17.230871
14	Belarus	Europe	\N	2025-06-29 16:25:17.24295	2025-06-29 16:25:17.24295
15	Belgium	Europe	\N	2025-06-29 16:25:17.254448	2025-06-29 16:25:17.254448
16	Belize	Americas	\N	2025-06-29 16:25:17.26735	2025-06-29 16:25:17.26735
17	Benin	Africa	\N	2025-06-29 16:25:17.281256	2025-06-29 16:25:17.281256
18	Bhutan	South-East Asia	\N	2025-06-29 16:25:17.294186	2025-06-29 16:25:17.294186
19	Bolivia	Americas	\N	2025-06-29 16:25:17.308401	2025-06-29 16:25:17.308401
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 16:25:17.324457	2025-06-29 16:25:17.324457
21	Botswana	Africa	\N	2025-06-29 16:25:17.338692	2025-06-29 16:25:17.338692
22	Brazil	Americas	\N	2025-06-29 16:25:17.350135	2025-06-29 16:25:17.350135
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 16:25:17.36823	2025-06-29 16:25:17.36823
24	Bulgaria	Europe	\N	2025-06-29 16:25:17.388411	2025-06-29 16:25:17.388411
25	Burkina Faso	Africa	\N	2025-06-29 16:25:17.414831	2025-06-29 16:25:17.414831
26	Burundi	Africa	\N	2025-06-29 16:25:17.429255	2025-06-29 16:25:17.429255
27	Cabo Verde	Africa	\N	2025-06-29 16:25:17.439932	2025-06-29 16:25:17.439932
28	Cambodia	Western Pacific	\N	2025-06-29 16:25:17.448695	2025-06-29 16:25:17.448695
29	Cameroon	Africa	\N	2025-06-29 16:25:17.462324	2025-06-29 16:25:17.462324
30	Canada	Americas	\N	2025-06-29 16:25:17.48072	2025-06-29 16:25:17.48072
31	Central African Republic	Africa	\N	2025-06-29 16:25:17.501702	2025-06-29 16:25:17.501702
32	Chad	Africa	\N	2025-06-29 16:25:17.534049	2025-06-29 16:25:17.534049
33	Chile	Americas	\N	2025-06-29 16:25:17.554474	2025-06-29 16:25:17.554474
34	China	Western Pacific	\N	2025-06-29 16:25:17.567651	2025-06-29 16:25:17.567651
35	Colombia	Americas	\N	2025-06-29 16:25:17.617036	2025-06-29 16:25:17.617036
36	Comoros	Africa	\N	2025-06-29 16:25:17.631724	2025-06-29 16:25:17.631724
37	Congo	Americas	\N	2025-06-29 16:25:17.647414	2025-06-29 16:25:17.647414
38	Costa Rica	Americas	\N	2025-06-29 16:25:17.661922	2025-06-29 16:25:17.661922
39	Côte d'Ivoire	Africa	\N	2025-06-29 16:25:17.685779	2025-06-29 16:25:17.685779
40	Croatia	Europe	\N	2025-06-29 16:25:17.698006	2025-06-29 16:25:17.698006
41	Cuba	Americas	\N	2025-06-29 16:25:17.709305	2025-06-29 16:25:17.709305
42	Cyprus	Europe	\N	2025-06-29 16:25:17.722368	2025-06-29 16:25:17.722368
43	Czechia	Europe	\N	2025-06-29 16:25:17.737483	2025-06-29 16:25:17.737483
44	North Korea	Western Pacific	\N	2025-06-29 16:25:17.75116	2025-06-29 16:25:17.75116
45	DR Congo	Africa	\N	2025-06-29 16:25:17.77248	2025-06-29 16:25:17.77248
46	Denmark	Europe	\N	2025-06-29 16:25:17.787922	2025-06-29 16:25:17.787922
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 16:25:17.800484	2025-06-29 16:25:17.800484
48	Dominican Republic	Americas	\N	2025-06-29 16:25:17.818708	2025-06-29 16:25:17.818708
49	Ecuador	Americas	\N	2025-06-29 16:25:17.842367	2025-06-29 16:25:17.842367
50	Egypt	Eastern Mediterranean	\N	2025-06-29 16:25:17.860489	2025-06-29 16:25:17.860489
51	El Salvador	Americas	\N	2025-06-29 16:25:17.892968	2025-06-29 16:25:17.892968
52	Equatorial Guinea	Africa	\N	2025-06-29 16:25:17.919381	2025-06-29 16:25:17.919381
53	Eritrea	Africa	\N	2025-06-29 16:25:17.941192	2025-06-29 16:25:17.941192
54	Estonia	Europe	\N	2025-06-29 16:25:17.9535	2025-06-29 16:25:17.9535
55	Eswatini	Africa	\N	2025-06-29 16:25:17.965101	2025-06-29 16:25:17.965101
56	Ethiopia	Africa	\N	2025-06-29 16:25:17.977731	2025-06-29 16:25:17.977731
57	Fiji	Western Pacific	\N	2025-06-29 16:25:17.990577	2025-06-29 16:25:17.990577
58	Finland	Europe	\N	2025-06-29 16:25:18.001204	2025-06-29 16:25:18.001204
59	France	Europe	\N	2025-06-29 16:25:18.020386	2025-06-29 16:25:18.020386
60	Gabon	Africa	\N	2025-06-29 16:25:18.03207	2025-06-29 16:25:18.03207
61	Gambia	Africa	\N	2025-06-29 16:25:18.043274	2025-06-29 16:25:18.043274
62	Georgia	Europe	\N	2025-06-29 16:25:18.060523	2025-06-29 16:25:18.060523
63	Germany	Europe	\N	2025-06-29 16:25:18.071705	2025-06-29 16:25:18.071705
64	Ghana	Africa	\N	2025-06-29 16:25:18.092862	2025-06-29 16:25:18.092862
65	Greece	Europe	\N	2025-06-29 16:25:18.106759	2025-06-29 16:25:18.106759
66	Guatemala	Americas	\N	2025-06-29 16:25:18.119996	2025-06-29 16:25:18.119996
67	Guinea	Africa	\N	2025-06-29 16:25:18.129419	2025-06-29 16:25:18.129419
68	Guinea-Bissau	Africa	\N	2025-06-29 16:25:18.142936	2025-06-29 16:25:18.142936
69	Guyana	Americas	\N	2025-06-29 16:25:18.161452	2025-06-29 16:25:18.161452
70	Haiti	Americas	\N	2025-06-29 16:25:18.173011	2025-06-29 16:25:18.173011
71	Honduras	Americas	\N	2025-06-29 16:25:18.187578	2025-06-29 16:25:18.187578
72	Hungary	Europe	\N	2025-06-29 16:25:18.200168	2025-06-29 16:25:18.200168
73	Iceland	Europe	\N	2025-06-29 16:25:18.215689	2025-06-29 16:25:18.215689
74	India	South-East Asia	\N	2025-06-29 16:25:18.230133	2025-06-29 16:25:18.230133
75	Indonesia	South-East Asia	\N	2025-06-29 16:25:18.261171	2025-06-29 16:25:18.261171
76	Iran	Eastern Mediterranean	\N	2025-06-29 16:25:18.277468	2025-06-29 16:25:18.277468
77	Ireland	Europe	\N	2025-06-29 16:25:18.292866	2025-06-29 16:25:18.292866
78	Israel	Europe	\N	2025-06-29 16:25:18.304185	2025-06-29 16:25:18.304185
79	Italy	Europe	\N	2025-06-29 16:25:18.329093	2025-06-29 16:25:18.329093
80	Jamaica	Americas	\N	2025-06-29 16:25:18.339939	2025-06-29 16:25:18.339939
81	Japan	Western Pacific	\N	2025-06-29 16:25:18.356705	2025-06-29 16:25:18.356705
82	Jordan	Eastern Mediterranean	\N	2025-06-29 16:25:18.376398	2025-06-29 16:25:18.376398
83	Kazakhstan	Europe	\N	2025-06-29 16:25:18.39337	2025-06-29 16:25:18.39337
84	Kenya	Africa	\N	2025-06-29 16:25:18.404383	2025-06-29 16:25:18.404383
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 16:25:18.417984	2025-06-29 16:25:18.417984
86	Kyrgyzstan	Europe	\N	2025-06-29 16:25:18.450393	2025-06-29 16:25:18.450393
87	Laos	Western Pacific	\N	2025-06-29 16:25:18.460909	2025-06-29 16:25:18.460909
88	Latvia	Europe	\N	2025-06-29 16:25:18.480142	2025-06-29 16:25:18.480142
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 16:25:18.502583	2025-06-29 16:25:18.502583
90	Lesotho	Africa	\N	2025-06-29 16:25:18.521771	2025-06-29 16:25:18.521771
91	Liberia	Africa	\N	2025-06-29 16:25:18.536677	2025-06-29 16:25:18.536677
92	Libya	Eastern Mediterranean	\N	2025-06-29 16:25:18.551388	2025-06-29 16:25:18.551388
93	Lithuania	Europe	\N	2025-06-29 16:25:18.564906	2025-06-29 16:25:18.564906
94	Luxembourg	Europe	\N	2025-06-29 16:25:18.589429	2025-06-29 16:25:18.589429
95	Madagascar	Africa	\N	2025-06-29 16:25:18.613666	2025-06-29 16:25:18.613666
96	Malawi	Africa	\N	2025-06-29 16:25:18.622769	2025-06-29 16:25:18.622769
97	Malaysia	Western Pacific	\N	2025-06-29 16:25:18.63158	2025-06-29 16:25:18.63158
98	Maldives	South-East Asia	\N	2025-06-29 16:25:18.638929	2025-06-29 16:25:18.638929
99	Mali	Africa	\N	2025-06-29 16:25:18.647588	2025-06-29 16:25:18.647588
100	Malta	Europe	\N	2025-06-29 16:25:18.656405	2025-06-29 16:25:18.656405
101	Mauritania	Africa	\N	2025-06-29 16:25:18.663135	2025-06-29 16:25:18.663135
102	Mauritius	Africa	\N	2025-06-29 16:25:18.674815	2025-06-29 16:25:18.674815
103	Mexico	Americas	\N	2025-06-29 16:25:18.68511	2025-06-29 16:25:18.68511
104	Mongolia	Western Pacific	\N	2025-06-29 16:25:18.696292	2025-06-29 16:25:18.696292
105	Montenegro	Europe	\N	2025-06-29 16:25:18.702521	2025-06-29 16:25:18.702521
106	Morocco	Eastern Mediterranean	\N	2025-06-29 16:25:18.710602	2025-06-29 16:25:18.710602
107	Mozambique	Africa	\N	2025-06-29 16:25:18.719414	2025-06-29 16:25:18.719414
108	Myanmar	South-East Asia	\N	2025-06-29 16:25:18.726247	2025-06-29 16:25:18.726247
109	Namibia	Africa	\N	2025-06-29 16:25:18.736038	2025-06-29 16:25:18.736038
110	Nepal	South-East Asia	\N	2025-06-29 16:25:18.740917	2025-06-29 16:25:18.740917
111	Netherlands	Europe	\N	2025-06-29 16:25:18.745281	2025-06-29 16:25:18.745281
112	New Zealand	Western Pacific	\N	2025-06-29 16:25:18.754479	2025-06-29 16:25:18.754479
113	Nicaragua	Americas	\N	2025-06-29 16:25:18.763227	2025-06-29 16:25:18.763227
114	Niger	Africa	\N	2025-06-29 16:25:18.771894	2025-06-29 16:25:18.771894
115	Nigeria	Africa	\N	2025-06-29 16:25:18.77473	2025-06-29 16:25:18.77473
116	Norway	Europe	\N	2025-06-29 16:25:18.781817	2025-06-29 16:25:18.781817
117	Oman	Eastern Mediterranean	\N	2025-06-29 16:25:18.788984	2025-06-29 16:25:18.788984
118	Pakistan	Eastern Mediterranean	\N	2025-06-29 16:25:18.797038	2025-06-29 16:25:18.797038
119	Panama	Americas	\N	2025-06-29 16:25:18.803468	2025-06-29 16:25:18.803468
120	Papua New Guinea	Western Pacific	\N	2025-06-29 16:25:18.811815	2025-06-29 16:25:18.811815
121	Paraguay	Americas	\N	2025-06-29 16:25:18.818487	2025-06-29 16:25:18.818487
122	Peru	Americas	\N	2025-06-29 16:25:18.825253	2025-06-29 16:25:18.825253
123	Philippines	Western Pacific	\N	2025-06-29 16:25:18.832223	2025-06-29 16:25:18.832223
124	Poland	Europe	\N	2025-06-29 16:25:18.840272	2025-06-29 16:25:18.840272
125	Portugal	Europe	\N	2025-06-29 16:25:18.846488	2025-06-29 16:25:18.846488
126	Qatar	Eastern Mediterranean	\N	2025-06-29 16:25:18.856412	2025-06-29 16:25:18.856412
127	South Korea	Western Pacific	\N	2025-06-29 16:25:18.863015	2025-06-29 16:25:18.863015
128	Moldova	Europe	\N	2025-06-29 16:25:18.873211	2025-06-29 16:25:18.873211
129	North Macedonia	Europe	\N	2025-06-29 16:25:18.889216	2025-06-29 16:25:18.889216
130	Romania	Europe	\N	2025-06-29 16:25:18.899861	2025-06-29 16:25:18.899861
131	Russia	Europe	\N	2025-06-29 16:25:18.909292	2025-06-29 16:25:18.909292
132	Rwanda	Africa	\N	2025-06-29 16:25:18.922115	2025-06-29 16:25:18.922115
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-29 16:25:18.930954	2025-06-29 16:25:18.930954
134	Senegal	Africa	\N	2025-06-29 16:25:18.938564	2025-06-29 16:25:18.938564
135	Serbia	Europe	\N	2025-06-29 16:25:18.94456	2025-06-29 16:25:18.94456
136	Sierra Leone	Africa	\N	2025-06-29 16:25:18.95134	2025-06-29 16:25:18.95134
137	Singapore	Western Pacific	\N	2025-06-29 16:25:18.958462	2025-06-29 16:25:18.958462
138	Slovakia	Europe	\N	2025-06-29 16:25:18.965024	2025-06-29 16:25:18.965024
139	Slovenia	Europe	\N	2025-06-29 16:25:18.972695	2025-06-29 16:25:18.972695
140	Somalia	Eastern Mediterranean	\N	2025-06-29 16:25:18.978529	2025-06-29 16:25:18.978529
141	South Africa	Africa	\N	2025-06-29 16:25:18.986846	2025-06-29 16:25:18.986846
142	South Sudan	Africa	\N	2025-06-29 16:25:18.992884	2025-06-29 16:25:18.992884
143	Spain	Europe	\N	2025-06-29 16:25:19.000273	2025-06-29 16:25:19.000273
144	Sri Lanka	South-East Asia	\N	2025-06-29 16:25:19.008244	2025-06-29 16:25:19.008244
145	Sudan	Eastern Mediterranean	\N	2025-06-29 16:25:19.018771	2025-06-29 16:25:19.018771
146	Suriname	Americas	\N	2025-06-29 16:25:19.029365	2025-06-29 16:25:19.029365
147	Sweden	Europe	\N	2025-06-29 16:25:19.037395	2025-06-29 16:25:19.037395
148	Switzerland	Europe	\N	2025-06-29 16:25:19.04953	2025-06-29 16:25:19.04953
149	Syria	Eastern Mediterranean	\N	2025-06-29 16:25:19.05728	2025-06-29 16:25:19.05728
150	Tajikistan	Europe	\N	2025-06-29 16:25:19.063831	2025-06-29 16:25:19.063831
151	Thailand	South-East Asia	\N	2025-06-29 16:25:19.074671	2025-06-29 16:25:19.074671
152	Timor-Leste	South-East Asia	\N	2025-06-29 16:25:19.082422	2025-06-29 16:25:19.082422
153	Togo	Africa	\N	2025-06-29 16:25:19.089995	2025-06-29 16:25:19.089995
154	Trinidad and Tobago	Americas	\N	2025-06-29 16:25:19.097822	2025-06-29 16:25:19.097822
155	Tunisia	Eastern Mediterranean	\N	2025-06-29 16:25:19.105544	2025-06-29 16:25:19.105544
156	Turkey	Europe	\N	2025-06-29 16:25:19.112265	2025-06-29 16:25:19.112265
157	Turkmenistan	Europe	\N	2025-06-29 16:25:19.118699	2025-06-29 16:25:19.118699
158	Uganda	Africa	\N	2025-06-29 16:25:19.126224	2025-06-29 16:25:19.126224
159	Ukraine	Europe	\N	2025-06-29 16:25:19.168665	2025-06-29 16:25:19.168665
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-29 16:25:19.196586	2025-06-29 16:25:19.196586
161	United Kingdom	Europe	\N	2025-06-29 16:25:19.210446	2025-06-29 16:25:19.210446
162	Tanzania	Africa	\N	2025-06-29 16:25:19.217608	2025-06-29 16:25:19.217608
163	United States	Americas	\N	2025-06-29 16:25:19.225395	2025-06-29 16:25:19.225395
164	Uruguay	Americas	\N	2025-06-29 16:25:19.235833	2025-06-29 16:25:19.235833
165	Uzbekistan	Europe	\N	2025-06-29 16:25:19.246652	2025-06-29 16:25:19.246652
166	Venezuela	Americas	\N	2025-06-29 16:25:19.249964	2025-06-29 16:25:19.249964
167	Viet Nam	Western Pacific	\N	2025-06-29 16:25:19.258557	2025-06-29 16:25:19.258557
168	Yemen	Eastern Mediterranean	\N	2025-06-29 16:25:19.268926	2025-06-29 16:25:19.268926
169	Zambia	Africa	\N	2025-06-29 16:25:19.278925	2025-06-29 16:25:19.278925
170	Zimbabwe	Africa	\N	2025-06-29 16:25:19.287676	2025-06-29 16:25:19.287676
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.298751	2025-06-29 16:25:19.298751
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.311953	2025-06-29 16:25:19.311953
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.322464	2025-06-29 16:25:19.322464
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.332207	2025-06-29 16:25:19.332207
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.3434	2025-06-29 16:25:19.3434
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.355343	2025-06-29 16:25:19.355343
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.365934	2025-06-29 16:25:19.365934
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.369093	2025-06-29 16:25:19.369093
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.379703	2025-06-29 16:25:19.379703
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.394251	2025-06-29 16:25:19.394251
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.404213	2025-06-29 16:25:19.404213
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.422533	2025-06-29 16:25:19.422533
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.433455	2025-06-29 16:25:19.433455
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.439657	2025-06-29 16:25:19.439657
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.447478	2025-06-29 16:25:19.447478
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.454549	2025-06-29 16:25:19.454549
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.46188	2025-06-29 16:25:19.46188
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.47009	2025-06-29 16:25:19.47009
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.479666	2025-06-29 16:25:19.479666
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.486177	2025-06-29 16:25:19.486177
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.493686	2025-06-29 16:25:19.493686
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.506939	2025-06-29 16:25:19.506939
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.51351	2025-06-29 16:25:19.51351
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.534931	2025-06-29 16:25:19.534931
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.544506	2025-06-29 16:25:19.544506
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.608232	2025-06-29 16:25:19.608232
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.649614	2025-06-29 16:25:19.649614
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.662198	2025-06-29 16:25:19.662198
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.681881	2025-06-29 16:25:19.681881
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.686943	2025-06-29 16:25:19.686943
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.699792	2025-06-29 16:25:19.699792
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.706788	2025-06-29 16:25:19.706788
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.723022	2025-06-29 16:25:19.723022
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.729854	2025-06-29 16:25:19.729854
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.736725	2025-06-29 16:25:19.736725
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.746533	2025-06-29 16:25:19.746533
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.755627	2025-06-29 16:25:19.755627
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.762498	2025-06-29 16:25:19.762498
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.771403	2025-06-29 16:25:19.771403
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.78177	2025-06-29 16:25:19.78177
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.792457	2025-06-29 16:25:19.792457
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.802952	2025-06-29 16:25:19.802952
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.810929	2025-06-29 16:25:19.810929
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.820053	2025-06-29 16:25:19.820053
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.829138	2025-06-29 16:25:19.829138
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.839526	2025-06-29 16:25:19.839526
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.849878	2025-06-29 16:25:19.849878
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.865357	2025-06-29 16:25:19.865357
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.876093	2025-06-29 16:25:19.876093
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.887513	2025-06-29 16:25:19.887513
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.916435	2025-06-29 16:25:19.916435
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.929806	2025-06-29 16:25:19.929806
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.976659	2025-06-29 16:25:19.976659
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:19.98966	2025-06-29 16:25:19.98966
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.000491	2025-06-29 16:25:20.000491
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.042292	2025-06-29 16:25:20.042292
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.057134	2025-06-29 16:25:20.057134
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.066317	2025-06-29 16:25:20.066317
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.078477	2025-06-29 16:25:20.078477
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.088528	2025-06-29 16:25:20.088528
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.10607	2025-06-29 16:25:20.10607
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.118644	2025-06-29 16:25:20.118644
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.135248	2025-06-29 16:25:20.135248
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.147013	2025-06-29 16:25:20.147013
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.161326	2025-06-29 16:25:20.161326
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.175389	2025-06-29 16:25:20.175389
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.192598	2025-06-29 16:25:20.192598
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.207808	2025-06-29 16:25:20.207808
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.221	2025-06-29 16:25:20.221
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.234903	2025-06-29 16:25:20.234903
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.246724	2025-06-29 16:25:20.246724
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.261081	2025-06-29 16:25:20.261081
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.27546	2025-06-29 16:25:20.27546
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.286351	2025-06-29 16:25:20.286351
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.303141	2025-06-29 16:25:20.303141
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.315077	2025-06-29 16:25:20.315077
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.331184	2025-06-29 16:25:20.331184
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.347134	2025-06-29 16:25:20.347134
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.364186	2025-06-29 16:25:20.364186
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.377106	2025-06-29 16:25:20.377106
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.389384	2025-06-29 16:25:20.389384
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.401751	2025-06-29 16:25:20.401751
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.420894	2025-06-29 16:25:20.420894
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.436636	2025-06-29 16:25:20.436636
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.455422	2025-06-29 16:25:20.455422
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.470768	2025-06-29 16:25:20.470768
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.490321	2025-06-29 16:25:20.490321
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.504338	2025-06-29 16:25:20.504338
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.517512	2025-06-29 16:25:20.517512
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.528174	2025-06-29 16:25:20.528174
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.543829	2025-06-29 16:25:20.543829
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.564264	2025-06-29 16:25:20.564264
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.591557	2025-06-29 16:25:20.591557
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.607892	2025-06-29 16:25:20.607892
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.618826	2025-06-29 16:25:20.618826
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.632083	2025-06-29 16:25:20.632083
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.643679	2025-06-29 16:25:20.643679
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.66137	2025-06-29 16:25:20.66137
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.673178	2025-06-29 16:25:20.673178
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.690207	2025-06-29 16:25:20.690207
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.699489	2025-06-29 16:25:20.699489
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.713348	2025-06-29 16:25:20.713348
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.722795	2025-06-29 16:25:20.722795
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.733486	2025-06-29 16:25:20.733486
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.74571	2025-06-29 16:25:20.74571
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.757264	2025-06-29 16:25:20.757264
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.768383	2025-06-29 16:25:20.768383
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.780266	2025-06-29 16:25:20.780266
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.79245	2025-06-29 16:25:20.79245
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.806322	2025-06-29 16:25:20.806322
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.817257	2025-06-29 16:25:20.817257
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.829798	2025-06-29 16:25:20.829798
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.843948	2025-06-29 16:25:20.843948
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.859643	2025-06-29 16:25:20.859643
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.869248	2025-06-29 16:25:20.869248
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.880606	2025-06-29 16:25:20.880606
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.894757	2025-06-29 16:25:20.894757
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.908878	2025-06-29 16:25:20.908878
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.922003	2025-06-29 16:25:20.922003
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.935522	2025-06-29 16:25:20.935522
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.954569	2025-06-29 16:25:20.954569
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.967406	2025-06-29 16:25:20.967406
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:20.981731	2025-06-29 16:25:20.981731
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.00039	2025-06-29 16:25:21.00039
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.010948	2025-06-29 16:25:21.010948
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.022308	2025-06-29 16:25:21.022308
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.034863	2025-06-29 16:25:21.034863
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.047423	2025-06-29 16:25:21.047423
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.061876	2025-06-29 16:25:21.061876
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.076566	2025-06-29 16:25:21.076566
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.090954	2025-06-29 16:25:21.090954
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.120422	2025-06-29 16:25:21.120422
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.134843	2025-06-29 16:25:21.134843
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.145921	2025-06-29 16:25:21.145921
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.162837	2025-06-29 16:25:21.162837
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.183051	2025-06-29 16:25:21.183051
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.197031	2025-06-29 16:25:21.197031
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.208551	2025-06-29 16:25:21.208551
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.218117	2025-06-29 16:25:21.218117
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.231393	2025-06-29 16:25:21.231393
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.241022	2025-06-29 16:25:21.241022
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.253013	2025-06-29 16:25:21.253013
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.263432	2025-06-29 16:25:21.263432
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.277134	2025-06-29 16:25:21.277134
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.290164	2025-06-29 16:25:21.290164
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.300976	2025-06-29 16:25:21.300976
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.309919	2025-06-29 16:25:21.309919
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.320243	2025-06-29 16:25:21.320243
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.337071	2025-06-29 16:25:21.337071
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.355323	2025-06-29 16:25:21.355323
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.379374	2025-06-29 16:25:21.379374
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.393674	2025-06-29 16:25:21.393674
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.409333	2025-06-29 16:25:21.409333
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.423354	2025-06-29 16:25:21.423354
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.43833	2025-06-29 16:25:21.43833
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.45309	2025-06-29 16:25:21.45309
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.464946	2025-06-29 16:25:21.464946
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.480093	2025-06-29 16:25:21.480093
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.493516	2025-06-29 16:25:21.493516
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.508233	2025-06-29 16:25:21.508233
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.52364	2025-06-29 16:25:21.52364
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.545489	2025-06-29 16:25:21.545489
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.560575	2025-06-29 16:25:21.560575
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.584935	2025-06-29 16:25:21.584935
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.603735	2025-06-29 16:25:21.603735
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.618595	2025-06-29 16:25:21.618595
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.632247	2025-06-29 16:25:21.632247
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.642633	2025-06-29 16:25:21.642633
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.654335	2025-06-29 16:25:21.654335
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.665571	2025-06-29 16:25:21.665571
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.678191	2025-06-29 16:25:21.678191
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.688138	2025-06-29 16:25:21.688138
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.697626	2025-06-29 16:25:21.697626
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.70993	2025-06-29 16:25:21.70993
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.721951	2025-06-29 16:25:21.721951
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.735376	2025-06-29 16:25:21.735376
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.747298	2025-06-29 16:25:21.747298
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.76327	2025-06-29 16:25:21.76327
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.778706	2025-06-29 16:25:21.778706
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.795086	2025-06-29 16:25:21.795086
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.808046	2025-06-29 16:25:21.808046
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.819861	2025-06-29 16:25:21.819861
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.831487	2025-06-29 16:25:21.831487
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.85009	2025-06-29 16:25:21.85009
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.868465	2025-06-29 16:25:21.868465
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.879636	2025-06-29 16:25:21.879636
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.889964	2025-06-29 16:25:21.889964
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.90234	2025-06-29 16:25:21.90234
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.914458	2025-06-29 16:25:21.914458
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.928354	2025-06-29 16:25:21.928354
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.941328	2025-06-29 16:25:21.941328
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.953785	2025-06-29 16:25:21.953785
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.964722	2025-06-29 16:25:21.964722
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.978057	2025-06-29 16:25:21.978057
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:21.998727	2025-06-29 16:25:21.998727
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.010016	2025-06-29 16:25:22.010016
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.021962	2025-06-29 16:25:22.021962
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.035168	2025-06-29 16:25:22.035168
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.05016	2025-06-29 16:25:22.05016
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.069553	2025-06-29 16:25:22.069553
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.090332	2025-06-29 16:25:22.090332
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.107796	2025-06-29 16:25:22.107796
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.130746	2025-06-29 16:25:22.130746
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.152867	2025-06-29 16:25:22.152867
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.187856	2025-06-29 16:25:22.187856
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.220569	2025-06-29 16:25:22.220569
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.24096	2025-06-29 16:25:22.24096
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.264465	2025-06-29 16:25:22.264465
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.289204	2025-06-29 16:25:22.289204
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.301221	2025-06-29 16:25:22.301221
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.315182	2025-06-29 16:25:22.315182
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.335137	2025-06-29 16:25:22.335137
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.351562	2025-06-29 16:25:22.351562
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.364007	2025-06-29 16:25:22.364007
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.379945	2025-06-29 16:25:22.379945
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.404519	2025-06-29 16:25:22.404519
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.434546	2025-06-29 16:25:22.434546
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.450212	2025-06-29 16:25:22.450212
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.476382	2025-06-29 16:25:22.476382
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.487114	2025-06-29 16:25:22.487114
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.501363	2025-06-29 16:25:22.501363
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.516807	2025-06-29 16:25:22.516807
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.529578	2025-06-29 16:25:22.529578
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.549884	2025-06-29 16:25:22.549884
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.563933	2025-06-29 16:25:22.563933
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.57629	2025-06-29 16:25:22.57629
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.589759	2025-06-29 16:25:22.589759
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.606155	2025-06-29 16:25:22.606155
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.622206	2025-06-29 16:25:22.622206
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.634484	2025-06-29 16:25:22.634484
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.649932	2025-06-29 16:25:22.649932
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.665092	2025-06-29 16:25:22.665092
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.679239	2025-06-29 16:25:22.679239
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.693257	2025-06-29 16:25:22.693257
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.702725	2025-06-29 16:25:22.702725
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.714351	2025-06-29 16:25:22.714351
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.726713	2025-06-29 16:25:22.726713
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.737828	2025-06-29 16:25:22.737828
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.749623	2025-06-29 16:25:22.749623
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.760384	2025-06-29 16:25:22.760384
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.776475	2025-06-29 16:25:22.776475
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.789072	2025-06-29 16:25:22.789072
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.800747	2025-06-29 16:25:22.800747
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.811537	2025-06-29 16:25:22.811537
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.825104	2025-06-29 16:25:22.825104
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.837817	2025-06-29 16:25:22.837817
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.846624	2025-06-29 16:25:22.846624
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.858172	2025-06-29 16:25:22.858172
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.871499	2025-06-29 16:25:22.871499
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.885151	2025-06-29 16:25:22.885151
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.903268	2025-06-29 16:25:22.903268
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.918279	2025-06-29 16:25:22.918279
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.929154	2025-06-29 16:25:22.929154
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.941858	2025-06-29 16:25:22.941858
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.957237	2025-06-29 16:25:22.957237
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.969927	2025-06-29 16:25:22.969927
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.983177	2025-06-29 16:25:22.983177
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:22.997012	2025-06-29 16:25:22.997012
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.00929	2025-06-29 16:25:23.00929
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.027437	2025-06-29 16:25:23.027437
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.041707	2025-06-29 16:25:23.041707
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.05495	2025-06-29 16:25:23.05495
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.06697	2025-06-29 16:25:23.06697
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.080016	2025-06-29 16:25:23.080016
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.092196	2025-06-29 16:25:23.092196
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.10239	2025-06-29 16:25:23.10239
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.117158	2025-06-29 16:25:23.117158
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.129911	2025-06-29 16:25:23.129911
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.143469	2025-06-29 16:25:23.143469
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.156256	2025-06-29 16:25:23.156256
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.167683	2025-06-29 16:25:23.167683
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.182495	2025-06-29 16:25:23.182495
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.191796	2025-06-29 16:25:23.191796
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.207329	2025-06-29 16:25:23.207329
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.218449	2025-06-29 16:25:23.218449
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.227918	2025-06-29 16:25:23.227918
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.239802	2025-06-29 16:25:23.239802
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.252296	2025-06-29 16:25:23.252296
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.26228	2025-06-29 16:25:23.26228
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.271814	2025-06-29 16:25:23.271814
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.280541	2025-06-29 16:25:23.280541
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.294905	2025-06-29 16:25:23.294905
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.306088	2025-06-29 16:25:23.306088
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.318149	2025-06-29 16:25:23.318149
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.334756	2025-06-29 16:25:23.334756
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.354703	2025-06-29 16:25:23.354703
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.365779	2025-06-29 16:25:23.365779
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.376758	2025-06-29 16:25:23.376758
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.38923	2025-06-29 16:25:23.38923
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.401937	2025-06-29 16:25:23.401937
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.4142	2025-06-29 16:25:23.4142
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.424803	2025-06-29 16:25:23.424803
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.435682	2025-06-29 16:25:23.435682
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.447472	2025-06-29 16:25:23.447472
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.46274	2025-06-29 16:25:23.46274
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.477769	2025-06-29 16:25:23.477769
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.488661	2025-06-29 16:25:23.488661
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.498358	2025-06-29 16:25:23.498358
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.508492	2025-06-29 16:25:23.508492
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.520617	2025-06-29 16:25:23.520617
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.533236	2025-06-29 16:25:23.533236
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.549346	2025-06-29 16:25:23.549346
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.560273	2025-06-29 16:25:23.560273
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 16:25:23.570882	2025-06-29 16:25:23.570882
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.591694	2025-06-29 16:25:23.591694
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.602271	2025-06-29 16:25:23.602271
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.621534	2025-06-29 16:25:23.621534
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.632182	2025-06-29 16:25:23.632182
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.64447	2025-06-29 16:25:23.64447
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.655065	2025-06-29 16:25:23.655065
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.671034	2025-06-29 16:25:23.671034
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.684241	2025-06-29 16:25:23.684241
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.698282	2025-06-29 16:25:23.698282
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.715184	2025-06-29 16:25:23.715184
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.72755	2025-06-29 16:25:23.72755
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.738457	2025-06-29 16:25:23.738457
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.749696	2025-06-29 16:25:23.749696
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.76131	2025-06-29 16:25:23.76131
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.776804	2025-06-29 16:25:23.776804
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.786756	2025-06-29 16:25:23.786756
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.798824	2025-06-29 16:25:23.798824
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.809266	2025-06-29 16:25:23.809266
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.821824	2025-06-29 16:25:23.821824
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.836406	2025-06-29 16:25:23.836406
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.848608	2025-06-29 16:25:23.848608
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.864517	2025-06-29 16:25:23.864517
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.873863	2025-06-29 16:25:23.873863
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.885784	2025-06-29 16:25:23.885784
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.896366	2025-06-29 16:25:23.896366
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.905835	2025-06-29 16:25:23.905835
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.916122	2025-06-29 16:25:23.916122
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.926266	2025-06-29 16:25:23.926266
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.937352	2025-06-29 16:25:23.937352
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.948057	2025-06-29 16:25:23.948057
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.960355	2025-06-29 16:25:23.960355
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.971627	2025-06-29 16:25:23.971627
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:23.985354	2025-06-29 16:25:23.985354
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.004213	2025-06-29 16:25:24.004213
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.015378	2025-06-29 16:25:24.015378
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.028016	2025-06-29 16:25:24.028016
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.045381	2025-06-29 16:25:24.045381
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.059908	2025-06-29 16:25:24.059908
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.081315	2025-06-29 16:25:24.081315
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.09772	2025-06-29 16:25:24.09772
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.113063	2025-06-29 16:25:24.113063
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.130391	2025-06-29 16:25:24.130391
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.141525	2025-06-29 16:25:24.141525
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.158654	2025-06-29 16:25:24.158654
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.176408	2025-06-29 16:25:24.176408
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.192692	2025-06-29 16:25:24.192692
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.204145	2025-06-29 16:25:24.204145
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.242108	2025-06-29 16:25:24.242108
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.254512	2025-06-29 16:25:24.254512
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.267638	2025-06-29 16:25:24.267638
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.279651	2025-06-29 16:25:24.279651
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.296308	2025-06-29 16:25:24.296308
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.31037	2025-06-29 16:25:24.31037
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.322391	2025-06-29 16:25:24.322391
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.338002	2025-06-29 16:25:24.338002
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.353305	2025-06-29 16:25:24.353305
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.370017	2025-06-29 16:25:24.370017
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.379748	2025-06-29 16:25:24.379748
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.389228	2025-06-29 16:25:24.389228
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.401538	2025-06-29 16:25:24.401538
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.412553	2025-06-29 16:25:24.412553
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.42451	2025-06-29 16:25:24.42451
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.43548	2025-06-29 16:25:24.43548
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.446548	2025-06-29 16:25:24.446548
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.461632	2025-06-29 16:25:24.461632
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.472262	2025-06-29 16:25:24.472262
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.485118	2025-06-29 16:25:24.485118
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.50066	2025-06-29 16:25:24.50066
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.52579	2025-06-29 16:25:24.52579
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.540264	2025-06-29 16:25:24.540264
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.554326	2025-06-29 16:25:24.554326
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.571825	2025-06-29 16:25:24.571825
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.583179	2025-06-29 16:25:24.583179
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.596591	2025-06-29 16:25:24.596591
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.608347	2025-06-29 16:25:24.608347
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.619901	2025-06-29 16:25:24.619901
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.630959	2025-06-29 16:25:24.630959
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.642556	2025-06-29 16:25:24.642556
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.653234	2025-06-29 16:25:24.653234
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.666885	2025-06-29 16:25:24.666885
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.67903	2025-06-29 16:25:24.67903
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.69018	2025-06-29 16:25:24.69018
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.703342	2025-06-29 16:25:24.703342
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.71725	2025-06-29 16:25:24.71725
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.731098	2025-06-29 16:25:24.731098
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.742062	2025-06-29 16:25:24.742062
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.760635	2025-06-29 16:25:24.760635
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.779158	2025-06-29 16:25:24.779158
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.798624	2025-06-29 16:25:24.798624
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.81563	2025-06-29 16:25:24.81563
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.829019	2025-06-29 16:25:24.829019
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.845139	2025-06-29 16:25:24.845139
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.854797	2025-06-29 16:25:24.854797
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.872756	2025-06-29 16:25:24.872756
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.887299	2025-06-29 16:25:24.887299
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.908585	2025-06-29 16:25:24.908585
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.919788	2025-06-29 16:25:24.919788
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.931613	2025-06-29 16:25:24.931613
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.943431	2025-06-29 16:25:24.943431
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.960171	2025-06-29 16:25:24.960171
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.975495	2025-06-29 16:25:24.975495
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:24.989314	2025-06-29 16:25:24.989314
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.027262	2025-06-29 16:25:25.027262
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.042578	2025-06-29 16:25:25.042578
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.062649	2025-06-29 16:25:25.062649
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.078204	2025-06-29 16:25:25.078204
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.090485	2025-06-29 16:25:25.090485
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.10349	2025-06-29 16:25:25.10349
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.116719	2025-06-29 16:25:25.116719
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.13292	2025-06-29 16:25:25.13292
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.154322	2025-06-29 16:25:25.154322
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.17818	2025-06-29 16:25:25.17818
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.199387	2025-06-29 16:25:25.199387
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.216775	2025-06-29 16:25:25.216775
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.235957	2025-06-29 16:25:25.235957
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.327283	2025-06-29 16:25:25.327283
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.364359	2025-06-29 16:25:25.364359
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.379531	2025-06-29 16:25:25.379531
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.417314	2025-06-29 16:25:25.417314
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.43724	2025-06-29 16:25:25.43724
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.450123	2025-06-29 16:25:25.450123
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.484682	2025-06-29 16:25:25.484682
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.508854	2025-06-29 16:25:25.508854
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.543132	2025-06-29 16:25:25.543132
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.580098	2025-06-29 16:25:25.580098
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.622188	2025-06-29 16:25:25.622188
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.657297	2025-06-29 16:25:25.657297
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.689586	2025-06-29 16:25:25.689586
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.708644	2025-06-29 16:25:25.708644
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.736734	2025-06-29 16:25:25.736734
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.751872	2025-06-29 16:25:25.751872
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.770541	2025-06-29 16:25:25.770541
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.797085	2025-06-29 16:25:25.797085
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.813715	2025-06-29 16:25:25.813715
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.841547	2025-06-29 16:25:25.841547
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.86681	2025-06-29 16:25:25.86681
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.893763	2025-06-29 16:25:25.893763
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.910628	2025-06-29 16:25:25.910628
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.929439	2025-06-29 16:25:25.929439
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.955879	2025-06-29 16:25:25.955879
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:25.96873	2025-06-29 16:25:25.96873
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.012723	2025-06-29 16:25:26.012723
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.032963	2025-06-29 16:25:26.032963
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.057936	2025-06-29 16:25:26.057936
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.097066	2025-06-29 16:25:26.097066
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.126706	2025-06-29 16:25:26.126706
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.164394	2025-06-29 16:25:26.164394
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.187464	2025-06-29 16:25:26.187464
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.20505	2025-06-29 16:25:26.20505
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.222452	2025-06-29 16:25:26.222452
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.245928	2025-06-29 16:25:26.245928
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.265499	2025-06-29 16:25:26.265499
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.283312	2025-06-29 16:25:26.283312
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.32465	2025-06-29 16:25:26.32465
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.355752	2025-06-29 16:25:26.355752
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.376384	2025-06-29 16:25:26.376384
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.389504	2025-06-29 16:25:26.389504
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.455753	2025-06-29 16:25:26.455753
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.48957	2025-06-29 16:25:26.48957
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.501098	2025-06-29 16:25:26.501098
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.589391	2025-06-29 16:25:26.589391
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.60804	2025-06-29 16:25:26.60804
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.628061	2025-06-29 16:25:26.628061
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.639557	2025-06-29 16:25:26.639557
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.651348	2025-06-29 16:25:26.651348
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.662267	2025-06-29 16:25:26.662267
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.677748	2025-06-29 16:25:26.677748
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.689512	2025-06-29 16:25:26.689512
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.703921	2025-06-29 16:25:26.703921
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.718955	2025-06-29 16:25:26.718955
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.730908	2025-06-29 16:25:26.730908
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.742711	2025-06-29 16:25:26.742711
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.757669	2025-06-29 16:25:26.757669
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.769762	2025-06-29 16:25:26.769762
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.787446	2025-06-29 16:25:26.787446
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.801903	2025-06-29 16:25:26.801903
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.81472	2025-06-29 16:25:26.81472
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.829861	2025-06-29 16:25:26.829861
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.840379	2025-06-29 16:25:26.840379
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.852705	2025-06-29 16:25:26.852705
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.864396	2025-06-29 16:25:26.864396
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.876358	2025-06-29 16:25:26.876358
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.887473	2025-06-29 16:25:26.887473
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.900172	2025-06-29 16:25:26.900172
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.913488	2025-06-29 16:25:26.913488
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.923006	2025-06-29 16:25:26.923006
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.932855	2025-06-29 16:25:26.932855
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.94456	2025-06-29 16:25:26.94456
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.955355	2025-06-29 16:25:26.955355
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.965301	2025-06-29 16:25:26.965301
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.980095	2025-06-29 16:25:26.980095
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:26.991355	2025-06-29 16:25:26.991355
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.006707	2025-06-29 16:25:27.006707
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.019644	2025-06-29 16:25:27.019644
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.031485	2025-06-29 16:25:27.031485
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.041989	2025-06-29 16:25:27.041989
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.052405	2025-06-29 16:25:27.052405
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.064476	2025-06-29 16:25:27.064476
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.07777	2025-06-29 16:25:27.07777
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.089382	2025-06-29 16:25:27.089382
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.100415	2025-06-29 16:25:27.100415
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.110253	2025-06-29 16:25:27.110253
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.119737	2025-06-29 16:25:27.119737
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.129344	2025-06-29 16:25:27.129344
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.139729	2025-06-29 16:25:27.139729
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.155083	2025-06-29 16:25:27.155083
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.166401	2025-06-29 16:25:27.166401
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.180903	2025-06-29 16:25:27.180903
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.19163	2025-06-29 16:25:27.19163
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.202303	2025-06-29 16:25:27.202303
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.216313	2025-06-29 16:25:27.216313
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.227483	2025-06-29 16:25:27.227483
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.239365	2025-06-29 16:25:27.239365
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.250862	2025-06-29 16:25:27.250862
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.261872	2025-06-29 16:25:27.261872
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.278597	2025-06-29 16:25:27.278597
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.292594	2025-06-29 16:25:27.292594
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.305053	2025-06-29 16:25:27.305053
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.31625	2025-06-29 16:25:27.31625
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.329222	2025-06-29 16:25:27.329222
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.340047	2025-06-29 16:25:27.340047
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.350617	2025-06-29 16:25:27.350617
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.361975	2025-06-29 16:25:27.361975
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.374908	2025-06-29 16:25:27.374908
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.386464	2025-06-29 16:25:27.386464
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.398098	2025-06-29 16:25:27.398098
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.409324	2025-06-29 16:25:27.409324
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.424659	2025-06-29 16:25:27.424659
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.436073	2025-06-29 16:25:27.436073
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.447667	2025-06-29 16:25:27.447667
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.46247	2025-06-29 16:25:27.46247
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.479016	2025-06-29 16:25:27.479016
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.498757	2025-06-29 16:25:27.498757
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.518316	2025-06-29 16:25:27.518316
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.529319	2025-06-29 16:25:27.529319
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.53989	2025-06-29 16:25:27.53989
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.550223	2025-06-29 16:25:27.550223
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.563795	2025-06-29 16:25:27.563795
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.573287	2025-06-29 16:25:27.573287
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.589539	2025-06-29 16:25:27.589539
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.598511	2025-06-29 16:25:27.598511
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.61043	2025-06-29 16:25:27.61043
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.622792	2025-06-29 16:25:27.622792
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.642088	2025-06-29 16:25:27.642088
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.654481	2025-06-29 16:25:27.654481
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.666105	2025-06-29 16:25:27.666105
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.678145	2025-06-29 16:25:27.678145
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.688052	2025-06-29 16:25:27.688052
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.698107	2025-06-29 16:25:27.698107
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.716466	2025-06-29 16:25:27.716466
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.731164	2025-06-29 16:25:27.731164
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.743375	2025-06-29 16:25:27.743375
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.755505	2025-06-29 16:25:27.755505
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.766911	2025-06-29 16:25:27.766911
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.778685	2025-06-29 16:25:27.778685
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.791009	2025-06-29 16:25:27.791009
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.803609	2025-06-29 16:25:27.803609
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.815486	2025-06-29 16:25:27.815486
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.825001	2025-06-29 16:25:27.825001
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.840735	2025-06-29 16:25:27.840735
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.859989	2025-06-29 16:25:27.859989
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.87102	2025-06-29 16:25:27.87102
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.882999	2025-06-29 16:25:27.882999
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.895497	2025-06-29 16:25:27.895497
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.913897	2025-06-29 16:25:27.913897
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.926217	2025-06-29 16:25:27.926217
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.938623	2025-06-29 16:25:27.938623
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.949283	2025-06-29 16:25:27.949283
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.959957	2025-06-29 16:25:27.959957
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.973815	2025-06-29 16:25:27.973815
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:27.988279	2025-06-29 16:25:27.988279
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.000312	2025-06-29 16:25:28.000312
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.01115	2025-06-29 16:25:28.01115
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.025765	2025-06-29 16:25:28.025765
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.038217	2025-06-29 16:25:28.038217
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.055891	2025-06-29 16:25:28.055891
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.066873	2025-06-29 16:25:28.066873
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.079829	2025-06-29 16:25:28.079829
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.095295	2025-06-29 16:25:28.095295
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.107617	2025-06-29 16:25:28.107617
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.118945	2025-06-29 16:25:28.118945
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.133053	2025-06-29 16:25:28.133053
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.147078	2025-06-29 16:25:28.147078
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.161994	2025-06-29 16:25:28.161994
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.171822	2025-06-29 16:25:28.171822
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.183189	2025-06-29 16:25:28.183189
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.198924	2025-06-29 16:25:28.198924
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.216699	2025-06-29 16:25:28.216699
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.230474	2025-06-29 16:25:28.230474
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.246633	2025-06-29 16:25:28.246633
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.260416	2025-06-29 16:25:28.260416
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.273634	2025-06-29 16:25:28.273634
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.285919	2025-06-29 16:25:28.285919
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.302696	2025-06-29 16:25:28.302696
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.31326	2025-06-29 16:25:28.31326
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.323465	2025-06-29 16:25:28.323465
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.335191	2025-06-29 16:25:28.335191
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.346488	2025-06-29 16:25:28.346488
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.357681	2025-06-29 16:25:28.357681
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.372949	2025-06-29 16:25:28.372949
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.383182	2025-06-29 16:25:28.383182
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.393435	2025-06-29 16:25:28.393435
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.403483	2025-06-29 16:25:28.403483
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.414662	2025-06-29 16:25:28.414662
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.425972	2025-06-29 16:25:28.425972
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.441255	2025-06-29 16:25:28.441255
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.455286	2025-06-29 16:25:28.455286
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.466793	2025-06-29 16:25:28.466793
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.479625	2025-06-29 16:25:28.479625
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.49324	2025-06-29 16:25:28.49324
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.508782	2025-06-29 16:25:28.508782
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.547725	2025-06-29 16:25:28.547725
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.575854	2025-06-29 16:25:28.575854
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.585667	2025-06-29 16:25:28.585667
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.597333	2025-06-29 16:25:28.597333
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.607497	2025-06-29 16:25:28.607497
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.619405	2025-06-29 16:25:28.619405
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.634241	2025-06-29 16:25:28.634241
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.654982	2025-06-29 16:25:28.654982
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.668486	2025-06-29 16:25:28.668486
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.686551	2025-06-29 16:25:28.686551
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.698622	2025-06-29 16:25:28.698622
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.710204	2025-06-29 16:25:28.710204
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.724859	2025-06-29 16:25:28.724859
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.736719	2025-06-29 16:25:28.736719
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.749516	2025-06-29 16:25:28.749516
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.760598	2025-06-29 16:25:28.760598
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.774196	2025-06-29 16:25:28.774196
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.787505	2025-06-29 16:25:28.787505
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.803888	2025-06-29 16:25:28.803888
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.815766	2025-06-29 16:25:28.815766
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.82637	2025-06-29 16:25:28.82637
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.839332	2025-06-29 16:25:28.839332
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.851049	2025-06-29 16:25:28.851049
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.86353	2025-06-29 16:25:28.86353
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.87458	2025-06-29 16:25:28.87458
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.884154	2025-06-29 16:25:28.884154
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.895726	2025-06-29 16:25:28.895726
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.906152	2025-06-29 16:25:28.906152
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.918133	2025-06-29 16:25:28.918133
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.928918	2025-06-29 16:25:28.928918
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.942573	2025-06-29 16:25:28.942573
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.957392	2025-06-29 16:25:28.957392
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.970563	2025-06-29 16:25:28.970563
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.980553	2025-06-29 16:25:28.980553
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:28.99379	2025-06-29 16:25:28.99379
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.007254	2025-06-29 16:25:29.007254
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.019081	2025-06-29 16:25:29.019081
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.031658	2025-06-29 16:25:29.031658
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.047216	2025-06-29 16:25:29.047216
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.057959	2025-06-29 16:25:29.057959
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.068364	2025-06-29 16:25:29.068364
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.084824	2025-06-29 16:25:29.084824
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.100575	2025-06-29 16:25:29.100575
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.111497	2025-06-29 16:25:29.111497
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.124458	2025-06-29 16:25:29.124458
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.141897	2025-06-29 16:25:29.141897
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.166383	2025-06-29 16:25:29.166383
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.181912	2025-06-29 16:25:29.181912
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.200031	2025-06-29 16:25:29.200031
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.22059	2025-06-29 16:25:29.22059
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.242084	2025-06-29 16:25:29.242084
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.26083	2025-06-29 16:25:29.26083
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.277734	2025-06-29 16:25:29.277734
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.312432	2025-06-29 16:25:29.312432
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.338416	2025-06-29 16:25:29.338416
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.360096	2025-06-29 16:25:29.360096
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.373135	2025-06-29 16:25:29.373135
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.392639	2025-06-29 16:25:29.392639
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.410452	2025-06-29 16:25:29.410452
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.425791	2025-06-29 16:25:29.425791
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.4401	2025-06-29 16:25:29.4401
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.451883	2025-06-29 16:25:29.451883
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.466311	2025-06-29 16:25:29.466311
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.47873	2025-06-29 16:25:29.47873
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.491085	2025-06-29 16:25:29.491085
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.503353	2025-06-29 16:25:29.503353
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.533494	2025-06-29 16:25:29.533494
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.555678	2025-06-29 16:25:29.555678
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.576895	2025-06-29 16:25:29.576895
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.592842	2025-06-29 16:25:29.592842
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.605545	2025-06-29 16:25:29.605545
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.624153	2025-06-29 16:25:29.624153
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.641976	2025-06-29 16:25:29.641976
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.659527	2025-06-29 16:25:29.659527
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.67343	2025-06-29 16:25:29.67343
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.688056	2025-06-29 16:25:29.688056
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.701937	2025-06-29 16:25:29.701937
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.713682	2025-06-29 16:25:29.713682
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.726226	2025-06-29 16:25:29.726226
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.740059	2025-06-29 16:25:29.740059
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.754832	2025-06-29 16:25:29.754832
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.770047	2025-06-29 16:25:29.770047
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.803571	2025-06-29 16:25:29.803571
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.815164	2025-06-29 16:25:29.815164
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.826377	2025-06-29 16:25:29.826377
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.845408	2025-06-29 16:25:29.845408
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.856838	2025-06-29 16:25:29.856838
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.869348	2025-06-29 16:25:29.869348
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.878789	2025-06-29 16:25:29.878789
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.890727	2025-06-29 16:25:29.890727
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.901848	2025-06-29 16:25:29.901848
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.912388	2025-06-29 16:25:29.912388
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.923997	2025-06-29 16:25:29.923997
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.935731	2025-06-29 16:25:29.935731
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.947801	2025-06-29 16:25:29.947801
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.961612	2025-06-29 16:25:29.961612
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.97192	2025-06-29 16:25:29.97192
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:29.988623	2025-06-29 16:25:29.988623
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.003652	2025-06-29 16:25:30.003652
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.014911	2025-06-29 16:25:30.014911
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.030818	2025-06-29 16:25:30.030818
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.045128	2025-06-29 16:25:30.045128
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.057772	2025-06-29 16:25:30.057772
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.069092	2025-06-29 16:25:30.069092
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.082525	2025-06-29 16:25:30.082525
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 16:25:30.095542	2025-06-29 16:25:30.095542
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.106969	2025-06-29 16:25:30.106969
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.120213	2025-06-29 16:25:30.120213
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.130335	2025-06-29 16:25:30.130335
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.146681	2025-06-29 16:25:30.146681
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.16158	2025-06-29 16:25:30.16158
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.174538	2025-06-29 16:25:30.174538
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.189709	2025-06-29 16:25:30.189709
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.200854	2025-06-29 16:25:30.200854
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.21423	2025-06-29 16:25:30.21423
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.226117	2025-06-29 16:25:30.226117
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.238109	2025-06-29 16:25:30.238109
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.249529	2025-06-29 16:25:30.249529
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.26395	2025-06-29 16:25:30.26395
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.27843	2025-06-29 16:25:30.27843
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.288866	2025-06-29 16:25:30.288866
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.302212	2025-06-29 16:25:30.302212
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.314641	2025-06-29 16:25:30.314641
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.325415	2025-06-29 16:25:30.325415
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.334901	2025-06-29 16:25:30.334901
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.3445	2025-06-29 16:25:30.3445
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.355701	2025-06-29 16:25:30.355701
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.365761	2025-06-29 16:25:30.365761
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.379773	2025-06-29 16:25:30.379773
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.390675	2025-06-29 16:25:30.390675
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.402591	2025-06-29 16:25:30.402591
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.411169	2025-06-29 16:25:30.411169
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.418539	2025-06-29 16:25:30.418539
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.426113	2025-06-29 16:25:30.426113
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.434604	2025-06-29 16:25:30.434604
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.442566	2025-06-29 16:25:30.442566
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.450108	2025-06-29 16:25:30.450108
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.457344	2025-06-29 16:25:30.457344
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.463696	2025-06-29 16:25:30.463696
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.473813	2025-06-29 16:25:30.473813
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.481213	2025-06-29 16:25:30.481213
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.487983	2025-06-29 16:25:30.487983
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.494149	2025-06-29 16:25:30.494149
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.501509	2025-06-29 16:25:30.501509
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.509777	2025-06-29 16:25:30.509777
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.517659	2025-06-29 16:25:30.517659
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.525785	2025-06-29 16:25:30.525785
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.534467	2025-06-29 16:25:30.534467
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.542537	2025-06-29 16:25:30.542537
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.549139	2025-06-29 16:25:30.549139
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.555664	2025-06-29 16:25:30.555664
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.562951	2025-06-29 16:25:30.562951
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.569218	2025-06-29 16:25:30.569218
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.576422	2025-06-29 16:25:30.576422
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.584573	2025-06-29 16:25:30.584573
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.591986	2025-06-29 16:25:30.591986
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.598566	2025-06-29 16:25:30.598566
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.605078	2025-06-29 16:25:30.605078
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.613857	2025-06-29 16:25:30.613857
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.620225	2025-06-29 16:25:30.620225
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.627614	2025-06-29 16:25:30.627614
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.636259	2025-06-29 16:25:30.636259
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.642443	2025-06-29 16:25:30.642443
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.649119	2025-06-29 16:25:30.649119
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.655657	2025-06-29 16:25:30.655657
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.661792	2025-06-29 16:25:30.661792
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.668737	2025-06-29 16:25:30.668737
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.675961	2025-06-29 16:25:30.675961
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.68655	2025-06-29 16:25:30.68655
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.893705	2025-06-29 16:25:30.893705
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.962785	2025-06-29 16:25:30.962785
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.987786	2025-06-29 16:25:30.987786
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:30.99775	2025-06-29 16:25:30.99775
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.012794	2025-06-29 16:25:31.012794
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.023443	2025-06-29 16:25:31.023443
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.03111	2025-06-29 16:25:31.03111
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.044492	2025-06-29 16:25:31.044492
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.059035	2025-06-29 16:25:31.059035
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.066491	2025-06-29 16:25:31.066491
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.075076	2025-06-29 16:25:31.075076
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.084585	2025-06-29 16:25:31.084585
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.092615	2025-06-29 16:25:31.092615
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.097886	2025-06-29 16:25:31.097886
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.102936	2025-06-29 16:25:31.102936
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.118312	2025-06-29 16:25:31.118312
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.124747	2025-06-29 16:25:31.124747
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.13531	2025-06-29 16:25:31.13531
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.142467	2025-06-29 16:25:31.142467
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.147315	2025-06-29 16:25:31.147315
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.15406	2025-06-29 16:25:31.15406
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.164883	2025-06-29 16:25:31.164883
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.173296	2025-06-29 16:25:31.173296
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.183643	2025-06-29 16:25:31.183643
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.191495	2025-06-29 16:25:31.191495
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.194449	2025-06-29 16:25:31.194449
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.199241	2025-06-29 16:25:31.199241
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.206826	2025-06-29 16:25:31.206826
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.214243	2025-06-29 16:25:31.214243
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.223558	2025-06-29 16:25:31.223558
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.228427	2025-06-29 16:25:31.228427
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.233347	2025-06-29 16:25:31.233347
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.241511	2025-06-29 16:25:31.241511
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.24885	2025-06-29 16:25:31.24885
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.254361	2025-06-29 16:25:31.254361
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.267407	2025-06-29 16:25:31.267407
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.274899	2025-06-29 16:25:31.274899
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.287567	2025-06-29 16:25:31.287567
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.293078	2025-06-29 16:25:31.293078
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.300094	2025-06-29 16:25:31.300094
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.305696	2025-06-29 16:25:31.305696
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.308935	2025-06-29 16:25:31.308935
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.313665	2025-06-29 16:25:31.313665
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.319847	2025-06-29 16:25:31.319847
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.3269	2025-06-29 16:25:31.3269
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.332129	2025-06-29 16:25:31.332129
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.341403	2025-06-29 16:25:31.341403
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.351087	2025-06-29 16:25:31.351087
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.361419	2025-06-29 16:25:31.361419
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.366882	2025-06-29 16:25:31.366882
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.371962	2025-06-29 16:25:31.371962
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.381719	2025-06-29 16:25:31.381719
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.391417	2025-06-29 16:25:31.391417
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.400204	2025-06-29 16:25:31.400204
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.414443	2025-06-29 16:25:31.414443
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.419289	2025-06-29 16:25:31.419289
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.429717	2025-06-29 16:25:31.429717
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.44067	2025-06-29 16:25:31.44067
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.443971	2025-06-29 16:25:31.443971
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.453465	2025-06-29 16:25:31.453465
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.463679	2025-06-29 16:25:31.463679
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.474109	2025-06-29 16:25:31.474109
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.48361	2025-06-29 16:25:31.48361
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.494125	2025-06-29 16:25:31.494125
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.507799	2025-06-29 16:25:31.507799
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.516832	2025-06-29 16:25:31.516832
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.528484	2025-06-29 16:25:31.528484
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.540878	2025-06-29 16:25:31.540878
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.549387	2025-06-29 16:25:31.549387
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.560179	2025-06-29 16:25:31.560179
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.570292	2025-06-29 16:25:31.570292
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.580617	2025-06-29 16:25:31.580617
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.591924	2025-06-29 16:25:31.591924
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.603504	2025-06-29 16:25:31.603504
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.610617	2025-06-29 16:25:31.610617
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.61585	2025-06-29 16:25:31.61585
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.622199	2025-06-29 16:25:31.622199
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.629336	2025-06-29 16:25:31.629336
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.63268	2025-06-29 16:25:31.63268
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.638804	2025-06-29 16:25:31.638804
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.649299	2025-06-29 16:25:31.649299
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.655779	2025-06-29 16:25:31.655779
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.659409	2025-06-29 16:25:31.659409
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.664696	2025-06-29 16:25:31.664696
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.669828	2025-06-29 16:25:31.669828
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.674688	2025-06-29 16:25:31.674688
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.683796	2025-06-29 16:25:31.683796
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.689367	2025-06-29 16:25:31.689367
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.697096	2025-06-29 16:25:31.697096
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.708138	2025-06-29 16:25:31.708138
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.719035	2025-06-29 16:25:31.719035
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.724223	2025-06-29 16:25:31.724223
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.731658	2025-06-29 16:25:31.731658
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.739321	2025-06-29 16:25:31.739321
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.744568	2025-06-29 16:25:31.744568
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.751164	2025-06-29 16:25:31.751164
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.754486	2025-06-29 16:25:31.754486
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.766525	2025-06-29 16:25:31.766525
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.772824	2025-06-29 16:25:31.772824
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.779409	2025-06-29 16:25:31.779409
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.806028	2025-06-29 16:25:31.806028
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.813741	2025-06-29 16:25:31.813741
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.820859	2025-06-29 16:25:31.820859
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.830226	2025-06-29 16:25:31.830226
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.835514	2025-06-29 16:25:31.835514
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.84085	2025-06-29 16:25:31.84085
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.849215	2025-06-29 16:25:31.849215
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.856935	2025-06-29 16:25:31.856935
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.860155	2025-06-29 16:25:31.860155
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.86562	2025-06-29 16:25:31.86562
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.87849	2025-06-29 16:25:31.87849
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.883083	2025-06-29 16:25:31.883083
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.891348	2025-06-29 16:25:31.891348
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.896242	2025-06-29 16:25:31.896242
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.901509	2025-06-29 16:25:31.901509
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.906782	2025-06-29 16:25:31.906782
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.912598	2025-06-29 16:25:31.912598
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.918617	2025-06-29 16:25:31.918617
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.940714	2025-06-29 16:25:31.940714
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.945925	2025-06-29 16:25:31.945925
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.951528	2025-06-29 16:25:31.951528
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.957046	2025-06-29 16:25:31.957046
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.985739	2025-06-29 16:25:31.985739
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:31.993528	2025-06-29 16:25:31.993528
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.006289	2025-06-29 16:25:32.006289
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.016502	2025-06-29 16:25:32.016502
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.037989	2025-06-29 16:25:32.037989
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.047124	2025-06-29 16:25:32.047124
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.071737	2025-06-29 16:25:32.071737
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.087943	2025-06-29 16:25:32.087943
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.094141	2025-06-29 16:25:32.094141
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.099889	2025-06-29 16:25:32.099889
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.104892	2025-06-29 16:25:32.104892
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.112719	2025-06-29 16:25:32.112719
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.122567	2025-06-29 16:25:32.122567
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.164489	2025-06-29 16:25:32.164489
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.167898	2025-06-29 16:25:32.167898
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.17379	2025-06-29 16:25:32.17379
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.218408	2025-06-29 16:25:32.218408
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.227215	2025-06-29 16:25:32.227215
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.2366	2025-06-29 16:25:32.2366
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.262947	2025-06-29 16:25:32.262947
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.282323	2025-06-29 16:25:32.282323
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.291653	2025-06-29 16:25:32.291653
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.308635	2025-06-29 16:25:32.308635
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.312175	2025-06-29 16:25:32.312175
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.32603	2025-06-29 16:25:32.32603
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.341357	2025-06-29 16:25:32.341357
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.358162	2025-06-29 16:25:32.358162
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.36493	2025-06-29 16:25:32.36493
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.39108	2025-06-29 16:25:32.39108
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.397666	2025-06-29 16:25:32.397666
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.411367	2025-06-29 16:25:32.411367
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.418497	2025-06-29 16:25:32.418497
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.424439	2025-06-29 16:25:32.424439
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.438532	2025-06-29 16:25:32.438532
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.443262	2025-06-29 16:25:32.443262
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.464701	2025-06-29 16:25:32.464701
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.469613	2025-06-29 16:25:32.469613
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.473103	2025-06-29 16:25:32.473103
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.478565	2025-06-29 16:25:32.478565
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.496292	2025-06-29 16:25:32.496292
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.502204	2025-06-29 16:25:32.502204
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.507595	2025-06-29 16:25:32.507595
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.527283	2025-06-29 16:25:32.527283
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.533254	2025-06-29 16:25:32.533254
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.540415	2025-06-29 16:25:32.540415
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.55947	2025-06-29 16:25:32.55947
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.565223	2025-06-29 16:25:32.565223
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.570781	2025-06-29 16:25:32.570781
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.581005	2025-06-29 16:25:32.581005
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.590062	2025-06-29 16:25:32.590062
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.594833	2025-06-29 16:25:32.594833
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.611512	2025-06-29 16:25:32.611512
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.61856	2025-06-29 16:25:32.61856
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.624747	2025-06-29 16:25:32.624747
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.63035	2025-06-29 16:25:32.63035
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.635577	2025-06-29 16:25:32.635577
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.646824	2025-06-29 16:25:32.646824
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.655399	2025-06-29 16:25:32.655399
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.665687	2025-06-29 16:25:32.665687
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.673684	2025-06-29 16:25:32.673684
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.679111	2025-06-29 16:25:32.679111
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.683827	2025-06-29 16:25:32.683827
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.687725	2025-06-29 16:25:32.687725
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.693074	2025-06-29 16:25:32.693074
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.700991	2025-06-29 16:25:32.700991
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.705912	2025-06-29 16:25:32.705912
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.712371	2025-06-29 16:25:32.712371
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.717787	2025-06-29 16:25:32.717787
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.729486	2025-06-29 16:25:32.729486
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.737245	2025-06-29 16:25:32.737245
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.748584	2025-06-29 16:25:32.748584
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.753377	2025-06-29 16:25:32.753377
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.763054	2025-06-29 16:25:32.763054
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.766107	2025-06-29 16:25:32.766107
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.771255	2025-06-29 16:25:32.771255
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.779096	2025-06-29 16:25:32.779096
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.78199	2025-06-29 16:25:32.78199
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.786541	2025-06-29 16:25:32.786541
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.790295	2025-06-29 16:25:32.790295
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.794964	2025-06-29 16:25:32.794964
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.803806	2025-06-29 16:25:32.803806
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.808837	2025-06-29 16:25:32.808837
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.811601	2025-06-29 16:25:32.811601
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.816731	2025-06-29 16:25:32.816731
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.819511	2025-06-29 16:25:32.819511
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.828932	2025-06-29 16:25:32.828932
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.831862	2025-06-29 16:25:32.831862
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.836403	2025-06-29 16:25:32.836403
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.841568	2025-06-29 16:25:32.841568
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.84986	2025-06-29 16:25:32.84986
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.854667	2025-06-29 16:25:32.854667
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.859797	2025-06-29 16:25:32.859797
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.865799	2025-06-29 16:25:32.865799
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.868792	2025-06-29 16:25:32.868792
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.873469	2025-06-29 16:25:32.873469
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.880283	2025-06-29 16:25:32.880283
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.885996	2025-06-29 16:25:32.885996
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.890971	2025-06-29 16:25:32.890971
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.898622	2025-06-29 16:25:32.898622
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.903751	2025-06-29 16:25:32.903751
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.908429	2025-06-29 16:25:32.908429
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.914065	2025-06-29 16:25:32.914065
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.919806	2025-06-29 16:25:32.919806
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.930209	2025-06-29 16:25:32.930209
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.933334	2025-06-29 16:25:32.933334
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.939148	2025-06-29 16:25:32.939148
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.945012	2025-06-29 16:25:32.945012
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.95025	2025-06-29 16:25:32.95025
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.957892	2025-06-29 16:25:32.957892
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.964613	2025-06-29 16:25:32.964613
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.969922	2025-06-29 16:25:32.969922
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.975039	2025-06-29 16:25:32.975039
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.980468	2025-06-29 16:25:32.980468
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.98333	2025-06-29 16:25:32.98333
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.991967	2025-06-29 16:25:32.991967
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:32.997151	2025-06-29 16:25:32.997151
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.004432	2025-06-29 16:25:33.004432
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.009472	2025-06-29 16:25:33.009472
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.014594	2025-06-29 16:25:33.014594
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.017825	2025-06-29 16:25:33.017825
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.029109	2025-06-29 16:25:33.029109
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.037876	2025-06-29 16:25:33.037876
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.043038	2025-06-29 16:25:33.043038
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.048429	2025-06-29 16:25:33.048429
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.053124	2025-06-29 16:25:33.053124
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.058807	2025-06-29 16:25:33.058807
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.06172	2025-06-29 16:25:33.06172
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.068171	2025-06-29 16:25:33.068171
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.076534	2025-06-29 16:25:33.076534
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.081461	2025-06-29 16:25:33.081461
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.090795	2025-06-29 16:25:33.090795
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.100779	2025-06-29 16:25:33.100779
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.107402	2025-06-29 16:25:33.107402
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.114113	2025-06-29 16:25:33.114113
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.121217	2025-06-29 16:25:33.121217
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.128947	2025-06-29 16:25:33.128947
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.133195	2025-06-29 16:25:33.133195
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.152694	2025-06-29 16:25:33.152694
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.161278	2025-06-29 16:25:33.161278
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.164185	2025-06-29 16:25:33.164185
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.172627	2025-06-29 16:25:33.172627
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.178176	2025-06-29 16:25:33.178176
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.182427	2025-06-29 16:25:33.182427
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.187292	2025-06-29 16:25:33.187292
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.19276	2025-06-29 16:25:33.19276
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.205021	2025-06-29 16:25:33.205021
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.210326	2025-06-29 16:25:33.210326
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.226604	2025-06-29 16:25:33.226604
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.23228	2025-06-29 16:25:33.23228
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.235097	2025-06-29 16:25:33.235097
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.245292	2025-06-29 16:25:33.245292
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.252341	2025-06-29 16:25:33.252341
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.25803	2025-06-29 16:25:33.25803
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.2638	2025-06-29 16:25:33.2638
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.270843	2025-06-29 16:25:33.270843
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.278756	2025-06-29 16:25:33.278756
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.284256	2025-06-29 16:25:33.284256
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.29253	2025-06-29 16:25:33.29253
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.299444	2025-06-29 16:25:33.299444
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.308846	2025-06-29 16:25:33.308846
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.318707	2025-06-29 16:25:33.318707
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.323386	2025-06-29 16:25:33.323386
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.328814	2025-06-29 16:25:33.328814
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.334388	2025-06-29 16:25:33.334388
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.339657	2025-06-29 16:25:33.339657
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.355659	2025-06-29 16:25:33.355659
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.361129	2025-06-29 16:25:33.361129
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.365993	2025-06-29 16:25:33.365993
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.371528	2025-06-29 16:25:33.371528
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.378473	2025-06-29 16:25:33.378473
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.387464	2025-06-29 16:25:33.387464
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.399015	2025-06-29 16:25:33.399015
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.41268	2025-06-29 16:25:33.41268
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.427537	2025-06-29 16:25:33.427537
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.43565	2025-06-29 16:25:33.43565
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.477135	2025-06-29 16:25:33.477135
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.480311	2025-06-29 16:25:33.480311
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.486073	2025-06-29 16:25:33.486073
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.530739	2025-06-29 16:25:33.530739
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.536544	2025-06-29 16:25:33.536544
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.575432	2025-06-29 16:25:33.575432
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.581805	2025-06-29 16:25:33.581805
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.585434	2025-06-29 16:25:33.585434
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.624565	2025-06-29 16:25:33.624565
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.62981	2025-06-29 16:25:33.62981
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.668712	2025-06-29 16:25:33.668712
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.676734	2025-06-29 16:25:33.676734
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.682408	2025-06-29 16:25:33.682408
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.68732	2025-06-29 16:25:33.68732
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.693554	2025-06-29 16:25:33.693554
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.704864	2025-06-29 16:25:33.704864
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.709736	2025-06-29 16:25:33.709736
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.718153	2025-06-29 16:25:33.718153
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.726333	2025-06-29 16:25:33.726333
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.770677	2025-06-29 16:25:33.770677
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.795541	2025-06-29 16:25:33.795541
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.808014	2025-06-29 16:25:33.808014
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.819833	2025-06-29 16:25:33.819833
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.828506	2025-06-29 16:25:33.828506
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.833403	2025-06-29 16:25:33.833403
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.838665	2025-06-29 16:25:33.838665
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.850038	2025-06-29 16:25:33.850038
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.855522	2025-06-29 16:25:33.855522
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.865774	2025-06-29 16:25:33.865774
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.871512	2025-06-29 16:25:33.871512
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.87674	2025-06-29 16:25:33.87674
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.886868	2025-06-29 16:25:33.886868
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.893739	2025-06-29 16:25:33.893739
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.911213	2025-06-29 16:25:33.911213
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.915869	2025-06-29 16:25:33.915869
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.923194	2025-06-29 16:25:33.923194
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.931901	2025-06-29 16:25:33.931901
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.939099	2025-06-29 16:25:33.939099
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.946602	2025-06-29 16:25:33.946602
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.953827	2025-06-29 16:25:33.953827
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.958426	2025-06-29 16:25:33.958426
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.965805	2025-06-29 16:25:33.965805
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.971199	2025-06-29 16:25:33.971199
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.97939	2025-06-29 16:25:33.97939
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.989774	2025-06-29 16:25:33.989774
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:33.996925	2025-06-29 16:25:33.996925
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.005486	2025-06-29 16:25:34.005486
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.014112	2025-06-29 16:25:34.014112
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.021674	2025-06-29 16:25:34.021674
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.028191	2025-06-29 16:25:34.028191
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.033058	2025-06-29 16:25:34.033058
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.039666	2025-06-29 16:25:34.039666
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.046581	2025-06-29 16:25:34.046581
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.054641	2025-06-29 16:25:34.054641
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.062806	2025-06-29 16:25:34.062806
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.069779	2025-06-29 16:25:34.069779
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.083841	2025-06-29 16:25:34.083841
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.088379	2025-06-29 16:25:34.088379
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.095183	2025-06-29 16:25:34.095183
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.102845	2025-06-29 16:25:34.102845
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.107711	2025-06-29 16:25:34.107711
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.112902	2025-06-29 16:25:34.112902
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.123621	2025-06-29 16:25:34.123621
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.126854	2025-06-29 16:25:34.126854
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.135623	2025-06-29 16:25:34.135623
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.140048	2025-06-29 16:25:34.140048
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.145434	2025-06-29 16:25:34.145434
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.152515	2025-06-29 16:25:34.152515
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.160954	2025-06-29 16:25:34.160954
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.165694	2025-06-29 16:25:34.165694
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.170839	2025-06-29 16:25:34.170839
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.174666	2025-06-29 16:25:34.174666
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.179271	2025-06-29 16:25:34.179271
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.184454	2025-06-29 16:25:34.184454
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.191052	2025-06-29 16:25:34.191052
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.199105	2025-06-29 16:25:34.199105
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.20715	2025-06-29 16:25:34.20715
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.21694	2025-06-29 16:25:34.21694
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.223651	2025-06-29 16:25:34.223651
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.230403	2025-06-29 16:25:34.230403
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.239187	2025-06-29 16:25:34.239187
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.247058	2025-06-29 16:25:34.247058
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.251865	2025-06-29 16:25:34.251865
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.258728	2025-06-29 16:25:34.258728
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.263431	2025-06-29 16:25:34.263431
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.268727	2025-06-29 16:25:34.268727
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.277824	2025-06-29 16:25:34.277824
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.282983	2025-06-29 16:25:34.282983
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.288714	2025-06-29 16:25:34.288714
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.295576	2025-06-29 16:25:34.295576
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.300782	2025-06-29 16:25:34.300782
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.306538	2025-06-29 16:25:34.306538
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.309591	2025-06-29 16:25:34.309591
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.314613	2025-06-29 16:25:34.314613
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.327318	2025-06-29 16:25:34.327318
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.331625	2025-06-29 16:25:34.331625
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.338972	2025-06-29 16:25:34.338972
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.345675	2025-06-29 16:25:34.345675
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.356994	2025-06-29 16:25:34.356994
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.366223	2025-06-29 16:25:34.366223
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.373219	2025-06-29 16:25:34.373219
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.380815	2025-06-29 16:25:34.380815
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.38603	2025-06-29 16:25:34.38603
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.390208	2025-06-29 16:25:34.390208
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.394917	2025-06-29 16:25:34.394917
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.401716	2025-06-29 16:25:34.401716
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.408924	2025-06-29 16:25:34.408924
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.417461	2025-06-29 16:25:34.417461
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.420265	2025-06-29 16:25:34.420265
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.430209	2025-06-29 16:25:34.430209
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.433273	2025-06-29 16:25:34.433273
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.438036	2025-06-29 16:25:34.438036
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.445371	2025-06-29 16:25:34.445371
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.457452	2025-06-29 16:25:34.457452
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.468311	2025-06-29 16:25:34.468311
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.479424	2025-06-29 16:25:34.479424
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.484919	2025-06-29 16:25:34.484919
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.503853	2025-06-29 16:25:34.503853
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.509259	2025-06-29 16:25:34.509259
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.515141	2025-06-29 16:25:34.515141
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.525935	2025-06-29 16:25:34.525935
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.531647	2025-06-29 16:25:34.531647
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.536619	2025-06-29 16:25:34.536619
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.545245	2025-06-29 16:25:34.545245
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.550127	2025-06-29 16:25:34.550127
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.561846	2025-06-29 16:25:34.561846
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.565388	2025-06-29 16:25:34.565388
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.57018	2025-06-29 16:25:34.57018
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.580623	2025-06-29 16:25:34.580623
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.586279	2025-06-29 16:25:34.586279
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.591234	2025-06-29 16:25:34.591234
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.597699	2025-06-29 16:25:34.597699
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.610316	2025-06-29 16:25:34.610316
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.61745	2025-06-29 16:25:34.61745
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.627492	2025-06-29 16:25:34.627492
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.635205	2025-06-29 16:25:34.635205
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.641054	2025-06-29 16:25:34.641054
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.644546	2025-06-29 16:25:34.644546
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.655015	2025-06-29 16:25:34.655015
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.661241	2025-06-29 16:25:34.661241
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.66859	2025-06-29 16:25:34.66859
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.673815	2025-06-29 16:25:34.673815
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.67937	2025-06-29 16:25:34.67937
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.684097	2025-06-29 16:25:34.684097
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.689409	2025-06-29 16:25:34.689409
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.696136	2025-06-29 16:25:34.696136
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.703986	2025-06-29 16:25:34.703986
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.71043	2025-06-29 16:25:34.71043
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.71747	2025-06-29 16:25:34.71747
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.72314	2025-06-29 16:25:34.72314
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.730728	2025-06-29 16:25:34.730728
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.738657	2025-06-29 16:25:34.738657
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.74445	2025-06-29 16:25:34.74445
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.750129	2025-06-29 16:25:34.750129
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.788774	2025-06-29 16:25:34.788774
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.792791	2025-06-29 16:25:34.792791
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.804601	2025-06-29 16:25:34.804601
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.847479	2025-06-29 16:25:34.847479
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.853621	2025-06-29 16:25:34.853621
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.859087	2025-06-29 16:25:34.859087
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.864379	2025-06-29 16:25:34.864379
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.869661	2025-06-29 16:25:34.869661
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.875453	2025-06-29 16:25:34.875453
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.914504	2025-06-29 16:25:34.914504
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.926573	2025-06-29 16:25:34.926573
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.933454	2025-06-29 16:25:34.933454
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.972756	2025-06-29 16:25:34.972756
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:34.980478	2025-06-29 16:25:34.980478
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.021871	2025-06-29 16:25:35.021871
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.025252	2025-06-29 16:25:35.025252
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.028353	2025-06-29 16:25:35.028353
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.033678	2025-06-29 16:25:35.033678
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.041471	2025-06-29 16:25:35.041471
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.048477	2025-06-29 16:25:35.048477
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.087315	2025-06-29 16:25:35.087315
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.094403	2025-06-29 16:25:35.094403
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.104154	2025-06-29 16:25:35.104154
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.111408	2025-06-29 16:25:35.111408
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.114617	2025-06-29 16:25:35.114617
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.152831	2025-06-29 16:25:35.152831
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.159141	2025-06-29 16:25:35.159141
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.200455	2025-06-29 16:25:35.200455
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.211516	2025-06-29 16:25:35.211516
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.253142	2025-06-29 16:25:35.253142
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.263865	2025-06-29 16:25:35.263865
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.313454	2025-06-29 16:25:35.313454
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.325653	2025-06-29 16:25:35.325653
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.331796	2025-06-29 16:25:35.331796
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.33737	2025-06-29 16:25:35.33737
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.344993	2025-06-29 16:25:35.344993
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.359697	2025-06-29 16:25:35.359697
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.364745	2025-06-29 16:25:35.364745
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 16:25:35.376269	2025-06-29 16:25:35.376269
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.383094	2025-06-29 16:25:35.383094
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.390148	2025-06-29 16:25:35.390148
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.400924	2025-06-29 16:25:35.400924
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.403979	2025-06-29 16:25:35.403979
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.413355	2025-06-29 16:25:35.413355
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.418238	2025-06-29 16:25:35.418238
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.4229	2025-06-29 16:25:35.4229
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.429988	2025-06-29 16:25:35.429988
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.432865	2025-06-29 16:25:35.432865
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.439939	2025-06-29 16:25:35.439939
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.446575	2025-06-29 16:25:35.446575
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.454501	2025-06-29 16:25:35.454501
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.461033	2025-06-29 16:25:35.461033
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.466982	2025-06-29 16:25:35.466982
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.474242	2025-06-29 16:25:35.474242
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.486986	2025-06-29 16:25:35.486986
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.49275	2025-06-29 16:25:35.49275
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.498088	2025-06-29 16:25:35.498088
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.51261	2025-06-29 16:25:35.51261
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.51943	2025-06-29 16:25:35.51943
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.527981	2025-06-29 16:25:35.527981
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.543512	2025-06-29 16:25:35.543512
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.563473	2025-06-29 16:25:35.563473
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.568704	2025-06-29 16:25:35.568704
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.573419	2025-06-29 16:25:35.573419
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.578585	2025-06-29 16:25:35.578585
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.58881	2025-06-29 16:25:35.58881
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.605968	2025-06-29 16:25:35.605968
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.610269	2025-06-29 16:25:35.610269
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.615442	2025-06-29 16:25:35.615442
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.621397	2025-06-29 16:25:35.621397
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.627494	2025-06-29 16:25:35.627494
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.637335	2025-06-29 16:25:35.637335
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.643801	2025-06-29 16:25:35.643801
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.651035	2025-06-29 16:25:35.651035
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.654225	2025-06-29 16:25:35.654225
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.658779	2025-06-29 16:25:35.658779
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.661673	2025-06-29 16:25:35.661673
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.66823	2025-06-29 16:25:35.66823
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.675147	2025-06-29 16:25:35.675147
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.684548	2025-06-29 16:25:35.684548
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.691517	2025-06-29 16:25:35.691517
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.696622	2025-06-29 16:25:35.696622
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.701578	2025-06-29 16:25:35.701578
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.712602	2025-06-29 16:25:35.712602
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.718331	2025-06-29 16:25:35.718331
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.724069	2025-06-29 16:25:35.724069
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.730387	2025-06-29 16:25:35.730387
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.737708	2025-06-29 16:25:35.737708
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.747297	2025-06-29 16:25:35.747297
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.756121	2025-06-29 16:25:35.756121
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.761313	2025-06-29 16:25:35.761313
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.766592	2025-06-29 16:25:35.766592
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.774795	2025-06-29 16:25:35.774795
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.777871	2025-06-29 16:25:35.777871
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.784615	2025-06-29 16:25:35.784615
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.788653	2025-06-29 16:25:35.788653
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.795167	2025-06-29 16:25:35.795167
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.804486	2025-06-29 16:25:35.804486
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.810789	2025-06-29 16:25:35.810789
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.821325	2025-06-29 16:25:35.821325
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.824662	2025-06-29 16:25:35.824662
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.832165	2025-06-29 16:25:35.832165
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.838835	2025-06-29 16:25:35.838835
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.84496	2025-06-29 16:25:35.84496
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.855581	2025-06-29 16:25:35.855581
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.861193	2025-06-29 16:25:35.861193
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.866733	2025-06-29 16:25:35.866733
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.872122	2025-06-29 16:25:35.872122
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.875456	2025-06-29 16:25:35.875456
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.882243	2025-06-29 16:25:35.882243
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.887786	2025-06-29 16:25:35.887786
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.892905	2025-06-29 16:25:35.892905
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.901612	2025-06-29 16:25:35.901612
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.90815	2025-06-29 16:25:35.90815
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.915097	2025-06-29 16:25:35.915097
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.920616	2025-06-29 16:25:35.920616
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.927885	2025-06-29 16:25:35.927885
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.932883	2025-06-29 16:25:35.932883
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.936247	2025-06-29 16:25:35.936247
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.941541	2025-06-29 16:25:35.941541
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.946815	2025-06-29 16:25:35.946815
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.951649	2025-06-29 16:25:35.951649
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.959581	2025-06-29 16:25:35.959581
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.963523	2025-06-29 16:25:35.963523
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.975221	2025-06-29 16:25:35.975221
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.980262	2025-06-29 16:25:35.980262
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.987543	2025-06-29 16:25:35.987543
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:35.993752	2025-06-29 16:25:35.993752
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.000808	2025-06-29 16:25:36.000808
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.006581	2025-06-29 16:25:36.006581
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.011058	2025-06-29 16:25:36.011058
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.014286	2025-06-29 16:25:36.014286
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.021233	2025-06-29 16:25:36.021233
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.029447	2025-06-29 16:25:36.029447
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.037222	2025-06-29 16:25:36.037222
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.04282	2025-06-29 16:25:36.04282
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.048758	2025-06-29 16:25:36.048758
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.05643	2025-06-29 16:25:36.05643
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.061612	2025-06-29 16:25:36.061612
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.067273	2025-06-29 16:25:36.067273
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.072368	2025-06-29 16:25:36.072368
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.077852	2025-06-29 16:25:36.077852
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.085056	2025-06-29 16:25:36.085056
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.092072	2025-06-29 16:25:36.092072
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.097708	2025-06-29 16:25:36.097708
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.104498	2025-06-29 16:25:36.104498
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.110018	2025-06-29 16:25:36.110018
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.117323	2025-06-29 16:25:36.117323
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.124838	2025-06-29 16:25:36.124838
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.131798	2025-06-29 16:25:36.131798
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.14166	2025-06-29 16:25:36.14166
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.149003	2025-06-29 16:25:36.149003
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.156147	2025-06-29 16:25:36.156147
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.16698	2025-06-29 16:25:36.16698
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.177971	2025-06-29 16:25:36.177971
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.185191	2025-06-29 16:25:36.185191
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.19205	2025-06-29 16:25:36.19205
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.201624	2025-06-29 16:25:36.201624
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.210761	2025-06-29 16:25:36.210761
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.220295	2025-06-29 16:25:36.220295
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.230351	2025-06-29 16:25:36.230351
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.233318	2025-06-29 16:25:36.233318
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.243774	2025-06-29 16:25:36.243774
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.249249	2025-06-29 16:25:36.249249
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.257874	2025-06-29 16:25:36.257874
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.267135	2025-06-29 16:25:36.267135
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.276881	2025-06-29 16:25:36.276881
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.286051	2025-06-29 16:25:36.286051
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.289576	2025-06-29 16:25:36.289576
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.298922	2025-06-29 16:25:36.298922
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.307056	2025-06-29 16:25:36.307056
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.31916	2025-06-29 16:25:36.31916
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.330186	2025-06-29 16:25:36.330186
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.335245	2025-06-29 16:25:36.335245
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.345752	2025-06-29 16:25:36.345752
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.355204	2025-06-29 16:25:36.355204
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.364993	2025-06-29 16:25:36.364993
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.374339	2025-06-29 16:25:36.374339
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.385649	2025-06-29 16:25:36.385649
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.39637	2025-06-29 16:25:36.39637
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.399691	2025-06-29 16:25:36.399691
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.405854	2025-06-29 16:25:36.405854
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.411945	2025-06-29 16:25:36.411945
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.418227	2025-06-29 16:25:36.418227
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.429358	2025-06-29 16:25:36.429358
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.435665	2025-06-29 16:25:36.435665
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.446385	2025-06-29 16:25:36.446385
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.453891	2025-06-29 16:25:36.453891
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.464418	2025-06-29 16:25:36.464418
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.471801	2025-06-29 16:25:36.471801
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.476341	2025-06-29 16:25:36.476341
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.479098	2025-06-29 16:25:36.479098
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.483171	2025-06-29 16:25:36.483171
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.489734	2025-06-29 16:25:36.489734
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.496796	2025-06-29 16:25:36.496796
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.503451	2025-06-29 16:25:36.503451
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.510891	2025-06-29 16:25:36.510891
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.518408	2025-06-29 16:25:36.518408
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.530186	2025-06-29 16:25:36.530186
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.539597	2025-06-29 16:25:36.539597
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.548901	2025-06-29 16:25:36.548901
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.557317	2025-06-29 16:25:36.557317
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.567019	2025-06-29 16:25:36.567019
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.572608	2025-06-29 16:25:36.572608
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.580208	2025-06-29 16:25:36.580208
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.590606	2025-06-29 16:25:36.590606
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.594044	2025-06-29 16:25:36.594044
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.603544	2025-06-29 16:25:36.603544
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.612664	2025-06-29 16:25:36.612664
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.620137	2025-06-29 16:25:36.620137
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.630651	2025-06-29 16:25:36.630651
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.639495	2025-06-29 16:25:36.639495
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.647677	2025-06-29 16:25:36.647677
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.656491	2025-06-29 16:25:36.656491
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.66299	2025-06-29 16:25:36.66299
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.669373	2025-06-29 16:25:36.669373
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.676047	2025-06-29 16:25:36.676047
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.686077	2025-06-29 16:25:36.686077
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.692906	2025-06-29 16:25:36.692906
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.701642	2025-06-29 16:25:36.701642
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.710583	2025-06-29 16:25:36.710583
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.719546	2025-06-29 16:25:36.719546
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.731013	2025-06-29 16:25:36.731013
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.743177	2025-06-29 16:25:36.743177
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.75255	2025-06-29 16:25:36.75255
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.762465	2025-06-29 16:25:36.762465
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.772197	2025-06-29 16:25:36.772197
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.78445	2025-06-29 16:25:36.78445
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.795115	2025-06-29 16:25:36.795115
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.804539	2025-06-29 16:25:36.804539
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.815839	2025-06-29 16:25:36.815839
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.818835	2025-06-29 16:25:36.818835
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.827376	2025-06-29 16:25:36.827376
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.834676	2025-06-29 16:25:36.834676
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.841458	2025-06-29 16:25:36.841458
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.905905	2025-06-29 16:25:36.905905
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.947698	2025-06-29 16:25:36.947698
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.95725	2025-06-29 16:25:36.95725
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.964191	2025-06-29 16:25:36.964191
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:36.992237	2025-06-29 16:25:36.992237
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.000656	2025-06-29 16:25:37.000656
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.042915	2025-06-29 16:25:37.042915
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.052307	2025-06-29 16:25:37.052307
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.094319	2025-06-29 16:25:37.094319
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.0997	2025-06-29 16:25:37.0997
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.119189	2025-06-29 16:25:37.119189
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.128725	2025-06-29 16:25:37.128725
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.139805	2025-06-29 16:25:37.139805
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.144415	2025-06-29 16:25:37.144415
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.176025	2025-06-29 16:25:37.176025
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.186621	2025-06-29 16:25:37.186621
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.230943	2025-06-29 16:25:37.230943
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.238614	2025-06-29 16:25:37.238614
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.280615	2025-06-29 16:25:37.280615
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.289751	2025-06-29 16:25:37.289751
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.333598	2025-06-29 16:25:37.333598
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.343574	2025-06-29 16:25:37.343574
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.348884	2025-06-29 16:25:37.348884
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.362826	2025-06-29 16:25:37.362826
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.372683	2025-06-29 16:25:37.372683
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.414929	2025-06-29 16:25:37.414929
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.446114	2025-06-29 16:25:37.446114
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.467209	2025-06-29 16:25:37.467209
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.4792	2025-06-29 16:25:37.4792
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.498448	2025-06-29 16:25:37.498448
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.507057	2025-06-29 16:25:37.507057
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.517289	2025-06-29 16:25:37.517289
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.53044	2025-06-29 16:25:37.53044
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.541753	2025-06-29 16:25:37.541753
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.552658	2025-06-29 16:25:37.552658
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.561888	2025-06-29 16:25:37.561888
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.604623	2025-06-29 16:25:37.604623
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.648393	2025-06-29 16:25:37.648393
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.657496	2025-06-29 16:25:37.657496
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.66422	2025-06-29 16:25:37.66422
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.671554	2025-06-29 16:25:37.671554
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.680484	2025-06-29 16:25:37.680484
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.695021	2025-06-29 16:25:37.695021
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.705969	2025-06-29 16:25:37.705969
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.711176	2025-06-29 16:25:37.711176
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.742843	2025-06-29 16:25:37.742843
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.777824	2025-06-29 16:25:37.777824
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.7852	2025-06-29 16:25:37.7852
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.79321	2025-06-29 16:25:37.79321
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.803077	2025-06-29 16:25:37.803077
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.810666	2025-06-29 16:25:37.810666
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.850539	2025-06-29 16:25:37.850539
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.859863	2025-06-29 16:25:37.859863
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.902269	2025-06-29 16:25:37.902269
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.913568	2025-06-29 16:25:37.913568
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.93715	2025-06-29 16:25:37.93715
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.943666	2025-06-29 16:25:37.943666
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.950471	2025-06-29 16:25:37.950471
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.959025	2025-06-29 16:25:37.959025
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.970457	2025-06-29 16:25:37.970457
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.97688	2025-06-29 16:25:37.97688
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.989576	2025-06-29 16:25:37.989576
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:37.996824	2025-06-29 16:25:37.996824
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.007893	2025-06-29 16:25:38.007893
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.012196	2025-06-29 16:25:38.012196
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.021217	2025-06-29 16:25:38.021217
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.029648	2025-06-29 16:25:38.029648
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.038791	2025-06-29 16:25:38.038791
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.045262	2025-06-29 16:25:38.045262
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.051409	2025-06-29 16:25:38.051409
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.064741	2025-06-29 16:25:38.064741
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.073289	2025-06-29 16:25:38.073289
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.081693	2025-06-29 16:25:38.081693
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.090512	2025-06-29 16:25:38.090512
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.098976	2025-06-29 16:25:38.098976
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.108548	2025-06-29 16:25:38.108548
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.117345	2025-06-29 16:25:38.117345
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.127586	2025-06-29 16:25:38.127586
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.138487	2025-06-29 16:25:38.138487
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.143627	2025-06-29 16:25:38.143627
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.154592	2025-06-29 16:25:38.154592
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.166516	2025-06-29 16:25:38.166516
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.209207	2025-06-29 16:25:38.209207
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.219679	2025-06-29 16:25:38.219679
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.263556	2025-06-29 16:25:38.263556
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.273905	2025-06-29 16:25:38.273905
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.319308	2025-06-29 16:25:38.319308
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.330967	2025-06-29 16:25:38.330967
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.377483	2025-06-29 16:25:38.377483
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.3894	2025-06-29 16:25:38.3894
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.41139	2025-06-29 16:25:38.41139
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.423947	2025-06-29 16:25:38.423947
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.434071	2025-06-29 16:25:38.434071
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.461486	2025-06-29 16:25:38.461486
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.471499	2025-06-29 16:25:38.471499
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.484152	2025-06-29 16:25:38.484152
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.495489	2025-06-29 16:25:38.495489
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.506198	2025-06-29 16:25:38.506198
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.517876	2025-06-29 16:25:38.517876
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.528621	2025-06-29 16:25:38.528621
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.539094	2025-06-29 16:25:38.539094
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.549627	2025-06-29 16:25:38.549627
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.561163	2025-06-29 16:25:38.561163
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.572926	2025-06-29 16:25:38.572926
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.584592	2025-06-29 16:25:38.584592
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.596825	2025-06-29 16:25:38.596825
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.6081	2025-06-29 16:25:38.6081
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.620522	2025-06-29 16:25:38.620522
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.632678	2025-06-29 16:25:38.632678
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.644693	2025-06-29 16:25:38.644693
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.65443	2025-06-29 16:25:38.65443
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.684378	2025-06-29 16:25:38.684378
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.694856	2025-06-29 16:25:38.694856
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.704752	2025-06-29 16:25:38.704752
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.715202	2025-06-29 16:25:38.715202
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.726324	2025-06-29 16:25:38.726324
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.737078	2025-06-29 16:25:38.737078
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.744754	2025-06-29 16:25:38.744754
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.755284	2025-06-29 16:25:38.755284
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.765792	2025-06-29 16:25:38.765792
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.774618	2025-06-29 16:25:38.774618
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.786104	2025-06-29 16:25:38.786104
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.795704	2025-06-29 16:25:38.795704
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.806873	2025-06-29 16:25:38.806873
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.81458	2025-06-29 16:25:38.81458
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.82217	2025-06-29 16:25:38.82217
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.834235	2025-06-29 16:25:38.834235
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.841726	2025-06-29 16:25:38.841726
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.852463	2025-06-29 16:25:38.852463
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.864469	2025-06-29 16:25:38.864469
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.875842	2025-06-29 16:25:38.875842
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.92946	2025-06-29 16:25:38.92946
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.939161	2025-06-29 16:25:38.939161
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.950397	2025-06-29 16:25:38.950397
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.963387	2025-06-29 16:25:38.963387
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.976875	2025-06-29 16:25:38.976875
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.986973	2025-06-29 16:25:38.986973
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:38.994582	2025-06-29 16:25:38.994582
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.00526	2025-06-29 16:25:39.00526
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.015344	2025-06-29 16:25:39.015344
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.023251	2025-06-29 16:25:39.023251
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.035122	2025-06-29 16:25:39.035122
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.047181	2025-06-29 16:25:39.047181
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.057238	2025-06-29 16:25:39.057238
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.068454	2025-06-29 16:25:39.068454
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.075843	2025-06-29 16:25:39.075843
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.087415	2025-06-29 16:25:39.087415
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.098722	2025-06-29 16:25:39.098722
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.109371	2025-06-29 16:25:39.109371
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.119897	2025-06-29 16:25:39.119897
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.130092	2025-06-29 16:25:39.130092
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.140344	2025-06-29 16:25:39.140344
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.147905	2025-06-29 16:25:39.147905
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.160435	2025-06-29 16:25:39.160435
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.171918	2025-06-29 16:25:39.171918
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.182279	2025-06-29 16:25:39.182279
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.195862	2025-06-29 16:25:39.195862
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.210174	2025-06-29 16:25:39.210174
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.222484	2025-06-29 16:25:39.222484
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.235095	2025-06-29 16:25:39.235095
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.248229	2025-06-29 16:25:39.248229
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.263673	2025-06-29 16:25:39.263673
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.282459	2025-06-29 16:25:39.282459
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.296144	2025-06-29 16:25:39.296144
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.306594	2025-06-29 16:25:39.306594
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.319826	2025-06-29 16:25:39.319826
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.330824	2025-06-29 16:25:39.330824
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.341692	2025-06-29 16:25:39.341692
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.35246	2025-06-29 16:25:39.35246
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.362275	2025-06-29 16:25:39.362275
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.375267	2025-06-29 16:25:39.375267
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.386357	2025-06-29 16:25:39.386357
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.401153	2025-06-29 16:25:39.401153
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.412282	2025-06-29 16:25:39.412282
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.425307	2025-06-29 16:25:39.425307
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.450259	2025-06-29 16:25:39.450259
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.460394	2025-06-29 16:25:39.460394
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.475937	2025-06-29 16:25:39.475937
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.485898	2025-06-29 16:25:39.485898
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.499301	2025-06-29 16:25:39.499301
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.507156	2025-06-29 16:25:39.507156
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.528528	2025-06-29 16:25:39.528528
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.538737	2025-06-29 16:25:39.538737
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.548998	2025-06-29 16:25:39.548998
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.579944	2025-06-29 16:25:39.579944
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.590841	2025-06-29 16:25:39.590841
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.603309	2025-06-29 16:25:39.603309
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.647739	2025-06-29 16:25:39.647739
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.659356	2025-06-29 16:25:39.659356
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.669179	2025-06-29 16:25:39.669179
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.706383	2025-06-29 16:25:39.706383
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.726454	2025-06-29 16:25:39.726454
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.738298	2025-06-29 16:25:39.738298
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.757308	2025-06-29 16:25:39.757308
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.77364	2025-06-29 16:25:39.77364
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.784164	2025-06-29 16:25:39.784164
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.827256	2025-06-29 16:25:39.827256
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.836243	2025-06-29 16:25:39.836243
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.853457	2025-06-29 16:25:39.853457
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.863836	2025-06-29 16:25:39.863836
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.876031	2025-06-29 16:25:39.876031
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.901282	2025-06-29 16:25:39.901282
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.910825	2025-06-29 16:25:39.910825
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-29 16:25:39.920952	2025-06-29 16:25:39.920952
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:39.932917	2025-06-29 16:25:39.932917
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:39.944871	2025-06-29 16:25:39.944871
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:39.988026	2025-06-29 16:25:39.988026
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:39.998229	2025-06-29 16:25:39.998229
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.023931	2025-06-29 16:25:40.023931
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.03434	2025-06-29 16:25:40.03434
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.044209	2025-06-29 16:25:40.044209
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.073839	2025-06-29 16:25:40.073839
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.116703	2025-06-29 16:25:40.116703
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.126691	2025-06-29 16:25:40.126691
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.168909	2025-06-29 16:25:40.168909
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.179631	2025-06-29 16:25:40.179631
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.193869	2025-06-29 16:25:40.193869
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.222667	2025-06-29 16:25:40.222667
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.232982	2025-06-29 16:25:40.232982
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.254673	2025-06-29 16:25:40.254673
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.265227	2025-06-29 16:25:40.265227
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.276099	2025-06-29 16:25:40.276099
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.297222	2025-06-29 16:25:40.297222
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.308447	2025-06-29 16:25:40.308447
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.375123	2025-06-29 16:25:40.375123
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.385852	2025-06-29 16:25:40.385852
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.395782	2025-06-29 16:25:40.395782
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.406399	2025-06-29 16:25:40.406399
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.43735	2025-06-29 16:25:40.43735
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.445363	2025-06-29 16:25:40.445363
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.477224	2025-06-29 16:25:40.477224
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.488452	2025-06-29 16:25:40.488452
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.532282	2025-06-29 16:25:40.532282
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.543694	2025-06-29 16:25:40.543694
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.568247	2025-06-29 16:25:40.568247
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.578614	2025-06-29 16:25:40.578614
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.59081	2025-06-29 16:25:40.59081
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.600083	2025-06-29 16:25:40.600083
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.612445	2025-06-29 16:25:40.612445
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.623604	2025-06-29 16:25:40.623604
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.634913	2025-06-29 16:25:40.634913
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.644935	2025-06-29 16:25:40.644935
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.655416	2025-06-29 16:25:40.655416
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.699602	2025-06-29 16:25:40.699602
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.710203	2025-06-29 16:25:40.710203
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.753353	2025-06-29 16:25:40.753353
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.764139	2025-06-29 16:25:40.764139
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.80297	2025-06-29 16:25:40.80297
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.813329	2025-06-29 16:25:40.813329
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.823986	2025-06-29 16:25:40.823986
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.835872	2025-06-29 16:25:40.835872
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.847745	2025-06-29 16:25:40.847745
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.858233	2025-06-29 16:25:40.858233
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.869425	2025-06-29 16:25:40.869425
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.883702	2025-06-29 16:25:40.883702
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.894868	2025-06-29 16:25:40.894868
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.904694	2025-06-29 16:25:40.904694
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.915136	2025-06-29 16:25:40.915136
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.927836	2025-06-29 16:25:40.927836
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.93952	2025-06-29 16:25:40.93952
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.950571	2025-06-29 16:25:40.950571
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.962132	2025-06-29 16:25:40.962132
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.974584	2025-06-29 16:25:40.974584
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.984581	2025-06-29 16:25:40.984581
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:40.996407	2025-06-29 16:25:40.996407
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.006864	2025-06-29 16:25:41.006864
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.034568	2025-06-29 16:25:41.034568
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.045203	2025-06-29 16:25:41.045203
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.066674	2025-06-29 16:25:41.066674
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.077323	2025-06-29 16:25:41.077323
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.123114	2025-06-29 16:25:41.123114
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.168255	2025-06-29 16:25:41.168255
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.178502	2025-06-29 16:25:41.178502
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.205063	2025-06-29 16:25:41.205063
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.215061	2025-06-29 16:25:41.215061
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.226148	2025-06-29 16:25:41.226148
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.236574	2025-06-29 16:25:41.236574
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.248018	2025-06-29 16:25:41.248018
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.270041	2025-06-29 16:25:41.270041
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.296938	2025-06-29 16:25:41.296938
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.307669	2025-06-29 16:25:41.307669
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.354594	2025-06-29 16:25:41.354594
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.364588	2025-06-29 16:25:41.364588
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.41495	2025-06-29 16:25:41.41495
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.444396	2025-06-29 16:25:41.444396
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.454327	2025-06-29 16:25:41.454327
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.464111	2025-06-29 16:25:41.464111
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.478149	2025-06-29 16:25:41.478149
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.487558	2025-06-29 16:25:41.487558
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.494672	2025-06-29 16:25:41.494672
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.505297	2025-06-29 16:25:41.505297
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.515842	2025-06-29 16:25:41.515842
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.533697	2025-06-29 16:25:41.533697
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.541551	2025-06-29 16:25:41.541551
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.553914	2025-06-29 16:25:41.553914
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.596388	2025-06-29 16:25:41.596388
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.608735	2025-06-29 16:25:41.608735
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.653151	2025-06-29 16:25:41.653151
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.66693	2025-06-29 16:25:41.66693
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.677652	2025-06-29 16:25:41.677652
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.687593	2025-06-29 16:25:41.687593
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.697956	2025-06-29 16:25:41.697956
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.743602	2025-06-29 16:25:41.743602
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.790247	2025-06-29 16:25:41.790247
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.809473	2025-06-29 16:25:41.809473
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.823129	2025-06-29 16:25:41.823129
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.833689	2025-06-29 16:25:41.833689
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.845695	2025-06-29 16:25:41.845695
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.889572	2025-06-29 16:25:41.889572
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.901125	2025-06-29 16:25:41.901125
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.929837	2025-06-29 16:25:41.929837
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.939915	2025-06-29 16:25:41.939915
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.983858	2025-06-29 16:25:41.983858
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.994287	2025-06-29 16:25:41.994287
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.037782	2025-06-29 16:25:42.037782
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.048798	2025-06-29 16:25:42.048798
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.060045	2025-06-29 16:25:42.060045
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.071332	2025-06-29 16:25:42.071332
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.124717	2025-06-29 16:25:42.124717
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.135547	2025-06-29 16:25:42.135547
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.179585	2025-06-29 16:25:42.179585
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.223032	2025-06-29 16:25:42.223032
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.234623	2025-06-29 16:25:42.234623
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.278479	2025-06-29 16:25:42.278479
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.288854	2025-06-29 16:25:42.288854
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.299106	2025-06-29 16:25:42.299106
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.341446	2025-06-29 16:25:42.341446
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.352326	2025-06-29 16:25:42.352326
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.370628	2025-06-29 16:25:42.370628
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.413997	2025-06-29 16:25:42.413997
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.427803	2025-06-29 16:25:42.427803
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.44016	2025-06-29 16:25:42.44016
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.483457	2025-06-29 16:25:42.483457
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.49427	2025-06-29 16:25:42.49427
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.536887	2025-06-29 16:25:42.536887
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.547337	2025-06-29 16:25:42.547337
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.577849	2025-06-29 16:25:42.577849
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.588131	2025-06-29 16:25:42.588131
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.599331	2025-06-29 16:25:42.599331
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.61066	2025-06-29 16:25:42.61066
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.621669	2025-06-29 16:25:42.621669
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.656738	2025-06-29 16:25:42.656738
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.702783	2025-06-29 16:25:42.702783
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.712653	2025-06-29 16:25:42.712653
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.755607	2025-06-29 16:25:42.755607
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.766393	2025-06-29 16:25:42.766393
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.808942	2025-06-29 16:25:42.808942
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.818746	2025-06-29 16:25:42.818746
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.853265	2025-06-29 16:25:42.853265
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.86406	2025-06-29 16:25:42.86406
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.874281	2025-06-29 16:25:42.874281
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.884977	2025-06-29 16:25:42.884977
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.896417	2025-06-29 16:25:42.896417
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.912035	2025-06-29 16:25:42.912035
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.925296	2025-06-29 16:25:42.925296
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.93542	2025-06-29 16:25:42.93542
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.945316	2025-06-29 16:25:42.945316
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.955491	2025-06-29 16:25:42.955491
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.966847	2025-06-29 16:25:42.966847
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.976457	2025-06-29 16:25:42.976457
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.98713	2025-06-29 16:25:42.98713
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.998475	2025-06-29 16:25:42.998475
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.010756	2025-06-29 16:25:43.010756
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.020404	2025-06-29 16:25:43.020404
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.031432	2025-06-29 16:25:43.031432
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.044341	2025-06-29 16:25:43.044341
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.512963	2025-06-29 16:25:42.512963
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.592136	2025-06-29 16:25:41.592136
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.606802	2025-06-29 16:25:41.606802
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.61921	2025-06-29 16:25:41.61921
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.634564	2025-06-29 16:25:41.634564
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.654467	2025-06-29 16:25:41.654467
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.669179	2025-06-29 16:25:41.669179
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.686077	2025-06-29 16:25:41.686077
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.703431	2025-06-29 16:25:41.703431
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.719077	2025-06-29 16:25:41.719077
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.730874	2025-06-29 16:25:41.730874
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.7537	2025-06-29 16:25:41.7537
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.768898	2025-06-29 16:25:41.768898
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.782626	2025-06-29 16:25:41.782626
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.792957	2025-06-29 16:25:41.792957
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.803816	2025-06-29 16:25:41.803816
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.815622	2025-06-29 16:25:41.815622
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.827523	2025-06-29 16:25:41.827523
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.839249	2025-06-29 16:25:41.839249
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.849222	2025-06-29 16:25:41.849222
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.858499	2025-06-29 16:25:41.858499
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.867669	2025-06-29 16:25:41.867669
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.878327	2025-06-29 16:25:41.878327
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.888592	2025-06-29 16:25:41.888592
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.899448	2025-06-29 16:25:41.899448
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.91001	2025-06-29 16:25:41.91001
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.921065	2025-06-29 16:25:41.921065
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.931658	2025-06-29 16:25:41.931658
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.941644	2025-06-29 16:25:41.941644
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.952504	2025-06-29 16:25:41.952504
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.965467	2025-06-29 16:25:41.965467
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.97793	2025-06-29 16:25:41.97793
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:41.989878	2025-06-29 16:25:41.989878
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.001221	2025-06-29 16:25:42.001221
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.008776	2025-06-29 16:25:42.008776
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.020866	2025-06-29 16:25:42.020866
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.032363	2025-06-29 16:25:42.032363
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.041728	2025-06-29 16:25:42.041728
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.056936	2025-06-29 16:25:42.056936
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.070331	2025-06-29 16:25:42.070331
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.079958	2025-06-29 16:25:42.079958
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.091629	2025-06-29 16:25:42.091629
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.103264	2025-06-29 16:25:42.103264
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.11382	2025-06-29 16:25:42.11382
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.123539	2025-06-29 16:25:42.123539
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.13488	2025-06-29 16:25:42.13488
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.151026	2025-06-29 16:25:42.151026
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.160532	2025-06-29 16:25:42.160532
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.170883	2025-06-29 16:25:42.170883
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.181302	2025-06-29 16:25:42.181302
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.191202	2025-06-29 16:25:42.191202
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.201556	2025-06-29 16:25:42.201556
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.211276	2025-06-29 16:25:42.211276
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.22127	2025-06-29 16:25:42.22127
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.232384	2025-06-29 16:25:42.232384
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.24293	2025-06-29 16:25:42.24293
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.255496	2025-06-29 16:25:42.255496
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.266108	2025-06-29 16:25:42.266108
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.280077	2025-06-29 16:25:42.280077
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.299813	2025-06-29 16:25:42.299813
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.313483	2025-06-29 16:25:42.313483
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.323132	2025-06-29 16:25:42.323132
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.335586	2025-06-29 16:25:42.335586
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.345485	2025-06-29 16:25:42.345485
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.355853	2025-06-29 16:25:42.355853
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.366111	2025-06-29 16:25:42.366111
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.376217	2025-06-29 16:25:42.376217
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.393195	2025-06-29 16:25:42.393195
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.426267	2025-06-29 16:25:42.426267
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.436703	2025-06-29 16:25:42.436703
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.447443	2025-06-29 16:25:42.447443
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.462436	2025-06-29 16:25:42.462436
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.472937	2025-06-29 16:25:42.472937
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.480516	2025-06-29 16:25:42.480516
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.510412	2025-06-29 16:25:42.510412
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.519709	2025-06-29 16:25:42.519709
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.532227	2025-06-29 16:25:42.532227
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.543929	2025-06-29 16:25:42.543929
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.551792	2025-06-29 16:25:42.551792
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.562062	2025-06-29 16:25:42.562062
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.572925	2025-06-29 16:25:42.572925
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.584748	2025-06-29 16:25:42.584748
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.597648	2025-06-29 16:25:42.597648
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.609072	2025-06-29 16:25:42.609072
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.620285	2025-06-29 16:25:42.620285
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.633777	2025-06-29 16:25:42.633777
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.646123	2025-06-29 16:25:42.646123
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.655878	2025-06-29 16:25:42.655878
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.665483	2025-06-29 16:25:42.665483
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.67576	2025-06-29 16:25:42.67576
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.68668	2025-06-29 16:25:42.68668
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.695997	2025-06-29 16:25:42.695997
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.707032	2025-06-29 16:25:42.707032
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.716891	2025-06-29 16:25:42.716891
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.726615	2025-06-29 16:25:42.726615
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.740287	2025-06-29 16:25:42.740287
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.750903	2025-06-29 16:25:42.750903
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.760121	2025-06-29 16:25:42.760121
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.77103	2025-06-29 16:25:42.77103
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.780368	2025-06-29 16:25:42.780368
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.791765	2025-06-29 16:25:42.791765
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.801701	2025-06-29 16:25:42.801701
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.810911	2025-06-29 16:25:42.810911
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.821475	2025-06-29 16:25:42.821475
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.83178	2025-06-29 16:25:42.83178
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.844089	2025-06-29 16:25:42.844089
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.853838	2025-06-29 16:25:42.853838
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.865894	2025-06-29 16:25:42.865894
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.875698	2025-06-29 16:25:42.875698
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.887273	2025-06-29 16:25:42.887273
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.896672	2025-06-29 16:25:42.896672
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.909018	2025-06-29 16:25:42.909018
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.921678	2025-06-29 16:25:42.921678
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.9352	2025-06-29 16:25:42.9352
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.945447	2025-06-29 16:25:42.945447
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.957104	2025-06-29 16:25:42.957104
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.967699	2025-06-29 16:25:42.967699
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.978818	2025-06-29 16:25:42.978818
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.989374	2025-06-29 16:25:42.989374
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:42.99951	2025-06-29 16:25:42.99951
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.009557	2025-06-29 16:25:43.009557
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.018917	2025-06-29 16:25:43.018917
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.03009	2025-06-29 16:25:43.03009
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.040616	2025-06-29 16:25:43.040616
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.051033	2025-06-29 16:25:43.051033
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.060564	2025-06-29 16:25:43.060564
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.070639	2025-06-29 16:25:43.070639
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.081071	2025-06-29 16:25:43.081071
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.09393	2025-06-29 16:25:43.09393
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.10626	2025-06-29 16:25:43.10626
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.116696	2025-06-29 16:25:43.116696
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.128675	2025-06-29 16:25:43.128675
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.140549	2025-06-29 16:25:43.140549
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.150773	2025-06-29 16:25:43.150773
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.161588	2025-06-29 16:25:43.161588
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.171742	2025-06-29 16:25:43.171742
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.183527	2025-06-29 16:25:43.183527
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.195415	2025-06-29 16:25:43.195415
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.2079	2025-06-29 16:25:43.2079
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.217604	2025-06-29 16:25:43.217604
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.227761	2025-06-29 16:25:43.227761
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.238598	2025-06-29 16:25:43.238598
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.24923	2025-06-29 16:25:43.24923
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.259345	2025-06-29 16:25:43.259345
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.269164	2025-06-29 16:25:43.269164
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.280507	2025-06-29 16:25:43.280507
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.290619	2025-06-29 16:25:43.290619
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.303782	2025-06-29 16:25:43.303782
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.314649	2025-06-29 16:25:43.314649
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.325357	2025-06-29 16:25:43.325357
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.335806	2025-06-29 16:25:43.335806
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.371103	2025-06-29 16:25:43.371103
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.383245	2025-06-29 16:25:43.383245
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.415883	2025-06-29 16:25:43.415883
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.460995	2025-06-29 16:25:43.460995
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.472478	2025-06-29 16:25:43.472478
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.516998	2025-06-29 16:25:43.516998
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.527652	2025-06-29 16:25:43.527652
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.551034	2025-06-29 16:25:43.551034
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.562199	2025-06-29 16:25:43.562199
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.60714	2025-06-29 16:25:43.60714
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.614587	2025-06-29 16:25:43.614587
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.624666	2025-06-29 16:25:43.624666
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.66725	2025-06-29 16:25:43.66725
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.677652	2025-06-29 16:25:43.677652
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.721608	2025-06-29 16:25:43.721608
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.731923	2025-06-29 16:25:43.731923
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.744366	2025-06-29 16:25:43.744366
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.795829	2025-06-29 16:25:43.795829
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.807616	2025-06-29 16:25:43.807616
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.82964	2025-06-29 16:25:43.82964
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.873776	2025-06-29 16:25:43.873776
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.885236	2025-06-29 16:25:43.885236
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.929306	2025-06-29 16:25:43.929306
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.97351	2025-06-29 16:25:43.97351
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:43.985398	2025-06-29 16:25:43.985398
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.030335	2025-06-29 16:25:44.030335
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.044897	2025-06-29 16:25:44.044897
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.084315	2025-06-29 16:25:44.084315
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.132173	2025-06-29 16:25:44.132173
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.143683	2025-06-29 16:25:44.143683
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.153494	2025-06-29 16:25:44.153494
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.175355	2025-06-29 16:25:44.175355
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.18993	2025-06-29 16:25:44.18993
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.201258	2025-06-29 16:25:44.201258
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.244961	2025-06-29 16:25:44.244961
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.292226	2025-06-29 16:25:44.292226
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.305746	2025-06-29 16:25:44.305746
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.351129	2025-06-29 16:25:44.351129
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.362309	2025-06-29 16:25:44.362309
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.376781	2025-06-29 16:25:44.376781
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.388166	2025-06-29 16:25:44.388166
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.401729	2025-06-29 16:25:44.401729
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.414902	2025-06-29 16:25:44.414902
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.432775	2025-06-29 16:25:44.432775
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.45048	2025-06-29 16:25:44.45048
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.457995	2025-06-29 16:25:44.457995
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.468218	2025-06-29 16:25:44.468218
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.478362	2025-06-29 16:25:44.478362
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.488487	2025-06-29 16:25:44.488487
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.497999	2025-06-29 16:25:44.497999
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.5412	2025-06-29 16:25:44.5412
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.584895	2025-06-29 16:25:44.584895
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.59367	2025-06-29 16:25:44.59367
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.635433	2025-06-29 16:25:44.635433
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.651095	2025-06-29 16:25:44.651095
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.664345	2025-06-29 16:25:44.664345
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.726725	2025-06-29 16:25:44.726725
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.75967	2025-06-29 16:25:44.75967
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.79285	2025-06-29 16:25:44.79285
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.844105	2025-06-29 16:25:44.844105
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:44.984024	2025-06-29 16:25:44.984024
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.020187	2025-06-29 16:25:45.020187
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.077793	2025-06-29 16:25:45.077793
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.092232	2025-06-29 16:25:45.092232
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.13397	2025-06-29 16:25:45.13397
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.152444	2025-06-29 16:25:45.152444
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.163232	2025-06-29 16:25:45.163232
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.180294	2025-06-29 16:25:45.180294
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.196171	2025-06-29 16:25:45.196171
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.21464	2025-06-29 16:25:45.21464
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.227505	2025-06-29 16:25:45.227505
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.276343	2025-06-29 16:25:45.276343
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.319327	2025-06-29 16:25:45.319327
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.339845	2025-06-29 16:25:45.339845
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.361582	2025-06-29 16:25:45.361582
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.38577	2025-06-29 16:25:45.38577
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.429361	2025-06-29 16:25:45.429361
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.547471	2025-06-29 16:25:45.547471
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.572654	2025-06-29 16:25:45.572654
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.612724	2025-06-29 16:25:45.612724
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.622376	2025-06-29 16:25:45.622376
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.702442	2025-06-29 16:25:45.702442
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.72983	2025-06-29 16:25:45.72983
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.742712	2025-06-29 16:25:45.742712
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.785356	2025-06-29 16:25:45.785356
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.813855	2025-06-29 16:25:45.813855
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.835298	2025-06-29 16:25:45.835298
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.973363	2025-06-29 16:25:45.973363
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:45.994443	2025-06-29 16:25:45.994443
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.01156	2025-06-29 16:25:46.01156
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.05088	2025-06-29 16:25:46.05088
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.110804	2025-06-29 16:25:46.110804
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.259181	2025-06-29 16:25:46.259181
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.496926	2025-06-29 16:25:46.496926
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.532747	2025-06-29 16:25:46.532747
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.570758	2025-06-29 16:25:46.570758
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.597921	2025-06-29 16:25:46.597921
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.629603	2025-06-29 16:25:46.629603
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.748965	2025-06-29 16:25:46.748965
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.797968	2025-06-29 16:25:46.797968
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.813169	2025-06-29 16:25:46.813169
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.83946	2025-06-29 16:25:46.83946
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.870804	2025-06-29 16:25:46.870804
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.923198	2025-06-29 16:25:46.923198
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:46.959027	2025-06-29 16:25:46.959027
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.019796	2025-06-29 16:25:47.019796
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.0537	2025-06-29 16:25:47.0537
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.070755	2025-06-29 16:25:47.070755
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.090556	2025-06-29 16:25:47.090556
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.122308	2025-06-29 16:25:47.122308
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.146951	2025-06-29 16:25:47.146951
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.162546	2025-06-29 16:25:47.162546
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.193874	2025-06-29 16:25:47.193874
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.371791	2025-06-29 16:25:47.371791
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.400403	2025-06-29 16:25:47.400403
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.4218	2025-06-29 16:25:47.4218
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.476172	2025-06-29 16:25:47.476172
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.543648	2025-06-29 16:25:47.543648
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.556177	2025-06-29 16:25:47.556177
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.579116	2025-06-29 16:25:47.579116
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.602481	2025-06-29 16:25:47.602481
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.630645	2025-06-29 16:25:47.630645
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.670777	2025-06-29 16:25:47.670777
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.715942	2025-06-29 16:25:47.715942
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.752131	2025-06-29 16:25:47.752131
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.765679	2025-06-29 16:25:47.765679
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.789141	2025-06-29 16:25:47.789141
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:47.851645	2025-06-29 16:25:47.851645
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.287091	2025-06-29 16:25:48.287091
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.302743	2025-06-29 16:25:48.302743
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.318643	2025-06-29 16:25:48.318643
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.353991	2025-06-29 16:25:48.353991
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.437377	2025-06-29 16:25:48.437377
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.469226	2025-06-29 16:25:48.469226
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.483701	2025-06-29 16:25:48.483701
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.501337	2025-06-29 16:25:48.501337
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.569484	2025-06-29 16:25:48.569484
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.600206	2025-06-29 16:25:48.600206
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.628481	2025-06-29 16:25:48.628481
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.689521	2025-06-29 16:25:48.689521
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.717332	2025-06-29 16:25:48.717332
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.731426	2025-06-29 16:25:48.731426
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.744963	2025-06-29 16:25:48.744963
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.782373	2025-06-29 16:25:48.782373
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:48.919738	2025-06-29 16:25:48.919738
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.038464	2025-06-29 16:25:49.038464
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.206841	2025-06-29 16:25:49.206841
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.291263	2025-06-29 16:25:49.291263
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.306047	2025-06-29 16:25:49.306047
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.347922	2025-06-29 16:25:49.347922
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.396684	2025-06-29 16:25:49.396684
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.421711	2025-06-29 16:25:49.421711
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.439041	2025-06-29 16:25:49.439041
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.455008	2025-06-29 16:25:49.455008
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.486298	2025-06-29 16:25:49.486298
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.542837	2025-06-29 16:25:49.542837
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.564711	2025-06-29 16:25:49.564711
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.606185	2025-06-29 16:25:49.606185
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.642923	2025-06-29 16:25:49.642923
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.656068	2025-06-29 16:25:49.656068
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.674942	2025-06-29 16:25:49.674942
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.690731	2025-06-29 16:25:49.690731
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.702683	2025-06-29 16:25:49.702683
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.723073	2025-06-29 16:25:49.723073
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.733072	2025-06-29 16:25:49.733072
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.749309	2025-06-29 16:25:49.749309
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.764968	2025-06-29 16:25:49.764968
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.780779	2025-06-29 16:25:49.780779
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.802644	2025-06-29 16:25:49.802644
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.833143	2025-06-29 16:25:49.833143
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.853484	2025-06-29 16:25:49.853484
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.907782	2025-06-29 16:25:49.907782
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.931573	2025-06-29 16:25:49.931573
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.951388	2025-06-29 16:25:49.951388
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.970656	2025-06-29 16:25:49.970656
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:49.998962	2025-06-29 16:25:49.998962
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.011164	2025-06-29 16:25:50.011164
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.021717	2025-06-29 16:25:50.021717
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.041509	2025-06-29 16:25:50.041509
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.057214	2025-06-29 16:25:50.057214
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.08141	2025-06-29 16:25:50.08141
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.12362	2025-06-29 16:25:50.12362
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.139577	2025-06-29 16:25:50.139577
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.15634	2025-06-29 16:25:50.15634
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.177109	2025-06-29 16:25:50.177109
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.202178	2025-06-29 16:25:50.202178
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.220304	2025-06-29 16:25:50.220304
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.237987	2025-06-29 16:25:50.237987
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.252702	2025-06-29 16:25:50.252702
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.271833	2025-06-29 16:25:50.271833
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.289135	2025-06-29 16:25:50.289135
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.329504	2025-06-29 16:25:50.329504
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.345424	2025-06-29 16:25:50.345424
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.388555	2025-06-29 16:25:50.388555
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.407711	2025-06-29 16:25:50.407711
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.428846	2025-06-29 16:25:50.428846
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.462521	2025-06-29 16:25:50.462521
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.487728	2025-06-29 16:25:50.487728
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.500235	2025-06-29 16:25:50.500235
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.526234	2025-06-29 16:25:50.526234
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.550358	2025-06-29 16:25:50.550358
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.563857	2025-06-29 16:25:50.563857
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.590493	2025-06-29 16:25:50.590493
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.630328	2025-06-29 16:25:50.630328
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.646265	2025-06-29 16:25:50.646265
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.738389	2025-06-29 16:25:50.738389
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.752487	2025-06-29 16:25:50.752487
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.770801	2025-06-29 16:25:50.770801
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.817814	2025-06-29 16:25:50.817814
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.835994	2025-06-29 16:25:50.835994
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.863382	2025-06-29 16:25:50.863382
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.9064	2025-06-29 16:25:50.9064
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:50.929283	2025-06-29 16:25:50.929283
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.001339	2025-06-29 16:25:51.001339
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.01327	2025-06-29 16:25:51.01327
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.028377	2025-06-29 16:25:51.028377
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.043412	2025-06-29 16:25:51.043412
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.061389	2025-06-29 16:25:51.061389
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.088693	2025-06-29 16:25:51.088693
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.158471	2025-06-29 16:25:51.158471
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.196627	2025-06-29 16:25:51.196627
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.214516	2025-06-29 16:25:51.214516
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.224564	2025-06-29 16:25:51.224564
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.238734	2025-06-29 16:25:51.238734
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.260142	2025-06-29 16:25:51.260142
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.279054	2025-06-29 16:25:51.279054
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.302198	2025-06-29 16:25:51.302198
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.326306	2025-06-29 16:25:51.326306
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.351842	2025-06-29 16:25:51.351842
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.376907	2025-06-29 16:25:51.376907
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.398983	2025-06-29 16:25:51.398983
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.408889	2025-06-29 16:25:51.408889
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.436999	2025-06-29 16:25:51.436999
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.449672	2025-06-29 16:25:51.449672
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.471301	2025-06-29 16:25:51.471301
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.48827	2025-06-29 16:25:51.48827
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.505588	2025-06-29 16:25:51.505588
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.556911	2025-06-29 16:25:51.556911
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.574859	2025-06-29 16:25:51.574859
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.593196	2025-06-29 16:25:51.593196
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.630403	2025-06-29 16:25:51.630403
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.655075	2025-06-29 16:25:51.655075
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-29 16:25:51.682256	2025-06-29 16:25:51.682256
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.694987	2025-06-29 16:25:51.694987
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.715499	2025-06-29 16:25:51.715499
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.733406	2025-06-29 16:25:51.733406
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.754382	2025-06-29 16:25:51.754382
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.77975	2025-06-29 16:25:51.77975
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.793446	2025-06-29 16:25:51.793446
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.812107	2025-06-29 16:25:51.812107
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.830723	2025-06-29 16:25:51.830723
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.842967	2025-06-29 16:25:51.842967
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.864113	2025-06-29 16:25:51.864113
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.877756	2025-06-29 16:25:51.877756
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.893655	2025-06-29 16:25:51.893655
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.912188	2025-06-29 16:25:51.912188
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.940694	2025-06-29 16:25:51.940694
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.9601	2025-06-29 16:25:51.9601
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:51.990836	2025-06-29 16:25:51.990836
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.006641	2025-06-29 16:25:52.006641
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.020402	2025-06-29 16:25:52.020402
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.030209	2025-06-29 16:25:52.030209
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.044283	2025-06-29 16:25:52.044283
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.056075	2025-06-29 16:25:52.056075
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.07093	2025-06-29 16:25:52.07093
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.115835	2025-06-29 16:25:52.115835
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.128517	2025-06-29 16:25:52.128517
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.139875	2025-06-29 16:25:52.139875
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.156604	2025-06-29 16:25:52.156604
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.259004	2025-06-29 16:25:52.259004
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.319638	2025-06-29 16:25:52.319638
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.352131	2025-06-29 16:25:52.352131
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.385955	2025-06-29 16:25:52.385955
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.411684	2025-06-29 16:25:52.411684
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.429933	2025-06-29 16:25:52.429933
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.438796	2025-06-29 16:25:52.438796
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.457166	2025-06-29 16:25:52.457166
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.470338	2025-06-29 16:25:52.470338
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.483858	2025-06-29 16:25:52.483858
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.493832	2025-06-29 16:25:52.493832
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.508255	2025-06-29 16:25:52.508255
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.518965	2025-06-29 16:25:52.518965
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.534824	2025-06-29 16:25:52.534824
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.550497	2025-06-29 16:25:52.550497
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.572116	2025-06-29 16:25:52.572116
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.583067	2025-06-29 16:25:52.583067
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.597402	2025-06-29 16:25:52.597402
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.609721	2025-06-29 16:25:52.609721
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.621698	2025-06-29 16:25:52.621698
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.631606	2025-06-29 16:25:52.631606
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.646036	2025-06-29 16:25:52.646036
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.663777	2025-06-29 16:25:52.663777
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.681492	2025-06-29 16:25:52.681492
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.697749	2025-06-29 16:25:52.697749
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.708671	2025-06-29 16:25:52.708671
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.728215	2025-06-29 16:25:52.728215
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.745119	2025-06-29 16:25:52.745119
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.756001	2025-06-29 16:25:52.756001
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.769545	2025-06-29 16:25:52.769545
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.784067	2025-06-29 16:25:52.784067
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.811534	2025-06-29 16:25:52.811534
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.835165	2025-06-29 16:25:52.835165
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.851214	2025-06-29 16:25:52.851214
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.873042	2025-06-29 16:25:52.873042
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.895207	2025-06-29 16:25:52.895207
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.915101	2025-06-29 16:25:52.915101
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.938162	2025-06-29 16:25:52.938162
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.953957	2025-06-29 16:25:52.953957
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:52.967233	2025-06-29 16:25:52.967233
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.000116	2025-06-29 16:25:53.000116
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.020941	2025-06-29 16:25:53.020941
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.035667	2025-06-29 16:25:53.035667
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.061359	2025-06-29 16:25:53.061359
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.077992	2025-06-29 16:25:53.077992
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.096523	2025-06-29 16:25:53.096523
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.110785	2025-06-29 16:25:53.110785
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.163992	2025-06-29 16:25:53.163992
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.17622	2025-06-29 16:25:53.17622
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.187215	2025-06-29 16:25:53.187215
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.22812	2025-06-29 16:25:53.22812
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.249229	2025-06-29 16:25:53.249229
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.263824	2025-06-29 16:25:53.263824
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.290628	2025-06-29 16:25:53.290628
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.319933	2025-06-29 16:25:53.319933
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.34038	2025-06-29 16:25:53.34038
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.355493	2025-06-29 16:25:53.355493
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.376969	2025-06-29 16:25:53.376969
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.412825	2025-06-29 16:25:53.412825
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.426553	2025-06-29 16:25:53.426553
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.440663	2025-06-29 16:25:53.440663
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.458343	2025-06-29 16:25:53.458343
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.474031	2025-06-29 16:25:53.474031
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.484612	2025-06-29 16:25:53.484612
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.500917	2025-06-29 16:25:53.500917
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.52023	2025-06-29 16:25:53.52023
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.534108	2025-06-29 16:25:53.534108
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.554718	2025-06-29 16:25:53.554718
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.567364	2025-06-29 16:25:53.567364
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.591881	2025-06-29 16:25:53.591881
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.612719	2025-06-29 16:25:53.612719
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.629488	2025-06-29 16:25:53.629488
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.659318	2025-06-29 16:25:53.659318
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.672613	2025-06-29 16:25:53.672613
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.692828	2025-06-29 16:25:53.692828
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.710169	2025-06-29 16:25:53.710169
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.7271	2025-06-29 16:25:53.7271
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.750145	2025-06-29 16:25:53.750145
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.769592	2025-06-29 16:25:53.769592
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.792666	2025-06-29 16:25:53.792666
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.802934	2025-06-29 16:25:53.802934
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.815246	2025-06-29 16:25:53.815246
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.843596	2025-06-29 16:25:53.843596
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.85664	2025-06-29 16:25:53.85664
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.888284	2025-06-29 16:25:53.888284
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.900311	2025-06-29 16:25:53.900311
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.910623	2025-06-29 16:25:53.910623
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.921583	2025-06-29 16:25:53.921583
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.933912	2025-06-29 16:25:53.933912
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.951233	2025-06-29 16:25:53.951233
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.961597	2025-06-29 16:25:53.961597
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.97636	2025-06-29 16:25:53.97636
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:53.994526	2025-06-29 16:25:53.994526
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.007541	2025-06-29 16:25:54.007541
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.02961	2025-06-29 16:25:54.02961
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.04478	2025-06-29 16:25:54.04478
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.059698	2025-06-29 16:25:54.059698
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.075596	2025-06-29 16:25:54.075596
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.102722	2025-06-29 16:25:54.102722
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.112107	2025-06-29 16:25:54.112107
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.127173	2025-06-29 16:25:54.127173
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.139612	2025-06-29 16:25:54.139612
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.154395	2025-06-29 16:25:54.154395
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.167843	2025-06-29 16:25:54.167843
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.205768	2025-06-29 16:25:54.205768
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.220377	2025-06-29 16:25:54.220377
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.238856	2025-06-29 16:25:54.238856
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.275811	2025-06-29 16:25:54.275811
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.291109	2025-06-29 16:25:54.291109
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.305792	2025-06-29 16:25:54.305792
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.321459	2025-06-29 16:25:54.321459
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.341506	2025-06-29 16:25:54.341506
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.352464	2025-06-29 16:25:54.352464
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.369886	2025-06-29 16:25:54.369886
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.39865	2025-06-29 16:25:54.39865
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.412582	2025-06-29 16:25:54.412582
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.425762	2025-06-29 16:25:54.425762
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.438608	2025-06-29 16:25:54.438608
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.457389	2025-06-29 16:25:54.457389
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.472235	2025-06-29 16:25:54.472235
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.489619	2025-06-29 16:25:54.489619
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.504154	2025-06-29 16:25:54.504154
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.539294	2025-06-29 16:25:54.539294
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.553498	2025-06-29 16:25:54.553498
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.57476	2025-06-29 16:25:54.57476
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.606784	2025-06-29 16:25:54.606784
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.617208	2025-06-29 16:25:54.617208
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.639756	2025-06-29 16:25:54.639756
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.658928	2025-06-29 16:25:54.658928
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.691845	2025-06-29 16:25:54.691845
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.707079	2025-06-29 16:25:54.707079
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.721178	2025-06-29 16:25:54.721178
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.732419	2025-06-29 16:25:54.732419
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.742436	2025-06-29 16:25:54.742436
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.755883	2025-06-29 16:25:54.755883
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.766316	2025-06-29 16:25:54.766316
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.776941	2025-06-29 16:25:54.776941
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.81201	2025-06-29 16:25:54.81201
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.830925	2025-06-29 16:25:54.830925
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.859334	2025-06-29 16:25:54.859334
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.873919	2025-06-29 16:25:54.873919
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.889746	2025-06-29 16:25:54.889746
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.903011	2025-06-29 16:25:54.903011
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.919652	2025-06-29 16:25:54.919652
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.933179	2025-06-29 16:25:54.933179
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.949731	2025-06-29 16:25:54.949731
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.974724	2025-06-29 16:25:54.974724
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.985924	2025-06-29 16:25:54.985924
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:54.999014	2025-06-29 16:25:54.999014
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.013884	2025-06-29 16:25:55.013884
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.037124	2025-06-29 16:25:55.037124
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.062934	2025-06-29 16:25:55.062934
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.074336	2025-06-29 16:25:55.074336
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.095607	2025-06-29 16:25:55.095607
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.117095	2025-06-29 16:25:55.117095
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.140459	2025-06-29 16:25:55.140459
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.189423	2025-06-29 16:25:55.189423
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.203651	2025-06-29 16:25:55.203651
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.233226	2025-06-29 16:25:55.233226
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.23639	2025-06-29 16:25:55.23639
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.247039	2025-06-29 16:25:55.247039
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.254269	2025-06-29 16:25:55.254269
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.269355	2025-06-29 16:25:55.269355
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.278161	2025-06-29 16:25:55.278161
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.29199	2025-06-29 16:25:55.29199
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.305055	2025-06-29 16:25:55.305055
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.312049	2025-06-29 16:25:55.312049
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.318386	2025-06-29 16:25:55.318386
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.329414	2025-06-29 16:25:55.329414
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.336351	2025-06-29 16:25:55.336351
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.342931	2025-06-29 16:25:55.342931
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.349731	2025-06-29 16:25:55.349731
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.361051	2025-06-29 16:25:55.361051
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.368037	2025-06-29 16:25:55.368037
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.377492	2025-06-29 16:25:55.377492
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.386414	2025-06-29 16:25:55.386414
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.395769	2025-06-29 16:25:55.395769
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.398767	2025-06-29 16:25:55.398767
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.406763	2025-06-29 16:25:55.406763
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.418437	2025-06-29 16:25:55.418437
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.428631	2025-06-29 16:25:55.428631
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.447026	2025-06-29 16:25:55.447026
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.454396	2025-06-29 16:25:55.454396
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.465813	2025-06-29 16:25:55.465813
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.472767	2025-06-29 16:25:55.472767
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.484219	2025-06-29 16:25:55.484219
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.489414	2025-06-29 16:25:55.489414
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.502768	2025-06-29 16:25:55.502768
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.513624	2025-06-29 16:25:55.513624
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.523468	2025-06-29 16:25:55.523468
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.534414	2025-06-29 16:25:55.534414
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.54513	2025-06-29 16:25:55.54513
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.552331	2025-06-29 16:25:55.552331
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.561375	2025-06-29 16:25:55.561375
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.571241	2025-06-29 16:25:55.571241
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.578651	2025-06-29 16:25:55.578651
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.588797	2025-06-29 16:25:55.588797
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.601721	2025-06-29 16:25:55.601721
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.608711	2025-06-29 16:25:55.608711
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.618631	2025-06-29 16:25:55.618631
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.63018	2025-06-29 16:25:55.63018
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.643367	2025-06-29 16:25:55.643367
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.671652	2025-06-29 16:25:55.671652
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.681827	2025-06-29 16:25:55.681827
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.695556	2025-06-29 16:25:55.695556
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.720213	2025-06-29 16:25:55.720213
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.744645	2025-06-29 16:25:55.744645
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.753649	2025-06-29 16:25:55.753649
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.763526	2025-06-29 16:25:55.763526
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.772622	2025-06-29 16:25:55.772622
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.782744	2025-06-29 16:25:55.782744
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.793461	2025-06-29 16:25:55.793461
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.803104	2025-06-29 16:25:55.803104
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.817493	2025-06-29 16:25:55.817493
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.856741	2025-06-29 16:25:55.856741
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.866853	2025-06-29 16:25:55.866853
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.886312	2025-06-29 16:25:55.886312
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.926749	2025-06-29 16:25:55.926749
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.953376	2025-06-29 16:25:55.953376
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.957059	2025-06-29 16:25:55.957059
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.964512	2025-06-29 16:25:55.964512
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:55.981011	2025-06-29 16:25:55.981011
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.009532	2025-06-29 16:25:56.009532
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.020315	2025-06-29 16:25:56.020315
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.055789	2025-06-29 16:25:56.055789
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.065986	2025-06-29 16:25:56.065986
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.091161	2025-06-29 16:25:56.091161
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.102325	2025-06-29 16:25:56.102325
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.122403	2025-06-29 16:25:56.122403
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.140614	2025-06-29 16:25:56.140614
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.151572	2025-06-29 16:25:56.151572
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.1565	2025-06-29 16:25:56.1565
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.165014	2025-06-29 16:25:56.165014
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.171892	2025-06-29 16:25:56.171892
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.180064	2025-06-29 16:25:56.180064
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.190527	2025-06-29 16:25:56.190527
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.200692	2025-06-29 16:25:56.200692
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.210807	2025-06-29 16:25:56.210807
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.221646	2025-06-29 16:25:56.221646
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.25247	2025-06-29 16:25:56.25247
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.264843	2025-06-29 16:25:56.264843
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.298815	2025-06-29 16:25:56.298815
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.322089	2025-06-29 16:25:56.322089
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.327234	2025-06-29 16:25:56.327234
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.337928	2025-06-29 16:25:56.337928
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.352121	2025-06-29 16:25:56.352121
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.361059	2025-06-29 16:25:56.361059
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.378458	2025-06-29 16:25:56.378458
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.383956	2025-06-29 16:25:56.383956
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.391572	2025-06-29 16:25:56.391572
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.400049	2025-06-29 16:25:56.400049
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.407146	2025-06-29 16:25:56.407146
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.424497	2025-06-29 16:25:56.424497
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.434849	2025-06-29 16:25:56.434849
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.441784	2025-06-29 16:25:56.441784
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.448894	2025-06-29 16:25:56.448894
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.45603	2025-06-29 16:25:56.45603
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.462915	2025-06-29 16:25:56.462915
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.503788	2025-06-29 16:25:56.503788
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.518047	2025-06-29 16:25:56.518047
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.523316	2025-06-29 16:25:56.523316
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.534775	2025-06-29 16:25:56.534775
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.544136	2025-06-29 16:25:56.544136
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.549358	2025-06-29 16:25:56.549358
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.55804	2025-06-29 16:25:56.55804
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.575597	2025-06-29 16:25:56.575597
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.588619	2025-06-29 16:25:56.588619
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-29 16:25:56.618546	2025-06-29 16:25:56.618546
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 16:25:16.88499
2	ART Coverage	\N	\N	2025-06-29 16:25:16.901435
3	People Living with HIV	\N	\N	2025-06-29 16:25:16.94302
4	HIV-related Deaths	\N	\N	2025-06-29 16:25:16.952198
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 16:25:16.965864
6	ART Pediatric Coverage	\N	\N	2025-06-29 16:25:16.978708
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$/vWsCoV0OBYRnlFOQB7Kq.gzw4HpEJN0relocjjHBeUwEiUoMnWdm	admin	0	2025-06-29 16:25:16.795467	2025-06-29 16:25:16.795467
2	userch	$2b$12$U2zUF6EvWuFcn/8zufkpPeMRNzSmYyeEvuIzOvxj8gJfdRnNKQK3.	user	0	2025-06-29 16:25:16.819766	2025-06-29 16:25:16.819766
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

