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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-30 07:40:20.080531	2025-06-30 07:40:20.080531
2	Albania	Europe	\N	2025-06-30 07:40:20.085417	2025-06-30 07:40:20.085417
3	Algeria	Africa	\N	2025-06-30 07:40:20.089868	2025-06-30 07:40:20.089868
4	Angola	Africa	\N	2025-06-30 07:40:20.092287	2025-06-30 07:40:20.092287
5	Argentina	Americas	\N	2025-06-30 07:40:20.094794	2025-06-30 07:40:20.094794
6	Armenia	Europe	\N	2025-06-30 07:40:20.098836	2025-06-30 07:40:20.098836
7	Australia	Western Pacific	\N	2025-06-30 07:40:20.10151	2025-06-30 07:40:20.10151
8	Austria	Europe	\N	2025-06-30 07:40:20.10615	2025-06-30 07:40:20.10615
9	Azerbaijan	Europe	\N	2025-06-30 07:40:20.110658	2025-06-30 07:40:20.110658
10	Bahamas	Americas	\N	2025-06-30 07:40:20.115258	2025-06-30 07:40:20.115258
11	Bahrain	Eastern Mediterranean	\N	2025-06-30 07:40:20.119549	2025-06-30 07:40:20.119549
12	Bangladesh	South-East Asia	\N	2025-06-30 07:40:20.124122	2025-06-30 07:40:20.124122
13	Barbados	Americas	\N	2025-06-30 07:40:20.128786	2025-06-30 07:40:20.128786
14	Belarus	Europe	\N	2025-06-30 07:40:20.133574	2025-06-30 07:40:20.133574
15	Belgium	Europe	\N	2025-06-30 07:40:20.136318	2025-06-30 07:40:20.136318
16	Belize	Americas	\N	2025-06-30 07:40:20.139029	2025-06-30 07:40:20.139029
17	Benin	Africa	\N	2025-06-30 07:40:20.143701	2025-06-30 07:40:20.143701
18	Bhutan	South-East Asia	\N	2025-06-30 07:40:20.148335	2025-06-30 07:40:20.148335
19	Bolivia	Americas	\N	2025-06-30 07:40:20.152836	2025-06-30 07:40:20.152836
20	Bosnia and Herzegovina	Europe	\N	2025-06-30 07:40:20.155763	2025-06-30 07:40:20.155763
21	Botswana	Africa	\N	2025-06-30 07:40:20.160194	2025-06-30 07:40:20.160194
22	Brazil	Americas	\N	2025-06-30 07:40:20.164783	2025-06-30 07:40:20.164783
23	Brunei Darussalam	Western Pacific	\N	2025-06-30 07:40:20.169418	2025-06-30 07:40:20.169418
24	Bulgaria	Europe	\N	2025-06-30 07:40:20.173931	2025-06-30 07:40:20.173931
25	Burkina Faso	Africa	\N	2025-06-30 07:40:20.181873	2025-06-30 07:40:20.181873
26	Burundi	Africa	\N	2025-06-30 07:40:20.186505	2025-06-30 07:40:20.186505
27	Cabo Verde	Africa	\N	2025-06-30 07:40:20.189232	2025-06-30 07:40:20.189232
28	Cambodia	Western Pacific	\N	2025-06-30 07:40:20.193488	2025-06-30 07:40:20.193488
29	Cameroon	Africa	\N	2025-06-30 07:40:20.196331	2025-06-30 07:40:20.196331
30	Canada	Americas	\N	2025-06-30 07:40:20.202962	2025-06-30 07:40:20.202962
31	Central African Republic	Africa	\N	2025-06-30 07:40:20.205675	2025-06-30 07:40:20.205675
32	Chad	Africa	\N	2025-06-30 07:40:20.210476	2025-06-30 07:40:20.210476
33	Chile	Americas	\N	2025-06-30 07:40:20.21518	2025-06-30 07:40:20.21518
34	China	Western Pacific	\N	2025-06-30 07:40:20.22154	2025-06-30 07:40:20.22154
35	Colombia	Americas	\N	2025-06-30 07:40:20.22699	2025-06-30 07:40:20.22699
36	Comoros	Africa	\N	2025-06-30 07:40:20.232847	2025-06-30 07:40:20.232847
37	Congo	Americas	\N	2025-06-30 07:40:20.237037	2025-06-30 07:40:20.237037
38	Costa Rica	Americas	\N	2025-06-30 07:40:20.239734	2025-06-30 07:40:20.239734
39	Côte d'Ivoire	Africa	\N	2025-06-30 07:40:20.24235	2025-06-30 07:40:20.24235
40	Croatia	Europe	\N	2025-06-30 07:40:20.247026	2025-06-30 07:40:20.247026
41	Cuba	Americas	\N	2025-06-30 07:40:20.251826	2025-06-30 07:40:20.251826
42	Cyprus	Europe	\N	2025-06-30 07:40:20.256666	2025-06-30 07:40:20.256666
43	Czechia	Europe	\N	2025-06-30 07:40:20.26125	2025-06-30 07:40:20.26125
44	North Korea	Western Pacific	\N	2025-06-30 07:40:20.265831	2025-06-30 07:40:20.265831
45	DR Congo	Africa	\N	2025-06-30 07:40:20.268636	2025-06-30 07:40:20.268636
46	Denmark	Europe	\N	2025-06-30 07:40:20.272977	2025-06-30 07:40:20.272977
47	Djibouti	Eastern Mediterranean	\N	2025-06-30 07:40:20.277626	2025-06-30 07:40:20.277626
48	Dominican Republic	Americas	\N	2025-06-30 07:40:20.282375	2025-06-30 07:40:20.282375
49	Ecuador	Americas	\N	2025-06-30 07:40:20.287046	2025-06-30 07:40:20.287046
50	Egypt	Eastern Mediterranean	\N	2025-06-30 07:40:20.289825	2025-06-30 07:40:20.289825
51	El Salvador	Americas	\N	2025-06-30 07:40:20.293765	2025-06-30 07:40:20.293765
52	Equatorial Guinea	Africa	\N	2025-06-30 07:40:20.298291	2025-06-30 07:40:20.298291
53	Eritrea	Africa	\N	2025-06-30 07:40:20.301175	2025-06-30 07:40:20.301175
54	Estonia	Europe	\N	2025-06-30 07:40:20.305814	2025-06-30 07:40:20.305814
55	Eswatini	Africa	\N	2025-06-30 07:40:20.308547	2025-06-30 07:40:20.308547
56	Ethiopia	Africa	\N	2025-06-30 07:40:20.311228	2025-06-30 07:40:20.311228
57	Fiji	Western Pacific	\N	2025-06-30 07:40:20.31415	2025-06-30 07:40:20.31415
58	Finland	Europe	\N	2025-06-30 07:40:20.316969	2025-06-30 07:40:20.316969
59	France	Europe	\N	2025-06-30 07:40:20.319865	2025-06-30 07:40:20.319865
60	Gabon	Africa	\N	2025-06-30 07:40:20.322501	2025-06-30 07:40:20.322501
61	Gambia	Africa	\N	2025-06-30 07:40:20.325017	2025-06-30 07:40:20.325017
62	Georgia	Europe	\N	2025-06-30 07:40:20.329352	2025-06-30 07:40:20.329352
63	Germany	Europe	\N	2025-06-30 07:40:20.332423	2025-06-30 07:40:20.332423
64	Ghana	Africa	\N	2025-06-30 07:40:20.336594	2025-06-30 07:40:20.336594
65	Greece	Europe	\N	2025-06-30 07:40:20.340654	2025-06-30 07:40:20.340654
66	Guatemala	Americas	\N	2025-06-30 07:40:20.343366	2025-06-30 07:40:20.343366
67	Guinea	Africa	\N	2025-06-30 07:40:20.347607	2025-06-30 07:40:20.347607
68	Guinea-Bissau	Africa	\N	2025-06-30 07:40:20.35173	2025-06-30 07:40:20.35173
69	Guyana	Americas	\N	2025-06-30 07:40:20.356114	2025-06-30 07:40:20.356114
70	Haiti	Americas	\N	2025-06-30 07:40:20.360828	2025-06-30 07:40:20.360828
71	Honduras	Americas	\N	2025-06-30 07:40:20.365612	2025-06-30 07:40:20.365612
72	Hungary	Europe	\N	2025-06-30 07:40:20.370342	2025-06-30 07:40:20.370342
73	Iceland	Europe	\N	2025-06-30 07:40:20.374885	2025-06-30 07:40:20.374885
74	India	South-East Asia	\N	2025-06-30 07:40:20.379583	2025-06-30 07:40:20.379583
75	Indonesia	South-East Asia	\N	2025-06-30 07:40:20.38401	2025-06-30 07:40:20.38401
76	Iran	Eastern Mediterranean	\N	2025-06-30 07:40:20.388625	2025-06-30 07:40:20.388625
77	Ireland	Europe	\N	2025-06-30 07:40:20.393575	2025-06-30 07:40:20.393575
78	Israel	Europe	\N	2025-06-30 07:40:20.398274	2025-06-30 07:40:20.398274
79	Italy	Europe	\N	2025-06-30 07:40:20.403057	2025-06-30 07:40:20.403057
80	Jamaica	Americas	\N	2025-06-30 07:40:20.405687	2025-06-30 07:40:20.405687
81	Japan	Western Pacific	\N	2025-06-30 07:40:20.410005	2025-06-30 07:40:20.410005
82	Jordan	Eastern Mediterranean	\N	2025-06-30 07:40:20.414457	2025-06-30 07:40:20.414457
83	Kazakhstan	Europe	\N	2025-06-30 07:40:20.417315	2025-06-30 07:40:20.417315
84	Kenya	Africa	\N	2025-06-30 07:40:20.421981	2025-06-30 07:40:20.421981
85	Kuwait	Eastern Mediterranean	\N	2025-06-30 07:40:20.426664	2025-06-30 07:40:20.426664
86	Kyrgyzstan	Europe	\N	2025-06-30 07:40:20.432445	2025-06-30 07:40:20.432445
87	Laos	Western Pacific	\N	2025-06-30 07:40:20.437105	2025-06-30 07:40:20.437105
88	Latvia	Europe	\N	2025-06-30 07:40:20.441533	2025-06-30 07:40:20.441533
89	Lebanon	Eastern Mediterranean	\N	2025-06-30 07:40:20.445888	2025-06-30 07:40:20.445888
90	Lesotho	Africa	\N	2025-06-30 07:40:20.448549	2025-06-30 07:40:20.448549
91	Liberia	Africa	\N	2025-06-30 07:40:20.452388	2025-06-30 07:40:20.452388
92	Libya	Eastern Mediterranean	\N	2025-06-30 07:40:20.456835	2025-06-30 07:40:20.456835
93	Lithuania	Europe	\N	2025-06-30 07:40:20.461344	2025-06-30 07:40:20.461344
94	Luxembourg	Europe	\N	2025-06-30 07:40:20.464465	2025-06-30 07:40:20.464465
95	Madagascar	Africa	\N	2025-06-30 07:40:20.468879	2025-06-30 07:40:20.468879
96	Malawi	Africa	\N	2025-06-30 07:40:20.473239	2025-06-30 07:40:20.473239
97	Malaysia	Western Pacific	\N	2025-06-30 07:40:20.477761	2025-06-30 07:40:20.477761
98	Maldives	South-East Asia	\N	2025-06-30 07:40:20.482411	2025-06-30 07:40:20.482411
99	Mali	Africa	\N	2025-06-30 07:40:20.485179	2025-06-30 07:40:20.485179
100	Malta	Europe	\N	2025-06-30 07:40:20.489793	2025-06-30 07:40:20.489793
101	Mauritania	Africa	\N	2025-06-30 07:40:20.495845	2025-06-30 07:40:20.495845
102	Mauritius	Africa	\N	2025-06-30 07:40:20.501518	2025-06-30 07:40:20.501518
103	Mexico	Americas	\N	2025-06-30 07:40:20.507458	2025-06-30 07:40:20.507458
104	Mongolia	Western Pacific	\N	2025-06-30 07:40:20.513065	2025-06-30 07:40:20.513065
105	Montenegro	Europe	\N	2025-06-30 07:40:20.515762	2025-06-30 07:40:20.515762
106	Morocco	Eastern Mediterranean	\N	2025-06-30 07:40:20.522036	2025-06-30 07:40:20.522036
107	Mozambique	Africa	\N	2025-06-30 07:40:20.525939	2025-06-30 07:40:20.525939
108	Myanmar	South-East Asia	\N	2025-06-30 07:40:20.530166	2025-06-30 07:40:20.530166
109	Namibia	Africa	\N	2025-06-30 07:40:20.53786	2025-06-30 07:40:20.53786
110	Nepal	South-East Asia	\N	2025-06-30 07:40:20.541853	2025-06-30 07:40:20.541853
111	Netherlands	Europe	\N	2025-06-30 07:40:20.546146	2025-06-30 07:40:20.546146
112	New Zealand	Western Pacific	\N	2025-06-30 07:40:20.548759	2025-06-30 07:40:20.548759
113	Nicaragua	Americas	\N	2025-06-30 07:40:20.554233	2025-06-30 07:40:20.554233
114	Niger	Africa	\N	2025-06-30 07:40:20.563699	2025-06-30 07:40:20.563699
115	Nigeria	Africa	\N	2025-06-30 07:40:20.567884	2025-06-30 07:40:20.567884
116	Norway	Europe	\N	2025-06-30 07:40:20.571951	2025-06-30 07:40:20.571951
117	Oman	Eastern Mediterranean	\N	2025-06-30 07:40:20.576222	2025-06-30 07:40:20.576222
118	Pakistan	Eastern Mediterranean	\N	2025-06-30 07:40:20.580507	2025-06-30 07:40:20.580507
119	Panama	Americas	\N	2025-06-30 07:40:20.58298	2025-06-30 07:40:20.58298
120	Papua New Guinea	Western Pacific	\N	2025-06-30 07:40:20.586938	2025-06-30 07:40:20.586938
121	Paraguay	Americas	\N	2025-06-30 07:40:20.591	2025-06-30 07:40:20.591
122	Peru	Americas	\N	2025-06-30 07:40:20.593565	2025-06-30 07:40:20.593565
123	Philippines	Western Pacific	\N	2025-06-30 07:40:20.597596	2025-06-30 07:40:20.597596
124	Poland	Europe	\N	2025-06-30 07:40:20.601653	2025-06-30 07:40:20.601653
125	Portugal	Europe	\N	2025-06-30 07:40:20.604233	2025-06-30 07:40:20.604233
126	Qatar	Eastern Mediterranean	\N	2025-06-30 07:40:20.608205	2025-06-30 07:40:20.608205
127	South Korea	Western Pacific	\N	2025-06-30 07:40:20.612244	2025-06-30 07:40:20.612244
128	Moldova	Europe	\N	2025-06-30 07:40:20.616218	2025-06-30 07:40:20.616218
129	North Macedonia	Europe	\N	2025-06-30 07:40:20.620244	2025-06-30 07:40:20.620244
130	Romania	Europe	\N	2025-06-30 07:40:20.624656	2025-06-30 07:40:20.624656
131	Russia	Europe	\N	2025-06-30 07:40:20.627092	2025-06-30 07:40:20.627092
132	Rwanda	Africa	\N	2025-06-30 07:40:20.631083	2025-06-30 07:40:20.631083
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-30 07:40:20.635291	2025-06-30 07:40:20.635291
134	Senegal	Africa	\N	2025-06-30 07:40:20.639611	2025-06-30 07:40:20.639611
135	Serbia	Europe	\N	2025-06-30 07:40:20.642298	2025-06-30 07:40:20.642298
136	Sierra Leone	Africa	\N	2025-06-30 07:40:20.646332	2025-06-30 07:40:20.646332
137	Singapore	Western Pacific	\N	2025-06-30 07:40:20.649099	2025-06-30 07:40:20.649099
138	Slovakia	Europe	\N	2025-06-30 07:40:20.653256	2025-06-30 07:40:20.653256
139	Slovenia	Europe	\N	2025-06-30 07:40:20.657543	2025-06-30 07:40:20.657543
140	Somalia	Eastern Mediterranean	\N	2025-06-30 07:40:20.659995	2025-06-30 07:40:20.659995
141	South Africa	Africa	\N	2025-06-30 07:40:20.663912	2025-06-30 07:40:20.663912
142	South Sudan	Africa	\N	2025-06-30 07:40:20.666536	2025-06-30 07:40:20.666536
143	Spain	Europe	\N	2025-06-30 07:40:20.672413	2025-06-30 07:40:20.672413
144	Sri Lanka	South-East Asia	\N	2025-06-30 07:40:20.683725	2025-06-30 07:40:20.683725
145	Sudan	Eastern Mediterranean	\N	2025-06-30 07:40:20.686786	2025-06-30 07:40:20.686786
146	Suriname	Americas	\N	2025-06-30 07:40:20.689504	2025-06-30 07:40:20.689504
147	Sweden	Europe	\N	2025-06-30 07:40:20.692012	2025-06-30 07:40:20.692012
148	Switzerland	Europe	\N	2025-06-30 07:40:20.696386	2025-06-30 07:40:20.696386
149	Syria	Eastern Mediterranean	\N	2025-06-30 07:40:20.699939	2025-06-30 07:40:20.699939
150	Tajikistan	Europe	\N	2025-06-30 07:40:20.704437	2025-06-30 07:40:20.704437
151	Thailand	South-East Asia	\N	2025-06-30 07:40:20.708538	2025-06-30 07:40:20.708538
152	Timor-Leste	South-East Asia	\N	2025-06-30 07:40:20.711665	2025-06-30 07:40:20.711665
153	Togo	Africa	\N	2025-06-30 07:40:20.716147	2025-06-30 07:40:20.716147
154	Trinidad and Tobago	Americas	\N	2025-06-30 07:40:20.720388	2025-06-30 07:40:20.720388
155	Tunisia	Eastern Mediterranean	\N	2025-06-30 07:40:20.723095	2025-06-30 07:40:20.723095
156	Turkey	Europe	\N	2025-06-30 07:40:20.725656	2025-06-30 07:40:20.725656
157	Turkmenistan	Europe	\N	2025-06-30 07:40:20.729424	2025-06-30 07:40:20.729424
158	Uganda	Africa	\N	2025-06-30 07:40:20.733579	2025-06-30 07:40:20.733579
159	Ukraine	Europe	\N	2025-06-30 07:40:20.737722	2025-06-30 07:40:20.737722
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-30 07:40:20.740081	2025-06-30 07:40:20.740081
161	United Kingdom	Europe	\N	2025-06-30 07:40:20.744361	2025-06-30 07:40:20.744361
162	Tanzania	Africa	\N	2025-06-30 07:40:20.748498	2025-06-30 07:40:20.748498
163	United States	Americas	\N	2025-06-30 07:40:20.751242	2025-06-30 07:40:20.751242
164	Uruguay	Americas	\N	2025-06-30 07:40:20.753839	2025-06-30 07:40:20.753839
165	Uzbekistan	Europe	\N	2025-06-30 07:40:20.756338	2025-06-30 07:40:20.756338
166	Venezuela	Americas	\N	2025-06-30 07:40:20.760395	2025-06-30 07:40:20.760395
167	Viet Nam	Western Pacific	\N	2025-06-30 07:40:20.76305	2025-06-30 07:40:20.76305
168	Yemen	Eastern Mediterranean	\N	2025-06-30 07:40:20.767371	2025-06-30 07:40:20.767371
169	Zambia	Africa	\N	2025-06-30 07:40:20.773115	2025-06-30 07:40:20.773115
170	Zimbabwe	Africa	\N	2025-06-30 07:40:20.777986	2025-06-30 07:40:20.777986
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.780942	2025-06-30 07:40:20.780942
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.785258	2025-06-30 07:40:20.785258
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.789807	2025-06-30 07:40:20.789807
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.793964	2025-06-30 07:40:20.793964
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.798461	2025-06-30 07:40:20.798461
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.802985	2025-06-30 07:40:20.802985
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.805812	2025-06-30 07:40:20.805812
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.810012	2025-06-30 07:40:20.810012
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.814016	2025-06-30 07:40:20.814016
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.81665	2025-06-30 07:40:20.81665
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.821138	2025-06-30 07:40:20.821138
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.823893	2025-06-30 07:40:20.823893
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.828599	2025-06-30 07:40:20.828599
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.831333	2025-06-30 07:40:20.831333
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.836048	2025-06-30 07:40:20.836048
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.840633	2025-06-30 07:40:20.840633
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.847013	2025-06-30 07:40:20.847013
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.851508	2025-06-30 07:40:20.851508
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.854339	2025-06-30 07:40:20.854339
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.858594	2025-06-30 07:40:20.858594
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.863378	2025-06-30 07:40:20.863378
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.867781	2025-06-30 07:40:20.867781
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.874084	2025-06-30 07:40:20.874084
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.876797	2025-06-30 07:40:20.876797
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.880915	2025-06-30 07:40:20.880915
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.883732	2025-06-30 07:40:20.883732
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.887894	2025-06-30 07:40:20.887894
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.8922	2025-06-30 07:40:20.8922
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.896631	2025-06-30 07:40:20.896631
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.900948	2025-06-30 07:40:20.900948
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.903671	2025-06-30 07:40:20.903671
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.90654	2025-06-30 07:40:20.90654
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.909536	2025-06-30 07:40:20.909536
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.914321	2025-06-30 07:40:20.914321
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.917385	2025-06-30 07:40:20.917385
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.921969	2025-06-30 07:40:20.921969
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.924754	2025-06-30 07:40:20.924754
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.929359	2025-06-30 07:40:20.929359
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.934763	2025-06-30 07:40:20.934763
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.938911	2025-06-30 07:40:20.938911
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.941666	2025-06-30 07:40:20.941666
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.946203	2025-06-30 07:40:20.946203
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.952856	2025-06-30 07:40:20.952856
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.958986	2025-06-30 07:40:20.958986
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.961842	2025-06-30 07:40:20.961842
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.964629	2025-06-30 07:40:20.964629
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.968722	2025-06-30 07:40:20.968722
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.971432	2025-06-30 07:40:20.971432
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.976129	2025-06-30 07:40:20.976129
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.98092	2025-06-30 07:40:20.98092
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.98783	2025-06-30 07:40:20.98783
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.9905	2025-06-30 07:40:20.9905
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.995726	2025-06-30 07:40:20.995726
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:20.999371	2025-06-30 07:40:20.999371
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.007719	2025-06-30 07:40:21.007719
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.010415	2025-06-30 07:40:21.010415
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.013163	2025-06-30 07:40:21.013163
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.017677	2025-06-30 07:40:21.017677
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.022103	2025-06-30 07:40:21.022103
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.028181	2025-06-30 07:40:21.028181
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.034071	2025-06-30 07:40:21.034071
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.038421	2025-06-30 07:40:21.038421
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.042987	2025-06-30 07:40:21.042987
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.045715	2025-06-30 07:40:21.045715
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.050268	2025-06-30 07:40:21.050268
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.054953	2025-06-30 07:40:21.054953
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.059246	2025-06-30 07:40:21.059246
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.063967	2025-06-30 07:40:21.063967
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.066731	2025-06-30 07:40:21.066731
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.071287	2025-06-30 07:40:21.071287
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.080167	2025-06-30 07:40:21.080167
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.082963	2025-06-30 07:40:21.082963
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.087394	2025-06-30 07:40:21.087394
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.089942	2025-06-30 07:40:21.089942
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.092716	2025-06-30 07:40:21.092716
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.095399	2025-06-30 07:40:21.095399
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.098172	2025-06-30 07:40:21.098172
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.104099	2025-06-30 07:40:21.104099
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.108183	2025-06-30 07:40:21.108183
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.114651	2025-06-30 07:40:21.114651
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.117309	2025-06-30 07:40:21.117309
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.125083	2025-06-30 07:40:21.125083
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.127843	2025-06-30 07:40:21.127843
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.132424	2025-06-30 07:40:21.132424
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.137097	2025-06-30 07:40:21.137097
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.141681	2025-06-30 07:40:21.141681
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.14505	2025-06-30 07:40:21.14505
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.151205	2025-06-30 07:40:21.151205
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.155224	2025-06-30 07:40:21.155224
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.159639	2025-06-30 07:40:21.159639
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.164173	2025-06-30 07:40:21.164173
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.16899	2025-06-30 07:40:21.16899
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.17354	2025-06-30 07:40:21.17354
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.180325	2025-06-30 07:40:21.180325
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.18535	2025-06-30 07:40:21.18535
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.188165	2025-06-30 07:40:21.188165
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.192891	2025-06-30 07:40:21.192891
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.195746	2025-06-30 07:40:21.195746
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.200508	2025-06-30 07:40:21.200508
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.205189	2025-06-30 07:40:21.205189
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.2079	2025-06-30 07:40:21.2079
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.211841	2025-06-30 07:40:21.211841
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.214724	2025-06-30 07:40:21.214724
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.219177	2025-06-30 07:40:21.219177
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.221977	2025-06-30 07:40:21.221977
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.22674	2025-06-30 07:40:21.22674
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.22959	2025-06-30 07:40:21.22959
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.232364	2025-06-30 07:40:21.232364
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.235166	2025-06-30 07:40:21.235166
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.237953	2025-06-30 07:40:21.237953
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.242763	2025-06-30 07:40:21.242763
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.245539	2025-06-30 07:40:21.245539
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.249859	2025-06-30 07:40:21.249859
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.252733	2025-06-30 07:40:21.252733
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.255641	2025-06-30 07:40:21.255641
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.260044	2025-06-30 07:40:21.260044
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.262922	2025-06-30 07:40:21.262922
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.265729	2025-06-30 07:40:21.265729
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.270507	2025-06-30 07:40:21.270507
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.273345	2025-06-30 07:40:21.273345
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.279964	2025-06-30 07:40:21.279964
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.282599	2025-06-30 07:40:21.282599
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.287468	2025-06-30 07:40:21.287468
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.292137	2025-06-30 07:40:21.292137
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.296662	2025-06-30 07:40:21.296662
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.299667	2025-06-30 07:40:21.299667
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.304381	2025-06-30 07:40:21.304381
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.307077	2025-06-30 07:40:21.307077
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.311769	2025-06-30 07:40:21.311769
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.318588	2025-06-30 07:40:21.318588
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.323138	2025-06-30 07:40:21.323138
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.325769	2025-06-30 07:40:21.325769
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.329733	2025-06-30 07:40:21.329733
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.332597	2025-06-30 07:40:21.332597
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.337155	2025-06-30 07:40:21.337155
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.34204	2025-06-30 07:40:21.34204
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.346971	2025-06-30 07:40:21.346971
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.351636	2025-06-30 07:40:21.351636
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.354504	2025-06-30 07:40:21.354504
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.359103	2025-06-30 07:40:21.359103
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.363986	2025-06-30 07:40:21.363986
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.368437	2025-06-30 07:40:21.368437
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.371368	2025-06-30 07:40:21.371368
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.374498	2025-06-30 07:40:21.374498
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.377265	2025-06-30 07:40:21.377265
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.381849	2025-06-30 07:40:21.381849
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.384681	2025-06-30 07:40:21.384681
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.389113	2025-06-30 07:40:21.389113
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.393648	2025-06-30 07:40:21.393648
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.398318	2025-06-30 07:40:21.398318
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.403011	2025-06-30 07:40:21.403011
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.407844	2025-06-30 07:40:21.407844
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.412742	2025-06-30 07:40:21.412742
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.417405	2025-06-30 07:40:21.417405
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.421846	2025-06-30 07:40:21.421846
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.424654	2025-06-30 07:40:21.424654
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.43108	2025-06-30 07:40:21.43108
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.436064	2025-06-30 07:40:21.436064
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.438864	2025-06-30 07:40:21.438864
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.443356	2025-06-30 07:40:21.443356
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.446175	2025-06-30 07:40:21.446175
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.448929	2025-06-30 07:40:21.448929
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.451764	2025-06-30 07:40:21.451764
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.456439	2025-06-30 07:40:21.456439
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.459189	2025-06-30 07:40:21.459189
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.462293	2025-06-30 07:40:21.462293
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.465185	2025-06-30 07:40:21.465185
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.472012	2025-06-30 07:40:21.472012
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.476531	2025-06-30 07:40:21.476531
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.481174	2025-06-30 07:40:21.481174
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.485556	2025-06-30 07:40:21.485556
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.490342	2025-06-30 07:40:21.490342
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.497208	2025-06-30 07:40:21.497208
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.505329	2025-06-30 07:40:21.505329
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.511313	2025-06-30 07:40:21.511313
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.5155	2025-06-30 07:40:21.5155
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.521761	2025-06-30 07:40:21.521761
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.524376	2025-06-30 07:40:21.524376
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.530698	2025-06-30 07:40:21.530698
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.536752	2025-06-30 07:40:21.536752
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.542661	2025-06-30 07:40:21.542661
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.548909	2025-06-30 07:40:21.548909
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.555062	2025-06-30 07:40:21.555062
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.559424	2025-06-30 07:40:21.559424
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.565768	2025-06-30 07:40:21.565768
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.571488	2025-06-30 07:40:21.571488
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.577569	2025-06-30 07:40:21.577569
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.583482	2025-06-30 07:40:21.583482
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.589547	2025-06-30 07:40:21.589547
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.595655	2025-06-30 07:40:21.595655
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.601183	2025-06-30 07:40:21.601183
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.607761	2025-06-30 07:40:21.607761
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.613599	2025-06-30 07:40:21.613599
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.619647	2025-06-30 07:40:21.619647
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.624065	2025-06-30 07:40:21.624065
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.626838	2025-06-30 07:40:21.626838
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.631068	2025-06-30 07:40:21.631068
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.637073	2025-06-30 07:40:21.637073
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.642892	2025-06-30 07:40:21.642892
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.645578	2025-06-30 07:40:21.645578
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.650883	2025-06-30 07:40:21.650883
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.695925	2025-06-30 07:40:21.695925
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.701813	2025-06-30 07:40:21.701813
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.711424	2025-06-30 07:40:21.711424
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.750365	2025-06-30 07:40:21.750365
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.756018	2025-06-30 07:40:21.756018
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.758565	2025-06-30 07:40:21.758565
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.760963	2025-06-30 07:40:21.760963
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.796461	2025-06-30 07:40:21.796461
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.803565	2025-06-30 07:40:21.803565
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.842025	2025-06-30 07:40:21.842025
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.848034	2025-06-30 07:40:21.848034
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.856223	2025-06-30 07:40:21.856223
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.859218	2025-06-30 07:40:21.859218
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.863964	2025-06-30 07:40:21.863964
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.86989	2025-06-30 07:40:21.86989
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.908497	2025-06-30 07:40:21.908497
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.915111	2025-06-30 07:40:21.915111
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.919901	2025-06-30 07:40:21.919901
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.936899	2025-06-30 07:40:21.936899
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.942719	2025-06-30 07:40:21.942719
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.949376	2025-06-30 07:40:21.949376
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.955411	2025-06-30 07:40:21.955411
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.961599	2025-06-30 07:40:21.961599
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.965782	2025-06-30 07:40:21.965782
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.970363	2025-06-30 07:40:21.970363
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.977657	2025-06-30 07:40:21.977657
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:21.984221	2025-06-30 07:40:21.984221
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.017817	2025-06-30 07:40:22.017817
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.025092	2025-06-30 07:40:22.025092
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.063027	2025-06-30 07:40:22.063027
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.066259	2025-06-30 07:40:22.066259
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.069528	2025-06-30 07:40:22.069528
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.073928	2025-06-30 07:40:22.073928
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.109809	2025-06-30 07:40:22.109809
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.114279	2025-06-30 07:40:22.114279
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.118901	2025-06-30 07:40:22.118901
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.154436	2025-06-30 07:40:22.154436
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.192908	2025-06-30 07:40:22.192908
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.197687	2025-06-30 07:40:22.197687
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.202059	2025-06-30 07:40:22.202059
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.206221	2025-06-30 07:40:22.206221
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.210708	2025-06-30 07:40:22.210708
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.216891	2025-06-30 07:40:22.216891
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.22306	2025-06-30 07:40:22.22306
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.228877	2025-06-30 07:40:22.228877
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.234959	2025-06-30 07:40:22.234959
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.241123	2025-06-30 07:40:22.241123
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.247998	2025-06-30 07:40:22.247998
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.252048	2025-06-30 07:40:22.252048
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.256401	2025-06-30 07:40:22.256401
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.260409	2025-06-30 07:40:22.260409
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.264576	2025-06-30 07:40:22.264576
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.271025	2025-06-30 07:40:22.271025
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.275329	2025-06-30 07:40:22.275329
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.278661	2025-06-30 07:40:22.278661
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.28326	2025-06-30 07:40:22.28326
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.287748	2025-06-30 07:40:22.287748
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.296233	2025-06-30 07:40:22.296233
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.301109	2025-06-30 07:40:22.301109
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.305588	2025-06-30 07:40:22.305588
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.316246	2025-06-30 07:40:22.316246
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.320717	2025-06-30 07:40:22.320717
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.325062	2025-06-30 07:40:22.325062
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.329213	2025-06-30 07:40:22.329213
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.333342	2025-06-30 07:40:22.333342
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.337561	2025-06-30 07:40:22.337561
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.341682	2025-06-30 07:40:22.341682
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.346024	2025-06-30 07:40:22.346024
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.351056	2025-06-30 07:40:22.351056
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.355902	2025-06-30 07:40:22.355902
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.461661	2025-06-30 07:40:22.461661
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.467664	2025-06-30 07:40:22.467664
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.470709	2025-06-30 07:40:22.470709
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.47361	2025-06-30 07:40:22.47361
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.477816	2025-06-30 07:40:22.477816
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.514058	2025-06-30 07:40:22.514058
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.519034	2025-06-30 07:40:22.519034
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.523733	2025-06-30 07:40:22.523733
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.539484	2025-06-30 07:40:22.539484
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.544172	2025-06-30 07:40:22.544172
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.573954	2025-06-30 07:40:22.573954
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.576731	2025-06-30 07:40:22.576731
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.594459	2025-06-30 07:40:22.594459
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.601803	2025-06-30 07:40:22.601803
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.619418	2025-06-30 07:40:22.619418
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.625873	2025-06-30 07:40:22.625873
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.632153	2025-06-30 07:40:22.632153
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.64679	2025-06-30 07:40:22.64679
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.653091	2025-06-30 07:40:22.653091
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.659355	2025-06-30 07:40:22.659355
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.665426	2025-06-30 07:40:22.665426
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.671524	2025-06-30 07:40:22.671524
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.679082	2025-06-30 07:40:22.679082
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.692162	2025-06-30 07:40:22.692162
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.694752	2025-06-30 07:40:22.694752
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.701659	2025-06-30 07:40:22.701659
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.707413	2025-06-30 07:40:22.707413
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.713072	2025-06-30 07:40:22.713072
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.719157	2025-06-30 07:40:22.719157
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.724978	2025-06-30 07:40:22.724978
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.730955	2025-06-30 07:40:22.730955
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.768577	2025-06-30 07:40:22.768577
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 07:40:22.774827	2025-06-30 07:40:22.774827
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.81276	2025-06-30 07:40:22.81276
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.819168	2025-06-30 07:40:22.819168
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.85655	2025-06-30 07:40:22.85655
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.862975	2025-06-30 07:40:22.862975
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.900559	2025-06-30 07:40:22.900559
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.906855	2025-06-30 07:40:22.906855
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.944179	2025-06-30 07:40:22.944179
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.953012	2025-06-30 07:40:22.953012
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.959655	2025-06-30 07:40:22.959655
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:22.996955	2025-06-30 07:40:22.996955
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.003053	2025-06-30 07:40:23.003053
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.009575	2025-06-30 07:40:23.009575
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.015871	2025-06-30 07:40:23.015871
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.053954	2025-06-30 07:40:23.053954
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.060985	2025-06-30 07:40:23.060985
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.098759	2025-06-30 07:40:23.098759
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.104907	2025-06-30 07:40:23.104907
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.139121	2025-06-30 07:40:23.139121
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.145033	2025-06-30 07:40:23.145033
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.171897	2025-06-30 07:40:23.171897
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.177906	2025-06-30 07:40:23.177906
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.19608	2025-06-30 07:40:23.19608
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.201956	2025-06-30 07:40:23.201956
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.207909	2025-06-30 07:40:23.207909
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.245543	2025-06-30 07:40:23.245543
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.251302	2025-06-30 07:40:23.251302
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.257612	2025-06-30 07:40:23.257612
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.26358	2025-06-30 07:40:23.26358
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.301527	2025-06-30 07:40:23.301527
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.308423	2025-06-30 07:40:23.308423
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.346619	2025-06-30 07:40:23.346619
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.352639	2025-06-30 07:40:23.352639
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.35856	2025-06-30 07:40:23.35856
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.364484	2025-06-30 07:40:23.364484
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.370588	2025-06-30 07:40:23.370588
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.376403	2025-06-30 07:40:23.376403
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.402827	2025-06-30 07:40:23.402827
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.411332	2025-06-30 07:40:23.411332
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.452739	2025-06-30 07:40:23.452739
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.459655	2025-06-30 07:40:23.459655
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.497834	2025-06-30 07:40:23.497834
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.50628	2025-06-30 07:40:23.50628
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.541465	2025-06-30 07:40:23.541465
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.552729	2025-06-30 07:40:23.552729
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.559379	2025-06-30 07:40:23.559379
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.565218	2025-06-30 07:40:23.565218
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.571151	2025-06-30 07:40:23.571151
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.577046	2025-06-30 07:40:23.577046
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.583106	2025-06-30 07:40:23.583106
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.589908	2025-06-30 07:40:23.589908
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.597113	2025-06-30 07:40:23.597113
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.603674	2025-06-30 07:40:23.603674
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.60956	2025-06-30 07:40:23.60956
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.615763	2025-06-30 07:40:23.615763
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.621749	2025-06-30 07:40:23.621749
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.627854	2025-06-30 07:40:23.627854
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.633905	2025-06-30 07:40:23.633905
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.639948	2025-06-30 07:40:23.639948
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.646251	2025-06-30 07:40:23.646251
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.652748	2025-06-30 07:40:23.652748
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.658953	2025-06-30 07:40:23.658953
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.664836	2025-06-30 07:40:23.664836
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.670851	2025-06-30 07:40:23.670851
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.677246	2025-06-30 07:40:23.677246
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.683382	2025-06-30 07:40:23.683382
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.688796	2025-06-30 07:40:23.688796
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.694536	2025-06-30 07:40:23.694536
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.703342	2025-06-30 07:40:23.703342
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.706229	2025-06-30 07:40:23.706229
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.709449	2025-06-30 07:40:23.709449
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.713831	2025-06-30 07:40:23.713831
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.71979	2025-06-30 07:40:23.71979
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.725971	2025-06-30 07:40:23.725971
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.732029	2025-06-30 07:40:23.732029
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.738216	2025-06-30 07:40:23.738216
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.744079	2025-06-30 07:40:23.744079
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.751983	2025-06-30 07:40:23.751983
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.756087	2025-06-30 07:40:23.756087
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.760185	2025-06-30 07:40:23.760185
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.765947	2025-06-30 07:40:23.765947
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.771866	2025-06-30 07:40:23.771866
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.778022	2025-06-30 07:40:23.778022
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.784755	2025-06-30 07:40:23.784755
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.790682	2025-06-30 07:40:23.790682
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.796576	2025-06-30 07:40:23.796576
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.802594	2025-06-30 07:40:23.802594
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.808309	2025-06-30 07:40:23.808309
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.814226	2025-06-30 07:40:23.814226
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.820279	2025-06-30 07:40:23.820279
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.827043	2025-06-30 07:40:23.827043
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.833287	2025-06-30 07:40:23.833287
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.839432	2025-06-30 07:40:23.839432
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.845393	2025-06-30 07:40:23.845393
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.851412	2025-06-30 07:40:23.851412
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.857448	2025-06-30 07:40:23.857448
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.863339	2025-06-30 07:40:23.863339
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.869393	2025-06-30 07:40:23.869393
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.876632	2025-06-30 07:40:23.876632
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.882842	2025-06-30 07:40:23.882842
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.888763	2025-06-30 07:40:23.888763
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.896149	2025-06-30 07:40:23.896149
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.902524	2025-06-30 07:40:23.902524
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.908657	2025-06-30 07:40:23.908657
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.91458	2025-06-30 07:40:23.91458
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.921434	2025-06-30 07:40:23.921434
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.929843	2025-06-30 07:40:23.929843
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.937278	2025-06-30 07:40:23.937278
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.943318	2025-06-30 07:40:23.943318
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.948977	2025-06-30 07:40:23.948977
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.955012	2025-06-30 07:40:23.955012
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.960845	2025-06-30 07:40:23.960845
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.967294	2025-06-30 07:40:23.967294
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.973256	2025-06-30 07:40:23.973256
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.979418	2025-06-30 07:40:23.979418
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.985394	2025-06-30 07:40:23.985394
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.992392	2025-06-30 07:40:23.992392
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:23.998098	2025-06-30 07:40:23.998098
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.003832	2025-06-30 07:40:24.003832
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.009659	2025-06-30 07:40:24.009659
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.015544	2025-06-30 07:40:24.015544
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.021452	2025-06-30 07:40:24.021452
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.027137	2025-06-30 07:40:24.027137
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.034571	2025-06-30 07:40:24.034571
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.04025	2025-06-30 07:40:24.04025
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.045856	2025-06-30 07:40:24.045856
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.051543	2025-06-30 07:40:24.051543
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.05756	2025-06-30 07:40:24.05756
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.063332	2025-06-30 07:40:24.063332
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.068926	2025-06-30 07:40:24.068926
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.076545	2025-06-30 07:40:24.076545
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.082142	2025-06-30 07:40:24.082142
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.088668	2025-06-30 07:40:24.088668
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.094225	2025-06-30 07:40:24.094225
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.099998	2025-06-30 07:40:24.099998
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.107418	2025-06-30 07:40:24.107418
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.113339	2025-06-30 07:40:24.113339
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.119368	2025-06-30 07:40:24.119368
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.12664	2025-06-30 07:40:24.12664
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.134133	2025-06-30 07:40:24.134133
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.140253	2025-06-30 07:40:24.140253
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.14687	2025-06-30 07:40:24.14687
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.153877	2025-06-30 07:40:24.153877
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.160641	2025-06-30 07:40:24.160641
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.168739	2025-06-30 07:40:24.168739
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.175456	2025-06-30 07:40:24.175456
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.182583	2025-06-30 07:40:24.182583
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.189094	2025-06-30 07:40:24.189094
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.196293	2025-06-30 07:40:24.196293
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.202712	2025-06-30 07:40:24.202712
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.209464	2025-06-30 07:40:24.209464
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.216769	2025-06-30 07:40:24.216769
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.229001	2025-06-30 07:40:24.229001
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.236247	2025-06-30 07:40:24.236247
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.274759	2025-06-30 07:40:24.274759
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.282011	2025-06-30 07:40:24.282011
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.313514	2025-06-30 07:40:24.313514
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.320457	2025-06-30 07:40:24.320457
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.334361	2025-06-30 07:40:24.334361
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.341815	2025-06-30 07:40:24.341815
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.351809	2025-06-30 07:40:24.351809
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.358649	2025-06-30 07:40:24.358649
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.366451	2025-06-30 07:40:24.366451
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.373769	2025-06-30 07:40:24.373769
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.380382	2025-06-30 07:40:24.380382
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.387393	2025-06-30 07:40:24.387393
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.392282	2025-06-30 07:40:24.392282
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.398537	2025-06-30 07:40:24.398537
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.406475	2025-06-30 07:40:24.406475
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.414489	2025-06-30 07:40:24.414489
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.442446	2025-06-30 07:40:24.442446
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.450368	2025-06-30 07:40:24.450368
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.456941	2025-06-30 07:40:24.456941
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.483916	2025-06-30 07:40:24.483916
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.491132	2025-06-30 07:40:24.491132
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.508234	2025-06-30 07:40:24.508234
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.515194	2025-06-30 07:40:24.515194
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.538806	2025-06-30 07:40:24.538806
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.546047	2025-06-30 07:40:24.546047
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.564659	2025-06-30 07:40:24.564659
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.572173	2025-06-30 07:40:24.572173
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.5834	2025-06-30 07:40:24.5834
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.590568	2025-06-30 07:40:24.590568
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.59754	2025-06-30 07:40:24.59754
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.607643	2025-06-30 07:40:24.607643
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.6154	2025-06-30 07:40:24.6154
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.623549	2025-06-30 07:40:24.623549
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.630557	2025-06-30 07:40:24.630557
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.637242	2025-06-30 07:40:24.637242
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.644405	2025-06-30 07:40:24.644405
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.651455	2025-06-30 07:40:24.651455
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.658472	2025-06-30 07:40:24.658472
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.665422	2025-06-30 07:40:24.665422
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.6737	2025-06-30 07:40:24.6737
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.680931	2025-06-30 07:40:24.680931
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.687792	2025-06-30 07:40:24.687792
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.694738	2025-06-30 07:40:24.694738
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.702201	2025-06-30 07:40:24.702201
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.710987	2025-06-30 07:40:24.710987
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.718286	2025-06-30 07:40:24.718286
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.746765	2025-06-30 07:40:24.746765
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.753967	2025-06-30 07:40:24.753967
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.761631	2025-06-30 07:40:24.761631
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.768878	2025-06-30 07:40:24.768878
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.776124	2025-06-30 07:40:24.776124
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.783117	2025-06-30 07:40:24.783117
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.789756	2025-06-30 07:40:24.789756
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.796758	2025-06-30 07:40:24.796758
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.805266	2025-06-30 07:40:24.805266
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.81238	2025-06-30 07:40:24.81238
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.819403	2025-06-30 07:40:24.819403
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.826226	2025-06-30 07:40:24.826226
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.832783	2025-06-30 07:40:24.832783
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.839505	2025-06-30 07:40:24.839505
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.845751	2025-06-30 07:40:24.845751
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.852796	2025-06-30 07:40:24.852796
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.859657	2025-06-30 07:40:24.859657
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.866866	2025-06-30 07:40:24.866866
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.873643	2025-06-30 07:40:24.873643
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.880758	2025-06-30 07:40:24.880758
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.888106	2025-06-30 07:40:24.888106
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.895051	2025-06-30 07:40:24.895051
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.902173	2025-06-30 07:40:24.902173
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.910138	2025-06-30 07:40:24.910138
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.91933	2025-06-30 07:40:24.91933
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.926403	2025-06-30 07:40:24.926403
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.933323	2025-06-30 07:40:24.933323
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.940373	2025-06-30 07:40:24.940373
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.947542	2025-06-30 07:40:24.947542
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.954097	2025-06-30 07:40:24.954097
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.960862	2025-06-30 07:40:24.960862
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.968304	2025-06-30 07:40:24.968304
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.97648	2025-06-30 07:40:24.97648
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.982902	2025-06-30 07:40:24.982902
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.991664	2025-06-30 07:40:24.991664
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:24.99861	2025-06-30 07:40:24.99861
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.011559	2025-06-30 07:40:25.011559
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.020444	2025-06-30 07:40:25.020444
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.027228	2025-06-30 07:40:25.027228
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.034812	2025-06-30 07:40:25.034812
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.073113	2025-06-30 07:40:25.073113
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.083253	2025-06-30 07:40:25.083253
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.092539	2025-06-30 07:40:25.092539
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.130955	2025-06-30 07:40:25.130955
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.138295	2025-06-30 07:40:25.138295
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.15967	2025-06-30 07:40:25.15967
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.166599	2025-06-30 07:40:25.166599
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.17381	2025-06-30 07:40:25.17381
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.180964	2025-06-30 07:40:25.180964
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.187813	2025-06-30 07:40:25.187813
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.194576	2025-06-30 07:40:25.194576
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.201126	2025-06-30 07:40:25.201126
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.207524	2025-06-30 07:40:25.207524
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.21418	2025-06-30 07:40:25.21418
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.222741	2025-06-30 07:40:25.222741
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.231802	2025-06-30 07:40:25.231802
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.238755	2025-06-30 07:40:25.238755
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.245343	2025-06-30 07:40:25.245343
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.251954	2025-06-30 07:40:25.251954
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.259381	2025-06-30 07:40:25.259381
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.266129	2025-06-30 07:40:25.266129
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.272674	2025-06-30 07:40:25.272674
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.280015	2025-06-30 07:40:25.280015
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.286814	2025-06-30 07:40:25.286814
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.295219	2025-06-30 07:40:25.295219
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.302479	2025-06-30 07:40:25.302479
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.316124	2025-06-30 07:40:25.316124
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.323211	2025-06-30 07:40:25.323211
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.335111	2025-06-30 07:40:25.335111
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.342157	2025-06-30 07:40:25.342157
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.349299	2025-06-30 07:40:25.349299
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.35618	2025-06-30 07:40:25.35618
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.362917	2025-06-30 07:40:25.362917
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.370062	2025-06-30 07:40:25.370062
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.376793	2025-06-30 07:40:25.376793
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.383569	2025-06-30 07:40:25.383569
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.390181	2025-06-30 07:40:25.390181
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.398362	2025-06-30 07:40:25.398362
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.406508	2025-06-30 07:40:25.406508
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.41533	2025-06-30 07:40:25.41533
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.45385	2025-06-30 07:40:25.45385
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.463644	2025-06-30 07:40:25.463644
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.500907	2025-06-30 07:40:25.500907
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.510804	2025-06-30 07:40:25.510804
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.539179	2025-06-30 07:40:25.539179
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.5571	2025-06-30 07:40:25.5571
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.564909	2025-06-30 07:40:25.564909
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.585442	2025-06-30 07:40:25.585442
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.59334	2025-06-30 07:40:25.59334
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.616732	2025-06-30 07:40:25.616732
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.624752	2025-06-30 07:40:25.624752
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.641399	2025-06-30 07:40:25.641399
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.648592	2025-06-30 07:40:25.648592
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.655622	2025-06-30 07:40:25.655622
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.663858	2025-06-30 07:40:25.663858
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.672001	2025-06-30 07:40:25.672001
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.680366	2025-06-30 07:40:25.680366
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.687023	2025-06-30 07:40:25.687023
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.694318	2025-06-30 07:40:25.694318
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.701089	2025-06-30 07:40:25.701089
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.707793	2025-06-30 07:40:25.707793
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.717313	2025-06-30 07:40:25.717313
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.723992	2025-06-30 07:40:25.723992
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.731268	2025-06-30 07:40:25.731268
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.738826	2025-06-30 07:40:25.738826
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.748621	2025-06-30 07:40:25.748621
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.789098	2025-06-30 07:40:25.789098
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.795952	2025-06-30 07:40:25.795952
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.835986	2025-06-30 07:40:25.835986
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.844087	2025-06-30 07:40:25.844087
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.882569	2025-06-30 07:40:25.882569
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.891553	2025-06-30 07:40:25.891553
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.930766	2025-06-30 07:40:25.930766
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.969621	2025-06-30 07:40:25.969621
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.977433	2025-06-30 07:40:25.977433
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:25.985929	2025-06-30 07:40:25.985929
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.024333	2025-06-30 07:40:26.024333
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.030933	2025-06-30 07:40:26.030933
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.039078	2025-06-30 07:40:26.039078
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.046236	2025-06-30 07:40:26.046236
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.070348	2025-06-30 07:40:26.070348
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.078508	2025-06-30 07:40:26.078508
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.084853	2025-06-30 07:40:26.084853
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.092647	2025-06-30 07:40:26.092647
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.131098	2025-06-30 07:40:26.131098
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.139426	2025-06-30 07:40:26.139426
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.146926	2025-06-30 07:40:26.146926
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.156403	2025-06-30 07:40:26.156403
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.194898	2025-06-30 07:40:26.194898
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.201979	2025-06-30 07:40:26.201979
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.226787	2025-06-30 07:40:26.226787
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.234011	2025-06-30 07:40:26.234011
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.256176	2025-06-30 07:40:26.256176
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.26349	2025-06-30 07:40:26.26349
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.301963	2025-06-30 07:40:26.301963
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.340522	2025-06-30 07:40:26.340522
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.348375	2025-06-30 07:40:26.348375
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.387017	2025-06-30 07:40:26.387017
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.395703	2025-06-30 07:40:26.395703
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.402932	2025-06-30 07:40:26.402932
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.409674	2025-06-30 07:40:26.409674
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.417664	2025-06-30 07:40:26.417664
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.424305	2025-06-30 07:40:26.424305
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.43117	2025-06-30 07:40:26.43117
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.43926	2025-06-30 07:40:26.43926
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.468515	2025-06-30 07:40:26.468515
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.476436	2025-06-30 07:40:26.476436
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.51569	2025-06-30 07:40:26.51569
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.523481	2025-06-30 07:40:26.523481
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.530391	2025-06-30 07:40:26.530391
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.56932	2025-06-30 07:40:26.56932
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.577037	2025-06-30 07:40:26.577037
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.608081	2025-06-30 07:40:26.608081
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.615508	2025-06-30 07:40:26.615508
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.63041	2025-06-30 07:40:26.63041
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.638559	2025-06-30 07:40:26.638559
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.650991	2025-06-30 07:40:26.650991
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.659915	2025-06-30 07:40:26.659915
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.666945	2025-06-30 07:40:26.666945
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.674731	2025-06-30 07:40:26.674731
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.713227	2025-06-30 07:40:26.713227
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.719668	2025-06-30 07:40:26.719668
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.727049	2025-06-30 07:40:26.727049
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.733765	2025-06-30 07:40:26.733765
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.740573	2025-06-30 07:40:26.740573
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.748429	2025-06-30 07:40:26.748429
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.754899	2025-06-30 07:40:26.754899
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.761556	2025-06-30 07:40:26.761556
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.768953	2025-06-30 07:40:26.768953
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.776031	2025-06-30 07:40:26.776031
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.783622	2025-06-30 07:40:26.783622
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.790646	2025-06-30 07:40:26.790646
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.798126	2025-06-30 07:40:26.798126
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.804993	2025-06-30 07:40:26.804993
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.812099	2025-06-30 07:40:26.812099
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.819086	2025-06-30 07:40:26.819086
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.825808	2025-06-30 07:40:26.825808
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.833863	2025-06-30 07:40:26.833863
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.842006	2025-06-30 07:40:26.842006
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.851521	2025-06-30 07:40:26.851521
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.863255	2025-06-30 07:40:26.863255
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.870919	2025-06-30 07:40:26.870919
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.877535	2025-06-30 07:40:26.877535
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.883894	2025-06-30 07:40:26.883894
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.892204	2025-06-30 07:40:26.892204
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.90157	2025-06-30 07:40:26.90157
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.909154	2025-06-30 07:40:26.909154
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.916255	2025-06-30 07:40:26.916255
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.923369	2025-06-30 07:40:26.923369
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.930114	2025-06-30 07:40:26.930114
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.938015	2025-06-30 07:40:26.938015
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.945697	2025-06-30 07:40:26.945697
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.952738	2025-06-30 07:40:26.952738
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.991815	2025-06-30 07:40:26.991815
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:26.999418	2025-06-30 07:40:26.999418
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.027916	2025-06-30 07:40:27.027916
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.035456	2025-06-30 07:40:27.035456
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.042662	2025-06-30 07:40:27.042662
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.050348	2025-06-30 07:40:27.050348
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.060488	2025-06-30 07:40:27.060488
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.068915	2025-06-30 07:40:27.068915
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.093522	2025-06-30 07:40:27.093522
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.101524	2025-06-30 07:40:27.101524
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.108896	2025-06-30 07:40:27.108896
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.116095	2025-06-30 07:40:27.116095
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.123701	2025-06-30 07:40:27.123701
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.130287	2025-06-30 07:40:27.130287
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.136821	2025-06-30 07:40:27.136821
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.143697	2025-06-30 07:40:27.143697
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.15283	2025-06-30 07:40:27.15283
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.159789	2025-06-30 07:40:27.159789
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.171859	2025-06-30 07:40:27.171859
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.17881	2025-06-30 07:40:27.17881
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.185283	2025-06-30 07:40:27.185283
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.191981	2025-06-30 07:40:27.191981
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.198397	2025-06-30 07:40:27.198397
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.204942	2025-06-30 07:40:27.204942
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 07:40:27.212201	2025-06-30 07:40:27.212201
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.218853	2025-06-30 07:40:27.218853
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.22636	2025-06-30 07:40:27.22636
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.23332	2025-06-30 07:40:27.23332
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.241928	2025-06-30 07:40:27.241928
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.248966	2025-06-30 07:40:27.248966
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.255984	2025-06-30 07:40:27.255984
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.26274	2025-06-30 07:40:27.26274
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.270466	2025-06-30 07:40:27.270466
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.278559	2025-06-30 07:40:27.278559
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.285817	2025-06-30 07:40:27.285817
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.294669	2025-06-30 07:40:27.294669
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.302886	2025-06-30 07:40:27.302886
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.309296	2025-06-30 07:40:27.309296
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.315762	2025-06-30 07:40:27.315762
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.32231	2025-06-30 07:40:27.32231
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.329794	2025-06-30 07:40:27.329794
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.336881	2025-06-30 07:40:27.336881
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.344893	2025-06-30 07:40:27.344893
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.352632	2025-06-30 07:40:27.352632
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.360381	2025-06-30 07:40:27.360381
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.369661	2025-06-30 07:40:27.369661
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.376534	2025-06-30 07:40:27.376534
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.383956	2025-06-30 07:40:27.383956
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.391994	2025-06-30 07:40:27.391994
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.417843	2025-06-30 07:40:27.417843
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.427547	2025-06-30 07:40:27.427547
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.434724	2025-06-30 07:40:27.434724
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.443909	2025-06-30 07:40:27.443909
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.451904	2025-06-30 07:40:27.451904
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.462264	2025-06-30 07:40:27.462264
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.469603	2025-06-30 07:40:27.469603
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.49217	2025-06-30 07:40:27.49217
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.496528	2025-06-30 07:40:27.496528
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.501856	2025-06-30 07:40:27.501856
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.508963	2025-06-30 07:40:27.508963
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.516476	2025-06-30 07:40:27.516476
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.52328	2025-06-30 07:40:27.52328
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.530194	2025-06-30 07:40:27.530194
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.537255	2025-06-30 07:40:27.537255
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.545577	2025-06-30 07:40:27.545577
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.552612	2025-06-30 07:40:27.552612
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.562278	2025-06-30 07:40:27.562278
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.570252	2025-06-30 07:40:27.570252
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.577687	2025-06-30 07:40:27.577687
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.584776	2025-06-30 07:40:27.584776
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.597723	2025-06-30 07:40:27.597723
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.607027	2025-06-30 07:40:27.607027
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.61432	2025-06-30 07:40:27.61432
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.621746	2025-06-30 07:40:27.621746
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.629149	2025-06-30 07:40:27.629149
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.636324	2025-06-30 07:40:27.636324
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.643488	2025-06-30 07:40:27.643488
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.653472	2025-06-30 07:40:27.653472
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.663936	2025-06-30 07:40:27.663936
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.672008	2025-06-30 07:40:27.672008
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.679472	2025-06-30 07:40:27.679472
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.687554	2025-06-30 07:40:27.687554
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.69497	2025-06-30 07:40:27.69497
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.70201	2025-06-30 07:40:27.70201
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.70913	2025-06-30 07:40:27.70913
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.720187	2025-06-30 07:40:27.720187
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.732446	2025-06-30 07:40:27.732446
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.741748	2025-06-30 07:40:27.741748
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.74876	2025-06-30 07:40:27.74876
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.756098	2025-06-30 07:40:27.756098
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.763566	2025-06-30 07:40:27.763566
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.770074	2025-06-30 07:40:27.770074
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.778496	2025-06-30 07:40:27.778496
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.785189	2025-06-30 07:40:27.785189
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.792402	2025-06-30 07:40:27.792402
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.798979	2025-06-30 07:40:27.798979
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.806418	2025-06-30 07:40:27.806418
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.814859	2025-06-30 07:40:27.814859
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.821799	2025-06-30 07:40:27.821799
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.829125	2025-06-30 07:40:27.829125
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.838026	2025-06-30 07:40:27.838026
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.847261	2025-06-30 07:40:27.847261
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.853854	2025-06-30 07:40:27.853854
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.863878	2025-06-30 07:40:27.863878
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.870746	2025-06-30 07:40:27.870746
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.877888	2025-06-30 07:40:27.877888
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.884562	2025-06-30 07:40:27.884562
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.891143	2025-06-30 07:40:27.891143
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.898263	2025-06-30 07:40:27.898263
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.905207	2025-06-30 07:40:27.905207
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.91255	2025-06-30 07:40:27.91255
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.91994	2025-06-30 07:40:27.91994
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.926442	2025-06-30 07:40:27.926442
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.936403	2025-06-30 07:40:27.936403
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.943116	2025-06-30 07:40:27.943116
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.951448	2025-06-30 07:40:27.951448
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.959938	2025-06-30 07:40:27.959938
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.971979	2025-06-30 07:40:27.971979
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.979934	2025-06-30 07:40:27.979934
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.987101	2025-06-30 07:40:27.987101
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:27.995844	2025-06-30 07:40:27.995844
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.003035	2025-06-30 07:40:28.003035
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.00996	2025-06-30 07:40:28.00996
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.016843	2025-06-30 07:40:28.016843
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.023768	2025-06-30 07:40:28.023768
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.031679	2025-06-30 07:40:28.031679
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.041157	2025-06-30 07:40:28.041157
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.048246	2025-06-30 07:40:28.048246
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.058525	2025-06-30 07:40:28.058525
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.067233	2025-06-30 07:40:28.067233
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.075997	2025-06-30 07:40:28.075997
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.08247	2025-06-30 07:40:28.08247
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.089029	2025-06-30 07:40:28.089029
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.096991	2025-06-30 07:40:28.096991
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.104478	2025-06-30 07:40:28.104478
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.112894	2025-06-30 07:40:28.112894
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.121313	2025-06-30 07:40:28.121313
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.12831	2025-06-30 07:40:28.12831
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.136759	2025-06-30 07:40:28.136759
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.145699	2025-06-30 07:40:28.145699
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.154146	2025-06-30 07:40:28.154146
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.162823	2025-06-30 07:40:28.162823
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.171331	2025-06-30 07:40:28.171331
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.178436	2025-06-30 07:40:28.178436
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.18704	2025-06-30 07:40:28.18704
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.193656	2025-06-30 07:40:28.193656
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.20231	2025-06-30 07:40:28.20231
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.208966	2025-06-30 07:40:28.208966
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.217262	2025-06-30 07:40:28.217262
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.22403	2025-06-30 07:40:28.22403
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.230782	2025-06-30 07:40:28.230782
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.239714	2025-06-30 07:40:28.239714
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.247463	2025-06-30 07:40:28.247463
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.255266	2025-06-30 07:40:28.255266
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.282018	2025-06-30 07:40:28.282018
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.289097	2025-06-30 07:40:28.289097
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.298835	2025-06-30 07:40:28.298835
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.307182	2025-06-30 07:40:28.307182
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.314473	2025-06-30 07:40:28.314473
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.321373	2025-06-30 07:40:28.321373
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.328446	2025-06-30 07:40:28.328446
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.335603	2025-06-30 07:40:28.335603
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.344111	2025-06-30 07:40:28.344111
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.351639	2025-06-30 07:40:28.351639
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.360539	2025-06-30 07:40:28.360539
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.367422	2025-06-30 07:40:28.367422
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.374609	2025-06-30 07:40:28.374609
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.381573	2025-06-30 07:40:28.381573
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.389205	2025-06-30 07:40:28.389205
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.39607	2025-06-30 07:40:28.39607
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.404015	2025-06-30 07:40:28.404015
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.412589	2025-06-30 07:40:28.412589
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.421466	2025-06-30 07:40:28.421466
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.428888	2025-06-30 07:40:28.428888
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.43765	2025-06-30 07:40:28.43765
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.445479	2025-06-30 07:40:28.445479
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.454531	2025-06-30 07:40:28.454531
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.461738	2025-06-30 07:40:28.461738
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.468438	2025-06-30 07:40:28.468438
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.47587	2025-06-30 07:40:28.47587
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.484533	2025-06-30 07:40:28.484533
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.491944	2025-06-30 07:40:28.491944
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.499006	2025-06-30 07:40:28.499006
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.506609	2025-06-30 07:40:28.506609
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.513679	2025-06-30 07:40:28.513679
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.525725	2025-06-30 07:40:28.525725
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.533127	2025-06-30 07:40:28.533127
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.550867	2025-06-30 07:40:28.550867
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.558007	2025-06-30 07:40:28.558007
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.56573	2025-06-30 07:40:28.56573
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.574061	2025-06-30 07:40:28.574061
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.581643	2025-06-30 07:40:28.581643
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.593372	2025-06-30 07:40:28.593372
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.601114	2025-06-30 07:40:28.601114
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.618595	2025-06-30 07:40:28.618595
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.627091	2025-06-30 07:40:28.627091
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.635491	2025-06-30 07:40:28.635491
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.643646	2025-06-30 07:40:28.643646
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.65112	2025-06-30 07:40:28.65112
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.658116	2025-06-30 07:40:28.658116
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.665387	2025-06-30 07:40:28.665387
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.672986	2025-06-30 07:40:28.672986
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.680351	2025-06-30 07:40:28.680351
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.688982	2025-06-30 07:40:28.688982
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.696531	2025-06-30 07:40:28.696531
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.705202	2025-06-30 07:40:28.705202
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.712139	2025-06-30 07:40:28.712139
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.719552	2025-06-30 07:40:28.719552
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.73649	2025-06-30 07:40:28.73649
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.743999	2025-06-30 07:40:28.743999
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.75183	2025-06-30 07:40:28.75183
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.759285	2025-06-30 07:40:28.759285
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.768227	2025-06-30 07:40:28.768227
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.776357	2025-06-30 07:40:28.776357
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.783112	2025-06-30 07:40:28.783112
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.792279	2025-06-30 07:40:28.792279
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.799226	2025-06-30 07:40:28.799226
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.814802	2025-06-30 07:40:28.814802
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.82255	2025-06-30 07:40:28.82255
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.831238	2025-06-30 07:40:28.831238
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.848285	2025-06-30 07:40:28.848285
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.855855	2025-06-30 07:40:28.855855
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.863285	2025-06-30 07:40:28.863285
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.87116	2025-06-30 07:40:28.87116
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.878056	2025-06-30 07:40:28.878056
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.88543	2025-06-30 07:40:28.88543
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.892675	2025-06-30 07:40:28.892675
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.901139	2025-06-30 07:40:28.901139
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.908435	2025-06-30 07:40:28.908435
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.917231	2025-06-30 07:40:28.917231
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.924859	2025-06-30 07:40:28.924859
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.932591	2025-06-30 07:40:28.932591
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.939839	2025-06-30 07:40:28.939839
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.94784	2025-06-30 07:40:28.94784
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.95623	2025-06-30 07:40:28.95623
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.96523	2025-06-30 07:40:28.96523
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.974541	2025-06-30 07:40:28.974541
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.983917	2025-06-30 07:40:28.983917
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.991921	2025-06-30 07:40:28.991921
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:28.999668	2025-06-30 07:40:28.999668
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.006826	2025-06-30 07:40:29.006826
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.013964	2025-06-30 07:40:29.013964
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.022221	2025-06-30 07:40:29.022221
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.031659	2025-06-30 07:40:29.031659
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.03916	2025-06-30 07:40:29.03916
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.048105	2025-06-30 07:40:29.048105
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.055716	2025-06-30 07:40:29.055716
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.064542	2025-06-30 07:40:29.064542
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.07307	2025-06-30 07:40:29.07307
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.080577	2025-06-30 07:40:29.080577
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.087964	2025-06-30 07:40:29.087964
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.095244	2025-06-30 07:40:29.095244
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.102933	2025-06-30 07:40:29.102933
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.109949	2025-06-30 07:40:29.109949
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.118229	2025-06-30 07:40:29.118229
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.126944	2025-06-30 07:40:29.126944
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.134636	2025-06-30 07:40:29.134636
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.14329	2025-06-30 07:40:29.14329
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.151048	2025-06-30 07:40:29.151048
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.15784	2025-06-30 07:40:29.15784
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.166279	2025-06-30 07:40:29.166279
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.174234	2025-06-30 07:40:29.174234
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.181049	2025-06-30 07:40:29.181049
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.18759	2025-06-30 07:40:29.18759
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.195452	2025-06-30 07:40:29.195452
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.202831	2025-06-30 07:40:29.202831
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.210645	2025-06-30 07:40:29.210645
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.218998	2025-06-30 07:40:29.218998
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.227085	2025-06-30 07:40:29.227085
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.235998	2025-06-30 07:40:29.235998
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.244662	2025-06-30 07:40:29.244662
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.252118	2025-06-30 07:40:29.252118
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.262979	2025-06-30 07:40:29.262979
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.274611	2025-06-30 07:40:29.274611
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.281975	2025-06-30 07:40:29.281975
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.288955	2025-06-30 07:40:29.288955
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.296328	2025-06-30 07:40:29.296328
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.304359	2025-06-30 07:40:29.304359
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.312049	2025-06-30 07:40:29.312049
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.322265	2025-06-30 07:40:29.322265
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.330216	2025-06-30 07:40:29.330216
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.340462	2025-06-30 07:40:29.340462
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.348052	2025-06-30 07:40:29.348052
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.355726	2025-06-30 07:40:29.355726
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.36312	2025-06-30 07:40:29.36312
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.370785	2025-06-30 07:40:29.370785
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.378489	2025-06-30 07:40:29.378489
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.385921	2025-06-30 07:40:29.385921
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.396455	2025-06-30 07:40:29.396455
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.404214	2025-06-30 07:40:29.404214
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.412548	2025-06-30 07:40:29.412548
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.421457	2025-06-30 07:40:29.421457
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.430129	2025-06-30 07:40:29.430129
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.438063	2025-06-30 07:40:29.438063
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.445362	2025-06-30 07:40:29.445362
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.453234	2025-06-30 07:40:29.453234
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.461221	2025-06-30 07:40:29.461221
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.468809	2025-06-30 07:40:29.468809
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.475816	2025-06-30 07:40:29.475816
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.48332	2025-06-30 07:40:29.48332
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.490623	2025-06-30 07:40:29.490623
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.497988	2025-06-30 07:40:29.497988
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.508869	2025-06-30 07:40:29.508869
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.516932	2025-06-30 07:40:29.516932
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.524777	2025-06-30 07:40:29.524777
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.5332	2025-06-30 07:40:29.5332
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.541962	2025-06-30 07:40:29.541962
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.548899	2025-06-30 07:40:29.548899
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.557217	2025-06-30 07:40:29.557217
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.565573	2025-06-30 07:40:29.565573
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.573905	2025-06-30 07:40:29.573905
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.584361	2025-06-30 07:40:29.584361
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.597528	2025-06-30 07:40:29.597528
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.606343	2025-06-30 07:40:29.606343
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.61388	2025-06-30 07:40:29.61388
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.623922	2025-06-30 07:40:29.623922
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.631868	2025-06-30 07:40:29.631868
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.639688	2025-06-30 07:40:29.639688
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.648628	2025-06-30 07:40:29.648628
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.657755	2025-06-30 07:40:29.657755
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.664703	2025-06-30 07:40:29.664703
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.674064	2025-06-30 07:40:29.674064
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.681062	2025-06-30 07:40:29.681062
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.690596	2025-06-30 07:40:29.690596
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.697423	2025-06-30 07:40:29.697423
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.704421	2025-06-30 07:40:29.704421
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.712527	2025-06-30 07:40:29.712527
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.719668	2025-06-30 07:40:29.719668
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.727595	2025-06-30 07:40:29.727595
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.734664	2025-06-30 07:40:29.734664
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.741797	2025-06-30 07:40:29.741797
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.752833	2025-06-30 07:40:29.752833
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.759779	2025-06-30 07:40:29.759779
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.771421	2025-06-30 07:40:29.771421
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.780329	2025-06-30 07:40:29.780329
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.814964	2025-06-30 07:40:29.814964
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.824226	2025-06-30 07:40:29.824226
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.833683	2025-06-30 07:40:29.833683
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.840196	2025-06-30 07:40:29.840196
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.850084	2025-06-30 07:40:29.850084
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.889064	2025-06-30 07:40:29.889064
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.895766	2025-06-30 07:40:29.895766
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.90278	2025-06-30 07:40:29.90278
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.910213	2025-06-30 07:40:29.910213
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.949041	2025-06-30 07:40:29.949041
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.957441	2025-06-30 07:40:29.957441
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:29.995892	2025-06-30 07:40:29.995892
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.034426	2025-06-30 07:40:30.034426
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.04374	2025-06-30 07:40:30.04374
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.051701	2025-06-30 07:40:30.051701
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.090641	2025-06-30 07:40:30.090641
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.098098	2025-06-30 07:40:30.098098
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.120864	2025-06-30 07:40:30.120864
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.128716	2025-06-30 07:40:30.128716
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.155716	2025-06-30 07:40:30.155716
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.163437	2025-06-30 07:40:30.163437
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.171148	2025-06-30 07:40:30.171148
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.193948	2025-06-30 07:40:30.193948
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.204754	2025-06-30 07:40:30.204754
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.244363	2025-06-30 07:40:30.244363
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.253135	2025-06-30 07:40:30.253135
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.275366	2025-06-30 07:40:30.275366
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.282958	2025-06-30 07:40:30.282958
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.314681	2025-06-30 07:40:30.314681
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.322162	2025-06-30 07:40:30.322162
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.329365	2025-06-30 07:40:30.329365
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.344759	2025-06-30 07:40:30.344759
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.353571	2025-06-30 07:40:30.353571
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.361112	2025-06-30 07:40:30.361112
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.368844	2025-06-30 07:40:30.368844
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.377101	2025-06-30 07:40:30.377101
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.384263	2025-06-30 07:40:30.384263
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.394421	2025-06-30 07:40:30.394421
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.402864	2025-06-30 07:40:30.402864
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.412193	2025-06-30 07:40:30.412193
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.419371	2025-06-30 07:40:30.419371
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.428871	2025-06-30 07:40:30.428871
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.436371	2025-06-30 07:40:30.436371
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.443905	2025-06-30 07:40:30.443905
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.451693	2025-06-30 07:40:30.451693
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.458737	2025-06-30 07:40:30.458737
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.465796	2025-06-30 07:40:30.465796
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.504893	2025-06-30 07:40:30.504893
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.512651	2025-06-30 07:40:30.512651
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.595901	2025-06-30 07:40:30.595901
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.602259	2025-06-30 07:40:30.602259
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.609449	2025-06-30 07:40:30.609449
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.617134	2025-06-30 07:40:30.617134
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.655407	2025-06-30 07:40:30.655407
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.663895	2025-06-30 07:40:30.663895
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.673351	2025-06-30 07:40:30.673351
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.713056	2025-06-30 07:40:30.713056
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.752589	2025-06-30 07:40:30.752589
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.761457	2025-06-30 07:40:30.761457
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.800029	2025-06-30 07:40:30.800029
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.809289	2025-06-30 07:40:30.809289
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.848089	2025-06-30 07:40:30.848089
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.855636	2025-06-30 07:40:30.855636
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.894859	2025-06-30 07:40:30.894859
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.902125	2025-06-30 07:40:30.902125
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.940925	2025-06-30 07:40:30.940925
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.950049	2025-06-30 07:40:30.950049
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.957505	2025-06-30 07:40:30.957505
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:30.995639	2025-06-30 07:40:30.995639
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.002705	2025-06-30 07:40:31.002705
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.009766	2025-06-30 07:40:31.009766
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.048529	2025-06-30 07:40:31.048529
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.056015	2025-06-30 07:40:31.056015
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.063639	2025-06-30 07:40:31.063639
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.104369	2025-06-30 07:40:31.104369
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.114804	2025-06-30 07:40:31.114804
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.122554	2025-06-30 07:40:31.122554
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.130712	2025-06-30 07:40:31.130712
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.171512	2025-06-30 07:40:31.171512
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.212522	2025-06-30 07:40:31.212522
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.253139	2025-06-30 07:40:31.253139
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.262189	2025-06-30 07:40:31.262189
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.300624	2025-06-30 07:40:31.300624
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.308921	2025-06-30 07:40:31.308921
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.347519	2025-06-30 07:40:31.347519
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.354608	2025-06-30 07:40:31.354608
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.394029	2025-06-30 07:40:31.394029
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.408114	2025-06-30 07:40:31.408114
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.4585	2025-06-30 07:40:31.4585
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.476245	2025-06-30 07:40:31.476245
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.491546	2025-06-30 07:40:31.491546
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.506293	2025-06-30 07:40:31.506293
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.525373	2025-06-30 07:40:31.525373
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.535584	2025-06-30 07:40:31.535584
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.570373	2025-06-30 07:40:31.570373
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.597136	2025-06-30 07:40:31.597136
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.617878	2025-06-30 07:40:31.617878
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.662382	2025-06-30 07:40:31.662382
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.678129	2025-06-30 07:40:31.678129
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.706204	2025-06-30 07:40:31.706204
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.751703	2025-06-30 07:40:31.751703
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.770328	2025-06-30 07:40:31.770328
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.779629	2025-06-30 07:40:31.779629
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.827433	2025-06-30 07:40:31.827433
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.874865	2025-06-30 07:40:31.874865
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.898299	2025-06-30 07:40:31.898299
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.939524	2025-06-30 07:40:31.939524
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.952833	2025-06-30 07:40:31.952833
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:31.999886	2025-06-30 07:40:31.999886
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.017242	2025-06-30 07:40:32.017242
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.062286	2025-06-30 07:40:32.062286
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.077798	2025-06-30 07:40:32.077798
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.095956	2025-06-30 07:40:32.095956
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.112448	2025-06-30 07:40:32.112448
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.130309	2025-06-30 07:40:32.130309
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.146238	2025-06-30 07:40:32.146238
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.161373	2025-06-30 07:40:32.161373
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.176202	2025-06-30 07:40:32.176202
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.223447	2025-06-30 07:40:32.223447
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.273615	2025-06-30 07:40:32.273615
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.292403	2025-06-30 07:40:32.292403
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.339013	2025-06-30 07:40:32.339013
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.353227	2025-06-30 07:40:32.353227
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.367785	2025-06-30 07:40:32.367785
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.388879	2025-06-30 07:40:32.388879
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.427466	2025-06-30 07:40:32.427466
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.43438	2025-06-30 07:40:32.43438
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.443198	2025-06-30 07:40:32.443198
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.482128	2025-06-30 07:40:32.482128
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.489373	2025-06-30 07:40:32.489373
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.497387	2025-06-30 07:40:32.497387
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.513518	2025-06-30 07:40:32.513518
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.553313	2025-06-30 07:40:32.553313
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.560726	2025-06-30 07:40:32.560726
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.568812	2025-06-30 07:40:32.568812
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.588054	2025-06-30 07:40:32.588054
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.596321	2025-06-30 07:40:32.596321
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.635604	2025-06-30 07:40:32.635604
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.643476	2025-06-30 07:40:32.643476
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.68209	2025-06-30 07:40:32.68209
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.690106	2025-06-30 07:40:32.690106
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.731421	2025-06-30 07:40:32.731421
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.772799	2025-06-30 07:40:32.772799
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.813663	2025-06-30 07:40:32.813663
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.822417	2025-06-30 07:40:32.822417
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.830049	2025-06-30 07:40:32.830049
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.871315	2025-06-30 07:40:32.871315
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.881395	2025-06-30 07:40:32.881395
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.920574	2025-06-30 07:40:32.920574
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.929259	2025-06-30 07:40:32.929259
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.938163	2025-06-30 07:40:32.938163
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.977675	2025-06-30 07:40:32.977675
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.98673	2025-06-30 07:40:32.98673
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:32.996078	2025-06-30 07:40:32.996078
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.003694	2025-06-30 07:40:33.003694
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.012767	2025-06-30 07:40:33.012767
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.021558	2025-06-30 07:40:33.021558
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.064319	2025-06-30 07:40:33.064319
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.10654	2025-06-30 07:40:33.10654
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.11382	2025-06-30 07:40:33.11382
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.121086	2025-06-30 07:40:33.121086
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.160555	2025-06-30 07:40:33.160555
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.169099	2025-06-30 07:40:33.169099
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.208434	2025-06-30 07:40:33.208434
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.216445	2025-06-30 07:40:33.216445
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.23808	2025-06-30 07:40:33.23808
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.2457	2025-06-30 07:40:33.2457
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.284466	2025-06-30 07:40:33.284466
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.293189	2025-06-30 07:40:33.293189
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.313543	2025-06-30 07:40:33.313543
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.321207	2025-06-30 07:40:33.321207
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.32974	2025-06-30 07:40:33.32974
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.339348	2025-06-30 07:40:33.339348
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.347293	2025-06-30 07:40:33.347293
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.382232	2025-06-30 07:40:33.382232
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.390732	2025-06-30 07:40:33.390732
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.404889	2025-06-30 07:40:33.404889
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.451414	2025-06-30 07:40:33.451414
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.465671	2025-06-30 07:40:33.465671
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.501037	2025-06-30 07:40:33.501037
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.512846	2025-06-30 07:40:33.512846
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.525767	2025-06-30 07:40:33.525767
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.571475	2025-06-30 07:40:33.571475
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.58967	2025-06-30 07:40:33.58967
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.628959	2025-06-30 07:40:33.628959
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.648625	2025-06-30 07:40:33.648625
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.696	2025-06-30 07:40:33.696
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.704734	2025-06-30 07:40:33.704734
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.717005	2025-06-30 07:40:33.717005
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.762546	2025-06-30 07:40:33.762546
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.775983	2025-06-30 07:40:33.775983
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.818904	2025-06-30 07:40:33.818904
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.830884	2025-06-30 07:40:33.830884
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.8449	2025-06-30 07:40:33.8449
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.857493	2025-06-30 07:40:33.857493
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.878555	2025-06-30 07:40:33.878555
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.898057	2025-06-30 07:40:33.898057
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.928024	2025-06-30 07:40:33.928024
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.953659	2025-06-30 07:40:33.953659
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.962426	2025-06-30 07:40:33.962426
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.975452	2025-06-30 07:40:33.975452
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:33.988659	2025-06-30 07:40:33.988659
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.001532	2025-06-30 07:40:34.001532
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.015637	2025-06-30 07:40:34.015637
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.027418	2025-06-30 07:40:34.027418
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.039854	2025-06-30 07:40:34.039854
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.052874	2025-06-30 07:40:34.052874
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.066681	2025-06-30 07:40:34.066681
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.080717	2025-06-30 07:40:34.080717
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.095045	2025-06-30 07:40:34.095045
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.108351	2025-06-30 07:40:34.108351
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.121484	2025-06-30 07:40:34.121484
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.133477	2025-06-30 07:40:34.133477
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.144946	2025-06-30 07:40:34.144946
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.152179	2025-06-30 07:40:34.152179
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.159989	2025-06-30 07:40:34.159989
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.167788	2025-06-30 07:40:34.167788
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.175818	2025-06-30 07:40:34.175818
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.183015	2025-06-30 07:40:34.183015
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.190525	2025-06-30 07:40:34.190525
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.19768	2025-06-30 07:40:34.19768
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.204993	2025-06-30 07:40:34.204993
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.213447	2025-06-30 07:40:34.213447
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.241888	2025-06-30 07:40:34.241888
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.250508	2025-06-30 07:40:34.250508
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.258019	2025-06-30 07:40:34.258019
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.270916	2025-06-30 07:40:34.270916
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.278721	2025-06-30 07:40:34.278721
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.285643	2025-06-30 07:40:34.285643
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.293695	2025-06-30 07:40:34.293695
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.301178	2025-06-30 07:40:34.301178
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.324001	2025-06-30 07:40:34.324001
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.332061	2025-06-30 07:40:34.332061
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.344656	2025-06-30 07:40:34.344656
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.361311	2025-06-30 07:40:34.361311
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.369454	2025-06-30 07:40:34.369454
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.377138	2025-06-30 07:40:34.377138
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.384455	2025-06-30 07:40:34.384455
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.393229	2025-06-30 07:40:34.393229
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.400609	2025-06-30 07:40:34.400609
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.408811	2025-06-30 07:40:34.408811
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.41758	2025-06-30 07:40:34.41758
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 07:40:34.425245	2025-06-30 07:40:34.425245
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.435642	2025-06-30 07:40:34.435642
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.442995	2025-06-30 07:40:34.442995
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.44989	2025-06-30 07:40:34.44989
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.458007	2025-06-30 07:40:34.458007
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.466136	2025-06-30 07:40:34.466136
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.478612	2025-06-30 07:40:34.478612
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.485301	2025-06-30 07:40:34.485301
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.492494	2025-06-30 07:40:34.492494
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.499906	2025-06-30 07:40:34.499906
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.511992	2025-06-30 07:40:34.511992
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.518958	2025-06-30 07:40:34.518958
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.526587	2025-06-30 07:40:34.526587
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.534724	2025-06-30 07:40:34.534724
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.572073	2025-06-30 07:40:34.572073
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.581042	2025-06-30 07:40:34.581042
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.6099	2025-06-30 07:40:34.6099
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.618998	2025-06-30 07:40:34.618998
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.627014	2025-06-30 07:40:34.627014
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.634066	2025-06-30 07:40:34.634066
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.642382	2025-06-30 07:40:34.642382
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.651635	2025-06-30 07:40:34.651635
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.659213	2025-06-30 07:40:34.659213
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.664357	2025-06-30 07:40:34.664357
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.672396	2025-06-30 07:40:34.672396
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.680384	2025-06-30 07:40:34.680384
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.687481	2025-06-30 07:40:34.687481
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.695019	2025-06-30 07:40:34.695019
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.702601	2025-06-30 07:40:34.702601
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.71141	2025-06-30 07:40:34.71141
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.72066	2025-06-30 07:40:34.72066
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.727888	2025-06-30 07:40:34.727888
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.736168	2025-06-30 07:40:34.736168
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.743174	2025-06-30 07:40:34.743174
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.781357	2025-06-30 07:40:34.781357
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.788399	2025-06-30 07:40:34.788399
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.827071	2025-06-30 07:40:34.827071
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.834345	2025-06-30 07:40:34.834345
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.872789	2025-06-30 07:40:34.872789
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.8797	2025-06-30 07:40:34.8797
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.887567	2025-06-30 07:40:34.887567
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.926694	2025-06-30 07:40:34.926694
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.934014	2025-06-30 07:40:34.934014
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.941813	2025-06-30 07:40:34.941813
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.979898	2025-06-30 07:40:34.979898
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.989068	2025-06-30 07:40:34.989068
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:34.996532	2025-06-30 07:40:34.996532
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.035237	2025-06-30 07:40:35.035237
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.04553	2025-06-30 07:40:35.04553
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.083705	2025-06-30 07:40:35.083705
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.092112	2025-06-30 07:40:35.092112
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.130754	2025-06-30 07:40:35.130754
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.13717	2025-06-30 07:40:35.13717
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.181132	2025-06-30 07:40:35.181132
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.195525	2025-06-30 07:40:35.195525
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.239867	2025-06-30 07:40:35.239867
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.252852	2025-06-30 07:40:35.252852
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.301872	2025-06-30 07:40:35.301872
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.315747	2025-06-30 07:40:35.315747
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.325662	2025-06-30 07:40:35.325662
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.369099	2025-06-30 07:40:35.369099
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.383563	2025-06-30 07:40:35.383563
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.395117	2025-06-30 07:40:35.395117
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.407487	2025-06-30 07:40:35.407487
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.420223	2025-06-30 07:40:35.420223
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.464548	2025-06-30 07:40:35.464548
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.482183	2025-06-30 07:40:35.482183
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.527497	2025-06-30 07:40:35.527497
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.538945	2025-06-30 07:40:35.538945
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.552764	2025-06-30 07:40:35.552764
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.596797	2025-06-30 07:40:35.596797
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.616546	2025-06-30 07:40:35.616546
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.658214	2025-06-30 07:40:35.658214
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.676782	2025-06-30 07:40:35.676782
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.728503	2025-06-30 07:40:35.728503
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.773771	2025-06-30 07:40:35.773771
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.786974	2025-06-30 07:40:35.786974
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.834716	2025-06-30 07:40:35.834716
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.855754	2025-06-30 07:40:35.855754
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.865128	2025-06-30 07:40:35.865128
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.909084	2025-06-30 07:40:35.909084
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.92067	2025-06-30 07:40:35.92067
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:35.971481	2025-06-30 07:40:35.971481
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.020017	2025-06-30 07:40:36.020017
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.028566	2025-06-30 07:40:36.028566
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.041469	2025-06-30 07:40:36.041469
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.053949	2025-06-30 07:40:36.053949
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.070026	2025-06-30 07:40:36.070026
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.113964	2025-06-30 07:40:36.113964
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.12933	2025-06-30 07:40:36.12933
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.173501	2025-06-30 07:40:36.173501
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.184872	2025-06-30 07:40:36.184872
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.197091	2025-06-30 07:40:36.197091
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.209664	2025-06-30 07:40:36.209664
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.255167	2025-06-30 07:40:36.255167
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.269192	2025-06-30 07:40:36.269192
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.315398	2025-06-30 07:40:36.315398
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.328262	2025-06-30 07:40:36.328262
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.343813	2025-06-30 07:40:36.343813
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.356657	2025-06-30 07:40:36.356657
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.369801	2025-06-30 07:40:36.369801
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.38242	2025-06-30 07:40:36.38242
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.3946	2025-06-30 07:40:36.3946
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.40913	2025-06-30 07:40:36.40913
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.422506	2025-06-30 07:40:36.422506
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.436703	2025-06-30 07:40:36.436703
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.451174	2025-06-30 07:40:36.451174
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.46473	2025-06-30 07:40:36.46473
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.478674	2025-06-30 07:40:36.478674
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.491712	2025-06-30 07:40:36.491712
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.507235	2025-06-30 07:40:36.507235
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.551387	2025-06-30 07:40:36.551387
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.564371	2025-06-30 07:40:36.564371
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.579143	2025-06-30 07:40:36.579143
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.592688	2025-06-30 07:40:36.592688
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.605567	2025-06-30 07:40:36.605567
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.617928	2025-06-30 07:40:36.617928
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.631712	2025-06-30 07:40:36.631712
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.643728	2025-06-30 07:40:36.643728
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.665483	2025-06-30 07:40:36.665483
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.673674	2025-06-30 07:40:36.673674
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.68437	2025-06-30 07:40:36.68437
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.6929	2025-06-30 07:40:36.6929
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.699855	2025-06-30 07:40:36.699855
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.70788	2025-06-30 07:40:36.70788
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.71697	2025-06-30 07:40:36.71697
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.725259	2025-06-30 07:40:36.725259
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.733099	2025-06-30 07:40:36.733099
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.740782	2025-06-30 07:40:36.740782
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.74821	2025-06-30 07:40:36.74821
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.755912	2025-06-30 07:40:36.755912
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.76369	2025-06-30 07:40:36.76369
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.773431	2025-06-30 07:40:36.773431
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.781308	2025-06-30 07:40:36.781308
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.788918	2025-06-30 07:40:36.788918
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.796266	2025-06-30 07:40:36.796266
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.804117	2025-06-30 07:40:36.804117
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.812467	2025-06-30 07:40:36.812467
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.823037	2025-06-30 07:40:36.823037
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.830278	2025-06-30 07:40:36.830278
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.83728	2025-06-30 07:40:36.83728
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.844585	2025-06-30 07:40:36.844585
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.85202	2025-06-30 07:40:36.85202
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.862138	2025-06-30 07:40:36.862138
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.871417	2025-06-30 07:40:36.871417
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.885255	2025-06-30 07:40:36.885255
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.899918	2025-06-30 07:40:36.899918
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.908188	2025-06-30 07:40:36.908188
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.923317	2025-06-30 07:40:36.923317
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.931239	2025-06-30 07:40:36.931239
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.940257	2025-06-30 07:40:36.940257
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.947832	2025-06-30 07:40:36.947832
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.956416	2025-06-30 07:40:36.956416
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.964805	2025-06-30 07:40:36.964805
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.980576	2025-06-30 07:40:36.980576
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.991383	2025-06-30 07:40:36.991383
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:36.998717	2025-06-30 07:40:36.998717
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.007103	2025-06-30 07:40:37.007103
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.032353	2025-06-30 07:40:37.032353
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.039706	2025-06-30 07:40:37.039706
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.046097	2025-06-30 07:40:37.046097
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.05353	2025-06-30 07:40:37.05353
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.062258	2025-06-30 07:40:37.062258
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.069338	2025-06-30 07:40:37.069338
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.076309	2025-06-30 07:40:37.076309
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.083072	2025-06-30 07:40:37.083072
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.091155	2025-06-30 07:40:37.091155
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.099785	2025-06-30 07:40:37.099785
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.107625	2025-06-30 07:40:37.107625
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.114949	2025-06-30 07:40:37.114949
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.122706	2025-06-30 07:40:37.122706
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.130423	2025-06-30 07:40:37.130423
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.137887	2025-06-30 07:40:37.137887
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.145456	2025-06-30 07:40:37.145456
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.152513	2025-06-30 07:40:37.152513
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.160676	2025-06-30 07:40:37.160676
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.168054	2025-06-30 07:40:37.168054
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.176306	2025-06-30 07:40:37.176306
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.196995	2025-06-30 07:40:37.196995
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.204589	2025-06-30 07:40:37.204589
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.212042	2025-06-30 07:40:37.212042
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.220278	2025-06-30 07:40:37.220278
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.227674	2025-06-30 07:40:37.227674
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.235547	2025-06-30 07:40:37.235547
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.24206	2025-06-30 07:40:37.24206
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.249779	2025-06-30 07:40:37.249779
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.257219	2025-06-30 07:40:37.257219
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.265452	2025-06-30 07:40:37.265452
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.27286	2025-06-30 07:40:37.27286
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.279931	2025-06-30 07:40:37.279931
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.286899	2025-06-30 07:40:37.286899
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.295269	2025-06-30 07:40:37.295269
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.304146	2025-06-30 07:40:37.304146
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.311655	2025-06-30 07:40:37.311655
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.318883	2025-06-30 07:40:37.318883
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.327168	2025-06-30 07:40:37.327168
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.334481	2025-06-30 07:40:37.334481
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.342203	2025-06-30 07:40:37.342203
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.349722	2025-06-30 07:40:37.349722
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.356976	2025-06-30 07:40:37.356976
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.363707	2025-06-30 07:40:37.363707
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.371543	2025-06-30 07:40:37.371543
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.378568	2025-06-30 07:40:37.378568
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.38686	2025-06-30 07:40:37.38686
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.39395	2025-06-30 07:40:37.39395
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.401323	2025-06-30 07:40:37.401323
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.410284	2025-06-30 07:40:37.410284
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.417589	2025-06-30 07:40:37.417589
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.425938	2025-06-30 07:40:37.425938
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.434382	2025-06-30 07:40:37.434382
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.441534	2025-06-30 07:40:37.441534
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.448941	2025-06-30 07:40:37.448941
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.45567	2025-06-30 07:40:37.45567
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.462788	2025-06-30 07:40:37.462788
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.470063	2025-06-30 07:40:37.470063
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.47717	2025-06-30 07:40:37.47717
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.483796	2025-06-30 07:40:37.483796
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.491498	2025-06-30 07:40:37.491498
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.498801	2025-06-30 07:40:37.498801
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.506337	2025-06-30 07:40:37.506337
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.515355	2025-06-30 07:40:37.515355
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.527954	2025-06-30 07:40:37.527954
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.539495	2025-06-30 07:40:37.539495
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.546093	2025-06-30 07:40:37.546093
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.55421	2025-06-30 07:40:37.55421
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.561761	2025-06-30 07:40:37.561761
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.569055	2025-06-30 07:40:37.569055
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.576078	2025-06-30 07:40:37.576078
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.585233	2025-06-30 07:40:37.585233
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.594391	2025-06-30 07:40:37.594391
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.603548	2025-06-30 07:40:37.603548
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.61046	2025-06-30 07:40:37.61046
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.617794	2025-06-30 07:40:37.617794
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.628094	2025-06-30 07:40:37.628094
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.639767	2025-06-30 07:40:37.639767
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.649841	2025-06-30 07:40:37.649841
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.662359	2025-06-30 07:40:37.662359
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.672318	2025-06-30 07:40:37.672318
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.679569	2025-06-30 07:40:37.679569
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.686912	2025-06-30 07:40:37.686912
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.694255	2025-06-30 07:40:37.694255
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.702143	2025-06-30 07:40:37.702143
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.709644	2025-06-30 07:40:37.709644
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.717628	2025-06-30 07:40:37.717628
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.726484	2025-06-30 07:40:37.726484
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.73477	2025-06-30 07:40:37.73477
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.742572	2025-06-30 07:40:37.742572
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.751529	2025-06-30 07:40:37.751529
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.762094	2025-06-30 07:40:37.762094
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.772221	2025-06-30 07:40:37.772221
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.77911	2025-06-30 07:40:37.77911
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.788203	2025-06-30 07:40:37.788203
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.796121	2025-06-30 07:40:37.796121
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.804263	2025-06-30 07:40:37.804263
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.812875	2025-06-30 07:40:37.812875
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.820297	2025-06-30 07:40:37.820297
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.828054	2025-06-30 07:40:37.828054
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.83582	2025-06-30 07:40:37.83582
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.84323	2025-06-30 07:40:37.84323
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.850937	2025-06-30 07:40:37.850937
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.859059	2025-06-30 07:40:37.859059
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.868907	2025-06-30 07:40:37.868907
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.87585	2025-06-30 07:40:37.87585
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.885655	2025-06-30 07:40:37.885655
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.895712	2025-06-30 07:40:37.895712
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.902598	2025-06-30 07:40:37.902598
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.911787	2025-06-30 07:40:37.911787
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.920465	2025-06-30 07:40:37.920465
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.928071	2025-06-30 07:40:37.928071
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.935713	2025-06-30 07:40:37.935713
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.942722	2025-06-30 07:40:37.942722
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.950031	2025-06-30 07:40:37.950031
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.957923	2025-06-30 07:40:37.957923
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.965657	2025-06-30 07:40:37.965657
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.972686	2025-06-30 07:40:37.972686
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.980467	2025-06-30 07:40:37.980467
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.988716	2025-06-30 07:40:37.988716
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:37.996086	2025-06-30 07:40:37.996086
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.003347	2025-06-30 07:40:38.003347
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.012306	2025-06-30 07:40:38.012306
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.021968	2025-06-30 07:40:38.021968
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.035103	2025-06-30 07:40:38.035103
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.043199	2025-06-30 07:40:38.043199
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.056918	2025-06-30 07:40:38.056918
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.064415	2025-06-30 07:40:38.064415
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.072753	2025-06-30 07:40:38.072753
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.08086	2025-06-30 07:40:38.08086
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.088446	2025-06-30 07:40:38.088446
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.095914	2025-06-30 07:40:38.095914
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.102499	2025-06-30 07:40:38.102499
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.109768	2025-06-30 07:40:38.109768
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.117588	2025-06-30 07:40:38.117588
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.125167	2025-06-30 07:40:38.125167
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.131872	2025-06-30 07:40:38.131872
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.138373	2025-06-30 07:40:38.138373
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.145132	2025-06-30 07:40:38.145132
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.151853	2025-06-30 07:40:38.151853
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.159253	2025-06-30 07:40:38.159253
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.166586	2025-06-30 07:40:38.166586
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.174086	2025-06-30 07:40:38.174086
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.212537	2025-06-30 07:40:38.212537
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.220034	2025-06-30 07:40:38.220034
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.227919	2025-06-30 07:40:38.227919
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.234819	2025-06-30 07:40:38.234819
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.241693	2025-06-30 07:40:38.241693
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.253416	2025-06-30 07:40:38.253416
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.276556	2025-06-30 07:40:38.276556
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.29417	2025-06-30 07:40:38.29417
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.301328	2025-06-30 07:40:38.301328
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.308452	2025-06-30 07:40:38.308452
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.316078	2025-06-30 07:40:38.316078
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.322983	2025-06-30 07:40:38.322983
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.338394	2025-06-30 07:40:38.338394
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.345823	2025-06-30 07:40:38.345823
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.353742	2025-06-30 07:40:38.353742
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.361068	2025-06-30 07:40:38.361068
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.367765	2025-06-30 07:40:38.367765
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.375958	2025-06-30 07:40:38.375958
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.382784	2025-06-30 07:40:38.382784
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.391462	2025-06-30 07:40:38.391462
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.405415	2025-06-30 07:40:38.405415
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.419713	2025-06-30 07:40:38.419713
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.438296	2025-06-30 07:40:38.438296
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.452947	2025-06-30 07:40:38.452947
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.464091	2025-06-30 07:40:38.464091
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.478348	2025-06-30 07:40:38.478348
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.49112	2025-06-30 07:40:38.49112
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.506019	2025-06-30 07:40:38.506019
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.519172	2025-06-30 07:40:38.519172
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.540338	2025-06-30 07:40:38.540338
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.552977	2025-06-30 07:40:38.552977
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.567229	2025-06-30 07:40:38.567229
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.580275	2025-06-30 07:40:38.580275
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.59432	2025-06-30 07:40:38.59432
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.60718	2025-06-30 07:40:38.60718
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.620909	2025-06-30 07:40:38.620909
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.634238	2025-06-30 07:40:38.634238
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.647975	2025-06-30 07:40:38.647975
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.661123	2025-06-30 07:40:38.661123
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.67355	2025-06-30 07:40:38.67355
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.687781	2025-06-30 07:40:38.687781
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.700929	2025-06-30 07:40:38.700929
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.711778	2025-06-30 07:40:38.711778
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.724832	2025-06-30 07:40:38.724832
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.736937	2025-06-30 07:40:38.736937
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.75098	2025-06-30 07:40:38.75098
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.764392	2025-06-30 07:40:38.764392
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.777571	2025-06-30 07:40:38.777571
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.790275	2025-06-30 07:40:38.790275
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.803285	2025-06-30 07:40:38.803285
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.817506	2025-06-30 07:40:38.817506
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.829282	2025-06-30 07:40:38.829282
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.842818	2025-06-30 07:40:38.842818
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.855217	2025-06-30 07:40:38.855217
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.865202	2025-06-30 07:40:38.865202
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.877516	2025-06-30 07:40:38.877516
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.888181	2025-06-30 07:40:38.888181
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.897192	2025-06-30 07:40:38.897192
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.903871	2025-06-30 07:40:38.903871
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.911645	2025-06-30 07:40:38.911645
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.919372	2025-06-30 07:40:38.919372
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.931427	2025-06-30 07:40:38.931427
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.939054	2025-06-30 07:40:38.939054
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.948616	2025-06-30 07:40:38.948616
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.956183	2025-06-30 07:40:38.956183
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.96347	2025-06-30 07:40:38.96347
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.971392	2025-06-30 07:40:38.971392
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.978864	2025-06-30 07:40:38.978864
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.986283	2025-06-30 07:40:38.986283
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:38.993544	2025-06-30 07:40:38.993544
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.001629	2025-06-30 07:40:39.001629
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.015985	2025-06-30 07:40:39.015985
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.022927	2025-06-30 07:40:39.022927
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.029475	2025-06-30 07:40:39.029475
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.03983	2025-06-30 07:40:39.03983
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.047405	2025-06-30 07:40:39.047405
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.054716	2025-06-30 07:40:39.054716
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.06185	2025-06-30 07:40:39.06185
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.069799	2025-06-30 07:40:39.069799
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.077988	2025-06-30 07:40:39.077988
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.086748	2025-06-30 07:40:39.086748
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.094848	2025-06-30 07:40:39.094848
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.102918	2025-06-30 07:40:39.102918
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.110113	2025-06-30 07:40:39.110113
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.117439	2025-06-30 07:40:39.117439
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.125191	2025-06-30 07:40:39.125191
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.133535	2025-06-30 07:40:39.133535
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.1418	2025-06-30 07:40:39.1418
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.148511	2025-06-30 07:40:39.148511
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.15586	2025-06-30 07:40:39.15586
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.164162	2025-06-30 07:40:39.164162
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.171031	2025-06-30 07:40:39.171031
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.179252	2025-06-30 07:40:39.179252
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.186892	2025-06-30 07:40:39.186892
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.19493	2025-06-30 07:40:39.19493
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.202153	2025-06-30 07:40:39.202153
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.208981	2025-06-30 07:40:39.208981
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.216336	2025-06-30 07:40:39.216336
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.22423	2025-06-30 07:40:39.22423
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.23268	2025-06-30 07:40:39.23268
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 07:40:39.240769	2025-06-30 07:40:39.240769
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.249318	2025-06-30 07:40:39.249318
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.256483	2025-06-30 07:40:39.256483
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.26408	2025-06-30 07:40:39.26408
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.279112	2025-06-30 07:40:39.279112
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.286769	2025-06-30 07:40:39.286769
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.295578	2025-06-30 07:40:39.295578
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.302574	2025-06-30 07:40:39.302574
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.310806	2025-06-30 07:40:39.310806
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.317882	2025-06-30 07:40:39.317882
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.330479	2025-06-30 07:40:39.330479
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.337727	2025-06-30 07:40:39.337727
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.345564	2025-06-30 07:40:39.345564
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.352999	2025-06-30 07:40:39.352999
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.359888	2025-06-30 07:40:39.359888
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.366911	2025-06-30 07:40:39.366911
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.374154	2025-06-30 07:40:39.374154
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.382019	2025-06-30 07:40:39.382019
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.388858	2025-06-30 07:40:39.388858
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.396005	2025-06-30 07:40:39.396005
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.403333	2025-06-30 07:40:39.403333
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.41267	2025-06-30 07:40:39.41267
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.419769	2025-06-30 07:40:39.419769
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.426708	2025-06-30 07:40:39.426708
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.433673	2025-06-30 07:40:39.433673
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.441633	2025-06-30 07:40:39.441633
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.448953	2025-06-30 07:40:39.448953
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.456025	2025-06-30 07:40:39.456025
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.464084	2025-06-30 07:40:39.464084
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.473624	2025-06-30 07:40:39.473624
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.484785	2025-06-30 07:40:39.484785
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.491936	2025-06-30 07:40:39.491936
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.498618	2025-06-30 07:40:39.498618
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.50599	2025-06-30 07:40:39.50599
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.513282	2025-06-30 07:40:39.513282
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.523575	2025-06-30 07:40:39.523575
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.530529	2025-06-30 07:40:39.530529
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.537589	2025-06-30 07:40:39.537589
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.545246	2025-06-30 07:40:39.545246
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.552363	2025-06-30 07:40:39.552363
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.560107	2025-06-30 07:40:39.560107
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.567438	2025-06-30 07:40:39.567438
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.574621	2025-06-30 07:40:39.574621
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.583607	2025-06-30 07:40:39.583607
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.590695	2025-06-30 07:40:39.590695
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.597756	2025-06-30 07:40:39.597756
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.605561	2025-06-30 07:40:39.605561
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.612814	2025-06-30 07:40:39.612814
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.625353	2025-06-30 07:40:39.625353
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.632331	2025-06-30 07:40:39.632331
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.643222	2025-06-30 07:40:39.643222
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.652106	2025-06-30 07:40:39.652106
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.66161	2025-06-30 07:40:39.66161
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.669101	2025-06-30 07:40:39.669101
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.68088	2025-06-30 07:40:39.68088
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.690249	2025-06-30 07:40:39.690249
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.699971	2025-06-30 07:40:39.699971
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.706579	2025-06-30 07:40:39.706579
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.715227	2025-06-30 07:40:39.715227
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.722624	2025-06-30 07:40:39.722624
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.730997	2025-06-30 07:40:39.730997
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.738367	2025-06-30 07:40:39.738367
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.746405	2025-06-30 07:40:39.746405
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.753327	2025-06-30 07:40:39.753327
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.761706	2025-06-30 07:40:39.761706
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.770172	2025-06-30 07:40:39.770172
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.778297	2025-06-30 07:40:39.778297
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.785709	2025-06-30 07:40:39.785709
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.792862	2025-06-30 07:40:39.792862
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.801092	2025-06-30 07:40:39.801092
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.809723	2025-06-30 07:40:39.809723
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.817036	2025-06-30 07:40:39.817036
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.825971	2025-06-30 07:40:39.825971
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.833787	2025-06-30 07:40:39.833787
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.840727	2025-06-30 07:40:39.840727
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.850448	2025-06-30 07:40:39.850448
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.85785	2025-06-30 07:40:39.85785
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.864548	2025-06-30 07:40:39.864548
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.872168	2025-06-30 07:40:39.872168
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.881275	2025-06-30 07:40:39.881275
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.888058	2025-06-30 07:40:39.888058
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.897816	2025-06-30 07:40:39.897816
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.90505	2025-06-30 07:40:39.90505
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.911842	2025-06-30 07:40:39.911842
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.918653	2025-06-30 07:40:39.918653
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.926026	2025-06-30 07:40:39.926026
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.934546	2025-06-30 07:40:39.934546
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.940993	2025-06-30 07:40:39.940993
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.948183	2025-06-30 07:40:39.948183
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.955381	2025-06-30 07:40:39.955381
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.963373	2025-06-30 07:40:39.963373
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.972969	2025-06-30 07:40:39.972969
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.983968	2025-06-30 07:40:39.983968
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.991748	2025-06-30 07:40:39.991748
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:39.9996	2025-06-30 07:40:39.9996
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.007251	2025-06-30 07:40:40.007251
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.014571	2025-06-30 07:40:40.014571
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.022219	2025-06-30 07:40:40.022219
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.029855	2025-06-30 07:40:40.029855
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.040607	2025-06-30 07:40:40.040607
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.047607	2025-06-30 07:40:40.047607
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.067727	2025-06-30 07:40:40.067727
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.076005	2025-06-30 07:40:40.076005
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.083553	2025-06-30 07:40:40.083553
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.090696	2025-06-30 07:40:40.090696
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.098086	2025-06-30 07:40:40.098086
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.107597	2025-06-30 07:40:40.107597
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.114912	2025-06-30 07:40:40.114912
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.12243	2025-06-30 07:40:40.12243
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.129721	2025-06-30 07:40:40.129721
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.137407	2025-06-30 07:40:40.137407
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.15051	2025-06-30 07:40:40.15051
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.165615	2025-06-30 07:40:40.165615
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.180662	2025-06-30 07:40:40.180662
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.194254	2025-06-30 07:40:40.194254
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.207266	2025-06-30 07:40:40.207266
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.221231	2025-06-30 07:40:40.221231
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.234236	2025-06-30 07:40:40.234236
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.247568	2025-06-30 07:40:40.247568
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.261008	2025-06-30 07:40:40.261008
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.273972	2025-06-30 07:40:40.273972
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.287109	2025-06-30 07:40:40.287109
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.300628	2025-06-30 07:40:40.300628
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.313108	2025-06-30 07:40:40.313108
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.328151	2025-06-30 07:40:40.328151
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.340618	2025-06-30 07:40:40.340618
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.354059	2025-06-30 07:40:40.354059
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.367551	2025-06-30 07:40:40.367551
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.379305	2025-06-30 07:40:40.379305
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.392499	2025-06-30 07:40:40.392499
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.404105	2025-06-30 07:40:40.404105
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.41656	2025-06-30 07:40:40.41656
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.43048	2025-06-30 07:40:40.43048
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.444527	2025-06-30 07:40:40.444527
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.459496	2025-06-30 07:40:40.459496
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.475084	2025-06-30 07:40:40.475084
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.492908	2025-06-30 07:40:40.492908
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.509531	2025-06-30 07:40:40.509531
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.671907	2025-06-30 07:40:40.671907
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.684171	2025-06-30 07:40:40.684171
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.692277	2025-06-30 07:40:40.692277
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.703644	2025-06-30 07:40:40.703644
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.710476	2025-06-30 07:40:40.710476
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.718243	2025-06-30 07:40:40.718243
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.726719	2025-06-30 07:40:40.726719
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.733075	2025-06-30 07:40:40.733075
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.741585	2025-06-30 07:40:40.741585
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.748111	2025-06-30 07:40:40.748111
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.756505	2025-06-30 07:40:40.756505
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.76399	2025-06-30 07:40:40.76399
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.771512	2025-06-30 07:40:40.771512
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.778953	2025-06-30 07:40:40.778953
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.785868	2025-06-30 07:40:40.785868
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.794452	2025-06-30 07:40:40.794452
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.801821	2025-06-30 07:40:40.801821
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.813356	2025-06-30 07:40:40.813356
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.819963	2025-06-30 07:40:40.819963
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.827746	2025-06-30 07:40:40.827746
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.835231	2025-06-30 07:40:40.835231
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.841195	2025-06-30 07:40:40.841195
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.848099	2025-06-30 07:40:40.848099
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.855649	2025-06-30 07:40:40.855649
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.862149	2025-06-30 07:40:40.862149
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.86961	2025-06-30 07:40:40.86961
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.8768	2025-06-30 07:40:40.8768
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.884566	2025-06-30 07:40:40.884566
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.896092	2025-06-30 07:40:40.896092
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.903553	2025-06-30 07:40:40.903553
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.914478	2025-06-30 07:40:40.914478
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.921921	2025-06-30 07:40:40.921921
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.930579	2025-06-30 07:40:40.930579
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.940059	2025-06-30 07:40:40.940059
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.948803	2025-06-30 07:40:40.948803
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.956259	2025-06-30 07:40:40.956259
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.964188	2025-06-30 07:40:40.964188
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.971049	2025-06-30 07:40:40.971049
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.977956	2025-06-30 07:40:40.977956
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.984688	2025-06-30 07:40:40.984688
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:40.991798	2025-06-30 07:40:40.991798
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.000614	2025-06-30 07:40:41.000614
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.00768	2025-06-30 07:40:41.00768
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.016401	2025-06-30 07:40:41.016401
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.027349	2025-06-30 07:40:41.027349
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.034103	2025-06-30 07:40:41.034103
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.041539	2025-06-30 07:40:41.041539
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.049919	2025-06-30 07:40:41.049919
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.058003	2025-06-30 07:40:41.058003
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.066406	2025-06-30 07:40:41.066406
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.07364	2025-06-30 07:40:41.07364
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.087911	2025-06-30 07:40:41.087911
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.095649	2025-06-30 07:40:41.095649
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.118064	2025-06-30 07:40:41.118064
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.12543	2025-06-30 07:40:41.12543
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.135505	2025-06-30 07:40:41.135505
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.144913	2025-06-30 07:40:41.144913
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.152296	2025-06-30 07:40:41.152296
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.160539	2025-06-30 07:40:41.160539
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.170839	2025-06-30 07:40:41.170839
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.179468	2025-06-30 07:40:41.179468
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.189008	2025-06-30 07:40:41.189008
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.195879	2025-06-30 07:40:41.195879
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.204572	2025-06-30 07:40:41.204572
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.211716	2025-06-30 07:40:41.211716
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.220694	2025-06-30 07:40:41.220694
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.228227	2025-06-30 07:40:41.228227
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.234979	2025-06-30 07:40:41.234979
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.242554	2025-06-30 07:40:41.242554
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.249539	2025-06-30 07:40:41.249539
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.256984	2025-06-30 07:40:41.256984
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.264103	2025-06-30 07:40:41.264103
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.27103	2025-06-30 07:40:41.27103
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.278824	2025-06-30 07:40:41.278824
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.285634	2025-06-30 07:40:41.285634
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.294581	2025-06-30 07:40:41.294581
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.302325	2025-06-30 07:40:41.302325
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.313541	2025-06-30 07:40:41.313541
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.323606	2025-06-30 07:40:41.323606
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.332581	2025-06-30 07:40:41.332581
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.340157	2025-06-30 07:40:41.340157
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.348357	2025-06-30 07:40:41.348357
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.356097	2025-06-30 07:40:41.356097
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.363344	2025-06-30 07:40:41.363344
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.37089	2025-06-30 07:40:41.37089
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.378054	2025-06-30 07:40:41.378054
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.385594	2025-06-30 07:40:41.385594
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.392474	2025-06-30 07:40:41.392474
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.400352	2025-06-30 07:40:41.400352
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.407297	2025-06-30 07:40:41.407297
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.414633	2025-06-30 07:40:41.414633
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.422396	2025-06-30 07:40:41.422396
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.429247	2025-06-30 07:40:41.429247
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.436146	2025-06-30 07:40:41.436146
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.445066	2025-06-30 07:40:41.445066
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.45311	2025-06-30 07:40:41.45311
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.461384	2025-06-30 07:40:41.461384
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.469921	2025-06-30 07:40:41.469921
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.476753	2025-06-30 07:40:41.476753
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.483995	2025-06-30 07:40:41.483995
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.49086	2025-06-30 07:40:41.49086
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.498931	2025-06-30 07:40:41.498931
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.50613	2025-06-30 07:40:41.50613
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.512754	2025-06-30 07:40:41.512754
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.521191	2025-06-30 07:40:41.521191
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.53197	2025-06-30 07:40:41.53197
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.538976	2025-06-30 07:40:41.538976
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.547378	2025-06-30 07:40:41.547378
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.554299	2025-06-30 07:40:41.554299
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.562173	2025-06-30 07:40:41.562173
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.569805	2025-06-30 07:40:41.569805
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.577046	2025-06-30 07:40:41.577046
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.584186	2025-06-30 07:40:41.584186
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.59217	2025-06-30 07:40:41.59217
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.600509	2025-06-30 07:40:41.600509
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.608246	2025-06-30 07:40:41.608246
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.615816	2025-06-30 07:40:41.615816
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.623436	2025-06-30 07:40:41.623436
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.630881	2025-06-30 07:40:41.630881
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.638402	2025-06-30 07:40:41.638402
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.648751	2025-06-30 07:40:41.648751
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.657534	2025-06-30 07:40:41.657534
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.664691	2025-06-30 07:40:41.664691
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.671786	2025-06-30 07:40:41.671786
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.681755	2025-06-30 07:40:41.681755
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.689195	2025-06-30 07:40:41.689195
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.698747	2025-06-30 07:40:41.698747
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.710038	2025-06-30 07:40:41.710038
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.717073	2025-06-30 07:40:41.717073
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.72554	2025-06-30 07:40:41.72554
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.733243	2025-06-30 07:40:41.733243
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.739576	2025-06-30 07:40:41.739576
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.747807	2025-06-30 07:40:41.747807
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.75496	2025-06-30 07:40:41.75496
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.764082	2025-06-30 07:40:41.764082
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.77241	2025-06-30 07:40:41.77241
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.781985	2025-06-30 07:40:41.781985
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.789089	2025-06-30 07:40:41.789089
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.796338	2025-06-30 07:40:41.796338
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.803693	2025-06-30 07:40:41.803693
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.813862	2025-06-30 07:40:41.813862
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.821324	2025-06-30 07:40:41.821324
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.82899	2025-06-30 07:40:41.82899
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.83564	2025-06-30 07:40:41.83564
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.846076	2025-06-30 07:40:41.846076
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.853157	2025-06-30 07:40:41.853157
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.860051	2025-06-30 07:40:41.860051
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.867783	2025-06-30 07:40:41.867783
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.875111	2025-06-30 07:40:41.875111
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.88336	2025-06-30 07:40:41.88336
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.893296	2025-06-30 07:40:41.893296
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.900784	2025-06-30 07:40:41.900784
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.908249	2025-06-30 07:40:41.908249
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.917926	2025-06-30 07:40:41.917926
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.926974	2025-06-30 07:40:41.926974
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.933847	2025-06-30 07:40:41.933847
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.94179	2025-06-30 07:40:41.94179
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.949093	2025-06-30 07:40:41.949093
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.956002	2025-06-30 07:40:41.956002
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.963528	2025-06-30 07:40:41.963528
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.972158	2025-06-30 07:40:41.972158
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.980141	2025-06-30 07:40:41.980141
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.987701	2025-06-30 07:40:41.987701
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:41.99478	2025-06-30 07:40:41.99478
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.002114	2025-06-30 07:40:42.002114
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.009308	2025-06-30 07:40:42.009308
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.016634	2025-06-30 07:40:42.016634
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.023467	2025-06-30 07:40:42.023467
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.030745	2025-06-30 07:40:42.030745
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.039006	2025-06-30 07:40:42.039006
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.047983	2025-06-30 07:40:42.047983
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.056897	2025-06-30 07:40:42.056897
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.064972	2025-06-30 07:40:42.064972
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.093836	2025-06-30 07:40:42.093836
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.102233	2025-06-30 07:40:42.102233
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.110867	2025-06-30 07:40:42.110867
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.118061	2025-06-30 07:40:42.118061
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.125259	2025-06-30 07:40:42.125259
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.132532	2025-06-30 07:40:42.132532
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.140081	2025-06-30 07:40:42.140081
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.148572	2025-06-30 07:40:42.148572
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.159941	2025-06-30 07:40:42.159941
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.167491	2025-06-30 07:40:42.167491
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.175206	2025-06-30 07:40:42.175206
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.183267	2025-06-30 07:40:42.183267
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.190951	2025-06-30 07:40:42.190951
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.19891	2025-06-30 07:40:42.19891
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.206098	2025-06-30 07:40:42.206098
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.215003	2025-06-30 07:40:42.215003
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.223261	2025-06-30 07:40:42.223261
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.23324	2025-06-30 07:40:42.23324
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.241244	2025-06-30 07:40:42.241244
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.280357	2025-06-30 07:40:42.280357
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.288704	2025-06-30 07:40:42.288704
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.301714	2025-06-30 07:40:42.301714
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.310898	2025-06-30 07:40:42.310898
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.322193	2025-06-30 07:40:42.322193
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.331246	2025-06-30 07:40:42.331246
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.340142	2025-06-30 07:40:42.340142
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.353215	2025-06-30 07:40:42.353215
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.361378	2025-06-30 07:40:42.361378
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.403163	2025-06-30 07:40:42.403163
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.417719	2025-06-30 07:40:42.417719
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.443741	2025-06-30 07:40:42.443741
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.456666	2025-06-30 07:40:42.456666
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.469278	2025-06-30 07:40:42.469278
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.482399	2025-06-30 07:40:42.482399
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.496408	2025-06-30 07:40:42.496408
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.509752	2025-06-30 07:40:42.509752
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.524136	2025-06-30 07:40:42.524136
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.543573	2025-06-30 07:40:42.543573
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.557939	2025-06-30 07:40:42.557939
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.570582	2025-06-30 07:40:42.570582
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.584052	2025-06-30 07:40:42.584052
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.629564	2025-06-30 07:40:42.629564
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.643667	2025-06-30 07:40:42.643667
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.657991	2025-06-30 07:40:42.657991
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.703678	2025-06-30 07:40:42.703678
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.721123	2025-06-30 07:40:42.721123
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.768286	2025-06-30 07:40:42.768286
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.784906	2025-06-30 07:40:42.784906
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.806267	2025-06-30 07:40:42.806267
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.81849	2025-06-30 07:40:42.81849
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.832497	2025-06-30 07:40:42.832497
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.848591	2025-06-30 07:40:42.848591
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.862157	2025-06-30 07:40:42.862157
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.876324	2025-06-30 07:40:42.876324
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.921511	2025-06-30 07:40:42.921511
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.933115	2025-06-30 07:40:42.933115
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.966669	2025-06-30 07:40:42.966669
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:42.978017	2025-06-30 07:40:42.978017
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.0103	2025-06-30 07:40:43.0103
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.025075	2025-06-30 07:40:43.025075
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.051152	2025-06-30 07:40:43.051152
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.065859	2025-06-30 07:40:43.065859
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.085222	2025-06-30 07:40:43.085222
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.09801	2025-06-30 07:40:43.09801
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.124673	2025-06-30 07:40:43.124673
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.136507	2025-06-30 07:40:43.136507
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.149682	2025-06-30 07:40:43.149682
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.161398	2025-06-30 07:40:43.161398
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.174391	2025-06-30 07:40:43.174391
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.187323	2025-06-30 07:40:43.187323
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.199394	2025-06-30 07:40:43.199394
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.207418	2025-06-30 07:40:43.207418
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.216148	2025-06-30 07:40:43.216148
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.224066	2025-06-30 07:40:43.224066
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.232643	2025-06-30 07:40:43.232643
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.241413	2025-06-30 07:40:43.241413
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.254538	2025-06-30 07:40:43.254538
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.266389	2025-06-30 07:40:43.266389
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.278317	2025-06-30 07:40:43.278317
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.291211	2025-06-30 07:40:43.291211
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.308147	2025-06-30 07:40:43.308147
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.322558	2025-06-30 07:40:43.322558
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.340529	2025-06-30 07:40:43.340529
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.354373	2025-06-30 07:40:43.354373
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.366758	2025-06-30 07:40:43.366758
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.383676	2025-06-30 07:40:43.383676
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.398009	2025-06-30 07:40:43.398009
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.413772	2025-06-30 07:40:43.413772
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.431302	2025-06-30 07:40:43.431302
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.44837	2025-06-30 07:40:43.44837
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.462475	2025-06-30 07:40:43.462475
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.476424	2025-06-30 07:40:43.476424
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.492414	2025-06-30 07:40:43.492414
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.50573	2025-06-30 07:40:43.50573
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.519383	2025-06-30 07:40:43.519383
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.536168	2025-06-30 07:40:43.536168
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.549592	2025-06-30 07:40:43.549592
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.563596	2025-06-30 07:40:43.563596
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.576817	2025-06-30 07:40:43.576817
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.591664	2025-06-30 07:40:43.591664
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.604538	2025-06-30 07:40:43.604538
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.61776	2025-06-30 07:40:43.61776
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.631196	2025-06-30 07:40:43.631196
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.64292	2025-06-30 07:40:43.64292
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.650758	2025-06-30 07:40:43.650758
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.658526	2025-06-30 07:40:43.658526
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.665527	2025-06-30 07:40:43.665527
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.675248	2025-06-30 07:40:43.675248
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.682185	2025-06-30 07:40:43.682185
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.721029	2025-06-30 07:40:43.721029
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.761882	2025-06-30 07:40:43.761882
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.771674	2025-06-30 07:40:43.771674
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.810082	2025-06-30 07:40:43.810082
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.81771	2025-06-30 07:40:43.81771
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.856588	2025-06-30 07:40:43.856588
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.864053	2025-06-30 07:40:43.864053
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.907515	2025-06-30 07:40:43.907515
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.916591	2025-06-30 07:40:43.916591
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.953213	2025-06-30 07:40:43.953213
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.961203	2025-06-30 07:40:43.961203
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.969312	2025-06-30 07:40:43.969312
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.979041	2025-06-30 07:40:43.979041
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.98822	2025-06-30 07:40:43.98822
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:43.996276	2025-06-30 07:40:43.996276
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.004278	2025-06-30 07:40:44.004278
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.011623	2025-06-30 07:40:44.011623
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.020381	2025-06-30 07:40:44.020381
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.028206	2025-06-30 07:40:44.028206
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.043611	2025-06-30 07:40:44.043611
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.051351	2025-06-30 07:40:44.051351
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.075863	2025-06-30 07:40:44.075863
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.083128	2025-06-30 07:40:44.083128
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.094911	2025-06-30 07:40:44.094911
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.102276	2025-06-30 07:40:44.102276
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.141553	2025-06-30 07:40:44.141553
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.152298	2025-06-30 07:40:44.152298
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.167455	2025-06-30 07:40:44.167455
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.180429	2025-06-30 07:40:44.180429
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.215695	2025-06-30 07:40:44.215695
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.228298	2025-06-30 07:40:44.228298
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.267608	2025-06-30 07:40:44.267608
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.28286	2025-06-30 07:40:44.28286
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.3232	2025-06-30 07:40:44.3232
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.337071	2025-06-30 07:40:44.337071
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.351223	2025-06-30 07:40:44.351223
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.380631	2025-06-30 07:40:44.380631
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.392864	2025-06-30 07:40:44.392864
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.401496	2025-06-30 07:40:44.401496
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.417528	2025-06-30 07:40:44.417528
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.426082	2025-06-30 07:40:44.426082
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.436354	2025-06-30 07:40:44.436354
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.445647	2025-06-30 07:40:44.445647
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.453728	2025-06-30 07:40:44.453728
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.464407	2025-06-30 07:40:44.464407
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.4741	2025-06-30 07:40:44.4741
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.4831	2025-06-30 07:40:44.4831
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.49229	2025-06-30 07:40:44.49229
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.500559	2025-06-30 07:40:44.500559
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.509751	2025-06-30 07:40:44.509751
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.51848	2025-06-30 07:40:44.51848
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.528358	2025-06-30 07:40:44.528358
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.542695	2025-06-30 07:40:44.542695
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.551173	2025-06-30 07:40:44.551173
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.560151	2025-06-30 07:40:44.560151
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.587592	2025-06-30 07:40:44.587592
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.596523	2025-06-30 07:40:44.596523
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.636911	2025-06-30 07:40:44.636911
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.650799	2025-06-30 07:40:44.650799
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.663472	2025-06-30 07:40:44.663472
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.672571	2025-06-30 07:40:44.672571
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.680638	2025-06-30 07:40:44.680638
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.69254	2025-06-30 07:40:44.69254
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.702238	2025-06-30 07:40:44.702238
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.711222	2025-06-30 07:40:44.711222
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.7389	2025-06-30 07:40:44.7389
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.752707	2025-06-30 07:40:44.752707
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.792987	2025-06-30 07:40:44.792987
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.806817	2025-06-30 07:40:44.806817
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.822103	2025-06-30 07:40:44.822103
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.86637	2025-06-30 07:40:44.86637
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.879445	2025-06-30 07:40:44.879445
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.9033	2025-06-30 07:40:44.9033
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.916378	2025-06-30 07:40:44.916378
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.945811	2025-06-30 07:40:44.945811
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.958919	2025-06-30 07:40:44.958919
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.973227	2025-06-30 07:40:44.973227
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:44.986605	2025-06-30 07:40:44.986605
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.000552	2025-06-30 07:40:45.000552
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.014261	2025-06-30 07:40:45.014261
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.029559	2025-06-30 07:40:45.029559
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.043205	2025-06-30 07:40:45.043205
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.055623	2025-06-30 07:40:45.055623
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.067816	2025-06-30 07:40:45.067816
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.083633	2025-06-30 07:40:45.083633
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.09644	2025-06-30 07:40:45.09644
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.110376	2025-06-30 07:40:45.110376
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.135311	2025-06-30 07:40:45.135311
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.148536	2025-06-30 07:40:45.148536
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.184306	2025-06-30 07:40:45.184306
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.196919	2025-06-30 07:40:45.196919
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.213868	2025-06-30 07:40:45.213868
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.227791	2025-06-30 07:40:45.227791
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.250025	2025-06-30 07:40:45.250025
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.291766	2025-06-30 07:40:45.291766
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.311214	2025-06-30 07:40:45.311214
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.323901	2025-06-30 07:40:45.323901
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.337355	2025-06-30 07:40:45.337355
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.350274	2025-06-30 07:40:45.350274
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.372768	2025-06-30 07:40:45.372768
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.386566	2025-06-30 07:40:45.386566
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.400152	2025-06-30 07:40:45.400152
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.42338	2025-06-30 07:40:45.42338
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.436945	2025-06-30 07:40:45.436945
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.469553	2025-06-30 07:40:45.469553
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.490937	2025-06-30 07:40:45.490937
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.504468	2025-06-30 07:40:45.504468
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.517699	2025-06-30 07:40:45.517699
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.55248	2025-06-30 07:40:45.55248
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.566675	2025-06-30 07:40:45.566675
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.575278	2025-06-30 07:40:45.575278
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.593622	2025-06-30 07:40:45.593622
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.615784	2025-06-30 07:40:45.615784
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.661368	2025-06-30 07:40:45.661368
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.681615	2025-06-30 07:40:45.681615
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.69676	2025-06-30 07:40:45.69676
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.708777	2025-06-30 07:40:45.708777
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.753294	2025-06-30 07:40:45.753294
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.768519	2025-06-30 07:40:45.768519
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.77739	2025-06-30 07:40:45.77739
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.791364	2025-06-30 07:40:45.791364
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.805512	2025-06-30 07:40:45.805512
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.851342	2025-06-30 07:40:45.851342
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.898958	2025-06-30 07:40:45.898958
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.918225	2025-06-30 07:40:45.918225
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.970788	2025-06-30 07:40:45.970788
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:45.987335	2025-06-30 07:40:45.987335
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.027995	2025-06-30 07:40:46.027995
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.04296	2025-06-30 07:40:46.04296
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.089907	2025-06-30 07:40:46.089907
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.109774	2025-06-30 07:40:46.109774
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.155895	2025-06-30 07:40:46.155895
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.169778	2025-06-30 07:40:46.169778
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.185773	2025-06-30 07:40:46.185773
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.199429	2025-06-30 07:40:46.199429
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.212734	2025-06-30 07:40:46.212734
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 07:40:46.224805	2025-06-30 07:40:46.224805
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.266624	2025-06-30 07:40:46.266624
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.313536	2025-06-30 07:40:46.313536
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.328531	2025-06-30 07:40:46.328531
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.340881	2025-06-30 07:40:46.340881
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.355341	2025-06-30 07:40:46.355341
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.368068	2025-06-30 07:40:46.368068
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.412466	2025-06-30 07:40:46.412466
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.423392	2025-06-30 07:40:46.423392
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.436816	2025-06-30 07:40:46.436816
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.480573	2025-06-30 07:40:46.480573
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.527797	2025-06-30 07:40:46.527797
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.542773	2025-06-30 07:40:46.542773
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.586813	2025-06-30 07:40:46.586813
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.605954	2025-06-30 07:40:46.605954
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.650902	2025-06-30 07:40:46.650902
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.663565	2025-06-30 07:40:46.663565
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.709845	2025-06-30 07:40:46.709845
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.722836	2025-06-30 07:40:46.722836
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.737864	2025-06-30 07:40:46.737864
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.782817	2025-06-30 07:40:46.782817
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.794967	2025-06-30 07:40:46.794967
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.808642	2025-06-30 07:40:46.808642
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.824658	2025-06-30 07:40:46.824658
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.836813	2025-06-30 07:40:46.836813
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.881475	2025-06-30 07:40:46.881475
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.893535	2025-06-30 07:40:46.893535
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.90714	2025-06-30 07:40:46.90714
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.921106	2025-06-30 07:40:46.921106
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.964983	2025-06-30 07:40:46.964983
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.977701	2025-06-30 07:40:46.977701
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:46.990437	2025-06-30 07:40:46.990437
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.035674	2025-06-30 07:40:47.035674
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.081684	2025-06-30 07:40:47.081684
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.095341	2025-06-30 07:40:47.095341
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.138887	2025-06-30 07:40:47.138887
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.152437	2025-06-30 07:40:47.152437
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.196681	2025-06-30 07:40:47.196681
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.283712	2025-06-30 07:40:47.283712
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.329687	2025-06-30 07:40:47.329687
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.343208	2025-06-30 07:40:47.343208
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.390997	2025-06-30 07:40:47.390997
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.402517	2025-06-30 07:40:47.402517
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.41558	2025-06-30 07:40:47.41558
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.42703	2025-06-30 07:40:47.42703
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.439022	2025-06-30 07:40:47.439022
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.482169	2025-06-30 07:40:47.482169
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.49333	2025-06-30 07:40:47.49333
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.508171	2025-06-30 07:40:47.508171
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.552014	2025-06-30 07:40:47.552014
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.564531	2025-06-30 07:40:47.564531
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.577878	2025-06-30 07:40:47.577878
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.591414	2025-06-30 07:40:47.591414
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.605013	2025-06-30 07:40:47.605013
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.624134	2025-06-30 07:40:47.624134
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.634933	2025-06-30 07:40:47.634933
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.647801	2025-06-30 07:40:47.647801
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.66299	2025-06-30 07:40:47.66299
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.684631	2025-06-30 07:40:47.684631
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.698067	2025-06-30 07:40:47.698067
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.711341	2025-06-30 07:40:47.711341
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.722878	2025-06-30 07:40:47.722878
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.734592	2025-06-30 07:40:47.734592
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.747817	2025-06-30 07:40:47.747817
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.756289	2025-06-30 07:40:47.756289
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.764143	2025-06-30 07:40:47.764143
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.772502	2025-06-30 07:40:47.772502
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.781491	2025-06-30 07:40:47.781491
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.799769	2025-06-30 07:40:47.799769
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.817269	2025-06-30 07:40:47.817269
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.830924	2025-06-30 07:40:47.830924
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.843898	2025-06-30 07:40:47.843898
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.857746	2025-06-30 07:40:47.857746
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.870632	2025-06-30 07:40:47.870632
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.882786	2025-06-30 07:40:47.882786
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.895589	2025-06-30 07:40:47.895589
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.903462	2025-06-30 07:40:47.903462
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.911319	2025-06-30 07:40:47.911319
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.917534	2025-06-30 07:40:47.917534
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.924189	2025-06-30 07:40:47.924189
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.93083	2025-06-30 07:40:47.93083
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.93786	2025-06-30 07:40:47.93786
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.944516	2025-06-30 07:40:47.944516
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.951507	2025-06-30 07:40:47.951507
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.959058	2025-06-30 07:40:47.959058
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.96648	2025-06-30 07:40:47.96648
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.975527	2025-06-30 07:40:47.975527
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.982624	2025-06-30 07:40:47.982624
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.989083	2025-06-30 07:40:47.989083
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:47.997684	2025-06-30 07:40:47.997684
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.003975	2025-06-30 07:40:48.003975
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.010724	2025-06-30 07:40:48.010724
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.017336	2025-06-30 07:40:48.017336
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.024833	2025-06-30 07:40:48.024833
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.033799	2025-06-30 07:40:48.033799
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.042635	2025-06-30 07:40:48.042635
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.049067	2025-06-30 07:40:48.049067
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.056698	2025-06-30 07:40:48.056698
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.064112	2025-06-30 07:40:48.064112
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.07123	2025-06-30 07:40:48.07123
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.078201	2025-06-30 07:40:48.078201
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.085573	2025-06-30 07:40:48.085573
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.092548	2025-06-30 07:40:48.092548
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.099096	2025-06-30 07:40:48.099096
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.106579	2025-06-30 07:40:48.106579
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.114265	2025-06-30 07:40:48.114265
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.121517	2025-06-30 07:40:48.121517
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.12864	2025-06-30 07:40:48.12864
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.1358	2025-06-30 07:40:48.1358
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.14452	2025-06-30 07:40:48.14452
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.151398	2025-06-30 07:40:48.151398
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.158749	2025-06-30 07:40:48.158749
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.166067	2025-06-30 07:40:48.166067
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.173144	2025-06-30 07:40:48.173144
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.180279	2025-06-30 07:40:48.180279
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.188077	2025-06-30 07:40:48.188077
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.195427	2025-06-30 07:40:48.195427
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.202611	2025-06-30 07:40:48.202611
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.209538	2025-06-30 07:40:48.209538
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.216466	2025-06-30 07:40:48.216466
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.223606	2025-06-30 07:40:48.223606
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.230832	2025-06-30 07:40:48.230832
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.23737	2025-06-30 07:40:48.23737
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.244256	2025-06-30 07:40:48.244256
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.252853	2025-06-30 07:40:48.252853
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.260176	2025-06-30 07:40:48.260176
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.267032	2025-06-30 07:40:48.267032
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.274085	2025-06-30 07:40:48.274085
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.281229	2025-06-30 07:40:48.281229
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.287791	2025-06-30 07:40:48.287791
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.295363	2025-06-30 07:40:48.295363
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.302728	2025-06-30 07:40:48.302728
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.30979	2025-06-30 07:40:48.30979
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.316246	2025-06-30 07:40:48.316246
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.323911	2025-06-30 07:40:48.323911
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.330382	2025-06-30 07:40:48.330382
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.338124	2025-06-30 07:40:48.338124
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.344735	2025-06-30 07:40:48.344735
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.351727	2025-06-30 07:40:48.351727
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.357903	2025-06-30 07:40:48.357903
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.365811	2025-06-30 07:40:48.365811
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.372323	2025-06-30 07:40:48.372323
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.378844	2025-06-30 07:40:48.378844
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.385461	2025-06-30 07:40:48.385461
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.392191	2025-06-30 07:40:48.392191
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.399313	2025-06-30 07:40:48.399313
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.407413	2025-06-30 07:40:48.407413
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.414549	2025-06-30 07:40:48.414549
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.421843	2025-06-30 07:40:48.421843
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.429753	2025-06-30 07:40:48.429753
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.436578	2025-06-30 07:40:48.436578
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.444965	2025-06-30 07:40:48.444965
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.451895	2025-06-30 07:40:48.451895
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.459868	2025-06-30 07:40:48.459868
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.467927	2025-06-30 07:40:48.467927
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.475181	2025-06-30 07:40:48.475181
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.482593	2025-06-30 07:40:48.482593
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.490353	2025-06-30 07:40:48.490353
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.497115	2025-06-30 07:40:48.497115
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.503704	2025-06-30 07:40:48.503704
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.511213	2025-06-30 07:40:48.511213
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.522962	2025-06-30 07:40:48.522962
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.529749	2025-06-30 07:40:48.529749
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.53669	2025-06-30 07:40:48.53669
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.544263	2025-06-30 07:40:48.544263
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.552136	2025-06-30 07:40:48.552136
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.559162	2025-06-30 07:40:48.559162
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.567223	2025-06-30 07:40:48.567223
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.574321	2025-06-30 07:40:48.574321
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.583011	2025-06-30 07:40:48.583011
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.590658	2025-06-30 07:40:48.590658
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.59987	2025-06-30 07:40:48.59987
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.606717	2025-06-30 07:40:48.606717
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.615328	2025-06-30 07:40:48.615328
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.621569	2025-06-30 07:40:48.621569
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.629551	2025-06-30 07:40:48.629551
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.636674	2025-06-30 07:40:48.636674
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.643416	2025-06-30 07:40:48.643416
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.650014	2025-06-30 07:40:48.650014
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.657571	2025-06-30 07:40:48.657571
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.664605	2025-06-30 07:40:48.664605
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.671205	2025-06-30 07:40:48.671205
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.677754	2025-06-30 07:40:48.677754
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.684379	2025-06-30 07:40:48.684379
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.691116	2025-06-30 07:40:48.691116
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.697653	2025-06-30 07:40:48.697653
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.705371	2025-06-30 07:40:48.705371
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.713721	2025-06-30 07:40:48.713721
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.720968	2025-06-30 07:40:48.720968
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.727879	2025-06-30 07:40:48.727879
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.735506	2025-06-30 07:40:48.735506
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.742445	2025-06-30 07:40:48.742445
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.749551	2025-06-30 07:40:48.749551
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.758735	2025-06-30 07:40:48.758735
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.766553	2025-06-30 07:40:48.766553
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.774755	2025-06-30 07:40:48.774755
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.786677	2025-06-30 07:40:48.786677
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.793147	2025-06-30 07:40:48.793147
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.80064	2025-06-30 07:40:48.80064
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.807271	2025-06-30 07:40:48.807271
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.814201	2025-06-30 07:40:48.814201
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.820864	2025-06-30 07:40:48.820864
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.831073	2025-06-30 07:40:48.831073
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.840081	2025-06-30 07:40:48.840081
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.850212	2025-06-30 07:40:48.850212
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.857332	2025-06-30 07:40:48.857332
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.86415	2025-06-30 07:40:48.86415
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.871631	2025-06-30 07:40:48.871631
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.878413	2025-06-30 07:40:48.878413
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.886518	2025-06-30 07:40:48.886518
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.895914	2025-06-30 07:40:48.895914
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.908178	2025-06-30 07:40:48.908178
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.922845	2025-06-30 07:40:48.922845
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.934673	2025-06-30 07:40:48.934673
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:48.948106	2025-06-30 07:40:48.948106
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.23158	2025-06-30 07:40:49.23158
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.271726	2025-06-30 07:40:49.271726
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.324045	2025-06-30 07:40:49.324045
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.332715	2025-06-30 07:40:49.332715
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.339388	2025-06-30 07:40:49.339388
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.347442	2025-06-30 07:40:49.347442
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.354288	2025-06-30 07:40:49.354288
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.362447	2025-06-30 07:40:49.362447
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.370606	2025-06-30 07:40:49.370606
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.378964	2025-06-30 07:40:49.378964
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.386014	2025-06-30 07:40:49.386014
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.395301	2025-06-30 07:40:49.395301
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.404021	2025-06-30 07:40:49.404021
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.413483	2025-06-30 07:40:49.413483
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.422427	2025-06-30 07:40:49.422427
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.42872	2025-06-30 07:40:49.42872
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.433485	2025-06-30 07:40:49.433485
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.43886	2025-06-30 07:40:49.43886
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.444221	2025-06-30 07:40:49.444221
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.448153	2025-06-30 07:40:49.448153
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.457334	2025-06-30 07:40:49.457334
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.463989	2025-06-30 07:40:49.463989
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.471087	2025-06-30 07:40:49.471087
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.479526	2025-06-30 07:40:49.479526
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.578534	2025-06-30 07:40:49.578534
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.606989	2025-06-30 07:40:49.606989
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.625187	2025-06-30 07:40:49.625187
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.631774	2025-06-30 07:40:49.631774
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.640389	2025-06-30 07:40:49.640389
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.647891	2025-06-30 07:40:49.647891
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.656193	2025-06-30 07:40:49.656193
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.663586	2025-06-30 07:40:49.663586
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.670095	2025-06-30 07:40:49.670095
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.67656	2025-06-30 07:40:49.67656
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.685149	2025-06-30 07:40:49.685149
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.693346	2025-06-30 07:40:49.693346
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.702394	2025-06-30 07:40:49.702394
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.712781	2025-06-30 07:40:49.712781
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.720361	2025-06-30 07:40:49.720361
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.732212	2025-06-30 07:40:49.732212
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.737751	2025-06-30 07:40:49.737751
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.746372	2025-06-30 07:40:49.746372
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.755393	2025-06-30 07:40:49.755393
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.766177	2025-06-30 07:40:49.766177
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.776229	2025-06-30 07:40:49.776229
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.785877	2025-06-30 07:40:49.785877
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.795063	2025-06-30 07:40:49.795063
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.803536	2025-06-30 07:40:49.803536
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.808392	2025-06-30 07:40:49.808392
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.817067	2025-06-30 07:40:49.817067
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.823365	2025-06-30 07:40:49.823365
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.831845	2025-06-30 07:40:49.831845
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.840245	2025-06-30 07:40:49.840245
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.848532	2025-06-30 07:40:49.848532
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.856581	2025-06-30 07:40:49.856581
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.865532	2025-06-30 07:40:49.865532
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.873392	2025-06-30 07:40:49.873392
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.882192	2025-06-30 07:40:49.882192
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.8908	2025-06-30 07:40:49.8908
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.899267	2025-06-30 07:40:49.899267
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.907782	2025-06-30 07:40:49.907782
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.920495	2025-06-30 07:40:49.920495
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.92594	2025-06-30 07:40:49.92594
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.934233	2025-06-30 07:40:49.934233
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.946002	2025-06-30 07:40:49.946002
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.953541	2025-06-30 07:40:49.953541
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.959127	2025-06-30 07:40:49.959127
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.970713	2025-06-30 07:40:49.970713
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.975812	2025-06-30 07:40:49.975812
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.984194	2025-06-30 07:40:49.984194
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.994648	2025-06-30 07:40:49.994648
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:49.999827	2025-06-30 07:40:49.999827
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.008412	2025-06-30 07:40:50.008412
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.012957	2025-06-30 07:40:50.012957
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.022688	2025-06-30 07:40:50.022688
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.031413	2025-06-30 07:40:50.031413
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.039968	2025-06-30 07:40:50.039968
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.049515	2025-06-30 07:40:50.049515
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.058378	2025-06-30 07:40:50.058378
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 07:40:50.069293	2025-06-30 07:40:50.069293
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-30 07:40:20.057402
2	ART Coverage	\N	\N	2025-06-30 07:40:20.061497
3	People Living with HIV	\N	\N	2025-06-30 07:40:20.067631
4	HIV-related Deaths	\N	\N	2025-06-30 07:40:20.070359
5	HIV Cases Adults 15-49	\N	\N	2025-06-30 07:40:20.073197
6	ART Pediatric Coverage	\N	\N	2025-06-30 07:40:20.077646
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminfr	$2b$12$9X7EhmsTFOBUitABWlw9kOIjvL9ZyuEHufpq41W6wEc/X0DIRRRWi	admin	0	2025-06-30 07:40:20.037201	2025-06-30 07:40:20.037201
2	userfr	$2b$12$lpcVVMlPidgD0Hn5zRoVNuWqeBQxoMNzh24cz7Mdqwi8acBH6KCLC	user	0	2025-06-30 07:40:20.048924	2025-06-30 07:40:20.048924
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

