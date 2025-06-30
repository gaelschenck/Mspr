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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 21:47:16.350488	2025-06-29 21:47:16.350488
2	Albania	Europe	\N	2025-06-29 21:47:16.355446	2025-06-29 21:47:16.355446
3	Algeria	Africa	\N	2025-06-29 21:47:16.423843	2025-06-29 21:47:16.423843
4	Angola	Africa	\N	2025-06-29 21:47:16.429837	2025-06-29 21:47:16.429837
5	Argentina	Americas	\N	2025-06-29 21:47:16.447252	2025-06-29 21:47:16.447252
6	Armenia	Europe	\N	2025-06-29 21:47:16.490766	2025-06-29 21:47:16.490766
7	Australia	Western Pacific	\N	2025-06-29 21:47:16.497515	2025-06-29 21:47:16.497515
8	Austria	Europe	\N	2025-06-29 21:47:16.537746	2025-06-29 21:47:16.537746
9	Azerbaijan	Europe	\N	2025-06-29 21:47:16.542719	2025-06-29 21:47:16.542719
10	Bahamas	Americas	\N	2025-06-29 21:47:16.546463	2025-06-29 21:47:16.546463
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 21:47:16.55011	2025-06-29 21:47:16.55011
12	Bangladesh	South-East Asia	\N	2025-06-29 21:47:16.580036	2025-06-29 21:47:16.580036
13	Barbados	Americas	\N	2025-06-29 21:47:16.58336	2025-06-29 21:47:16.58336
14	Belarus	Europe	\N	2025-06-29 21:47:16.586627	2025-06-29 21:47:16.586627
15	Belgium	Europe	\N	2025-06-29 21:47:16.589967	2025-06-29 21:47:16.589967
16	Belize	Americas	\N	2025-06-29 21:47:16.592938	2025-06-29 21:47:16.592938
17	Benin	Africa	\N	2025-06-29 21:47:16.596324	2025-06-29 21:47:16.596324
18	Bhutan	South-East Asia	\N	2025-06-29 21:47:16.604042	2025-06-29 21:47:16.604042
19	Bolivia	Americas	\N	2025-06-29 21:47:16.607789	2025-06-29 21:47:16.607789
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 21:47:16.610897	2025-06-29 21:47:16.610897
21	Botswana	Africa	\N	2025-06-29 21:47:16.614174	2025-06-29 21:47:16.614174
22	Brazil	Americas	\N	2025-06-29 21:47:16.618686	2025-06-29 21:47:16.618686
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 21:47:16.625987	2025-06-29 21:47:16.625987
24	Bulgaria	Europe	\N	2025-06-29 21:47:16.630633	2025-06-29 21:47:16.630633
25	Burkina Faso	Africa	\N	2025-06-29 21:47:16.635706	2025-06-29 21:47:16.635706
26	Burundi	Africa	\N	2025-06-29 21:47:16.640755	2025-06-29 21:47:16.640755
27	Cabo Verde	Africa	\N	2025-06-29 21:47:16.644624	2025-06-29 21:47:16.644624
28	Cambodia	Western Pacific	\N	2025-06-29 21:47:16.679812	2025-06-29 21:47:16.679812
29	Cameroon	Africa	\N	2025-06-29 21:47:16.683906	2025-06-29 21:47:16.683906
30	Canada	Americas	\N	2025-06-29 21:47:16.687416	2025-06-29 21:47:16.687416
31	Central African Republic	Africa	\N	2025-06-29 21:47:16.690813	2025-06-29 21:47:16.690813
32	Chad	Africa	\N	2025-06-29 21:47:16.694282	2025-06-29 21:47:16.694282
33	Chile	Americas	\N	2025-06-29 21:47:16.720582	2025-06-29 21:47:16.720582
34	China	Western Pacific	\N	2025-06-29 21:47:16.726329	2025-06-29 21:47:16.726329
35	Colombia	Americas	\N	2025-06-29 21:47:16.73263	2025-06-29 21:47:16.73263
36	Comoros	Africa	\N	2025-06-29 21:47:16.739643	2025-06-29 21:47:16.739643
37	Congo	Americas	\N	2025-06-29 21:47:16.75721	2025-06-29 21:47:16.75721
38	Costa Rica	Americas	\N	2025-06-29 21:47:16.762792	2025-06-29 21:47:16.762792
39	Côte d'Ivoire	Africa	\N	2025-06-29 21:47:16.766314	2025-06-29 21:47:16.766314
40	Croatia	Europe	\N	2025-06-29 21:47:16.783274	2025-06-29 21:47:16.783274
41	Cuba	Americas	\N	2025-06-29 21:47:16.790038	2025-06-29 21:47:16.790038
42	Cyprus	Europe	\N	2025-06-29 21:47:16.796155	2025-06-29 21:47:16.796155
43	Czechia	Europe	\N	2025-06-29 21:47:16.821308	2025-06-29 21:47:16.821308
44	North Korea	Western Pacific	\N	2025-06-29 21:47:16.826229	2025-06-29 21:47:16.826229
45	DR Congo	Africa	\N	2025-06-29 21:47:16.830966	2025-06-29 21:47:16.830966
46	Denmark	Europe	\N	2025-06-29 21:47:16.8391	2025-06-29 21:47:16.8391
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 21:47:16.849967	2025-06-29 21:47:16.849967
48	Dominican Republic	Americas	\N	2025-06-29 21:47:16.861559	2025-06-29 21:47:16.861559
49	Ecuador	Americas	\N	2025-06-29 21:47:16.873673	2025-06-29 21:47:16.873673
50	Egypt	Eastern Mediterranean	\N	2025-06-29 21:47:16.885196	2025-06-29 21:47:16.885196
51	El Salvador	Americas	\N	2025-06-29 21:47:16.907443	2025-06-29 21:47:16.907443
52	Equatorial Guinea	Africa	\N	2025-06-29 21:47:16.919355	2025-06-29 21:47:16.919355
53	Eritrea	Africa	\N	2025-06-29 21:47:16.938119	2025-06-29 21:47:16.938119
54	Estonia	Europe	\N	2025-06-29 21:47:16.953653	2025-06-29 21:47:16.953653
55	Eswatini	Africa	\N	2025-06-29 21:47:16.968981	2025-06-29 21:47:16.968981
56	Ethiopia	Africa	\N	2025-06-29 21:47:16.98883	2025-06-29 21:47:16.98883
57	Fiji	Western Pacific	\N	2025-06-29 21:47:17.015725	2025-06-29 21:47:17.015725
58	Finland	Europe	\N	2025-06-29 21:47:17.038153	2025-06-29 21:47:17.038153
59	France	Europe	\N	2025-06-29 21:47:17.088658	2025-06-29 21:47:17.088658
60	Gabon	Africa	\N	2025-06-29 21:47:17.103512	2025-06-29 21:47:17.103512
61	Gambia	Africa	\N	2025-06-29 21:47:17.123639	2025-06-29 21:47:17.123639
62	Georgia	Europe	\N	2025-06-29 21:47:17.172112	2025-06-29 21:47:17.172112
63	Germany	Europe	\N	2025-06-29 21:47:17.237547	2025-06-29 21:47:17.237547
64	Ghana	Africa	\N	2025-06-29 21:47:17.256733	2025-06-29 21:47:17.256733
65	Greece	Europe	\N	2025-06-29 21:47:17.287726	2025-06-29 21:47:17.287726
66	Guatemala	Americas	\N	2025-06-29 21:47:17.324535	2025-06-29 21:47:17.324535
67	Guinea	Africa	\N	2025-06-29 21:47:17.371933	2025-06-29 21:47:17.371933
68	Guinea-Bissau	Africa	\N	2025-06-29 21:47:17.439783	2025-06-29 21:47:17.439783
69	Guyana	Americas	\N	2025-06-29 21:47:17.463444	2025-06-29 21:47:17.463444
70	Haiti	Americas	\N	2025-06-29 21:47:17.513357	2025-06-29 21:47:17.513357
71	Honduras	Americas	\N	2025-06-29 21:47:17.542574	2025-06-29 21:47:17.542574
72	Hungary	Europe	\N	2025-06-29 21:47:17.567797	2025-06-29 21:47:17.567797
73	Iceland	Europe	\N	2025-06-29 21:47:17.585806	2025-06-29 21:47:17.585806
74	India	South-East Asia	\N	2025-06-29 21:47:17.602434	2025-06-29 21:47:17.602434
75	Indonesia	South-East Asia	\N	2025-06-29 21:47:17.636803	2025-06-29 21:47:17.636803
76	Iran	Eastern Mediterranean	\N	2025-06-29 21:47:17.703808	2025-06-29 21:47:17.703808
77	Ireland	Europe	\N	2025-06-29 21:47:17.750519	2025-06-29 21:47:17.750519
78	Israel	Europe	\N	2025-06-29 21:47:17.770193	2025-06-29 21:47:17.770193
79	Italy	Europe	\N	2025-06-29 21:47:17.791831	2025-06-29 21:47:17.791831
80	Jamaica	Americas	\N	2025-06-29 21:47:17.854622	2025-06-29 21:47:17.854622
81	Japan	Western Pacific	\N	2025-06-29 21:47:17.896625	2025-06-29 21:47:17.896625
82	Jordan	Eastern Mediterranean	\N	2025-06-29 21:47:17.922587	2025-06-29 21:47:17.922587
83	Kazakhstan	Europe	\N	2025-06-29 21:47:17.963023	2025-06-29 21:47:17.963023
84	Kenya	Africa	\N	2025-06-29 21:47:17.990294	2025-06-29 21:47:17.990294
85	Kuwait	Eastern Mediterranean	\N	2025-06-29 21:47:18.014724	2025-06-29 21:47:18.014724
86	Kyrgyzstan	Europe	\N	2025-06-29 21:47:18.030053	2025-06-29 21:47:18.030053
87	Laos	Western Pacific	\N	2025-06-29 21:47:18.07083	2025-06-29 21:47:18.07083
88	Latvia	Europe	\N	2025-06-29 21:47:18.101487	2025-06-29 21:47:18.101487
89	Lebanon	Eastern Mediterranean	\N	2025-06-29 21:47:18.116043	2025-06-29 21:47:18.116043
90	Lesotho	Africa	\N	2025-06-29 21:47:18.148869	2025-06-29 21:47:18.148869
91	Liberia	Africa	\N	2025-06-29 21:47:18.198093	2025-06-29 21:47:18.198093
92	Libya	Eastern Mediterranean	\N	2025-06-29 21:47:18.260224	2025-06-29 21:47:18.260224
93	Lithuania	Europe	\N	2025-06-29 21:47:18.291472	2025-06-29 21:47:18.291472
94	Luxembourg	Europe	\N	2025-06-29 21:47:18.382384	2025-06-29 21:47:18.382384
95	Madagascar	Africa	\N	2025-06-29 21:47:18.446312	2025-06-29 21:47:18.446312
96	Malawi	Africa	\N	2025-06-29 21:47:18.497542	2025-06-29 21:47:18.497542
97	Malaysia	Western Pacific	\N	2025-06-29 21:47:18.5237	2025-06-29 21:47:18.5237
98	Maldives	South-East Asia	\N	2025-06-29 21:47:18.555318	2025-06-29 21:47:18.555318
99	Mali	Africa	\N	2025-06-29 21:47:18.629431	2025-06-29 21:47:18.629431
100	Malta	Europe	\N	2025-06-29 21:47:18.649507	2025-06-29 21:47:18.649507
101	Mauritania	Africa	\N	2025-06-29 21:47:18.692884	2025-06-29 21:47:18.692884
102	Mauritius	Africa	\N	2025-06-29 21:47:18.720929	2025-06-29 21:47:18.720929
103	Mexico	Americas	\N	2025-06-29 21:47:18.747388	2025-06-29 21:47:18.747388
104	Mongolia	Western Pacific	\N	2025-06-29 21:47:18.774816	2025-06-29 21:47:18.774816
105	Montenegro	Europe	\N	2025-06-29 21:47:18.815174	2025-06-29 21:47:18.815174
106	Morocco	Eastern Mediterranean	\N	2025-06-29 21:47:18.829123	2025-06-29 21:47:18.829123
107	Mozambique	Africa	\N	2025-06-29 21:47:18.84788	2025-06-29 21:47:18.84788
108	Myanmar	South-East Asia	\N	2025-06-29 21:47:18.86114	2025-06-29 21:47:18.86114
109	Namibia	Africa	\N	2025-06-29 21:47:18.87877	2025-06-29 21:47:18.87877
110	Nepal	South-East Asia	\N	2025-06-29 21:47:18.898602	2025-06-29 21:47:18.898602
111	Netherlands	Europe	\N	2025-06-29 21:47:18.916545	2025-06-29 21:47:18.916545
112	New Zealand	Western Pacific	\N	2025-06-29 21:47:18.936415	2025-06-29 21:47:18.936415
113	Nicaragua	Americas	\N	2025-06-29 21:47:18.9532	2025-06-29 21:47:18.9532
114	Niger	Africa	\N	2025-06-29 21:47:18.975104	2025-06-29 21:47:18.975104
115	Nigeria	Africa	\N	2025-06-29 21:47:19.003622	2025-06-29 21:47:19.003622
116	Norway	Europe	\N	2025-06-29 21:47:19.057842	2025-06-29 21:47:19.057842
117	Oman	Eastern Mediterranean	\N	2025-06-29 21:47:19.092298	2025-06-29 21:47:19.092298
118	Pakistan	Eastern Mediterranean	\N	2025-06-29 21:47:19.124703	2025-06-29 21:47:19.124703
119	Panama	Americas	\N	2025-06-29 21:47:19.153071	2025-06-29 21:47:19.153071
120	Papua New Guinea	Western Pacific	\N	2025-06-29 21:47:19.190597	2025-06-29 21:47:19.190597
121	Paraguay	Americas	\N	2025-06-29 21:47:19.222207	2025-06-29 21:47:19.222207
122	Peru	Americas	\N	2025-06-29 21:47:19.28537	2025-06-29 21:47:19.28537
123	Philippines	Western Pacific	\N	2025-06-29 21:47:19.322989	2025-06-29 21:47:19.322989
124	Poland	Europe	\N	2025-06-29 21:47:19.350706	2025-06-29 21:47:19.350706
125	Portugal	Europe	\N	2025-06-29 21:47:19.382575	2025-06-29 21:47:19.382575
126	Qatar	Eastern Mediterranean	\N	2025-06-29 21:47:19.397638	2025-06-29 21:47:19.397638
127	South Korea	Western Pacific	\N	2025-06-29 21:47:19.422239	2025-06-29 21:47:19.422239
128	Moldova	Europe	\N	2025-06-29 21:47:19.454247	2025-06-29 21:47:19.454247
129	North Macedonia	Europe	\N	2025-06-29 21:47:19.483893	2025-06-29 21:47:19.483893
130	Romania	Europe	\N	2025-06-29 21:47:19.510828	2025-06-29 21:47:19.510828
131	Russia	Europe	\N	2025-06-29 21:47:19.529712	2025-06-29 21:47:19.529712
132	Rwanda	Africa	\N	2025-06-29 21:47:19.546745	2025-06-29 21:47:19.546745
133	Saudi Arabia	Eastern Mediterranean	\N	2025-06-29 21:47:19.559712	2025-06-29 21:47:19.559712
134	Senegal	Africa	\N	2025-06-29 21:47:19.570956	2025-06-29 21:47:19.570956
135	Serbia	Europe	\N	2025-06-29 21:47:19.585061	2025-06-29 21:47:19.585061
136	Sierra Leone	Africa	\N	2025-06-29 21:47:19.595417	2025-06-29 21:47:19.595417
137	Singapore	Western Pacific	\N	2025-06-29 21:47:19.609473	2025-06-29 21:47:19.609473
138	Slovakia	Europe	\N	2025-06-29 21:47:19.623632	2025-06-29 21:47:19.623632
139	Slovenia	Europe	\N	2025-06-29 21:47:19.639853	2025-06-29 21:47:19.639853
140	Somalia	Eastern Mediterranean	\N	2025-06-29 21:47:19.656675	2025-06-29 21:47:19.656675
141	South Africa	Africa	\N	2025-06-29 21:47:19.670155	2025-06-29 21:47:19.670155
142	South Sudan	Africa	\N	2025-06-29 21:47:19.680505	2025-06-29 21:47:19.680505
143	Spain	Europe	\N	2025-06-29 21:47:19.696622	2025-06-29 21:47:19.696622
144	Sri Lanka	South-East Asia	\N	2025-06-29 21:47:19.725751	2025-06-29 21:47:19.725751
145	Sudan	Eastern Mediterranean	\N	2025-06-29 21:47:19.748742	2025-06-29 21:47:19.748742
146	Suriname	Americas	\N	2025-06-29 21:47:19.766827	2025-06-29 21:47:19.766827
147	Sweden	Europe	\N	2025-06-29 21:47:19.779087	2025-06-29 21:47:19.779087
148	Switzerland	Europe	\N	2025-06-29 21:47:19.791805	2025-06-29 21:47:19.791805
149	Syria	Eastern Mediterranean	\N	2025-06-29 21:47:19.809049	2025-06-29 21:47:19.809049
150	Tajikistan	Europe	\N	2025-06-29 21:47:19.819111	2025-06-29 21:47:19.819111
151	Thailand	South-East Asia	\N	2025-06-29 21:47:19.846708	2025-06-29 21:47:19.846708
152	Timor-Leste	South-East Asia	\N	2025-06-29 21:47:19.896934	2025-06-29 21:47:19.896934
153	Togo	Africa	\N	2025-06-29 21:47:19.91243	2025-06-29 21:47:19.91243
154	Trinidad and Tobago	Americas	\N	2025-06-29 21:47:19.942521	2025-06-29 21:47:19.942521
155	Tunisia	Eastern Mediterranean	\N	2025-06-29 21:47:19.960012	2025-06-29 21:47:19.960012
156	Turkey	Europe	\N	2025-06-29 21:47:19.975652	2025-06-29 21:47:19.975652
157	Turkmenistan	Europe	\N	2025-06-29 21:47:20.008753	2025-06-29 21:47:20.008753
158	Uganda	Africa	\N	2025-06-29 21:47:20.029677	2025-06-29 21:47:20.029677
159	Ukraine	Europe	\N	2025-06-29 21:47:20.043109	2025-06-29 21:47:20.043109
160	United Arab Emirates	Eastern Mediterranean	\N	2025-06-29 21:47:20.053805	2025-06-29 21:47:20.053805
161	United Kingdom	Europe	\N	2025-06-29 21:47:20.10401	2025-06-29 21:47:20.10401
162	Tanzania	Africa	\N	2025-06-29 21:47:20.121041	2025-06-29 21:47:20.121041
163	United States	Americas	\N	2025-06-29 21:47:20.142683	2025-06-29 21:47:20.142683
164	Uruguay	Americas	\N	2025-06-29 21:47:20.160296	2025-06-29 21:47:20.160296
165	Uzbekistan	Europe	\N	2025-06-29 21:47:20.178486	2025-06-29 21:47:20.178486
166	Venezuela	Americas	\N	2025-06-29 21:47:20.195558	2025-06-29 21:47:20.195558
167	Viet Nam	Western Pacific	\N	2025-06-29 21:47:20.215682	2025-06-29 21:47:20.215682
168	Yemen	Eastern Mediterranean	\N	2025-06-29 21:47:20.255587	2025-06-29 21:47:20.255587
169	Zambia	Africa	\N	2025-06-29 21:47:20.278461	2025-06-29 21:47:20.278461
170	Zimbabwe	Africa	\N	2025-06-29 21:47:20.366654	2025-06-29 21:47:20.366654
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.42202	2025-06-29 21:47:20.42202
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.485154	2025-06-29 21:47:20.485154
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.529963	2025-06-29 21:47:20.529963
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.554003	2025-06-29 21:47:20.554003
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.605702	2025-06-29 21:47:20.605702
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.625347	2025-06-29 21:47:20.625347
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.649108	2025-06-29 21:47:20.649108
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.66215	2025-06-29 21:47:20.66215
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.67856	2025-06-29 21:47:20.67856
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.689912	2025-06-29 21:47:20.689912
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.713314	2025-06-29 21:47:20.713314
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.725585	2025-06-29 21:47:20.725585
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.744476	2025-06-29 21:47:20.744476
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.765856	2025-06-29 21:47:20.765856
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.779689	2025-06-29 21:47:20.779689
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.7974	2025-06-29 21:47:20.7974
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.817734	2025-06-29 21:47:20.817734
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.840614	2025-06-29 21:47:20.840614
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.877963	2025-06-29 21:47:20.877963
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.88922	2025-06-29 21:47:20.88922
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.903137	2025-06-29 21:47:20.903137
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.92703	2025-06-29 21:47:20.92703
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.951227	2025-06-29 21:47:20.951227
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:20.979329	2025-06-29 21:47:20.979329
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.040278	2025-06-29 21:47:21.040278
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.070372	2025-06-29 21:47:21.070372
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.095257	2025-06-29 21:47:21.095257
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.110956	2025-06-29 21:47:21.110956
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.123461	2025-06-29 21:47:21.123461
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.164646	2025-06-29 21:47:21.164646
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.187858	2025-06-29 21:47:21.187858
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.222478	2025-06-29 21:47:21.222478
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.251152	2025-06-29 21:47:21.251152
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.289582	2025-06-29 21:47:21.289582
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.324857	2025-06-29 21:47:21.324857
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.354685	2025-06-29 21:47:21.354685
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.386317	2025-06-29 21:47:21.386317
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.414749	2025-06-29 21:47:21.414749
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.470665	2025-06-29 21:47:21.470665
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.490428	2025-06-29 21:47:21.490428
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.509155	2025-06-29 21:47:21.509155
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.528142	2025-06-29 21:47:21.528142
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.546808	2025-06-29 21:47:21.546808
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.563856	2025-06-29 21:47:21.563856
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.590549	2025-06-29 21:47:21.590549
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.633402	2025-06-29 21:47:21.633402
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.71165	2025-06-29 21:47:21.71165
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.737432	2025-06-29 21:47:21.737432
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.763385	2025-06-29 21:47:21.763385
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.777377	2025-06-29 21:47:21.777377
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.804057	2025-06-29 21:47:21.804057
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.823978	2025-06-29 21:47:21.823978
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.847761	2025-06-29 21:47:21.847761
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.862012	2025-06-29 21:47:21.862012
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.876814	2025-06-29 21:47:21.876814
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.897732	2025-06-29 21:47:21.897732
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.914974	2025-06-29 21:47:21.914974
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.951915	2025-06-29 21:47:21.951915
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:21.992245	2025-06-29 21:47:21.992245
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.058041	2025-06-29 21:47:22.058041
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.138443	2025-06-29 21:47:22.138443
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.276269	2025-06-29 21:47:22.276269
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.522793	2025-06-29 21:47:22.522793
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.682878	2025-06-29 21:47:22.682878
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.782307	2025-06-29 21:47:22.782307
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:22.919017	2025-06-29 21:47:22.919017
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.055074	2025-06-29 21:47:23.055074
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.302033	2025-06-29 21:47:23.302033
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.453641	2025-06-29 21:47:23.453641
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.658083	2025-06-29 21:47:23.658083
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.70624	2025-06-29 21:47:23.70624
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.742483	2025-06-29 21:47:23.742483
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.823319	2025-06-29 21:47:23.823319
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.856845	2025-06-29 21:47:23.856845
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.885593	2025-06-29 21:47:23.885593
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.922902	2025-06-29 21:47:23.922902
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.943063	2025-06-29 21:47:23.943063
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.96331	2025-06-29 21:47:23.96331
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.976336	2025-06-29 21:47:23.976336
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:23.988109	2025-06-29 21:47:23.988109
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.003148	2025-06-29 21:47:24.003148
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.063207	2025-06-29 21:47:24.063207
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.159591	2025-06-29 21:47:24.159591
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.214254	2025-06-29 21:47:24.214254
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.364198	2025-06-29 21:47:24.364198
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.411709	2025-06-29 21:47:24.411709
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.437874	2025-06-29 21:47:24.437874
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.459582	2025-06-29 21:47:24.459582
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.481433	2025-06-29 21:47:24.481433
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.509432	2025-06-29 21:47:24.509432
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.535882	2025-06-29 21:47:24.535882
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.599129	2025-06-29 21:47:24.599129
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.619025	2025-06-29 21:47:24.619025
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.668846	2025-06-29 21:47:24.668846
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.686573	2025-06-29 21:47:24.686573
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.703897	2025-06-29 21:47:24.703897
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.716049	2025-06-29 21:47:24.716049
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.737724	2025-06-29 21:47:24.737724
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.753378	2025-06-29 21:47:24.753378
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.806699	2025-06-29 21:47:24.806699
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.829786	2025-06-29 21:47:24.829786
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.850812	2025-06-29 21:47:24.850812
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.865156	2025-06-29 21:47:24.865156
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.885897	2025-06-29 21:47:24.885897
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.942886	2025-06-29 21:47:24.942886
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.960572	2025-06-29 21:47:24.960572
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:24.999562	2025-06-29 21:47:24.999562
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.013409	2025-06-29 21:47:25.013409
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.05612	2025-06-29 21:47:25.05612
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.110535	2025-06-29 21:47:25.110535
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.14097	2025-06-29 21:47:25.14097
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.176788	2025-06-29 21:47:25.176788
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.25653	2025-06-29 21:47:25.25653
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.32327	2025-06-29 21:47:25.32327
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.350097	2025-06-29 21:47:25.350097
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.378231	2025-06-29 21:47:25.378231
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.424151	2025-06-29 21:47:25.424151
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.442026	2025-06-29 21:47:25.442026
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.462242	2025-06-29 21:47:25.462242
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.47941	2025-06-29 21:47:25.47941
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.495423	2025-06-29 21:47:25.495423
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.517551	2025-06-29 21:47:25.517551
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.530507	2025-06-29 21:47:25.530507
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.560498	2025-06-29 21:47:25.560498
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.574739	2025-06-29 21:47:25.574739
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.598717	2025-06-29 21:47:25.598717
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.633166	2025-06-29 21:47:25.633166
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.665896	2025-06-29 21:47:25.665896
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.688848	2025-06-29 21:47:25.688848
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.707573	2025-06-29 21:47:25.707573
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.725979	2025-06-29 21:47:25.725979
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.75333	2025-06-29 21:47:25.75333
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.781764	2025-06-29 21:47:25.781764
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.801903	2025-06-29 21:47:25.801903
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.815572	2025-06-29 21:47:25.815572
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.844337	2025-06-29 21:47:25.844337
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.889806	2025-06-29 21:47:25.889806
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.934044	2025-06-29 21:47:25.934044
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:25.985841	2025-06-29 21:47:25.985841
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.006202	2025-06-29 21:47:26.006202
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.039716	2025-06-29 21:47:26.039716
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.069549	2025-06-29 21:47:26.069549
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.082676	2025-06-29 21:47:26.082676
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.1249	2025-06-29 21:47:26.1249
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.153694	2025-06-29 21:47:26.153694
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.174337	2025-06-29 21:47:26.174337
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.213951	2025-06-29 21:47:26.213951
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.259691	2025-06-29 21:47:26.259691
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.321763	2025-06-29 21:47:26.321763
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.379376	2025-06-29 21:47:26.379376
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.452261	2025-06-29 21:47:26.452261
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.509906	2025-06-29 21:47:26.509906
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.570167	2025-06-29 21:47:26.570167
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.608017	2025-06-29 21:47:26.608017
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.646263	2025-06-29 21:47:26.646263
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.69477	2025-06-29 21:47:26.69477
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.757714	2025-06-29 21:47:26.757714
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.771904	2025-06-29 21:47:26.771904
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.791131	2025-06-29 21:47:26.791131
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.819674	2025-06-29 21:47:26.819674
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.840811	2025-06-29 21:47:26.840811
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.868231	2025-06-29 21:47:26.868231
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.907359	2025-06-29 21:47:26.907359
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.925815	2025-06-29 21:47:26.925815
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.94022	2025-06-29 21:47:26.94022
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.968221	2025-06-29 21:47:26.968221
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:26.985878	2025-06-29 21:47:26.985878
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.010788	2025-06-29 21:47:27.010788
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.028434	2025-06-29 21:47:27.028434
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.048078	2025-06-29 21:47:27.048078
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.067244	2025-06-29 21:47:27.067244
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.084317	2025-06-29 21:47:27.084317
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.106237	2025-06-29 21:47:27.106237
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.131239	2025-06-29 21:47:27.131239
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.147263	2025-06-29 21:47:27.147263
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.167658	2025-06-29 21:47:27.167658
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.227404	2025-06-29 21:47:27.227404
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.261749	2025-06-29 21:47:27.261749
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.284272	2025-06-29 21:47:27.284272
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.296069	2025-06-29 21:47:27.296069
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.311068	2025-06-29 21:47:27.311068
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.340102	2025-06-29 21:47:27.340102
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.394753	2025-06-29 21:47:27.394753
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.419243	2025-06-29 21:47:27.419243
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.45399	2025-06-29 21:47:27.45399
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.474651	2025-06-29 21:47:27.474651
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.490985	2025-06-29 21:47:27.490985
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.511903	2025-06-29 21:47:27.511903
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.532399	2025-06-29 21:47:27.532399
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.55015	2025-06-29 21:47:27.55015
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.615229	2025-06-29 21:47:27.615229
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.630913	2025-06-29 21:47:27.630913
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.644959	2025-06-29 21:47:27.644959
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.6608	2025-06-29 21:47:27.6608
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.672992	2025-06-29 21:47:27.672992
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.689678	2025-06-29 21:47:27.689678
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.703663	2025-06-29 21:47:27.703663
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.717733	2025-06-29 21:47:27.717733
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.732301	2025-06-29 21:47:27.732301
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.751947	2025-06-29 21:47:27.751947
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.788452	2025-06-29 21:47:27.788452
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.813098	2025-06-29 21:47:27.813098
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.834709	2025-06-29 21:47:27.834709
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.873283	2025-06-29 21:47:27.873283
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.881752	2025-06-29 21:47:27.881752
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.891443	2025-06-29 21:47:27.891443
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.895427	2025-06-29 21:47:27.895427
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.90193	2025-06-29 21:47:27.90193
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.905901	2025-06-29 21:47:27.905901
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.909777	2025-06-29 21:47:27.909777
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.9136	2025-06-29 21:47:27.9136
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.916839	2025-06-29 21:47:27.916839
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.922274	2025-06-29 21:47:27.922274
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.927508	2025-06-29 21:47:27.927508
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.93151	2025-06-29 21:47:27.93151
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.936985	2025-06-29 21:47:27.936985
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.946197	2025-06-29 21:47:27.946197
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.950936	2025-06-29 21:47:27.950936
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.961473	2025-06-29 21:47:27.961473
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.981149	2025-06-29 21:47:27.981149
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.985534	2025-06-29 21:47:27.985534
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.989741	2025-06-29 21:47:27.989741
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:27.994925	2025-06-29 21:47:27.994925
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.000789	2025-06-29 21:47:28.000789
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.00673	2025-06-29 21:47:28.00673
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.011808	2025-06-29 21:47:28.011808
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.01573	2025-06-29 21:47:28.01573
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.021789	2025-06-29 21:47:28.021789
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.027711	2025-06-29 21:47:28.027711
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.068976	2025-06-29 21:47:28.068976
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.080978	2025-06-29 21:47:28.080978
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.085829	2025-06-29 21:47:28.085829
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.091022	2025-06-29 21:47:28.091022
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.114745	2025-06-29 21:47:28.114745
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.129387	2025-06-29 21:47:28.129387
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.141093	2025-06-29 21:47:28.141093
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.14737	2025-06-29 21:47:28.14737
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.160975	2025-06-29 21:47:28.160975
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.181508	2025-06-29 21:47:28.181508
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.208618	2025-06-29 21:47:28.208618
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.218375	2025-06-29 21:47:28.218375
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.233337	2025-06-29 21:47:28.233337
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.240111	2025-06-29 21:47:28.240111
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.248292	2025-06-29 21:47:28.248292
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.2581	2025-06-29 21:47:28.2581
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.271422	2025-06-29 21:47:28.271422
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.282139	2025-06-29 21:47:28.282139
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.293253	2025-06-29 21:47:28.293253
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.299624	2025-06-29 21:47:28.299624
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.317273	2025-06-29 21:47:28.317273
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.330201	2025-06-29 21:47:28.330201
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.337109	2025-06-29 21:47:28.337109
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.34489	2025-06-29 21:47:28.34489
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.388776	2025-06-29 21:47:28.388776
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.399265	2025-06-29 21:47:28.399265
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.412043	2025-06-29 21:47:28.412043
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.428664	2025-06-29 21:47:28.428664
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.447865	2025-06-29 21:47:28.447865
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.463966	2025-06-29 21:47:28.463966
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.470799	2025-06-29 21:47:28.470799
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.480034	2025-06-29 21:47:28.480034
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.483481	2025-06-29 21:47:28.483481
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.486802	2025-06-29 21:47:28.486802
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.490077	2025-06-29 21:47:28.490077
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.497702	2025-06-29 21:47:28.497702
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.503447	2025-06-29 21:47:28.503447
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.509376	2025-06-29 21:47:28.509376
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.51285	2025-06-29 21:47:28.51285
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.517644	2025-06-29 21:47:28.517644
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.520889	2025-06-29 21:47:28.520889
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.52601	2025-06-29 21:47:28.52601
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.531388	2025-06-29 21:47:28.531388
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.53676	2025-06-29 21:47:28.53676
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.543188	2025-06-29 21:47:28.543188
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.549837	2025-06-29 21:47:28.549837
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.554321	2025-06-29 21:47:28.554321
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.558012	2025-06-29 21:47:28.558012
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.563558	2025-06-29 21:47:28.563558
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.570013	2025-06-29 21:47:28.570013
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.575048	2025-06-29 21:47:28.575048
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.582654	2025-06-29 21:47:28.582654
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.586701	2025-06-29 21:47:28.586701
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.59038	2025-06-29 21:47:28.59038
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.594937	2025-06-29 21:47:28.594937
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.599406	2025-06-29 21:47:28.599406
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.602907	2025-06-29 21:47:28.602907
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.607892	2025-06-29 21:47:28.607892
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.613438	2025-06-29 21:47:28.613438
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.618709	2025-06-29 21:47:28.618709
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.622145	2025-06-29 21:47:28.622145
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.625277	2025-06-29 21:47:28.625277
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.628324	2025-06-29 21:47:28.628324
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.633317	2025-06-29 21:47:28.633317
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.636356	2025-06-29 21:47:28.636356
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.640733	2025-06-29 21:47:28.640733
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.645532	2025-06-29 21:47:28.645532
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.649435	2025-06-29 21:47:28.649435
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.653101	2025-06-29 21:47:28.653101
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.656428	2025-06-29 21:47:28.656428
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.65953	2025-06-29 21:47:28.65953
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.665312	2025-06-29 21:47:28.665312
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.671794	2025-06-29 21:47:28.671794
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.677507	2025-06-29 21:47:28.677507
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-06-29 21:47:28.682682	2025-06-29 21:47:28.682682
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.68804	2025-06-29 21:47:28.68804
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.695734	2025-06-29 21:47:28.695734
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.699227	2025-06-29 21:47:28.699227
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.702449	2025-06-29 21:47:28.702449
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.707608	2025-06-29 21:47:28.707608
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.712828	2025-06-29 21:47:28.712828
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.716633	2025-06-29 21:47:28.716633
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.720144	2025-06-29 21:47:28.720144
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.723429	2025-06-29 21:47:28.723429
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.728398	2025-06-29 21:47:28.728398
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.73275	2025-06-29 21:47:28.73275
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.737482	2025-06-29 21:47:28.737482
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.742786	2025-06-29 21:47:28.742786
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.746379	2025-06-29 21:47:28.746379
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.751675	2025-06-29 21:47:28.751675
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.755349	2025-06-29 21:47:28.755349
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.759055	2025-06-29 21:47:28.759055
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.762569	2025-06-29 21:47:28.762569
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.767989	2025-06-29 21:47:28.767989
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.775439	2025-06-29 21:47:28.775439
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.786399	2025-06-29 21:47:28.786399
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.79158	2025-06-29 21:47:28.79158
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.796179	2025-06-29 21:47:28.796179
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.799719	2025-06-29 21:47:28.799719
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.80316	2025-06-29 21:47:28.80316
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.808534	2025-06-29 21:47:28.808534
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.817012	2025-06-29 21:47:28.817012
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.820404	2025-06-29 21:47:28.820404
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.825408	2025-06-29 21:47:28.825408
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.829681	2025-06-29 21:47:28.829681
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.834919	2025-06-29 21:47:28.834919
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.838938	2025-06-29 21:47:28.838938
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.843553	2025-06-29 21:47:28.843553
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.846919	2025-06-29 21:47:28.846919
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.852799	2025-06-29 21:47:28.852799
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.859216	2025-06-29 21:47:28.859216
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.870004	2025-06-29 21:47:28.870004
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.876284	2025-06-29 21:47:28.876284
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.882418	2025-06-29 21:47:28.882418
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.894868	2025-06-29 21:47:28.894868
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.906405	2025-06-29 21:47:28.906405
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.914845	2025-06-29 21:47:28.914845
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.921881	2025-06-29 21:47:28.921881
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.929443	2025-06-29 21:47:28.929443
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.93724	2025-06-29 21:47:28.93724
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.945928	2025-06-29 21:47:28.945928
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.953184	2025-06-29 21:47:28.953184
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.960363	2025-06-29 21:47:28.960363
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.969863	2025-06-29 21:47:28.969863
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.976187	2025-06-29 21:47:28.976187
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.982422	2025-06-29 21:47:28.982422
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.98798	2025-06-29 21:47:28.98798
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:28.994218	2025-06-29 21:47:28.994218
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.007758	2025-06-29 21:47:29.007758
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.012307	2025-06-29 21:47:29.012307
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.020038	2025-06-29 21:47:29.020038
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.024888	2025-06-29 21:47:29.024888
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.030458	2025-06-29 21:47:29.030458
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.036503	2025-06-29 21:47:29.036503
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.041615	2025-06-29 21:47:29.041615
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.046245	2025-06-29 21:47:29.046245
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.053355	2025-06-29 21:47:29.053355
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.056693	2025-06-29 21:47:29.056693
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.06146	2025-06-29 21:47:29.06146
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.070639	2025-06-29 21:47:29.070639
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.085433	2025-06-29 21:47:29.085433
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.099683	2025-06-29 21:47:29.099683
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.11612	2025-06-29 21:47:29.11612
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.127133	2025-06-29 21:47:29.127133
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.145105	2025-06-29 21:47:29.145105
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.16012	2025-06-29 21:47:29.16012
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.177213	2025-06-29 21:47:29.177213
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.188881	2025-06-29 21:47:29.188881
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.203294	2025-06-29 21:47:29.203294
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.221953	2025-06-29 21:47:29.221953
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.243295	2025-06-29 21:47:29.243295
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.263567	2025-06-29 21:47:29.263567
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.287463	2025-06-29 21:47:29.287463
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.305066	2025-06-29 21:47:29.305066
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.321778	2025-06-29 21:47:29.321778
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.359414	2025-06-29 21:47:29.359414
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.379474	2025-06-29 21:47:29.379474
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.394726	2025-06-29 21:47:29.394726
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.406257	2025-06-29 21:47:29.406257
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.429145	2025-06-29 21:47:29.429145
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.444627	2025-06-29 21:47:29.444627
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.465825	2025-06-29 21:47:29.465825
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.477864	2025-06-29 21:47:29.477864
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.496832	2025-06-29 21:47:29.496832
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.521815	2025-06-29 21:47:29.521815
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.533498	2025-06-29 21:47:29.533498
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.547771	2025-06-29 21:47:29.547771
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.564398	2025-06-29 21:47:29.564398
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.594844	2025-06-29 21:47:29.594844
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.615503	2025-06-29 21:47:29.615503
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.62786	2025-06-29 21:47:29.62786
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.666264	2025-06-29 21:47:29.666264
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.685853	2025-06-29 21:47:29.685853
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.704862	2025-06-29 21:47:29.704862
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.757629	2025-06-29 21:47:29.757629
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.788649	2025-06-29 21:47:29.788649
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.861814	2025-06-29 21:47:29.861814
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.898638	2025-06-29 21:47:29.898638
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.914646	2025-06-29 21:47:29.914646
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.941505	2025-06-29 21:47:29.941505
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:29.983815	2025-06-29 21:47:29.983815
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.016909	2025-06-29 21:47:30.016909
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.032656	2025-06-29 21:47:30.032656
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.049604	2025-06-29 21:47:30.049604
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.073436	2025-06-29 21:47:30.073436
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.101672	2025-06-29 21:47:30.101672
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.133105	2025-06-29 21:47:30.133105
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.164213	2025-06-29 21:47:30.164213
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.185521	2025-06-29 21:47:30.185521
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.231589	2025-06-29 21:47:30.231589
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.251963	2025-06-29 21:47:30.251963
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.266505	2025-06-29 21:47:30.266505
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.282522	2025-06-29 21:47:30.282522
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.301858	2025-06-29 21:47:30.301858
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.331176	2025-06-29 21:47:30.331176
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.377057	2025-06-29 21:47:30.377057
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.393405	2025-06-29 21:47:30.393405
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.40748	2025-06-29 21:47:30.40748
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.426233	2025-06-29 21:47:30.426233
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.446507	2025-06-29 21:47:30.446507
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.463588	2025-06-29 21:47:30.463588
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.48755	2025-06-29 21:47:30.48755
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.507989	2025-06-29 21:47:30.507989
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.536384	2025-06-29 21:47:30.536384
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.55421	2025-06-29 21:47:30.55421
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.571184	2025-06-29 21:47:30.571184
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.591141	2025-06-29 21:47:30.591141
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.616429	2025-06-29 21:47:30.616429
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.644624	2025-06-29 21:47:30.644624
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.664223	2025-06-29 21:47:30.664223
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.694568	2025-06-29 21:47:30.694568
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.711754	2025-06-29 21:47:30.711754
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.736973	2025-06-29 21:47:30.736973
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.759663	2025-06-29 21:47:30.759663
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.782089	2025-06-29 21:47:30.782089
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.801995	2025-06-29 21:47:30.801995
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.820837	2025-06-29 21:47:30.820837
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.838855	2025-06-29 21:47:30.838855
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.854609	2025-06-29 21:47:30.854609
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.870786	2025-06-29 21:47:30.870786
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.884246	2025-06-29 21:47:30.884246
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.901887	2025-06-29 21:47:30.901887
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.937949	2025-06-29 21:47:30.937949
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.951971	2025-06-29 21:47:30.951971
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.973148	2025-06-29 21:47:30.973148
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:30.987816	2025-06-29 21:47:30.987816
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.013254	2025-06-29 21:47:31.013254
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.03313	2025-06-29 21:47:31.03313
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.071673	2025-06-29 21:47:31.071673
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.109553	2025-06-29 21:47:31.109553
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.12956	2025-06-29 21:47:31.12956
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.14744	2025-06-29 21:47:31.14744
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.171069	2025-06-29 21:47:31.171069
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.191131	2025-06-29 21:47:31.191131
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.233406	2025-06-29 21:47:31.233406
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.249358	2025-06-29 21:47:31.249358
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.268525	2025-06-29 21:47:31.268525
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.300419	2025-06-29 21:47:31.300419
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.325455	2025-06-29 21:47:31.325455
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.345056	2025-06-29 21:47:31.345056
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.363337	2025-06-29 21:47:31.363337
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.381327	2025-06-29 21:47:31.381327
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.399332	2025-06-29 21:47:31.399332
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.416604	2025-06-29 21:47:31.416604
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.431646	2025-06-29 21:47:31.431646
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.457547	2025-06-29 21:47:31.457547
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.469901	2025-06-29 21:47:31.469901
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.484187	2025-06-29 21:47:31.484187
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.496111	2025-06-29 21:47:31.496111
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.511891	2025-06-29 21:47:31.511891
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.531264	2025-06-29 21:47:31.531264
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.545219	2025-06-29 21:47:31.545219
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.557639	2025-06-29 21:47:31.557639
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.569675	2025-06-29 21:47:31.569675
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.584432	2025-06-29 21:47:31.584432
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.599391	2025-06-29 21:47:31.599391
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.610731	2025-06-29 21:47:31.610731
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.625313	2025-06-29 21:47:31.625313
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.67709	2025-06-29 21:47:31.67709
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.693805	2025-06-29 21:47:31.693805
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.708887	2025-06-29 21:47:31.708887
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.72438	2025-06-29 21:47:31.72438
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.74154	2025-06-29 21:47:31.74154
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.755856	2025-06-29 21:47:31.755856
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.769012	2025-06-29 21:47:31.769012
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.789239	2025-06-29 21:47:31.789239
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.803748	2025-06-29 21:47:31.803748
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.817676	2025-06-29 21:47:31.817676
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.828537	2025-06-29 21:47:31.828537
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.839544	2025-06-29 21:47:31.839544
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.85495	2025-06-29 21:47:31.85495
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.866909	2025-06-29 21:47:31.866909
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.880826	2025-06-29 21:47:31.880826
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.891804	2025-06-29 21:47:31.891804
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.909391	2025-06-29 21:47:31.909391
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.936051	2025-06-29 21:47:31.936051
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.963765	2025-06-29 21:47:31.963765
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:31.985955	2025-06-29 21:47:31.985955
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.004727	2025-06-29 21:47:32.004727
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.020908	2025-06-29 21:47:32.020908
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.035376	2025-06-29 21:47:32.035376
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.051173	2025-06-29 21:47:32.051173
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.069589	2025-06-29 21:47:32.069589
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.088602	2025-06-29 21:47:32.088602
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.102139	2025-06-29 21:47:32.102139
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.11902	2025-06-29 21:47:32.11902
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.131592	2025-06-29 21:47:32.131592
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.144069	2025-06-29 21:47:32.144069
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.156288	2025-06-29 21:47:32.156288
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.174226	2025-06-29 21:47:32.174226
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.204364	2025-06-29 21:47:32.204364
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.225755	2025-06-29 21:47:32.225755
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.243973	2025-06-29 21:47:32.243973
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.258844	2025-06-29 21:47:32.258844
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.274856	2025-06-29 21:47:32.274856
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.314232	2025-06-29 21:47:32.314232
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.336787	2025-06-29 21:47:32.336787
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.353184	2025-06-29 21:47:32.353184
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.368876	2025-06-29 21:47:32.368876
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.383639	2025-06-29 21:47:32.383639
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.400776	2025-06-29 21:47:32.400776
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.41525	2025-06-29 21:47:32.41525
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.429741	2025-06-29 21:47:32.429741
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.441287	2025-06-29 21:47:32.441287
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.454293	2025-06-29 21:47:32.454293
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.478518	2025-06-29 21:47:32.478518
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.492378	2025-06-29 21:47:32.492378
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.508736	2025-06-29 21:47:32.508736
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.520545	2025-06-29 21:47:32.520545
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.540642	2025-06-29 21:47:32.540642
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.554596	2025-06-29 21:47:32.554596
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.568231	2025-06-29 21:47:32.568231
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.588009	2025-06-29 21:47:32.588009
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.613169	2025-06-29 21:47:32.613169
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.636948	2025-06-29 21:47:32.636948
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.652448	2025-06-29 21:47:32.652448
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.669873	2025-06-29 21:47:32.669873
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.706353	2025-06-29 21:47:32.706353
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.740632	2025-06-29 21:47:32.740632
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.776358	2025-06-29 21:47:32.776358
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.803165	2025-06-29 21:47:32.803165
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.827217	2025-06-29 21:47:32.827217
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.8378	2025-06-29 21:47:32.8378
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.857449	2025-06-29 21:47:32.857449
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.867601	2025-06-29 21:47:32.867601
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.882838	2025-06-29 21:47:32.882838
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.895386	2025-06-29 21:47:32.895386
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.907414	2025-06-29 21:47:32.907414
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.920269	2025-06-29 21:47:32.920269
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.937513	2025-06-29 21:47:32.937513
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.952627	2025-06-29 21:47:32.952627
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.969169	2025-06-29 21:47:32.969169
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.979531	2025-06-29 21:47:32.979531
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.990769	2025-06-29 21:47:32.990769
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.008579	2025-06-29 21:47:33.008579
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.023233	2025-06-29 21:47:33.023233
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.035629	2025-06-29 21:47:33.035629
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.050379	2025-06-29 21:47:33.050379
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.069171	2025-06-29 21:47:33.069171
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.088856	2025-06-29 21:47:33.088856
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.102034	2025-06-29 21:47:33.102034
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.115996	2025-06-29 21:47:33.115996
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.142824	2025-06-29 21:47:33.142824
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.157706	2025-06-29 21:47:33.157706
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.177466	2025-06-29 21:47:33.177466
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.203401	2025-06-29 21:47:33.203401
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.223324	2025-06-29 21:47:33.223324
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.23862	2025-06-29 21:47:33.23862
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.250055	2025-06-29 21:47:33.250055
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.278344	2025-06-29 21:47:33.278344
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.290518	2025-06-29 21:47:33.290518
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.308571	2025-06-29 21:47:33.308571
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.327013	2025-06-29 21:47:33.327013
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.34488	2025-06-29 21:47:33.34488
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.359991	2025-06-29 21:47:33.359991
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.38015	2025-06-29 21:47:33.38015
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.391797	2025-06-29 21:47:33.391797
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.404344	2025-06-29 21:47:33.404344
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.417719	2025-06-29 21:47:33.417719
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.434147	2025-06-29 21:47:33.434147
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.461126	2025-06-29 21:47:33.461126
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.476276	2025-06-29 21:47:33.476276
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.494823	2025-06-29 21:47:33.494823
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.514601	2025-06-29 21:47:33.514601
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.531518	2025-06-29 21:47:33.531518
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.544512	2025-06-29 21:47:33.544512
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.557837	2025-06-29 21:47:33.557837
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.57098	2025-06-29 21:47:33.57098
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.583825	2025-06-29 21:47:33.583825
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.597193	2025-06-29 21:47:33.597193
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.608925	2025-06-29 21:47:33.608925
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.621327	2025-06-29 21:47:33.621327
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.634458	2025-06-29 21:47:33.634458
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.649553	2025-06-29 21:47:33.649553
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.659109	2025-06-29 21:47:33.659109
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.67189	2025-06-29 21:47:33.67189
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.68572	2025-06-29 21:47:33.68572
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.698863	2025-06-29 21:47:33.698863
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.711591	2025-06-29 21:47:33.711591
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.722631	2025-06-29 21:47:33.722631
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.732073	2025-06-29 21:47:33.732073
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.743586	2025-06-29 21:47:33.743586
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.753597	2025-06-29 21:47:33.753597
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.764575	2025-06-29 21:47:33.764575
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.775848	2025-06-29 21:47:33.775848
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.788652	2025-06-29 21:47:33.788652
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.800847	2025-06-29 21:47:33.800847
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.816348	2025-06-29 21:47:33.816348
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.834151	2025-06-29 21:47:33.834151
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.849757	2025-06-29 21:47:33.849757
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.86307	2025-06-29 21:47:33.86307
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.878266	2025-06-29 21:47:33.878266
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.890329	2025-06-29 21:47:33.890329
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.903684	2025-06-29 21:47:33.903684
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.915266	2025-06-29 21:47:33.915266
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.932516	2025-06-29 21:47:33.932516
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.945426	2025-06-29 21:47:33.945426
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.960147	2025-06-29 21:47:33.960147
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.973313	2025-06-29 21:47:33.973313
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.988216	2025-06-29 21:47:33.988216
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.004212	2025-06-29 21:47:34.004212
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.018495	2025-06-29 21:47:34.018495
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.031588	2025-06-29 21:47:34.031588
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.044511	2025-06-29 21:47:34.044511
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.057511	2025-06-29 21:47:34.057511
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.162314	2025-06-29 21:47:34.162314
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.287497	2025-06-29 21:47:34.287497
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.322539	2025-06-29 21:47:34.322539
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.337904	2025-06-29 21:47:34.337904
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.355069	2025-06-29 21:47:34.355069
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.37105	2025-06-29 21:47:34.37105
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:34.38748	2025-06-29 21:47:34.38748
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.550068	2025-06-29 21:47:33.550068
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.563348	2025-06-29 21:47:33.563348
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.135483	2025-06-29 21:47:32.135483
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.156383	2025-06-29 21:47:32.156383
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.17053	2025-06-29 21:47:32.17053
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.209903	2025-06-29 21:47:32.209903
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.229067	2025-06-29 21:47:32.229067
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.244245	2025-06-29 21:47:32.244245
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.262669	2025-06-29 21:47:32.262669
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.27916	2025-06-29 21:47:32.27916
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.294428	2025-06-29 21:47:32.294428
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.306083	2025-06-29 21:47:32.306083
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.319991	2025-06-29 21:47:32.319991
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.336233	2025-06-29 21:47:32.336233
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.351033	2025-06-29 21:47:32.351033
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.362535	2025-06-29 21:47:32.362535
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.378856	2025-06-29 21:47:32.378856
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.398107	2025-06-29 21:47:32.398107
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.414237	2025-06-29 21:47:32.414237
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.44666	2025-06-29 21:47:32.44666
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.477944	2025-06-29 21:47:32.477944
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.510865	2025-06-29 21:47:32.510865
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.530773	2025-06-29 21:47:32.530773
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.546288	2025-06-29 21:47:32.546288
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.573559	2025-06-29 21:47:32.573559
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.606357	2025-06-29 21:47:32.606357
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.626567	2025-06-29 21:47:32.626567
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.670622	2025-06-29 21:47:32.670622
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.688005	2025-06-29 21:47:32.688005
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.707809	2025-06-29 21:47:32.707809
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.729492	2025-06-29 21:47:32.729492
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.749974	2025-06-29 21:47:32.749974
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.773531	2025-06-29 21:47:32.773531
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.791481	2025-06-29 21:47:32.791481
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.810376	2025-06-29 21:47:32.810376
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.835003	2025-06-29 21:47:32.835003
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.888057	2025-06-29 21:47:32.888057
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.92135	2025-06-29 21:47:32.92135
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:32.974687	2025-06-29 21:47:32.974687
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.019334	2025-06-29 21:47:33.019334
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.059292	2025-06-29 21:47:33.059292
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.076642	2025-06-29 21:47:33.076642
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.102243	2025-06-29 21:47:33.102243
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.119731	2025-06-29 21:47:33.119731
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.148437	2025-06-29 21:47:33.148437
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.174284	2025-06-29 21:47:33.174284
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.189386	2025-06-29 21:47:33.189386
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.202163	2025-06-29 21:47:33.202163
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.217696	2025-06-29 21:47:33.217696
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.230551	2025-06-29 21:47:33.230551
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.248871	2025-06-29 21:47:33.248871
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.265731	2025-06-29 21:47:33.265731
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.279142	2025-06-29 21:47:33.279142
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.291511	2025-06-29 21:47:33.291511
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.305719	2025-06-29 21:47:33.305719
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.319486	2025-06-29 21:47:33.319486
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.332237	2025-06-29 21:47:33.332237
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.350391	2025-06-29 21:47:33.350391
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.363452	2025-06-29 21:47:33.363452
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.374915	2025-06-29 21:47:33.374915
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.394123	2025-06-29 21:47:33.394123
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.406917	2025-06-29 21:47:33.406917
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.419345	2025-06-29 21:47:33.419345
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.433034	2025-06-29 21:47:33.433034
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.445379	2025-06-29 21:47:33.445379
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.457223	2025-06-29 21:47:33.457223
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.478894	2025-06-29 21:47:33.478894
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.495821	2025-06-29 21:47:33.495821
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.511024	2025-06-29 21:47:33.511024
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.5268	2025-06-29 21:47:33.5268
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.542167	2025-06-29 21:47:33.542167
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.554037	2025-06-29 21:47:33.554037
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.573706	2025-06-29 21:47:33.573706
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.58736	2025-06-29 21:47:33.58736
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.605414	2025-06-29 21:47:33.605414
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.619939	2025-06-29 21:47:33.619939
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.637675	2025-06-29 21:47:33.637675
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.653366	2025-06-29 21:47:33.653366
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.666892	2025-06-29 21:47:33.666892
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-06-29 21:47:33.681288	2025-06-29 21:47:33.681288
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.698535	2025-06-29 21:47:33.698535
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.711099	2025-06-29 21:47:33.711099
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.726709	2025-06-29 21:47:33.726709
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.755138	2025-06-29 21:47:33.755138
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.808934	2025-06-29 21:47:33.808934
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.846123	2025-06-29 21:47:33.846123
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.879361	2025-06-29 21:47:33.879361
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.898962	2025-06-29 21:47:33.898962
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.917897	2025-06-29 21:47:33.917897
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.951436	2025-06-29 21:47:33.951436
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:33.98029	2025-06-29 21:47:33.98029
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.007173	2025-06-29 21:47:34.007173
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.018776	2025-06-29 21:47:34.018776
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.03479	2025-06-29 21:47:34.03479
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.049505	2025-06-29 21:47:34.049505
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.064572	2025-06-29 21:47:34.064572
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.087199	2025-06-29 21:47:34.087199
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.103351	2025-06-29 21:47:34.103351
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.124479	2025-06-29 21:47:34.124479
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.150152	2025-06-29 21:47:34.150152
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.169664	2025-06-29 21:47:34.169664
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.293271	2025-06-29 21:47:34.293271
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.384984	2025-06-29 21:47:34.384984
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.45005	2025-06-29 21:47:34.45005
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.483504	2025-06-29 21:47:34.483504
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.505501	2025-06-29 21:47:34.505501
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.536143	2025-06-29 21:47:34.536143
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.597287	2025-06-29 21:47:34.597287
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.613869	2025-06-29 21:47:34.613869
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.685929	2025-06-29 21:47:34.685929
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.740824	2025-06-29 21:47:34.740824
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.788973	2025-06-29 21:47:34.788973
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.837124	2025-06-29 21:47:34.837124
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:34.954742	2025-06-29 21:47:34.954742
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.025301	2025-06-29 21:47:35.025301
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.082844	2025-06-29 21:47:35.082844
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.182178	2025-06-29 21:47:35.182178
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.267154	2025-06-29 21:47:35.267154
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.445691	2025-06-29 21:47:35.445691
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.493059	2025-06-29 21:47:35.493059
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.583098	2025-06-29 21:47:35.583098
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.70186	2025-06-29 21:47:35.70186
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.751507	2025-06-29 21:47:35.751507
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.769234	2025-06-29 21:47:35.769234
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.857563	2025-06-29 21:47:35.857563
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.936341	2025-06-29 21:47:35.936341
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:35.979109	2025-06-29 21:47:35.979109
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.047834	2025-06-29 21:47:36.047834
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.078181	2025-06-29 21:47:36.078181
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.089581	2025-06-29 21:47:36.089581
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.110213	2025-06-29 21:47:36.110213
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.156992	2025-06-29 21:47:36.156992
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.197379	2025-06-29 21:47:36.197379
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.246517	2025-06-29 21:47:36.246517
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.280624	2025-06-29 21:47:36.280624
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.297809	2025-06-29 21:47:36.297809
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.328075	2025-06-29 21:47:36.328075
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.368338	2025-06-29 21:47:36.368338
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.430574	2025-06-29 21:47:36.430574
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.5944	2025-06-29 21:47:36.5944
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.77951	2025-06-29 21:47:36.77951
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:36.849635	2025-06-29 21:47:36.849635
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.074966	2025-06-29 21:47:37.074966
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.195343	2025-06-29 21:47:37.195343
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.246413	2025-06-29 21:47:37.246413
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.32093	2025-06-29 21:47:37.32093
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.44636	2025-06-29 21:47:37.44636
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.564935	2025-06-29 21:47:37.564935
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.610537	2025-06-29 21:47:37.610537
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.626918	2025-06-29 21:47:37.626918
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.632913	2025-06-29 21:47:37.632913
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.636978	2025-06-29 21:47:37.636978
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.641666	2025-06-29 21:47:37.641666
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.645575	2025-06-29 21:47:37.645575
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.658702	2025-06-29 21:47:37.658702
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.663823	2025-06-29 21:47:37.663823
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.669892	2025-06-29 21:47:37.669892
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.678633	2025-06-29 21:47:37.678633
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.717448	2025-06-29 21:47:37.717448
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.725507	2025-06-29 21:47:37.725507
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.768916	2025-06-29 21:47:37.768916
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.780503	2025-06-29 21:47:37.780503
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.783971	2025-06-29 21:47:37.783971
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.824666	2025-06-29 21:47:37.824666
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.834125	2025-06-29 21:47:37.834125
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.837438	2025-06-29 21:47:37.837438
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.875321	2025-06-29 21:47:37.875321
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.883679	2025-06-29 21:47:37.883679
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.889378	2025-06-29 21:47:37.889378
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.895075	2025-06-29 21:47:37.895075
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.927792	2025-06-29 21:47:37.927792
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.937072	2025-06-29 21:47:37.937072
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.942117	2025-06-29 21:47:37.942117
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.94713	2025-06-29 21:47:37.94713
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.953518	2025-06-29 21:47:37.953518
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.95912	2025-06-29 21:47:37.95912
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.966085	2025-06-29 21:47:37.966085
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.972292	2025-06-29 21:47:37.972292
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.977761	2025-06-29 21:47:37.977761
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.982246	2025-06-29 21:47:37.982246
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.988189	2025-06-29 21:47:37.988189
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:37.995347	2025-06-29 21:47:37.995347
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.000527	2025-06-29 21:47:38.000527
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.006868	2025-06-29 21:47:38.006868
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.010285	2025-06-29 21:47:38.010285
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.01558	2025-06-29 21:47:38.01558
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.018779	2025-06-29 21:47:38.018779
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.023994	2025-06-29 21:47:38.023994
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.029314	2025-06-29 21:47:38.029314
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.034315	2025-06-29 21:47:38.034315
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.039645	2025-06-29 21:47:38.039645
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.046621	2025-06-29 21:47:38.046621
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.051692	2025-06-29 21:47:38.051692
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.054713	2025-06-29 21:47:38.054713
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.060241	2025-06-29 21:47:38.060241
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.064586	2025-06-29 21:47:38.064586
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.067543	2025-06-29 21:47:38.067543
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.072902	2025-06-29 21:47:38.072902
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.077225	2025-06-29 21:47:38.077225
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.083859	2025-06-29 21:47:38.083859
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.088424	2025-06-29 21:47:38.088424
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.113092	2025-06-29 21:47:38.113092
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.11816	2025-06-29 21:47:38.11816
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.125274	2025-06-29 21:47:38.125274
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-06-29 21:47:38.128717	2025-06-29 21:47:38.128717
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 21:47:16.299132
2	ART Coverage	\N	\N	2025-06-29 21:47:16.312887
3	People Living with HIV	\N	\N	2025-06-29 21:47:16.318522
4	HIV-related Deaths	\N	\N	2025-06-29 21:47:16.327535
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 21:47:16.338549
6	ART Pediatric Coverage	\N	\N	2025-06-29 21:47:16.343128
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$/vWsCoV0OBYRnlFOQB7Kq.gzw4HpEJN0relocjjHBeUwEiUoMnWdm	admin	0	2025-06-29 21:47:16.283067	2025-06-29 21:47:16.283067
2	userch	$2b$12$U2zUF6EvWuFcn/8zufkpPeMRNzSmYyeEvuIzOvxj8gJfdRnNKQK3.	user	0	2025-06-29 21:47:16.289977	2025-06-29 21:47:16.289977
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

