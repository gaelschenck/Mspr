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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-30 08:30:42.270654	2025-06-30 08:30:42.270654
2	Albania	Europe	\N	2025-06-30 08:30:42.276414	2025-06-30 08:30:42.276414
3	Algeria	Africa	\N	2025-06-30 08:30:42.282323	2025-06-30 08:30:42.282323
4	Angola	Africa	\N	2025-06-30 08:30:42.291435	2025-06-30 08:30:42.291435
5	Argentina	Americas	\N	2025-06-30 08:30:42.297756	2025-06-30 08:30:42.297756
6	Armenia	Europe	\N	2025-06-30 08:30:42.30689	2025-06-30 08:30:42.30689
7	Australia	Western Pacific	\N	2025-06-30 08:30:42.312935	2025-06-30 08:30:42.312935
8	Austria	Europe	\N	2025-06-30 08:30:42.318725	2025-06-30 08:30:42.318725
9	Azerbaijan	Europe	\N	2025-06-30 08:30:42.326122	2025-06-30 08:30:42.326122
10	Bahamas	Americas	\N	2025-06-30 08:30:42.332262	2025-06-30 08:30:42.332262
11	Bahrain	Eastern Mediterranean	\N	2025-06-30 08:30:42.33967	2025-06-30 08:30:42.33967
12	Bangladesh	South-East Asia	\N	2025-06-30 08:30:42.346627	2025-06-30 08:30:42.346627
13	Barbados	Americas	\N	2025-06-30 08:30:42.353329	2025-06-30 08:30:42.353329
14	Belarus	Europe	\N	2025-06-30 08:30:42.359077	2025-06-30 08:30:42.359077
15	Belgium	Europe	\N	2025-06-30 08:30:42.366266	2025-06-30 08:30:42.366266
16	Belize	Americas	\N	2025-06-30 08:30:42.372081	2025-06-30 08:30:42.372081
17	Benin	Africa	\N	2025-06-30 08:30:42.377931	2025-06-30 08:30:42.377931
18	Bhutan	South-East Asia	\N	2025-06-30 08:30:42.383755	2025-06-30 08:30:42.383755
19	Bolivia	Americas	\N	2025-06-30 08:30:42.39003	2025-06-30 08:30:42.39003
20	Bosnia and Herzegovina	Europe	\N	2025-06-30 08:30:42.396526	2025-06-30 08:30:42.396526
21	Botswana	Africa	\N	2025-06-30 08:30:42.403471	2025-06-30 08:30:42.403471
22	Brazil	Americas	\N	2025-06-30 08:30:42.411361	2025-06-30 08:30:42.411361
23	Brunei Darussalam	Western Pacific	\N	2025-06-30 08:30:42.41819	2025-06-30 08:30:42.41819
24	Bulgaria	Europe	\N	2025-06-30 08:30:42.425484	2025-06-30 08:30:42.425484
25	Burkina Faso	Africa	\N	2025-06-30 08:30:42.433818	2025-06-30 08:30:42.433818
26	Burundi	Africa	\N	2025-06-30 08:30:42.441739	2025-06-30 08:30:42.441739
27	Cabo Verde	Africa	\N	2025-06-30 08:30:42.46539	2025-06-30 08:30:42.46539
28	Cambodia	Western Pacific	\N	2025-06-30 08:30:42.474479	2025-06-30 08:30:42.474479
29	Cameroon	Africa	\N	2025-06-30 08:30:42.480888	2025-06-30 08:30:42.480888
30	Canada	Americas	\N	2025-06-30 08:30:42.488715	2025-06-30 08:30:42.488715
31	Central African Republic	Africa	\N	2025-06-30 08:30:42.506364	2025-06-30 08:30:42.506364
32	Chad	Africa	\N	2025-06-30 08:30:42.513165	2025-06-30 08:30:42.513165
33	Chile	Americas	\N	2025-06-30 08:30:42.519797	2025-06-30 08:30:42.519797
34	China	Western Pacific	\N	2025-06-30 08:30:42.526647	2025-06-30 08:30:42.526647
35	Colombia	Americas	\N	2025-06-30 08:30:42.53326	2025-06-30 08:30:42.53326
36	Comoros	Africa	\N	2025-06-30 08:30:42.540156	2025-06-30 08:30:42.540156
37	Congo	Americas	\N	2025-06-30 08:30:42.547718	2025-06-30 08:30:42.547718
38	Costa Rica	Americas	\N	2025-06-30 08:30:42.554232	2025-06-30 08:30:42.554232
39	Côte d'Ivoire	Africa	\N	2025-06-30 08:30:42.561199	2025-06-30 08:30:42.561199
40	Croatia	Europe	\N	2025-06-30 08:30:42.567733	2025-06-30 08:30:42.567733
41	Cuba	Americas	\N	2025-06-30 08:30:42.574773	2025-06-30 08:30:42.574773
42	Cyprus	Europe	\N	2025-06-30 08:30:42.581331	2025-06-30 08:30:42.581331
43	Czechia	Europe	\N	2025-06-30 08:30:42.588106	2025-06-30 08:30:42.588106
44	North Korea	Western Pacific	\N	2025-06-30 08:30:42.595014	2025-06-30 08:30:42.595014
45	DR Congo	Africa	\N	2025-06-30 08:30:42.601939	2025-06-30 08:30:42.601939
46	Denmark	Europe	\N	2025-06-30 08:30:42.610303	2025-06-30 08:30:42.610303
47	Djibouti	Eastern Mediterranean	\N	2025-06-30 08:30:42.618634	2025-06-30 08:30:42.618634
48	Dominican Republic	Americas	\N	2025-06-30 08:30:42.625685	2025-06-30 08:30:42.625685
49	Ecuador	Americas	\N	2025-06-30 08:30:42.632208	2025-06-30 08:30:42.632208
50	Egypt	Eastern Mediterranean	\N	2025-06-30 08:30:42.638871	2025-06-30 08:30:42.638871
51	El Salvador	Americas	\N	2025-06-30 08:30:42.66592	2025-06-30 08:30:42.66592
52	Equatorial Guinea	Africa	\N	2025-06-30 08:30:42.675046	2025-06-30 08:30:42.675046
53	Eritrea	Africa	\N	2025-06-30 08:30:42.683898	2025-06-30 08:30:42.683898
54	Estonia	Europe	\N	2025-06-30 08:30:42.690505	2025-06-30 08:30:42.690505
55	Eswatini	Africa	\N	2025-06-30 08:30:42.696963	2025-06-30 08:30:42.696963
56	Ethiopia	Africa	\N	2025-06-30 08:30:42.705093	2025-06-30 08:30:42.705093
57	Fiji	Western Pacific	\N	2025-06-30 08:30:42.711747	2025-06-30 08:30:42.711747
58	Finland	Europe	\N	2025-06-30 08:30:42.718271	2025-06-30 08:30:42.718271
59	France	Europe	\N	2025-06-30 08:30:42.725113	2025-06-30 08:30:42.725113
60	Gabon	Africa	\N	2025-06-30 08:30:42.731469	2025-06-30 08:30:42.731469
61	Gambia	Africa	\N	2025-06-30 08:30:42.739557	2025-06-30 08:30:42.739557
62	Georgia	Europe	\N	2025-06-30 08:30:42.746452	2025-06-30 08:30:42.746452
63	Germany	Europe	\N	2025-06-30 08:30:42.753107	2025-06-30 08:30:42.753107
64	Ghana	Africa	\N	2025-06-30 08:30:42.759687	2025-06-30 08:30:42.759687
65	Greece	Europe	\N	2025-06-30 08:30:42.766567	2025-06-30 08:30:42.766567
66	Guatemala	Americas	\N	2025-06-30 08:30:42.773768	2025-06-30 08:30:42.773768
67	Guinea	Africa	\N	2025-06-30 08:30:42.780718	2025-06-30 08:30:42.780718
68	Guinea-Bissau	Africa	\N	2025-06-30 08:30:42.788063	2025-06-30 08:30:42.788063
69	Guyana	Americas	\N	2025-06-30 08:30:42.795472	2025-06-30 08:30:42.795472
70	Haiti	Americas	\N	2025-06-30 08:30:42.803771	2025-06-30 08:30:42.803771
71	Honduras	Americas	\N	2025-06-30 08:30:42.812301	2025-06-30 08:30:42.812301
72	Hungary	Europe	\N	2025-06-30 08:30:42.819409	2025-06-30 08:30:42.819409
73	Iceland	Europe	\N	2025-06-30 08:30:42.827468	2025-06-30 08:30:42.827468
74	India	South-East Asia	\N	2025-06-30 08:30:42.8388	2025-06-30 08:30:42.8388
75	Indonesia	South-East Asia	\N	2025-06-30 08:30:42.845469	2025-06-30 08:30:42.845469
76	Iran	Eastern Mediterranean	\N	2025-06-30 08:30:42.85275	2025-06-30 08:30:42.85275
77	Ireland	Europe	\N	2025-06-30 08:30:42.863182	2025-06-30 08:30:42.863182
78	Israel	Europe	\N	2025-06-30 08:30:42.872774	2025-06-30 08:30:42.872774
79	Italy	Europe	\N	2025-06-30 08:30:42.881522	2025-06-30 08:30:42.881522
80	Jamaica	Americas	\N	2025-06-30 08:30:42.88796	2025-06-30 08:30:42.88796
81	Japan	Western Pacific	\N	2025-06-30 08:30:42.895062	2025-06-30 08:30:42.895062
82	Jordan	Eastern Mediterranean	\N	2025-06-30 08:30:42.901607	2025-06-30 08:30:42.901607
83	Kazakhstan	Europe	\N	2025-06-30 08:30:42.908471	2025-06-30 08:30:42.908471
84	Kenya	Africa	\N	2025-06-30 08:30:42.915752	2025-06-30 08:30:42.915752
85	Kuwait	Eastern Mediterranean	\N	2025-06-30 08:30:42.923184	2025-06-30 08:30:42.923184
86	Kyrgyzstan	Europe	\N	2025-06-30 08:30:42.930478	2025-06-30 08:30:42.930478
87	Laos	Western Pacific	\N	2025-06-30 08:30:42.944859	2025-06-30 08:30:42.944859
88	Latvia	Europe	\N	2025-06-30 08:30:42.952458	2025-06-30 08:30:42.952458
89	Lebanon	Eastern Mediterranean	\N	2025-06-30 08:30:42.961449	2025-06-30 08:30:42.961449
90	Lesotho	Africa	\N	2025-06-30 08:30:42.977312	2025-06-30 08:30:42.977312
91	Liberia	Africa	\N	2025-06-30 08:30:42.985299	2025-06-30 08:30:42.985299
92	Libya	Eastern Mediterranean	\N	2025-06-30 08:30:43.020606	2025-06-30 08:30:43.020606
93	Lithuania	Europe	\N	2025-06-30 08:30:43.029668	2025-06-30 08:30:43.029668
94	Luxembourg	Europe	\N	2025-06-30 08:30:43.037191	2025-06-30 08:30:43.037191
95	Madagascar	Africa	\N	2025-06-30 08:30:43.045949	2025-06-30 08:30:43.045949
96	Malawi	Africa	\N	2025-06-30 08:30:43.05572	2025-06-30 08:30:43.05572
97	Malaysia	Western Pacific	\N	2025-06-30 08:30:43.062346	2025-06-30 08:30:43.062346
98	Maldives	South-East Asia	\N	2025-06-30 08:30:43.069044	2025-06-30 08:30:43.069044
99	Mali	Africa	\N	2025-06-30 08:30:43.075619	2025-06-30 08:30:43.075619
100	Malta	Europe	\N	2025-06-30 08:30:43.082601	2025-06-30 08:30:43.082601
101	Mauritania	Africa	\N	2025-06-30 08:30:43.089622	2025-06-30 08:30:43.089622
102	Mauritius	Africa	\N	2025-06-30 08:30:43.096501	2025-06-30 08:30:43.096501
103	Mexico	Americas	\N	2025-06-30 08:30:43.103982	2025-06-30 08:30:43.103982
104	Mongolia	Western Pacific	\N	2025-06-30 08:30:43.110703	2025-06-30 08:30:43.110703
105	Montenegro	Europe	\N	2025-06-30 08:30:43.119831	2025-06-30 08:30:43.119831
106	Morocco	Eastern Mediterranean	\N	2025-06-30 08:30:43.126594	2025-06-30 08:30:43.126594
107	Mozambique	Africa	\N	2025-06-30 08:30:43.134923	2025-06-30 08:30:43.134923
108	Myanmar	South-East Asia	\N	2025-06-30 08:30:43.17543	2025-06-30 08:30:43.17543
109	Namibia	Africa	\N	2025-06-30 08:30:43.23562	2025-06-30 08:30:43.23562
110	Nepal	South-East Asia	\N	2025-06-30 08:30:43.287875	2025-06-30 08:30:43.287875
111	Netherlands	Europe	\N	2025-06-30 08:30:43.326043	2025-06-30 08:30:43.326043
112	New Zealand	Western Pacific	\N	2025-06-30 08:30:43.333013	2025-06-30 08:30:43.333013
113	Nicaragua	Americas	\N	2025-06-30 08:30:43.339948	2025-06-30 08:30:43.339948
114	Niger	Africa	\N	2025-06-30 08:30:43.379033	2025-06-30 08:30:43.379033
115	Nigeria	Africa	\N	2025-06-30 08:30:43.387038	2025-06-30 08:30:43.387038
116	Norway	Europe	\N	2025-06-30 08:30:43.39544	2025-06-30 08:30:43.39544
117	Oman	Eastern Mediterranean	\N	2025-06-30 08:30:43.404423	2025-06-30 08:30:43.404423
118	Pakistan	Eastern Mediterranean	\N	2025-06-30 08:30:43.41301	2025-06-30 08:30:43.41301
119	Panama	Americas	\N	2025-06-30 08:30:43.420312	2025-06-30 08:30:43.420312
120	Papua New Guinea	Western Pacific	\N	2025-06-30 08:30:43.449667	2025-06-30 08:30:43.449667
121	Paraguay	Americas	\N	2025-06-30 08:30:43.45652	2025-06-30 08:30:43.45652
122	Peru	Americas	\N	2025-06-30 08:30:43.530103	2025-06-30 08:30:43.530103
123	Philippines	Western Pacific	\N	2025-06-30 08:30:43.538545	2025-06-30 08:30:43.538545
124	Poland	Europe	\N	2025-06-30 08:30:43.545691	2025-06-30 08:30:43.545691
125	Portugal	Europe	\N	2025-06-30 08:30:43.602311	2025-06-30 08:30:43.602311
126	Qatar	Eastern Mediterranean	\N	2025-06-30 08:30:43.608367	2025-06-30 08:30:43.608367
127	South Korea	Western Pacific	\N	2025-06-30 08:30:43.640994	2025-06-30 08:30:43.640994
128	Moldova	Europe	\N	2025-06-30 08:30:43.648115	2025-06-30 08:30:43.648115
129	North Macedonia	Europe	\N	2025-06-30 08:30:43.655173	2025-06-30 08:30:43.655173
130	Romania	Europe	\N	2025-06-30 08:30:43.662682	2025-06-30 08:30:43.662682
131	Russia	Europe	\N	2025-06-30 08:30:43.66938	2025-06-30 08:30:43.66938
132	Rwanda	Africa	\N	2025-06-30 08:30:43.678064	2025-06-30 08:30:43.678064
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-30 08:30:43.685981	2025-06-30 08:30:43.685981
134	Senegal	Africa	\N	2025-06-30 08:30:43.696844	2025-06-30 08:30:43.696844
135	Serbia	Europe	\N	2025-06-30 08:30:43.704356	2025-06-30 08:30:43.704356
136	Sierra Leone	Africa	\N	2025-06-30 08:30:43.7114	2025-06-30 08:30:43.7114
137	Singapore	Western Pacific	\N	2025-06-30 08:30:43.718952	2025-06-30 08:30:43.718952
138	Slovakia	Europe	\N	2025-06-30 08:30:43.725774	2025-06-30 08:30:43.725774
139	Slovenia	Europe	\N	2025-06-30 08:30:43.7327	2025-06-30 08:30:43.7327
140	Somalia	Eastern Mediterranean	\N	2025-06-30 08:30:43.739598	2025-06-30 08:30:43.739598
141	South Africa	Africa	\N	2025-06-30 08:30:43.748106	2025-06-30 08:30:43.748106
142	South Sudan	Africa	\N	2025-06-30 08:30:43.75552	2025-06-30 08:30:43.75552
143	Spain	Europe	\N	2025-06-30 08:30:43.770852	2025-06-30 08:30:43.770852
144	Sri Lanka	South-East Asia	\N	2025-06-30 08:30:43.787654	2025-06-30 08:30:43.787654
145	Sudan	Eastern Mediterranean	\N	2025-06-30 08:30:43.794193	2025-06-30 08:30:43.794193
146	Suriname	Americas	\N	2025-06-30 08:30:43.801167	2025-06-30 08:30:43.801167
147	Sweden	Europe	\N	2025-06-30 08:30:43.807836	2025-06-30 08:30:43.807836
148	Switzerland	Europe	\N	2025-06-30 08:30:43.819268	2025-06-30 08:30:43.819268
149	Syria	Eastern Mediterranean	\N	2025-06-30 08:30:43.826369	2025-06-30 08:30:43.826369
150	Tajikistan	Europe	\N	2025-06-30 08:30:43.83449	2025-06-30 08:30:43.83449
151	Thailand	South-East Asia	\N	2025-06-30 08:30:43.861631	2025-06-30 08:30:43.861631
152	Timor-Leste	South-East Asia	\N	2025-06-30 08:30:43.86823	2025-06-30 08:30:43.86823
153	Togo	Africa	\N	2025-06-30 08:30:43.875806	2025-06-30 08:30:43.875806
154	Trinidad and Tobago	Americas	\N	2025-06-30 08:30:43.882398	2025-06-30 08:30:43.882398
155	Tunisia	Eastern Mediterranean	\N	2025-06-30 08:30:43.890259	2025-06-30 08:30:43.890259
156	Turkey	Europe	\N	2025-06-30 08:30:43.897569	2025-06-30 08:30:43.897569
157	Turkmenistan	Europe	\N	2025-06-30 08:30:43.906298	2025-06-30 08:30:43.906298
158	Uganda	Africa	\N	2025-06-30 08:30:43.915116	2025-06-30 08:30:43.915116
159	Ukraine	Europe	\N	2025-06-30 08:30:43.922788	2025-06-30 08:30:43.922788
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-30 08:30:43.930632	2025-06-30 08:30:43.930632
161	United Kingdom	Europe	\N	2025-06-30 08:30:43.937923	2025-06-30 08:30:43.937923
162	Tanzania	Africa	\N	2025-06-30 08:30:43.944938	2025-06-30 08:30:43.944938
163	United States	Americas	\N	2025-06-30 08:30:43.952335	2025-06-30 08:30:43.952335
164	Uruguay	Americas	\N	2025-06-30 08:30:43.959891	2025-06-30 08:30:43.959891
165	Uzbekistan	Europe	\N	2025-06-30 08:30:43.966505	2025-06-30 08:30:43.966505
166	Venezuela	Americas	\N	2025-06-30 08:30:43.973713	2025-06-30 08:30:43.973713
167	Viet Nam	Western Pacific	\N	2025-06-30 08:30:43.981176	2025-06-30 08:30:43.981176
168	Yemen	Eastern Mediterranean	\N	2025-06-30 08:30:44.003297	2025-06-30 08:30:44.003297
169	Zambia	Africa	\N	2025-06-30 08:30:44.010126	2025-06-30 08:30:44.010126
170	Zimbabwe	Africa	\N	2025-06-30 08:30:44.01658	2025-06-30 08:30:44.01658
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.022937	2025-06-30 08:30:44.022937
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.032709	2025-06-30 08:30:44.032709
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.041027	2025-06-30 08:30:44.041027
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.048222	2025-06-30 08:30:44.048222
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.05579	2025-06-30 08:30:44.05579
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.062854	2025-06-30 08:30:44.062854
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.105563	2025-06-30 08:30:44.105563
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.122709	2025-06-30 08:30:44.122709
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.143069	2025-06-30 08:30:44.143069
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.159096	2025-06-30 08:30:44.159096
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.168916	2025-06-30 08:30:44.168916
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.175426	2025-06-30 08:30:44.175426
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.182669	2025-06-30 08:30:44.182669
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.190033	2025-06-30 08:30:44.190033
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.197681	2025-06-30 08:30:44.197681
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.204205	2025-06-30 08:30:44.204205
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.223394	2025-06-30 08:30:44.223394
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.231006	2025-06-30 08:30:44.231006
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.238833	2025-06-30 08:30:44.238833
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.245959	2025-06-30 08:30:44.245959
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.253417	2025-06-30 08:30:44.253417
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.260873	2025-06-30 08:30:44.260873
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.270567	2025-06-30 08:30:44.270567
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.277936	2025-06-30 08:30:44.277936
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.285876	2025-06-30 08:30:44.285876
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.292811	2025-06-30 08:30:44.292811
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.299543	2025-06-30 08:30:44.299543
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.306725	2025-06-30 08:30:44.306725
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.326883	2025-06-30 08:30:44.326883
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.363717	2025-06-30 08:30:44.363717
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.370535	2025-06-30 08:30:44.370535
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.377628	2025-06-30 08:30:44.377628
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.385591	2025-06-30 08:30:44.385591
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.397098	2025-06-30 08:30:44.397098
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.40418	2025-06-30 08:30:44.40418
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.414158	2025-06-30 08:30:44.414158
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.421127	2025-06-30 08:30:44.421127
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.428292	2025-06-30 08:30:44.428292
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.43493	2025-06-30 08:30:44.43493
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.443704	2025-06-30 08:30:44.443704
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.451041	2025-06-30 08:30:44.451041
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.459222	2025-06-30 08:30:44.459222
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.466609	2025-06-30 08:30:44.466609
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.473781	2025-06-30 08:30:44.473781
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.484692	2025-06-30 08:30:44.484692
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.492781	2025-06-30 08:30:44.492781
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.500593	2025-06-30 08:30:44.500593
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.508236	2025-06-30 08:30:44.508236
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.515349	2025-06-30 08:30:44.515349
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.522821	2025-06-30 08:30:44.522821
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.531204	2025-06-30 08:30:44.531204
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.539377	2025-06-30 08:30:44.539377
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.54656	2025-06-30 08:30:44.54656
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.554879	2025-06-30 08:30:44.554879
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.561841	2025-06-30 08:30:44.561841
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.568866	2025-06-30 08:30:44.568866
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.577304	2025-06-30 08:30:44.577304
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.585711	2025-06-30 08:30:44.585711
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.593116	2025-06-30 08:30:44.593116
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.599978	2025-06-30 08:30:44.599978
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.634726	2025-06-30 08:30:44.634726
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.681837	2025-06-30 08:30:44.681837
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.689625	2025-06-30 08:30:44.689625
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.699353	2025-06-30 08:30:44.699353
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.706411	2025-06-30 08:30:44.706411
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.718923	2025-06-30 08:30:44.718923
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.725871	2025-06-30 08:30:44.725871
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.735008	2025-06-30 08:30:44.735008
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.742644	2025-06-30 08:30:44.742644
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.750301	2025-06-30 08:30:44.750301
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.758251	2025-06-30 08:30:44.758251
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.766264	2025-06-30 08:30:44.766264
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.773336	2025-06-30 08:30:44.773336
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.781111	2025-06-30 08:30:44.781111
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.788646	2025-06-30 08:30:44.788646
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.796025	2025-06-30 08:30:44.796025
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.804416	2025-06-30 08:30:44.804416
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.811694	2025-06-30 08:30:44.811694
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.819399	2025-06-30 08:30:44.819399
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.827837	2025-06-30 08:30:44.827837
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.841947	2025-06-30 08:30:44.841947
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.848857	2025-06-30 08:30:44.848857
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.856212	2025-06-30 08:30:44.856212
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.864218	2025-06-30 08:30:44.864218
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.872725	2025-06-30 08:30:44.872725
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.880307	2025-06-30 08:30:44.880307
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.887161	2025-06-30 08:30:44.887161
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.894234	2025-06-30 08:30:44.894234
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.902175	2025-06-30 08:30:44.902175
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.909443	2025-06-30 08:30:44.909443
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.916793	2025-06-30 08:30:44.916793
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.925163	2025-06-30 08:30:44.925163
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.93255	2025-06-30 08:30:44.93255
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.940568	2025-06-30 08:30:44.940568
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.949193	2025-06-30 08:30:44.949193
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.957492	2025-06-30 08:30:44.957492
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.965132	2025-06-30 08:30:44.965132
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.973864	2025-06-30 08:30:44.973864
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.981315	2025-06-30 08:30:44.981315
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:44.990029	2025-06-30 08:30:44.990029
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.000145	2025-06-30 08:30:45.000145
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.010327	2025-06-30 08:30:45.010327
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.018587	2025-06-30 08:30:45.018587
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.027468	2025-06-30 08:30:45.027468
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.034393	2025-06-30 08:30:45.034393
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.042397	2025-06-30 08:30:45.042397
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.049464	2025-06-30 08:30:45.049464
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.058095	2025-06-30 08:30:45.058095
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.075085	2025-06-30 08:30:45.075085
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.084263	2025-06-30 08:30:45.084263
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.091214	2025-06-30 08:30:45.091214
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.09916	2025-06-30 08:30:45.09916
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.106153	2025-06-30 08:30:45.106153
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.138021	2025-06-30 08:30:45.138021
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.146018	2025-06-30 08:30:45.146018
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.154439	2025-06-30 08:30:45.154439
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.162003	2025-06-30 08:30:45.162003
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.168885	2025-06-30 08:30:45.168885
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.176304	2025-06-30 08:30:45.176304
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.183698	2025-06-30 08:30:45.183698
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.192206	2025-06-30 08:30:45.192206
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.200789	2025-06-30 08:30:45.200789
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.209134	2025-06-30 08:30:45.209134
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.216373	2025-06-30 08:30:45.216373
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.224145	2025-06-30 08:30:45.224145
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.247953	2025-06-30 08:30:45.247953
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.255936	2025-06-30 08:30:45.255936
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.263934	2025-06-30 08:30:45.263934
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.271301	2025-06-30 08:30:45.271301
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.27812	2025-06-30 08:30:45.27812
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.284698	2025-06-30 08:30:45.284698
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.291963	2025-06-30 08:30:45.291963
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.303678	2025-06-30 08:30:45.303678
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.312588	2025-06-30 08:30:45.312588
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.322776	2025-06-30 08:30:45.322776
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.333217	2025-06-30 08:30:45.333217
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.341266	2025-06-30 08:30:45.341266
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.349736	2025-06-30 08:30:45.349736
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.35737	2025-06-30 08:30:45.35737
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.36462	2025-06-30 08:30:45.36462
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.39334	2025-06-30 08:30:45.39334
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.401014	2025-06-30 08:30:45.401014
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.408594	2025-06-30 08:30:45.408594
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.415539	2025-06-30 08:30:45.415539
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.423706	2025-06-30 08:30:45.423706
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.432609	2025-06-30 08:30:45.432609
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.440007	2025-06-30 08:30:45.440007
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.447798	2025-06-30 08:30:45.447798
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.455152	2025-06-30 08:30:45.455152
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.463726	2025-06-30 08:30:45.463726
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.471992	2025-06-30 08:30:45.471992
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.496208	2025-06-30 08:30:45.496208
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.518334	2025-06-30 08:30:45.518334
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.547749	2025-06-30 08:30:45.547749
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.555914	2025-06-30 08:30:45.555914
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.56307	2025-06-30 08:30:45.56307
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.570398	2025-06-30 08:30:45.570398
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.578043	2025-06-30 08:30:45.578043
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.584915	2025-06-30 08:30:45.584915
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.593151	2025-06-30 08:30:45.593151
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.600581	2025-06-30 08:30:45.600581
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.609358	2025-06-30 08:30:45.609358
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.616253	2025-06-30 08:30:45.616253
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.62338	2025-06-30 08:30:45.62338
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.631877	2025-06-30 08:30:45.631877
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.639253	2025-06-30 08:30:45.639253
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.647653	2025-06-30 08:30:45.647653
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.654615	2025-06-30 08:30:45.654615
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.662784	2025-06-30 08:30:45.662784
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.669621	2025-06-30 08:30:45.669621
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.677516	2025-06-30 08:30:45.677516
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.68666	2025-06-30 08:30:45.68666
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.694697	2025-06-30 08:30:45.694697
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.701635	2025-06-30 08:30:45.701635
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.70998	2025-06-30 08:30:45.70998
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.716773	2025-06-30 08:30:45.716773
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.735767	2025-06-30 08:30:45.735767
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.743509	2025-06-30 08:30:45.743509
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.751979	2025-06-30 08:30:45.751979
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.759152	2025-06-30 08:30:45.759152
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.782441	2025-06-30 08:30:45.782441
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.790208	2025-06-30 08:30:45.790208
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.797978	2025-06-30 08:30:45.797978
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.830833	2025-06-30 08:30:45.830833
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.838627	2025-06-30 08:30:45.838627
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.887109	2025-06-30 08:30:45.887109
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.89499	2025-06-30 08:30:45.89499
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.933126	2025-06-30 08:30:45.933126
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.940826	2025-06-30 08:30:45.940826
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.976187	2025-06-30 08:30:45.976187
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.98396	2025-06-30 08:30:45.98396
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.99108	2025-06-30 08:30:45.99108
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:45.999017	2025-06-30 08:30:45.999017
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.006453	2025-06-30 08:30:46.006453
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.013525	2025-06-30 08:30:46.013525
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.021973	2025-06-30 08:30:46.021973
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.030798	2025-06-30 08:30:46.030798
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.038155	2025-06-30 08:30:46.038155
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.047529	2025-06-30 08:30:46.047529
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.056643	2025-06-30 08:30:46.056643
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.065113	2025-06-30 08:30:46.065113
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.073353	2025-06-30 08:30:46.073353
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.083619	2025-06-30 08:30:46.083619
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.090551	2025-06-30 08:30:46.090551
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.098033	2025-06-30 08:30:46.098033
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.10528	2025-06-30 08:30:46.10528
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.115311	2025-06-30 08:30:46.115311
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.124175	2025-06-30 08:30:46.124175
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.143727	2025-06-30 08:30:46.143727
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.178354	2025-06-30 08:30:46.178354
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.232593	2025-06-30 08:30:46.232593
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.243153	2025-06-30 08:30:46.243153
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.250203	2025-06-30 08:30:46.250203
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.25813	2025-06-30 08:30:46.25813
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.267078	2025-06-30 08:30:46.267078
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.28624	2025-06-30 08:30:46.28624
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.301646	2025-06-30 08:30:46.301646
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.310601	2025-06-30 08:30:46.310601
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.318834	2025-06-30 08:30:46.318834
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.340749	2025-06-30 08:30:46.340749
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.369759	2025-06-30 08:30:46.369759
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.37753	2025-06-30 08:30:46.37753
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.407434	2025-06-30 08:30:46.407434
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.414308	2025-06-30 08:30:46.414308
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.434923	2025-06-30 08:30:46.434923
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.443899	2025-06-30 08:30:46.443899
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.462905	2025-06-30 08:30:46.462905
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.471095	2025-06-30 08:30:46.471095
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.478349	2025-06-30 08:30:46.478349
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.486339	2025-06-30 08:30:46.486339
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.54571	2025-06-30 08:30:46.54571
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.562731	2025-06-30 08:30:46.562731
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.57007	2025-06-30 08:30:46.57007
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.57743	2025-06-30 08:30:46.57743
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.607195	2025-06-30 08:30:46.607195
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.614611	2025-06-30 08:30:46.614611
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.622798	2025-06-30 08:30:46.622798
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.631784	2025-06-30 08:30:46.631784
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.639583	2025-06-30 08:30:46.639583
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.648021	2025-06-30 08:30:46.648021
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.656025	2025-06-30 08:30:46.656025
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.664389	2025-06-30 08:30:46.664389
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.684016	2025-06-30 08:30:46.684016
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.769199	2025-06-30 08:30:46.769199
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.860237	2025-06-30 08:30:46.860237
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.87332	2025-06-30 08:30:46.87332
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.8816	2025-06-30 08:30:46.8816
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.888997	2025-06-30 08:30:46.888997
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.927778	2025-06-30 08:30:46.927778
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.967023	2025-06-30 08:30:46.967023
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.974943	2025-06-30 08:30:46.974943
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.983624	2025-06-30 08:30:46.983624
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.991922	2025-06-30 08:30:46.991922
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:46.999111	2025-06-30 08:30:46.999111
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.012672	2025-06-30 08:30:47.012672
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.020225	2025-06-30 08:30:47.020225
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.033209	2025-06-30 08:30:47.033209
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.042791	2025-06-30 08:30:47.042791
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.049931	2025-06-30 08:30:47.049931
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.084671	2025-06-30 08:30:47.084671
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.094136	2025-06-30 08:30:47.094136
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.124415	2025-06-30 08:30:47.124415
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.132296	2025-06-30 08:30:47.132296
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.140914	2025-06-30 08:30:47.140914
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.180078	2025-06-30 08:30:47.180078
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.187862	2025-06-30 08:30:47.187862
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.213008	2025-06-30 08:30:47.213008
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.235469	2025-06-30 08:30:47.235469
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.24336	2025-06-30 08:30:47.24336
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.250492	2025-06-30 08:30:47.250492
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.301573	2025-06-30 08:30:47.301573
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.308884	2025-06-30 08:30:47.308884
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.316919	2025-06-30 08:30:47.316919
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.325333	2025-06-30 08:30:47.325333
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.3343	2025-06-30 08:30:47.3343
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.342852	2025-06-30 08:30:47.342852
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.350497	2025-06-30 08:30:47.350497
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.361041	2025-06-30 08:30:47.361041
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.376523	2025-06-30 08:30:47.376523
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.386361	2025-06-30 08:30:47.386361
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.396069	2025-06-30 08:30:47.396069
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.406069	2025-06-30 08:30:47.406069
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.413337	2025-06-30 08:30:47.413337
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.461692	2025-06-30 08:30:47.461692
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.469444	2025-06-30 08:30:47.469444
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.510657	2025-06-30 08:30:47.510657
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.55123	2025-06-30 08:30:47.55123
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.559918	2025-06-30 08:30:47.559918
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.568336	2025-06-30 08:30:47.568336
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.576738	2025-06-30 08:30:47.576738
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.584131	2025-06-30 08:30:47.584131
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.609505	2025-06-30 08:30:47.609505
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.617747	2025-06-30 08:30:47.617747
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.657299	2025-06-30 08:30:47.657299
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.666119	2025-06-30 08:30:47.666119
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.705511	2025-06-30 08:30:47.705511
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.716077	2025-06-30 08:30:47.716077
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.725625	2025-06-30 08:30:47.725625
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.77877	2025-06-30 08:30:47.77877
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.800355	2025-06-30 08:30:47.800355
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.829902	2025-06-30 08:30:47.829902
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.839792	2025-06-30 08:30:47.839792
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.846738	2025-06-30 08:30:47.846738
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-30 08:30:47.855466	2025-06-30 08:30:47.855466
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.863055	2025-06-30 08:30:47.863055
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.874672	2025-06-30 08:30:47.874672
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.889252	2025-06-30 08:30:47.889252
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.898595	2025-06-30 08:30:47.898595
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.906411	2025-06-30 08:30:47.906411
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.915886	2025-06-30 08:30:47.915886
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.936925	2025-06-30 08:30:47.936925
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.954945	2025-06-30 08:30:47.954945
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.962541	2025-06-30 08:30:47.962541
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.971874	2025-06-30 08:30:47.971874
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.980595	2025-06-30 08:30:47.980595
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.988337	2025-06-30 08:30:47.988337
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:47.997581	2025-06-30 08:30:47.997581
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.004582	2025-06-30 08:30:48.004582
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.012616	2025-06-30 08:30:48.012616
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.021766	2025-06-30 08:30:48.021766
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.030763	2025-06-30 08:30:48.030763
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.040584	2025-06-30 08:30:48.040584
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.048176	2025-06-30 08:30:48.048176
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.055739	2025-06-30 08:30:48.055739
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.063345	2025-06-30 08:30:48.063345
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.0731	2025-06-30 08:30:48.0731
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.081404	2025-06-30 08:30:48.081404
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.093199	2025-06-30 08:30:48.093199
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.101975	2025-06-30 08:30:48.101975
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.125179	2025-06-30 08:30:48.125179
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.133658	2025-06-30 08:30:48.133658
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.183361	2025-06-30 08:30:48.183361
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.244062	2025-06-30 08:30:48.244062
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.299874	2025-06-30 08:30:48.299874
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.307087	2025-06-30 08:30:48.307087
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.327877	2025-06-30 08:30:48.327877
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.335656	2025-06-30 08:30:48.335656
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.346113	2025-06-30 08:30:48.346113
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.354552	2025-06-30 08:30:48.354552
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.37105	2025-06-30 08:30:48.37105
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.379219	2025-06-30 08:30:48.379219
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.387852	2025-06-30 08:30:48.387852
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.39634	2025-06-30 08:30:48.39634
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.405587	2025-06-30 08:30:48.405587
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.413238	2025-06-30 08:30:48.413238
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.422699	2025-06-30 08:30:48.422699
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.432532	2025-06-30 08:30:48.432532
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.444818	2025-06-30 08:30:48.444818
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.456939	2025-06-30 08:30:48.456939
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.471803	2025-06-30 08:30:48.471803
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.49511	2025-06-30 08:30:48.49511
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.50298	2025-06-30 08:30:48.50298
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.510537	2025-06-30 08:30:48.510537
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.523855	2025-06-30 08:30:48.523855
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.53163	2025-06-30 08:30:48.53163
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.53867	2025-06-30 08:30:48.53867
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.547399	2025-06-30 08:30:48.547399
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.55621	2025-06-30 08:30:48.55621
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.564119	2025-06-30 08:30:48.564119
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.576701	2025-06-30 08:30:48.576701
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.585149	2025-06-30 08:30:48.585149
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.594198	2025-06-30 08:30:48.594198
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.604724	2025-06-30 08:30:48.604724
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.612794	2025-06-30 08:30:48.612794
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.62063	2025-06-30 08:30:48.62063
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.629363	2025-06-30 08:30:48.629363
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.636851	2025-06-30 08:30:48.636851
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.64465	2025-06-30 08:30:48.64465
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.655801	2025-06-30 08:30:48.655801
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.665107	2025-06-30 08:30:48.665107
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.67475	2025-06-30 08:30:48.67475
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.68464	2025-06-30 08:30:48.68464
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.693254	2025-06-30 08:30:48.693254
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.703669	2025-06-30 08:30:48.703669
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.71199	2025-06-30 08:30:48.71199
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.71931	2025-06-30 08:30:48.71931
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.726745	2025-06-30 08:30:48.726745
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.736035	2025-06-30 08:30:48.736035
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.743535	2025-06-30 08:30:48.743535
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.751874	2025-06-30 08:30:48.751874
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.759248	2025-06-30 08:30:48.759248
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.770121	2025-06-30 08:30:48.770121
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.777484	2025-06-30 08:30:48.777484
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.786646	2025-06-30 08:30:48.786646
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.794923	2025-06-30 08:30:48.794923
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.804253	2025-06-30 08:30:48.804253
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.81241	2025-06-30 08:30:48.81241
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.822532	2025-06-30 08:30:48.822532
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.82939	2025-06-30 08:30:48.82939
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.837917	2025-06-30 08:30:48.837917
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.845645	2025-06-30 08:30:48.845645
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.854716	2025-06-30 08:30:48.854716
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.870168	2025-06-30 08:30:48.870168
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.878416	2025-06-30 08:30:48.878416
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.888876	2025-06-30 08:30:48.888876
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.897142	2025-06-30 08:30:48.897142
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.913883	2025-06-30 08:30:48.913883
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.921546	2025-06-30 08:30:48.921546
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.95573	2025-06-30 08:30:48.95573
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.96434	2025-06-30 08:30:48.96434
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.972585	2025-06-30 08:30:48.972585
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.981367	2025-06-30 08:30:48.981367
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:48.990486	2025-06-30 08:30:48.990486
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.000706	2025-06-30 08:30:49.000706
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.009334	2025-06-30 08:30:49.009334
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.018609	2025-06-30 08:30:49.018609
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.027498	2025-06-30 08:30:49.027498
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.034889	2025-06-30 08:30:49.034889
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.057076	2025-06-30 08:30:49.057076
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.089418	2025-06-30 08:30:49.089418
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.119524	2025-06-30 08:30:49.119524
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.128523	2025-06-30 08:30:49.128523
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.150235	2025-06-30 08:30:49.150235
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.15735	2025-06-30 08:30:49.15735
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.17476	2025-06-30 08:30:49.17476
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.183277	2025-06-30 08:30:49.183277
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.191537	2025-06-30 08:30:49.191537
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.206248	2025-06-30 08:30:49.206248
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.215455	2025-06-30 08:30:49.215455
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.222711	2025-06-30 08:30:49.222711
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.231466	2025-06-30 08:30:49.231466
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.241554	2025-06-30 08:30:49.241554
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.250433	2025-06-30 08:30:49.250433
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.258058	2025-06-30 08:30:49.258058
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.265651	2025-06-30 08:30:49.265651
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.273908	2025-06-30 08:30:49.273908
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.286499	2025-06-30 08:30:49.286499
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.293914	2025-06-30 08:30:49.293914
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.301395	2025-06-30 08:30:49.301395
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.311461	2025-06-30 08:30:49.311461
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.318433	2025-06-30 08:30:49.318433
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.327309	2025-06-30 08:30:49.327309
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.336083	2025-06-30 08:30:49.336083
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.344777	2025-06-30 08:30:49.344777
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.351347	2025-06-30 08:30:49.351347
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.358797	2025-06-30 08:30:49.358797
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.368046	2025-06-30 08:30:49.368046
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.375423	2025-06-30 08:30:49.375423
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.383463	2025-06-30 08:30:49.383463
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.392263	2025-06-30 08:30:49.392263
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.399193	2025-06-30 08:30:49.399193
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.406348	2025-06-30 08:30:49.406348
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.415297	2025-06-30 08:30:49.415297
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.423275	2025-06-30 08:30:49.423275
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.432653	2025-06-30 08:30:49.432653
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.44105	2025-06-30 08:30:49.44105
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.449244	2025-06-30 08:30:49.449244
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.457121	2025-06-30 08:30:49.457121
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.465588	2025-06-30 08:30:49.465588
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.473148	2025-06-30 08:30:49.473148
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.481978	2025-06-30 08:30:49.481978
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.489242	2025-06-30 08:30:49.489242
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.507581	2025-06-30 08:30:49.507581
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.515471	2025-06-30 08:30:49.515471
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.523736	2025-06-30 08:30:49.523736
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.531148	2025-06-30 08:30:49.531148
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.540334	2025-06-30 08:30:49.540334
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.550433	2025-06-30 08:30:49.550433
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.559495	2025-06-30 08:30:49.559495
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.570525	2025-06-30 08:30:49.570525
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.577317	2025-06-30 08:30:49.577317
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.5942	2025-06-30 08:30:49.5942
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.602035	2025-06-30 08:30:49.602035
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.608451	2025-06-30 08:30:49.608451
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.61588	2025-06-30 08:30:49.61588
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.624723	2025-06-30 08:30:49.624723
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.632427	2025-06-30 08:30:49.632427
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.641241	2025-06-30 08:30:49.641241
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.648524	2025-06-30 08:30:49.648524
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.655087	2025-06-30 08:30:49.655087
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.662752	2025-06-30 08:30:49.662752
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.669256	2025-06-30 08:30:49.669256
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.67666	2025-06-30 08:30:49.67666
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.684098	2025-06-30 08:30:49.684098
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.691181	2025-06-30 08:30:49.691181
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.698159	2025-06-30 08:30:49.698159
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.729358	2025-06-30 08:30:49.729358
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.770513	2025-06-30 08:30:49.770513
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.789525	2025-06-30 08:30:49.789525
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.797336	2025-06-30 08:30:49.797336
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.805744	2025-06-30 08:30:49.805744
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.814251	2025-06-30 08:30:49.814251
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.848593	2025-06-30 08:30:49.848593
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.857336	2025-06-30 08:30:49.857336
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.896845	2025-06-30 08:30:49.896845
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.903579	2025-06-30 08:30:49.903579
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.91758	2025-06-30 08:30:49.91758
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.925527	2025-06-30 08:30:49.925527
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.934388	2025-06-30 08:30:49.934388
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.943689	2025-06-30 08:30:49.943689
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.950707	2025-06-30 08:30:49.950707
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.96025	2025-06-30 08:30:49.96025
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.966858	2025-06-30 08:30:49.966858
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.974523	2025-06-30 08:30:49.974523
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.981902	2025-06-30 08:30:49.981902
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.991288	2025-06-30 08:30:49.991288
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:49.997758	2025-06-30 08:30:49.997758
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.005069	2025-06-30 08:30:50.005069
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.012806	2025-06-30 08:30:50.012806
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.020616	2025-06-30 08:30:50.020616
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.04214	2025-06-30 08:30:50.04214
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.049383	2025-06-30 08:30:50.049383
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.079604	2025-06-30 08:30:50.079604
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.087511	2025-06-30 08:30:50.087511
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.096877	2025-06-30 08:30:50.096877
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.10485	2025-06-30 08:30:50.10485
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.112235	2025-06-30 08:30:50.112235
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.119901	2025-06-30 08:30:50.119901
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.128449	2025-06-30 08:30:50.128449
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.135723	2025-06-30 08:30:50.135723
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.143485	2025-06-30 08:30:50.143485
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.16587	2025-06-30 08:30:50.16587
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.172445	2025-06-30 08:30:50.172445
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.179841	2025-06-30 08:30:50.179841
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.187162	2025-06-30 08:30:50.187162
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.195703	2025-06-30 08:30:50.195703
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.20486	2025-06-30 08:30:50.20486
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.229548	2025-06-30 08:30:50.229548
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.239742	2025-06-30 08:30:50.239742
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.247401	2025-06-30 08:30:50.247401
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.258655	2025-06-30 08:30:50.258655
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.269212	2025-06-30 08:30:50.269212
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.315793	2025-06-30 08:30:50.315793
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.329023	2025-06-30 08:30:50.329023
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.338097	2025-06-30 08:30:50.338097
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.345497	2025-06-30 08:30:50.345497
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.36088	2025-06-30 08:30:50.36088
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.368395	2025-06-30 08:30:50.368395
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.378628	2025-06-30 08:30:50.378628
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.38746	2025-06-30 08:30:50.38746
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.394905	2025-06-30 08:30:50.394905
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.40204	2025-06-30 08:30:50.40204
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.410634	2025-06-30 08:30:50.410634
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.417907	2025-06-30 08:30:50.417907
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.425383	2025-06-30 08:30:50.425383
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.436254	2025-06-30 08:30:50.436254
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.445406	2025-06-30 08:30:50.445406
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.453343	2025-06-30 08:30:50.453343
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.462426	2025-06-30 08:30:50.462426
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.469844	2025-06-30 08:30:50.469844
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.477597	2025-06-30 08:30:50.477597
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.484819	2025-06-30 08:30:50.484819
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.492586	2025-06-30 08:30:50.492586
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.500486	2025-06-30 08:30:50.500486
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.507443	2025-06-30 08:30:50.507443
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.51509	2025-06-30 08:30:50.51509
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.522737	2025-06-30 08:30:50.522737
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.530574	2025-06-30 08:30:50.530574
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.53752	2025-06-30 08:30:50.53752
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.546524	2025-06-30 08:30:50.546524
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.555042	2025-06-30 08:30:50.555042
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.565837	2025-06-30 08:30:50.565837
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.573722	2025-06-30 08:30:50.573722
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.580733	2025-06-30 08:30:50.580733
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.588456	2025-06-30 08:30:50.588456
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.596621	2025-06-30 08:30:50.596621
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.604117	2025-06-30 08:30:50.604117
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.611638	2025-06-30 08:30:50.611638
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.62135	2025-06-30 08:30:50.62135
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.630962	2025-06-30 08:30:50.630962
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.637719	2025-06-30 08:30:50.637719
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.646373	2025-06-30 08:30:50.646373
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.656662	2025-06-30 08:30:50.656662
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.665998	2025-06-30 08:30:50.665998
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.67377	2025-06-30 08:30:50.67377
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.681543	2025-06-30 08:30:50.681543
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.690269	2025-06-30 08:30:50.690269
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.69726	2025-06-30 08:30:50.69726
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.706111	2025-06-30 08:30:50.706111
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.714176	2025-06-30 08:30:50.714176
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.723347	2025-06-30 08:30:50.723347
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.731959	2025-06-30 08:30:50.731959
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.740814	2025-06-30 08:30:50.740814
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.788847	2025-06-30 08:30:50.788847
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.801873	2025-06-30 08:30:50.801873
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.809139	2025-06-30 08:30:50.809139
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.816578	2025-06-30 08:30:50.816578
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.825953	2025-06-30 08:30:50.825953
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.835892	2025-06-30 08:30:50.835892
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.843246	2025-06-30 08:30:50.843246
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.869456	2025-06-30 08:30:50.869456
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.889499	2025-06-30 08:30:50.889499
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.900603	2025-06-30 08:30:50.900603
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.908318	2025-06-30 08:30:50.908318
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.915506	2025-06-30 08:30:50.915506
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.923057	2025-06-30 08:30:50.923057
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.932771	2025-06-30 08:30:50.932771
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.950074	2025-06-30 08:30:50.950074
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.95977	2025-06-30 08:30:50.95977
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.967817	2025-06-30 08:30:50.967817
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.976291	2025-06-30 08:30:50.976291
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.982899	2025-06-30 08:30:50.982899
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.991152	2025-06-30 08:30:50.991152
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:50.998764	2025-06-30 08:30:50.998764
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.007854	2025-06-30 08:30:51.007854
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.014961	2025-06-30 08:30:51.014961
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.033385	2025-06-30 08:30:51.033385
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.049371	2025-06-30 08:30:51.049371
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.056664	2025-06-30 08:30:51.056664
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.065458	2025-06-30 08:30:51.065458
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.073499	2025-06-30 08:30:51.073499
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.080695	2025-06-30 08:30:51.080695
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.088847	2025-06-30 08:30:51.088847
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.096598	2025-06-30 08:30:51.096598
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.10926	2025-06-30 08:30:51.10926
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.117311	2025-06-30 08:30:51.117311
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.126081	2025-06-30 08:30:51.126081
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.134422	2025-06-30 08:30:51.134422
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.143348	2025-06-30 08:30:51.143348
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.181237	2025-06-30 08:30:51.181237
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.18992	2025-06-30 08:30:51.18992
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.198019	2025-06-30 08:30:51.198019
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.205876	2025-06-30 08:30:51.205876
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.214751	2025-06-30 08:30:51.214751
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.223963	2025-06-30 08:30:51.223963
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.232465	2025-06-30 08:30:51.232465
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.239673	2025-06-30 08:30:51.239673
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.247935	2025-06-30 08:30:51.247935
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.26683	2025-06-30 08:30:51.26683
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.275596	2025-06-30 08:30:51.275596
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.297168	2025-06-30 08:30:51.297168
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.305693	2025-06-30 08:30:51.305693
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.313291	2025-06-30 08:30:51.313291
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.322248	2025-06-30 08:30:51.322248
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.330724	2025-06-30 08:30:51.330724
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.34065	2025-06-30 08:30:51.34065
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.347151	2025-06-30 08:30:51.347151
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.354895	2025-06-30 08:30:51.354895
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.368738	2025-06-30 08:30:51.368738
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.376364	2025-06-30 08:30:51.376364
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.383463	2025-06-30 08:30:51.383463
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.391651	2025-06-30 08:30:51.391651
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.401192	2025-06-30 08:30:51.401192
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.408395	2025-06-30 08:30:51.408395
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.417779	2025-06-30 08:30:51.417779
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.42687	2025-06-30 08:30:51.42687
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.436108	2025-06-30 08:30:51.436108
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.444194	2025-06-30 08:30:51.444194
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.453743	2025-06-30 08:30:51.453743
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.462708	2025-06-30 08:30:51.462708
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.471514	2025-06-30 08:30:51.471514
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.482033	2025-06-30 08:30:51.482033
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.491119	2025-06-30 08:30:51.491119
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.50081	2025-06-30 08:30:51.50081
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.50985	2025-06-30 08:30:51.50985
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.516958	2025-06-30 08:30:51.516958
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.52479	2025-06-30 08:30:51.52479
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.532691	2025-06-30 08:30:51.532691
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.543211	2025-06-30 08:30:51.543211
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.551118	2025-06-30 08:30:51.551118
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.566448	2025-06-30 08:30:51.566448
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.575628	2025-06-30 08:30:51.575628
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.59958	2025-06-30 08:30:51.59958
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.607254	2025-06-30 08:30:51.607254
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.622762	2025-06-30 08:30:51.622762
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.629829	2025-06-30 08:30:51.629829
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.64636	2025-06-30 08:30:51.64636
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.653546	2025-06-30 08:30:51.653546
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.661777	2025-06-30 08:30:51.661777
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.670235	2025-06-30 08:30:51.670235
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.681482	2025-06-30 08:30:51.681482
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.690021	2025-06-30 08:30:51.690021
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.707722	2025-06-30 08:30:51.707722
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.717066	2025-06-30 08:30:51.717066
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.727751	2025-06-30 08:30:51.727751
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.736815	2025-06-30 08:30:51.736815
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.746376	2025-06-30 08:30:51.746376
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.755209	2025-06-30 08:30:51.755209
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.763724	2025-06-30 08:30:51.763724
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.771861	2025-06-30 08:30:51.771861
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.78084	2025-06-30 08:30:51.78084
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.789034	2025-06-30 08:30:51.789034
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.796878	2025-06-30 08:30:51.796878
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.805235	2025-06-30 08:30:51.805235
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.813335	2025-06-30 08:30:51.813335
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.844686	2025-06-30 08:30:51.844686
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.851944	2025-06-30 08:30:51.851944
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.85927	2025-06-30 08:30:51.85927
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.884658	2025-06-30 08:30:51.884658
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.893513	2025-06-30 08:30:51.893513
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.901715	2025-06-30 08:30:51.901715
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.91868	2025-06-30 08:30:51.91868
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.927063	2025-06-30 08:30:51.927063
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.934459	2025-06-30 08:30:51.934459
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.943335	2025-06-30 08:30:51.943335
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.950868	2025-06-30 08:30:51.950868
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.976554	2025-06-30 08:30:51.976554
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:51.984373	2025-06-30 08:30:51.984373
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.018574	2025-06-30 08:30:52.018574
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.026697	2025-06-30 08:30:52.026697
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.034296	2025-06-30 08:30:52.034296
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.044986	2025-06-30 08:30:52.044986
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.052695	2025-06-30 08:30:52.052695
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.061484	2025-06-30 08:30:52.061484
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.069026	2025-06-30 08:30:52.069026
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.077514	2025-06-30 08:30:52.077514
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.088097	2025-06-30 08:30:52.088097
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.096548	2025-06-30 08:30:52.096548
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.105102	2025-06-30 08:30:52.105102
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.112448	2025-06-30 08:30:52.112448
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.12128	2025-06-30 08:30:52.12128
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.129679	2025-06-30 08:30:52.129679
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.138462	2025-06-30 08:30:52.138462
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.148133	2025-06-30 08:30:52.148133
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.154989	2025-06-30 08:30:52.154989
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.162343	2025-06-30 08:30:52.162343
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.176178	2025-06-30 08:30:52.176178
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.183452	2025-06-30 08:30:52.183452
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.192169	2025-06-30 08:30:52.192169
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.200992	2025-06-30 08:30:52.200992
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.2086	2025-06-30 08:30:52.2086
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.225498	2025-06-30 08:30:52.225498
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.232728	2025-06-30 08:30:52.232728
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.239808	2025-06-30 08:30:52.239808
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.246564	2025-06-30 08:30:52.246564
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.253883	2025-06-30 08:30:52.253883
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.263022	2025-06-30 08:30:52.263022
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.273971	2025-06-30 08:30:52.273971
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.283602	2025-06-30 08:30:52.283602
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.331174	2025-06-30 08:30:52.331174
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-30 08:30:52.368945	2025-06-30 08:30:52.368945
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.378553	2025-06-30 08:30:52.378553
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.415609	2025-06-30 08:30:52.415609
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.437345	2025-06-30 08:30:52.437345
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.476611	2025-06-30 08:30:52.476611
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.481877	2025-06-30 08:30:52.481877
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.489624	2025-06-30 08:30:52.489624
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.498378	2025-06-30 08:30:52.498378
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.519468	2025-06-30 08:30:52.519468
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.527062	2025-06-30 08:30:52.527062
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.537212	2025-06-30 08:30:52.537212
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.545219	2025-06-30 08:30:52.545219
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.552756	2025-06-30 08:30:52.552756
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.559618	2025-06-30 08:30:52.559618
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.568319	2025-06-30 08:30:52.568319
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.577273	2025-06-30 08:30:52.577273
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.584629	2025-06-30 08:30:52.584629
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.593213	2025-06-30 08:30:52.593213
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.608865	2025-06-30 08:30:52.608865
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.618378	2025-06-30 08:30:52.618378
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.625611	2025-06-30 08:30:52.625611
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.634588	2025-06-30 08:30:52.634588
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.643353	2025-06-30 08:30:52.643353
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.650446	2025-06-30 08:30:52.650446
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.659801	2025-06-30 08:30:52.659801
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.66657	2025-06-30 08:30:52.66657
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.675423	2025-06-30 08:30:52.675423
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.683138	2025-06-30 08:30:52.683138
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.715718	2025-06-30 08:30:52.715718
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.765582	2025-06-30 08:30:52.765582
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.772855	2025-06-30 08:30:52.772855
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.781438	2025-06-30 08:30:52.781438
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.79004	2025-06-30 08:30:52.79004
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.797234	2025-06-30 08:30:52.797234
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.804759	2025-06-30 08:30:52.804759
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.822632	2025-06-30 08:30:52.822632
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.830079	2025-06-30 08:30:52.830079
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.838055	2025-06-30 08:30:52.838055
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.845139	2025-06-30 08:30:52.845139
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.852955	2025-06-30 08:30:52.852955
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.862018	2025-06-30 08:30:52.862018
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.868788	2025-06-30 08:30:52.868788
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.880224	2025-06-30 08:30:52.880224
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.892074	2025-06-30 08:30:52.892074
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.900933	2025-06-30 08:30:52.900933
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.909748	2025-06-30 08:30:52.909748
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.918798	2025-06-30 08:30:52.918798
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.92566	2025-06-30 08:30:52.92566
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.932983	2025-06-30 08:30:52.932983
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.944439	2025-06-30 08:30:52.944439
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.951874	2025-06-30 08:30:52.951874
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.982104	2025-06-30 08:30:52.982104
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:52.991187	2025-06-30 08:30:52.991187
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.00064	2025-06-30 08:30:53.00064
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.008563	2025-06-30 08:30:53.008563
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.018191	2025-06-30 08:30:53.018191
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.025136	2025-06-30 08:30:53.025136
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.03352	2025-06-30 08:30:53.03352
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.042993	2025-06-30 08:30:53.042993
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.051021	2025-06-30 08:30:53.051021
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.060855	2025-06-30 08:30:53.060855
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.069422	2025-06-30 08:30:53.069422
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.079706	2025-06-30 08:30:53.079706
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.087299	2025-06-30 08:30:53.087299
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.097311	2025-06-30 08:30:53.097311
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.1074	2025-06-30 08:30:53.1074
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.124082	2025-06-30 08:30:53.124082
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.131442	2025-06-30 08:30:53.131442
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.138373	2025-06-30 08:30:53.138373
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.148424	2025-06-30 08:30:53.148424
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.155442	2025-06-30 08:30:53.155442
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.16293	2025-06-30 08:30:53.16293
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.170921	2025-06-30 08:30:53.170921
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.181733	2025-06-30 08:30:53.181733
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.19136	2025-06-30 08:30:53.19136
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.200239	2025-06-30 08:30:53.200239
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.207935	2025-06-30 08:30:53.207935
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.217487	2025-06-30 08:30:53.217487
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.224893	2025-06-30 08:30:53.224893
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.233897	2025-06-30 08:30:53.233897
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.241037	2025-06-30 08:30:53.241037
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.24872	2025-06-30 08:30:53.24872
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.256366	2025-06-30 08:30:53.256366
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.268766	2025-06-30 08:30:53.268766
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.27693	2025-06-30 08:30:53.27693
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.283832	2025-06-30 08:30:53.283832
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.293022	2025-06-30 08:30:53.293022
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.301086	2025-06-30 08:30:53.301086
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.309141	2025-06-30 08:30:53.309141
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.319287	2025-06-30 08:30:53.319287
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.326742	2025-06-30 08:30:53.326742
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.334937	2025-06-30 08:30:53.334937
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.342083	2025-06-30 08:30:53.342083
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.350282	2025-06-30 08:30:53.350282
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.358145	2025-06-30 08:30:53.358145
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.365493	2025-06-30 08:30:53.365493
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.374326	2025-06-30 08:30:53.374326
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.38304	2025-06-30 08:30:53.38304
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.390893	2025-06-30 08:30:53.390893
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.400472	2025-06-30 08:30:53.400472
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.407933	2025-06-30 08:30:53.407933
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.417411	2025-06-30 08:30:53.417411
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.425501	2025-06-30 08:30:53.425501
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.432991	2025-06-30 08:30:53.432991
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.440805	2025-06-30 08:30:53.440805
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.448192	2025-06-30 08:30:53.448192
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.45591	2025-06-30 08:30:53.45591
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.464444	2025-06-30 08:30:53.464444
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.474242	2025-06-30 08:30:53.474242
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.481911	2025-06-30 08:30:53.481911
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.491335	2025-06-30 08:30:53.491335
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.500527	2025-06-30 08:30:53.500527
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.509317	2025-06-30 08:30:53.509317
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.516744	2025-06-30 08:30:53.516744
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.52424	2025-06-30 08:30:53.52424
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.533187	2025-06-30 08:30:53.533187
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.540489	2025-06-30 08:30:53.540489
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.546986	2025-06-30 08:30:53.546986
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.556326	2025-06-30 08:30:53.556326
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.56474	2025-06-30 08:30:53.56474
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.572692	2025-06-30 08:30:53.572692
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.612522	2025-06-30 08:30:53.612522
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.653818	2025-06-30 08:30:53.653818
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.663871	2025-06-30 08:30:53.663871
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.673863	2025-06-30 08:30:53.673863
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.712425	2025-06-30 08:30:53.712425
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.720395	2025-06-30 08:30:53.720395
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.759252	2025-06-30 08:30:53.759252
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.767826	2025-06-30 08:30:53.767826
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.776838	2025-06-30 08:30:53.776838
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.78623	2025-06-30 08:30:53.78623
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.793372	2025-06-30 08:30:53.793372
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.800482	2025-06-30 08:30:53.800482
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.808267	2025-06-30 08:30:53.808267
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.816863	2025-06-30 08:30:53.816863
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.823958	2025-06-30 08:30:53.823958
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.832181	2025-06-30 08:30:53.832181
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.83973	2025-06-30 08:30:53.83973
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.848864	2025-06-30 08:30:53.848864
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.856498	2025-06-30 08:30:53.856498
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.864355	2025-06-30 08:30:53.864355
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.871302	2025-06-30 08:30:53.871302
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.879642	2025-06-30 08:30:53.879642
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.886983	2025-06-30 08:30:53.886983
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.899984	2025-06-30 08:30:53.899984
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.909088	2025-06-30 08:30:53.909088
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.916119	2025-06-30 08:30:53.916119
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.925406	2025-06-30 08:30:53.925406
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.933632	2025-06-30 08:30:53.933632
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.941927	2025-06-30 08:30:53.941927
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.949842	2025-06-30 08:30:53.949842
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.958776	2025-06-30 08:30:53.958776
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.966436	2025-06-30 08:30:53.966436
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.974103	2025-06-30 08:30:53.974103
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.981457	2025-06-30 08:30:53.981457
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.991286	2025-06-30 08:30:53.991286
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:53.998407	2025-06-30 08:30:53.998407
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.009739	2025-06-30 08:30:54.009739
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.01795	2025-06-30 08:30:54.01795
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.025881	2025-06-30 08:30:54.025881
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.037169	2025-06-30 08:30:54.037169
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.045341	2025-06-30 08:30:54.045341
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.054869	2025-06-30 08:30:54.054869
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.061763	2025-06-30 08:30:54.061763
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.069316	2025-06-30 08:30:54.069316
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.078057	2025-06-30 08:30:54.078057
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.085125	2025-06-30 08:30:54.085125
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.092642	2025-06-30 08:30:54.092642
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.101882	2025-06-30 08:30:54.101882
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.109416	2025-06-30 08:30:54.109416
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.116504	2025-06-30 08:30:54.116504
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.126439	2025-06-30 08:30:54.126439
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.133111	2025-06-30 08:30:54.133111
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.141048	2025-06-30 08:30:54.141048
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.147736	2025-06-30 08:30:54.147736
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.155169	2025-06-30 08:30:54.155169
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.163151	2025-06-30 08:30:54.163151
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.169815	2025-06-30 08:30:54.169815
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.177462	2025-06-30 08:30:54.177462
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.188444	2025-06-30 08:30:54.188444
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.196623	2025-06-30 08:30:54.196623
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.204622	2025-06-30 08:30:54.204622
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.212029	2025-06-30 08:30:54.212029
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.218877	2025-06-30 08:30:54.218877
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.227517	2025-06-30 08:30:54.227517
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.235047	2025-06-30 08:30:54.235047
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.242312	2025-06-30 08:30:54.242312
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.254358	2025-06-30 08:30:54.254358
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.263433	2025-06-30 08:30:54.263433
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.27045	2025-06-30 08:30:54.27045
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.280359	2025-06-30 08:30:54.280359
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.290898	2025-06-30 08:30:54.290898
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.297325	2025-06-30 08:30:54.297325
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.305033	2025-06-30 08:30:54.305033
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.316574	2025-06-30 08:30:54.316574
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.329062	2025-06-30 08:30:54.329062
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.336013	2025-06-30 08:30:54.336013
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.345205	2025-06-30 08:30:54.345205
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.354142	2025-06-30 08:30:54.354142
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.361348	2025-06-30 08:30:54.361348
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.368918	2025-06-30 08:30:54.368918
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.383712	2025-06-30 08:30:54.383712
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.393496	2025-06-30 08:30:54.393496
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.400643	2025-06-30 08:30:54.400643
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.408752	2025-06-30 08:30:54.408752
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.415742	2025-06-30 08:30:54.415742
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.422836	2025-06-30 08:30:54.422836
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.443498	2025-06-30 08:30:54.443498
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.457963	2025-06-30 08:30:54.457963
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.467487	2025-06-30 08:30:54.467487
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.474649	2025-06-30 08:30:54.474649
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.513848	2025-06-30 08:30:54.513848
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.521557	2025-06-30 08:30:54.521557
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.550559	2025-06-30 08:30:54.550559
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.558203	2025-06-30 08:30:54.558203
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.565739	2025-06-30 08:30:54.565739
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.574757	2025-06-30 08:30:54.574757
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.581786	2025-06-30 08:30:54.581786
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.588748	2025-06-30 08:30:54.588748
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.597508	2025-06-30 08:30:54.597508
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.606102	2025-06-30 08:30:54.606102
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.628743	2025-06-30 08:30:54.628743
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.635226	2025-06-30 08:30:54.635226
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.644422	2025-06-30 08:30:54.644422
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.652487	2025-06-30 08:30:54.652487
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.659826	2025-06-30 08:30:54.659826
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.668606	2025-06-30 08:30:54.668606
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.676418	2025-06-30 08:30:54.676418
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.683554	2025-06-30 08:30:54.683554
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.690765	2025-06-30 08:30:54.690765
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.698486	2025-06-30 08:30:54.698486
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.708266	2025-06-30 08:30:54.708266
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.716918	2025-06-30 08:30:54.716918
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.730323	2025-06-30 08:30:54.730323
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.737665	2025-06-30 08:30:54.737665
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.747099	2025-06-30 08:30:54.747099
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.755133	2025-06-30 08:30:54.755133
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.76307	2025-06-30 08:30:54.76307
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.771781	2025-06-30 08:30:54.771781
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.801397	2025-06-30 08:30:54.801397
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.808562	2025-06-30 08:30:54.808562
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.817932	2025-06-30 08:30:54.817932
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.824351	2025-06-30 08:30:54.824351
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.831712	2025-06-30 08:30:54.831712
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.838388	2025-06-30 08:30:54.838388
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.847257	2025-06-30 08:30:54.847257
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.854485	2025-06-30 08:30:54.854485
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.863134	2025-06-30 08:30:54.863134
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.872639	2025-06-30 08:30:54.872639
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.880926	2025-06-30 08:30:54.880926
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.890108	2025-06-30 08:30:54.890108
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.897188	2025-06-30 08:30:54.897188
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.905158	2025-06-30 08:30:54.905158
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.913724	2025-06-30 08:30:54.913724
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.922881	2025-06-30 08:30:54.922881
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.931151	2025-06-30 08:30:54.931151
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.938337	2025-06-30 08:30:54.938337
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.950771	2025-06-30 08:30:54.950771
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.959065	2025-06-30 08:30:54.959065
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.968154	2025-06-30 08:30:54.968154
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.975923	2025-06-30 08:30:54.975923
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.984643	2025-06-30 08:30:54.984643
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:54.993716	2025-06-30 08:30:54.993716
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.001898	2025-06-30 08:30:55.001898
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.032441	2025-06-30 08:30:55.032441
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.04158	2025-06-30 08:30:55.04158
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.049572	2025-06-30 08:30:55.049572
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.056541	2025-06-30 08:30:55.056541
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.066142	2025-06-30 08:30:55.066142
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.075049	2025-06-30 08:30:55.075049
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.084437	2025-06-30 08:30:55.084437
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.092182	2025-06-30 08:30:55.092182
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.101266	2025-06-30 08:30:55.101266
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.111593	2025-06-30 08:30:55.111593
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.122219	2025-06-30 08:30:55.122219
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.12974	2025-06-30 08:30:55.12974
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.137122	2025-06-30 08:30:55.137122
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.144149	2025-06-30 08:30:55.144149
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.153905	2025-06-30 08:30:55.153905
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.161588	2025-06-30 08:30:55.161588
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.172346	2025-06-30 08:30:55.172346
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.180161	2025-06-30 08:30:55.180161
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.188185	2025-06-30 08:30:55.188185
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.196254	2025-06-30 08:30:55.196254
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.204076	2025-06-30 08:30:55.204076
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.21261	2025-06-30 08:30:55.21261
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.219897	2025-06-30 08:30:55.219897
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.259873	2025-06-30 08:30:55.259873
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.268041	2025-06-30 08:30:55.268041
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.276097	2025-06-30 08:30:55.276097
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.289917	2025-06-30 08:30:55.289917
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.297454	2025-06-30 08:30:55.297454
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.305558	2025-06-30 08:30:55.305558
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.313119	2025-06-30 08:30:55.313119
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.320609	2025-06-30 08:30:55.320609
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.329678	2025-06-30 08:30:55.329678
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.33819	2025-06-30 08:30:55.33819
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.345465	2025-06-30 08:30:55.345465
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.353787	2025-06-30 08:30:55.353787
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.365782	2025-06-30 08:30:55.365782
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.373259	2025-06-30 08:30:55.373259
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.381991	2025-06-30 08:30:55.381991
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.389303	2025-06-30 08:30:55.389303
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.398002	2025-06-30 08:30:55.398002
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.406952	2025-06-30 08:30:55.406952
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.414252	2025-06-30 08:30:55.414252
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.428773	2025-06-30 08:30:55.428773
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.436368	2025-06-30 08:30:55.436368
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.443214	2025-06-30 08:30:55.443214
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.452956	2025-06-30 08:30:55.452956
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.460552	2025-06-30 08:30:55.460552
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.469758	2025-06-30 08:30:55.469758
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.479612	2025-06-30 08:30:55.479612
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.487051	2025-06-30 08:30:55.487051
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.49671	2025-06-30 08:30:55.49671
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.514812	2025-06-30 08:30:55.514812
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.521766	2025-06-30 08:30:55.521766
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.560234	2025-06-30 08:30:55.560234
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.5682	2025-06-30 08:30:55.5682
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.608498	2025-06-30 08:30:55.608498
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.61618	2025-06-30 08:30:55.61618
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.624001	2025-06-30 08:30:55.624001
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.663264	2025-06-30 08:30:55.663264
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.671251	2025-06-30 08:30:55.671251
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.678423	2025-06-30 08:30:55.678423
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.687271	2025-06-30 08:30:55.687271
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.713891	2025-06-30 08:30:55.713891
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.753236	2025-06-30 08:30:55.753236
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.761157	2025-06-30 08:30:55.761157
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.770118	2025-06-30 08:30:55.770118
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.780792	2025-06-30 08:30:55.780792
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.819654	2025-06-30 08:30:55.819654
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.828298	2025-06-30 08:30:55.828298
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.835961	2025-06-30 08:30:55.835961
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.874977	2025-06-30 08:30:55.874977
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.883034	2025-06-30 08:30:55.883034
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.895419	2025-06-30 08:30:55.895419
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.941047	2025-06-30 08:30:55.941047
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.95397	2025-06-30 08:30:55.95397
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.966854	2025-06-30 08:30:55.966854
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:55.990451	2025-06-30 08:30:55.990451
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.004828	2025-06-30 08:30:56.004828
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.018015	2025-06-30 08:30:56.018015
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.03274	2025-06-30 08:30:56.03274
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.045735	2025-06-30 08:30:56.045735
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.059388	2025-06-30 08:30:56.059388
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.073902	2025-06-30 08:30:56.073902
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.086559	2025-06-30 08:30:56.086559
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.100121	2025-06-30 08:30:56.100121
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.114897	2025-06-30 08:30:56.114897
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.127483	2025-06-30 08:30:56.127483
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.154651	2025-06-30 08:30:56.154651
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.164426	2025-06-30 08:30:56.164426
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.173471	2025-06-30 08:30:56.173471
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.183871	2025-06-30 08:30:56.183871
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.203078	2025-06-30 08:30:56.203078
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.217377	2025-06-30 08:30:56.217377
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.230493	2025-06-30 08:30:56.230493
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.244844	2025-06-30 08:30:56.244844
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.25957	2025-06-30 08:30:56.25957
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.274024	2025-06-30 08:30:56.274024
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.292896	2025-06-30 08:30:56.292896
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.309506	2025-06-30 08:30:56.309506
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.322493	2025-06-30 08:30:56.322493
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.335592	2025-06-30 08:30:56.335592
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.348769	2025-06-30 08:30:56.348769
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.356995	2025-06-30 08:30:56.356995
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.369463	2025-06-30 08:30:56.369463
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.377469	2025-06-30 08:30:56.377469
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.386874	2025-06-30 08:30:56.386874
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.400701	2025-06-30 08:30:56.400701
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.409126	2025-06-30 08:30:56.409126
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.416741	2025-06-30 08:30:56.416741
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.424555	2025-06-30 08:30:56.424555
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.449028	2025-06-30 08:30:56.449028
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.456472	2025-06-30 08:30:56.456472
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.476065	2025-06-30 08:30:56.476065
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.48299	2025-06-30 08:30:56.48299
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.53196	2025-06-30 08:30:56.53196
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.544459	2025-06-30 08:30:56.544459
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.552125	2025-06-30 08:30:56.552125
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.559735	2025-06-30 08:30:56.559735
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.567014	2025-06-30 08:30:56.567014
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.586421	2025-06-30 08:30:56.586421
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.59386	2025-06-30 08:30:56.59386
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.601427	2025-06-30 08:30:56.601427
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.608291	2025-06-30 08:30:56.608291
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.615791	2025-06-30 08:30:56.615791
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.623739	2025-06-30 08:30:56.623739
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.634105	2025-06-30 08:30:56.634105
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.642171	2025-06-30 08:30:56.642171
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.6494	2025-06-30 08:30:56.6494
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.656731	2025-06-30 08:30:56.656731
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.668698	2025-06-30 08:30:56.668698
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.690598	2025-06-30 08:30:56.690598
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.699591	2025-06-30 08:30:56.699591
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.707442	2025-06-30 08:30:56.707442
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.714902	2025-06-30 08:30:56.714902
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.722701	2025-06-30 08:30:56.722701
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.73036	2025-06-30 08:30:56.73036
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.737855	2025-06-30 08:30:56.737855
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.745278	2025-06-30 08:30:56.745278
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.753759	2025-06-30 08:30:56.753759
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.763511	2025-06-30 08:30:56.763511
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.771637	2025-06-30 08:30:56.771637
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.779685	2025-06-30 08:30:56.779685
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.789163	2025-06-30 08:30:56.789163
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.798562	2025-06-30 08:30:56.798562
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.80751	2025-06-30 08:30:56.80751
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.816437	2025-06-30 08:30:56.816437
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.845012	2025-06-30 08:30:56.845012
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.854994	2025-06-30 08:30:56.854994
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.863818	2025-06-30 08:30:56.863818
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.872527	2025-06-30 08:30:56.872527
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.883034	2025-06-30 08:30:56.883034
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.892229	2025-06-30 08:30:56.892229
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.89948	2025-06-30 08:30:56.89948
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.907653	2025-06-30 08:30:56.907653
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.916144	2025-06-30 08:30:56.916144
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.923347	2025-06-30 08:30:56.923347
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.937312	2025-06-30 08:30:56.937312
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.947582	2025-06-30 08:30:56.947582
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.955347	2025-06-30 08:30:56.955347
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.962781	2025-06-30 08:30:56.962781
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.970419	2025-06-30 08:30:56.970419
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.97836	2025-06-30 08:30:56.97836
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:56.994301	2025-06-30 08:30:56.994301
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.003232	2025-06-30 08:30:57.003232
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.012823	2025-06-30 08:30:57.012823
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.020652	2025-06-30 08:30:57.020652
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.02835	2025-06-30 08:30:57.02835
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.054564	2025-06-30 08:30:57.054564
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.061938	2025-06-30 08:30:57.061938
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.072959	2025-06-30 08:30:57.072959
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.080162	2025-06-30 08:30:57.080162
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.088859	2025-06-30 08:30:57.088859
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.098522	2025-06-30 08:30:57.098522
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.105742	2025-06-30 08:30:57.105742
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.115175	2025-06-30 08:30:57.115175
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.123611	2025-06-30 08:30:57.123611
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.131215	2025-06-30 08:30:57.131215
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.138812	2025-06-30 08:30:57.138812
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.1463	2025-06-30 08:30:57.1463
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.159968	2025-06-30 08:30:57.159968
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.167517	2025-06-30 08:30:57.167517
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.177017	2025-06-30 08:30:57.177017
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.185082	2025-06-30 08:30:57.185082
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.192753	2025-06-30 08:30:57.192753
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.200449	2025-06-30 08:30:57.200449
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.209573	2025-06-30 08:30:57.209573
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.216771	2025-06-30 08:30:57.216771
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.225954	2025-06-30 08:30:57.225954
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.234671	2025-06-30 08:30:57.234671
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.242396	2025-06-30 08:30:57.242396
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.250279	2025-06-30 08:30:57.250279
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.257974	2025-06-30 08:30:57.257974
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.266098	2025-06-30 08:30:57.266098
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.273275	2025-06-30 08:30:57.273275
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.281058	2025-06-30 08:30:57.281058
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.288239	2025-06-30 08:30:57.288239
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.302168	2025-06-30 08:30:57.302168
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.309261	2025-06-30 08:30:57.309261
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.316539	2025-06-30 08:30:57.316539
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.324096	2025-06-30 08:30:57.324096
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.330898	2025-06-30 08:30:57.330898
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.33838	2025-06-30 08:30:57.33838
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.345616	2025-06-30 08:30:57.345616
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.354666	2025-06-30 08:30:57.354666
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.363533	2025-06-30 08:30:57.363533
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.371273	2025-06-30 08:30:57.371273
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.380419	2025-06-30 08:30:57.380419
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.389421	2025-06-30 08:30:57.389421
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.397555	2025-06-30 08:30:57.397555
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.404326	2025-06-30 08:30:57.404326
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.412148	2025-06-30 08:30:57.412148
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.418889	2025-06-30 08:30:57.418889
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.431513	2025-06-30 08:30:57.431513
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.43873	2025-06-30 08:30:57.43873
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.448663	2025-06-30 08:30:57.448663
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.456256	2025-06-30 08:30:57.456256
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.463912	2025-06-30 08:30:57.463912
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.476275	2025-06-30 08:30:57.476275
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.483454	2025-06-30 08:30:57.483454
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.491158	2025-06-30 08:30:57.491158
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.511627	2025-06-30 08:30:57.511627
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.518923	2025-06-30 08:30:57.518923
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.526879	2025-06-30 08:30:57.526879
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.534302	2025-06-30 08:30:57.534302
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.552469	2025-06-30 08:30:57.552469
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.55938	2025-06-30 08:30:57.55938
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.566517	2025-06-30 08:30:57.566517
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.605257	2025-06-30 08:30:57.605257
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.613679	2025-06-30 08:30:57.613679
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.620783	2025-06-30 08:30:57.620783
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.659107	2025-06-30 08:30:57.659107
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.666574	2025-06-30 08:30:57.666574
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.673801	2025-06-30 08:30:57.673801
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.682162	2025-06-30 08:30:57.682162
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.69011	2025-06-30 08:30:57.69011
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.700323	2025-06-30 08:30:57.700323
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.713573	2025-06-30 08:30:57.713573
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.720183	2025-06-30 08:30:57.720183
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.72784	2025-06-30 08:30:57.72784
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.735482	2025-06-30 08:30:57.735482
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.745222	2025-06-30 08:30:57.745222
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.754928	2025-06-30 08:30:57.754928
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.763045	2025-06-30 08:30:57.763045
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.771831	2025-06-30 08:30:57.771831
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.779134	2025-06-30 08:30:57.779134
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.786888	2025-06-30 08:30:57.786888
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.794461	2025-06-30 08:30:57.794461
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.804037	2025-06-30 08:30:57.804037
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.811743	2025-06-30 08:30:57.811743
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.819183	2025-06-30 08:30:57.819183
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.828284	2025-06-30 08:30:57.828284
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.836831	2025-06-30 08:30:57.836831
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.844993	2025-06-30 08:30:57.844993
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.873009	2025-06-30 08:30:57.873009
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.880593	2025-06-30 08:30:57.880593
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.9082	2025-06-30 08:30:57.9082
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.915279	2025-06-30 08:30:57.915279
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.922564	2025-06-30 08:30:57.922564
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.929846	2025-06-30 08:30:57.929846
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.937643	2025-06-30 08:30:57.937643
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.957792	2025-06-30 08:30:57.957792
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.967009	2025-06-30 08:30:57.967009
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.974471	2025-06-30 08:30:57.974471
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.982537	2025-06-30 08:30:57.982537
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.990664	2025-06-30 08:30:57.990664
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:57.998485	2025-06-30 08:30:57.998485
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.006017	2025-06-30 08:30:58.006017
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.014005	2025-06-30 08:30:58.014005
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.021567	2025-06-30 08:30:58.021567
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.029062	2025-06-30 08:30:58.029062
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.03785	2025-06-30 08:30:58.03785
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.045565	2025-06-30 08:30:58.045565
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.084607	2025-06-30 08:30:58.084607
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.091729	2025-06-30 08:30:58.091729
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.099808	2025-06-30 08:30:58.099808
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.115645	2025-06-30 08:30:58.115645
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.123108	2025-06-30 08:30:58.123108
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.130785	2025-06-30 08:30:58.130785
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.145133	2025-06-30 08:30:58.145133
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.159122	2025-06-30 08:30:58.159122
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.173823	2025-06-30 08:30:58.173823
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.187169	2025-06-30 08:30:58.187169
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.20208	2025-06-30 08:30:58.20208
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.221156	2025-06-30 08:30:58.221156
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.229167	2025-06-30 08:30:58.229167
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.240668	2025-06-30 08:30:58.240668
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.250233	2025-06-30 08:30:58.250233
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.258804	2025-06-30 08:30:58.258804
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.267047	2025-06-30 08:30:58.267047
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-30 08:30:58.289999	2025-06-30 08:30:58.289999
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.298715	2025-06-30 08:30:58.298715
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.30749	2025-06-30 08:30:58.30749
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.316817	2025-06-30 08:30:58.316817
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.329282	2025-06-30 08:30:58.329282
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.33914	2025-06-30 08:30:58.33914
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.370512	2025-06-30 08:30:58.370512
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.383259	2025-06-30 08:30:58.383259
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.39908	2025-06-30 08:30:58.39908
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.413993	2025-06-30 08:30:58.413993
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.451129	2025-06-30 08:30:58.451129
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.463573	2025-06-30 08:30:58.463573
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.483098	2025-06-30 08:30:58.483098
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.502143	2025-06-30 08:30:58.502143
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.525164	2025-06-30 08:30:58.525164
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.545553	2025-06-30 08:30:58.545553
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.563185	2025-06-30 08:30:58.563185
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.581616	2025-06-30 08:30:58.581616
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.596924	2025-06-30 08:30:58.596924
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.614643	2025-06-30 08:30:58.614643
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.638197	2025-06-30 08:30:58.638197
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.649023	2025-06-30 08:30:58.649023
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.665449	2025-06-30 08:30:58.665449
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.673089	2025-06-30 08:30:58.673089
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.682175	2025-06-30 08:30:58.682175
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.68943	2025-06-30 08:30:58.68943
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.698382	2025-06-30 08:30:58.698382
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.704971	2025-06-30 08:30:58.704971
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.714493	2025-06-30 08:30:58.714493
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.722488	2025-06-30 08:30:58.722488
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.731238	2025-06-30 08:30:58.731238
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.73916	2025-06-30 08:30:58.73916
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.747039	2025-06-30 08:30:58.747039
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.765974	2025-06-30 08:30:58.765974
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.773905	2025-06-30 08:30:58.773905
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.782037	2025-06-30 08:30:58.782037
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.789815	2025-06-30 08:30:58.789815
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.797706	2025-06-30 08:30:58.797706
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.828083	2025-06-30 08:30:58.828083
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.835688	2025-06-30 08:30:58.835688
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.843573	2025-06-30 08:30:58.843573
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.860947	2025-06-30 08:30:58.860947
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.868287	2025-06-30 08:30:58.868287
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.875543	2025-06-30 08:30:58.875543
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.883581	2025-06-30 08:30:58.883581
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.891064	2025-06-30 08:30:58.891064
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.898148	2025-06-30 08:30:58.898148
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.905617	2025-06-30 08:30:58.905617
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.928537	2025-06-30 08:30:58.928537
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.936583	2025-06-30 08:30:58.936583
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.943446	2025-06-30 08:30:58.943446
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.95259	2025-06-30 08:30:58.95259
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.960214	2025-06-30 08:30:58.960214
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.967544	2025-06-30 08:30:58.967544
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.974535	2025-06-30 08:30:58.974535
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.981802	2025-06-30 08:30:58.981802
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.990542	2025-06-30 08:30:58.990542
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:58.999331	2025-06-30 08:30:58.999331
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.006452	2025-06-30 08:30:59.006452
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.013706	2025-06-30 08:30:59.013706
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.021782	2025-06-30 08:30:59.021782
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.031728	2025-06-30 08:30:59.031728
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.039357	2025-06-30 08:30:59.039357
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.047786	2025-06-30 08:30:59.047786
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.056209	2025-06-30 08:30:59.056209
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.064972	2025-06-30 08:30:59.064972
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.072129	2025-06-30 08:30:59.072129
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.078855	2025-06-30 08:30:59.078855
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.08636	2025-06-30 08:30:59.08636
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.095266	2025-06-30 08:30:59.095266
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.103034	2025-06-30 08:30:59.103034
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.11081	2025-06-30 08:30:59.11081
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.118484	2025-06-30 08:30:59.118484
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.125951	2025-06-30 08:30:59.125951
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.134388	2025-06-30 08:30:59.134388
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.14187	2025-06-30 08:30:59.14187
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.177381	2025-06-30 08:30:59.177381
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.184706	2025-06-30 08:30:59.184706
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.191522	2025-06-30 08:30:59.191522
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.199525	2025-06-30 08:30:59.199525
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.208513	2025-06-30 08:30:59.208513
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.217384	2025-06-30 08:30:59.217384
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.224658	2025-06-30 08:30:59.224658
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.23277	2025-06-30 08:30:59.23277
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.24006	2025-06-30 08:30:59.24006
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.248721	2025-06-30 08:30:59.248721
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.255262	2025-06-30 08:30:59.255262
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.267258	2025-06-30 08:30:59.267258
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.274353	2025-06-30 08:30:59.274353
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.283328	2025-06-30 08:30:59.283328
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.290883	2025-06-30 08:30:59.290883
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.298903	2025-06-30 08:30:59.298903
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.309397	2025-06-30 08:30:59.309397
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.319505	2025-06-30 08:30:59.319505
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.326726	2025-06-30 08:30:59.326726
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.334335	2025-06-30 08:30:59.334335
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.341705	2025-06-30 08:30:59.341705
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.349706	2025-06-30 08:30:59.349706
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.360373	2025-06-30 08:30:59.360373
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.368282	2025-06-30 08:30:59.368282
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.375878	2025-06-30 08:30:59.375878
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.384759	2025-06-30 08:30:59.384759
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.393468	2025-06-30 08:30:59.393468
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.402227	2025-06-30 08:30:59.402227
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.409667	2025-06-30 08:30:59.409667
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.417839	2025-06-30 08:30:59.417839
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.425382	2025-06-30 08:30:59.425382
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.433479	2025-06-30 08:30:59.433479
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.440257	2025-06-30 08:30:59.440257
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.448895	2025-06-30 08:30:59.448895
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.45664	2025-06-30 08:30:59.45664
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.463704	2025-06-30 08:30:59.463704
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.472679	2025-06-30 08:30:59.472679
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.481691	2025-06-30 08:30:59.481691
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.498391	2025-06-30 08:30:59.498391
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.505572	2025-06-30 08:30:59.505572
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.51497	2025-06-30 08:30:59.51497
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.522242	2025-06-30 08:30:59.522242
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.531367	2025-06-30 08:30:59.531367
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.539873	2025-06-30 08:30:59.539873
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.547172	2025-06-30 08:30:59.547172
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.555329	2025-06-30 08:30:59.555329
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.563306	2025-06-30 08:30:59.563306
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.571052	2025-06-30 08:30:59.571052
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.580287	2025-06-30 08:30:59.580287
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.588347	2025-06-30 08:30:59.588347
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.596092	2025-06-30 08:30:59.596092
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.60351	2025-06-30 08:30:59.60351
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.612514	2025-06-30 08:30:59.612514
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.61988	2025-06-30 08:30:59.61988
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.627491	2025-06-30 08:30:59.627491
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.638874	2025-06-30 08:30:59.638874
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.64728	2025-06-30 08:30:59.64728
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.655866	2025-06-30 08:30:59.655866
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.662662	2025-06-30 08:30:59.662662
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.671667	2025-06-30 08:30:59.671667
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.679768	2025-06-30 08:30:59.679768
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.688007	2025-06-30 08:30:59.688007
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.706259	2025-06-30 08:30:59.706259
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.713236	2025-06-30 08:30:59.713236
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.720815	2025-06-30 08:30:59.720815
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.72923	2025-06-30 08:30:59.72923
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.736085	2025-06-30 08:30:59.736085
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.774232	2025-06-30 08:30:59.774232
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.811063	2025-06-30 08:30:59.811063
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.818258	2025-06-30 08:30:59.818258
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.826004	2025-06-30 08:30:59.826004
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.832781	2025-06-30 08:30:59.832781
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.839871	2025-06-30 08:30:59.839871
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.847406	2025-06-30 08:30:59.847406
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.856514	2025-06-30 08:30:59.856514
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.872792	2025-06-30 08:30:59.872792
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.880245	2025-06-30 08:30:59.880245
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.886696	2025-06-30 08:30:59.886696
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.896783	2025-06-30 08:30:59.896783
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.909779	2025-06-30 08:30:59.909779
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.926962	2025-06-30 08:30:59.926962
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.940246	2025-06-30 08:30:59.940246
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.963496	2025-06-30 08:30:59.963496
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.976995	2025-06-30 08:30:59.976995
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:30:59.992164	2025-06-30 08:30:59.992164
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.004928	2025-06-30 08:31:00.004928
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.019441	2025-06-30 08:31:00.019441
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.032075	2025-06-30 08:31:00.032075
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.046905	2025-06-30 08:31:00.046905
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.059102	2025-06-30 08:31:00.059102
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.07242	2025-06-30 08:31:00.07242
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.086152	2025-06-30 08:31:00.086152
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.099162	2025-06-30 08:31:00.099162
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.114413	2025-06-30 08:31:00.114413
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.132078	2025-06-30 08:31:00.132078
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.154727	2025-06-30 08:31:00.154727
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.16697	2025-06-30 08:31:00.16697
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.181945	2025-06-30 08:31:00.181945
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.196957	2025-06-30 08:31:00.196957
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.210349	2025-06-30 08:31:00.210349
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.222397	2025-06-30 08:31:00.222397
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.236814	2025-06-30 08:31:00.236814
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.250688	2025-06-30 08:31:00.250688
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.264674	2025-06-30 08:31:00.264674
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.277896	2025-06-30 08:31:00.277896
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.291771	2025-06-30 08:31:00.291771
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.305117	2025-06-30 08:31:00.305117
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.320157	2025-06-30 08:31:00.320157
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.332429	2025-06-30 08:31:00.332429
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.351757	2025-06-30 08:31:00.351757
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.360629	2025-06-30 08:31:00.360629
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.373902	2025-06-30 08:31:00.373902
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.389289	2025-06-30 08:31:00.389289
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.397568	2025-06-30 08:31:00.397568
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.404669	2025-06-30 08:31:00.404669
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.412112	2025-06-30 08:31:00.412112
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.419868	2025-06-30 08:31:00.419868
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.428798	2025-06-30 08:31:00.428798
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.436372	2025-06-30 08:31:00.436372
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.446297	2025-06-30 08:31:00.446297
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.457138	2025-06-30 08:31:00.457138
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.4662	2025-06-30 08:31:00.4662
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.473805	2025-06-30 08:31:00.473805
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.480861	2025-06-30 08:31:00.480861
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.488703	2025-06-30 08:31:00.488703
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.4959	2025-06-30 08:31:00.4959
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.508888	2025-06-30 08:31:00.508888
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.517466	2025-06-30 08:31:00.517466
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.525217	2025-06-30 08:31:00.525217
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.562001	2025-06-30 08:31:00.562001
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.573056	2025-06-30 08:31:00.573056
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.582109	2025-06-30 08:31:00.582109
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.594173	2025-06-30 08:31:00.594173
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.602669	2025-06-30 08:31:00.602669
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.610588	2025-06-30 08:31:00.610588
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.621917	2025-06-30 08:31:00.621917
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.629114	2025-06-30 08:31:00.629114
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.637586	2025-06-30 08:31:00.637586
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.646969	2025-06-30 08:31:00.646969
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.653783	2025-06-30 08:31:00.653783
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.661114	2025-06-30 08:31:00.661114
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.668611	2025-06-30 08:31:00.668611
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.676176	2025-06-30 08:31:00.676176
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.684209	2025-06-30 08:31:00.684209
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.694922	2025-06-30 08:31:00.694922
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.704679	2025-06-30 08:31:00.704679
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.711585	2025-06-30 08:31:00.711585
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.719358	2025-06-30 08:31:00.719358
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.726599	2025-06-30 08:31:00.726599
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.735385	2025-06-30 08:31:00.735385
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.742297	2025-06-30 08:31:00.742297
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.749986	2025-06-30 08:31:00.749986
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.757338	2025-06-30 08:31:00.757338
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.795734	2025-06-30 08:31:00.795734
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.804217	2025-06-30 08:31:00.804217
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.811347	2025-06-30 08:31:00.811347
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.82184	2025-06-30 08:31:00.82184
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.829986	2025-06-30 08:31:00.829986
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.8481	2025-06-30 08:31:00.8481
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.856798	2025-06-30 08:31:00.856798
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.864829	2025-06-30 08:31:00.864829
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.872486	2025-06-30 08:31:00.872486
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.881915	2025-06-30 08:31:00.881915
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.89247	2025-06-30 08:31:00.89247
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.899707	2025-06-30 08:31:00.899707
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.907192	2025-06-30 08:31:00.907192
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.915431	2025-06-30 08:31:00.915431
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.923197	2025-06-30 08:31:00.923197
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.931482	2025-06-30 08:31:00.931482
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.946058	2025-06-30 08:31:00.946058
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.954844	2025-06-30 08:31:00.954844
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.984468	2025-06-30 08:31:00.984468
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:00.992126	2025-06-30 08:31:00.992126
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.024094	2025-06-30 08:31:01.024094
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.031739	2025-06-30 08:31:01.031739
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.048217	2025-06-30 08:31:01.048217
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.055704	2025-06-30 08:31:01.055704
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.094748	2025-06-30 08:31:01.094748
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.102011	2025-06-30 08:31:01.102011
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.111745	2025-06-30 08:31:01.111745
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.119058	2025-06-30 08:31:01.119058
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.129452	2025-06-30 08:31:01.129452
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.137687	2025-06-30 08:31:01.137687
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.150708	2025-06-30 08:31:01.150708
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.161383	2025-06-30 08:31:01.161383
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.171981	2025-06-30 08:31:01.171981
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.182903	2025-06-30 08:31:01.182903
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.196441	2025-06-30 08:31:01.196441
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.209405	2025-06-30 08:31:01.209405
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.222541	2025-06-30 08:31:01.222541
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.267312	2025-06-30 08:31:01.267312
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.27995	2025-06-30 08:31:01.27995
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.29331	2025-06-30 08:31:01.29331
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.305158	2025-06-30 08:31:01.305158
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.318521	2025-06-30 08:31:01.318521
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.331896	2025-06-30 08:31:01.331896
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.343535	2025-06-30 08:31:01.343535
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.357007	2025-06-30 08:31:01.357007
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.36977	2025-06-30 08:31:01.36977
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.38336	2025-06-30 08:31:01.38336
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.396417	2025-06-30 08:31:01.396417
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.434837	2025-06-30 08:31:01.434837
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.448024	2025-06-30 08:31:01.448024
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.461181	2025-06-30 08:31:01.461181
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.495215	2025-06-30 08:31:01.495215
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.512357	2025-06-30 08:31:01.512357
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.525945	2025-06-30 08:31:01.525945
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.545815	2025-06-30 08:31:01.545815
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.560032	2025-06-30 08:31:01.560032
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.573923	2025-06-30 08:31:01.573923
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.603392	2025-06-30 08:31:01.603392
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.61913	2025-06-30 08:31:01.61913
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.632879	2025-06-30 08:31:01.632879
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.646804	2025-06-30 08:31:01.646804
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.661801	2025-06-30 08:31:01.661801
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.67493	2025-06-30 08:31:01.67493
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.707673	2025-06-30 08:31:01.707673
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.722797	2025-06-30 08:31:01.722797
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.744012	2025-06-30 08:31:01.744012
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.758132	2025-06-30 08:31:01.758132
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.772004	2025-06-30 08:31:01.772004
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.790489	2025-06-30 08:31:01.790489
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.803076	2025-06-30 08:31:01.803076
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.816042	2025-06-30 08:31:01.816042
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.830071	2025-06-30 08:31:01.830071
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.844536	2025-06-30 08:31:01.844536
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.859318	2025-06-30 08:31:01.859318
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.872525	2025-06-30 08:31:01.872525
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.886897	2025-06-30 08:31:01.886897
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.896297	2025-06-30 08:31:01.896297
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.903322	2025-06-30 08:31:01.903322
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.93006	2025-06-30 08:31:01.93006
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.940416	2025-06-30 08:31:01.940416
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.948917	2025-06-30 08:31:01.948917
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.955974	2025-06-30 08:31:01.955974
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.965092	2025-06-30 08:31:01.965092
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.972987	2025-06-30 08:31:01.972987
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.980513	2025-06-30 08:31:01.980513
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.989613	2025-06-30 08:31:01.989613
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:01.998601	2025-06-30 08:31:01.998601
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.009132	2025-06-30 08:31:02.009132
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.018887	2025-06-30 08:31:02.018887
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.036718	2025-06-30 08:31:02.036718
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.04561	2025-06-30 08:31:02.04561
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.052893	2025-06-30 08:31:02.052893
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.063584	2025-06-30 08:31:02.063584
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.072272	2025-06-30 08:31:02.072272
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.081223	2025-06-30 08:31:02.081223
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.089424	2025-06-30 08:31:02.089424
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.09873	2025-06-30 08:31:02.09873
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.106435	2025-06-30 08:31:02.106435
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.113917	2025-06-30 08:31:02.113917
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.122047	2025-06-30 08:31:02.122047
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.129595	2025-06-30 08:31:02.129595
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.156944	2025-06-30 08:31:02.156944
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.165269	2025-06-30 08:31:02.165269
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.173693	2025-06-30 08:31:02.173693
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.182265	2025-06-30 08:31:02.182265
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.190852	2025-06-30 08:31:02.190852
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.19999	2025-06-30 08:31:02.19999
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.213277	2025-06-30 08:31:02.213277
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.221258	2025-06-30 08:31:02.221258
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.229201	2025-06-30 08:31:02.229201
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.242126	2025-06-30 08:31:02.242126
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.261315	2025-06-30 08:31:02.261315
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.268934	2025-06-30 08:31:02.268934
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.277308	2025-06-30 08:31:02.277308
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.306498	2025-06-30 08:31:02.306498
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.315284	2025-06-30 08:31:02.315284
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.333718	2025-06-30 08:31:02.333718
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.342261	2025-06-30 08:31:02.342261
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.375165	2025-06-30 08:31:02.375165
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.386099	2025-06-30 08:31:02.386099
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.411137	2025-06-30 08:31:02.411137
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.440145	2025-06-30 08:31:02.440145
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.46574	2025-06-30 08:31:02.46574
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.493715	2025-06-30 08:31:02.493715
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.50836	2025-06-30 08:31:02.50836
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.529317	2025-06-30 08:31:02.529317
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.551195	2025-06-30 08:31:02.551195
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.587904	2025-06-30 08:31:02.587904
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.612931	2025-06-30 08:31:02.612931
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.636288	2025-06-30 08:31:02.636288
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.646558	2025-06-30 08:31:02.646558
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.659294	2025-06-30 08:31:02.659294
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.668157	2025-06-30 08:31:02.668157
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.678458	2025-06-30 08:31:02.678458
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.688372	2025-06-30 08:31:02.688372
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.700519	2025-06-30 08:31:02.700519
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.713839	2025-06-30 08:31:02.713839
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.724024	2025-06-30 08:31:02.724024
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.735826	2025-06-30 08:31:02.735826
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.746234	2025-06-30 08:31:02.746234
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.756052	2025-06-30 08:31:02.756052
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.764918	2025-06-30 08:31:02.764918
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.775021	2025-06-30 08:31:02.775021
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.783826	2025-06-30 08:31:02.783826
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.793074	2025-06-30 08:31:02.793074
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.803526	2025-06-30 08:31:02.803526
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.812616	2025-06-30 08:31:02.812616
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.822036	2025-06-30 08:31:02.822036
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.831209	2025-06-30 08:31:02.831209
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.840988	2025-06-30 08:31:02.840988
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.851518	2025-06-30 08:31:02.851518
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.862295	2025-06-30 08:31:02.862295
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.872529	2025-06-30 08:31:02.872529
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.885382	2025-06-30 08:31:02.885382
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.896416	2025-06-30 08:31:02.896416
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.907868	2025-06-30 08:31:02.907868
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.919083	2025-06-30 08:31:02.919083
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.929643	2025-06-30 08:31:02.929643
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.938137	2025-06-30 08:31:02.938137
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.947596	2025-06-30 08:31:02.947596
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.955791	2025-06-30 08:31:02.955791
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.963075	2025-06-30 08:31:02.963075
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.974216	2025-06-30 08:31:02.974216
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.984634	2025-06-30 08:31:02.984634
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:02.994972	2025-06-30 08:31:02.994972
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.034484	2025-06-30 08:31:03.034484
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.045021	2025-06-30 08:31:03.045021
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.055107	2025-06-30 08:31:03.055107
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.064899	2025-06-30 08:31:03.064899
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.076823	2025-06-30 08:31:03.076823
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.086356	2025-06-30 08:31:03.086356
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-06-30 08:31:03.094732	2025-06-30 08:31:03.094732
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.106152	2025-06-30 08:31:03.106152
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.117296	2025-06-30 08:31:03.117296
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.127354	2025-06-30 08:31:03.127354
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.148479	2025-06-30 08:31:03.148479
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.159504	2025-06-30 08:31:03.159504
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.172212	2025-06-30 08:31:03.172212
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.183055	2025-06-30 08:31:03.183055
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.193099	2025-06-30 08:31:03.193099
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.204128	2025-06-30 08:31:03.204128
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.211488	2025-06-30 08:31:03.211488
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.219177	2025-06-30 08:31:03.219177
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.226895	2025-06-30 08:31:03.226895
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.234991	2025-06-30 08:31:03.234991
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.244299	2025-06-30 08:31:03.244299
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.25377	2025-06-30 08:31:03.25377
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.26364	2025-06-30 08:31:03.26364
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.272716	2025-06-30 08:31:03.272716
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.281132	2025-06-30 08:31:03.281132
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.289916	2025-06-30 08:31:03.289916
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.299469	2025-06-30 08:31:03.299469
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.30679	2025-06-30 08:31:03.30679
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.318579	2025-06-30 08:31:03.318579
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.326863	2025-06-30 08:31:03.326863
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.335273	2025-06-30 08:31:03.335273
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.343967	2025-06-30 08:31:03.343967
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.352844	2025-06-30 08:31:03.352844
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.362281	2025-06-30 08:31:03.362281
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.372177	2025-06-30 08:31:03.372177
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.380062	2025-06-30 08:31:03.380062
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.389811	2025-06-30 08:31:03.389811
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.396849	2025-06-30 08:31:03.396849
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.404743	2025-06-30 08:31:03.404743
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.44138	2025-06-30 08:31:03.44138
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.455122	2025-06-30 08:31:03.455122
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.465109	2025-06-30 08:31:03.465109
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.474679	2025-06-30 08:31:03.474679
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.481957	2025-06-30 08:31:03.481957
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.491221	2025-06-30 08:31:03.491221
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.530176	2025-06-30 08:31:03.530176
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.538322	2025-06-30 08:31:03.538322
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.54537	2025-06-30 08:31:03.54537
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.556521	2025-06-30 08:31:03.556521
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.56457	2025-06-30 08:31:03.56457
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.575376	2025-06-30 08:31:03.575376
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.587785	2025-06-30 08:31:03.587785
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.595736	2025-06-30 08:31:03.595736
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.605052	2025-06-30 08:31:03.605052
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.61326	2025-06-30 08:31:03.61326
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.620438	2025-06-30 08:31:03.620438
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.628559	2025-06-30 08:31:03.628559
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.642471	2025-06-30 08:31:03.642471
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.657026	2025-06-30 08:31:03.657026
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.669481	2025-06-30 08:31:03.669481
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.685521	2025-06-30 08:31:03.685521
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.699556	2025-06-30 08:31:03.699556
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.726753	2025-06-30 08:31:03.726753
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.739147	2025-06-30 08:31:03.739147
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.753708	2025-06-30 08:31:03.753708
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.767192	2025-06-30 08:31:03.767192
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.812172	2025-06-30 08:31:03.812172
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.826366	2025-06-30 08:31:03.826366
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.867668	2025-06-30 08:31:03.867668
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.883789	2025-06-30 08:31:03.883789
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.89824	2025-06-30 08:31:03.89824
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.917702	2025-06-30 08:31:03.917702
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.940184	2025-06-30 08:31:03.940184
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.953299	2025-06-30 08:31:03.953299
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.9667	2025-06-30 08:31:03.9667
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.982175	2025-06-30 08:31:03.982175
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:03.996404	2025-06-30 08:31:03.996404
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.015196	2025-06-30 08:31:04.015196
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.029436	2025-06-30 08:31:04.029436
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.047645	2025-06-30 08:31:04.047645
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.067389	2025-06-30 08:31:04.067389
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.082999	2025-06-30 08:31:04.082999
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.097253	2025-06-30 08:31:04.097253
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.11112	2025-06-30 08:31:04.11112
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.12635	2025-06-30 08:31:04.12635
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.13881	2025-06-30 08:31:04.13881
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.154511	2025-06-30 08:31:04.154511
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.16816	2025-06-30 08:31:04.16816
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.183074	2025-06-30 08:31:04.183074
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.19698	2025-06-30 08:31:04.19698
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.209207	2025-06-30 08:31:04.209207
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.222777	2025-06-30 08:31:04.222777
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.235785	2025-06-30 08:31:04.235785
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.250459	2025-06-30 08:31:04.250459
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.264113	2025-06-30 08:31:04.264113
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.278584	2025-06-30 08:31:04.278584
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.29744	2025-06-30 08:31:04.29744
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.313423	2025-06-30 08:31:04.313423
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.327651	2025-06-30 08:31:04.327651
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.341635	2025-06-30 08:31:04.341635
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.356491	2025-06-30 08:31:04.356491
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.373771	2025-06-30 08:31:04.373771
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.389865	2025-06-30 08:31:04.389865
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.403216	2025-06-30 08:31:04.403216
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.413617	2025-06-30 08:31:04.413617
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.422095	2025-06-30 08:31:04.422095
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.429622	2025-06-30 08:31:04.429622
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.43737	2025-06-30 08:31:04.43737
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.446184	2025-06-30 08:31:04.446184
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.479092	2025-06-30 08:31:04.479092
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.488811	2025-06-30 08:31:04.488811
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.496569	2025-06-30 08:31:04.496569
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.509214	2025-06-30 08:31:04.509214
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.516753	2025-06-30 08:31:04.516753
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.548293	2025-06-30 08:31:04.548293
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.556351	2025-06-30 08:31:04.556351
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.564635	2025-06-30 08:31:04.564635
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.572556	2025-06-30 08:31:04.572556
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.581364	2025-06-30 08:31:04.581364
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.591145	2025-06-30 08:31:04.591145
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.602233	2025-06-30 08:31:04.602233
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.613007	2025-06-30 08:31:04.613007
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.620252	2025-06-30 08:31:04.620252
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.628275	2025-06-30 08:31:04.628275
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.635811	2025-06-30 08:31:04.635811
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.642454	2025-06-30 08:31:04.642454
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.649291	2025-06-30 08:31:04.649291
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.656887	2025-06-30 08:31:04.656887
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.664014	2025-06-30 08:31:04.664014
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.671774	2025-06-30 08:31:04.671774
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.678429	2025-06-30 08:31:04.678429
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.687128	2025-06-30 08:31:04.687128
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.694043	2025-06-30 08:31:04.694043
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.702131	2025-06-30 08:31:04.702131
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.709553	2025-06-30 08:31:04.709553
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.718625	2025-06-30 08:31:04.718625
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.726594	2025-06-30 08:31:04.726594
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.733862	2025-06-30 08:31:04.733862
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.743688	2025-06-30 08:31:04.743688
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.750669	2025-06-30 08:31:04.750669
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.759441	2025-06-30 08:31:04.759441
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.767885	2025-06-30 08:31:04.767885
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.77653	2025-06-30 08:31:04.77653
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.784748	2025-06-30 08:31:04.784748
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.792744	2025-06-30 08:31:04.792744
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.800733	2025-06-30 08:31:04.800733
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.808117	2025-06-30 08:31:04.808117
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.824232	2025-06-30 08:31:04.824232
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.831529	2025-06-30 08:31:04.831529
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.840312	2025-06-30 08:31:04.840312
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.847792	2025-06-30 08:31:04.847792
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.85679	2025-06-30 08:31:04.85679
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.864509	2025-06-30 08:31:04.864509
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.872061	2025-06-30 08:31:04.872061
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.882674	2025-06-30 08:31:04.882674
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.890464	2025-06-30 08:31:04.890464
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.897869	2025-06-30 08:31:04.897869
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.905475	2025-06-30 08:31:04.905475
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.912465	2025-06-30 08:31:04.912465
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.921557	2025-06-30 08:31:04.921557
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.92826	2025-06-30 08:31:04.92826
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.949054	2025-06-30 08:31:04.949054
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:04.995174	2025-06-30 08:31:04.995174
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.003473	2025-06-30 08:31:05.003473
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.029453	2025-06-30 08:31:05.029453
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.054273	2025-06-30 08:31:05.054273
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.097647	2025-06-30 08:31:05.097647
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.108268	2025-06-30 08:31:05.108268
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.117649	2025-06-30 08:31:05.117649
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.127326	2025-06-30 08:31:05.127326
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.134631	2025-06-30 08:31:05.134631
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.143729	2025-06-30 08:31:05.143729
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.15186	2025-06-30 08:31:05.15186
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.1608	2025-06-30 08:31:05.1608
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.178638	2025-06-30 08:31:05.178638
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.187709	2025-06-30 08:31:05.187709
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.196463	2025-06-30 08:31:05.196463
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.205058	2025-06-30 08:31:05.205058
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.213821	2025-06-30 08:31:05.213821
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.222787	2025-06-30 08:31:05.222787
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.230395	2025-06-30 08:31:05.230395
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.256532	2025-06-30 08:31:05.256532
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.265204	2025-06-30 08:31:05.265204
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.36225	2025-06-30 08:31:05.36225
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.596029	2025-06-30 08:31:05.596029
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.633894	2025-06-30 08:31:05.633894
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.644985	2025-06-30 08:31:05.644985
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.653077	2025-06-30 08:31:05.653077
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.660605	2025-06-30 08:31:05.660605
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.669258	2025-06-30 08:31:05.669258
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.6823	2025-06-30 08:31:05.6823
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.692505	2025-06-30 08:31:05.692505
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.700443	2025-06-30 08:31:05.700443
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.708609	2025-06-30 08:31:05.708609
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.717881	2025-06-30 08:31:05.717881
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.731817	2025-06-30 08:31:05.731817
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.758395	2025-06-30 08:31:05.758395
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.767846	2025-06-30 08:31:05.767846
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.786662	2025-06-30 08:31:05.786662
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.796837	2025-06-30 08:31:05.796837
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.803247	2025-06-30 08:31:05.803247
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.808573	2025-06-30 08:31:05.808573
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.814133	2025-06-30 08:31:05.814133
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.819855	2025-06-30 08:31:05.819855
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.826937	2025-06-30 08:31:05.826937
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.839953	2025-06-30 08:31:05.839953
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.872883	2025-06-30 08:31:05.872883
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.917133	2025-06-30 08:31:05.917133
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.945636	2025-06-30 08:31:05.945636
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.955607	2025-06-30 08:31:05.955607
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.96534	2025-06-30 08:31:05.96534
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.976693	2025-06-30 08:31:05.976693
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.986593	2025-06-30 08:31:05.986593
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:05.993577	2025-06-30 08:31:05.993577
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.0037	2025-06-30 08:31:06.0037
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.012902	2025-06-30 08:31:06.012902
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.019992	2025-06-30 08:31:06.019992
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.028345	2025-06-30 08:31:06.028345
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.038005	2025-06-30 08:31:06.038005
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.044386	2025-06-30 08:31:06.044386
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.054999	2025-06-30 08:31:06.054999
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.061555	2025-06-30 08:31:06.061555
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.072311	2025-06-30 08:31:06.072311
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.082072	2025-06-30 08:31:06.082072
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.091549	2025-06-30 08:31:06.091549
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.09983	2025-06-30 08:31:06.09983
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.108661	2025-06-30 08:31:06.108661
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.117958	2025-06-30 08:31:06.117958
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.12644	2025-06-30 08:31:06.12644
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.13511	2025-06-30 08:31:06.13511
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.144621	2025-06-30 08:31:06.144621
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.153595	2025-06-30 08:31:06.153595
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.162999	2025-06-30 08:31:06.162999
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.172153	2025-06-30 08:31:06.172153
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.181601	2025-06-30 08:31:06.181601
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.18942	2025-06-30 08:31:06.18942
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.199734	2025-06-30 08:31:06.199734
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.207876	2025-06-30 08:31:06.207876
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.217157	2025-06-30 08:31:06.217157
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.225634	2025-06-30 08:31:06.225634
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.231938	2025-06-30 08:31:06.231938
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.238975	2025-06-30 08:31:06.238975
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.248132	2025-06-30 08:31:06.248132
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.256672	2025-06-30 08:31:06.256672
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.266298	2025-06-30 08:31:06.266298
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.275376	2025-06-30 08:31:06.275376
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.282126	2025-06-30 08:31:06.282126
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.292412	2025-06-30 08:31:06.292412
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.300232	2025-06-30 08:31:06.300232
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.310299	2025-06-30 08:31:06.310299
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.31866	2025-06-30 08:31:06.31866
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.327262	2025-06-30 08:31:06.327262
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.336361	2025-06-30 08:31:06.336361
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.343195	2025-06-30 08:31:06.343195
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.354465	2025-06-30 08:31:06.354465
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.367168	2025-06-30 08:31:06.367168
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.374031	2025-06-30 08:31:06.374031
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.380916	2025-06-30 08:31:06.380916
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.390033	2025-06-30 08:31:06.390033
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.397331	2025-06-30 08:31:06.397331
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.403631	2025-06-30 08:31:06.403631
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.408635	2025-06-30 08:31:06.408635
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.414389	2025-06-30 08:31:06.414389
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.421509	2025-06-30 08:31:06.421509
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.428263	2025-06-30 08:31:06.428263
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.433763	2025-06-30 08:31:06.433763
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.4386	2025-06-30 08:31:06.4386
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.445914	2025-06-30 08:31:06.445914
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.453095	2025-06-30 08:31:06.453095
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.459627	2025-06-30 08:31:06.459627
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.485405	2025-06-30 08:31:06.485405
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.552166	2025-06-30 08:31:06.552166
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.562464	2025-06-30 08:31:06.562464
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.57003	2025-06-30 08:31:06.57003
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.575104	2025-06-30 08:31:06.575104
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.581821	2025-06-30 08:31:06.581821
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.587489	2025-06-30 08:31:06.587489
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.593263	2025-06-30 08:31:06.593263
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.599007	2025-06-30 08:31:06.599007
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.604292	2025-06-30 08:31:06.604292
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.607636	2025-06-30 08:31:06.607636
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.615874	2025-06-30 08:31:06.615874
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.622836	2025-06-30 08:31:06.622836
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.632536	2025-06-30 08:31:06.632536
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.639475	2025-06-30 08:31:06.639475
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.650214	2025-06-30 08:31:06.650214
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.657604	2025-06-30 08:31:06.657604
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.667938	2025-06-30 08:31:06.667938
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.677997	2025-06-30 08:31:06.677997
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.687538	2025-06-30 08:31:06.687538
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.695017	2025-06-30 08:31:06.695017
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.702898	2025-06-30 08:31:06.702898
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.712069	2025-06-30 08:31:06.712069
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.718852	2025-06-30 08:31:06.718852
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.727579	2025-06-30 08:31:06.727579
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.737422	2025-06-30 08:31:06.737422
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.747054	2025-06-30 08:31:06.747054
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.754003	2025-06-30 08:31:06.754003
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.765445	2025-06-30 08:31:06.765445
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.775367	2025-06-30 08:31:06.775367
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.785276	2025-06-30 08:31:06.785276
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.79177	2025-06-30 08:31:06.79177
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.801187	2025-06-30 08:31:06.801187
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.809859	2025-06-30 08:31:06.809859
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.818516	2025-06-30 08:31:06.818516
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.827126	2025-06-30 08:31:06.827126
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.835736	2025-06-30 08:31:06.835736
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.845517	2025-06-30 08:31:06.845517
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.852505	2025-06-30 08:31:06.852505
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.864611	2025-06-30 08:31:06.864611
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.87467	2025-06-30 08:31:06.87467
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.881446	2025-06-30 08:31:06.881446
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.888484	2025-06-30 08:31:06.888484
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.89916	2025-06-30 08:31:06.89916
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.905476	2025-06-30 08:31:06.905476
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.914327	2025-06-30 08:31:06.914327
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.924257	2025-06-30 08:31:06.924257
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.930538	2025-06-30 08:31:06.930538
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.939342	2025-06-30 08:31:06.939342
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.946053	2025-06-30 08:31:06.946053
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.95616	2025-06-30 08:31:06.95616
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.961338	2025-06-30 08:31:06.961338
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.966488	2025-06-30 08:31:06.966488
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.972469	2025-06-30 08:31:06.972469
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.978	2025-06-30 08:31:06.978
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.988083	2025-06-30 08:31:06.988083
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:06.997754	2025-06-30 08:31:06.997754
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.008851	2025-06-30 08:31:07.008851
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.014689	2025-06-30 08:31:07.014689
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.022372	2025-06-30 08:31:07.022372
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.030739	2025-06-30 08:31:07.030739
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.046284	2025-06-30 08:31:07.046284
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.056649	2025-06-30 08:31:07.056649
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.065042	2025-06-30 08:31:07.065042
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.073816	2025-06-30 08:31:07.073816
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.083608	2025-06-30 08:31:07.083608
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.092127	2025-06-30 08:31:07.092127
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.101179	2025-06-30 08:31:07.101179
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.110174	2025-06-30 08:31:07.110174
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.119764	2025-06-30 08:31:07.119764
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.129012	2025-06-30 08:31:07.129012
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.137968	2025-06-30 08:31:07.137968
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.1527	2025-06-30 08:31:07.1527
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.175642	2025-06-30 08:31:07.175642
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.187996	2025-06-30 08:31:07.187996
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.20147	2025-06-30 08:31:07.20147
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.214961	2025-06-30 08:31:07.214961
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.22973	2025-06-30 08:31:07.22973
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.243624	2025-06-30 08:31:07.243624
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.257878	2025-06-30 08:31:07.257878
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.275274	2025-06-30 08:31:07.275274
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.291451	2025-06-30 08:31:07.291451
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.304153	2025-06-30 08:31:07.304153
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.315057	2025-06-30 08:31:07.315057
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.331435	2025-06-30 08:31:07.331435
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.344534	2025-06-30 08:31:07.344534
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.353873	2025-06-30 08:31:07.353873
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.368004	2025-06-30 08:31:07.368004
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.380839	2025-06-30 08:31:07.380839
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.390535	2025-06-30 08:31:07.390535
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.400906	2025-06-30 08:31:07.400906
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.416527	2025-06-30 08:31:07.416527
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.424688	2025-06-30 08:31:07.424688
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.434861	2025-06-30 08:31:07.434861
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.451396	2025-06-30 08:31:07.451396
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.459847	2025-06-30 08:31:07.459847
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.470231	2025-06-30 08:31:07.470231
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.485979	2025-06-30 08:31:07.485979
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.494535	2025-06-30 08:31:07.494535
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.50542	2025-06-30 08:31:07.50542
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.521242	2025-06-30 08:31:07.521242
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.534476	2025-06-30 08:31:07.534476
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.545838	2025-06-30 08:31:07.545838
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.56044	2025-06-30 08:31:07.56044
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.57493	2025-06-30 08:31:07.57493
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.584	2025-06-30 08:31:07.584
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.60146	2025-06-30 08:31:07.60146
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.610582	2025-06-30 08:31:07.610582
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.621404	2025-06-30 08:31:07.621404
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.637374	2025-06-30 08:31:07.637374
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.645182	2025-06-30 08:31:07.645182
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.654089	2025-06-30 08:31:07.654089
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.668256	2025-06-30 08:31:07.668256
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.678216	2025-06-30 08:31:07.678216
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.68804	2025-06-30 08:31:07.68804
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.7029	2025-06-30 08:31:07.7029
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.714113	2025-06-30 08:31:07.714113
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.720167	2025-06-30 08:31:07.720167
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.73315	2025-06-30 08:31:07.73315
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.739043	2025-06-30 08:31:07.739043
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.772524	2025-06-30 08:31:07.772524
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.781125	2025-06-30 08:31:07.781125
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.787467	2025-06-30 08:31:07.787467
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.798046	2025-06-30 08:31:07.798046
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.807063	2025-06-30 08:31:07.807063
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.81737	2025-06-30 08:31:07.81737
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.824397	2025-06-30 08:31:07.824397
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.830055	2025-06-30 08:31:07.830055
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.837577	2025-06-30 08:31:07.837577
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.84663	2025-06-30 08:31:07.84663
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.853836	2025-06-30 08:31:07.853836
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.860907	2025-06-30 08:31:07.860907
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.868382	2025-06-30 08:31:07.868382
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.876579	2025-06-30 08:31:07.876579
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.883737	2025-06-30 08:31:07.883737
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.88892	2025-06-30 08:31:07.88892
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.893745	2025-06-30 08:31:07.893745
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.899613	2025-06-30 08:31:07.899613
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.905289	2025-06-30 08:31:07.905289
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.910649	2025-06-30 08:31:07.910649
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.915607	2025-06-30 08:31:07.915607
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.920696	2025-06-30 08:31:07.920696
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.925747	2025-06-30 08:31:07.925747
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.93059	2025-06-30 08:31:07.93059
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.936045	2025-06-30 08:31:07.936045
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.940776	2025-06-30 08:31:07.940776
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.94627	2025-06-30 08:31:07.94627
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.951564	2025-06-30 08:31:07.951564
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.958138	2025-06-30 08:31:07.958138
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.967228	2025-06-30 08:31:07.967228
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.974365	2025-06-30 08:31:07.974365
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.982498	2025-06-30 08:31:07.982498
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.989216	2025-06-30 08:31:07.989216
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.99424	2025-06-30 08:31:07.99424
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:07.999552	2025-06-30 08:31:07.999552
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.007291	2025-06-30 08:31:08.007291
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.014183	2025-06-30 08:31:08.014183
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.02216	2025-06-30 08:31:08.02216
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.028886	2025-06-30 08:31:08.028886
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.037747	2025-06-30 08:31:08.037747
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.045491	2025-06-30 08:31:08.045491
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.05301	2025-06-30 08:31:08.05301
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.059875	2025-06-30 08:31:08.059875
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.066793	2025-06-30 08:31:08.066793
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.07368	2025-06-30 08:31:08.07368
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.082229	2025-06-30 08:31:08.082229
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.091013	2025-06-30 08:31:08.091013
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.098603	2025-06-30 08:31:08.098603
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.103622	2025-06-30 08:31:08.103622
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.10931	2025-06-30 08:31:08.10931
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.128171	2025-06-30 08:31:08.128171
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.133402	2025-06-30 08:31:08.133402
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.138144	2025-06-30 08:31:08.138144
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.142988	2025-06-30 08:31:08.142988
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.148149	2025-06-30 08:31:08.148149
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.153247	2025-06-30 08:31:08.153247
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.158896	2025-06-30 08:31:08.158896
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.164103	2025-06-30 08:31:08.164103
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.169071	2025-06-30 08:31:08.169071
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.175846	2025-06-30 08:31:08.175846
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.181027	2025-06-30 08:31:08.181027
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.186978	2025-06-30 08:31:08.186978
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.192326	2025-06-30 08:31:08.192326
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.198539	2025-06-30 08:31:08.198539
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.204252	2025-06-30 08:31:08.204252
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.209109	2025-06-30 08:31:08.209109
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.214367	2025-06-30 08:31:08.214367
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.219228	2025-06-30 08:31:08.219228
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.225622	2025-06-30 08:31:08.225622
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.230334	2025-06-30 08:31:08.230334
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.23543	2025-06-30 08:31:08.23543
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.240198	2025-06-30 08:31:08.240198
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.245324	2025-06-30 08:31:08.245324
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.250573	2025-06-30 08:31:08.250573
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.255999	2025-06-30 08:31:08.255999
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.262128	2025-06-30 08:31:08.262128
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.270003	2025-06-30 08:31:08.270003
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.277229	2025-06-30 08:31:08.277229
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.283202	2025-06-30 08:31:08.283202
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.288673	2025-06-30 08:31:08.288673
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.294063	2025-06-30 08:31:08.294063
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.300888	2025-06-30 08:31:08.300888
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.305827	2025-06-30 08:31:08.305827
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.310901	2025-06-30 08:31:08.310901
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.316413	2025-06-30 08:31:08.316413
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.322104	2025-06-30 08:31:08.322104
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.328499	2025-06-30 08:31:08.328499
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.334313	2025-06-30 08:31:08.334313
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.339259	2025-06-30 08:31:08.339259
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.34583	2025-06-30 08:31:08.34583
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.351885	2025-06-30 08:31:08.351885
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.357902	2025-06-30 08:31:08.357902
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.362865	2025-06-30 08:31:08.362865
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.36796	2025-06-30 08:31:08.36796
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.372989	2025-06-30 08:31:08.372989
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.379186	2025-06-30 08:31:08.379186
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.384921	2025-06-30 08:31:08.384921
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.390655	2025-06-30 08:31:08.390655
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.396149	2025-06-30 08:31:08.396149
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.401459	2025-06-30 08:31:08.401459
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.423546	2025-06-30 08:31:08.423546
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.429026	2025-06-30 08:31:08.429026
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.45908	2025-06-30 08:31:08.45908
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.465395	2025-06-30 08:31:08.465395
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.472094	2025-06-30 08:31:08.472094
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.476797	2025-06-30 08:31:08.476797
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.483001	2025-06-30 08:31:08.483001
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.488479	2025-06-30 08:31:08.488479
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.493551	2025-06-30 08:31:08.493551
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.498807	2025-06-30 08:31:08.498807
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.503604	2025-06-30 08:31:08.503604
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.508389	2025-06-30 08:31:08.508389
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.513664	2025-06-30 08:31:08.513664
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.520242	2025-06-30 08:31:08.520242
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.525547	2025-06-30 08:31:08.525547
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.533758	2025-06-30 08:31:08.533758
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.546898	2025-06-30 08:31:08.546898
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.552177	2025-06-30 08:31:08.552177
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.559482	2025-06-30 08:31:08.559482
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.566508	2025-06-30 08:31:08.566508
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.571585	2025-06-30 08:31:08.571585
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.578644	2025-06-30 08:31:08.578644
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.583324	2025-06-30 08:31:08.583324
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.589479	2025-06-30 08:31:08.589479
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.594932	2025-06-30 08:31:08.594932
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.600291	2025-06-30 08:31:08.600291
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.607083	2025-06-30 08:31:08.607083
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.617331	2025-06-30 08:31:08.617331
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.624272	2025-06-30 08:31:08.624272
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.629385	2025-06-30 08:31:08.629385
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.635768	2025-06-30 08:31:08.635768
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.64182	2025-06-30 08:31:08.64182
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.649007	2025-06-30 08:31:08.649007
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.657315	2025-06-30 08:31:08.657315
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.66234	2025-06-30 08:31:08.66234
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.667229	2025-06-30 08:31:08.667229
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.67287	2025-06-30 08:31:08.67287
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.678036	2025-06-30 08:31:08.678036
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.685975	2025-06-30 08:31:08.685975
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.692741	2025-06-30 08:31:08.692741
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.890986	2025-06-30 08:31:08.890986
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.971434	2025-06-30 08:31:08.971434
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.982267	2025-06-30 08:31:08.982267
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:08.995158	2025-06-30 08:31:08.995158
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.005911	2025-06-30 08:31:09.005911
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.014143	2025-06-30 08:31:09.014143
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.021412	2025-06-30 08:31:09.021412
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.02658	2025-06-30 08:31:09.02658
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.032219	2025-06-30 08:31:09.032219
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.035911	2025-06-30 08:31:09.035911
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.042747	2025-06-30 08:31:09.042747
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.049125	2025-06-30 08:31:09.049125
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.055071	2025-06-30 08:31:09.055071
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.059982	2025-06-30 08:31:09.059982
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.065329	2025-06-30 08:31:09.065329
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.070507	2025-06-30 08:31:09.070507
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.079303	2025-06-30 08:31:09.079303
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.084622	2025-06-30 08:31:09.084622
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.089897	2025-06-30 08:31:09.089897
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.096432	2025-06-30 08:31:09.096432
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.102056	2025-06-30 08:31:09.102056
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.109913	2025-06-30 08:31:09.109913
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.11609	2025-06-30 08:31:09.11609
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.121511	2025-06-30 08:31:09.121511
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.127491	2025-06-30 08:31:09.127491
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.134062	2025-06-30 08:31:09.134062
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.139232	2025-06-30 08:31:09.139232
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.144342	2025-06-30 08:31:09.144342
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.149696	2025-06-30 08:31:09.149696
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.15461	2025-06-30 08:31:09.15461
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.159765	2025-06-30 08:31:09.159765
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.164829	2025-06-30 08:31:09.164829
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-06-30 08:31:09.169997	2025-06-30 08:31:09.169997
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.175532	2025-06-30 08:31:09.175532
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.202283	2025-06-30 08:31:09.202283
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.45897	2025-06-30 08:31:09.45897
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.572974	2025-06-30 08:31:09.572974
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.588563	2025-06-30 08:31:09.588563
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.599285	2025-06-30 08:31:09.599285
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.610706	2025-06-30 08:31:09.610706
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.619811	2025-06-30 08:31:09.619811
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.626247	2025-06-30 08:31:09.626247
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.633217	2025-06-30 08:31:09.633217
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.636682	2025-06-30 08:31:09.636682
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.640864	2025-06-30 08:31:09.640864
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.64445	2025-06-30 08:31:09.64445
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.649047	2025-06-30 08:31:09.649047
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.652912	2025-06-30 08:31:09.652912
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.656756	2025-06-30 08:31:09.656756
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.662313	2025-06-30 08:31:09.662313
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.669603	2025-06-30 08:31:09.669603
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.676941	2025-06-30 08:31:09.676941
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.683716	2025-06-30 08:31:09.683716
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.689897	2025-06-30 08:31:09.689897
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.694839	2025-06-30 08:31:09.694839
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.698143	2025-06-30 08:31:09.698143
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.701866	2025-06-30 08:31:09.701866
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.705797	2025-06-30 08:31:09.705797
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.711253	2025-06-30 08:31:09.711253
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.716373	2025-06-30 08:31:09.716373
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.721071	2025-06-30 08:31:09.721071
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.724307	2025-06-30 08:31:09.724307
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.727595	2025-06-30 08:31:09.727595
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.733089	2025-06-30 08:31:09.733089
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.743037	2025-06-30 08:31:09.743037
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.746517	2025-06-30 08:31:09.746517
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.749846	2025-06-30 08:31:09.749846
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.753157	2025-06-30 08:31:09.753157
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.757767	2025-06-30 08:31:09.757767
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.761678	2025-06-30 08:31:09.761678
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.766757	2025-06-30 08:31:09.766757
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.771963	2025-06-30 08:31:09.771963
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.775639	2025-06-30 08:31:09.775639
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.781586	2025-06-30 08:31:09.781586
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.786624	2025-06-30 08:31:09.786624
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.790466	2025-06-30 08:31:09.790466
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.795787	2025-06-30 08:31:09.795787
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.801042	2025-06-30 08:31:09.801042
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.805204	2025-06-30 08:31:09.805204
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.809053	2025-06-30 08:31:09.809053
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.812866	2025-06-30 08:31:09.812866
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.821314	2025-06-30 08:31:09.821314
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.826694	2025-06-30 08:31:09.826694
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.83077	2025-06-30 08:31:09.83077
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.835773	2025-06-30 08:31:09.835773
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.838942	2025-06-30 08:31:09.838942
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.843078	2025-06-30 08:31:09.843078
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.84861	2025-06-30 08:31:09.84861
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.85357	2025-06-30 08:31:09.85357
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.857543	2025-06-30 08:31:09.857543
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.862651	2025-06-30 08:31:09.862651
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.868176	2025-06-30 08:31:09.868176
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.872428	2025-06-30 08:31:09.872428
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.876392	2025-06-30 08:31:09.876392
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.881823	2025-06-30 08:31:09.881823
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.886726	2025-06-30 08:31:09.886726
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.892008	2025-06-30 08:31:09.892008
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.897444	2025-06-30 08:31:09.897444
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.90243	2025-06-30 08:31:09.90243
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.907251	2025-06-30 08:31:09.907251
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.912249	2025-06-30 08:31:09.912249
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.915675	2025-06-30 08:31:09.915675
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.920324	2025-06-30 08:31:09.920324
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.925151	2025-06-30 08:31:09.925151
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.929195	2025-06-30 08:31:09.929195
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.932616	2025-06-30 08:31:09.932616
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.93915	2025-06-30 08:31:09.93915
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.944267	2025-06-30 08:31:09.944267
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.947473	2025-06-30 08:31:09.947473
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.952205	2025-06-30 08:31:09.952205
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.957281	2025-06-30 08:31:09.957281
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.962484	2025-06-30 08:31:09.962484
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.968038	2025-06-30 08:31:09.968038
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.972925	2025-06-30 08:31:09.972925
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.979915	2025-06-30 08:31:09.979915
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.984727	2025-06-30 08:31:09.984727
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.989585	2025-06-30 08:31:09.989585
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.99443	2025-06-30 08:31:09.99443
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:09.999635	2025-06-30 08:31:09.999635
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.004764	2025-06-30 08:31:10.004764
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.009659	2025-06-30 08:31:10.009659
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.014687	2025-06-30 08:31:10.014687
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.017997	2025-06-30 08:31:10.017997
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.021313	2025-06-30 08:31:10.021313
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.024504	2025-06-30 08:31:10.024504
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.029211	2025-06-30 08:31:10.029211
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.034711	2025-06-30 08:31:10.034711
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.039754	2025-06-30 08:31:10.039754
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.045223	2025-06-30 08:31:10.045223
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.050663	2025-06-30 08:31:10.050663
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.056394	2025-06-30 08:31:10.056394
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.06009	2025-06-30 08:31:10.06009
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.0651	2025-06-30 08:31:10.0651
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.070733	2025-06-30 08:31:10.070733
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.075415	2025-06-30 08:31:10.075415
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.082184	2025-06-30 08:31:10.082184
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.091682	2025-06-30 08:31:10.091682
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.107926	2025-06-30 08:31:10.107926
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.113231	2025-06-30 08:31:10.113231
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.1225	2025-06-30 08:31:10.1225
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.129715	2025-06-30 08:31:10.129715
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.133404	2025-06-30 08:31:10.133404
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.137378	2025-06-30 08:31:10.137378
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.142785	2025-06-30 08:31:10.142785
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.148793	2025-06-30 08:31:10.148793
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.156606	2025-06-30 08:31:10.156606
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.165758	2025-06-30 08:31:10.165758
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.169688	2025-06-30 08:31:10.169688
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.173566	2025-06-30 08:31:10.173566
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.179884	2025-06-30 08:31:10.179884
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.188926	2025-06-30 08:31:10.188926
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.197003	2025-06-30 08:31:10.197003
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.202631	2025-06-30 08:31:10.202631
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.206799	2025-06-30 08:31:10.206799
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.210656	2025-06-30 08:31:10.210656
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.216349	2025-06-30 08:31:10.216349
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.22304	2025-06-30 08:31:10.22304
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.228576	2025-06-30 08:31:10.228576
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.233653	2025-06-30 08:31:10.233653
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.23776	2025-06-30 08:31:10.23776
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.241629	2025-06-30 08:31:10.241629
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.246571	2025-06-30 08:31:10.246571
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.252053	2025-06-30 08:31:10.252053
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.258967	2025-06-30 08:31:10.258967
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.264008	2025-06-30 08:31:10.264008
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.269333	2025-06-30 08:31:10.269333
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.27296	2025-06-30 08:31:10.27296
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.279555	2025-06-30 08:31:10.279555
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.283602	2025-06-30 08:31:10.283602
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.288933	2025-06-30 08:31:10.288933
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.294636	2025-06-30 08:31:10.294636
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.298205	2025-06-30 08:31:10.298205
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.302356	2025-06-30 08:31:10.302356
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.307606	2025-06-30 08:31:10.307606
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.311791	2025-06-30 08:31:10.311791
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.316202	2025-06-30 08:31:10.316202
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.320097	2025-06-30 08:31:10.320097
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.329729	2025-06-30 08:31:10.329729
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.334934	2025-06-30 08:31:10.334934
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.34124	2025-06-30 08:31:10.34124
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.348174	2025-06-30 08:31:10.348174
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.355225	2025-06-30 08:31:10.355225
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.361165	2025-06-30 08:31:10.361165
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.365666	2025-06-30 08:31:10.365666
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.372812	2025-06-30 08:31:10.372812
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.378628	2025-06-30 08:31:10.378628
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.399256	2025-06-30 08:31:10.399256
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.407002	2025-06-30 08:31:10.407002
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.415845	2025-06-30 08:31:10.415845
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.4215	2025-06-30 08:31:10.4215
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.425051	2025-06-30 08:31:10.425051
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.432276	2025-06-30 08:31:10.432276
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.437507	2025-06-30 08:31:10.437507
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.444441	2025-06-30 08:31:10.444441
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.456367	2025-06-30 08:31:10.456367
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.476477	2025-06-30 08:31:10.476477
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.498173	2025-06-30 08:31:10.498173
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.506103	2025-06-30 08:31:10.506103
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.514524	2025-06-30 08:31:10.514524
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.536419	2025-06-30 08:31:10.536419
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.544239	2025-06-30 08:31:10.544239
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.555316	2025-06-30 08:31:10.555316
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.558933	2025-06-30 08:31:10.558933
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.562198	2025-06-30 08:31:10.562198
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.566268	2025-06-30 08:31:10.566268
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.57171	2025-06-30 08:31:10.57171
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.577126	2025-06-30 08:31:10.577126
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.581016	2025-06-30 08:31:10.581016
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.590391	2025-06-30 08:31:10.590391
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.594434	2025-06-30 08:31:10.594434
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.598676	2025-06-30 08:31:10.598676
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.604564	2025-06-30 08:31:10.604564
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.609931	2025-06-30 08:31:10.609931
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.617512	2025-06-30 08:31:10.617512
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.622784	2025-06-30 08:31:10.622784
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.639331	2025-06-30 08:31:10.639331
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.652764	2025-06-30 08:31:10.652764
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.661465	2025-06-30 08:31:10.661465
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.664645	2025-06-30 08:31:10.664645
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.667971	2025-06-30 08:31:10.667971
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.671351	2025-06-30 08:31:10.671351
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.674355	2025-06-30 08:31:10.674355
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.677406	2025-06-30 08:31:10.677406
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.680475	2025-06-30 08:31:10.680475
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.684095	2025-06-30 08:31:10.684095
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.687437	2025-06-30 08:31:10.687437
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.690785	2025-06-30 08:31:10.690785
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.694133	2025-06-30 08:31:10.694133
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.702293	2025-06-30 08:31:10.702293
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.705637	2025-06-30 08:31:10.705637
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.709304	2025-06-30 08:31:10.709304
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.712517	2025-06-30 08:31:10.712517
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.715715	2025-06-30 08:31:10.715715
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.718923	2025-06-30 08:31:10.718923
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.7294	2025-06-30 08:31:10.7294
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.732846	2025-06-30 08:31:10.732846
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.736041	2025-06-30 08:31:10.736041
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.739051	2025-06-30 08:31:10.739051
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.742067	2025-06-30 08:31:10.742067
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.745069	2025-06-30 08:31:10.745069
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.748222	2025-06-30 08:31:10.748222
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.751896	2025-06-30 08:31:10.751896
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.755196	2025-06-30 08:31:10.755196
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.761038	2025-06-30 08:31:10.761038
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.766809	2025-06-30 08:31:10.766809
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.772495	2025-06-30 08:31:10.772495
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.778343	2025-06-30 08:31:10.778343
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.781931	2025-06-30 08:31:10.781931
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.794294	2025-06-30 08:31:10.794294
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.798283	2025-06-30 08:31:10.798283
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.811168	2025-06-30 08:31:10.811168
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.819431	2025-06-30 08:31:10.819431
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.824813	2025-06-30 08:31:10.824813
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.829157	2025-06-30 08:31:10.829157
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.83302	2025-06-30 08:31:10.83302
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.837445	2025-06-30 08:31:10.837445
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.841043	2025-06-30 08:31:10.841043
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.844759	2025-06-30 08:31:10.844759
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.848659	2025-06-30 08:31:10.848659
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.852366	2025-06-30 08:31:10.852366
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.858288	2025-06-30 08:31:10.858288
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.863762	2025-06-30 08:31:10.863762
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.867369	2025-06-30 08:31:10.867369
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.876793	2025-06-30 08:31:10.876793
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.882348	2025-06-30 08:31:10.882348
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.888435	2025-06-30 08:31:10.888435
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.893709	2025-06-30 08:31:10.893709
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.896943	2025-06-30 08:31:10.896943
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.900113	2025-06-30 08:31:10.900113
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.903319	2025-06-30 08:31:10.903319
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.908197	2025-06-30 08:31:10.908197
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.912427	2025-06-30 08:31:10.912427
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.919134	2025-06-30 08:31:10.919134
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.922463	2025-06-30 08:31:10.922463
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.927821	2025-06-30 08:31:10.927821
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.934279	2025-06-30 08:31:10.934279
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.940753	2025-06-30 08:31:10.940753
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.946267	2025-06-30 08:31:10.946267
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.949749	2025-06-30 08:31:10.949749
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.955553	2025-06-30 08:31:10.955553
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.959139	2025-06-30 08:31:10.959139
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.962646	2025-06-30 08:31:10.962646
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.965983	2025-06-30 08:31:10.965983
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.970043	2025-06-30 08:31:10.970043
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.973405	2025-06-30 08:31:10.973405
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.977271	2025-06-30 08:31:10.977271
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.981662	2025-06-30 08:31:10.981662
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.985364	2025-06-30 08:31:10.985364
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.988897	2025-06-30 08:31:10.988897
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.992173	2025-06-30 08:31:10.992173
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:10.996793	2025-06-30 08:31:10.996793
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.000039	2025-06-30 08:31:11.000039
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.003461	2025-06-30 08:31:11.003461
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.007444	2025-06-30 08:31:11.007444
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.011279	2025-06-30 08:31:11.011279
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.014565	2025-06-30 08:31:11.014565
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.018277	2025-06-30 08:31:11.018277
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.026725	2025-06-30 08:31:11.026725
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.030645	2025-06-30 08:31:11.030645
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.034036	2025-06-30 08:31:11.034036
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.038809	2025-06-30 08:31:11.038809
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.042226	2025-06-30 08:31:11.042226
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.045454	2025-06-30 08:31:11.045454
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.048916	2025-06-30 08:31:11.048916
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.052626	2025-06-30 08:31:11.052626
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.055954	2025-06-30 08:31:11.055954
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.059912	2025-06-30 08:31:11.059912
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.065708	2025-06-30 08:31:11.065708
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.07351	2025-06-30 08:31:11.07351
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.078502	2025-06-30 08:31:11.078502
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.08183	2025-06-30 08:31:11.08183
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.084956	2025-06-30 08:31:11.084956
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.090449	2025-06-30 08:31:11.090449
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.096092	2025-06-30 08:31:11.096092
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.100332	2025-06-30 08:31:11.100332
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.107027	2025-06-30 08:31:11.107027
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.111408	2025-06-30 08:31:11.111408
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.147634	2025-06-30 08:31:11.147634
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.153214	2025-06-30 08:31:11.153214
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.158593	2025-06-30 08:31:11.158593
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.165007	2025-06-30 08:31:11.165007
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.202061	2025-06-30 08:31:11.202061
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.21047	2025-06-30 08:31:11.21047
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.218455	2025-06-30 08:31:11.218455
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.255463	2025-06-30 08:31:11.255463
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.258794	2025-06-30 08:31:11.258794
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-06-30 08:31:11.262304	2025-06-30 08:31:11.262304
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-30 08:30:42.227365
2	ART Coverage	\N	\N	2025-06-30 08:30:42.237757
3	People Living with HIV	\N	\N	2025-06-30 08:30:42.243887
4	HIV-related Deaths	\N	\N	2025-06-30 08:30:42.250082
5	HIV Cases Adults 15-49	\N	\N	2025-06-30 08:30:42.255961
6	ART Pediatric Coverage	\N	\N	2025-06-30 08:30:42.264682
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminus	$2b$12$8qDaG2FCucGhf/ttTpppK.qS62EFm9AmHpkKTJG0JQceLq9C6MUqa	admin	0	2025-06-30 08:30:42.210923	2025-06-30 08:30:42.210923
2	userus	$2b$12$1Qkh3kX3iGb41Lo7epRFBegJJZ9DdJ6m0JV9hJ8Fo6hQKEgRsz4Ea	user	0	2025-06-30 08:30:42.216799	2025-06-30 08:30:42.216799
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

