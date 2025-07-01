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
1	Afghanistan	Eastern Mediterranean	\N	2025-07-01 04:24:05.217071	2025-07-01 04:24:05.217071
2	Albania	Europe	\N	2025-07-01 04:24:05.227466	2025-07-01 04:24:05.227466
3	Algeria	Africa	\N	2025-07-01 04:24:05.237861	2025-07-01 04:24:05.237861
4	Angola	Africa	\N	2025-07-01 04:24:05.251346	2025-07-01 04:24:05.251346
5	Argentina	Americas	\N	2025-07-01 04:24:05.26193	2025-07-01 04:24:05.26193
6	Armenia	Europe	\N	2025-07-01 04:24:05.270844	2025-07-01 04:24:05.270844
7	Australia	Western Pacific	\N	2025-07-01 04:24:05.279964	2025-07-01 04:24:05.279964
8	Austria	Europe	\N	2025-07-01 04:24:05.294844	2025-07-01 04:24:05.294844
9	Azerbaijan	Europe	\N	2025-07-01 04:24:05.304025	2025-07-01 04:24:05.304025
10	Bahamas	Americas	\N	2025-07-01 04:24:05.3151	2025-07-01 04:24:05.3151
11	Bahrain	Eastern Mediterranean	\N	2025-07-01 04:24:05.324126	2025-07-01 04:24:05.324126
12	Bangladesh	South-East Asia	\N	2025-07-01 04:24:05.332842	2025-07-01 04:24:05.332842
13	Barbados	Americas	\N	2025-07-01 04:24:05.344022	2025-07-01 04:24:05.344022
14	Belarus	Europe	\N	2025-07-01 04:24:05.354746	2025-07-01 04:24:05.354746
15	Belgium	Europe	\N	2025-07-01 04:24:05.36521	2025-07-01 04:24:05.36521
16	Belize	Americas	\N	2025-07-01 04:24:05.378698	2025-07-01 04:24:05.378698
17	Benin	Africa	\N	2025-07-01 04:24:05.387545	2025-07-01 04:24:05.387545
18	Bhutan	South-East Asia	\N	2025-07-01 04:24:05.397813	2025-07-01 04:24:05.397813
19	Bolivia	Americas	\N	2025-07-01 04:24:05.407707	2025-07-01 04:24:05.407707
20	Bosnia and Herzegovina	Europe	\N	2025-07-01 04:24:05.419439	2025-07-01 04:24:05.419439
21	Botswana	Africa	\N	2025-07-01 04:24:05.434401	2025-07-01 04:24:05.434401
22	Brazil	Americas	\N	2025-07-01 04:24:05.443368	2025-07-01 04:24:05.443368
23	Brunei Darussalam	Western Pacific	\N	2025-07-01 04:24:05.453806	2025-07-01 04:24:05.453806
24	Bulgaria	Europe	\N	2025-07-01 04:24:05.463794	2025-07-01 04:24:05.463794
25	Burkina Faso	Africa	\N	2025-07-01 04:24:05.472886	2025-07-01 04:24:05.472886
26	Burundi	Africa	\N	2025-07-01 04:24:05.483005	2025-07-01 04:24:05.483005
27	Cabo Verde	Africa	\N	2025-07-01 04:24:05.49405	2025-07-01 04:24:05.49405
28	Cambodia	Western Pacific	\N	2025-07-01 04:24:05.504042	2025-07-01 04:24:05.504042
29	Cameroon	Africa	\N	2025-07-01 04:24:05.512565	2025-07-01 04:24:05.512565
30	Canada	Americas	\N	2025-07-01 04:24:05.523291	2025-07-01 04:24:05.523291
31	Central African Republic	Africa	\N	2025-07-01 04:24:05.533827	2025-07-01 04:24:05.533827
32	Chad	Africa	\N	2025-07-01 04:24:05.54367	2025-07-01 04:24:05.54367
33	Chile	Americas	\N	2025-07-01 04:24:05.555474	2025-07-01 04:24:05.555474
34	China	Western Pacific	\N	2025-07-01 04:24:05.564871	2025-07-01 04:24:05.564871
35	Colombia	Americas	\N	2025-07-01 04:24:05.593199	2025-07-01 04:24:05.593199
36	Comoros	Africa	\N	2025-07-01 04:24:05.603201	2025-07-01 04:24:05.603201
37	Congo	Americas	\N	2025-07-01 04:24:05.64398	2025-07-01 04:24:05.64398
38	Costa Rica	Americas	\N	2025-07-01 04:24:05.685505	2025-07-01 04:24:05.685505
39	Côte d'Ivoire	Africa	\N	2025-07-01 04:24:05.69691	2025-07-01 04:24:05.69691
40	Croatia	Europe	\N	2025-07-01 04:24:05.739462	2025-07-01 04:24:05.739462
41	Cuba	Americas	\N	2025-07-01 04:24:05.781434	2025-07-01 04:24:05.781434
42	Cyprus	Europe	\N	2025-07-01 04:24:05.823335	2025-07-01 04:24:05.823335
43	Czechia	Europe	\N	2025-07-01 04:24:05.847629	2025-07-01 04:24:05.847629
44	North Korea	Western Pacific	\N	2025-07-01 04:24:05.905616	2025-07-01 04:24:05.905616
45	DR Congo	Africa	\N	2025-07-01 04:24:05.924589	2025-07-01 04:24:05.924589
46	Denmark	Europe	\N	2025-07-01 04:24:05.951865	2025-07-01 04:24:05.951865
47	Djibouti	Eastern Mediterranean	\N	2025-07-01 04:24:06.00292	2025-07-01 04:24:06.00292
48	Dominican Republic	Americas	\N	2025-07-01 04:24:06.016951	2025-07-01 04:24:06.016951
49	Ecuador	Americas	\N	2025-07-01 04:24:06.0615	2025-07-01 04:24:06.0615
50	Egypt	Eastern Mediterranean	\N	2025-07-01 04:24:06.07436	2025-07-01 04:24:06.07436
51	El Salvador	Americas	\N	2025-07-01 04:24:06.087818	2025-07-01 04:24:06.087818
52	Equatorial Guinea	Africa	\N	2025-07-01 04:24:06.138235	2025-07-01 04:24:06.138235
53	Eritrea	Africa	\N	2025-07-01 04:24:06.158048	2025-07-01 04:24:06.158048
54	Estonia	Europe	\N	2025-07-01 04:24:06.17612	2025-07-01 04:24:06.17612
55	Eswatini	Africa	\N	2025-07-01 04:24:06.193583	2025-07-01 04:24:06.193583
56	Ethiopia	Africa	\N	2025-07-01 04:24:06.220971	2025-07-01 04:24:06.220971
57	Fiji	Western Pacific	\N	2025-07-01 04:24:06.248596	2025-07-01 04:24:06.248596
58	Finland	Europe	\N	2025-07-01 04:24:06.272116	2025-07-01 04:24:06.272116
59	France	Europe	\N	2025-07-01 04:24:06.292694	2025-07-01 04:24:06.292694
60	Gabon	Africa	\N	2025-07-01 04:24:06.320989	2025-07-01 04:24:06.320989
61	Gambia	Africa	\N	2025-07-01 04:24:06.346707	2025-07-01 04:24:06.346707
62	Georgia	Europe	\N	2025-07-01 04:24:06.376843	2025-07-01 04:24:06.376843
63	Germany	Europe	\N	2025-07-01 04:24:06.389394	2025-07-01 04:24:06.389394
64	Ghana	Africa	\N	2025-07-01 04:24:06.407389	2025-07-01 04:24:06.407389
65	Greece	Europe	\N	2025-07-01 04:24:06.425076	2025-07-01 04:24:06.425076
66	Guatemala	Americas	\N	2025-07-01 04:24:06.443339	2025-07-01 04:24:06.443339
67	Guinea	Africa	\N	2025-07-01 04:24:06.462907	2025-07-01 04:24:06.462907
68	Guinea-Bissau	Africa	\N	2025-07-01 04:24:06.480938	2025-07-01 04:24:06.480938
69	Guyana	Americas	\N	2025-07-01 04:24:06.499684	2025-07-01 04:24:06.499684
70	Haiti	Americas	\N	2025-07-01 04:24:06.519974	2025-07-01 04:24:06.519974
71	Honduras	Americas	\N	2025-07-01 04:24:06.5484	2025-07-01 04:24:06.5484
72	Hungary	Europe	\N	2025-07-01 04:24:06.558266	2025-07-01 04:24:06.558266
73	Iceland	Europe	\N	2025-07-01 04:24:06.56792	2025-07-01 04:24:06.56792
74	India	South-East Asia	\N	2025-07-01 04:24:06.577631	2025-07-01 04:24:06.577631
75	Indonesia	South-East Asia	\N	2025-07-01 04:24:06.588093	2025-07-01 04:24:06.588093
76	Iran	Eastern Mediterranean	\N	2025-07-01 04:24:06.599007	2025-07-01 04:24:06.599007
77	Ireland	Europe	\N	2025-07-01 04:24:06.608441	2025-07-01 04:24:06.608441
78	Israel	Europe	\N	2025-07-01 04:24:06.61728	2025-07-01 04:24:06.61728
79	Italy	Europe	\N	2025-07-01 04:24:06.62811	2025-07-01 04:24:06.62811
80	Jamaica	Americas	\N	2025-07-01 04:24:06.640099	2025-07-01 04:24:06.640099
81	Japan	Western Pacific	\N	2025-07-01 04:24:06.651074	2025-07-01 04:24:06.651074
82	Jordan	Eastern Mediterranean	\N	2025-07-01 04:24:06.659592	2025-07-01 04:24:06.659592
83	Kazakhstan	Europe	\N	2025-07-01 04:24:06.666435	2025-07-01 04:24:06.666435
84	Kenya	Africa	\N	2025-07-01 04:24:06.672752	2025-07-01 04:24:06.672752
85	Kuwait	Eastern Mediterranean	\N	2025-07-01 04:24:06.683998	2025-07-01 04:24:06.683998
86	Kyrgyzstan	Europe	\N	2025-07-01 04:24:06.691334	2025-07-01 04:24:06.691334
87	Laos	Western Pacific	\N	2025-07-01 04:24:06.703157	2025-07-01 04:24:06.703157
88	Latvia	Europe	\N	2025-07-01 04:24:06.708309	2025-07-01 04:24:06.708309
89	Lebanon	Eastern Mediterranean	\N	2025-07-01 04:24:06.717028	2025-07-01 04:24:06.717028
90	Lesotho	Africa	\N	2025-07-01 04:24:06.724841	2025-07-01 04:24:06.724841
91	Liberia	Africa	\N	2025-07-01 04:24:06.735428	2025-07-01 04:24:06.735428
92	Libya	Eastern Mediterranean	\N	2025-07-01 04:24:06.742202	2025-07-01 04:24:06.742202
93	Lithuania	Europe	\N	2025-07-01 04:24:06.750101	2025-07-01 04:24:06.750101
94	Luxembourg	Europe	\N	2025-07-01 04:24:06.760026	2025-07-01 04:24:06.760026
95	Madagascar	Africa	\N	2025-07-01 04:24:06.769023	2025-07-01 04:24:06.769023
96	Malawi	Africa	\N	2025-07-01 04:24:06.775751	2025-07-01 04:24:06.775751
97	Malaysia	Western Pacific	\N	2025-07-01 04:24:06.782589	2025-07-01 04:24:06.782589
98	Maldives	South-East Asia	\N	2025-07-01 04:24:06.792478	2025-07-01 04:24:06.792478
99	Mali	Africa	\N	2025-07-01 04:24:06.798937	2025-07-01 04:24:06.798937
100	Malta	Europe	\N	2025-07-01 04:24:06.805314	2025-07-01 04:24:06.805314
101	Mauritania	Africa	\N	2025-07-01 04:24:06.813007	2025-07-01 04:24:06.813007
102	Mauritius	Africa	\N	2025-07-01 04:24:06.820973	2025-07-01 04:24:06.820973
103	Mexico	Americas	\N	2025-07-01 04:24:06.829103	2025-07-01 04:24:06.829103
104	Mongolia	Western Pacific	\N	2025-07-01 04:24:06.839052	2025-07-01 04:24:06.839052
105	Montenegro	Europe	\N	2025-07-01 04:24:06.844863	2025-07-01 04:24:06.844863
106	Morocco	Eastern Mediterranean	\N	2025-07-01 04:24:06.849922	2025-07-01 04:24:06.849922
107	Mozambique	Africa	\N	2025-07-01 04:24:06.854821	2025-07-01 04:24:06.854821
108	Myanmar	South-East Asia	\N	2025-07-01 04:24:07.177243	2025-07-01 04:24:07.177243
109	Namibia	Africa	\N	2025-07-01 04:24:07.194661	2025-07-01 04:24:07.194661
110	Nepal	South-East Asia	\N	2025-07-01 04:24:07.200971	2025-07-01 04:24:07.200971
111	Netherlands	Europe	\N	2025-07-01 04:24:07.20574	2025-07-01 04:24:07.20574
112	New Zealand	Western Pacific	\N	2025-07-01 04:24:07.215362	2025-07-01 04:24:07.215362
113	Nicaragua	Americas	\N	2025-07-01 04:24:07.224222	2025-07-01 04:24:07.224222
114	Niger	Africa	\N	2025-07-01 04:24:07.227535	2025-07-01 04:24:07.227535
115	Nigeria	Africa	\N	2025-07-01 04:24:07.395747	2025-07-01 04:24:07.395747
116	Norway	Europe	\N	2025-07-01 04:24:07.514063	2025-07-01 04:24:07.514063
117	Oman	Eastern Mediterranean	\N	2025-07-01 04:24:07.52578	2025-07-01 04:24:07.52578
118	Pakistan	Eastern Mediterranean	\N	2025-07-01 04:24:07.535543	2025-07-01 04:24:07.535543
119	Panama	Americas	\N	2025-07-01 04:24:07.546985	2025-07-01 04:24:07.546985
120	Papua New Guinea	Western Pacific	\N	2025-07-01 04:24:07.556745	2025-07-01 04:24:07.556745
121	Paraguay	Americas	\N	2025-07-01 04:24:07.593729	2025-07-01 04:24:07.593729
122	Peru	Americas	\N	2025-07-01 04:24:07.602737	2025-07-01 04:24:07.602737
123	Philippines	Western Pacific	\N	2025-07-01 04:24:07.609617	2025-07-01 04:24:07.609617
124	Poland	Europe	\N	2025-07-01 04:24:07.627648	2025-07-01 04:24:07.627648
125	Portugal	Europe	\N	2025-07-01 04:24:07.639779	2025-07-01 04:24:07.639779
126	Qatar	Eastern Mediterranean	\N	2025-07-01 04:24:07.648534	2025-07-01 04:24:07.648534
127	South Korea	Western Pacific	\N	2025-07-01 04:24:07.655395	2025-07-01 04:24:07.655395
128	Moldova	Europe	\N	2025-07-01 04:24:07.662845	2025-07-01 04:24:07.662845
129	North Macedonia	Europe	\N	2025-07-01 04:24:07.670114	2025-07-01 04:24:07.670114
130	Romania	Europe	\N	2025-07-01 04:24:07.677963	2025-07-01 04:24:07.677963
131	Russia	Europe	\N	2025-07-01 04:24:07.955704	2025-07-01 04:24:07.955704
132	Rwanda	Africa	\N	2025-07-01 04:24:08.064335	2025-07-01 04:24:08.064335
133	Saudi Arabia	Eastern Mediterranean	\N	2025-07-01 04:24:08.081906	2025-07-01 04:24:08.081906
134	Senegal	Africa	\N	2025-07-01 04:24:08.088114	2025-07-01 04:24:08.088114
135	Serbia	Europe	\N	2025-07-01 04:24:08.093324	2025-07-01 04:24:08.093324
136	Sierra Leone	Africa	\N	2025-07-01 04:24:08.103079	2025-07-01 04:24:08.103079
137	Singapore	Western Pacific	\N	2025-07-01 04:24:08.106298	2025-07-01 04:24:08.106298
138	Slovakia	Europe	\N	2025-07-01 04:24:08.1108	2025-07-01 04:24:08.1108
139	Slovenia	Europe	\N	2025-07-01 04:24:08.115487	2025-07-01 04:24:08.115487
140	Somalia	Eastern Mediterranean	\N	2025-07-01 04:24:08.121256	2025-07-01 04:24:08.121256
141	South Africa	Africa	\N	2025-07-01 04:24:08.125891	2025-07-01 04:24:08.125891
142	South Sudan	Africa	\N	2025-07-01 04:24:08.12862	2025-07-01 04:24:08.12862
143	Spain	Europe	\N	2025-07-01 04:24:08.133221	2025-07-01 04:24:08.133221
144	Sri Lanka	South-East Asia	\N	2025-07-01 04:24:08.138001	2025-07-01 04:24:08.138001
145	Sudan	Eastern Mediterranean	\N	2025-07-01 04:24:08.140773	2025-07-01 04:24:08.140773
146	Suriname	Americas	\N	2025-07-01 04:24:08.143395	2025-07-01 04:24:08.143395
147	Sweden	Europe	\N	2025-07-01 04:24:08.146472	2025-07-01 04:24:08.146472
148	Switzerland	Europe	\N	2025-07-01 04:24:08.149257	2025-07-01 04:24:08.149257
149	Syria	Eastern Mediterranean	\N	2025-07-01 04:24:08.16025	2025-07-01 04:24:08.16025
150	Tajikistan	Europe	\N	2025-07-01 04:24:08.164956	2025-07-01 04:24:08.164956
151	Thailand	South-East Asia	\N	2025-07-01 04:24:08.168019	2025-07-01 04:24:08.168019
152	Timor-Leste	South-East Asia	\N	2025-07-01 04:24:08.171535	2025-07-01 04:24:08.171535
153	Togo	Africa	\N	2025-07-01 04:24:08.174468	2025-07-01 04:24:08.174468
154	Trinidad and Tobago	Americas	\N	2025-07-01 04:24:08.17764	2025-07-01 04:24:08.17764
155	Tunisia	Eastern Mediterranean	\N	2025-07-01 04:24:08.181722	2025-07-01 04:24:08.181722
156	Turkey	Europe	\N	2025-07-01 04:24:08.186282	2025-07-01 04:24:08.186282
157	Turkmenistan	Europe	\N	2025-07-01 04:24:08.189094	2025-07-01 04:24:08.189094
158	Uganda	Africa	\N	2025-07-01 04:24:08.194329	2025-07-01 04:24:08.194329
159	Ukraine	Europe	\N	2025-07-01 04:24:08.198387	2025-07-01 04:24:08.198387
160	United Arab Emirates	Eastern Mediterranean	\N	2025-07-01 04:24:08.203201	2025-07-01 04:24:08.203201
161	United Kingdom	Europe	\N	2025-07-01 04:24:08.207662	2025-07-01 04:24:08.207662
162	Tanzania	Africa	\N	2025-07-01 04:24:08.211962	2025-07-01 04:24:08.211962
163	United States	Americas	\N	2025-07-01 04:24:08.214596	2025-07-01 04:24:08.214596
164	Uruguay	Americas	\N	2025-07-01 04:24:08.219217	2025-07-01 04:24:08.219217
165	Uzbekistan	Europe	\N	2025-07-01 04:24:08.224487	2025-07-01 04:24:08.224487
166	Venezuela	Americas	\N	2025-07-01 04:24:08.228936	2025-07-01 04:24:08.228936
167	Viet Nam	Western Pacific	\N	2025-07-01 04:24:08.231885	2025-07-01 04:24:08.231885
168	Yemen	Eastern Mediterranean	\N	2025-07-01 04:24:08.234816	2025-07-01 04:24:08.234816
169	Zambia	Africa	\N	2025-07-01 04:24:08.239132	2025-07-01 04:24:08.239132
170	Zimbabwe	Africa	\N	2025-07-01 04:24:08.245898	2025-07-01 04:24:08.245898
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.24917	2025-07-01 04:24:08.24917
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.253344	2025-07-01 04:24:08.253344
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.258365	2025-07-01 04:24:08.258365
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.261915	2025-07-01 04:24:08.261915
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.266678	2025-07-01 04:24:08.266678
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.269913	2025-07-01 04:24:08.269913
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.276572	2025-07-01 04:24:08.276572
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.279704	2025-07-01 04:24:08.279704
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.282622	2025-07-01 04:24:08.282622
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.285725	2025-07-01 04:24:08.285725
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.289547	2025-07-01 04:24:08.289547
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.294296	2025-07-01 04:24:08.294296
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.29722	2025-07-01 04:24:08.29722
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.300055	2025-07-01 04:24:08.300055
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.305923	2025-07-01 04:24:08.305923
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.311563	2025-07-01 04:24:08.311563
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.314299	2025-07-01 04:24:08.314299
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.317127	2025-07-01 04:24:08.317127
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.32	2025-07-01 04:24:08.32
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.32418	2025-07-01 04:24:08.32418
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.332103	2025-07-01 04:24:08.332103
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.335115	2025-07-01 04:24:08.335115
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.338115	2025-07-01 04:24:08.338115
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.342608	2025-07-01 04:24:08.342608
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.346078	2025-07-01 04:24:08.346078
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.350644	2025-07-01 04:24:08.350644
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.35724	2025-07-01 04:24:08.35724
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.362649	2025-07-01 04:24:08.362649
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.369268	2025-07-01 04:24:08.369268
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.373481	2025-07-01 04:24:08.373481
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.378358	2025-07-01 04:24:08.378358
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.383646	2025-07-01 04:24:08.383646
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.386851	2025-07-01 04:24:08.386851
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.390231	2025-07-01 04:24:08.390231
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.394614	2025-07-01 04:24:08.394614
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.401982	2025-07-01 04:24:08.401982
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.407688	2025-07-01 04:24:08.407688
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.4122	2025-07-01 04:24:08.4122
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.416631	2025-07-01 04:24:08.416631
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.420788	2025-07-01 04:24:08.420788
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.424286	2025-07-01 04:24:08.424286
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.42951	2025-07-01 04:24:08.42951
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.43432	2025-07-01 04:24:08.43432
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.436873	2025-07-01 04:24:08.436873
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.441463	2025-07-01 04:24:08.441463
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.445476	2025-07-01 04:24:08.445476
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.448461	2025-07-01 04:24:08.448461
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.452169	2025-07-01 04:24:08.452169
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.455773	2025-07-01 04:24:08.455773
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.459426	2025-07-01 04:24:08.459426
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.462544	2025-07-01 04:24:08.462544
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.466854	2025-07-01 04:24:08.466854
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.47288	2025-07-01 04:24:08.47288
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.475708	2025-07-01 04:24:08.475708
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.478688	2025-07-01 04:24:08.478688
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.482479	2025-07-01 04:24:08.482479
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.486103	2025-07-01 04:24:08.486103
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.489397	2025-07-01 04:24:08.489397
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.492221	2025-07-01 04:24:08.492221
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.496928	2025-07-01 04:24:08.496928
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.499682	2025-07-01 04:24:08.499682
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.50244	2025-07-01 04:24:08.50244
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.505025	2025-07-01 04:24:08.505025
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.510527	2025-07-01 04:24:08.510527
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.513805	2025-07-01 04:24:08.513805
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.518146	2025-07-01 04:24:08.518146
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.52323	2025-07-01 04:24:08.52323
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.5285	2025-07-01 04:24:08.5285
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.534658	2025-07-01 04:24:08.534658
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.540932	2025-07-01 04:24:08.540932
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.552034	2025-07-01 04:24:08.552034
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.561711	2025-07-01 04:24:08.561711
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.565702	2025-07-01 04:24:08.565702
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.573115	2025-07-01 04:24:08.573115
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.579203	2025-07-01 04:24:08.579203
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.584647	2025-07-01 04:24:08.584647
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.591557	2025-07-01 04:24:08.591557
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.597507	2025-07-01 04:24:08.597507
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.602645	2025-07-01 04:24:08.602645
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.607996	2025-07-01 04:24:08.607996
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.612789	2025-07-01 04:24:08.612789
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.618996	2025-07-01 04:24:08.618996
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.624061	2025-07-01 04:24:08.624061
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.629712	2025-07-01 04:24:08.629712
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.635609	2025-07-01 04:24:08.635609
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.640496	2025-07-01 04:24:08.640496
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.645485	2025-07-01 04:24:08.645485
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.650445	2025-07-01 04:24:08.650445
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.6556	2025-07-01 04:24:08.6556
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.661915	2025-07-01 04:24:08.661915
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.667708	2025-07-01 04:24:08.667708
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.675023	2025-07-01 04:24:08.675023
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.680675	2025-07-01 04:24:08.680675
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.686702	2025-07-01 04:24:08.686702
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.694385	2025-07-01 04:24:08.694385
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.70049	2025-07-01 04:24:08.70049
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.70586	2025-07-01 04:24:08.70586
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.712451	2025-07-01 04:24:08.712451
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.718584	2025-07-01 04:24:08.718584
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.724109	2025-07-01 04:24:08.724109
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.730847	2025-07-01 04:24:08.730847
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.738954	2025-07-01 04:24:08.738954
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.744286	2025-07-01 04:24:08.744286
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.749417	2025-07-01 04:24:08.749417
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.756397	2025-07-01 04:24:08.756397
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.762066	2025-07-01 04:24:08.762066
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.767066	2025-07-01 04:24:08.767066
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.772156	2025-07-01 04:24:08.772156
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.776883	2025-07-01 04:24:08.776883
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.782591	2025-07-01 04:24:08.782591
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.788627	2025-07-01 04:24:08.788627
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.795377	2025-07-01 04:24:08.795377
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.801087	2025-07-01 04:24:08.801087
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.810034	2025-07-01 04:24:08.810034
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.818697	2025-07-01 04:24:08.818697
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.821758	2025-07-01 04:24:08.821758
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.826062	2025-07-01 04:24:08.826062
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.832501	2025-07-01 04:24:08.832501
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.839417	2025-07-01 04:24:08.839417
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.844782	2025-07-01 04:24:08.844782
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.851345	2025-07-01 04:24:08.851345
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.857096	2025-07-01 04:24:08.857096
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.861999	2025-07-01 04:24:08.861999
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.868969	2025-07-01 04:24:08.868969
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.874383	2025-07-01 04:24:08.874383
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.88442	2025-07-01 04:24:08.88442
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.891273	2025-07-01 04:24:08.891273
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.896047	2025-07-01 04:24:08.896047
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.904799	2025-07-01 04:24:08.904799
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.911455	2025-07-01 04:24:08.911455
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.921671	2025-07-01 04:24:08.921671
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.933778	2025-07-01 04:24:08.933778
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.941382	2025-07-01 04:24:08.941382
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.950579	2025-07-01 04:24:08.950579
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.956062	2025-07-01 04:24:08.956062
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.962862	2025-07-01 04:24:08.962862
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.967931	2025-07-01 04:24:08.967931
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.984132	2025-07-01 04:24:08.984132
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.987357	2025-07-01 04:24:08.987357
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:08.993911	2025-07-01 04:24:08.993911
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.00148	2025-07-01 04:24:09.00148
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.006496	2025-07-01 04:24:09.006496
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.014699	2025-07-01 04:24:09.014699
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.023491	2025-07-01 04:24:09.023491
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.028266	2025-07-01 04:24:09.028266
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.031571	2025-07-01 04:24:09.031571
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.036576	2025-07-01 04:24:09.036576
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.048925	2025-07-01 04:24:09.048925
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.058815	2025-07-01 04:24:09.058815
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.063938	2025-07-01 04:24:09.063938
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.069122	2025-07-01 04:24:09.069122
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.074119	2025-07-01 04:24:09.074119
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.080114	2025-07-01 04:24:09.080114
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.087623	2025-07-01 04:24:09.087623
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.091953	2025-07-01 04:24:09.091953
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.095152	2025-07-01 04:24:09.095152
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.099878	2025-07-01 04:24:09.099878
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.103599	2025-07-01 04:24:09.103599
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.108912	2025-07-01 04:24:09.108912
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.113603	2025-07-01 04:24:09.113603
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.116963	2025-07-01 04:24:09.116963
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.122619	2025-07-01 04:24:09.122619
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.127717	2025-07-01 04:24:09.127717
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.130664	2025-07-01 04:24:09.130664
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.13519	2025-07-01 04:24:09.13519
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.138868	2025-07-01 04:24:09.138868
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.142125	2025-07-01 04:24:09.142125
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.147403	2025-07-01 04:24:09.147403
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.15361	2025-07-01 04:24:09.15361
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.157121	2025-07-01 04:24:09.157121
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.160262	2025-07-01 04:24:09.160262
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.163716	2025-07-01 04:24:09.163716
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.170424	2025-07-01 04:24:09.170424
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.174783	2025-07-01 04:24:09.174783
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.181029	2025-07-01 04:24:09.181029
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.187883	2025-07-01 04:24:09.187883
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.191051	2025-07-01 04:24:09.191051
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.194218	2025-07-01 04:24:09.194218
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.197686	2025-07-01 04:24:09.197686
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.204304	2025-07-01 04:24:09.204304
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.210786	2025-07-01 04:24:09.210786
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.21587	2025-07-01 04:24:09.21587
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.220812	2025-07-01 04:24:09.220812
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.224849	2025-07-01 04:24:09.224849
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.230185	2025-07-01 04:24:09.230185
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.235159	2025-07-01 04:24:09.235159
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.24197	2025-07-01 04:24:09.24197
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.244972	2025-07-01 04:24:09.244972
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.250843	2025-07-01 04:24:09.250843
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.25784	2025-07-01 04:24:09.25784
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.266703	2025-07-01 04:24:09.266703
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.271603	2025-07-01 04:24:09.271603
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.275915	2025-07-01 04:24:09.275915
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.280012	2025-07-01 04:24:09.280012
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.283352	2025-07-01 04:24:09.283352
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.287516	2025-07-01 04:24:09.287516
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.292313	2025-07-01 04:24:09.292313
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.297116	2025-07-01 04:24:09.297116
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.300619	2025-07-01 04:24:09.300619
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.303794	2025-07-01 04:24:09.303794
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.306878	2025-07-01 04:24:09.306878
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.310224	2025-07-01 04:24:09.310224
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.313687	2025-07-01 04:24:09.313687
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.318753	2025-07-01 04:24:09.318753
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.32221	2025-07-01 04:24:09.32221
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.326484	2025-07-01 04:24:09.326484
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.330955	2025-07-01 04:24:09.330955
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.335753	2025-07-01 04:24:09.335753
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.339359	2025-07-01 04:24:09.339359
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.342721	2025-07-01 04:24:09.342721
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.346042	2025-07-01 04:24:09.346042
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.349139	2025-07-01 04:24:09.349139
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.352538	2025-07-01 04:24:09.352538
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.356524	2025-07-01 04:24:09.356524
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.359808	2025-07-01 04:24:09.359808
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.363853	2025-07-01 04:24:09.363853
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.36725	2025-07-01 04:24:09.36725
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.370491	2025-07-01 04:24:09.370491
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.37381	2025-07-01 04:24:09.37381
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.37828	2025-07-01 04:24:09.37828
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.381504	2025-07-01 04:24:09.381504
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.384922	2025-07-01 04:24:09.384922
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.389253	2025-07-01 04:24:09.389253
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.394009	2025-07-01 04:24:09.394009
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.398845	2025-07-01 04:24:09.398845
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.401966	2025-07-01 04:24:09.401966
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.405116	2025-07-01 04:24:09.405116
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.409544	2025-07-01 04:24:09.409544
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.412975	2025-07-01 04:24:09.412975
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.41857	2025-07-01 04:24:09.41857
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.422414	2025-07-01 04:24:09.422414
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.425667	2025-07-01 04:24:09.425667
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.430077	2025-07-01 04:24:09.430077
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.435517	2025-07-01 04:24:09.435517
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.440453	2025-07-01 04:24:09.440453
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.443912	2025-07-01 04:24:09.443912
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.447808	2025-07-01 04:24:09.447808
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.451166	2025-07-01 04:24:09.451166
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.454748	2025-07-01 04:24:09.454748
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.459582	2025-07-01 04:24:09.459582
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.463398	2025-07-01 04:24:09.463398
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.467172	2025-07-01 04:24:09.467172
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.47286	2025-07-01 04:24:09.47286
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.476178	2025-07-01 04:24:09.476178
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.47934	2025-07-01 04:24:09.47934
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.483115	2025-07-01 04:24:09.483115
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.486783	2025-07-01 04:24:09.486783
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.490667	2025-07-01 04:24:09.490667
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.493778	2025-07-01 04:24:09.493778
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.49716	2025-07-01 04:24:09.49716
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.501564	2025-07-01 04:24:09.501564
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.506425	2025-07-01 04:24:09.506425
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.510184	2025-07-01 04:24:09.510184
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.513334	2025-07-01 04:24:09.513334
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.517115	2025-07-01 04:24:09.517115
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.520473	2025-07-01 04:24:09.520473
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.524003	2025-07-01 04:24:09.524003
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.528807	2025-07-01 04:24:09.528807
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.532397	2025-07-01 04:24:09.532397
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.536231	2025-07-01 04:24:09.536231
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.539946	2025-07-01 04:24:09.539946
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.543261	2025-07-01 04:24:09.543261
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.546913	2025-07-01 04:24:09.546913
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.550737	2025-07-01 04:24:09.550737
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.554327	2025-07-01 04:24:09.554327
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.557865	2025-07-01 04:24:09.557865
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.560917	2025-07-01 04:24:09.560917
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.564023	2025-07-01 04:24:09.564023
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.56824	2025-07-01 04:24:09.56824
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.573043	2025-07-01 04:24:09.573043
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.576585	2025-07-01 04:24:09.576585
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.579797	2025-07-01 04:24:09.579797
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.583078	2025-07-01 04:24:09.583078
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.586672	2025-07-01 04:24:09.586672
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.590305	2025-07-01 04:24:09.590305
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.593773	2025-07-01 04:24:09.593773
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.597146	2025-07-01 04:24:09.597146
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.600603	2025-07-01 04:24:09.600603
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.605259	2025-07-01 04:24:09.605259
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.608816	2025-07-01 04:24:09.608816
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.615581	2025-07-01 04:24:09.615581
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.61999	2025-07-01 04:24:09.61999
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.625676	2025-07-01 04:24:09.625676
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.629041	2025-07-01 04:24:09.629041
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.634258	2025-07-01 04:24:09.634258
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.637775	2025-07-01 04:24:09.637775
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.641336	2025-07-01 04:24:09.641336
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.645143	2025-07-01 04:24:09.645143
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.648623	2025-07-01 04:24:09.648623
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.651854	2025-07-01 04:24:09.651854
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.654969	2025-07-01 04:24:09.654969
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.659308	2025-07-01 04:24:09.659308
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.664305	2025-07-01 04:24:09.664305
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.671411	2025-07-01 04:24:09.671411
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.676566	2025-07-01 04:24:09.676566
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.682773	2025-07-01 04:24:09.682773
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.686183	2025-07-01 04:24:09.686183
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.689545	2025-07-01 04:24:09.689545
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.692882	2025-07-01 04:24:09.692882
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.695975	2025-07-01 04:24:09.695975
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.699063	2025-07-01 04:24:09.699063
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.70211	2025-07-01 04:24:09.70211
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.705793	2025-07-01 04:24:09.705793
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:24:09.709364	2025-07-01 04:24:09.709364
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.712681	2025-07-01 04:24:09.712681
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.716024	2025-07-01 04:24:09.716024
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.719237	2025-07-01 04:24:09.719237
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.722826	2025-07-01 04:24:09.722826
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.726327	2025-07-01 04:24:09.726327
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.729424	2025-07-01 04:24:09.729424
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.733736	2025-07-01 04:24:09.733736
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.738351	2025-07-01 04:24:09.738351
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.741957	2025-07-01 04:24:09.741957
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.745093	2025-07-01 04:24:09.745093
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.748254	2025-07-01 04:24:09.748254
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.751742	2025-07-01 04:24:09.751742
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.755445	2025-07-01 04:24:09.755445
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.758653	2025-07-01 04:24:09.758653
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.761812	2025-07-01 04:24:09.761812
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.764974	2025-07-01 04:24:09.764974
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.769371	2025-07-01 04:24:09.769371
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.772885	2025-07-01 04:24:09.772885
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.775992	2025-07-01 04:24:09.775992
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.77911	2025-07-01 04:24:09.77911
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.782075	2025-07-01 04:24:09.782075
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.785083	2025-07-01 04:24:09.785083
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.788546	2025-07-01 04:24:09.788546
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.791606	2025-07-01 04:24:09.791606
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.794774	2025-07-01 04:24:09.794774
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.797849	2025-07-01 04:24:09.797849
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.800904	2025-07-01 04:24:09.800904
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.804312	2025-07-01 04:24:09.804312
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.807541	2025-07-01 04:24:09.807541
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.810971	2025-07-01 04:24:09.810971
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.81402	2025-07-01 04:24:09.81402
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.817135	2025-07-01 04:24:09.817135
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.820219	2025-07-01 04:24:09.820219
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.82379	2025-07-01 04:24:09.82379
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.827933	2025-07-01 04:24:09.827933
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.831446	2025-07-01 04:24:09.831446
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.834813	2025-07-01 04:24:09.834813
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.838104	2025-07-01 04:24:09.838104
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.841956	2025-07-01 04:24:09.841956
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.845567	2025-07-01 04:24:09.845567
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.849084	2025-07-01 04:24:09.849084
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.852258	2025-07-01 04:24:09.852258
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.855522	2025-07-01 04:24:09.855522
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.859253	2025-07-01 04:24:09.859253
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.862962	2025-07-01 04:24:09.862962
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.866416	2025-07-01 04:24:09.866416
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.869982	2025-07-01 04:24:09.869982
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.873666	2025-07-01 04:24:09.873666
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.877563	2025-07-01 04:24:09.877563
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.881236	2025-07-01 04:24:09.881236
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.884412	2025-07-01 04:24:09.884412
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.887584	2025-07-01 04:24:09.887584
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.890765	2025-07-01 04:24:09.890765
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.894616	2025-07-01 04:24:09.894616
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.898586	2025-07-01 04:24:09.898586
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.901834	2025-07-01 04:24:09.901834
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.905059	2025-07-01 04:24:09.905059
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.909514	2025-07-01 04:24:09.909514
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.913362	2025-07-01 04:24:09.913362
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.916969	2025-07-01 04:24:09.916969
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.920397	2025-07-01 04:24:09.920397
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.923741	2025-07-01 04:24:09.923741
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.927271	2025-07-01 04:24:09.927271
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.930509	2025-07-01 04:24:09.930509
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.934068	2025-07-01 04:24:09.934068
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.938267	2025-07-01 04:24:09.938267
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.941277	2025-07-01 04:24:09.941277
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.944342	2025-07-01 04:24:09.944342
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.947547	2025-07-01 04:24:09.947547
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.951271	2025-07-01 04:24:09.951271
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.954365	2025-07-01 04:24:09.954365
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.958245	2025-07-01 04:24:09.958245
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.961875	2025-07-01 04:24:09.961875
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.965666	2025-07-01 04:24:09.965666
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.969091	2025-07-01 04:24:09.969091
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.972239	2025-07-01 04:24:09.972239
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.975787	2025-07-01 04:24:09.975787
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.979558	2025-07-01 04:24:09.979558
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.983103	2025-07-01 04:24:09.983103
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.986379	2025-07-01 04:24:09.986379
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.989509	2025-07-01 04:24:09.989509
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.992663	2025-07-01 04:24:09.992663
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:09.996392	2025-07-01 04:24:09.996392
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.00072	2025-07-01 04:24:10.00072
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.004332	2025-07-01 04:24:10.004332
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.007436	2025-07-01 04:24:10.007436
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.011075	2025-07-01 04:24:10.011075
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.014765	2025-07-01 04:24:10.014765
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.018159	2025-07-01 04:24:10.018159
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.021792	2025-07-01 04:24:10.021792
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.025024	2025-07-01 04:24:10.025024
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.028594	2025-07-01 04:24:10.028594
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.032247	2025-07-01 04:24:10.032247
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.035514	2025-07-01 04:24:10.035514
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.038621	2025-07-01 04:24:10.038621
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.041776	2025-07-01 04:24:10.041776
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.045967	2025-07-01 04:24:10.045967
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.075208	2025-07-01 04:24:10.075208
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.157974	2025-07-01 04:24:10.157974
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.192547	2025-07-01 04:24:10.192547
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.196536	2025-07-01 04:24:10.196536
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.200194	2025-07-01 04:24:10.200194
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.205154	2025-07-01 04:24:10.205154
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.209897	2025-07-01 04:24:10.209897
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.233258	2025-07-01 04:24:10.233258
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.236896	2025-07-01 04:24:10.236896
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.240302	2025-07-01 04:24:10.240302
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.24382	2025-07-01 04:24:10.24382
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.248513	2025-07-01 04:24:10.248513
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.253325	2025-07-01 04:24:10.253325
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.258811	2025-07-01 04:24:10.258811
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.263381	2025-07-01 04:24:10.263381
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.267106	2025-07-01 04:24:10.267106
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.270515	2025-07-01 04:24:10.270515
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.274025	2025-07-01 04:24:10.274025
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.278585	2025-07-01 04:24:10.278585
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.282144	2025-07-01 04:24:10.282144
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.286341	2025-07-01 04:24:10.286341
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.295866	2025-07-01 04:24:10.295866
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.302072	2025-07-01 04:24:10.302072
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.306004	2025-07-01 04:24:10.306004
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.310921	2025-07-01 04:24:10.310921
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.314805	2025-07-01 04:24:10.314805
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.349367	2025-07-01 04:24:10.349367
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.353993	2025-07-01 04:24:10.353993
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.358006	2025-07-01 04:24:10.358006
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.361398	2025-07-01 04:24:10.361398
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.364927	2025-07-01 04:24:10.364927
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.368381	2025-07-01 04:24:10.368381
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.371934	2025-07-01 04:24:10.371934
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.375204	2025-07-01 04:24:10.375204
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.378977	2025-07-01 04:24:10.378977
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.382599	2025-07-01 04:24:10.382599
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.386041	2025-07-01 04:24:10.386041
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.38961	2025-07-01 04:24:10.38961
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.393308	2025-07-01 04:24:10.393308
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.4171	2025-07-01 04:24:10.4171
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.455748	2025-07-01 04:24:10.455748
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.463745	2025-07-01 04:24:10.463745
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.467513	2025-07-01 04:24:10.467513
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.470847	2025-07-01 04:24:10.470847
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.474652	2025-07-01 04:24:10.474652
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.478995	2025-07-01 04:24:10.478995
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.483249	2025-07-01 04:24:10.483249
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.543894	2025-07-01 04:24:10.543894
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.558604	2025-07-01 04:24:10.558604
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.566506	2025-07-01 04:24:10.566506
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.583834	2025-07-01 04:24:10.583834
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.593854	2025-07-01 04:24:10.593854
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.64386	2025-07-01 04:24:10.64386
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.649131	2025-07-01 04:24:10.649131
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.652407	2025-07-01 04:24:10.652407
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.656063	2025-07-01 04:24:10.656063
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.660072	2025-07-01 04:24:10.660072
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.663825	2025-07-01 04:24:10.663825
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.667365	2025-07-01 04:24:10.667365
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.670768	2025-07-01 04:24:10.670768
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.674444	2025-07-01 04:24:10.674444
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.679832	2025-07-01 04:24:10.679832
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.690098	2025-07-01 04:24:10.690098
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.705826	2025-07-01 04:24:10.705826
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.712832	2025-07-01 04:24:10.712832
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.717819	2025-07-01 04:24:10.717819
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.722915	2025-07-01 04:24:10.722915
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.728286	2025-07-01 04:24:10.728286
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.73168	2025-07-01 04:24:10.73168
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.736287	2025-07-01 04:24:10.736287
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.741824	2025-07-01 04:24:10.741824
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.746922	2025-07-01 04:24:10.746922
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.750747	2025-07-01 04:24:10.750747
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.755353	2025-07-01 04:24:10.755353
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.75905	2025-07-01 04:24:10.75905
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.762285	2025-07-01 04:24:10.762285
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.766728	2025-07-01 04:24:10.766728
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.771629	2025-07-01 04:24:10.771629
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.776447	2025-07-01 04:24:10.776447
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.77999	2025-07-01 04:24:10.77999
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.783776	2025-07-01 04:24:10.783776
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.788254	2025-07-01 04:24:10.788254
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.793091	2025-07-01 04:24:10.793091
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.796931	2025-07-01 04:24:10.796931
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.800435	2025-07-01 04:24:10.800435
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.804267	2025-07-01 04:24:10.804267
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.809072	2025-07-01 04:24:10.809072
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.813146	2025-07-01 04:24:10.813146
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.81672	2025-07-01 04:24:10.81672
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.824048	2025-07-01 04:24:10.824048
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.827958	2025-07-01 04:24:10.827958
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.833965	2025-07-01 04:24:10.833965
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.843143	2025-07-01 04:24:10.843143
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.85787	2025-07-01 04:24:10.85787
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.863725	2025-07-01 04:24:10.863725
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.877139	2025-07-01 04:24:10.877139
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.893773	2025-07-01 04:24:10.893773
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.913762	2025-07-01 04:24:10.913762
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.927009	2025-07-01 04:24:10.927009
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.943765	2025-07-01 04:24:10.943765
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.948572	2025-07-01 04:24:10.948572
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.952338	2025-07-01 04:24:10.952338
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.955929	2025-07-01 04:24:10.955929
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.960703	2025-07-01 04:24:10.960703
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.964617	2025-07-01 04:24:10.964617
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.96808	2025-07-01 04:24:10.96808
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.973915	2025-07-01 04:24:10.973915
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.978695	2025-07-01 04:24:10.978695
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.98238	2025-07-01 04:24:10.98238
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.986234	2025-07-01 04:24:10.986234
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.990271	2025-07-01 04:24:10.990271
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.994708	2025-07-01 04:24:10.994708
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:10.998318	2025-07-01 04:24:10.998318
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.002981	2025-07-01 04:24:11.002981
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.009438	2025-07-01 04:24:11.009438
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.017899	2025-07-01 04:24:11.017899
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.027792	2025-07-01 04:24:11.027792
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.031618	2025-07-01 04:24:11.031618
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.0353	2025-07-01 04:24:11.0353
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.03852	2025-07-01 04:24:11.03852
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.042065	2025-07-01 04:24:11.042065
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.046456	2025-07-01 04:24:11.046456
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.063828	2025-07-01 04:24:11.063828
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.081055	2025-07-01 04:24:11.081055
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.093741	2025-07-01 04:24:11.093741
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.113831	2025-07-01 04:24:11.113831
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.143757	2025-07-01 04:24:11.143757
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.162679	2025-07-01 04:24:11.162679
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.167787	2025-07-01 04:24:11.167787
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.174427	2025-07-01 04:24:11.174427
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.181458	2025-07-01 04:24:11.181458
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.185682	2025-07-01 04:24:11.185682
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.189914	2025-07-01 04:24:11.189914
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.194054	2025-07-01 04:24:11.194054
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.198411	2025-07-01 04:24:11.198411
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.204659	2025-07-01 04:24:11.204659
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.209073	2025-07-01 04:24:11.209073
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.216465	2025-07-01 04:24:11.216465
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.220329	2025-07-01 04:24:11.220329
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.225657	2025-07-01 04:24:11.225657
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.229023	2025-07-01 04:24:11.229023
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.23376	2025-07-01 04:24:11.23376
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.238946	2025-07-01 04:24:11.238946
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.244028	2025-07-01 04:24:11.244028
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.248013	2025-07-01 04:24:11.248013
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.251201	2025-07-01 04:24:11.251201
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.25587	2025-07-01 04:24:11.25587
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.261061	2025-07-01 04:24:11.261061
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.265232	2025-07-01 04:24:11.265232
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.27476	2025-07-01 04:24:11.27476
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.280242	2025-07-01 04:24:11.280242
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.288085	2025-07-01 04:24:11.288085
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.292082	2025-07-01 04:24:11.292082
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.29562	2025-07-01 04:24:11.29562
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.299384	2025-07-01 04:24:11.299384
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.30278	2025-07-01 04:24:11.30278
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.307343	2025-07-01 04:24:11.307343
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.311232	2025-07-01 04:24:11.311232
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.316329	2025-07-01 04:24:11.316329
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.31986	2025-07-01 04:24:11.31986
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.323077	2025-07-01 04:24:11.323077
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.327599	2025-07-01 04:24:11.327599
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.331553	2025-07-01 04:24:11.331553
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.335083	2025-07-01 04:24:11.335083
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.338882	2025-07-01 04:24:11.338882
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.343533	2025-07-01 04:24:11.343533
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.348962	2025-07-01 04:24:11.348962
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.35307	2025-07-01 04:24:11.35307
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.357716	2025-07-01 04:24:11.357716
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.361591	2025-07-01 04:24:11.361591
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.364865	2025-07-01 04:24:11.364865
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.36949	2025-07-01 04:24:11.36949
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.374871	2025-07-01 04:24:11.374871
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.379453	2025-07-01 04:24:11.379453
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.385473	2025-07-01 04:24:11.385473
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.38944	2025-07-01 04:24:11.38944
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.393169	2025-07-01 04:24:11.393169
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.396994	2025-07-01 04:24:11.396994
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.400495	2025-07-01 04:24:11.400495
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.404109	2025-07-01 04:24:11.404109
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.407317	2025-07-01 04:24:11.407317
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.410615	2025-07-01 04:24:11.410615
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.414168	2025-07-01 04:24:11.414168
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.419135	2025-07-01 04:24:11.419135
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.422449	2025-07-01 04:24:11.422449
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.426429	2025-07-01 04:24:11.426429
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.43029	2025-07-01 04:24:11.43029
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.433609	2025-07-01 04:24:11.433609
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.437579	2025-07-01 04:24:11.437579
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.44129	2025-07-01 04:24:11.44129
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.445048	2025-07-01 04:24:11.445048
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.448729	2025-07-01 04:24:11.448729
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.452148	2025-07-01 04:24:11.452148
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.456199	2025-07-01 04:24:11.456199
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.459939	2025-07-01 04:24:11.459939
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.463883	2025-07-01 04:24:11.463883
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.467849	2025-07-01 04:24:11.467849
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.47189	2025-07-01 04:24:11.47189
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.475371	2025-07-01 04:24:11.475371
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.478763	2025-07-01 04:24:11.478763
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.482084	2025-07-01 04:24:11.482084
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.485604	2025-07-01 04:24:11.485604
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.489658	2025-07-01 04:24:11.489658
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.494044	2025-07-01 04:24:11.494044
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.497476	2025-07-01 04:24:11.497476
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.500674	2025-07-01 04:24:11.500674
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.504015	2025-07-01 04:24:11.504015
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.507711	2025-07-01 04:24:11.507711
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.511238	2025-07-01 04:24:11.511238
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.523216	2025-07-01 04:24:11.523216
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.527074	2025-07-01 04:24:11.527074
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.53139	2025-07-01 04:24:11.53139
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.536041	2025-07-01 04:24:11.536041
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.539427	2025-07-01 04:24:11.539427
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.542782	2025-07-01 04:24:11.542782
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.573943	2025-07-01 04:24:11.573943
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.583769	2025-07-01 04:24:11.583769
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.58838	2025-07-01 04:24:11.58838
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.597584	2025-07-01 04:24:11.597584
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.601784	2025-07-01 04:24:11.601784
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.608681	2025-07-01 04:24:11.608681
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.613694	2025-07-01 04:24:11.613694
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.623731	2025-07-01 04:24:11.623731
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.633458	2025-07-01 04:24:11.633458
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.643436	2025-07-01 04:24:11.643436
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.661969	2025-07-01 04:24:11.661969
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.666959	2025-07-01 04:24:11.666959
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.681985	2025-07-01 04:24:11.681985
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.693118	2025-07-01 04:24:11.693118
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.706312	2025-07-01 04:24:11.706312
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.719878	2025-07-01 04:24:11.719878
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.725854	2025-07-01 04:24:11.725854
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.737698	2025-07-01 04:24:11.737698
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.741596	2025-07-01 04:24:11.741596
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.745442	2025-07-01 04:24:11.745442
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.748993	2025-07-01 04:24:11.748993
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.754406	2025-07-01 04:24:11.754406
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.757664	2025-07-01 04:24:11.757664
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.761048	2025-07-01 04:24:11.761048
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.763896	2025-07-01 04:24:11.763896
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.766822	2025-07-01 04:24:11.766822
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.773797	2025-07-01 04:24:11.773797
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.77698	2025-07-01 04:24:11.77698
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.800995	2025-07-01 04:24:11.800995
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.805875	2025-07-01 04:24:11.805875
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.811138	2025-07-01 04:24:11.811138
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.816005	2025-07-01 04:24:11.816005
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.821318	2025-07-01 04:24:11.821318
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.82612	2025-07-01 04:24:11.82612
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.830198	2025-07-01 04:24:11.830198
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.833203	2025-07-01 04:24:11.833203
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.836228	2025-07-01 04:24:11.836228
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.840445	2025-07-01 04:24:11.840445
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.843556	2025-07-01 04:24:11.843556
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.846674	2025-07-01 04:24:11.846674
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.849788	2025-07-01 04:24:11.849788
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.852677	2025-07-01 04:24:11.852677
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.855384	2025-07-01 04:24:11.855384
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.858336	2025-07-01 04:24:11.858336
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.8622	2025-07-01 04:24:11.8622
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.865075	2025-07-01 04:24:11.865075
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.867832	2025-07-01 04:24:11.867832
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.870797	2025-07-01 04:24:11.870797
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.873976	2025-07-01 04:24:11.873976
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.877234	2025-07-01 04:24:11.877234
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.880216	2025-07-01 04:24:11.880216
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.883644	2025-07-01 04:24:11.883644
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.886648	2025-07-01 04:24:11.886648
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.889718	2025-07-01 04:24:11.889718
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.892767	2025-07-01 04:24:11.892767
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.926643	2025-07-01 04:24:11.926643
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.929749	2025-07-01 04:24:11.929749
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.932881	2025-07-01 04:24:11.932881
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.935866	2025-07-01 04:24:11.935866
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.938624	2025-07-01 04:24:11.938624
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:11.983593	2025-07-01 04:24:11.983593
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.001764	2025-07-01 04:24:12.001764
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.013607	2025-07-01 04:24:12.013607
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.033752	2025-07-01 04:24:12.033752
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.073651	2025-07-01 04:24:12.073651
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.079342	2025-07-01 04:24:12.079342
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.084981	2025-07-01 04:24:12.084981
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.123725	2025-07-01 04:24:12.123725
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.133733	2025-07-01 04:24:12.133733
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.169571	2025-07-01 04:24:12.169571
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.183723	2025-07-01 04:24:12.183723
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.187276	2025-07-01 04:24:12.187276
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.223035	2025-07-01 04:24:12.223035
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.226986	2025-07-01 04:24:12.226986
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.230321	2025-07-01 04:24:12.230321
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.233779	2025-07-01 04:24:12.233779
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.269689	2025-07-01 04:24:12.269689
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.284855	2025-07-01 04:24:12.284855
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.322624	2025-07-01 04:24:12.322624
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.328441	2025-07-01 04:24:12.328441
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.331943	2025-07-01 04:24:12.331943
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.336153	2025-07-01 04:24:12.336153
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.339794	2025-07-01 04:24:12.339794
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.343973	2025-07-01 04:24:12.343973
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.350487	2025-07-01 04:24:12.350487
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.354393	2025-07-01 04:24:12.354393
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.357856	2025-07-01 04:24:12.357856
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.362011	2025-07-01 04:24:12.362011
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.365148	2025-07-01 04:24:12.365148
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.370243	2025-07-01 04:24:12.370243
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.373811	2025-07-01 04:24:12.373811
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.377293	2025-07-01 04:24:12.377293
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.413273	2025-07-01 04:24:12.413273
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.416909	2025-07-01 04:24:12.416909
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.420344	2025-07-01 04:24:12.420344
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.423757	2025-07-01 04:24:12.423757
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.427177	2025-07-01 04:24:12.427177
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.463322	2025-07-01 04:24:12.463322
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.470279	2025-07-01 04:24:12.470279
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.473885	2025-07-01 04:24:12.473885
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.508322	2025-07-01 04:24:12.508322
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.513385	2025-07-01 04:24:12.513385
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.517544	2025-07-01 04:24:12.517544
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.522163	2025-07-01 04:24:12.522163
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:24:12.525801	2025-07-01 04:24:12.525801
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.529744	2025-07-01 04:24:12.529744
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.533338	2025-07-01 04:24:12.533338
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.544012	2025-07-01 04:24:12.544012
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.549226	2025-07-01 04:24:12.549226
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.552551	2025-07-01 04:24:12.552551
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.556213	2025-07-01 04:24:12.556213
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.591057	2025-07-01 04:24:12.591057
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.599254	2025-07-01 04:24:12.599254
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.635525	2025-07-01 04:24:12.635525
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.64207	2025-07-01 04:24:12.64207
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.645737	2025-07-01 04:24:12.645737
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.649089	2025-07-01 04:24:12.649089
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.683349	2025-07-01 04:24:12.683349
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.687081	2025-07-01 04:24:12.687081
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.690662	2025-07-01 04:24:12.690662
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.695212	2025-07-01 04:24:12.695212
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.699005	2025-07-01 04:24:12.699005
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.702649	2025-07-01 04:24:12.702649
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.705836	2025-07-01 04:24:12.705836
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.710434	2025-07-01 04:24:12.710434
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.714018	2025-07-01 04:24:12.714018
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.717372	2025-07-01 04:24:12.717372
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.720992	2025-07-01 04:24:12.720992
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.724582	2025-07-01 04:24:12.724582
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.727695	2025-07-01 04:24:12.727695
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.730993	2025-07-01 04:24:12.730993
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.736084	2025-07-01 04:24:12.736084
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.770475	2025-07-01 04:24:12.770475
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.776067	2025-07-01 04:24:12.776067
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.781334	2025-07-01 04:24:12.781334
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.815597	2025-07-01 04:24:12.815597
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.819283	2025-07-01 04:24:12.819283
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.822693	2025-07-01 04:24:12.822693
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.826038	2025-07-01 04:24:12.826038
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.829514	2025-07-01 04:24:12.829514
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.863984	2025-07-01 04:24:12.863984
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.867784	2025-07-01 04:24:12.867784
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.871338	2025-07-01 04:24:12.871338
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.875113	2025-07-01 04:24:12.875113
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.878639	2025-07-01 04:24:12.878639
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.88179	2025-07-01 04:24:12.88179
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.916072	2025-07-01 04:24:12.916072
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.919318	2025-07-01 04:24:12.919318
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.923799	2025-07-01 04:24:12.923799
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.9273	2025-07-01 04:24:12.9273
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.931655	2025-07-01 04:24:12.931655
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.935172	2025-07-01 04:24:12.935172
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.938416	2025-07-01 04:24:12.938416
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.972763	2025-07-01 04:24:12.972763
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:12.982132	2025-07-01 04:24:12.982132
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.018135	2025-07-01 04:24:13.018135
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.023678	2025-07-01 04:24:13.023678
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.04296	2025-07-01 04:24:13.04296
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.079878	2025-07-01 04:24:13.079878
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.085614	2025-07-01 04:24:13.085614
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.091299	2025-07-01 04:24:13.091299
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.127506	2025-07-01 04:24:13.127506
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.13212	2025-07-01 04:24:13.13212
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.137294	2025-07-01 04:24:13.137294
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.175052	2025-07-01 04:24:13.175052
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.181511	2025-07-01 04:24:13.181511
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.187381	2025-07-01 04:24:13.187381
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.221549	2025-07-01 04:24:13.221549
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.227815	2025-07-01 04:24:13.227815
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.239793	2025-07-01 04:24:13.239793
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.266725	2025-07-01 04:24:13.266725
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.272047	2025-07-01 04:24:13.272047
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.277329	2025-07-01 04:24:13.277329
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.280826	2025-07-01 04:24:13.280826
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.284186	2025-07-01 04:24:13.284186
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.287528	2025-07-01 04:24:13.287528
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.290801	2025-07-01 04:24:13.290801
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.295509	2025-07-01 04:24:13.295509
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.299131	2025-07-01 04:24:13.299131
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.30262	2025-07-01 04:24:13.30262
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.307332	2025-07-01 04:24:13.307332
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.31227	2025-07-01 04:24:13.31227
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.317091	2025-07-01 04:24:13.317091
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.320538	2025-07-01 04:24:13.320538
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.323826	2025-07-01 04:24:13.323826
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.327185	2025-07-01 04:24:13.327185
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.330543	2025-07-01 04:24:13.330543
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.333935	2025-07-01 04:24:13.333935
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.339678	2025-07-01 04:24:13.339678
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.344725	2025-07-01 04:24:13.344725
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.349387	2025-07-01 04:24:13.349387
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.352763	2025-07-01 04:24:13.352763
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.356104	2025-07-01 04:24:13.356104
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.376765	2025-07-01 04:24:13.376765
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.382024	2025-07-01 04:24:13.382024
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.386776	2025-07-01 04:24:13.386776
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.391995	2025-07-01 04:24:13.391995
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.39563	2025-07-01 04:24:13.39563
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.430322	2025-07-01 04:24:13.430322
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.435138	2025-07-01 04:24:13.435138
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.438882	2025-07-01 04:24:13.438882
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.442297	2025-07-01 04:24:13.442297
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.445783	2025-07-01 04:24:13.445783
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.480368	2025-07-01 04:24:13.480368
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.483844	2025-07-01 04:24:13.483844
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.487066	2025-07-01 04:24:13.487066
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.490304	2025-07-01 04:24:13.490304
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.493719	2025-07-01 04:24:13.493719
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.497123	2025-07-01 04:24:13.497123
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.50049	2025-07-01 04:24:13.50049
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.505104	2025-07-01 04:24:13.505104
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.508189	2025-07-01 04:24:13.508189
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.511243	2025-07-01 04:24:13.511243
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.51458	2025-07-01 04:24:13.51458
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.518667	2025-07-01 04:24:13.518667
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.553105	2025-07-01 04:24:13.553105
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.561597	2025-07-01 04:24:13.561597
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.565478	2025-07-01 04:24:13.565478
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.569942	2025-07-01 04:24:13.569942
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.591338	2025-07-01 04:24:13.591338
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.59491	2025-07-01 04:24:13.59491
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.598281	2025-07-01 04:24:13.598281
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.601632	2025-07-01 04:24:13.601632
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.605681	2025-07-01 04:24:13.605681
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.640271	2025-07-01 04:24:13.640271
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.643777	2025-07-01 04:24:13.643777
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.647043	2025-07-01 04:24:13.647043
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.650443	2025-07-01 04:24:13.650443
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.653763	2025-07-01 04:24:13.653763
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.657141	2025-07-01 04:24:13.657141
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.660408	2025-07-01 04:24:13.660408
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.664335	2025-07-01 04:24:13.664335
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.668086	2025-07-01 04:24:13.668086
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.671463	2025-07-01 04:24:13.671463
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.674707	2025-07-01 04:24:13.674707
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.67843	2025-07-01 04:24:13.67843
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.682656	2025-07-01 04:24:13.682656
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.686478	2025-07-01 04:24:13.686478
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.690689	2025-07-01 04:24:13.690689
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.694382	2025-07-01 04:24:13.694382
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.698342	2025-07-01 04:24:13.698342
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.702069	2025-07-01 04:24:13.702069
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.706373	2025-07-01 04:24:13.706373
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.710604	2025-07-01 04:24:13.710604
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.745113	2025-07-01 04:24:13.745113
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.748741	2025-07-01 04:24:13.748741
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.752207	2025-07-01 04:24:13.752207
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.755761	2025-07-01 04:24:13.755761
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.760556	2025-07-01 04:24:13.760556
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.794983	2025-07-01 04:24:13.794983
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.798626	2025-07-01 04:24:13.798626
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.802254	2025-07-01 04:24:13.802254
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.805702	2025-07-01 04:24:13.805702
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.809347	2025-07-01 04:24:13.809347
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.812451	2025-07-01 04:24:13.812451
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.815477	2025-07-01 04:24:13.815477
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.843541	2025-07-01 04:24:13.843541
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.84708	2025-07-01 04:24:13.84708
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.85036	2025-07-01 04:24:13.85036
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.853719	2025-07-01 04:24:13.853719
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.856963	2025-07-01 04:24:13.856963
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.870854	2025-07-01 04:24:13.870854
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.874453	2025-07-01 04:24:13.874453
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.888803	2025-07-01 04:24:13.888803
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.89228	2025-07-01 04:24:13.89228
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.895983	2025-07-01 04:24:13.895983
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.918625	2025-07-01 04:24:13.918625
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.922838	2025-07-01 04:24:13.922838
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.926541	2025-07-01 04:24:13.926541
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.930056	2025-07-01 04:24:13.930056
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.933773	2025-07-01 04:24:13.933773
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.968066	2025-07-01 04:24:13.968066
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.971665	2025-07-01 04:24:13.971665
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.975046	2025-07-01 04:24:13.975046
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.979813	2025-07-01 04:24:13.979813
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.983795	2025-07-01 04:24:13.983795
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.987355	2025-07-01 04:24:13.987355
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.991127	2025-07-01 04:24:13.991127
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.994147	2025-07-01 04:24:13.994147
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:13.998517	2025-07-01 04:24:13.998517
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.002358	2025-07-01 04:24:14.002358
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.037813	2025-07-01 04:24:14.037813
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.041342	2025-07-01 04:24:14.041342
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.046032	2025-07-01 04:24:14.046032
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.050854	2025-07-01 04:24:14.050854
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.055512	2025-07-01 04:24:14.055512
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.059962	2025-07-01 04:24:14.059962
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.063619	2025-07-01 04:24:14.063619
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.097914	2025-07-01 04:24:14.097914
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.101945	2025-07-01 04:24:14.101945
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.106106	2025-07-01 04:24:14.106106
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.110446	2025-07-01 04:24:14.110446
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.147539	2025-07-01 04:24:14.147539
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.151318	2025-07-01 04:24:14.151318
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.154795	2025-07-01 04:24:14.154795
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.158204	2025-07-01 04:24:14.158204
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.161608	2025-07-01 04:24:14.161608
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.165098	2025-07-01 04:24:14.165098
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.200816	2025-07-01 04:24:14.200816
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.204494	2025-07-01 04:24:14.204494
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.20772	2025-07-01 04:24:14.20772
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.211053	2025-07-01 04:24:14.211053
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.214281	2025-07-01 04:24:14.214281
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.217326	2025-07-01 04:24:14.217326
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.220349	2025-07-01 04:24:14.220349
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.224055	2025-07-01 04:24:14.224055
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.227468	2025-07-01 04:24:14.227468
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.231812	2025-07-01 04:24:14.231812
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.23686	2025-07-01 04:24:14.23686
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.271203	2025-07-01 04:24:14.271203
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.274796	2025-07-01 04:24:14.274796
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.278233	2025-07-01 04:24:14.278233
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.282962	2025-07-01 04:24:14.282962
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.28791	2025-07-01 04:24:14.28791
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.322653	2025-07-01 04:24:14.322653
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.32629	2025-07-01 04:24:14.32629
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.329971	2025-07-01 04:24:14.329971
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.335679	2025-07-01 04:24:14.335679
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.338682	2025-07-01 04:24:14.338682
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.3417	2025-07-01 04:24:14.3417
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.344741	2025-07-01 04:24:14.344741
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.347685	2025-07-01 04:24:14.347685
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.350853	2025-07-01 04:24:14.350853
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.354933	2025-07-01 04:24:14.354933
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.391309	2025-07-01 04:24:14.391309
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.396764	2025-07-01 04:24:14.396764
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.400921	2025-07-01 04:24:14.400921
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.40539	2025-07-01 04:24:14.40539
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.409955	2025-07-01 04:24:14.409955
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.444354	2025-07-01 04:24:14.444354
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.448109	2025-07-01 04:24:14.448109
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.451832	2025-07-01 04:24:14.451832
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.460415	2025-07-01 04:24:14.460415
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.463864	2025-07-01 04:24:14.463864
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.498938	2025-07-01 04:24:14.498938
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.506319	2025-07-01 04:24:14.506319
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.511943	2025-07-01 04:24:14.511943
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.517724	2025-07-01 04:24:14.517724
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.523582	2025-07-01 04:24:14.523582
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.532537	2025-07-01 04:24:14.532537
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.539979	2025-07-01 04:24:14.539979
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.547554	2025-07-01 04:24:14.547554
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.553705	2025-07-01 04:24:14.553705
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.559876	2025-07-01 04:24:14.559876
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.566244	2025-07-01 04:24:14.566244
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.573228	2025-07-01 04:24:14.573228
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.579622	2025-07-01 04:24:14.579622
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.585374	2025-07-01 04:24:14.585374
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.592197	2025-07-01 04:24:14.592197
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.599234	2025-07-01 04:24:14.599234
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.605768	2025-07-01 04:24:14.605768
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.611893	2025-07-01 04:24:14.611893
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.617937	2025-07-01 04:24:14.617937
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.624633	2025-07-01 04:24:14.624633
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.631819	2025-07-01 04:24:14.631819
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.66803	2025-07-01 04:24:14.66803
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.675277	2025-07-01 04:24:14.675277
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.682015	2025-07-01 04:24:14.682015
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.688437	2025-07-01 04:24:14.688437
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.694827	2025-07-01 04:24:14.694827
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.700479	2025-07-01 04:24:14.700479
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.706308	2025-07-01 04:24:14.706308
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.712336	2025-07-01 04:24:14.712336
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.718045	2025-07-01 04:24:14.718045
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.724019	2025-07-01 04:24:14.724019
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.73011	2025-07-01 04:24:14.73011
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.735962	2025-07-01 04:24:14.735962
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.742463	2025-07-01 04:24:14.742463
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.748317	2025-07-01 04:24:14.748317
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.753994	2025-07-01 04:24:14.753994
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.760796	2025-07-01 04:24:14.760796
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.767428	2025-07-01 04:24:14.767428
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.774222	2025-07-01 04:24:14.774222
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.780263	2025-07-01 04:24:14.780263
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.786107	2025-07-01 04:24:14.786107
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.793204	2025-07-01 04:24:14.793204
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.799312	2025-07-01 04:24:14.799312
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.806124	2025-07-01 04:24:14.806124
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.812077	2025-07-01 04:24:14.812077
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.817809	2025-07-01 04:24:14.817809
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.823942	2025-07-01 04:24:14.823942
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.830062	2025-07-01 04:24:14.830062
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.83666	2025-07-01 04:24:14.83666
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.843907	2025-07-01 04:24:14.843907
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.849267	2025-07-01 04:24:14.849267
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.854747	2025-07-01 04:24:14.854747
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.860625	2025-07-01 04:24:14.860625
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.867651	2025-07-01 04:24:14.867651
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.873615	2025-07-01 04:24:14.873615
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.879892	2025-07-01 04:24:14.879892
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.88609	2025-07-01 04:24:14.88609
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.892421	2025-07-01 04:24:14.892421
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.901499	2025-07-01 04:24:14.901499
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.908127	2025-07-01 04:24:14.908127
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.915167	2025-07-01 04:24:14.915167
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.920772	2025-07-01 04:24:14.920772
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.927081	2025-07-01 04:24:14.927081
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.933584	2025-07-01 04:24:14.933584
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.940304	2025-07-01 04:24:14.940304
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.947093	2025-07-01 04:24:14.947093
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.953901	2025-07-01 04:24:14.953901
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.960273	2025-07-01 04:24:14.960273
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.965982	2025-07-01 04:24:14.965982
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.972107	2025-07-01 04:24:14.972107
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.978134	2025-07-01 04:24:14.978134
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.981368	2025-07-01 04:24:14.981368
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.984165	2025-07-01 04:24:14.984165
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.986995	2025-07-01 04:24:14.986995
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.989816	2025-07-01 04:24:14.989816
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.992798	2025-07-01 04:24:14.992798
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:14.997119	2025-07-01 04:24:14.997119
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.000768	2025-07-01 04:24:15.000768
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.004271	2025-07-01 04:24:15.004271
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.007514	2025-07-01 04:24:15.007514
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.010563	2025-07-01 04:24:15.010563
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.013933	2025-07-01 04:24:15.013933
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.017259	2025-07-01 04:24:15.017259
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.020644	2025-07-01 04:24:15.020644
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.023673	2025-07-01 04:24:15.023673
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.026646	2025-07-01 04:24:15.026646
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.030989	2025-07-01 04:24:15.030989
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.035589	2025-07-01 04:24:15.035589
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.039146	2025-07-01 04:24:15.039146
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.043211	2025-07-01 04:24:15.043211
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.046384	2025-07-01 04:24:15.046384
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.049632	2025-07-01 04:24:15.049632
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.052467	2025-07-01 04:24:15.052467
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.055261	2025-07-01 04:24:15.055261
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.058052	2025-07-01 04:24:15.058052
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.060924	2025-07-01 04:24:15.060924
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.063715	2025-07-01 04:24:15.063715
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.066504	2025-07-01 04:24:15.066504
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.073679	2025-07-01 04:24:15.073679
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.077115	2025-07-01 04:24:15.077115
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.080577	2025-07-01 04:24:15.080577
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.083626	2025-07-01 04:24:15.083626
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.086656	2025-07-01 04:24:15.086656
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.089738	2025-07-01 04:24:15.089738
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.092968	2025-07-01 04:24:15.092968
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.096411	2025-07-01 04:24:15.096411
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.099676	2025-07-01 04:24:15.099676
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.102622	2025-07-01 04:24:15.102622
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.105561	2025-07-01 04:24:15.105561
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.108612	2025-07-01 04:24:15.108612
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.111927	2025-07-01 04:24:15.111927
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.115021	2025-07-01 04:24:15.115021
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.118251	2025-07-01 04:24:15.118251
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.121126	2025-07-01 04:24:15.121126
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.12541	2025-07-01 04:24:15.12541
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.128929	2025-07-01 04:24:15.128929
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.131936	2025-07-01 04:24:15.131936
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.134694	2025-07-01 04:24:15.134694
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.137459	2025-07-01 04:24:15.137459
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.140275	2025-07-01 04:24:15.140275
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.143108	2025-07-01 04:24:15.143108
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.146169	2025-07-01 04:24:15.146169
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.149216	2025-07-01 04:24:15.149216
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.152231	2025-07-01 04:24:15.152231
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.15537	2025-07-01 04:24:15.15537
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.158787	2025-07-01 04:24:15.158787
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.16208	2025-07-01 04:24:15.16208
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.164976	2025-07-01 04:24:15.164976
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.169061	2025-07-01 04:24:15.169061
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.17252	2025-07-01 04:24:15.17252
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.175568	2025-07-01 04:24:15.175568
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.179321	2025-07-01 04:24:15.179321
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.18287	2025-07-01 04:24:15.18287
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.186424	2025-07-01 04:24:15.186424
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.220561	2025-07-01 04:24:15.220561
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.224062	2025-07-01 04:24:15.224062
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.227533	2025-07-01 04:24:15.227533
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.2308	2025-07-01 04:24:15.2308
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.234104	2025-07-01 04:24:15.234104
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.26484	2025-07-01 04:24:15.26484
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.272557	2025-07-01 04:24:15.272557
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.275582	2025-07-01 04:24:15.275582
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.278494	2025-07-01 04:24:15.278494
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.281556	2025-07-01 04:24:15.281556
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.284582	2025-07-01 04:24:15.284582
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.287513	2025-07-01 04:24:15.287513
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.290556	2025-07-01 04:24:15.290556
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.293626	2025-07-01 04:24:15.293626
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.297238	2025-07-01 04:24:15.297238
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.300185	2025-07-01 04:24:15.300185
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.303818	2025-07-01 04:24:15.303818
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.311038	2025-07-01 04:24:15.311038
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.319026	2025-07-01 04:24:15.319026
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.324226	2025-07-01 04:24:15.324226
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.327449	2025-07-01 04:24:15.327449
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.331537	2025-07-01 04:24:15.331537
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.334738	2025-07-01 04:24:15.334738
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.338348	2025-07-01 04:24:15.338348
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.341651	2025-07-01 04:24:15.341651
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.346299	2025-07-01 04:24:15.346299
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.349444	2025-07-01 04:24:15.349444
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.352956	2025-07-01 04:24:15.352956
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.35638	2025-07-01 04:24:15.35638
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.359557	2025-07-01 04:24:15.359557
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.363098	2025-07-01 04:24:15.363098
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.366752	2025-07-01 04:24:15.366752
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.370432	2025-07-01 04:24:15.370432
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.373415	2025-07-01 04:24:15.373415
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.37638	2025-07-01 04:24:15.37638
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.379428	2025-07-01 04:24:15.379428
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.382746	2025-07-01 04:24:15.382746
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.386547	2025-07-01 04:24:15.386547
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.390133	2025-07-01 04:24:15.390133
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.393496	2025-07-01 04:24:15.393496
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.398026	2025-07-01 04:24:15.398026
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.401039	2025-07-01 04:24:15.401039
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.404082	2025-07-01 04:24:15.404082
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.4072	2025-07-01 04:24:15.4072
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.410428	2025-07-01 04:24:15.410428
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.413788	2025-07-01 04:24:15.413788
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.416937	2025-07-01 04:24:15.416937
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.41994	2025-07-01 04:24:15.41994
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.423006	2025-07-01 04:24:15.423006
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.426062	2025-07-01 04:24:15.426062
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.430199	2025-07-01 04:24:15.430199
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.434677	2025-07-01 04:24:15.434677
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.437976	2025-07-01 04:24:15.437976
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.440897	2025-07-01 04:24:15.440897
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.443775	2025-07-01 04:24:15.443775
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.446805	2025-07-01 04:24:15.446805
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.450072	2025-07-01 04:24:15.450072
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.454344	2025-07-01 04:24:15.454344
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.457875	2025-07-01 04:24:15.457875
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.461266	2025-07-01 04:24:15.461266
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.464541	2025-07-01 04:24:15.464541
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.467685	2025-07-01 04:24:15.467685
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.471081	2025-07-01 04:24:15.471081
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.474221	2025-07-01 04:24:15.474221
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.47722	2025-07-01 04:24:15.47722
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.48039	2025-07-01 04:24:15.48039
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.483622	2025-07-01 04:24:15.483622
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.486968	2025-07-01 04:24:15.486968
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.489986	2025-07-01 04:24:15.489986
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.492946	2025-07-01 04:24:15.492946
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.496015	2025-07-01 04:24:15.496015
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.499224	2025-07-01 04:24:15.499224
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.502863	2025-07-01 04:24:15.502863
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.506971	2025-07-01 04:24:15.506971
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.510408	2025-07-01 04:24:15.510408
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.513817	2025-07-01 04:24:15.513817
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.517313	2025-07-01 04:24:15.517313
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.520306	2025-07-01 04:24:15.520306
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.523606	2025-07-01 04:24:15.523606
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.526572	2025-07-01 04:24:15.526572
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.530045	2025-07-01 04:24:15.530045
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.533192	2025-07-01 04:24:15.533192
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.536248	2025-07-01 04:24:15.536248
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.539281	2025-07-01 04:24:15.539281
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.542636	2025-07-01 04:24:15.542636
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.545599	2025-07-01 04:24:15.545599
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.548582	2025-07-01 04:24:15.548582
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.551782	2025-07-01 04:24:15.551782
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.555282	2025-07-01 04:24:15.555282
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.558701	2025-07-01 04:24:15.558701
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.561752	2025-07-01 04:24:15.561752
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.564753	2025-07-01 04:24:15.564753
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.567754	2025-07-01 04:24:15.567754
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.570905	2025-07-01 04:24:15.570905
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.57431	2025-07-01 04:24:15.57431
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.577547	2025-07-01 04:24:15.577547
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.580622	2025-07-01 04:24:15.580622
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.587075	2025-07-01 04:24:15.587075
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.590962	2025-07-01 04:24:15.590962
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.594032	2025-07-01 04:24:15.594032
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.597396	2025-07-01 04:24:15.597396
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.60077	2025-07-01 04:24:15.60077
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.604054	2025-07-01 04:24:15.604054
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.606929	2025-07-01 04:24:15.606929
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.610263	2025-07-01 04:24:15.610263
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.61327	2025-07-01 04:24:15.61327
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.616531	2025-07-01 04:24:15.616531
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.619439	2025-07-01 04:24:15.619439
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.622525	2025-07-01 04:24:15.622525
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.625574	2025-07-01 04:24:15.625574
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.628658	2025-07-01 04:24:15.628658
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.631862	2025-07-01 04:24:15.631862
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.635358	2025-07-01 04:24:15.635358
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.638606	2025-07-01 04:24:15.638606
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.64166	2025-07-01 04:24:15.64166
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.644657	2025-07-01 04:24:15.644657
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.647693	2025-07-01 04:24:15.647693
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.650843	2025-07-01 04:24:15.650843
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.654284	2025-07-01 04:24:15.654284
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.65808	2025-07-01 04:24:15.65808
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.662159	2025-07-01 04:24:15.662159
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.665581	2025-07-01 04:24:15.665581
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.668703	2025-07-01 04:24:15.668703
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.672844	2025-07-01 04:24:15.672844
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.676161	2025-07-01 04:24:15.676161
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.679205	2025-07-01 04:24:15.679205
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.682203	2025-07-01 04:24:15.682203
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.685644	2025-07-01 04:24:15.685644
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.688728	2025-07-01 04:24:15.688728
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.691648	2025-07-01 04:24:15.691648
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.694432	2025-07-01 04:24:15.694432
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.698496	2025-07-01 04:24:15.698496
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.70195	2025-07-01 04:24:15.70195
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.705077	2025-07-01 04:24:15.705077
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.708441	2025-07-01 04:24:15.708441
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.711278	2025-07-01 04:24:15.711278
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.714239	2025-07-01 04:24:15.714239
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.718512	2025-07-01 04:24:15.718512
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.722017	2025-07-01 04:24:15.722017
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.725261	2025-07-01 04:24:15.725261
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.728374	2025-07-01 04:24:15.728374
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.731262	2025-07-01 04:24:15.731262
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.73429	2025-07-01 04:24:15.73429
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.738568	2025-07-01 04:24:15.738568
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.742195	2025-07-01 04:24:15.742195
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.745253	2025-07-01 04:24:15.745253
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.748284	2025-07-01 04:24:15.748284
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.752453	2025-07-01 04:24:15.752453
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.756079	2025-07-01 04:24:15.756079
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.759348	2025-07-01 04:24:15.759348
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.762798	2025-07-01 04:24:15.762798
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.766057	2025-07-01 04:24:15.766057
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.769242	2025-07-01 04:24:15.769242
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.773519	2025-07-01 04:24:15.773519
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.777041	2025-07-01 04:24:15.777041
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.780213	2025-07-01 04:24:15.780213
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.783585	2025-07-01 04:24:15.783585
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.786639	2025-07-01 04:24:15.786639
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.789632	2025-07-01 04:24:15.789632
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.792847	2025-07-01 04:24:15.792847
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.796323	2025-07-01 04:24:15.796323
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.799667	2025-07-01 04:24:15.799667
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.80262	2025-07-01 04:24:15.80262
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.805651	2025-07-01 04:24:15.805651
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.808608	2025-07-01 04:24:15.808608
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.812264	2025-07-01 04:24:15.812264
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.815407	2025-07-01 04:24:15.815407
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.818566	2025-07-01 04:24:15.818566
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.822646	2025-07-01 04:24:15.822646
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.825969	2025-07-01 04:24:15.825969
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.829081	2025-07-01 04:24:15.829081
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.832136	2025-07-01 04:24:15.832136
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.835057	2025-07-01 04:24:15.835057
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.838124	2025-07-01 04:24:15.838124
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.841378	2025-07-01 04:24:15.841378
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.844734	2025-07-01 04:24:15.844734
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.849169	2025-07-01 04:24:15.849169
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.852766	2025-07-01 04:24:15.852766
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.855723	2025-07-01 04:24:15.855723
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.859793	2025-07-01 04:24:15.859793
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.863189	2025-07-01 04:24:15.863189
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.86622	2025-07-01 04:24:15.86622
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.869468	2025-07-01 04:24:15.869468
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.873079	2025-07-01 04:24:15.873079
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.876441	2025-07-01 04:24:15.876441
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.879641	2025-07-01 04:24:15.879641
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.882666	2025-07-01 04:24:15.882666
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.885706	2025-07-01 04:24:15.885706
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.888935	2025-07-01 04:24:15.888935
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:24:15.892625	2025-07-01 04:24:15.892625
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.895653	2025-07-01 04:24:15.895653
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.899029	2025-07-01 04:24:15.899029
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.902297	2025-07-01 04:24:15.902297
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.906067	2025-07-01 04:24:15.906067
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.909359	2025-07-01 04:24:15.909359
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.912359	2025-07-01 04:24:15.912359
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.915365	2025-07-01 04:24:15.915365
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.91856	2025-07-01 04:24:15.91856
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.92277	2025-07-01 04:24:15.92277
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.925778	2025-07-01 04:24:15.925778
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.928649	2025-07-01 04:24:15.928649
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.931585	2025-07-01 04:24:15.931585
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.934658	2025-07-01 04:24:15.934658
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.938133	2025-07-01 04:24:15.938133
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.941447	2025-07-01 04:24:15.941447
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.944487	2025-07-01 04:24:15.944487
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.947568	2025-07-01 04:24:15.947568
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.95057	2025-07-01 04:24:15.95057
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.953617	2025-07-01 04:24:15.953617
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.956668	2025-07-01 04:24:15.956668
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.960042	2025-07-01 04:24:15.960042
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.9632	2025-07-01 04:24:15.9632
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.96627	2025-07-01 04:24:15.96627
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.969346	2025-07-01 04:24:15.969346
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.973662	2025-07-01 04:24:15.973662
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.977067	2025-07-01 04:24:15.977067
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.980144	2025-07-01 04:24:15.980144
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.98326	2025-07-01 04:24:15.98326
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.987373	2025-07-01 04:24:15.987373
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.990844	2025-07-01 04:24:15.990844
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.994123	2025-07-01 04:24:15.994123
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:15.997196	2025-07-01 04:24:15.997196
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.000355	2025-07-01 04:24:16.000355
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.003281	2025-07-01 04:24:16.003281
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.006276	2025-07-01 04:24:16.006276
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.009581	2025-07-01 04:24:16.009581
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.013248	2025-07-01 04:24:16.013248
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.016209	2025-07-01 04:24:16.016209
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.02047	2025-07-01 04:24:16.02047
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.024792	2025-07-01 04:24:16.024792
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.027916	2025-07-01 04:24:16.027916
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.031388	2025-07-01 04:24:16.031388
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.03466	2025-07-01 04:24:16.03466
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.037637	2025-07-01 04:24:16.037637
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.040611	2025-07-01 04:24:16.040611
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.043571	2025-07-01 04:24:16.043571
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.046636	2025-07-01 04:24:16.046636
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.050038	2025-07-01 04:24:16.050038
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.053476	2025-07-01 04:24:16.053476
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.0569	2025-07-01 04:24:16.0569
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.060358	2025-07-01 04:24:16.060358
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.063772	2025-07-01 04:24:16.063772
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.066715	2025-07-01 04:24:16.066715
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.069656	2025-07-01 04:24:16.069656
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.072708	2025-07-01 04:24:16.072708
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.076209	2025-07-01 04:24:16.076209
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.079626	2025-07-01 04:24:16.079626
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.083204	2025-07-01 04:24:16.083204
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.086288	2025-07-01 04:24:16.086288
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.089433	2025-07-01 04:24:16.089433
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.093915	2025-07-01 04:24:16.093915
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.09759	2025-07-01 04:24:16.09759
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.100969	2025-07-01 04:24:16.100969
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.104223	2025-07-01 04:24:16.104223
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.107229	2025-07-01 04:24:16.107229
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.110205	2025-07-01 04:24:16.110205
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.114512	2025-07-01 04:24:16.114512
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.118261	2025-07-01 04:24:16.118261
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.121723	2025-07-01 04:24:16.121723
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.124886	2025-07-01 04:24:16.124886
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.127885	2025-07-01 04:24:16.127885
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.131163	2025-07-01 04:24:16.131163
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.135517	2025-07-01 04:24:16.135517
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.140441	2025-07-01 04:24:16.140441
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.144105	2025-07-01 04:24:16.144105
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.147262	2025-07-01 04:24:16.147262
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.150223	2025-07-01 04:24:16.150223
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.153245	2025-07-01 04:24:16.153245
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.156677	2025-07-01 04:24:16.156677
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.159906	2025-07-01 04:24:16.159906
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.163017	2025-07-01 04:24:16.163017
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.166059	2025-07-01 04:24:16.166059
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.169541	2025-07-01 04:24:16.169541
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.17298	2025-07-01 04:24:16.17298
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.176281	2025-07-01 04:24:16.176281
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.17941	2025-07-01 04:24:16.17941
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.182472	2025-07-01 04:24:16.182472
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.187205	2025-07-01 04:24:16.187205
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.191371	2025-07-01 04:24:16.191371
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.196119	2025-07-01 04:24:16.196119
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.1995	2025-07-01 04:24:16.1995
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.202558	2025-07-01 04:24:16.202558
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.205633	2025-07-01 04:24:16.205633
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.210028	2025-07-01 04:24:16.210028
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.214916	2025-07-01 04:24:16.214916
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.21965	2025-07-01 04:24:16.21965
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.224349	2025-07-01 04:24:16.224349
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.229194	2025-07-01 04:24:16.229194
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.234229	2025-07-01 04:24:16.234229
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.2391	2025-07-01 04:24:16.2391
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.243784	2025-07-01 04:24:16.243784
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.249321	2025-07-01 04:24:16.249321
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.253601	2025-07-01 04:24:16.253601
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.25676	2025-07-01 04:24:16.25676
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.259803	2025-07-01 04:24:16.259803
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.264019	2025-07-01 04:24:16.264019
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.26772	2025-07-01 04:24:16.26772
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.271617	2025-07-01 04:24:16.271617
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.274851	2025-07-01 04:24:16.274851
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.278129	2025-07-01 04:24:16.278129
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.281701	2025-07-01 04:24:16.281701
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.285663	2025-07-01 04:24:16.285663
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.289169	2025-07-01 04:24:16.289169
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.293517	2025-07-01 04:24:16.293517
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.298422	2025-07-01 04:24:16.298422
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.301777	2025-07-01 04:24:16.301777
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.305352	2025-07-01 04:24:16.305352
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.309003	2025-07-01 04:24:16.309003
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.312072	2025-07-01 04:24:16.312072
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.314943	2025-07-01 04:24:16.314943
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.317781	2025-07-01 04:24:16.317781
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.321851	2025-07-01 04:24:16.321851
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.326678	2025-07-01 04:24:16.326678
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.330335	2025-07-01 04:24:16.330335
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.333225	2025-07-01 04:24:16.333225
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.336243	2025-07-01 04:24:16.336243
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.341918	2025-07-01 04:24:16.341918
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.346551	2025-07-01 04:24:16.346551
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.350106	2025-07-01 04:24:16.350106
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.353815	2025-07-01 04:24:16.353815
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.357343	2025-07-01 04:24:16.357343
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.36168	2025-07-01 04:24:16.36168
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.365276	2025-07-01 04:24:16.365276
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.369072	2025-07-01 04:24:16.369072
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.372124	2025-07-01 04:24:16.372124
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.375394	2025-07-01 04:24:16.375394
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.378907	2025-07-01 04:24:16.378907
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.382066	2025-07-01 04:24:16.382066
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.385446	2025-07-01 04:24:16.385446
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.389103	2025-07-01 04:24:16.389103
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.392539	2025-07-01 04:24:16.392539
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.395909	2025-07-01 04:24:16.395909
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.399043	2025-07-01 04:24:16.399043
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.402233	2025-07-01 04:24:16.402233
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.405187	2025-07-01 04:24:16.405187
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.408344	2025-07-01 04:24:16.408344
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.412855	2025-07-01 04:24:16.412855
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.416625	2025-07-01 04:24:16.416625
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.420043	2025-07-01 04:24:16.420043
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.423482	2025-07-01 04:24:16.423482
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.426504	2025-07-01 04:24:16.426504
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.429619	2025-07-01 04:24:16.429619
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.436287	2025-07-01 04:24:16.436287
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.441229	2025-07-01 04:24:16.441229
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.444873	2025-07-01 04:24:16.444873
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.448257	2025-07-01 04:24:16.448257
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.451785	2025-07-01 04:24:16.451785
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.454851	2025-07-01 04:24:16.454851
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.458216	2025-07-01 04:24:16.458216
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.461415	2025-07-01 04:24:16.461415
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.464715	2025-07-01 04:24:16.464715
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.468008	2025-07-01 04:24:16.468008
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.471368	2025-07-01 04:24:16.471368
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.474373	2025-07-01 04:24:16.474373
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.477552	2025-07-01 04:24:16.477552
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.481542	2025-07-01 04:24:16.481542
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.496068	2025-07-01 04:24:16.496068
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.49935	2025-07-01 04:24:16.49935
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.502583	2025-07-01 04:24:16.502583
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.505597	2025-07-01 04:24:16.505597
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.510279	2025-07-01 04:24:16.510279
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.515113	2025-07-01 04:24:16.515113
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.520046	2025-07-01 04:24:16.520046
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.523627	2025-07-01 04:24:16.523627
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.5274	2025-07-01 04:24:16.5274
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.5309	2025-07-01 04:24:16.5309
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.534063	2025-07-01 04:24:16.534063
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.537487	2025-07-01 04:24:16.537487
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.542194	2025-07-01 04:24:16.542194
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.545518	2025-07-01 04:24:16.545518
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.549347	2025-07-01 04:24:16.549347
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.55291	2025-07-01 04:24:16.55291
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.55615	2025-07-01 04:24:16.55615
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.559454	2025-07-01 04:24:16.559454
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.562349	2025-07-01 04:24:16.562349
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.56579	2025-07-01 04:24:16.56579
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.568879	2025-07-01 04:24:16.568879
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.57192	2025-07-01 04:24:16.57192
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.574726	2025-07-01 04:24:16.574726
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.57762	2025-07-01 04:24:16.57762
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.581198	2025-07-01 04:24:16.581198
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.584515	2025-07-01 04:24:16.584515
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.587598	2025-07-01 04:24:16.587598
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.591813	2025-07-01 04:24:16.591813
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.596886	2025-07-01 04:24:16.596886
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.601719	2025-07-01 04:24:16.601719
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.605112	2025-07-01 04:24:16.605112
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.608035	2025-07-01 04:24:16.608035
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.613012	2025-07-01 04:24:16.613012
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.616034	2025-07-01 04:24:16.616034
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.619147	2025-07-01 04:24:16.619147
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.622373	2025-07-01 04:24:16.622373
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.625426	2025-07-01 04:24:16.625426
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.628556	2025-07-01 04:24:16.628556
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.636095	2025-07-01 04:24:16.636095
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.639056	2025-07-01 04:24:16.639056
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.643115	2025-07-01 04:24:16.643115
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.646397	2025-07-01 04:24:16.646397
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.64963	2025-07-01 04:24:16.64963
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.652631	2025-07-01 04:24:16.652631
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.655564	2025-07-01 04:24:16.655564
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.65862	2025-07-01 04:24:16.65862
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.662319	2025-07-01 04:24:16.662319
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.665602	2025-07-01 04:24:16.665602
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.668556	2025-07-01 04:24:16.668556
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.671716	2025-07-01 04:24:16.671716
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.674942	2025-07-01 04:24:16.674942
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.677941	2025-07-01 04:24:16.677941
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.680978	2025-07-01 04:24:16.680978
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.683869	2025-07-01 04:24:16.683869
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.686946	2025-07-01 04:24:16.686946
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.690738	2025-07-01 04:24:16.690738
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.694233	2025-07-01 04:24:16.694233
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.697783	2025-07-01 04:24:16.697783
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.701335	2025-07-01 04:24:16.701335
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.704939	2025-07-01 04:24:16.704939
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.708633	2025-07-01 04:24:16.708633
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.712208	2025-07-01 04:24:16.712208
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.715241	2025-07-01 04:24:16.715241
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.718387	2025-07-01 04:24:16.718387
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.722076	2025-07-01 04:24:16.722076
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.725777	2025-07-01 04:24:16.725777
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.729342	2025-07-01 04:24:16.729342
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.732521	2025-07-01 04:24:16.732521
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.735906	2025-07-01 04:24:16.735906
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.739279	2025-07-01 04:24:16.739279
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.742647	2025-07-01 04:24:16.742647
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.745668	2025-07-01 04:24:16.745668
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.748883	2025-07-01 04:24:16.748883
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.753186	2025-07-01 04:24:16.753186
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.756935	2025-07-01 04:24:16.756935
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.760671	2025-07-01 04:24:16.760671
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.764172	2025-07-01 04:24:16.764172
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.771841	2025-07-01 04:24:16.771841
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.775575	2025-07-01 04:24:16.775575
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.780063	2025-07-01 04:24:16.780063
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.78373	2025-07-01 04:24:16.78373
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.786903	2025-07-01 04:24:16.786903
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.790109	2025-07-01 04:24:16.790109
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.793646	2025-07-01 04:24:16.793646
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.797321	2025-07-01 04:24:16.797321
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.800476	2025-07-01 04:24:16.800476
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.803739	2025-07-01 04:24:16.803739
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.806527	2025-07-01 04:24:16.806527
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.809415	2025-07-01 04:24:16.809415
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.812317	2025-07-01 04:24:16.812317
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.815334	2025-07-01 04:24:16.815334
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.818868	2025-07-01 04:24:16.818868
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.822355	2025-07-01 04:24:16.822355
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.826036	2025-07-01 04:24:16.826036
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.829165	2025-07-01 04:24:16.829165
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.832748	2025-07-01 04:24:16.832748
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.836293	2025-07-01 04:24:16.836293
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.839807	2025-07-01 04:24:16.839807
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.843108	2025-07-01 04:24:16.843108
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.846409	2025-07-01 04:24:16.846409
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.850058	2025-07-01 04:24:16.850058
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.853521	2025-07-01 04:24:16.853521
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.856968	2025-07-01 04:24:16.856968
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.861643	2025-07-01 04:24:16.861643
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.865094	2025-07-01 04:24:16.865094
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.86916	2025-07-01 04:24:16.86916
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.87315	2025-07-01 04:24:16.87315
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.876662	2025-07-01 04:24:16.876662
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.880392	2025-07-01 04:24:16.880392
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.88382	2025-07-01 04:24:16.88382
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.888492	2025-07-01 04:24:16.888492
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.892931	2025-07-01 04:24:16.892931
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.896862	2025-07-01 04:24:16.896862
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.900374	2025-07-01 04:24:16.900374
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.903552	2025-07-01 04:24:16.903552
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.906645	2025-07-01 04:24:16.906645
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.909903	2025-07-01 04:24:16.909903
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.922525	2025-07-01 04:24:16.922525
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.927496	2025-07-01 04:24:16.927496
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.932317	2025-07-01 04:24:16.932317
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.935617	2025-07-01 04:24:16.935617
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.939025	2025-07-01 04:24:16.939025
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.942408	2025-07-01 04:24:16.942408
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.945571	2025-07-01 04:24:16.945571
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.949356	2025-07-01 04:24:16.949356
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.952873	2025-07-01 04:24:16.952873
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.956344	2025-07-01 04:24:16.956344
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.959693	2025-07-01 04:24:16.959693
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.963047	2025-07-01 04:24:16.963047
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.976988	2025-07-01 04:24:16.976988
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.982356	2025-07-01 04:24:16.982356
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.989813	2025-07-01 04:24:16.989813
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.995009	2025-07-01 04:24:16.995009
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:16.999377	2025-07-01 04:24:16.999377
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.002814	2025-07-01 04:24:17.002814
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.007975	2025-07-01 04:24:17.007975
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.011365	2025-07-01 04:24:17.011365
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.014284	2025-07-01 04:24:17.014284
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.017444	2025-07-01 04:24:17.017444
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.020891	2025-07-01 04:24:17.020891
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.024404	2025-07-01 04:24:17.024404
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.027253	2025-07-01 04:24:17.027253
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.030088	2025-07-01 04:24:17.030088
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.033037	2025-07-01 04:24:17.033037
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.036396	2025-07-01 04:24:17.036396
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.040624	2025-07-01 04:24:17.040624
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.093562	2025-07-01 04:24:17.093562
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.101547	2025-07-01 04:24:17.101547
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.106294	2025-07-01 04:24:17.106294
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.111126	2025-07-01 04:24:17.111126
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.116435	2025-07-01 04:24:17.116435
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.119764	2025-07-01 04:24:17.119764
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.123109	2025-07-01 04:24:17.123109
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.127422	2025-07-01 04:24:17.127422
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.131204	2025-07-01 04:24:17.131204
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.134762	2025-07-01 04:24:17.134762
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.138273	2025-07-01 04:24:17.138273
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.142886	2025-07-01 04:24:17.142886
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.145714	2025-07-01 04:24:17.145714
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.148981	2025-07-01 04:24:17.148981
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.153387	2025-07-01 04:24:17.153387
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.157058	2025-07-01 04:24:17.157058
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.160545	2025-07-01 04:24:17.160545
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.165524	2025-07-01 04:24:17.165524
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.168841	2025-07-01 04:24:17.168841
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.172063	2025-07-01 04:24:17.172063
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.175351	2025-07-01 04:24:17.175351
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.178298	2025-07-01 04:24:17.178298
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.181346	2025-07-01 04:24:17.181346
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.184699	2025-07-01 04:24:17.184699
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.188154	2025-07-01 04:24:17.188154
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.191042	2025-07-01 04:24:17.191042
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.193712	2025-07-01 04:24:17.193712
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.19697	2025-07-01 04:24:17.19697
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.200344	2025-07-01 04:24:17.200344
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.203643	2025-07-01 04:24:17.203643
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.207148	2025-07-01 04:24:17.207148
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.211075	2025-07-01 04:24:17.211075
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.214209	2025-07-01 04:24:17.214209
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.21764	2025-07-01 04:24:17.21764
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.220811	2025-07-01 04:24:17.220811
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.224226	2025-07-01 04:24:17.224226
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.2285	2025-07-01 04:24:17.2285
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.231655	2025-07-01 04:24:17.231655
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.234714	2025-07-01 04:24:17.234714
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.238603	2025-07-01 04:24:17.238603
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.241755	2025-07-01 04:24:17.241755
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.244416	2025-07-01 04:24:17.244416
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.247272	2025-07-01 04:24:17.247272
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.250342	2025-07-01 04:24:17.250342
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.253679	2025-07-01 04:24:17.253679
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.256962	2025-07-01 04:24:17.256962
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.260196	2025-07-01 04:24:17.260196
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.263393	2025-07-01 04:24:17.263393
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.266513	2025-07-01 04:24:17.266513
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.270245	2025-07-01 04:24:17.270245
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.273395	2025-07-01 04:24:17.273395
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.276224	2025-07-01 04:24:17.276224
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.279189	2025-07-01 04:24:17.279189
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.282355	2025-07-01 04:24:17.282355
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.285904	2025-07-01 04:24:17.285904
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.290833	2025-07-01 04:24:17.290833
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.294455	2025-07-01 04:24:17.294455
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.297815	2025-07-01 04:24:17.297815
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.302093	2025-07-01 04:24:17.302093
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.305741	2025-07-01 04:24:17.305741
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.309172	2025-07-01 04:24:17.309172
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.313971	2025-07-01 04:24:17.313971
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.318267	2025-07-01 04:24:17.318267
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.321938	2025-07-01 04:24:17.321938
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.325308	2025-07-01 04:24:17.325308
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.330153	2025-07-01 04:24:17.330153
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.333345	2025-07-01 04:24:17.333345
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.33664	2025-07-01 04:24:17.33664
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.339863	2025-07-01 04:24:17.339863
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.342873	2025-07-01 04:24:17.342873
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.346639	2025-07-01 04:24:17.346639
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.349812	2025-07-01 04:24:17.349812
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.352686	2025-07-01 04:24:17.352686
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.355639	2025-07-01 04:24:17.355639
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.358891	2025-07-01 04:24:17.358891
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.362539	2025-07-01 04:24:17.362539
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.365758	2025-07-01 04:24:17.365758
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.369211	2025-07-01 04:24:17.369211
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.372526	2025-07-01 04:24:17.372526
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.375653	2025-07-01 04:24:17.375653
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.378788	2025-07-01 04:24:17.378788
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.381909	2025-07-01 04:24:17.381909
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.385633	2025-07-01 04:24:17.385633
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.389005	2025-07-01 04:24:17.389005
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.392393	2025-07-01 04:24:17.392393
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.399346	2025-07-01 04:24:17.399346
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.404202	2025-07-01 04:24:17.404202
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:24:17.409012	2025-07-01 04:24:17.409012
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.411992	2025-07-01 04:24:17.411992
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.41759	2025-07-01 04:24:17.41759
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.422171	2025-07-01 04:24:17.422171
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.425414	2025-07-01 04:24:17.425414
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.430522	2025-07-01 04:24:17.430522
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.436391	2025-07-01 04:24:17.436391
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.439266	2025-07-01 04:24:17.439266
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.443187	2025-07-01 04:24:17.443187
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.446461	2025-07-01 04:24:17.446461
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.449972	2025-07-01 04:24:17.449972
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.453042	2025-07-01 04:24:17.453042
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.455931	2025-07-01 04:24:17.455931
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.458827	2025-07-01 04:24:17.458827
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.462745	2025-07-01 04:24:17.462745
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.466307	2025-07-01 04:24:17.466307
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.469537	2025-07-01 04:24:17.469537
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.472385	2025-07-01 04:24:17.472385
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.47538	2025-07-01 04:24:17.47538
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.478546	2025-07-01 04:24:17.478546
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.481777	2025-07-01 04:24:17.481777
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.486197	2025-07-01 04:24:17.486197
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.490616	2025-07-01 04:24:17.490616
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.494876	2025-07-01 04:24:17.494876
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.497823	2025-07-01 04:24:17.497823
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.500914	2025-07-01 04:24:17.500914
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.503755	2025-07-01 04:24:17.503755
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.506698	2025-07-01 04:24:17.506698
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.509872	2025-07-01 04:24:17.509872
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.513094	2025-07-01 04:24:17.513094
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.517565	2025-07-01 04:24:17.517565
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.523298	2025-07-01 04:24:17.523298
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.528869	2025-07-01 04:24:17.528869
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.532032	2025-07-01 04:24:17.532032
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.536619	2025-07-01 04:24:17.536619
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.539696	2025-07-01 04:24:17.539696
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.543231	2025-07-01 04:24:17.543231
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.546622	2025-07-01 04:24:17.546622
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.550279	2025-07-01 04:24:17.550279
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.553256	2025-07-01 04:24:17.553256
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.556222	2025-07-01 04:24:17.556222
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.559255	2025-07-01 04:24:17.559255
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.562183	2025-07-01 04:24:17.562183
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.565332	2025-07-01 04:24:17.565332
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.568999	2025-07-01 04:24:17.568999
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.573145	2025-07-01 04:24:17.573145
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.575997	2025-07-01 04:24:17.575997
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.579037	2025-07-01 04:24:17.579037
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.584498	2025-07-01 04:24:17.584498
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.588144	2025-07-01 04:24:17.588144
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.591714	2025-07-01 04:24:17.591714
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.59513	2025-07-01 04:24:17.59513
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.598273	2025-07-01 04:24:17.598273
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.601814	2025-07-01 04:24:17.601814
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.605289	2025-07-01 04:24:17.605289
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.608698	2025-07-01 04:24:17.608698
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.611711	2025-07-01 04:24:17.611711
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.614774	2025-07-01 04:24:17.614774
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.618845	2025-07-01 04:24:17.618845
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.622322	2025-07-01 04:24:17.622322
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.625467	2025-07-01 04:24:17.625467
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.628994	2025-07-01 04:24:17.628994
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.632342	2025-07-01 04:24:17.632342
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.635379	2025-07-01 04:24:17.635379
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.638697	2025-07-01 04:24:17.638697
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.641706	2025-07-01 04:24:17.641706
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.645318	2025-07-01 04:24:17.645318
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.648921	2025-07-01 04:24:17.648921
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.651991	2025-07-01 04:24:17.651991
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.654962	2025-07-01 04:24:17.654962
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.658076	2025-07-01 04:24:17.658076
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.661527	2025-07-01 04:24:17.661527
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.665237	2025-07-01 04:24:17.665237
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.668751	2025-07-01 04:24:17.668751
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.672068	2025-07-01 04:24:17.672068
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.67653	2025-07-01 04:24:17.67653
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.680216	2025-07-01 04:24:17.680216
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.683547	2025-07-01 04:24:17.683547
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.686942	2025-07-01 04:24:17.686942
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.690202	2025-07-01 04:24:17.690202
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.694566	2025-07-01 04:24:17.694566
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.698202	2025-07-01 04:24:17.698202
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.70163	2025-07-01 04:24:17.70163
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.705113	2025-07-01 04:24:17.705113
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.708417	2025-07-01 04:24:17.708417
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.711725	2025-07-01 04:24:17.711725
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.71612	2025-07-01 04:24:17.71612
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.719714	2025-07-01 04:24:17.719714
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.722887	2025-07-01 04:24:17.722887
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.725843	2025-07-01 04:24:17.725843
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.728978	2025-07-01 04:24:17.728978
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.73201	2025-07-01 04:24:17.73201
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.735798	2025-07-01 04:24:17.735798
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.739934	2025-07-01 04:24:17.739934
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.743188	2025-07-01 04:24:17.743188
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.74659	2025-07-01 04:24:17.74659
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.750219	2025-07-01 04:24:17.750219
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.754674	2025-07-01 04:24:17.754674
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.758103	2025-07-01 04:24:17.758103
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.761913	2025-07-01 04:24:17.761913
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.769067	2025-07-01 04:24:17.769067
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.772714	2025-07-01 04:24:17.772714
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.776249	2025-07-01 04:24:17.776249
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.77941	2025-07-01 04:24:17.77941
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.782631	2025-07-01 04:24:17.782631
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.785598	2025-07-01 04:24:17.785598
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.789561	2025-07-01 04:24:17.789561
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.792877	2025-07-01 04:24:17.792877
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.796378	2025-07-01 04:24:17.796378
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.799719	2025-07-01 04:24:17.799719
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.803079	2025-07-01 04:24:17.803079
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.806689	2025-07-01 04:24:17.806689
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.810162	2025-07-01 04:24:17.810162
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.813212	2025-07-01 04:24:17.813212
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.81757	2025-07-01 04:24:17.81757
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.821326	2025-07-01 04:24:17.821326
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.825117	2025-07-01 04:24:17.825117
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.828774	2025-07-01 04:24:17.828774
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.832016	2025-07-01 04:24:17.832016
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.8355	2025-07-01 04:24:17.8355
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.83977	2025-07-01 04:24:17.83977
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.843239	2025-07-01 04:24:17.843239
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.84639	2025-07-01 04:24:17.84639
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.849999	2025-07-01 04:24:17.849999
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.85361	2025-07-01 04:24:17.85361
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.858167	2025-07-01 04:24:17.858167
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.861325	2025-07-01 04:24:17.861325
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.864858	2025-07-01 04:24:17.864858
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.869308	2025-07-01 04:24:17.869308
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.873378	2025-07-01 04:24:17.873378
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.876877	2025-07-01 04:24:17.876877
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.879994	2025-07-01 04:24:17.879994
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.883412	2025-07-01 04:24:17.883412
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.888122	2025-07-01 04:24:17.888122
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.892125	2025-07-01 04:24:17.892125
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.895492	2025-07-01 04:24:17.895492
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.909689	2025-07-01 04:24:17.909689
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.91297	2025-07-01 04:24:17.91297
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.916164	2025-07-01 04:24:17.916164
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.919603	2025-07-01 04:24:17.919603
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.92437	2025-07-01 04:24:17.92437
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.928926	2025-07-01 04:24:17.928926
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.963388	2025-07-01 04:24:17.963388
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.96677	2025-07-01 04:24:17.96677
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.970239	2025-07-01 04:24:17.970239
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.973806	2025-07-01 04:24:17.973806
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:17.976835	2025-07-01 04:24:17.976835
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.013002	2025-07-01 04:24:18.013002
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.016788	2025-07-01 04:24:18.016788
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.02043	2025-07-01 04:24:18.02043
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.023444	2025-07-01 04:24:18.023444
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.026368	2025-07-01 04:24:18.026368
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.030834	2025-07-01 04:24:18.030834
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.034686	2025-07-01 04:24:18.034686
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.038382	2025-07-01 04:24:18.038382
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.042138	2025-07-01 04:24:18.042138
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.047875	2025-07-01 04:24:18.047875
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.083195	2025-07-01 04:24:18.083195
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.08678	2025-07-01 04:24:18.08678
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.090059	2025-07-01 04:24:18.090059
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.093427	2025-07-01 04:24:18.093427
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.096935	2025-07-01 04:24:18.096935
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.100983	2025-07-01 04:24:18.100983
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.138481	2025-07-01 04:24:18.138481
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.143533	2025-07-01 04:24:18.143533
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.150627	2025-07-01 04:24:18.150627
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.189823	2025-07-01 04:24:18.189823
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.196777	2025-07-01 04:24:18.196777
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.20009	2025-07-01 04:24:18.20009
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.203474	2025-07-01 04:24:18.203474
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.238829	2025-07-01 04:24:18.238829
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.258191	2025-07-01 04:24:18.258191
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.295449	2025-07-01 04:24:18.295449
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.302822	2025-07-01 04:24:18.302822
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.307142	2025-07-01 04:24:18.307142
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.310599	2025-07-01 04:24:18.310599
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.314261	2025-07-01 04:24:18.314261
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.317469	2025-07-01 04:24:18.317469
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.320991	2025-07-01 04:24:18.320991
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.324548	2025-07-01 04:24:18.324548
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.328166	2025-07-01 04:24:18.328166
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.331505	2025-07-01 04:24:18.331505
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.335012	2025-07-01 04:24:18.335012
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.338556	2025-07-01 04:24:18.338556
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.342101	2025-07-01 04:24:18.342101
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.346952	2025-07-01 04:24:18.346952
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.350301	2025-07-01 04:24:18.350301
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.353478	2025-07-01 04:24:18.353478
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.388867	2025-07-01 04:24:18.388867
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.392372	2025-07-01 04:24:18.392372
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.398229	2025-07-01 04:24:18.398229
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.401767	2025-07-01 04:24:18.401767
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.439079	2025-07-01 04:24:18.439079
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.44485	2025-07-01 04:24:18.44485
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.448233	2025-07-01 04:24:18.448233
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.452235	2025-07-01 04:24:18.452235
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.489604	2025-07-01 04:24:18.489604
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.495073	2025-07-01 04:24:18.495073
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.49917	2025-07-01 04:24:18.49917
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.504073	2025-07-01 04:24:18.504073
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.511627	2025-07-01 04:24:18.511627
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.516923	2025-07-01 04:24:18.516923
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.521899	2025-07-01 04:24:18.521899
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.559691	2025-07-01 04:24:18.559691
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.564844	2025-07-01 04:24:18.564844
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.568347	2025-07-01 04:24:18.568347
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.604342	2025-07-01 04:24:18.604342
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.611676	2025-07-01 04:24:18.611676
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.618991	2025-07-01 04:24:18.618991
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.626325	2025-07-01 04:24:18.626325
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.631368	2025-07-01 04:24:18.631368
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.638234	2025-07-01 04:24:18.638234
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.675373	2025-07-01 04:24:18.675373
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.680659	2025-07-01 04:24:18.680659
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.686201	2025-07-01 04:24:18.686201
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.72406	2025-07-01 04:24:18.72406
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.728976	2025-07-01 04:24:18.728976
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.766034	2025-07-01 04:24:18.766034
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.775312	2025-07-01 04:24:18.775312
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.785234	2025-07-01 04:24:18.785234
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.795616	2025-07-01 04:24:18.795616
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.805752	2025-07-01 04:24:18.805752
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.818612	2025-07-01 04:24:18.818612
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.827753	2025-07-01 04:24:18.827753
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.83696	2025-07-01 04:24:18.83696
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.845415	2025-07-01 04:24:18.845415
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.888304	2025-07-01 04:24:18.888304
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.902349	2025-07-01 04:24:18.902349
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.914959	2025-07-01 04:24:18.914959
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.956943	2025-07-01 04:24:18.956943
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.973423	2025-07-01 04:24:18.973423
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.980611	2025-07-01 04:24:18.980611
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.988043	2025-07-01 04:24:18.988043
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:18.997547	2025-07-01 04:24:18.997547
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.038187	2025-07-01 04:24:19.038187
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.219126	2025-07-01 04:24:19.219126
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.270246	2025-07-01 04:24:19.270246
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.284618	2025-07-01 04:24:19.284618
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.299115	2025-07-01 04:24:19.299115
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.316821	2025-07-01 04:24:19.316821
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.33811	2025-07-01 04:24:19.33811
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.358923	2025-07-01 04:24:19.358923
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.368667	2025-07-01 04:24:19.368667
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.380013	2025-07-01 04:24:19.380013
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.400869	2025-07-01 04:24:19.400869
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.424333	2025-07-01 04:24:19.424333
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.443621	2025-07-01 04:24:19.443621
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.46501	2025-07-01 04:24:19.46501
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.485079	2025-07-01 04:24:19.485079
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.521524	2025-07-01 04:24:19.521524
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.527302	2025-07-01 04:24:19.527302
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.533662	2025-07-01 04:24:19.533662
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.554241	2025-07-01 04:24:19.554241
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.559687	2025-07-01 04:24:19.559687
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.565705	2025-07-01 04:24:19.565705
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.588634	2025-07-01 04:24:19.588634
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.594134	2025-07-01 04:24:19.594134
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.597761	2025-07-01 04:24:19.597761
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.632327	2025-07-01 04:24:19.632327
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.637969	2025-07-01 04:24:19.637969
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.642876	2025-07-01 04:24:19.642876
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.678141	2025-07-01 04:24:19.678141
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.681627	2025-07-01 04:24:19.681627
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.685042	2025-07-01 04:24:19.685042
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.688397	2025-07-01 04:24:19.688397
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.691726	2025-07-01 04:24:19.691726
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.695002	2025-07-01 04:24:19.695002
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.698267	2025-07-01 04:24:19.698267
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.704537	2025-07-01 04:24:19.704537
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.709485	2025-07-01 04:24:19.709485
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.712727	2025-07-01 04:24:19.712727
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.745191	2025-07-01 04:24:19.745191
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.751567	2025-07-01 04:24:19.751567
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.758996	2025-07-01 04:24:19.758996
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.798066	2025-07-01 04:24:19.798066
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.803737	2025-07-01 04:24:19.803737
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.809898	2025-07-01 04:24:19.809898
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.848869	2025-07-01 04:24:19.848869
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.856987	2025-07-01 04:24:19.856987
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.863495	2025-07-01 04:24:19.863495
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.901505	2025-07-01 04:24:19.901505
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.906872	2025-07-01 04:24:19.906872
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.914009	2025-07-01 04:24:19.914009
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.923913	2025-07-01 04:24:19.923913
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.962664	2025-07-01 04:24:19.962664
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.970377	2025-07-01 04:24:19.970377
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:19.976235	2025-07-01 04:24:19.976235
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.01361	2025-07-01 04:24:20.01361
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.019619	2025-07-01 04:24:20.019619
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.026039	2025-07-01 04:24:20.026039
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.035124	2025-07-01 04:24:20.035124
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.03902	2025-07-01 04:24:20.03902
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.042286	2025-07-01 04:24:20.042286
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.046788	2025-07-01 04:24:20.046788
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.051574	2025-07-01 04:24:20.051574
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.055195	2025-07-01 04:24:20.055195
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.090538	2025-07-01 04:24:20.090538
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.096355	2025-07-01 04:24:20.096355
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.101381	2025-07-01 04:24:20.101381
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.104846	2025-07-01 04:24:20.104846
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.14166	2025-07-01 04:24:20.14166
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.153561	2025-07-01 04:24:20.153561
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.19281	2025-07-01 04:24:20.19281
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.200238	2025-07-01 04:24:20.200238
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.234758	2025-07-01 04:24:20.234758
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.242379	2025-07-01 04:24:20.242379
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.247934	2025-07-01 04:24:20.247934
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.253258	2025-07-01 04:24:20.253258
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.270673	2025-07-01 04:24:20.270673
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.276125	2025-07-01 04:24:20.276125
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.28134	2025-07-01 04:24:20.28134
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.288707	2025-07-01 04:24:20.288707
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.298973	2025-07-01 04:24:20.298973
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.305443	2025-07-01 04:24:20.305443
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.312241	2025-07-01 04:24:20.312241
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.31846	2025-07-01 04:24:20.31846
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.324685	2025-07-01 04:24:20.324685
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.331424	2025-07-01 04:24:20.331424
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.429246	2025-07-01 04:24:20.429246
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.453019	2025-07-01 04:24:20.453019
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.470333	2025-07-01 04:24:20.470333
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.480942	2025-07-01 04:24:20.480942
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.490484	2025-07-01 04:24:20.490484
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.501606	2025-07-01 04:24:20.501606
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.508935	2025-07-01 04:24:20.508935
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.516208	2025-07-01 04:24:20.516208
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.52171	2025-07-01 04:24:20.52171
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.527137	2025-07-01 04:24:20.527137
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.533089	2025-07-01 04:24:20.533089
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.540539	2025-07-01 04:24:20.540539
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.543741	2025-07-01 04:24:20.543741
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.546765	2025-07-01 04:24:20.546765
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.549739	2025-07-01 04:24:20.549739
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.552868	2025-07-01 04:24:20.552868
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.556096	2025-07-01 04:24:20.556096
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.559133	2025-07-01 04:24:20.559133
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.563054	2025-07-01 04:24:20.563054
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.566271	2025-07-01 04:24:20.566271
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.569605	2025-07-01 04:24:20.569605
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.572753	2025-07-01 04:24:20.572753
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.57575	2025-07-01 04:24:20.57575
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.580496	2025-07-01 04:24:20.580496
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.589885	2025-07-01 04:24:20.589885
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.592863	2025-07-01 04:24:20.592863
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.596045	2025-07-01 04:24:20.596045
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.599173	2025-07-01 04:24:20.599173
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.602122	2025-07-01 04:24:20.602122
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.605093	2025-07-01 04:24:20.605093
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.608167	2025-07-01 04:24:20.608167
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.611842	2025-07-01 04:24:20.611842
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.615497	2025-07-01 04:24:20.615497
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.61856	2025-07-01 04:24:20.61856
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.621723	2025-07-01 04:24:20.621723
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.66667	2025-07-01 04:24:20.66667
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.670387	2025-07-01 04:24:20.670387
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.67353	2025-07-01 04:24:20.67353
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.67644	2025-07-01 04:24:20.67644
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.67948	2025-07-01 04:24:20.67948
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.682302	2025-07-01 04:24:20.682302
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.685213	2025-07-01 04:24:20.685213
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.688405	2025-07-01 04:24:20.688405
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.691354	2025-07-01 04:24:20.691354
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.698525	2025-07-01 04:24:20.698525
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.701631	2025-07-01 04:24:20.701631
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.705228	2025-07-01 04:24:20.705228
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.708388	2025-07-01 04:24:20.708388
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.711409	2025-07-01 04:24:20.711409
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.714509	2025-07-01 04:24:20.714509
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.717547	2025-07-01 04:24:20.717547
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.720575	2025-07-01 04:24:20.720575
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.724226	2025-07-01 04:24:20.724226
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.727658	2025-07-01 04:24:20.727658
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.731085	2025-07-01 04:24:20.731085
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.735225	2025-07-01 04:24:20.735225
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.741203	2025-07-01 04:24:20.741203
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.746748	2025-07-01 04:24:20.746748
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.751755	2025-07-01 04:24:20.751755
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.757433	2025-07-01 04:24:20.757433
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.761265	2025-07-01 04:24:20.761265
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.764553	2025-07-01 04:24:20.764553
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.769475	2025-07-01 04:24:20.769475
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.773407	2025-07-01 04:24:20.773407
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.781618	2025-07-01 04:24:20.781618
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.786313	2025-07-01 04:24:20.786313
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.793507	2025-07-01 04:24:20.793507
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.799847	2025-07-01 04:24:20.799847
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.806722	2025-07-01 04:24:20.806722
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.812171	2025-07-01 04:24:20.812171
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:20.81588	2025-07-01 04:24:20.81588
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.439826	2025-07-01 04:24:21.439826
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.516008	2025-07-01 04:24:21.516008
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.541698	2025-07-01 04:24:21.541698
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.5484	2025-07-01 04:24:21.5484
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.555618	2025-07-01 04:24:21.555618
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.560438	2025-07-01 04:24:21.560438
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.564368	2025-07-01 04:24:21.564368
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.570114	2025-07-01 04:24:21.570114
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.573454	2025-07-01 04:24:21.573454
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.580184	2025-07-01 04:24:21.580184
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.584095	2025-07-01 04:24:21.584095
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.589132	2025-07-01 04:24:21.589132
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.592184	2025-07-01 04:24:21.592184
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.59775	2025-07-01 04:24:21.59775
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.602143	2025-07-01 04:24:21.602143
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.605875	2025-07-01 04:24:21.605875
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.608451	2025-07-01 04:24:21.608451
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.612811	2025-07-01 04:24:21.612811
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.617302	2025-07-01 04:24:21.617302
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.621787	2025-07-01 04:24:21.621787
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.624711	2025-07-01 04:24:21.624711
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.627518	2025-07-01 04:24:21.627518
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.631793	2025-07-01 04:24:21.631793
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.634529	2025-07-01 04:24:21.634529
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.637228	2025-07-01 04:24:21.637228
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.640508	2025-07-01 04:24:21.640508
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.644824	2025-07-01 04:24:21.644824
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.654747	2025-07-01 04:24:21.654747
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.665647	2025-07-01 04:24:21.665647
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.669596	2025-07-01 04:24:21.669596
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.673835	2025-07-01 04:24:21.673835
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.680487	2025-07-01 04:24:21.680487
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.685089	2025-07-01 04:24:21.685089
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.689557	2025-07-01 04:24:21.689557
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.694039	2025-07-01 04:24:21.694039
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.706453	2025-07-01 04:24:21.706453
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.710717	2025-07-01 04:24:21.710717
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.714959	2025-07-01 04:24:21.714959
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.719599	2025-07-01 04:24:21.719599
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.726021	2025-07-01 04:24:21.726021
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.731718	2025-07-01 04:24:21.731718
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.735925	2025-07-01 04:24:21.735925
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.740571	2025-07-01 04:24:21.740571
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.748201	2025-07-01 04:24:21.748201
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.751137	2025-07-01 04:24:21.751137
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.755165	2025-07-01 04:24:21.755165
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.761639	2025-07-01 04:24:21.761639
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.765813	2025-07-01 04:24:21.765813
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.769893	2025-07-01 04:24:21.769893
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.775632	2025-07-01 04:24:21.775632
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.784721	2025-07-01 04:24:21.784721
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.794534	2025-07-01 04:24:21.794534
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.802067	2025-07-01 04:24:21.802067
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.809328	2025-07-01 04:24:21.809328
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.815933	2025-07-01 04:24:21.815933
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.822211	2025-07-01 04:24:21.822211
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.830681	2025-07-01 04:24:21.830681
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.836993	2025-07-01 04:24:21.836993
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.844343	2025-07-01 04:24:21.844343
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.853336	2025-07-01 04:24:21.853336
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.85948	2025-07-01 04:24:21.85948
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.866628	2025-07-01 04:24:21.866628
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.870496	2025-07-01 04:24:21.870496
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.873945	2025-07-01 04:24:21.873945
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.877208	2025-07-01 04:24:21.877208
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.881227	2025-07-01 04:24:21.881227
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.886561	2025-07-01 04:24:21.886561
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.891164	2025-07-01 04:24:21.891164
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.895856	2025-07-01 04:24:21.895856
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.899155	2025-07-01 04:24:21.899155
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.902542	2025-07-01 04:24:21.902542
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.906498	2025-07-01 04:24:21.906498
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.910254	2025-07-01 04:24:21.910254
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.91432	2025-07-01 04:24:21.91432
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.91902	2025-07-01 04:24:21.91902
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.922299	2025-07-01 04:24:21.922299
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.926852	2025-07-01 04:24:21.926852
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.930474	2025-07-01 04:24:21.930474
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.934233	2025-07-01 04:24:21.934233
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.939553	2025-07-01 04:24:21.939553
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.944883	2025-07-01 04:24:21.944883
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.956268	2025-07-01 04:24:21.956268
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.994103	2025-07-01 04:24:21.994103
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:21.997976	2025-07-01 04:24:21.997976
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.005467	2025-07-01 04:24:22.005467
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.017257	2025-07-01 04:24:22.017257
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.056532	2025-07-01 04:24:22.056532
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.063592	2025-07-01 04:24:22.063592
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.071183	2025-07-01 04:24:22.071183
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.077682	2025-07-01 04:24:22.077682
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.12296	2025-07-01 04:24:22.12296
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.167017	2025-07-01 04:24:22.167017
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.172306	2025-07-01 04:24:22.172306
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.177847	2025-07-01 04:24:22.177847
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.185687	2025-07-01 04:24:22.185687
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.226894	2025-07-01 04:24:22.226894
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.235657	2025-07-01 04:24:22.235657
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.241994	2025-07-01 04:24:22.241994
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.252601	2025-07-01 04:24:22.252601
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.262187	2025-07-01 04:24:22.262187
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.269577	2025-07-01 04:24:22.269577
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.306866	2025-07-01 04:24:22.306866
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.313986	2025-07-01 04:24:22.313986
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.351153	2025-07-01 04:24:22.351153
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.362012	2025-07-01 04:24:22.362012
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.367049	2025-07-01 04:24:22.367049
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.40753	2025-07-01 04:24:22.40753
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.412919	2025-07-01 04:24:22.412919
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.419759	2025-07-01 04:24:22.419759
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.458649	2025-07-01 04:24:22.458649
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.46237	2025-07-01 04:24:22.46237
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.467512	2025-07-01 04:24:22.467512
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.472157	2025-07-01 04:24:22.472157
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.476129	2025-07-01 04:24:22.476129
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.481351	2025-07-01 04:24:22.481351
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.487838	2025-07-01 04:24:22.487838
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.491106	2025-07-01 04:24:22.491106
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.496128	2025-07-01 04:24:22.496128
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.533073	2025-07-01 04:24:22.533073
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.536839	2025-07-01 04:24:22.536839
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.540441	2025-07-01 04:24:22.540441
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.543919	2025-07-01 04:24:22.543919
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.548786	2025-07-01 04:24:22.548786
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.554651	2025-07-01 04:24:22.554651
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.591743	2025-07-01 04:24:22.591743
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.598269	2025-07-01 04:24:22.598269
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.605476	2025-07-01 04:24:22.605476
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.608844	2025-07-01 04:24:22.608844
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.618623	2025-07-01 04:24:22.618623
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.622473	2025-07-01 04:24:22.622473
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.627372	2025-07-01 04:24:22.627372
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.630919	2025-07-01 04:24:22.630919
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.634262	2025-07-01 04:24:22.634262
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.637668	2025-07-01 04:24:22.637668
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.641608	2025-07-01 04:24:22.641608
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.645482	2025-07-01 04:24:22.645482
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.64881	2025-07-01 04:24:22.64881
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.652015	2025-07-01 04:24:22.652015
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.655248	2025-07-01 04:24:22.655248
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.658724	2025-07-01 04:24:22.658724
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.662625	2025-07-01 04:24:22.662625
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.666473	2025-07-01 04:24:22.666473
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.670581	2025-07-01 04:24:22.670581
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.675937	2025-07-01 04:24:22.675937
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.679961	2025-07-01 04:24:22.679961
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.685705	2025-07-01 04:24:22.685705
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.690265	2025-07-01 04:24:22.690265
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.695616	2025-07-01 04:24:22.695616
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.700796	2025-07-01 04:24:22.700796
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.704964	2025-07-01 04:24:22.704964
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.709912	2025-07-01 04:24:22.709912
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.714659	2025-07-01 04:24:22.714659
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.719305	2025-07-01 04:24:22.719305
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.724011	2025-07-01 04:24:22.724011
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.727662	2025-07-01 04:24:22.727662
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.732302	2025-07-01 04:24:22.732302
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.73693	2025-07-01 04:24:22.73693
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.740281	2025-07-01 04:24:22.740281
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.744959	2025-07-01 04:24:22.744959
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.750868	2025-07-01 04:24:22.750868
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.756912	2025-07-01 04:24:22.756912
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.761765	2025-07-01 04:24:22.761765
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.765235	2025-07-01 04:24:22.765235
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.770112	2025-07-01 04:24:22.770112
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.775563	2025-07-01 04:24:22.775563
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.780882	2025-07-01 04:24:22.780882
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.786774	2025-07-01 04:24:22.786774
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:22.792111	2025-07-01 04:24:22.792111
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.797545	2025-07-01 04:24:22.797545
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.801175	2025-07-01 04:24:22.801175
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.80858	2025-07-01 04:24:22.80858
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.814181	2025-07-01 04:24:22.814181
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.819278	2025-07-01 04:24:22.819278
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.823291	2025-07-01 04:24:22.823291
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.828748	2025-07-01 04:24:22.828748
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.831976	2025-07-01 04:24:22.831976
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.83701	2025-07-01 04:24:22.83701
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.842068	2025-07-01 04:24:22.842068
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.846973	2025-07-01 04:24:22.846973
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.853074	2025-07-01 04:24:22.853074
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.857848	2025-07-01 04:24:22.857848
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.863074	2025-07-01 04:24:22.863074
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.867961	2025-07-01 04:24:22.867961
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.872752	2025-07-01 04:24:22.872752
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.879035	2025-07-01 04:24:22.879035
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.882759	2025-07-01 04:24:22.882759
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.886614	2025-07-01 04:24:22.886614
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.892652	2025-07-01 04:24:22.892652
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.896439	2025-07-01 04:24:22.896439
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.900352	2025-07-01 04:24:22.900352
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.905433	2025-07-01 04:24:22.905433
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.91535	2025-07-01 04:24:22.91535
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.922051	2025-07-01 04:24:22.922051
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.932938	2025-07-01 04:24:22.932938
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.939521	2025-07-01 04:24:22.939521
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.94422	2025-07-01 04:24:22.94422
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.950347	2025-07-01 04:24:22.950347
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.954169	2025-07-01 04:24:22.954169
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.959112	2025-07-01 04:24:22.959112
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.962423	2025-07-01 04:24:22.962423
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.965892	2025-07-01 04:24:22.965892
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.971314	2025-07-01 04:24:22.971314
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.976953	2025-07-01 04:24:22.976953
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.981059	2025-07-01 04:24:22.981059
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.984499	2025-07-01 04:24:22.984499
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.989793	2025-07-01 04:24:22.989793
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.995178	2025-07-01 04:24:22.995178
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:22.998627	2025-07-01 04:24:22.998627
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.001892	2025-07-01 04:24:23.001892
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.00771	2025-07-01 04:24:23.00771
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.018664	2025-07-01 04:24:23.018664
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.023835	2025-07-01 04:24:23.023835
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.027226	2025-07-01 04:24:23.027226
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.03047	2025-07-01 04:24:23.03047
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.033753	2025-07-01 04:24:23.033753
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.03717	2025-07-01 04:24:23.03717
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.042478	2025-07-01 04:24:23.042478
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.04606	2025-07-01 04:24:23.04606
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.051474	2025-07-01 04:24:23.051474
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.056544	2025-07-01 04:24:23.056544
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.060108	2025-07-01 04:24:23.060108
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.063461	2025-07-01 04:24:23.063461
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.068701	2025-07-01 04:24:23.068701
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.074279	2025-07-01 04:24:23.074279
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.079359	2025-07-01 04:24:23.079359
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.082944	2025-07-01 04:24:23.082944
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.090651	2025-07-01 04:24:23.090651
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.094054	2025-07-01 04:24:23.094054
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.097951	2025-07-01 04:24:23.097951
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.111787	2025-07-01 04:24:23.111787
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.131013	2025-07-01 04:24:23.131013
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.13645	2025-07-01 04:24:23.13645
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.144727	2025-07-01 04:24:23.144727
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.151777	2025-07-01 04:24:23.151777
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.170093	2025-07-01 04:24:23.170093
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.180868	2025-07-01 04:24:23.180868
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.190397	2025-07-01 04:24:23.190397
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.211765	2025-07-01 04:24:23.211765
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.217751	2025-07-01 04:24:23.217751
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.223246	2025-07-01 04:24:23.223246
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.234572	2025-07-01 04:24:23.234572
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.24	2025-07-01 04:24:23.24
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.243539	2025-07-01 04:24:23.243539
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.248898	2025-07-01 04:24:23.248898
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.25269	2025-07-01 04:24:23.25269
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.257391	2025-07-01 04:24:23.257391
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.260893	2025-07-01 04:24:23.260893
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.267004	2025-07-01 04:24:23.267004
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.271975	2025-07-01 04:24:23.271975
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.275609	2025-07-01 04:24:23.275609
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.280614	2025-07-01 04:24:23.280614
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.285993	2025-07-01 04:24:23.285993
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.291338	2025-07-01 04:24:23.291338
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.296394	2025-07-01 04:24:23.296394
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.301383	2025-07-01 04:24:23.301383
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.306505	2025-07-01 04:24:23.306505
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.311699	2025-07-01 04:24:23.311699
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.324747	2025-07-01 04:24:23.324747
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.329549	2025-07-01 04:24:23.329549
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.334178	2025-07-01 04:24:23.334178
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.338904	2025-07-01 04:24:23.338904
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.34355	2025-07-01 04:24:23.34355
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.348768	2025-07-01 04:24:23.348768
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.353931	2025-07-01 04:24:23.353931
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.359072	2025-07-01 04:24:23.359072
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.362859	2025-07-01 04:24:23.362859
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.367592	2025-07-01 04:24:23.367592
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.372683	2025-07-01 04:24:23.372683
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.378127	2025-07-01 04:24:23.378127
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.382722	2025-07-01 04:24:23.382722
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.386019	2025-07-01 04:24:23.386019
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.389189	2025-07-01 04:24:23.389189
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.392341	2025-07-01 04:24:23.392341
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.589832	2025-07-01 04:24:23.589832
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.601936	2025-07-01 04:24:23.601936
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.605443	2025-07-01 04:24:23.605443
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.609615	2025-07-01 04:24:23.609615
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.614996	2025-07-01 04:24:23.614996
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.619913	2025-07-01 04:24:23.619913
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.624722	2025-07-01 04:24:23.624722
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.629625	2025-07-01 04:24:23.629625
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.635599	2025-07-01 04:24:23.635599
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.639511	2025-07-01 04:24:23.639511
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.64478	2025-07-01 04:24:23.64478
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.65593	2025-07-01 04:24:23.65593
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.661133	2025-07-01 04:24:23.661133
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.664421	2025-07-01 04:24:23.664421
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.669061	2025-07-01 04:24:23.669061
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.673689	2025-07-01 04:24:23.673689
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.676942	2025-07-01 04:24:23.676942
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.69846	2025-07-01 04:24:23.69846
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.708931	2025-07-01 04:24:23.708931
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.713408	2025-07-01 04:24:23.713408
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.717099	2025-07-01 04:24:23.717099
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.723166	2025-07-01 04:24:23.723166
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.726759	2025-07-01 04:24:23.726759
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.731395	2025-07-01 04:24:23.731395
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.736455	2025-07-01 04:24:23.736455
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.740248	2025-07-01 04:24:23.740248
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.746449	2025-07-01 04:24:23.746449
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.750214	2025-07-01 04:24:23.750214
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.754812	2025-07-01 04:24:23.754812
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.758135	2025-07-01 04:24:23.758135
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.762688	2025-07-01 04:24:23.762688
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.767254	2025-07-01 04:24:23.767254
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.771791	2025-07-01 04:24:23.771791
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.776216	2025-07-01 04:24:23.776216
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.780673	2025-07-01 04:24:23.780673
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.785965	2025-07-01 04:24:23.785965
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.790495	2025-07-01 04:24:23.790495
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.794577	2025-07-01 04:24:23.794577
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.797753	2025-07-01 04:24:23.797753
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.802532	2025-07-01 04:24:23.802532
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.810369	2025-07-01 04:24:23.810369
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.814129	2025-07-01 04:24:23.814129
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.818993	2025-07-01 04:24:23.818993
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.824308	2025-07-01 04:24:23.824308
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.833382	2025-07-01 04:24:23.833382
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.844807	2025-07-01 04:24:23.844807
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.871688	2025-07-01 04:24:23.871688
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.891693	2025-07-01 04:24:23.891693
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.921598	2025-07-01 04:24:23.921598
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.933923	2025-07-01 04:24:23.933923
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.944279	2025-07-01 04:24:23.944279
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.95393	2025-07-01 04:24:23.95393
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.957364	2025-07-01 04:24:23.957364
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.960661	2025-07-01 04:24:23.960661
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.965318	2025-07-01 04:24:23.965318
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.968657	2025-07-01 04:24:23.968657
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.973311	2025-07-01 04:24:23.973311
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.978819	2025-07-01 04:24:23.978819
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.98385	2025-07-01 04:24:23.98385
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.987017	2025-07-01 04:24:23.987017
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.991969	2025-07-01 04:24:23.991969
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:23.997072	2025-07-01 04:24:23.997072
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.000365	2025-07-01 04:24:24.000365
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.005037	2025-07-01 04:24:24.005037
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.008849	2025-07-01 04:24:24.008849
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.014546	2025-07-01 04:24:24.014546
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.018656	2025-07-01 04:24:24.018656
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.024952	2025-07-01 04:24:24.024952
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.028521	2025-07-01 04:24:24.028521
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.032194	2025-07-01 04:24:24.032194
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.036015	2025-07-01 04:24:24.036015
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.041155	2025-07-01 04:24:24.041155
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.045656	2025-07-01 04:24:24.045656
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.050595	2025-07-01 04:24:24.050595
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.05561	2025-07-01 04:24:24.05561
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.060307	2025-07-01 04:24:24.060307
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.064805	2025-07-01 04:24:24.064805
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.069514	2025-07-01 04:24:24.069514
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.074476	2025-07-01 04:24:24.074476
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.079715	2025-07-01 04:24:24.079715
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.084669	2025-07-01 04:24:24.084669
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.089927	2025-07-01 04:24:24.089927
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.096344	2025-07-01 04:24:24.096344
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.102059	2025-07-01 04:24:24.102059
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.107074	2025-07-01 04:24:24.107074
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.11167	2025-07-01 04:24:24.11167
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.118354	2025-07-01 04:24:24.118354
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.123936	2025-07-01 04:24:24.123936
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.128734	2025-07-01 04:24:24.128734
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.134662	2025-07-01 04:24:24.134662
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.144515	2025-07-01 04:24:24.144515
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.149277	2025-07-01 04:24:24.149277
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.154381	2025-07-01 04:24:24.154381
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.159398	2025-07-01 04:24:24.159398
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.164386	2025-07-01 04:24:24.164386
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.169263	2025-07-01 04:24:24.169263
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.172762	2025-07-01 04:24:24.172762
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.178922	2025-07-01 04:24:24.178922
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.182396	2025-07-01 04:24:24.182396
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.186951	2025-07-01 04:24:24.186951
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.191705	2025-07-01 04:24:24.191705
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.200639	2025-07-01 04:24:24.200639
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.203936	2025-07-01 04:24:24.203936
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.208755	2025-07-01 04:24:24.208755
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.213948	2025-07-01 04:24:24.213948
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.219081	2025-07-01 04:24:24.219081
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.223713	2025-07-01 04:24:24.223713
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.228417	2025-07-01 04:24:24.228417
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.234111	2025-07-01 04:24:24.234111
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.237423	2025-07-01 04:24:24.237423
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.241102	2025-07-01 04:24:24.241102
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.244531	2025-07-01 04:24:24.244531
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.249571	2025-07-01 04:24:24.249571
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.254537	2025-07-01 04:24:24.254537
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.258044	2025-07-01 04:24:24.258044
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.26307	2025-07-01 04:24:24.26307
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.266565	2025-07-01 04:24:24.266565
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.269857	2025-07-01 04:24:24.269857
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.274649	2025-07-01 04:24:24.274649
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.278299	2025-07-01 04:24:24.278299
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.283237	2025-07-01 04:24:24.283237
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.287888	2025-07-01 04:24:24.287888
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.292695	2025-07-01 04:24:24.292695
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.297984	2025-07-01 04:24:24.297984
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.303172	2025-07-01 04:24:24.303172
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.306591	2025-07-01 04:24:24.306591
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.312108	2025-07-01 04:24:24.312108
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.315526	2025-07-01 04:24:24.315526
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.321076	2025-07-01 04:24:24.321076
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.324518	2025-07-01 04:24:24.324518
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.328139	2025-07-01 04:24:24.328139
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.33305	2025-07-01 04:24:24.33305
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.33826	2025-07-01 04:24:24.33826
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.341842	2025-07-01 04:24:24.341842
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.347425	2025-07-01 04:24:24.347425
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.352361	2025-07-01 04:24:24.352361
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.356575	2025-07-01 04:24:24.356575
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.361823	2025-07-01 04:24:24.361823
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.365193	2025-07-01 04:24:24.365193
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.368578	2025-07-01 04:24:24.368578
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.373186	2025-07-01 04:24:24.373186
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.378152	2025-07-01 04:24:24.378152
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.382835	2025-07-01 04:24:24.382835
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.386352	2025-07-01 04:24:24.386352
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.391209	2025-07-01 04:24:24.391209
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.395093	2025-07-01 04:24:24.395093
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.400412	2025-07-01 04:24:24.400412
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.405802	2025-07-01 04:24:24.405802
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.409333	2025-07-01 04:24:24.409333
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.414306	2025-07-01 04:24:24.414306
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.419397	2025-07-01 04:24:24.419397
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.424579	2025-07-01 04:24:24.424579
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.430035	2025-07-01 04:24:24.430035
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.435195	2025-07-01 04:24:24.435195
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.440806	2025-07-01 04:24:24.440806
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.44574	2025-07-01 04:24:24.44574
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.451031	2025-07-01 04:24:24.451031
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.454545	2025-07-01 04:24:24.454545
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.45936	2025-07-01 04:24:24.45936
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.465506	2025-07-01 04:24:24.465506
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.472136	2025-07-01 04:24:24.472136
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.478553	2025-07-01 04:24:24.478553
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.481846	2025-07-01 04:24:24.481846
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.486787	2025-07-01 04:24:24.486787
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.492168	2025-07-01 04:24:24.492168
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.500508	2025-07-01 04:24:24.500508
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.505554	2025-07-01 04:24:24.505554
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.51194	2025-07-01 04:24:24.51194
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.515675	2025-07-01 04:24:24.515675
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.520722	2025-07-01 04:24:24.520722
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.525513	2025-07-01 04:24:24.525513
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.532335	2025-07-01 04:24:24.532335
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.537408	2025-07-01 04:24:24.537408
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.542522	2025-07-01 04:24:24.542522
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.547369	2025-07-01 04:24:24.547369
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.552613	2025-07-01 04:24:24.552613
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.558017	2025-07-01 04:24:24.558017
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.561659	2025-07-01 04:24:24.561659
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.565158	2025-07-01 04:24:24.565158
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.570772	2025-07-01 04:24:24.570772
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.576358	2025-07-01 04:24:24.576358
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.581581	2025-07-01 04:24:24.581581
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.589282	2025-07-01 04:24:24.589282
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.598151	2025-07-01 04:24:24.598151
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.60427	2025-07-01 04:24:24.60427
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.609027	2025-07-01 04:24:24.609027
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.612816	2025-07-01 04:24:24.612816
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.616115	2025-07-01 04:24:24.616115
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:24.622275	2025-07-01 04:24:24.622275
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-07-01 04:24:05.144242
2	ART Coverage	\N	\N	2025-07-01 04:24:05.157439
3	People Living with HIV	\N	\N	2025-07-01 04:24:05.172041
4	HIV-related Deaths	\N	\N	2025-07-01 04:24:05.185569
5	HIV Cases Adults 15-49	\N	\N	2025-07-01 04:24:05.19643
6	ART Pediatric Coverage	\N	\N	2025-07-01 04:24:05.205754
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminfr	$2b$12$9X7EhmsTFOBUitABWlw9kOIjvL9ZyuEHufpq41W6wEc/X0DIRRRWi	admin	0	2025-07-01 04:24:05.110172	2025-07-01 04:24:05.110172
2	userfr	$2b$12$lpcVVMlPidgD0Hn5zRoVNuWqeBQxoMNzh24cz7Mdqwi8acBH6KCLC	user	0	2025-07-01 04:24:05.121339	2025-07-01 04:24:05.121339
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

