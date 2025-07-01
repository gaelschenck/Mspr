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
1	Afghanistan	Eastern Mediterranean	\N	2025-07-01 04:23:18.193715	2025-07-01 04:23:18.193715
2	Albania	Europe	\N	2025-07-01 04:23:18.202589	2025-07-01 04:23:18.202589
3	Algeria	Africa	\N	2025-07-01 04:23:18.213502	2025-07-01 04:23:18.213502
4	Angola	Africa	\N	2025-07-01 04:23:18.224778	2025-07-01 04:23:18.224778
5	Argentina	Americas	\N	2025-07-01 04:23:18.234781	2025-07-01 04:23:18.234781
6	Armenia	Europe	\N	2025-07-01 04:23:18.243921	2025-07-01 04:23:18.243921
7	Australia	Western Pacific	\N	2025-07-01 04:23:18.254626	2025-07-01 04:23:18.254626
8	Austria	Europe	\N	2025-07-01 04:23:18.264696	2025-07-01 04:23:18.264696
9	Azerbaijan	Europe	\N	2025-07-01 04:23:18.278507	2025-07-01 04:23:18.278507
10	Bahamas	Americas	\N	2025-07-01 04:23:18.289123	2025-07-01 04:23:18.289123
11	Bahrain	Eastern Mediterranean	\N	2025-07-01 04:23:18.300039	2025-07-01 04:23:18.300039
12	Bangladesh	South-East Asia	\N	2025-07-01 04:23:18.310806	2025-07-01 04:23:18.310806
13	Barbados	Americas	\N	2025-07-01 04:23:18.321787	2025-07-01 04:23:18.321787
14	Belarus	Europe	\N	2025-07-01 04:23:18.334907	2025-07-01 04:23:18.334907
15	Belgium	Europe	\N	2025-07-01 04:23:18.346662	2025-07-01 04:23:18.346662
16	Belize	Americas	\N	2025-07-01 04:23:18.358079	2025-07-01 04:23:18.358079
17	Benin	Africa	\N	2025-07-01 04:23:18.369952	2025-07-01 04:23:18.369952
18	Bhutan	South-East Asia	\N	2025-07-01 04:23:18.380557	2025-07-01 04:23:18.380557
19	Bolivia	Americas	\N	2025-07-01 04:23:18.390619	2025-07-01 04:23:18.390619
20	Bosnia and Herzegovina	Europe	\N	2025-07-01 04:23:18.401821	2025-07-01 04:23:18.401821
21	Botswana	Africa	\N	2025-07-01 04:23:18.415267	2025-07-01 04:23:18.415267
22	Brazil	Americas	\N	2025-07-01 04:23:18.429642	2025-07-01 04:23:18.429642
23	Brunei Darussalam	Western Pacific	\N	2025-07-01 04:23:18.441184	2025-07-01 04:23:18.441184
24	Bulgaria	Europe	\N	2025-07-01 04:23:18.453068	2025-07-01 04:23:18.453068
25	Burkina Faso	Africa	\N	2025-07-01 04:23:18.466235	2025-07-01 04:23:18.466235
26	Burundi	Africa	\N	2025-07-01 04:23:18.479764	2025-07-01 04:23:18.479764
27	Cabo Verde	Africa	\N	2025-07-01 04:23:18.499659	2025-07-01 04:23:18.499659
28	Cambodia	Western Pacific	\N	2025-07-01 04:23:18.510845	2025-07-01 04:23:18.510845
29	Cameroon	Africa	\N	2025-07-01 04:23:18.520909	2025-07-01 04:23:18.520909
30	Canada	Americas	\N	2025-07-01 04:23:18.531925	2025-07-01 04:23:18.531925
31	Central African Republic	Africa	\N	2025-07-01 04:23:18.541952	2025-07-01 04:23:18.541952
32	Chad	Africa	\N	2025-07-01 04:23:18.55307	2025-07-01 04:23:18.55307
33	Chile	Americas	\N	2025-07-01 04:23:18.562481	2025-07-01 04:23:18.562481
34	China	Western Pacific	\N	2025-07-01 04:23:18.575224	2025-07-01 04:23:18.575224
35	Colombia	Americas	\N	2025-07-01 04:23:18.584429	2025-07-01 04:23:18.584429
36	Comoros	Africa	\N	2025-07-01 04:23:18.595682	2025-07-01 04:23:18.595682
37	Congo	Americas	\N	2025-07-01 04:23:18.606565	2025-07-01 04:23:18.606565
38	Costa Rica	Americas	\N	2025-07-01 04:23:18.617101	2025-07-01 04:23:18.617101
39	Côte d'Ivoire	Africa	\N	2025-07-01 04:23:18.626981	2025-07-01 04:23:18.626981
40	Croatia	Europe	\N	2025-07-01 04:23:18.636073	2025-07-01 04:23:18.636073
41	Cuba	Americas	\N	2025-07-01 04:23:18.646444	2025-07-01 04:23:18.646444
42	Cyprus	Europe	\N	2025-07-01 04:23:18.658926	2025-07-01 04:23:18.658926
43	Czechia	Europe	\N	2025-07-01 04:23:18.670667	2025-07-01 04:23:18.670667
44	North Korea	Western Pacific	\N	2025-07-01 04:23:18.680965	2025-07-01 04:23:18.680965
45	DR Congo	Africa	\N	2025-07-01 04:23:18.692367	2025-07-01 04:23:18.692367
46	Denmark	Europe	\N	2025-07-01 04:23:18.703315	2025-07-01 04:23:18.703315
47	Djibouti	Eastern Mediterranean	\N	2025-07-01 04:23:18.71339	2025-07-01 04:23:18.71339
48	Dominican Republic	Americas	\N	2025-07-01 04:23:18.725577	2025-07-01 04:23:18.725577
49	Ecuador	Americas	\N	2025-07-01 04:23:18.73903	2025-07-01 04:23:18.73903
50	Egypt	Eastern Mediterranean	\N	2025-07-01 04:23:18.749003	2025-07-01 04:23:18.749003
51	El Salvador	Americas	\N	2025-07-01 04:23:18.759471	2025-07-01 04:23:18.759471
52	Equatorial Guinea	Africa	\N	2025-07-01 04:23:18.769146	2025-07-01 04:23:18.769146
53	Eritrea	Africa	\N	2025-07-01 04:23:18.779654	2025-07-01 04:23:18.779654
54	Estonia	Europe	\N	2025-07-01 04:23:18.794226	2025-07-01 04:23:18.794226
55	Eswatini	Africa	\N	2025-07-01 04:23:18.805691	2025-07-01 04:23:18.805691
56	Ethiopia	Africa	\N	2025-07-01 04:23:18.817634	2025-07-01 04:23:18.817634
57	Fiji	Western Pacific	\N	2025-07-01 04:23:18.828159	2025-07-01 04:23:18.828159
58	Finland	Europe	\N	2025-07-01 04:23:18.839066	2025-07-01 04:23:18.839066
59	France	Europe	\N	2025-07-01 04:23:18.848756	2025-07-01 04:23:18.848756
60	Gabon	Africa	\N	2025-07-01 04:23:18.864314	2025-07-01 04:23:18.864314
61	Gambia	Africa	\N	2025-07-01 04:23:18.880601	2025-07-01 04:23:18.880601
62	Georgia	Europe	\N	2025-07-01 04:23:18.891496	2025-07-01 04:23:18.891496
63	Germany	Europe	\N	2025-07-01 04:23:18.905718	2025-07-01 04:23:18.905718
64	Ghana	Africa	\N	2025-07-01 04:23:18.921477	2025-07-01 04:23:18.921477
65	Greece	Europe	\N	2025-07-01 04:23:18.931713	2025-07-01 04:23:18.931713
66	Guatemala	Americas	\N	2025-07-01 04:23:18.946134	2025-07-01 04:23:18.946134
67	Guinea	Africa	\N	2025-07-01 04:23:18.958693	2025-07-01 04:23:18.958693
68	Guinea-Bissau	Africa	\N	2025-07-01 04:23:18.97088	2025-07-01 04:23:18.97088
69	Guyana	Americas	\N	2025-07-01 04:23:18.981189	2025-07-01 04:23:18.981189
70	Haiti	Americas	\N	2025-07-01 04:23:19.001251	2025-07-01 04:23:19.001251
71	Honduras	Americas	\N	2025-07-01 04:23:19.012286	2025-07-01 04:23:19.012286
72	Hungary	Europe	\N	2025-07-01 04:23:19.02236	2025-07-01 04:23:19.02236
73	Iceland	Europe	\N	2025-07-01 04:23:19.032907	2025-07-01 04:23:19.032907
74	India	South-East Asia	\N	2025-07-01 04:23:19.045712	2025-07-01 04:23:19.045712
75	Indonesia	South-East Asia	\N	2025-07-01 04:23:19.061843	2025-07-01 04:23:19.061843
76	Iran	Eastern Mediterranean	\N	2025-07-01 04:23:19.076798	2025-07-01 04:23:19.076798
77	Ireland	Europe	\N	2025-07-01 04:23:19.090042	2025-07-01 04:23:19.090042
78	Israel	Europe	\N	2025-07-01 04:23:19.100594	2025-07-01 04:23:19.100594
79	Italy	Europe	\N	2025-07-01 04:23:19.113269	2025-07-01 04:23:19.113269
80	Jamaica	Americas	\N	2025-07-01 04:23:19.124349	2025-07-01 04:23:19.124349
81	Japan	Western Pacific	\N	2025-07-01 04:23:19.136028	2025-07-01 04:23:19.136028
82	Jordan	Eastern Mediterranean	\N	2025-07-01 04:23:19.147248	2025-07-01 04:23:19.147248
83	Kazakhstan	Europe	\N	2025-07-01 04:23:19.169407	2025-07-01 04:23:19.169407
84	Kenya	Africa	\N	2025-07-01 04:23:19.185577	2025-07-01 04:23:19.185577
85	Kuwait	Eastern Mediterranean	\N	2025-07-01 04:23:19.199967	2025-07-01 04:23:19.199967
86	Kyrgyzstan	Europe	\N	2025-07-01 04:23:19.213905	2025-07-01 04:23:19.213905
87	Laos	Western Pacific	\N	2025-07-01 04:23:19.226111	2025-07-01 04:23:19.226111
88	Latvia	Europe	\N	2025-07-01 04:23:19.237213	2025-07-01 04:23:19.237213
89	Lebanon	Eastern Mediterranean	\N	2025-07-01 04:23:19.248603	2025-07-01 04:23:19.248603
90	Lesotho	Africa	\N	2025-07-01 04:23:19.258556	2025-07-01 04:23:19.258556
91	Liberia	Africa	\N	2025-07-01 04:23:19.269032	2025-07-01 04:23:19.269032
92	Libya	Eastern Mediterranean	\N	2025-07-01 04:23:19.281923	2025-07-01 04:23:19.281923
93	Lithuania	Europe	\N	2025-07-01 04:23:19.294956	2025-07-01 04:23:19.294956
94	Luxembourg	Europe	\N	2025-07-01 04:23:19.307789	2025-07-01 04:23:19.307789
95	Madagascar	Africa	\N	2025-07-01 04:23:19.321705	2025-07-01 04:23:19.321705
96	Malawi	Africa	\N	2025-07-01 04:23:19.331737	2025-07-01 04:23:19.331737
97	Malaysia	Western Pacific	\N	2025-07-01 04:23:19.344576	2025-07-01 04:23:19.344576
98	Maldives	South-East Asia	\N	2025-07-01 04:23:19.383525	2025-07-01 04:23:19.383525
99	Mali	Africa	\N	2025-07-01 04:23:19.407283	2025-07-01 04:23:19.407283
100	Malta	Europe	\N	2025-07-01 04:23:19.422513	2025-07-01 04:23:19.422513
101	Mauritania	Africa	\N	2025-07-01 04:23:19.439347	2025-07-01 04:23:19.439347
102	Mauritius	Africa	\N	2025-07-01 04:23:19.457874	2025-07-01 04:23:19.457874
103	Mexico	Americas	\N	2025-07-01 04:23:19.471519	2025-07-01 04:23:19.471519
104	Mongolia	Western Pacific	\N	2025-07-01 04:23:19.4861	2025-07-01 04:23:19.4861
105	Montenegro	Europe	\N	2025-07-01 04:23:19.500748	2025-07-01 04:23:19.500748
106	Morocco	Eastern Mediterranean	\N	2025-07-01 04:23:19.513684	2025-07-01 04:23:19.513684
107	Mozambique	Africa	\N	2025-07-01 04:23:19.530072	2025-07-01 04:23:19.530072
108	Myanmar	South-East Asia	\N	2025-07-01 04:23:19.546382	2025-07-01 04:23:19.546382
109	Namibia	Africa	\N	2025-07-01 04:23:19.55751	2025-07-01 04:23:19.55751
110	Nepal	South-East Asia	\N	2025-07-01 04:23:19.571931	2025-07-01 04:23:19.571931
111	Netherlands	Europe	\N	2025-07-01 04:23:19.648727	2025-07-01 04:23:19.648727
112	New Zealand	Western Pacific	\N	2025-07-01 04:23:19.661544	2025-07-01 04:23:19.661544
113	Nicaragua	Americas	\N	2025-07-01 04:23:19.675782	2025-07-01 04:23:19.675782
114	Niger	Africa	\N	2025-07-01 04:23:19.687892	2025-07-01 04:23:19.687892
115	Nigeria	Africa	\N	2025-07-01 04:23:19.701244	2025-07-01 04:23:19.701244
116	Norway	Europe	\N	2025-07-01 04:23:19.720817	2025-07-01 04:23:19.720817
117	Oman	Eastern Mediterranean	\N	2025-07-01 04:23:19.734036	2025-07-01 04:23:19.734036
118	Pakistan	Eastern Mediterranean	\N	2025-07-01 04:23:19.744262	2025-07-01 04:23:19.744262
119	Panama	Americas	\N	2025-07-01 04:23:19.759143	2025-07-01 04:23:19.759143
120	Papua New Guinea	Western Pacific	\N	2025-07-01 04:23:19.770164	2025-07-01 04:23:19.770164
121	Paraguay	Americas	\N	2025-07-01 04:23:19.780101	2025-07-01 04:23:19.780101
122	Peru	Americas	\N	2025-07-01 04:23:19.790505	2025-07-01 04:23:19.790505
123	Philippines	Western Pacific	\N	2025-07-01 04:23:19.802355	2025-07-01 04:23:19.802355
124	Poland	Europe	\N	2025-07-01 04:23:19.814449	2025-07-01 04:23:19.814449
125	Portugal	Europe	\N	2025-07-01 04:23:19.825474	2025-07-01 04:23:19.825474
126	Qatar	Eastern Mediterranean	\N	2025-07-01 04:23:19.837099	2025-07-01 04:23:19.837099
127	South Korea	Western Pacific	\N	2025-07-01 04:23:19.850747	2025-07-01 04:23:19.850747
128	Moldova	Europe	\N	2025-07-01 04:23:19.863653	2025-07-01 04:23:19.863653
129	North Macedonia	Europe	\N	2025-07-01 04:23:19.874852	2025-07-01 04:23:19.874852
130	Romania	Europe	\N	2025-07-01 04:23:19.91647	2025-07-01 04:23:19.91647
131	Russia	Europe	\N	2025-07-01 04:23:19.93096	2025-07-01 04:23:19.93096
132	Rwanda	Africa	\N	2025-07-01 04:23:19.945181	2025-07-01 04:23:19.945181
133	Saudi Arabia	Eastern Mediterranean	\N	2025-07-01 04:23:19.980817	2025-07-01 04:23:19.980817
134	Senegal	Africa	\N	2025-07-01 04:23:19.995101	2025-07-01 04:23:19.995101
135	Serbia	Europe	\N	2025-07-01 04:23:20.009408	2025-07-01 04:23:20.009408
136	Sierra Leone	Africa	\N	2025-07-01 04:23:20.047932	2025-07-01 04:23:20.047932
137	Singapore	Western Pacific	\N	2025-07-01 04:23:20.059819	2025-07-01 04:23:20.059819
138	Slovakia	Europe	\N	2025-07-01 04:23:20.072322	2025-07-01 04:23:20.072322
139	Slovenia	Europe	\N	2025-07-01 04:23:20.082251	2025-07-01 04:23:20.082251
140	Somalia	Eastern Mediterranean	\N	2025-07-01 04:23:20.095676	2025-07-01 04:23:20.095676
141	South Africa	Africa	\N	2025-07-01 04:23:20.105433	2025-07-01 04:23:20.105433
142	South Sudan	Africa	\N	2025-07-01 04:23:20.118036	2025-07-01 04:23:20.118036
143	Spain	Europe	\N	2025-07-01 04:23:20.131285	2025-07-01 04:23:20.131285
144	Sri Lanka	South-East Asia	\N	2025-07-01 04:23:20.145897	2025-07-01 04:23:20.145897
145	Sudan	Eastern Mediterranean	\N	2025-07-01 04:23:20.159531	2025-07-01 04:23:20.159531
146	Suriname	Americas	\N	2025-07-01 04:23:20.176094	2025-07-01 04:23:20.176094
147	Sweden	Europe	\N	2025-07-01 04:23:20.18945	2025-07-01 04:23:20.18945
148	Switzerland	Europe	\N	2025-07-01 04:23:20.201606	2025-07-01 04:23:20.201606
149	Syria	Eastern Mediterranean	\N	2025-07-01 04:23:20.217013	2025-07-01 04:23:20.217013
150	Tajikistan	Europe	\N	2025-07-01 04:23:20.22997	2025-07-01 04:23:20.22997
151	Thailand	South-East Asia	\N	2025-07-01 04:23:20.24167	2025-07-01 04:23:20.24167
152	Timor-Leste	South-East Asia	\N	2025-07-01 04:23:20.272763	2025-07-01 04:23:20.272763
153	Togo	Africa	\N	2025-07-01 04:23:20.284726	2025-07-01 04:23:20.284726
154	Trinidad and Tobago	Americas	\N	2025-07-01 04:23:20.31333	2025-07-01 04:23:20.31333
155	Tunisia	Eastern Mediterranean	\N	2025-07-01 04:23:20.339352	2025-07-01 04:23:20.339352
156	Turkey	Europe	\N	2025-07-01 04:23:20.35845	2025-07-01 04:23:20.35845
157	Turkmenistan	Europe	\N	2025-07-01 04:23:20.373748	2025-07-01 04:23:20.373748
158	Uganda	Africa	\N	2025-07-01 04:23:20.388567	2025-07-01 04:23:20.388567
159	Ukraine	Europe	\N	2025-07-01 04:23:20.406567	2025-07-01 04:23:20.406567
160	United Arab Emirates	Eastern Mediterranean	\N	2025-07-01 04:23:20.438945	2025-07-01 04:23:20.438945
161	United Kingdom	Europe	\N	2025-07-01 04:23:20.452742	2025-07-01 04:23:20.452742
162	Tanzania	Africa	\N	2025-07-01 04:23:20.474891	2025-07-01 04:23:20.474891
163	United States	Americas	\N	2025-07-01 04:23:20.498642	2025-07-01 04:23:20.498642
164	Uruguay	Americas	\N	2025-07-01 04:23:20.51813	2025-07-01 04:23:20.51813
165	Uzbekistan	Europe	\N	2025-07-01 04:23:20.528861	2025-07-01 04:23:20.528861
166	Venezuela	Americas	\N	2025-07-01 04:23:20.553237	2025-07-01 04:23:20.553237
167	Viet Nam	Western Pacific	\N	2025-07-01 04:23:20.575516	2025-07-01 04:23:20.575516
168	Yemen	Eastern Mediterranean	\N	2025-07-01 04:23:20.588233	2025-07-01 04:23:20.588233
169	Zambia	Africa	\N	2025-07-01 04:23:20.599377	2025-07-01 04:23:20.599377
170	Zimbabwe	Africa	\N	2025-07-01 04:23:20.611289	2025-07-01 04:23:20.611289
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
3401	1	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.622526	2025-07-01 04:23:20.622526
3402	1	1	2023	needing_antiretrovirals	200.00	\N	100.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.634435	2025-07-01 04:23:20.634435
3403	1	1	2023	percentage_received	11.00	\N	7.00	18.00	11.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.643646	2025-07-01 04:23:20.643646
3407	3	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.657279	2025-07-01 04:23:20.657279
3408	3	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.67232	2025-07-01 04:23:20.67232
3409	3	1	2023	percentage_received	74.00	\N	69.00	78.00	74.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.689931	2025-07-01 04:23:20.689931
3410	4	1	2023	received_antiretrovirals	9600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.703705	2025-07-01 04:23:20.703705
3411	4	1	2023	needing_antiretrovirals	25000.00	\N	19000.00	32000.00	25000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.71759	2025-07-01 04:23:20.71759
3412	4	1	2023	percentage_received	38.00	\N	29.00	48.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.730176	2025-07-01 04:23:20.730176
3413	5	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.748649	2025-07-01 04:23:20.748649
3414	5	1	2023	needing_antiretrovirals	1800.00	\N	1600.00	2000.00	1800.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.766534	2025-07-01 04:23:20.766534
3415	5	1	2023	percentage_received	95.00	\N	85.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.783418	2025-07-01 04:23:20.783418
3416	6	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.799903	2025-07-01 04:23:20.799903
3420	7	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.812884	2025-07-01 04:23:20.812884
3428	10	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.8405	2025-07-01 04:23:20.8405
3429	10	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.857044	2025-07-01 04:23:20.857044
3430	10	1	2023	percentage_received	58.00	\N	51.00	65.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.868081	2025-07-01 04:23:20.868081
3431	11	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.891192	2025-07-01 04:23:20.891192
3434	12	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.905469	2025-07-01 04:23:20.905469
3435	12	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.924763	2025-07-01 04:23:20.924763
3436	12	1	2023	percentage_received	28.00	\N	24.00	33.00	28.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.942521	2025-07-01 04:23:20.942521
3437	13	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.952892	2025-07-01 04:23:20.952892
3440	14	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.965179	2025-07-01 04:23:20.965179
3441	14	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:20.984239	2025-07-01 04:23:20.984239
3442	14	1	2023	percentage_received	90.00	\N	67.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.000953	2025-07-01 04:23:21.000953
3446	16	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.014351	2025-07-01 04:23:21.014351
3447	16	1	2023	needing_antiretrovirals	100.00	\N	100.00	200.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.032782	2025-07-01 04:23:21.032782
3448	16	1	2023	percentage_received	44.00	\N	39.00	49.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.048117	2025-07-01 04:23:21.048117
3449	17	1	2023	received_antiretrovirals	4600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.061463	2025-07-01 04:23:21.061463
3450	17	1	2023	needing_antiretrovirals	2600.00	\N	1600.00	4300.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.085754	2025-07-01 04:23:21.085754
3451	17	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.095931	2025-07-01 04:23:21.095931
3455	19	1	2023	received_antiretrovirals	350.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.111388	2025-07-01 04:23:21.111388
3456	19	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.125719	2025-07-01 04:23:21.125719
3457	19	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.138286	2025-07-01 04:23:21.138286
3461	21	1	2023	received_antiretrovirals	12400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.15922	2025-07-01 04:23:21.15922
3462	21	1	2023	needing_antiretrovirals	13000.00	\N	10000.00	14000.00	13000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.173938	2025-07-01 04:23:21.173938
3463	21	1	2023	percentage_received	95.00	\N	77.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.348896	2025-07-01 04:23:21.348896
3467	23	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.37924	2025-07-01 04:23:21.37924
3473	25	1	2023	received_antiretrovirals	4700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.398538	2025-07-01 04:23:21.398538
3474	25	1	2023	needing_antiretrovirals	4900.00	\N	3600.00	6100.00	4900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.481157	2025-07-01 04:23:21.481157
3475	25	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:21.995916	2025-07-01 04:23:21.995916
3476	26	1	2023	received_antiretrovirals	4000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.048285	2025-07-01 04:23:22.048285
3477	26	1	2023	needing_antiretrovirals	5000.00	\N	3800.00	6000.00	5000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.073928	2025-07-01 04:23:22.073928
3478	26	1	2023	percentage_received	80.00	\N	61.00	95.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.091354	2025-07-01 04:23:22.091354
3482	28	1	2023	received_antiretrovirals	620.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.104992	2025-07-01 04:23:22.104992
3483	28	1	2023	needing_antiretrovirals	730.00	\N	600.00	850.00	730.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.119518	2025-07-01 04:23:22.119518
3484	28	1	2023	percentage_received	85.00	\N	71.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.130924	2025-07-01 04:23:22.130924
3485	29	1	2023	received_antiretrovirals	21700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.152286	2025-07-01 04:23:22.152286
3486	29	1	2023	needing_antiretrovirals	27000.00	\N	21000.00	32000.00	27000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.17391	2025-07-01 04:23:22.17391
3487	29	1	2023	percentage_received	80.00	\N	61.00	94.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.189176	2025-07-01 04:23:22.189176
3491	31	1	2023	received_antiretrovirals	3200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.199001	2025-07-01 04:23:22.199001
3492	31	1	2023	needing_antiretrovirals	4500.00	\N	3300.00	5800.00	4500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.209613	2025-07-01 04:23:22.209613
3493	31	1	2023	percentage_received	71.00	\N	52.00	91.00	71.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.219669	2025-07-01 04:23:22.219669
3494	32	1	2023	received_antiretrovirals	5600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.233007	2025-07-01 04:23:22.233007
3495	32	1	2023	needing_antiretrovirals	10000.00	\N	7200.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.254808	2025-07-01 04:23:22.254808
3496	32	1	2023	percentage_received	56.00	\N	40.00	72.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.268842	2025-07-01 04:23:22.268842
3497	33	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.285197	2025-07-01 04:23:22.285197
3498	33	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.29824	2025-07-01 04:23:22.29824
3499	33	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.314511	2025-07-01 04:23:22.314511
3503	35	1	2023	received_antiretrovirals	490.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.333091	2025-07-01 04:23:22.333091
3504	35	1	2023	needing_antiretrovirals	2300.00	\N	1900.00	2700.00	2300.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.350645	2025-07-01 04:23:22.350645
3505	35	1	2023	percentage_received	21.00	\N	17.00	25.00	21.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.366879	2025-07-01 04:23:22.366879
3506	36	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.385695	2025-07-01 04:23:22.385695
3509	37	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.404321	2025-07-01 04:23:22.404321
3510	37	1	2023	needing_antiretrovirals	4100.00	\N	2800.00	5800.00	4100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.419837	2025-07-01 04:23:22.419837
3511	37	1	2023	percentage_received	25.00	\N	17.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.432288	2025-07-01 04:23:22.432288
3512	38	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.49102	2025-07-01 04:23:22.49102
3515	39	1	2023	received_antiretrovirals	16500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.508513	2025-07-01 04:23:22.508513
3516	39	1	2023	needing_antiretrovirals	18000.00	\N	13000.00	24000.00	18000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.526963	2025-07-01 04:23:22.526963
3517	39	1	2023	percentage_received	90.00	\N	65.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.542064	2025-07-01 04:23:22.542064
3521	41	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.56061	2025-07-01 04:23:22.56061
3522	41	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.574211	2025-07-01 04:23:22.574211
3523	41	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.587607	2025-07-01 04:23:22.587607
3527	43	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.603318	2025-07-01 04:23:22.603318
3533	45	1	2023	received_antiretrovirals	11400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.61805	2025-07-01 04:23:22.61805
3534	45	1	2023	needing_antiretrovirals	26000.00	\N	20000.00	31000.00	26000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.63173	2025-07-01 04:23:22.63173
3535	45	1	2023	percentage_received	44.00	\N	33.00	52.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.64351	2025-07-01 04:23:22.64351
3539	47	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.65526	2025-07-01 04:23:22.65526
3540	47	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.664698	2025-07-01 04:23:22.664698
3541	47	1	2023	percentage_received	30.00	\N	22.00	39.00	30.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.676046	2025-07-01 04:23:22.676046
3542	48	1	2023	received_antiretrovirals	770.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.696825	2025-07-01 04:23:22.696825
3543	48	1	2023	needing_antiretrovirals	910.00	\N	690.00	1200.00	910.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.71075	2025-07-01 04:23:22.71075
3544	48	1	2023	percentage_received	84.00	\N	64.00	95.00	84.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.722037	2025-07-01 04:23:22.722037
3545	49	1	2023	received_antiretrovirals	370.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.735335	2025-07-01 04:23:22.735335
3546	49	1	2023	needing_antiretrovirals	500.00	\N	500.00	620.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.744817	2025-07-01 04:23:22.744817
3547	49	1	2023	percentage_received	95.00	\N	68.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.754854	2025-07-01 04:23:22.754854
3548	50	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.766887	2025-07-01 04:23:22.766887
3549	50	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.783472	2025-07-01 04:23:22.783472
3550	50	1	2023	percentage_received	16.00	\N	15.00	18.00	16.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.797318	2025-07-01 04:23:22.797318
3551	51	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.810058	2025-07-01 04:23:22.810058
3552	51	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.821716	2025-07-01 04:23:22.821716
3553	51	1	2023	percentage_received	40.00	\N	33.00	46.00	40.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.832849	2025-07-01 04:23:22.832849
3554	52	1	2023	received_antiretrovirals	1300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.851557	2025-07-01 04:23:22.851557
3555	52	1	2023	needing_antiretrovirals	2600.00	\N	1800.00	3500.00	2600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.867913	2025-07-01 04:23:22.867913
3556	52	1	2023	percentage_received	50.00	\N	35.00	68.00	50.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.880735	2025-07-01 04:23:22.880735
3557	53	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.896727	2025-07-01 04:23:22.896727
3558	53	1	2023	needing_antiretrovirals	500.00	\N	500.00	690.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.910548	2025-07-01 04:23:22.910548
3559	53	1	2023	percentage_received	48.00	\N	34.00	69.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.924842	2025-07-01 04:23:22.924842
3563	55	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.943684	2025-07-01 04:23:22.943684
3564	55	1	2023	needing_antiretrovirals	11000.00	\N	9000.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.964555	2025-07-01 04:23:22.964555
3565	55	1	2023	percentage_received	79.00	\N	66.00	89.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:22.984138	2025-07-01 04:23:22.984138
3566	56	1	2023	received_antiretrovirals	18400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.004438	2025-07-01 04:23:23.004438
3567	56	1	2023	needing_antiretrovirals	20000.00	\N	14000.00	28000.00	20000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.01361	2025-07-01 04:23:23.01361
3568	56	1	2023	percentage_received	92.00	\N	63.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.056845	2025-07-01 04:23:23.056845
3576	59	1	2023	needing_antiretrovirals	1200.00	\N	1100.00	1300.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.067622	2025-07-01 04:23:23.067622
3578	60	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.109052	2025-07-01 04:23:23.109052
3579	60	1	2023	needing_antiretrovirals	2700.00	\N	1900.00	3600.00	2700.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.11961	2025-07-01 04:23:23.11961
3580	60	1	2023	percentage_received	72.00	\N	52.00	95.00	72.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.166663	2025-07-01 04:23:23.166663
3581	61	1	2023	received_antiretrovirals	700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.212451	2025-07-01 04:23:23.212451
3582	61	1	2023	needing_antiretrovirals	1000.00	\N	820.00	1300.00	1000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.260556	2025-07-01 04:23:23.260556
3583	61	1	2023	percentage_received	68.00	\N	54.00	86.00	68.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.277189	2025-07-01 04:23:23.277189
3588	63	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.327931	2025-07-01 04:23:23.327931
3590	64	1	2023	received_antiretrovirals	13000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.341996	2025-07-01 04:23:23.341996
3591	64	1	2023	needing_antiretrovirals	16000.00	\N	12000.00	21000.00	16000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.357219	2025-07-01 04:23:23.357219
3592	64	1	2023	percentage_received	79.00	\N	58.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.371447	2025-07-01 04:23:23.371447
3596	66	1	2023	received_antiretrovirals	270.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.404803	2025-07-01 04:23:23.404803
3597	66	1	2023	needing_antiretrovirals	790.00	\N	720.00	870.00	790.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.41981	2025-07-01 04:23:23.41981
3598	66	1	2023	percentage_received	34.00	\N	31.00	38.00	34.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.467502	2025-07-01 04:23:23.467502
3599	67	1	2023	received_antiretrovirals	3300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.515818	2025-07-01 04:23:23.515818
3600	67	1	2023	needing_antiretrovirals	5100.00	\N	3800.00	6600.00	5100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.596215	2025-07-01 04:23:23.596215
3601	67	1	2023	percentage_received	65.00	\N	48.00	84.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.606866	2025-07-01 04:23:23.606866
3602	68	1	2023	received_antiretrovirals	1000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.622701	2025-07-01 04:23:23.622701
3603	68	1	2023	needing_antiretrovirals	2100.00	\N	1700.00	2500.00	2100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.633438	2025-07-01 04:23:23.633438
3604	68	1	2023	percentage_received	48.00	\N	38.00	58.00	48.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.666382	2025-07-01 04:23:23.666382
3605	69	1	2023	received_antiretrovirals	160.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.683164	2025-07-01 04:23:23.683164
3606	69	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.729435	2025-07-01 04:23:23.729435
3607	69	1	2023	percentage_received	89.00	\N	67.00	95.00	89.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.739729	2025-07-01 04:23:23.739729
3608	70	1	2023	received_antiretrovirals	4900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.755007	2025-07-01 04:23:23.755007
3609	70	1	2023	needing_antiretrovirals	5900.00	\N	4700.00	6800.00	5900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.767384	2025-07-01 04:23:23.767384
3610	70	1	2023	percentage_received	83.00	\N	67.00	95.00	83.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.777963	2025-07-01 04:23:23.777963
3611	71	1	2023	received_antiretrovirals	200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.791826	2025-07-01 04:23:23.791826
3612	71	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.804882	2025-07-01 04:23:23.804882
3613	71	1	2023	percentage_received	59.00	\N	48.00	72.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.841574	2025-07-01 04:23:23.841574
3620	74	1	2023	received_antiretrovirals	13200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.856982	2025-07-01 04:23:23.856982
3623	75	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.898421	2025-07-01 04:23:23.898421
3624	75	1	2023	needing_antiretrovirals	12000.00	\N	10000.00	14000.00	12000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.94086	2025-07-01 04:23:23.94086
3625	75	1	2023	percentage_received	15.00	\N	13.00	18.00	15.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.955265	2025-07-01 04:23:23.955265
3626	76	1	2023	received_antiretrovirals	310.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.969108	2025-07-01 04:23:23.969108
3627	76	1	2023	needing_antiretrovirals	500.00	\N	200.00	840.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.980935	2025-07-01 04:23:23.980935
3628	76	1	2023	percentage_received	81.00	\N	41.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:23.993112	2025-07-01 04:23:23.993112
3630	77	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.001793	2025-07-01 04:23:24.001793
3633	78	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.019539	2025-07-01 04:23:24.019539
3636	79	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.03118	2025-07-01 04:23:24.03118
3638	80	1	2023	received_antiretrovirals	400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.047215	2025-07-01 04:23:24.047215
3639	80	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.059808	2025-07-01 04:23:24.059808
3640	80	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.069764	2025-07-01 04:23:24.069764
3647	83	1	2023	received_antiretrovirals	360.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.090825	2025-07-01 04:23:24.090825
3648	83	1	2023	needing_antiretrovirals	610.00	\N	550.00	660.00	610.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.134988	2025-07-01 04:23:24.134988
3649	83	1	2023	percentage_received	59.00	\N	54.00	65.00	59.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.181183	2025-07-01 04:23:24.181183
3650	84	1	2023	received_antiretrovirals	57500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.194116	2025-07-01 04:23:24.194116
3651	84	1	2023	needing_antiretrovirals	63000.00	\N	49000.00	80000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.206621	2025-07-01 04:23:24.206621
3652	84	1	2023	percentage_received	91.00	\N	70.00	95.00	91.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.221566	2025-07-01 04:23:24.221566
3653	85	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.239743	2025-07-01 04:23:24.239743
3656	86	1	2023	received_antiretrovirals	130.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.253377	2025-07-01 04:23:24.253377
3657	86	1	2023	needing_antiretrovirals	200.00	\N	200.00	500.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.264029	2025-07-01 04:23:24.264029
3658	86	1	2023	percentage_received	88.00	\N	69.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.277231	2025-07-01 04:23:24.277231
3659	87	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.291868	2025-07-01 04:23:24.291868
3660	87	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.312268	2025-07-01 04:23:24.312268
3661	87	1	2023	percentage_received	35.00	\N	31.00	41.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.335904	2025-07-01 04:23:24.335904
3668	90	1	2023	received_antiretrovirals	8200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.3498	2025-07-01 04:23:24.3498
3669	90	1	2023	needing_antiretrovirals	11000.00	\N	8200.00	12000.00	11000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.3655	2025-07-01 04:23:24.3655
3670	90	1	2023	percentage_received	77.00	\N	59.00	89.00	77.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.37863	2025-07-01 04:23:24.37863
3671	91	1	2023	received_antiretrovirals	1800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.400742	2025-07-01 04:23:24.400742
3672	91	1	2023	needing_antiretrovirals	2000.00	\N	1500.00	2300.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.415669	2025-07-01 04:23:24.415669
3673	91	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.427052	2025-07-01 04:23:24.427052
3674	92	1	2023	received_antiretrovirals	60.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.438541	2025-07-01 04:23:24.438541
3675	92	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.454928	2025-07-01 04:23:24.454928
3676	92	1	2023	percentage_received	63.00	\N	56.00	69.00	63.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.483226	2025-07-01 04:23:24.483226
3683	95	1	2023	received_antiretrovirals	280.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.49502	2025-07-01 04:23:24.49502
3684	95	1	2023	needing_antiretrovirals	1100.00	\N	820.00	1600.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.509304	2025-07-01 04:23:24.509304
3685	95	1	2023	percentage_received	25.00	\N	19.00	36.00	25.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.521376	2025-07-01 04:23:24.521376
3686	96	1	2023	received_antiretrovirals	47100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.539026	2025-07-01 04:23:24.539026
3687	96	1	2023	needing_antiretrovirals	45000.00	\N	34000.00	53000.00	45000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.552151	2025-07-01 04:23:24.552151
3688	96	1	2023	percentage_received	95.00	\N	80.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.567518	2025-07-01 04:23:24.567518
3689	97	1	2023	received_antiretrovirals	260.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.584004	2025-07-01 04:23:24.584004
3690	97	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.59789	2025-07-01 04:23:24.59789
3691	97	1	2023	percentage_received	95.00	\N	86.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.611233	2025-07-01 04:23:24.611233
3695	99	1	2023	received_antiretrovirals	2400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.625643	2025-07-01 04:23:24.625643
3696	99	1	2023	needing_antiretrovirals	10000.00	\N	8300.00	13000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.648011	2025-07-01 04:23:24.648011
3697	99	1	2023	percentage_received	24.00	\N	19.00	31.00	24.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.694224	2025-07-01 04:23:24.694224
3701	101	1	2023	received_antiretrovirals	50.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.70814	2025-07-01 04:23:24.70814
3702	101	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.759363	2025-07-01 04:23:24.759363
3703	101	1	2023	percentage_received	38.00	\N	31.00	47.00	38.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.783509	2025-07-01 04:23:24.783509
3704	102	1	2023	received_antiretrovirals	110.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.830865	2025-07-01 04:23:24.830865
3705	102	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.880024	2025-07-01 04:23:24.880024
3706	102	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.898173	2025-07-01 04:23:24.898173
3716	106	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.91216	2025-07-01 04:23:24.91216
3717	106	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.962427	2025-07-01 04:23:24.962427
3718	106	1	2023	percentage_received	61.00	\N	50.00	78.00	61.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:24.976331	2025-07-01 04:23:24.976331
3719	107	1	2023	received_antiretrovirals	109000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.020584	2025-07-01 04:23:25.020584
3720	107	1	2023	needing_antiretrovirals	110000.00	\N	78000.00	140000.00	110000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.034055	2025-07-01 04:23:25.034055
3721	107	1	2023	percentage_received	95.00	\N	73.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.075992	2025-07-01 04:23:25.075992
3722	108	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.098176	2025-07-01 04:23:25.098176
3723	108	1	2023	needing_antiretrovirals	5400.00	\N	4700.00	6100.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.125151	2025-07-01 04:23:25.125151
3724	108	1	2023	percentage_received	80.00	\N	69.00	89.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.151474	2025-07-01 04:23:25.151474
3725	109	1	2023	received_antiretrovirals	12100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.177614	2025-07-01 04:23:25.177614
3726	109	1	2023	needing_antiretrovirals	10000.00	\N	8200.00	12000.00	10000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.20559	2025-07-01 04:23:25.20559
3727	109	1	2023	percentage_received	95.00	\N	92.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.22391	2025-07-01 04:23:25.22391
3728	110	1	2023	received_antiretrovirals	150.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.244085	2025-07-01 04:23:25.244085
3729	110	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.477859	2025-07-01 04:23:25.477859
3730	110	1	2023	percentage_received	51.00	\N	43.00	60.00	51.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.501502	2025-07-01 04:23:25.501502
3734	112	1	2023	received_antiretrovirals	0.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.510684	2025-07-01 04:23:25.510684
3737	113	1	2023	received_antiretrovirals	120.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.520412	2025-07-01 04:23:25.520412
3738	113	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.529406	2025-07-01 04:23:25.529406
3739	113	1	2023	percentage_received	90.00	\N	73.00	95.00	90.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.542729	2025-07-01 04:23:25.542729
3740	114	1	2023	received_antiretrovirals	940.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.551545	2025-07-01 04:23:25.551545
3741	114	1	2023	needing_antiretrovirals	1600.00	\N	1400.00	2000.00	1600.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.564057	2025-07-01 04:23:25.564057
3742	114	1	2023	percentage_received	58.00	\N	48.00	70.00	58.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.574	2025-07-01 04:23:25.574
3743	115	1	2023	received_antiretrovirals	43700.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.587289	2025-07-01 04:23:25.587289
3744	115	1	2023	needing_antiretrovirals	100000.00	\N	65000.00	140000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.600661	2025-07-01 04:23:25.600661
3745	115	1	2023	percentage_received	44.00	\N	28.00	62.00	44.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.613805	2025-07-01 04:23:25.613805
3749	117	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.629608	2025-07-01 04:23:25.629608
3752	118	1	2023	received_antiretrovirals	320.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.642618	2025-07-01 04:23:25.642618
3753	118	1	2023	needing_antiretrovirals	3200.00	\N	2700.00	3800.00	3200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.654051	2025-07-01 04:23:25.654051
3754	118	1	2023	percentage_received	10.00	\N	8.00	12.00	10.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.668694	2025-07-01 04:23:25.668694
3755	119	1	2023	received_antiretrovirals	190.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.680051	2025-07-01 04:23:25.680051
3756	119	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.690856	2025-07-01 04:23:25.690856
3757	119	1	2023	percentage_received	92.00	\N	83.00	95.00	92.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.70574	2025-07-01 04:23:25.70574
3758	120	1	2023	received_antiretrovirals	960.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.750081	2025-07-01 04:23:25.750081
3759	120	1	2023	needing_antiretrovirals	1200.00	\N	910.00	1500.00	1200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.765461	2025-07-01 04:23:25.765461
3760	120	1	2023	percentage_received	79.00	\N	59.00	95.00	79.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.777877	2025-07-01 04:23:25.777877
3761	121	1	2023	received_antiretrovirals	250.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.791941	2025-07-01 04:23:25.791941
3762	121	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.80311	2025-07-01 04:23:25.80311
3763	121	1	2023	percentage_received	88.00	\N	60.00	95.00	88.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.832603	2025-07-01 04:23:25.832603
3764	122	1	2023	received_antiretrovirals	930.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.846984	2025-07-01 04:23:25.846984
3765	122	1	2023	needing_antiretrovirals	1100.00	\N	880.00	1500.00	1100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.863368	2025-07-01 04:23:25.863368
3766	122	1	2023	percentage_received	85.00	\N	67.00	95.00	85.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.876205	2025-07-01 04:23:25.876205
3767	123	1	2023	received_antiretrovirals	70.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.891824	2025-07-01 04:23:25.891824
3768	123	1	2023	needing_antiretrovirals	500.00	\N	500.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.903938	2025-07-01 04:23:25.903938
3769	123	1	2023	percentage_received	18.00	\N	15.00	22.00	18.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.917023	2025-07-01 04:23:25.917023
3774	125	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.930701	2025-07-01 04:23:25.930701
3782	128	1	2023	received_antiretrovirals	180.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.94341	2025-07-01 04:23:25.94341
3783	128	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.956417	2025-07-01 04:23:25.956417
3784	128	1	2023	percentage_received	73.00	\N	54.00	95.00	73.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.971334	2025-07-01 04:23:25.971334
3788	130	1	2023	received_antiretrovirals	230.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.983587	2025-07-01 04:23:25.983587
3789	130	1	2023	needing_antiretrovirals	200.00	\N	200.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:25.995214	2025-07-01 04:23:25.995214
3790	130	1	2023	percentage_received	95.00	\N	95.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.009463	2025-07-01 04:23:26.009463
3791	131	1	2023	received_antiretrovirals	13600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.025186	2025-07-01 04:23:26.025186
3794	132	1	2023	received_antiretrovirals	8600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.041701	2025-07-01 04:23:26.041701
3795	132	1	2023	needing_antiretrovirals	8100.00	\N	6000.00	9400.00	8100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.05458	2025-07-01 04:23:26.05458
3796	132	1	2023	percentage_received	95.00	\N	79.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.067492	2025-07-01 04:23:26.067492
3797	133	1	2023	received_antiretrovirals	40.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.100711	2025-07-01 04:23:26.100711
3800	134	1	2023	received_antiretrovirals	1400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.112817	2025-07-01 04:23:26.112817
3801	134	1	2023	needing_antiretrovirals	2200.00	\N	1800.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.121166	2025-07-01 04:23:26.121166
3802	134	1	2023	percentage_received	65.00	\N	56.00	75.00	65.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.133774	2025-07-01 04:23:26.133774
3806	136	1	2023	received_antiretrovirals	4400.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.14389	2025-07-01 04:23:26.14389
3809	137	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.155537	2025-07-01 04:23:26.155537
3818	140	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.173102	2025-07-01 04:23:26.173102
3819	140	1	2023	needing_antiretrovirals	500.00	\N	500.00	730.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.186128	2025-07-01 04:23:26.186128
3820	140	1	2023	percentage_received	19.00	\N	14.00	31.00	19.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.201577	2025-07-01 04:23:26.201577
3821	141	1	2023	received_antiretrovirals	248000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.224158	2025-07-01 04:23:26.224158
3822	141	1	2023	needing_antiretrovirals	290000.00	\N	210000.00	350000.00	290000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.240078	2025-07-01 04:23:26.240078
3823	141	1	2023	percentage_received	87.00	\N	63.00	95.00	87.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.259739	2025-07-01 04:23:26.259739
3824	142	1	2023	received_antiretrovirals	5500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.269841	2025-07-01 04:23:26.269841
3825	142	1	2023	needing_antiretrovirals	9900.00	\N	7200.00	13000.00	9900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.280938	2025-07-01 04:23:26.280938
3826	142	1	2023	percentage_received	56.00	\N	41.00	74.00	56.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.292778	2025-07-01 04:23:26.292778
3828	143	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.304366	2025-07-01 04:23:26.304366
3830	144	1	2023	received_antiretrovirals	20.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.344818	2025-07-01 04:23:26.344818
3833	145	1	2023	received_antiretrovirals	100.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.386953	2025-07-01 04:23:26.386953
3834	145	1	2023	needing_antiretrovirals	2000.00	\N	760.00	3700.00	2000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.400526	2025-07-01 04:23:26.400526
3835	145	1	2023	percentage_received	5.00	\N	2.00	9.00	5.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.44258	2025-07-01 04:23:26.44258
3836	146	1	2023	received_antiretrovirals	90.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.485336	2025-07-01 04:23:26.485336
3837	146	1	2023	needing_antiretrovirals	100.00	\N	100.00	100.00	100.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.496164	2025-07-01 04:23:26.496164
3838	146	1	2023	percentage_received	95.00	\N	84.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.535985	2025-07-01 04:23:26.535985
3845	149	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.547519	2025-07-01 04:23:26.547519
3848	150	1	2023	received_antiretrovirals	220.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.577733	2025-07-01 04:23:26.577733
3849	150	1	2023	needing_antiretrovirals	500.00	\N	500.00	560.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.587577	2025-07-01 04:23:26.587577
3850	150	1	2023	percentage_received	46.00	\N	39.00	56.00	46.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.598194	2025-07-01 04:23:26.598194
3851	151	1	2023	received_antiretrovirals	3800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.640613	2025-07-01 04:23:26.640613
3852	151	1	2023	needing_antiretrovirals	3900.00	\N	3200.00	4500.00	3900.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.677978	2025-07-01 04:23:26.677978
3853	151	1	2023	percentage_received	95.00	\N	81.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.689223	2025-07-01 04:23:26.689223
3857	153	1	2023	received_antiretrovirals	4300.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.709315	2025-07-01 04:23:26.709315
3858	153	1	2023	needing_antiretrovirals	5400.00	\N	4200.00	6200.00	5400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.733566	2025-07-01 04:23:26.733566
3859	153	1	2023	percentage_received	80.00	\N	62.00	92.00	80.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.74871	2025-07-01 04:23:26.74871
3863	155	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.784705	2025-07-01 04:23:26.784705
3872	158	1	2023	received_antiretrovirals	94800.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.827598	2025-07-01 04:23:26.827598
3873	158	1	2023	needing_antiretrovirals	100000.00	\N	81000.00	120000.00	100000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.842963	2025-07-01 04:23:26.842963
3874	158	1	2023	percentage_received	93.00	\N	73.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.886662	2025-07-01 04:23:26.886662
3875	159	1	2023	received_antiretrovirals	2200.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.900667	2025-07-01 04:23:26.900667
3876	159	1	2023	needing_antiretrovirals	2200.00	\N	1900.00	2500.00	2200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.932594	2025-07-01 04:23:26.932594
3877	159	1	2023	percentage_received	95.00	\N	89.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.951456	2025-07-01 04:23:26.951456
3878	160	1	2023	received_antiretrovirals	10.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:26.973283	2025-07-01 04:23:26.973283
3884	162	1	2023	received_antiretrovirals	77000.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.003513	2025-07-01 04:23:27.003513
3885	162	1	2023	needing_antiretrovirals	83000.00	\N	62000.00	98000.00	83000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.060079	2025-07-01 04:23:27.060079
3886	162	1	2023	percentage_received	93.00	\N	70.00	95.00	93.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.079528	2025-07-01 04:23:27.079528
3890	164	1	2023	received_antiretrovirals	140.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.107935	2025-07-01 04:23:27.107935
3891	164	1	2023	needing_antiretrovirals	200.00	\N	100.00	200.00	200.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.126929	2025-07-01 04:23:27.126929
3892	164	1	2023	percentage_received	95.00	\N	71.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.175836	2025-07-01 04:23:27.175836
3893	165	1	2023	received_antiretrovirals	540.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.197193	2025-07-01 04:23:27.197193
3894	165	1	2023	needing_antiretrovirals	1500.00	\N	1400.00	1600.00	1500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.214918	2025-07-01 04:23:27.214918
3895	165	1	2023	percentage_received	35.00	\N	33.00	38.00	35.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.230035	2025-07-01 04:23:27.230035
3896	166	1	2023	received_antiretrovirals	410.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.251411	2025-07-01 04:23:27.251411
3899	167	1	2023	received_antiretrovirals	1900.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.273566	2025-07-01 04:23:27.273566
3900	167	1	2023	needing_antiretrovirals	2400.00	\N	2000.00	2800.00	2400.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.297063	2025-07-01 04:23:27.297063
3901	167	1	2023	percentage_received	81.00	\N	69.00	95.00	81.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.316066	2025-07-01 04:23:27.316066
3902	168	1	2023	received_antiretrovirals	30.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.334015	2025-07-01 04:23:27.334015
3903	168	1	2023	needing_antiretrovirals	500.00	\N	200.00	500.00	500.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.352726	2025-07-01 04:23:27.352726
3904	168	1	2023	percentage_received	13.00	\N	8.00	20.00	13.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.373251	2025-07-01 04:23:27.373251
3905	169	1	2023	received_antiretrovirals	56500.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.391494	2025-07-01 04:23:27.391494
3906	169	1	2023	needing_antiretrovirals	48000.00	\N	38000.00	57000.00	48000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.410962	2025-07-01 04:23:27.410962
3907	169	1	2023	percentage_received	95.00	\N	94.00	95.00	95.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.459907	2025-07-01 04:23:27.459907
3908	170	1	2023	received_antiretrovirals	59600.00	\N	\N	\N	\N	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.477565	2025-07-01 04:23:27.477565
3909	170	1	2023	needing_antiretrovirals	63000.00	\N	48000.00	76000.00	63000.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.498859	2025-07-01 04:23:27.498859
3910	170	1	2023	percentage_received	94.00	\N	71.00	95.00	94.00	good	prevention_of_mother_to_child_transmission_by_country_clean.csv	\N	2025-07-01 04:23:27.525067	2025-07-01 04:23:27.525067
3911	1	2	2023	reported_receiving_art	920.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.547642	2025-07-01 04:23:27.547642
3912	1	2	2023	estimated_living_with_hiv	7200.00	\N	4100.00	11000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.564446	2025-07-01 04:23:27.564446
3913	1	2	2023	estimated_art_coverage_percent	13.00	\N	7.00	20.00	13.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.584634	2025-07-01 04:23:27.584634
3914	2	2	2023	reported_receiving_art	580.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.621208	2025-07-01 04:23:27.621208
3917	3	2	2023	reported_receiving_art	12800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.644767	2025-07-01 04:23:27.644767
3918	3	2	2023	estimated_living_with_hiv	16000.00	\N	15000.00	17000.00	16000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.662871	2025-07-01 04:23:27.662871
3919	3	2	2023	estimated_art_coverage_percent	81.00	\N	75.00	86.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.681067	2025-07-01 04:23:27.681067
3920	4	2	2023	reported_receiving_art	88700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.698789	2025-07-01 04:23:27.698789
3921	4	2	2023	estimated_living_with_hiv	330000.00	\N	290000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.709731	2025-07-01 04:23:27.709731
3922	4	2	2023	estimated_art_coverage_percent	27.00	\N	23.00	31.00	27.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.720531	2025-07-01 04:23:27.720531
3923	5	2	2023	reported_receiving_art	85500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.758255	2025-07-01 04:23:27.758255
3924	5	2	2023	estimated_living_with_hiv	140000.00	\N	130000.00	150000.00	140000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.786053	2025-07-01 04:23:27.786053
3925	5	2	2023	estimated_art_coverage_percent	61.00	\N	55.00	67.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.797053	2025-07-01 04:23:27.797053
3926	6	2	2023	reported_receiving_art	1900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.809756	2025-07-01 04:23:27.809756
3927	6	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4400.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.824964	2025-07-01 04:23:27.824964
3928	6	2	2023	estimated_art_coverage_percent	53.00	\N	44.00	65.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.837061	2025-07-01 04:23:27.837061
3929	7	2	2023	reported_receiving_art	22800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.846728	2025-07-01 04:23:27.846728
3930	7	2	2023	estimated_living_with_hiv	28000.00	\N	23000.00	31000.00	28000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.859852	2025-07-01 04:23:27.859852
3931	7	2	2023	estimated_art_coverage_percent	83.00	\N	70.00	93.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.87072	2025-07-01 04:23:27.87072
3935	9	2	2023	reported_receiving_art	4400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.881563	2025-07-01 04:23:27.881563
3938	10	2	2023	reported_receiving_art	3100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.894573	2025-07-01 04:23:27.894573
3939	10	2	2023	estimated_living_with_hiv	6000.00	\N	5300.00	6700.00	6000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.90544	2025-07-01 04:23:27.90544
3940	10	2	2023	estimated_art_coverage_percent	52.00	\N	45.00	58.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.918128	2025-07-01 04:23:27.918128
3944	12	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.930591	2025-07-01 04:23:27.930591
3945	12	2	2023	estimated_living_with_hiv	14000.00	\N	12000.00	16000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.942454	2025-07-01 04:23:27.942454
3946	12	2	2023	estimated_art_coverage_percent	22.00	\N	19.00	25.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.953711	2025-07-01 04:23:27.953711
3947	13	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.964248	2025-07-01 04:23:27.964248
3948	13	2	2023	estimated_living_with_hiv	3000.00	\N	2700.00	3400.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.975553	2025-07-01 04:23:27.975553
3949	13	2	2023	estimated_art_coverage_percent	50.00	\N	44.00	57.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.986608	2025-07-01 04:23:27.986608
3950	14	2	2023	reported_receiving_art	15500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:27.996698	2025-07-01 04:23:27.996698
3951	14	2	2023	estimated_living_with_hiv	27000.00	\N	22000.00	34000.00	27000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.007854	2025-07-01 04:23:28.007854
3952	14	2	2023	estimated_art_coverage_percent	59.00	\N	48.00	75.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.018826	2025-07-01 04:23:28.018826
3956	16	2	2023	reported_receiving_art	1400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.029458	2025-07-01 04:23:28.029458
3957	16	2	2023	estimated_living_with_hiv	4900.00	\N	4400.00	5400.00	4900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.044058	2025-07-01 04:23:28.044058
3958	16	2	2023	estimated_art_coverage_percent	28.00	\N	26.00	31.00	28.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.053837	2025-07-01 04:23:28.053837
3959	17	2	2023	reported_receiving_art	44200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.063354	2025-07-01 04:23:28.063354
3960	17	2	2023	estimated_living_with_hiv	73000.00	\N	48000.00	120000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.071985	2025-07-01 04:23:28.071985
3961	17	2	2023	estimated_art_coverage_percent	61.00	\N	40.00	95.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.082702	2025-07-01 04:23:28.082702
3962	18	2	2023	reported_receiving_art	480.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.091416	2025-07-01 04:23:28.091416
3963	18	2	2023	estimated_living_with_hiv	1300.00	\N	700.00	2700.00	1300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.102155	2025-07-01 04:23:28.102155
3964	18	2	2023	estimated_art_coverage_percent	37.00	\N	20.00	78.00	37.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.114115	2025-07-01 04:23:28.114115
3965	19	2	2023	reported_receiving_art	9900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.123431	2025-07-01 04:23:28.123431
3966	19	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.13475	2025-07-01 04:23:28.13475
3967	19	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	48.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.146739	2025-07-01 04:23:28.146739
3968	20	2	2023	reported_receiving_art	220.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.157586	2025-07-01 04:23:28.157586
3969	20	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.16925	2025-07-01 04:23:28.16925
3970	20	2	2023	estimated_art_coverage_percent	67.00	\N	57.00	78.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.181221	2025-07-01 04:23:28.181221
3971	21	2	2023	reported_receiving_art	307000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.191807	2025-07-01 04:23:28.191807
3972	21	2	2023	estimated_living_with_hiv	370000.00	\N	330000.00	400000.00	370000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.202326	2025-07-01 04:23:28.202326
3973	21	2	2023	estimated_art_coverage_percent	83.00	\N	75.00	90.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.212672	2025-07-01 04:23:28.212672
3974	22	2	2023	reported_receiving_art	593000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.223549	2025-07-01 04:23:28.223549
3975	22	2	2023	estimated_living_with_hiv	900000.00	\N	690000.00	1100000.00	900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.233949	2025-07-01 04:23:28.233949
3976	22	2	2023	estimated_art_coverage_percent	66.00	\N	51.00	82.00	66.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.249013	2025-07-01 04:23:28.249013
3977	23	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.259019	2025-07-01 04:23:28.259019
3980	24	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.270793	2025-07-01 04:23:28.270793
3981	24	2	2023	estimated_living_with_hiv	3500.00	\N	3000.00	4100.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.281399	2025-07-01 04:23:28.281399
3982	24	2	2023	estimated_art_coverage_percent	41.00	\N	35.00	48.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.293186	2025-07-01 04:23:28.293186
3983	25	2	2023	reported_receiving_art	59300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.302736	2025-07-01 04:23:28.302736
3984	25	2	2023	estimated_living_with_hiv	96000.00	\N	78000.00	120000.00	96000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.315863	2025-07-01 04:23:28.315863
3985	25	2	2023	estimated_art_coverage_percent	62.00	\N	50.00	75.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.330537	2025-07-01 04:23:28.330537
3986	26	2	2023	reported_receiving_art	65500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.339669	2025-07-01 04:23:28.339669
3987	26	2	2023	estimated_living_with_hiv	82000.00	\N	71000.00	97000.00	82000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.349017	2025-07-01 04:23:28.349017
3988	26	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	94.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.361295	2025-07-01 04:23:28.361295
3989	27	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.370895	2025-07-01 04:23:28.370895
3990	27	2	2023	estimated_living_with_hiv	2400.00	\N	2100.00	2900.00	2400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.382329	2025-07-01 04:23:28.382329
3991	27	2	2023	estimated_art_coverage_percent	89.00	\N	75.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.393519	2025-07-01 04:23:28.393519
3992	28	2	2023	reported_receiving_art	59500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.405886	2025-07-01 04:23:28.405886
3993	28	2	2023	estimated_living_with_hiv	73000.00	\N	64000.00	84000.00	73000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.418852	2025-07-01 04:23:28.418852
3994	28	2	2023	estimated_art_coverage_percent	81.00	\N	71.00	93.00	81.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.428568	2025-07-01 04:23:28.428568
3995	29	2	2023	reported_receiving_art	281000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.440434	2025-07-01 04:23:28.440434
3996	29	2	2023	estimated_living_with_hiv	540000.00	\N	470000.00	590000.00	540000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.451966	2025-07-01 04:23:28.451966
3997	29	2	2023	estimated_art_coverage_percent	52.00	\N	46.00	57.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.462563	2025-07-01 04:23:28.462563
4001	31	2	2023	reported_receiving_art	39600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.472561	2025-07-01 04:23:28.472561
4002	31	2	2023	estimated_living_with_hiv	110000.00	\N	90000.00	140000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.483965	2025-07-01 04:23:28.483965
4003	31	2	2023	estimated_art_coverage_percent	36.00	\N	30.00	45.00	36.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.496432	2025-07-01 04:23:28.496432
4004	32	2	2023	reported_receiving_art	61400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.509607	2025-07-01 04:23:28.509607
4005	32	2	2023	estimated_living_with_hiv	120000.00	\N	94000.00	150000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.520381	2025-07-01 04:23:28.520381
4006	32	2	2023	estimated_art_coverage_percent	51.00	\N	40.00	63.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.53691	2025-07-01 04:23:28.53691
4007	33	2	2023	reported_receiving_art	45100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.548848	2025-07-01 04:23:28.548848
4008	33	2	2023	estimated_living_with_hiv	71000.00	\N	63000.00	78000.00	71000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.559434	2025-07-01 04:23:28.559434
4009	33	2	2023	estimated_art_coverage_percent	63.00	\N	56.00	70.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.570996	2025-07-01 04:23:28.570996
4010	34	2	2023	reported_receiving_art	718000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.583571	2025-07-01 04:23:28.583571
4013	35	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.595491	2025-07-01 04:23:28.595491
4014	35	2	2023	estimated_living_with_hiv	160000.00	\N	130000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.606679	2025-07-01 04:23:28.606679
4015	35	2	2023	estimated_art_coverage_percent	73.00	\N	60.00	86.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.61801	2025-07-01 04:23:28.61801
4016	36	2	2023	reported_receiving_art	100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.630712	2025-07-01 04:23:28.630712
4017	36	2	2023	estimated_living_with_hiv	200.00	\N	100.00	500.00	200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.646462	2025-07-01 04:23:28.646462
4018	36	2	2023	estimated_art_coverage_percent	79.00	\N	39.00	95.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.658131	2025-07-01 04:23:28.658131
4019	37	2	2023	reported_receiving_art	31200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.673338	2025-07-01 04:23:28.673338
4020	37	2	2023	estimated_living_with_hiv	89000.00	\N	69000.00	120000.00	89000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.685042	2025-07-01 04:23:28.685042
4021	37	2	2023	estimated_art_coverage_percent	35.00	\N	27.00	46.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.697327	2025-07-01 04:23:28.697327
4022	38	2	2023	reported_receiving_art	7200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.727309	2025-07-01 04:23:28.727309
4023	38	2	2023	estimated_living_with_hiv	15000.00	\N	13000.00	17000.00	15000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.768457	2025-07-01 04:23:28.768457
4024	38	2	2023	estimated_art_coverage_percent	49.00	\N	44.00	54.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.779713	2025-07-01 04:23:28.779713
4025	39	2	2023	reported_receiving_art	252000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.794777	2025-07-01 04:23:28.794777
4026	39	2	2023	estimated_living_with_hiv	460000.00	\N	360000.00	580000.00	460000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.805021	2025-07-01 04:23:28.805021
4027	39	2	2023	estimated_art_coverage_percent	55.00	\N	44.00	70.00	55.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.816846	2025-07-01 04:23:28.816846
4028	40	2	2023	reported_receiving_art	1200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.827538	2025-07-01 04:23:28.827538
4029	40	2	2023	estimated_living_with_hiv	1600.00	\N	1400.00	1700.00	1600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.843353	2025-07-01 04:23:28.843353
4030	40	2	2023	estimated_art_coverage_percent	75.00	\N	67.00	83.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.856621	2025-07-01 04:23:28.856621
4031	41	2	2023	reported_receiving_art	21900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.867406	2025-07-01 04:23:28.867406
4032	41	2	2023	estimated_living_with_hiv	31000.00	\N	24000.00	37000.00	31000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.881354	2025-07-01 04:23:28.881354
4033	41	2	2023	estimated_art_coverage_percent	72.00	\N	55.00	85.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.897238	2025-07-01 04:23:28.897238
4037	43	2	2023	reported_receiving_art	2600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.909025	2025-07-01 04:23:28.909025
4038	43	2	2023	estimated_living_with_hiv	4400.00	\N	3700.00	5000.00	4400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.921668	2025-07-01 04:23:28.921668
4039	43	2	2023	estimated_art_coverage_percent	60.00	\N	51.00	68.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.936436	2025-07-01 04:23:28.936436
4043	45	2	2023	reported_receiving_art	256000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.950301	2025-07-01 04:23:28.950301
4044	45	2	2023	estimated_living_with_hiv	450000.00	\N	370000.00	530000.00	450000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.95982	2025-07-01 04:23:28.95982
4045	45	2	2023	estimated_art_coverage_percent	57.00	\N	47.00	67.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.97096	2025-07-01 04:23:28.97096
4046	46	2	2023	reported_receiving_art	5500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:28.984669	2025-07-01 04:23:28.984669
4047	46	2	2023	estimated_living_with_hiv	6200.00	\N	5600.00	7000.00	6200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.001965	2025-07-01 04:23:29.001965
4048	46	2	2023	estimated_art_coverage_percent	89.00	\N	79.00	95.00	89.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.014516	2025-07-01 04:23:29.014516
4049	47	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.027084	2025-07-01 04:23:29.027084
4050	47	2	2023	estimated_living_with_hiv	8800.00	\N	7100.00	11000.00	8800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.036947	2025-07-01 04:23:29.036947
4051	47	2	2023	estimated_art_coverage_percent	30.00	\N	25.00	38.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.047333	2025-07-01 04:23:29.047333
4052	48	2	2023	reported_receiving_art	39000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.062613	2025-07-01 04:23:29.062613
4053	48	2	2023	estimated_living_with_hiv	70000.00	\N	54000.00	92000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.073116	2025-07-01 04:23:29.073116
4054	48	2	2023	estimated_art_coverage_percent	56.00	\N	43.00	73.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.083401	2025-07-01 04:23:29.083401
4055	49	2	2023	reported_receiving_art	25100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.094934	2025-07-01 04:23:29.094934
4056	49	2	2023	estimated_living_with_hiv	44000.00	\N	29000.00	71000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.10691	2025-07-01 04:23:29.10691
4057	49	2	2023	estimated_art_coverage_percent	57.00	\N	38.00	93.00	57.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.11844	2025-07-01 04:23:29.11844
4058	50	2	2023	reported_receiving_art	6700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.131822	2025-07-01 04:23:29.131822
4059	50	2	2023	estimated_living_with_hiv	22000.00	\N	20000.00	24000.00	22000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.145357	2025-07-01 04:23:29.145357
4060	50	2	2023	estimated_art_coverage_percent	31.00	\N	28.00	33.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.158868	2025-07-01 04:23:29.158868
4061	51	2	2023	reported_receiving_art	11900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.168684	2025-07-01 04:23:29.168684
4062	51	2	2023	estimated_living_with_hiv	25000.00	\N	21000.00	30000.00	25000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.178924	2025-07-01 04:23:29.178924
4063	51	2	2023	estimated_art_coverage_percent	47.00	\N	39.00	55.00	47.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.193777	2025-07-01 04:23:29.193777
4064	52	2	2023	reported_receiving_art	21400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.212877	2025-07-01 04:23:29.212877
4065	52	2	2023	estimated_living_with_hiv	62000.00	\N	50000.00	81000.00	62000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.222774	2025-07-01 04:23:29.222774
4066	52	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	44.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.236798	2025-07-01 04:23:29.236798
4067	53	2	2023	reported_receiving_art	8900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.260562	2025-07-01 04:23:29.260562
4068	53	2	2023	estimated_living_with_hiv	18000.00	\N	13000.00	24000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.279341	2025-07-01 04:23:29.279341
4069	53	2	2023	estimated_art_coverage_percent	51.00	\N	38.00	68.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.304574	2025-07-01 04:23:29.304574
4070	54	2	2023	reported_receiving_art	4300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.323958	2025-07-01 04:23:29.323958
4071	54	2	2023	estimated_living_with_hiv	7400.00	\N	6600.00	8200.00	7400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.34139	2025-07-01 04:23:29.34139
4072	54	2	2023	estimated_art_coverage_percent	59.00	\N	53.00	66.00	59.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.359839	2025-07-01 04:23:29.359839
4073	55	2	2023	reported_receiving_art	177000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.378187	2025-07-01 04:23:29.378187
4074	55	2	2023	estimated_living_with_hiv	210000.00	\N	190000.00	220000.00	210000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.398499	2025-07-01 04:23:29.398499
4075	55	2	2023	estimated_art_coverage_percent	86.00	\N	80.00	94.00	86.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.419347	2025-07-01 04:23:29.419347
4076	56	2	2023	reported_receiving_art	450000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.434801	2025-07-01 04:23:29.434801
4077	56	2	2023	estimated_living_with_hiv	690000.00	\N	530000.00	900000.00	690000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.447985	2025-07-01 04:23:29.447985
4078	56	2	2023	estimated_art_coverage_percent	65.00	\N	50.00	85.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.461882	2025-07-01 04:23:29.461882
4082	58	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.480693	2025-07-01 04:23:29.480693
4083	58	2	2023	estimated_living_with_hiv	4000.00	\N	3100.00	4900.00	4000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.499683	2025-07-01 04:23:29.499683
4084	58	2	2023	estimated_art_coverage_percent	76.00	\N	60.00	95.00	76.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.694259	2025-07-01 04:23:29.694259
4085	59	2	2023	reported_receiving_art	148000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.703366	2025-07-01 04:23:29.703366
4086	59	2	2023	estimated_living_with_hiv	180000.00	\N	150000.00	210000.00	180000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.711847	2025-07-01 04:23:29.711847
4087	59	2	2023	estimated_art_coverage_percent	83.00	\N	69.00	95.00	83.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.723652	2025-07-01 04:23:29.723652
4088	60	2	2023	reported_receiving_art	35600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.735865	2025-07-01 04:23:29.735865
4089	60	2	2023	estimated_living_with_hiv	53000.00	\N	43000.00	67000.00	53000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.751165	2025-07-01 04:23:29.751165
4090	60	2	2023	estimated_art_coverage_percent	67.00	\N	54.00	85.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.772795	2025-07-01 04:23:29.772795
4091	61	2	2023	reported_receiving_art	7500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.784912	2025-07-01 04:23:29.784912
4092	61	2	2023	estimated_living_with_hiv	26000.00	\N	21000.00	33000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.79371	2025-07-01 04:23:29.79371
4093	61	2	2023	estimated_art_coverage_percent	29.00	\N	24.00	38.00	29.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.803561	2025-07-01 04:23:29.803561
4094	62	2	2023	reported_receiving_art	4600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.815084	2025-07-01 04:23:29.815084
4095	62	2	2023	estimated_living_with_hiv	9400.00	\N	8100.00	11000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.842392	2025-07-01 04:23:29.842392
4096	62	2	2023	estimated_art_coverage_percent	49.00	\N	42.00	57.00	49.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.851536	2025-07-01 04:23:29.851536
4097	63	2	2023	reported_receiving_art	69900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.863342	2025-07-01 04:23:29.863342
4098	63	2	2023	estimated_living_with_hiv	87000.00	\N	71000.00	100000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.903073	2025-07-01 04:23:29.903073
4099	63	2	2023	estimated_art_coverage_percent	80.00	\N	65.00	93.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.912931	2025-07-01 04:23:29.912931
4100	64	2	2023	reported_receiving_art	113000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.920096	2025-07-01 04:23:29.920096
4101	64	2	2023	estimated_living_with_hiv	330000.00	\N	280000.00	390000.00	330000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.930232	2025-07-01 04:23:29.930232
4102	64	2	2023	estimated_art_coverage_percent	34.00	\N	28.00	39.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.944236	2025-07-01 04:23:29.944236
4106	66	2	2023	reported_receiving_art	20200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.955176	2025-07-01 04:23:29.955176
4107	66	2	2023	estimated_living_with_hiv	47000.00	\N	43000.00	51000.00	47000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.966802	2025-07-01 04:23:29.966802
4108	66	2	2023	estimated_art_coverage_percent	43.00	\N	40.00	47.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.977236	2025-07-01 04:23:29.977236
4109	67	2	2023	reported_receiving_art	48600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:29.991135	2025-07-01 04:23:29.991135
4110	67	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	140000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.002797	2025-07-01 04:23:30.002797
4111	67	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	48.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.013087	2025-07-01 04:23:30.013087
4112	68	2	2023	reported_receiving_art	14600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.02418	2025-07-01 04:23:30.02418
4113	68	2	2023	estimated_living_with_hiv	44000.00	\N	39000.00	49000.00	44000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.034183	2025-07-01 04:23:30.034183
4114	68	2	2023	estimated_art_coverage_percent	33.00	\N	29.00	37.00	33.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.046488	2025-07-01 04:23:30.046488
4115	69	2	2023	reported_receiving_art	5600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.058426	2025-07-01 04:23:30.058426
4116	69	2	2023	estimated_living_with_hiv	8200.00	\N	7200.00	9400.00	8200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.068558	2025-07-01 04:23:30.068558
4117	69	2	2023	estimated_art_coverage_percent	68.00	\N	60.00	78.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.079965	2025-07-01 04:23:30.079965
4118	70	2	2023	reported_receiving_art	91500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.092989	2025-07-01 04:23:30.092989
4119	70	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	180000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.10375	2025-07-01 04:23:30.10375
4120	70	2	2023	estimated_art_coverage_percent	58.00	\N	52.00	65.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.114446	2025-07-01 04:23:30.114446
4121	71	2	2023	reported_receiving_art	11700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.12639	2025-07-01 04:23:30.12639
4122	71	2	2023	estimated_living_with_hiv	23000.00	\N	18000.00	28000.00	23000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.167489	2025-07-01 04:23:30.167489
4123	71	2	2023	estimated_art_coverage_percent	50.00	\N	40.00	61.00	50.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.180311	2025-07-01 04:23:30.180311
4124	72	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.19137	2025-07-01 04:23:30.19137
4125	72	2	2023	estimated_living_with_hiv	3700.00	\N	3200.00	4200.00	3700.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.202419	2025-07-01 04:23:30.202419
4126	72	2	2023	estimated_art_coverage_percent	56.00	\N	48.00	63.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.22048	2025-07-01 04:23:30.22048
4127	73	2	2023	reported_receiving_art	250.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.234325	2025-07-01 04:23:30.234325
4128	73	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.246123	2025-07-01 04:23:30.246123
4129	73	2	2023	estimated_art_coverage_percent	79.00	\N	71.00	87.00	79.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.25682	2025-07-01 04:23:30.25682
4133	75	2	2023	reported_receiving_art	108000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.282243	2025-07-01 04:23:30.282243
4134	75	2	2023	estimated_living_with_hiv	640000.00	\N	550000.00	750000.00	640000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.292731	2025-07-01 04:23:30.292731
4135	75	2	2023	estimated_art_coverage_percent	17.00	\N	15.00	20.00	17.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.306511	2025-07-01 04:23:30.306511
4136	76	2	2023	reported_receiving_art	12400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.329818	2025-07-01 04:23:30.329818
4137	76	2	2023	estimated_living_with_hiv	61000.00	\N	34000.00	120000.00	61000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.341025	2025-07-01 04:23:30.341025
4138	76	2	2023	estimated_art_coverage_percent	20.00	\N	11.00	39.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.353011	2025-07-01 04:23:30.353011
4139	77	2	2023	reported_receiving_art	5700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.366785	2025-07-01 04:23:30.366785
4140	77	2	2023	estimated_living_with_hiv	7200.00	\N	6200.00	8000.00	7200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.378203	2025-07-01 04:23:30.378203
4141	77	2	2023	estimated_art_coverage_percent	80.00	\N	69.00	89.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.388049	2025-07-01 04:23:30.388049
4143	78	2	2023	estimated_living_with_hiv	9000.00	\N	8000.00	10000.00	9000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.400378	2025-07-01 04:23:30.400378
4145	79	2	2023	reported_receiving_art	118000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.410793	2025-07-01 04:23:30.410793
4146	79	2	2023	estimated_living_with_hiv	130000.00	\N	110000.00	140000.00	130000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.420927	2025-07-01 04:23:30.420927
4147	79	2	2023	estimated_art_coverage_percent	91.00	\N	78.00	95.00	91.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.431704	2025-07-01 04:23:30.431704
4148	80	2	2023	reported_receiving_art	12600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.443196	2025-07-01 04:23:30.443196
4149	80	2	2023	estimated_living_with_hiv	40000.00	\N	35000.00	46000.00	40000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.464729	2025-07-01 04:23:30.464729
4150	80	2	2023	estimated_art_coverage_percent	31.00	\N	27.00	36.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.474955	2025-07-01 04:23:30.474955
4151	81	2	2023	reported_receiving_art	23700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.568418	2025-07-01 04:23:30.568418
4152	81	2	2023	estimated_living_with_hiv	30000.00	\N	25000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.589311	2025-07-01 04:23:30.589311
4153	81	2	2023	estimated_art_coverage_percent	80.00	\N	68.00	92.00	80.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.629999	2025-07-01 04:23:30.629999
4154	82	2	2023	reported_receiving_art	310.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.641038	2025-07-01 04:23:30.641038
4155	82	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.6818	2025-07-01 04:23:30.6818
4156	82	2	2023	estimated_art_coverage_percent	84.00	\N	76.00	95.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.691004	2025-07-01 04:23:30.691004
4157	83	2	2023	reported_receiving_art	15000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.7323	2025-07-01 04:23:30.7323
4158	83	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	27000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.74439	2025-07-01 04:23:30.74439
4159	83	2	2023	estimated_art_coverage_percent	58.00	\N	54.00	62.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.757415	2025-07-01 04:23:30.757415
4160	84	2	2023	reported_receiving_art	1068000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.804013	2025-07-01 04:23:30.804013
4161	84	2	2023	estimated_living_with_hiv	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.845769	2025-07-01 04:23:30.845769
4162	84	2	2023	estimated_art_coverage_percent	68.00	\N	58.00	82.00	68.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.855845	2025-07-01 04:23:30.855845
4163	85	2	2023	reported_receiving_art	400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.896151	2025-07-01 04:23:30.896151
4164	85	2	2023	estimated_living_with_hiv	640.00	\N	580.00	700.00	640.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.906714	2025-07-01 04:23:30.906714
4165	85	2	2023	estimated_art_coverage_percent	62.00	\N	55.00	67.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.947085	2025-07-01 04:23:30.947085
4166	86	2	2023	reported_receiving_art	3700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.958192	2025-07-01 04:23:30.958192
4167	86	2	2023	estimated_living_with_hiv	8500.00	\N	6500.00	12000.00	8500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:30.99937	2025-07-01 04:23:30.99937
4168	86	2	2023	estimated_art_coverage_percent	43.00	\N	33.00	59.00	43.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.009253	2025-07-01 04:23:31.009253
4169	87	2	2023	reported_receiving_art	6500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.026244	2025-07-01 04:23:31.026244
4170	87	2	2023	estimated_living_with_hiv	12000.00	\N	11000.00	14000.00	12000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.036096	2025-07-01 04:23:31.036096
4171	87	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	62.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.04849	2025-07-01 04:23:31.04849
4172	88	2	2023	reported_receiving_art	2400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.059829	2025-07-01 04:23:31.059829
4173	88	2	2023	estimated_living_with_hiv	5300.00	\N	4800.00	5900.00	5300.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.071962	2025-07-01 04:23:31.071962
4174	88	2	2023	estimated_art_coverage_percent	45.00	\N	41.00	50.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.088354	2025-07-01 04:23:31.088354
4175	89	2	2023	reported_receiving_art	1500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.098353	2025-07-01 04:23:31.098353
4176	89	2	2023	estimated_living_with_hiv	2500.00	\N	2200.00	2800.00	2500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.110481	2025-07-01 04:23:31.110481
4177	89	2	2023	estimated_art_coverage_percent	60.00	\N	53.00	67.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.122073	2025-07-01 04:23:31.122073
4178	90	2	2023	reported_receiving_art	206000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.132915	2025-07-01 04:23:31.132915
4179	90	2	2023	estimated_living_with_hiv	340000.00	\N	320000.00	360000.00	340000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.143105	2025-07-01 04:23:31.143105
4180	90	2	2023	estimated_art_coverage_percent	61.00	\N	57.00	65.00	61.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.156311	2025-07-01 04:23:31.156311
4181	91	2	2023	reported_receiving_art	13900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.16842	2025-07-01 04:23:31.16842
4182	91	2	2023	estimated_living_with_hiv	39000.00	\N	36000.00	44000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.180016	2025-07-01 04:23:31.180016
4183	91	2	2023	estimated_art_coverage_percent	35.00	\N	32.00	39.00	35.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.189655	2025-07-01 04:23:31.189655
4184	92	2	2023	reported_receiving_art	4100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.199525	2025-07-01 04:23:31.199525
4185	92	2	2023	estimated_living_with_hiv	9200.00	\N	8300.00	10000.00	9200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.209245	2025-07-01 04:23:31.209245
4186	92	2	2023	estimated_art_coverage_percent	44.00	\N	40.00	49.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.220471	2025-07-01 04:23:31.220471
4190	94	2	2023	reported_receiving_art	890.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.250608	2025-07-01 04:23:31.250608
4191	94	2	2023	estimated_living_with_hiv	1200.00	\N	1000.00	1300.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.260084	2025-07-01 04:23:31.260084
4192	94	2	2023	estimated_art_coverage_percent	77.00	\N	67.00	86.00	77.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.269878	2025-07-01 04:23:31.269878
4193	95	2	2023	reported_receiving_art	3500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.28278	2025-07-01 04:23:31.28278
4194	95	2	2023	estimated_living_with_hiv	39000.00	\N	30000.00	55000.00	39000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.296926	2025-07-01 04:23:31.296926
4195	95	2	2023	estimated_art_coverage_percent	9.00	\N	7.00	13.00	9.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.31043	2025-07-01 04:23:31.31043
4196	96	2	2023	reported_receiving_art	814000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.323641	2025-07-01 04:23:31.323641
4197	96	2	2023	estimated_living_with_hiv	1000000.00	\N	940000.00	1100000.00	1000000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.336801	2025-07-01 04:23:31.336801
4198	96	2	2023	estimated_art_coverage_percent	78.00	\N	70.00	84.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.34827	2025-07-01 04:23:31.34827
4199	97	2	2023	reported_receiving_art	41500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.358273	2025-07-01 04:23:31.358273
4200	97	2	2023	estimated_living_with_hiv	87000.00	\N	77000.00	98000.00	87000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.368122	2025-07-01 04:23:31.368122
4201	97	2	2023	estimated_art_coverage_percent	48.00	\N	42.00	53.00	48.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.380597	2025-07-01 04:23:31.380597
4205	99	2	2023	reported_receiving_art	47100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.390993	2025-07-01 04:23:31.390993
4206	99	2	2023	estimated_living_with_hiv	150000.00	\N	120000.00	190000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.401408	2025-07-01 04:23:31.401408
4207	99	2	2023	estimated_art_coverage_percent	31.00	\N	25.00	39.00	31.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.411162	2025-07-01 04:23:31.411162
4211	101	2	2023	reported_receiving_art	3000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.424074	2025-07-01 04:23:31.424074
4212	101	2	2023	estimated_living_with_hiv	5600.00	\N	4500.00	7200.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.437933	2025-07-01 04:23:31.437933
4213	101	2	2023	estimated_art_coverage_percent	54.00	\N	44.00	69.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.455999	2025-07-01 04:23:31.455999
4214	102	2	2023	reported_receiving_art	2800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.468452	2025-07-01 04:23:31.468452
4215	102	2	2023	estimated_living_with_hiv	13000.00	\N	10000.00	15000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.480246	2025-07-01 04:23:31.480246
4216	102	2	2023	estimated_art_coverage_percent	22.00	\N	18.00	26.00	22.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.490311	2025-07-01 04:23:31.490311
4217	103	2	2023	reported_receiving_art	165000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.502492	2025-07-01 04:23:31.502492
4218	103	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	270000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.516259	2025-07-01 04:23:31.516259
4219	103	2	2023	estimated_art_coverage_percent	70.00	\N	60.00	80.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.527994	2025-07-01 04:23:31.527994
4220	104	2	2023	reported_receiving_art	200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.541651	2025-07-01 04:23:31.541651
4221	104	2	2023	estimated_living_with_hiv	600.00	\N	530.00	670.00	600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.553999	2025-07-01 04:23:31.553999
4222	104	2	2023	estimated_art_coverage_percent	32.00	\N	29.00	36.00	32.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.561601	2025-07-01 04:23:31.561601
4223	105	2	2023	reported_receiving_art	160.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.574248	2025-07-01 04:23:31.574248
4224	105	2	2023	estimated_living_with_hiv	500.00	\N	500.00	500.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.582645	2025-07-01 04:23:31.582645
4225	105	2	2023	estimated_art_coverage_percent	40.00	\N	34.00	46.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.593673	2025-07-01 04:23:31.593673
4226	106	2	2023	reported_receiving_art	13600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.605307	2025-07-01 04:23:31.605307
4227	106	2	2023	estimated_living_with_hiv	21000.00	\N	17000.00	28000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.614847	2025-07-01 04:23:31.614847
4228	106	2	2023	estimated_art_coverage_percent	65.00	\N	52.00	86.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.626147	2025-07-01 04:23:31.626147
4229	107	2	2023	reported_receiving_art	1213000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.637397	2025-07-01 04:23:31.637397
4230	107	2	2023	estimated_living_with_hiv	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.649618	2025-07-01 04:23:31.649618
4231	107	2	2023	estimated_art_coverage_percent	56.00	\N	44.00	68.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.658919	2025-07-01 04:23:31.658919
4232	108	2	2023	reported_receiving_art	167000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.674306	2025-07-01 04:23:31.674306
4233	108	2	2023	estimated_living_with_hiv	240000.00	\N	210000.00	270000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.68765	2025-07-01 04:23:31.68765
4234	108	2	2023	estimated_art_coverage_percent	70.00	\N	63.00	79.00	70.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.699492	2025-07-01 04:23:31.699492
4235	109	2	2023	reported_receiving_art	184000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.712662	2025-07-01 04:23:31.712662
4236	109	2	2023	estimated_living_with_hiv	200000.00	\N	190000.00	220000.00	200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.728331	2025-07-01 04:23:31.728331
4237	109	2	2023	estimated_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.744464	2025-07-01 04:23:31.744464
4238	110	2	2023	reported_receiving_art	16900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.760512	2025-07-01 04:23:31.760512
4239	110	2	2023	estimated_living_with_hiv	30000.00	\N	26000.00	34000.00	30000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.780628	2025-07-01 04:23:31.780628
4240	110	2	2023	estimated_art_coverage_percent	56.00	\N	50.00	65.00	56.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.800537	2025-07-01 04:23:31.800537
4244	112	2	2023	reported_receiving_art	2700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.809342	2025-07-01 04:23:31.809342
4245	112	2	2023	estimated_living_with_hiv	3600.00	\N	3100.00	4200.00	3600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.823327	2025-07-01 04:23:31.823327
4246	112	2	2023	estimated_art_coverage_percent	73.00	\N	62.00	84.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.840388	2025-07-01 04:23:31.840388
4247	113	2	2023	reported_receiving_art	5000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.857609	2025-07-01 04:23:31.857609
4248	113	2	2023	estimated_living_with_hiv	9400.00	\N	7600.00	12000.00	9400.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.876732	2025-07-01 04:23:31.876732
4249	113	2	2023	estimated_art_coverage_percent	53.00	\N	43.00	68.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.897256	2025-07-01 04:23:31.897256
4250	114	2	2023	reported_receiving_art	19800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.916358	2025-07-01 04:23:31.916358
4251	114	2	2023	estimated_living_with_hiv	36000.00	\N	30000.00	43000.00	36000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.938406	2025-07-01 04:23:31.938406
4252	114	2	2023	estimated_art_coverage_percent	54.00	\N	45.00	65.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.956794	2025-07-01 04:23:31.956794
4253	115	2	2023	reported_receiving_art	1016000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.970616	2025-07-01 04:23:31.970616
4254	115	2	2023	estimated_living_with_hiv	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:31.985518	2025-07-01 04:23:31.985518
4255	115	2	2023	estimated_art_coverage_percent	53.00	\N	40.00	71.00	53.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.005398	2025-07-01 04:23:32.005398
4256	116	2	2023	reported_receiving_art	4700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.022295	2025-07-01 04:23:32.022295
4257	116	2	2023	estimated_living_with_hiv	5800.00	\N	5200.00	6300.00	5800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.045642	2025-07-01 04:23:32.045642
4258	116	2	2023	estimated_art_coverage_percent	82.00	\N	74.00	90.00	82.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.072009	2025-07-01 04:23:32.072009
4259	117	2	2023	reported_receiving_art	1300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.089721	2025-07-01 04:23:32.089721
4260	117	2	2023	estimated_living_with_hiv	3200.00	\N	2900.00	3600.00	3200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.107693	2025-07-01 04:23:32.107693
4261	117	2	2023	estimated_art_coverage_percent	41.00	\N	37.00	45.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.122024	2025-07-01 04:23:32.122024
4262	118	2	2023	reported_receiving_art	15800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.144088	2025-07-01 04:23:32.144088
4263	118	2	2023	estimated_living_with_hiv	160000.00	\N	140000.00	190000.00	160000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.155247	2025-07-01 04:23:32.155247
4264	118	2	2023	estimated_art_coverage_percent	10.00	\N	9.00	11.00	10.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.19078	2025-07-01 04:23:32.19078
4265	119	2	2023	reported_receiving_art	14200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.231857	2025-07-01 04:23:32.231857
4266	119	2	2023	estimated_living_with_hiv	26000.00	\N	24000.00	29000.00	26000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.271271	2025-07-01 04:23:32.271271
4267	119	2	2023	estimated_art_coverage_percent	54.00	\N	48.00	59.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.281406	2025-07-01 04:23:32.281406
4268	120	2	2023	reported_receiving_art	29400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.299862	2025-07-01 04:23:32.299862
4269	120	2	2023	estimated_living_with_hiv	45000.00	\N	41000.00	50000.00	45000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.317098	2025-07-01 04:23:32.317098
4270	120	2	2023	estimated_art_coverage_percent	65.00	\N	58.00	71.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.327757	2025-07-01 04:23:32.327757
4271	121	2	2023	reported_receiving_art	8500.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.340333	2025-07-01 04:23:32.340333
4272	121	2	2023	estimated_living_with_hiv	21000.00	\N	16000.00	31000.00	21000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.350126	2025-07-01 04:23:32.350126
4273	121	2	2023	estimated_art_coverage_percent	40.00	\N	31.00	58.00	40.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.363995	2025-07-01 04:23:32.363995
4274	122	2	2023	reported_receiving_art	57800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.374951	2025-07-01 04:23:32.374951
4275	122	2	2023	estimated_living_with_hiv	79000.00	\N	58000.00	110000.00	79000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.386805	2025-07-01 04:23:32.386805
4276	122	2	2023	estimated_art_coverage_percent	73.00	\N	54.00	95.00	73.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.396779	2025-07-01 04:23:32.396779
4277	123	2	2023	reported_receiving_art	33600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.406606	2025-07-01 04:23:32.406606
4278	123	2	2023	estimated_living_with_hiv	77000.00	\N	65000.00	90000.00	77000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.419252	2025-07-01 04:23:32.419252
4279	123	2	2023	estimated_art_coverage_percent	44.00	\N	37.00	51.00	44.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.430072	2025-07-01 04:23:32.430072
4283	125	2	2023	reported_receiving_art	37200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.441972	2025-07-01 04:23:32.441972
4284	125	2	2023	estimated_living_with_hiv	41000.00	\N	36000.00	46000.00	41000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.45252	2025-07-01 04:23:32.45252
4285	125	2	2023	estimated_art_coverage_percent	90.00	\N	78.00	95.00	90.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.463078	2025-07-01 04:23:32.463078
4286	126	2	2023	reported_receiving_art	150.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.472443	2025-07-01 04:23:32.472443
4292	128	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.483679	2025-07-01 04:23:32.483679
4293	128	2	2023	estimated_living_with_hiv	17000.00	\N	14000.00	23000.00	17000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.493354	2025-07-01 04:23:32.493354
4294	128	2	2023	estimated_art_coverage_percent	34.00	\N	27.00	45.00	34.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.524897	2025-07-01 04:23:32.524897
4295	129	2	2023	reported_receiving_art	240.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.538175	2025-07-01 04:23:32.538175
4296	129	2	2023	estimated_living_with_hiv	500.00	\N	500.00	520.00	500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.56187	2025-07-01 04:23:32.56187
4297	129	2	2023	estimated_art_coverage_percent	54.00	\N	47.00	63.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.59847	2025-07-01 04:23:32.59847
4298	130	2	2023	reported_receiving_art	12100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.637203	2025-07-01 04:23:32.637203
4299	130	2	2023	estimated_living_with_hiv	18000.00	\N	16000.00	20000.00	18000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.647378	2025-07-01 04:23:32.647378
4300	130	2	2023	estimated_art_coverage_percent	67.00	\N	60.00	73.00	67.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.672341	2025-07-01 04:23:32.672341
4304	132	2	2023	reported_receiving_art	194000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.718052	2025-07-01 04:23:32.718052
4305	132	2	2023	estimated_living_with_hiv	220000.00	\N	200000.00	250000.00	220000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.728117	2025-07-01 04:23:32.728117
4306	132	2	2023	estimated_art_coverage_percent	87.00	\N	76.00	95.00	87.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.769358	2025-07-01 04:23:32.769358
4307	133	2	2023	reported_receiving_art	6300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.810546	2025-07-01 04:23:32.810546
4310	134	2	2023	reported_receiving_art	26600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.821096	2025-07-01 04:23:32.821096
4311	134	2	2023	estimated_living_with_hiv	42000.00	\N	37000.00	47000.00	42000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.833074	2025-07-01 04:23:32.833074
4312	134	2	2023	estimated_art_coverage_percent	63.00	\N	55.00	71.00	63.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.863674	2025-07-01 04:23:32.863674
4313	135	2	2023	reported_receiving_art	2000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.874062	2025-07-01 04:23:32.874062
4314	135	2	2023	estimated_living_with_hiv	3000.00	\N	2200.00	3800.00	3000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.884703	2025-07-01 04:23:32.884703
4315	135	2	2023	estimated_art_coverage_percent	65.00	\N	47.00	83.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.897349	2025-07-01 04:23:32.897349
4316	136	2	2023	reported_receiving_art	28400.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.907722	2025-07-01 04:23:32.907722
4317	136	2	2023	estimated_living_with_hiv	70000.00	\N	56000.00	86000.00	70000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.919245	2025-07-01 04:23:32.919245
4318	136	2	2023	estimated_art_coverage_percent	41.00	\N	33.00	50.00	41.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.931933	2025-07-01 04:23:32.931933
4319	137	2	2023	reported_receiving_art	6200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.941821	2025-07-01 04:23:32.941821
4320	137	2	2023	estimated_living_with_hiv	7900.00	\N	7200.00	8700.00	7900.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.952565	2025-07-01 04:23:32.952565
4321	137	2	2023	estimated_art_coverage_percent	78.00	\N	71.00	86.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.963919	2025-07-01 04:23:32.963919
4322	138	2	2023	reported_receiving_art	650.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.978274	2025-07-01 04:23:32.978274
4323	138	2	2023	estimated_living_with_hiv	1200.00	\N	910.00	1900.00	1200.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:32.99149	2025-07-01 04:23:32.99149
4324	138	2	2023	estimated_art_coverage_percent	54.00	\N	40.00	85.00	54.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.00618	2025-07-01 04:23:33.00618
4328	140	2	2023	reported_receiving_art	3300.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.029604	2025-07-01 04:23:33.029604
4329	140	2	2023	estimated_living_with_hiv	11000.00	\N	8400.00	15000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.055407	2025-07-01 04:23:33.055407
4330	140	2	2023	estimated_art_coverage_percent	30.00	\N	23.00	41.00	30.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.066206	2025-07-01 04:23:33.066206
4331	141	2	2023	reported_receiving_art	4788000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.098418	2025-07-01 04:23:33.098418
4332	141	2	2023	estimated_living_with_hiv	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.139253	2025-07-01 04:23:33.139253
4333	141	2	2023	estimated_art_coverage_percent	62.00	\N	57.00	66.00	62.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.150629	2025-07-01 04:23:33.150629
4334	142	2	2023	reported_receiving_art	30700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.186298	2025-07-01 04:23:33.186298
4335	142	2	2023	estimated_living_with_hiv	190000.00	\N	140000.00	240000.00	190000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.203971	2025-07-01 04:23:33.203971
4336	142	2	2023	estimated_art_coverage_percent	16.00	\N	12.00	20.00	16.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.222903	2025-07-01 04:23:33.222903
4337	143	2	2023	reported_receiving_art	125000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.24261	2025-07-01 04:23:33.24261
4338	143	2	2023	estimated_living_with_hiv	150000.00	\N	130000.00	170000.00	150000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.268419	2025-07-01 04:23:33.268419
4339	143	2	2023	estimated_art_coverage_percent	84.00	\N	73.00	94.00	84.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.286013	2025-07-01 04:23:33.286013
4340	144	2	2023	reported_receiving_art	1600.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.305384	2025-07-01 04:23:33.305384
4341	144	2	2023	estimated_living_with_hiv	3500.00	\N	3100.00	4000.00	3500.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.325957	2025-07-01 04:23:33.325957
4342	144	2	2023	estimated_art_coverage_percent	45.00	\N	40.00	52.00	45.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.344679	2025-07-01 04:23:33.344679
4343	145	2	2023	reported_receiving_art	9000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.365596	2025-07-01 04:23:33.365596
4344	145	2	2023	estimated_living_with_hiv	59000.00	\N	26000.00	110000.00	59000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.388663	2025-07-01 04:23:33.388663
4345	145	2	2023	estimated_art_coverage_percent	15.00	\N	7.00	28.00	15.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.409248	2025-07-01 04:23:33.409248
4346	146	2	2023	reported_receiving_art	2900.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.426989	2025-07-01 04:23:33.426989
4347	146	2	2023	estimated_living_with_hiv	5600.00	\N	3700.00	8100.00	5600.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.445941	2025-07-01 04:23:33.445941
4348	146	2	2023	estimated_art_coverage_percent	52.00	\N	35.00	75.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.465083	2025-07-01 04:23:33.465083
4352	148	2	2023	reported_receiving_art	14800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.490822	2025-07-01 04:23:33.490822
4355	149	2	2023	reported_receiving_art	130.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.509917	2025-07-01 04:23:33.509917
4356	149	2	2023	estimated_living_with_hiv	660.00	\N	590.00	720.00	660.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.529101	2025-07-01 04:23:33.529101
4357	149	2	2023	estimated_art_coverage_percent	20.00	\N	18.00	22.00	20.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.563957	2025-07-01 04:23:33.563957
4358	150	2	2023	reported_receiving_art	6000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.583857	2025-07-01 04:23:33.583857
4359	150	2	2023	estimated_living_with_hiv	13000.00	\N	11000.00	16000.00	13000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.610227	2025-07-01 04:23:33.610227
4360	150	2	2023	estimated_art_coverage_percent	46.00	\N	38.00	56.00	46.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.63974	2025-07-01 04:23:33.63974
4361	151	2	2023	reported_receiving_art	359000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.657579	2025-07-01 04:23:33.657579
4362	151	2	2023	estimated_living_with_hiv	480000.00	\N	420000.00	550000.00	480000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.679376	2025-07-01 04:23:33.679376
4363	151	2	2023	estimated_art_coverage_percent	75.00	\N	66.00	86.00	75.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.699346	2025-07-01 04:23:33.699346
4367	153	2	2023	reported_receiving_art	64800.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.718026	2025-07-01 04:23:33.718026
4368	153	2	2023	estimated_living_with_hiv	110000.00	\N	100000.00	120000.00	110000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.770034	2025-07-01 04:23:33.770034
4369	153	2	2023	estimated_art_coverage_percent	60.00	\N	56.00	65.00	60.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.804699	2025-07-01 04:23:33.804699
4373	155	2	2023	reported_receiving_art	1100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.841946	2025-07-01 04:23:33.841946
4374	155	2	2023	estimated_living_with_hiv	2800.00	\N	1700.00	4400.00	2800.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.873386	2025-07-01 04:23:33.873386
4375	155	2	2023	estimated_art_coverage_percent	39.00	\N	24.00	61.00	39.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.907769	2025-07-01 04:23:33.907769
4382	158	2	2023	reported_receiving_art	1004000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.934959	2025-07-01 04:23:33.934959
4383	158	2	2023	estimated_living_with_hiv	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:33.972836	2025-07-01 04:23:33.972836
4384	158	2	2023	estimated_art_coverage_percent	72.00	\N	68.00	78.00	72.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.006098	2025-07-01 04:23:34.006098
4385	159	2	2023	reported_receiving_art	124000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.026939	2025-07-01 04:23:34.026939
4386	159	2	2023	estimated_living_with_hiv	240000.00	\N	220000.00	260000.00	240000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.045997	2025-07-01 04:23:34.045997
4387	159	2	2023	estimated_art_coverage_percent	52.00	\N	48.00	56.00	52.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.063776	2025-07-01 04:23:34.063776
4394	162	2	2023	reported_receiving_art	1109000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.081711	2025-07-01 04:23:34.081711
4395	162	2	2023	estimated_living_with_hiv	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.101171	2025-07-01 04:23:34.101171
4396	162	2	2023	estimated_art_coverage_percent	71.00	\N	64.00	78.00	71.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.120922	2025-07-01 04:23:34.120922
4400	164	2	2023	reported_receiving_art	8100.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.135447	2025-07-01 04:23:34.135447
4401	164	2	2023	estimated_living_with_hiv	14000.00	\N	9900.00	19000.00	14000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.151895	2025-07-01 04:23:34.151895
4402	164	2	2023	estimated_art_coverage_percent	58.00	\N	41.00	76.00	58.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.160871	2025-07-01 04:23:34.160871
4403	165	2	2023	reported_receiving_art	26700.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.170484	2025-07-01 04:23:34.170484
4404	165	2	2023	estimated_living_with_hiv	52000.00	\N	48000.00	56000.00	52000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.181959	2025-07-01 04:23:34.181959
4405	165	2	2023	estimated_art_coverage_percent	51.00	\N	47.00	55.00	51.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.19318	2025-07-01 04:23:34.19318
4407	166	2	2023	estimated_living_with_hiv	120000.00	\N	100000.00	130000.00	120000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.204849	2025-07-01 04:23:34.204849
4409	167	2	2023	reported_receiving_art	150000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.214934	2025-07-01 04:23:34.214934
4410	167	2	2023	estimated_living_with_hiv	230000.00	\N	200000.00	260000.00	230000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.226092	2025-07-01 04:23:34.226092
4411	167	2	2023	estimated_art_coverage_percent	65.00	\N	57.00	73.00	65.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.233421	2025-07-01 04:23:34.233421
4412	168	2	2023	reported_receiving_art	2200.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.245937	2025-07-01 04:23:34.245937
4413	168	2	2023	estimated_living_with_hiv	11000.00	\N	6500.00	18000.00	11000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.25622	2025-07-01 04:23:34.25622
4414	168	2	2023	estimated_art_coverage_percent	21.00	\N	12.00	35.00	21.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.265871	2025-07-01 04:23:34.265871
4415	169	2	2023	reported_receiving_art	965000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.276832	2025-07-01 04:23:34.276832
4416	169	2	2023	estimated_living_with_hiv	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.290318	2025-07-01 04:23:34.290318
4417	169	2	2023	estimated_art_coverage_percent	78.00	\N	69.00	88.00	78.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.303273	2025-07-01 04:23:34.303273
4418	170	2	2023	reported_receiving_art	1151000.00	\N	\N	\N	\N	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.317861	2025-07-01 04:23:34.317861
4419	170	2	2023	estimated_living_with_hiv	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.329335	2025-07-01 04:23:34.329335
4420	170	2	2023	estimated_art_coverage_percent	88.00	\N	77.00	95.00	88.00	good	art_coverage_by_country_clean.csv	\N	2025-07-01 04:23:34.339114	2025-07-01 04:23:34.339114
4421	1	3	2018	count	7200.00	\N	4100.00	11000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.350179	2025-07-01 04:23:34.350179
4423	3	3	2018	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.360507	2025-07-01 04:23:34.360507
4424	4	3	2018	count	330000.00	\N	290000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.370465	2025-07-01 04:23:34.370465
4425	5	3	2018	count	140000.00	\N	130000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.381759	2025-07-01 04:23:34.381759
4426	6	3	2018	count	3500.00	\N	3000.00	4400.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.394914	2025-07-01 04:23:34.394914
4427	7	3	2018	count	28000.00	\N	23000.00	31000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.407259	2025-07-01 04:23:34.407259
4430	10	3	2018	count	6000.00	\N	5300.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.420305	2025-07-01 04:23:34.420305
4432	12	3	2018	count	14000.00	\N	12000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.431205	2025-07-01 04:23:34.431205
4433	13	3	2018	count	3000.00	\N	2700.00	3400.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.444813	2025-07-01 04:23:34.444813
4434	14	3	2018	count	27000.00	\N	22000.00	34000.00	27000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.458395	2025-07-01 04:23:34.458395
4436	16	3	2018	count	4900.00	\N	4400.00	5400.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.472613	2025-07-01 04:23:34.472613
4437	17	3	2018	count	73000.00	\N	48000.00	120000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.48651	2025-07-01 04:23:34.48651
4438	18	3	2018	count	1300.00	\N	700.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.497512	2025-07-01 04:23:34.497512
4439	19	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.509491	2025-07-01 04:23:34.509491
4440	20	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.526827	2025-07-01 04:23:34.526827
4441	21	3	2018	count	370000.00	\N	330000.00	400000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.537864	2025-07-01 04:23:34.537864
4442	22	3	2018	count	900000.00	\N	690000.00	1100000.00	900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.551123	2025-07-01 04:23:34.551123
4444	24	3	2018	count	3500.00	\N	3000.00	4100.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.562791	2025-07-01 04:23:34.562791
4445	25	3	2018	count	96000.00	\N	78000.00	120000.00	96000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.574288	2025-07-01 04:23:34.574288
4446	26	3	2018	count	82000.00	\N	71000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.584881	2025-07-01 04:23:34.584881
4447	27	3	2018	count	2400.00	\N	2100.00	2900.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.59542	2025-07-01 04:23:34.59542
4448	28	3	2018	count	73000.00	\N	64000.00	84000.00	73000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.606351	2025-07-01 04:23:34.606351
4449	29	3	2018	count	540000.00	\N	470000.00	590000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.625158	2025-07-01 04:23:34.625158
4451	31	3	2018	count	110000.00	\N	90000.00	140000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.635398	2025-07-01 04:23:34.635398
4452	32	3	2018	count	120000.00	\N	94000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.645153	2025-07-01 04:23:34.645153
4453	33	3	2018	count	71000.00	\N	63000.00	78000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.656529	2025-07-01 04:23:34.656529
4455	35	3	2018	count	160000.00	\N	130000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.670134	2025-07-01 04:23:34.670134
4456	36	3	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.681401	2025-07-01 04:23:34.681401
4457	37	3	2018	count	89000.00	\N	69000.00	120000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.691164	2025-07-01 04:23:34.691164
4458	38	3	2018	count	15000.00	\N	13000.00	17000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.700569	2025-07-01 04:23:34.700569
4459	39	3	2018	count	460000.00	\N	360000.00	580000.00	460000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.71068	2025-07-01 04:23:34.71068
4460	40	3	2018	count	1600.00	\N	1400.00	1700.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.722306	2025-07-01 04:23:34.722306
4461	41	3	2018	count	31000.00	\N	24000.00	37000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.73383	2025-07-01 04:23:34.73383
4463	43	3	2018	count	4400.00	\N	3700.00	5000.00	4400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.746387	2025-07-01 04:23:34.746387
4465	45	3	2018	count	450000.00	\N	370000.00	530000.00	450000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.759842	2025-07-01 04:23:34.759842
4466	46	3	2018	count	6200.00	\N	5600.00	7000.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.772444	2025-07-01 04:23:34.772444
4467	47	3	2018	count	8800.00	\N	7100.00	11000.00	8800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.785741	2025-07-01 04:23:34.785741
4468	48	3	2018	count	70000.00	\N	54000.00	92000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.795453	2025-07-01 04:23:34.795453
4469	49	3	2018	count	44000.00	\N	29000.00	71000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.806407	2025-07-01 04:23:34.806407
4470	50	3	2018	count	22000.00	\N	20000.00	24000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.817576	2025-07-01 04:23:34.817576
4471	51	3	2018	count	25000.00	\N	21000.00	30000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.828791	2025-07-01 04:23:34.828791
4472	52	3	2018	count	62000.00	\N	50000.00	81000.00	62000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.839161	2025-07-01 04:23:34.839161
4473	53	3	2018	count	18000.00	\N	13000.00	24000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.850023	2025-07-01 04:23:34.850023
4474	54	3	2018	count	7400.00	\N	6600.00	8200.00	7400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.86121	2025-07-01 04:23:34.86121
4475	55	3	2018	count	210000.00	\N	190000.00	220000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.87365	2025-07-01 04:23:34.87365
4476	56	3	2018	count	690000.00	\N	530000.00	900000.00	690000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.883143	2025-07-01 04:23:34.883143
4478	58	3	2018	count	4000.00	\N	3100.00	4900.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.895638	2025-07-01 04:23:34.895638
4479	59	3	2018	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.905581	2025-07-01 04:23:34.905581
4480	60	3	2018	count	53000.00	\N	43000.00	67000.00	53000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.91597	2025-07-01 04:23:34.91597
4481	61	3	2018	count	26000.00	\N	21000.00	33000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.930033	2025-07-01 04:23:34.930033
4482	62	3	2018	count	9400.00	\N	8100.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.939786	2025-07-01 04:23:34.939786
4483	63	3	2018	count	87000.00	\N	71000.00	100000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.950511	2025-07-01 04:23:34.950511
4484	64	3	2018	count	330000.00	\N	280000.00	390000.00	330000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:34.96066	2025-07-01 04:23:34.96066
4486	66	3	2018	count	47000.00	\N	43000.00	51000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.001431	2025-07-01 04:23:35.001431
4487	67	3	2018	count	120000.00	\N	100000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.043011	2025-07-01 04:23:35.043011
4488	68	3	2018	count	44000.00	\N	39000.00	49000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.083933	2025-07-01 04:23:35.083933
4489	69	3	2018	count	8200.00	\N	7200.00	9400.00	8200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.095832	2025-07-01 04:23:35.095832
4490	70	3	2018	count	160000.00	\N	140000.00	180000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.136991	2025-07-01 04:23:35.136991
4491	71	3	2018	count	23000.00	\N	18000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.151856	2025-07-01 04:23:35.151856
4492	72	3	2018	count	3700.00	\N	3200.00	4200.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.171177	2025-07-01 04:23:35.171177
4493	73	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.190795	2025-07-01 04:23:35.190795
4495	75	3	2018	count	640000.00	\N	550000.00	750000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.22105	2025-07-01 04:23:35.22105
4496	76	3	2018	count	61000.00	\N	34000.00	120000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.269611	2025-07-01 04:23:35.269611
4497	77	3	2018	count	7200.00	\N	6200.00	8000.00	7200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.292898	2025-07-01 04:23:35.292898
4498	78	3	2018	count	9000.00	\N	8000.00	10000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.330007	2025-07-01 04:23:35.330007
4499	79	3	2018	count	130000.00	\N	110000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.375347	2025-07-01 04:23:35.375347
4500	80	3	2018	count	40000.00	\N	35000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.39762	2025-07-01 04:23:35.39762
4501	81	3	2018	count	30000.00	\N	25000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.424823	2025-07-01 04:23:35.424823
4502	82	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.454742	2025-07-01 04:23:35.454742
4503	83	3	2018	count	26000.00	\N	24000.00	27000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.47207	2025-07-01 04:23:35.47207
4504	84	3	2018	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.501146	2025-07-01 04:23:35.501146
4505	85	3	2018	count	640.00	\N	580.00	700.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.537758	2025-07-01 04:23:35.537758
4506	86	3	2018	count	8500.00	\N	6500.00	12000.00	8500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.559613	2025-07-01 04:23:35.559613
4507	87	3	2018	count	12000.00	\N	11000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.578277	2025-07-01 04:23:35.578277
4508	88	3	2018	count	5300.00	\N	4800.00	5900.00	5300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.601005	2025-07-01 04:23:35.601005
4509	89	3	2018	count	2500.00	\N	2200.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.64441	2025-07-01 04:23:35.64441
4510	90	3	2018	count	340000.00	\N	320000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.671409	2025-07-01 04:23:35.671409
4511	91	3	2018	count	39000.00	\N	36000.00	44000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.697501	2025-07-01 04:23:35.697501
4512	92	3	2018	count	9200.00	\N	8300.00	10000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.7258	2025-07-01 04:23:35.7258
4514	94	3	2018	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.746302	2025-07-01 04:23:35.746302
4515	95	3	2018	count	39000.00	\N	30000.00	55000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.827468	2025-07-01 04:23:35.827468
4516	96	3	2018	count	1000000.00	\N	940000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.840414	2025-07-01 04:23:35.840414
4517	97	3	2018	count	87000.00	\N	77000.00	98000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.862317	2025-07-01 04:23:35.862317
4519	99	3	2018	count	150000.00	\N	120000.00	190000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.879035	2025-07-01 04:23:35.879035
4521	101	3	2018	count	5600.00	\N	4500.00	7200.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.891413	2025-07-01 04:23:35.891413
4522	102	3	2018	count	13000.00	\N	10000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.909867	2025-07-01 04:23:35.909867
4523	103	3	2018	count	230000.00	\N	200000.00	270000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.922641	2025-07-01 04:23:35.922641
4524	104	3	2018	count	600.00	\N	530.00	670.00	600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.937044	2025-07-01 04:23:35.937044
4525	105	3	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.949887	2025-07-01 04:23:35.949887
4526	106	3	2018	count	21000.00	\N	17000.00	28000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.961051	2025-07-01 04:23:35.961051
4527	107	3	2018	count	2200000.00	\N	1700000.00	2700000.00	2200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.983601	2025-07-01 04:23:35.983601
4528	108	3	2018	count	240000.00	\N	210000.00	270000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:35.99531	2025-07-01 04:23:35.99531
4529	109	3	2018	count	200000.00	\N	190000.00	220000.00	200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.004941	2025-07-01 04:23:36.004941
4530	110	3	2018	count	30000.00	\N	26000.00	34000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.014381	2025-07-01 04:23:36.014381
4532	112	3	2018	count	3600.00	\N	3100.00	4200.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.025186	2025-07-01 04:23:36.025186
4533	113	3	2018	count	9400.00	\N	7600.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.037219	2025-07-01 04:23:36.037219
4534	114	3	2018	count	36000.00	\N	30000.00	43000.00	36000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.048951	2025-07-01 04:23:36.048951
4535	115	3	2018	count	1900000.00	\N	1400000.00	2600000.00	1900000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.064895	2025-07-01 04:23:36.064895
4536	116	3	2018	count	5800.00	\N	5200.00	6300.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.082084	2025-07-01 04:23:36.082084
4537	117	3	2018	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.095648	2025-07-01 04:23:36.095648
4538	118	3	2018	count	160000.00	\N	140000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.107772	2025-07-01 04:23:36.107772
4539	119	3	2018	count	26000.00	\N	24000.00	29000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.121731	2025-07-01 04:23:36.121731
4540	120	3	2018	count	45000.00	\N	41000.00	50000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.134454	2025-07-01 04:23:36.134454
4541	121	3	2018	count	21000.00	\N	16000.00	31000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.146379	2025-07-01 04:23:36.146379
4542	122	3	2018	count	79000.00	\N	58000.00	110000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.157805	2025-07-01 04:23:36.157805
4543	123	3	2018	count	77000.00	\N	65000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.167716	2025-07-01 04:23:36.167716
4545	125	3	2018	count	41000.00	\N	36000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.178167	2025-07-01 04:23:36.178167
4548	128	3	2018	count	17000.00	\N	14000.00	23000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.189971	2025-07-01 04:23:36.189971
4549	129	3	2018	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.203233	2025-07-01 04:23:36.203233
4550	130	3	2018	count	18000.00	\N	16000.00	20000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.215332	2025-07-01 04:23:36.215332
4552	132	3	2018	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.227501	2025-07-01 04:23:36.227501
4554	134	3	2018	count	42000.00	\N	37000.00	47000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.237572	2025-07-01 04:23:36.237572
4555	135	3	2018	count	3000.00	\N	2200.00	3800.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.251793	2025-07-01 04:23:36.251793
4556	136	3	2018	count	70000.00	\N	56000.00	86000.00	70000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.262156	2025-07-01 04:23:36.262156
4557	137	3	2018	count	7900.00	\N	7200.00	8700.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.273232	2025-07-01 04:23:36.273232
4558	138	3	2018	count	1200.00	\N	910.00	1900.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.290805	2025-07-01 04:23:36.290805
4560	140	3	2018	count	11000.00	\N	8400.00	15000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.305986	2025-07-01 04:23:36.305986
4561	141	3	2018	count	7700000.00	\N	7100000.00	8300000.00	7700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.317615	2025-07-01 04:23:36.317615
4562	142	3	2018	count	190000.00	\N	140000.00	240000.00	190000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.331534	2025-07-01 04:23:36.331534
4563	143	3	2018	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.350062	2025-07-01 04:23:36.350062
4564	144	3	2018	count	3500.00	\N	3100.00	4000.00	3500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.360234	2025-07-01 04:23:36.360234
4565	145	3	2018	count	59000.00	\N	26000.00	110000.00	59000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.371237	2025-07-01 04:23:36.371237
4566	146	3	2018	count	5600.00	\N	3700.00	8100.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.382937	2025-07-01 04:23:36.382937
4569	149	3	2018	count	660.00	\N	590.00	720.00	660.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.395229	2025-07-01 04:23:36.395229
4570	150	3	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.406052	2025-07-01 04:23:36.406052
4571	151	3	2018	count	480000.00	\N	420000.00	550000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.422827	2025-07-01 04:23:36.422827
4573	153	3	2018	count	110000.00	\N	100000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.434324	2025-07-01 04:23:36.434324
4575	155	3	2018	count	2800.00	\N	1700.00	4400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.446378	2025-07-01 04:23:36.446378
4578	158	3	2018	count	1400000.00	\N	1300000.00	1500000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.461051	2025-07-01 04:23:36.461051
4579	159	3	2018	count	240000.00	\N	220000.00	260000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.473498	2025-07-01 04:23:36.473498
4582	162	3	2018	count	1600000.00	\N	1400000.00	1700000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.484795	2025-07-01 04:23:36.484795
4584	164	3	2018	count	14000.00	\N	9900.00	19000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.497676	2025-07-01 04:23:36.497676
4585	165	3	2018	count	52000.00	\N	48000.00	56000.00	52000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.508842	2025-07-01 04:23:36.508842
4586	166	3	2018	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.521061	2025-07-01 04:23:36.521061
4587	167	3	2018	count	230000.00	\N	200000.00	260000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.533921	2025-07-01 04:23:36.533921
4588	168	3	2018	count	11000.00	\N	6500.00	18000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.54588	2025-07-01 04:23:36.54588
4589	169	3	2018	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.560441	2025-07-01 04:23:36.560441
4590	170	3	2018	count	1300000.00	\N	1100000.00	1500000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.571415	2025-07-01 04:23:36.571415
4591	1	3	2010	count	4200.00	\N	2500.00	6200.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.584498	2025-07-01 04:23:36.584498
4593	3	3	2010	count	7100.00	\N	6600.00	7600.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.593601	2025-07-01 04:23:36.593601
4594	4	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.605364	2025-07-01 04:23:36.605364
4595	5	3	2010	count	110000.00	\N	96000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.614732	2025-07-01 04:23:36.614732
4596	6	3	2010	count	3300.00	\N	2800.00	4100.00	3300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.626324	2025-07-01 04:23:36.626324
4597	7	3	2010	count	21000.00	\N	17000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.635921	2025-07-01 04:23:36.635921
4600	10	3	2010	count	5800.00	\N	5100.00	6600.00	5800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.645102	2025-07-01 04:23:36.645102
4602	12	3	2010	count	7700.00	\N	6600.00	8800.00	7700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.654941	2025-07-01 04:23:36.654941
4603	13	3	2010	count	2300.00	\N	2100.00	2600.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.664567	2025-07-01 04:23:36.664567
4604	14	3	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.676175	2025-07-01 04:23:36.676175
4606	16	3	2010	count	3700.00	\N	3400.00	4100.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.685469	2025-07-01 04:23:36.685469
4607	17	3	2010	count	61000.00	\N	41000.00	98000.00	61000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.694934	2025-07-01 04:23:36.694934
4608	18	3	2010	count	1300.00	\N	590.00	2700.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.704371	2025-07-01 04:23:36.704371
4609	19	3	2010	count	23000.00	\N	20000.00	25000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.715725	2025-07-01 04:23:36.715725
4610	20	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.726757	2025-07-01 04:23:36.726757
4611	21	3	2010	count	340000.00	\N	300000.00	360000.00	340000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.736492	2025-07-01 04:23:36.736492
4612	22	3	2010	count	670000.00	\N	520000.00	830000.00	670000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.749902	2025-07-01 04:23:36.749902
4614	24	3	2010	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.759259	2025-07-01 04:23:36.759259
4615	25	3	2010	count	110000.00	\N	88000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.769071	2025-07-01 04:23:36.769071
4616	26	3	2010	count	93000.00	\N	79000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.799078	2025-07-01 04:23:36.799078
4617	27	3	2010	count	2100.00	\N	1700.00	2600.00	2100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.807326	2025-07-01 04:23:36.807326
4618	28	3	2010	count	79000.00	\N	68000.00	93000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.818377	2025-07-01 04:23:36.818377
4619	29	3	2010	count	520000.00	\N	460000.00	560000.00	520000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.829702	2025-07-01 04:23:36.829702
4621	31	3	2010	count	140000.00	\N	110000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.851068	2025-07-01 04:23:36.851068
4622	32	3	2010	count	99000.00	\N	80000.00	120000.00	99000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.861437	2025-07-01 04:23:36.861437
4623	33	3	2010	count	39000.00	\N	34000.00	43000.00	39000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.872597	2025-07-01 04:23:36.872597
4625	35	3	2010	count	130000.00	\N	100000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.884629	2025-07-01 04:23:36.884629
4626	36	3	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.894271	2025-07-01 04:23:36.894271
4627	37	3	2010	count	82000.00	\N	69000.00	95000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.905969	2025-07-01 04:23:36.905969
4628	38	3	2010	count	9300.00	\N	8400.00	10000.00	9300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.936986	2025-07-01 04:23:36.936986
4629	39	3	2010	count	480000.00	\N	380000.00	610000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.948317	2025-07-01 04:23:36.948317
4630	40	3	2010	count	1000.00	\N	930.00	1100.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.9641	2025-07-01 04:23:36.9641
4631	41	3	2010	count	17000.00	\N	13000.00	21000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:36.974096	2025-07-01 04:23:36.974096
4633	43	3	2010	count	1800.00	\N	1500.00	2000.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.002463	2025-07-01 04:23:37.002463
4635	45	3	2010	count	480000.00	\N	400000.00	560000.00	480000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.013718	2025-07-01 04:23:37.013718
4636	46	3	2010	count	5500.00	\N	5000.00	6200.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.025141	2025-07-01 04:23:37.025141
4637	47	3	2010	count	9400.00	\N	7700.00	11000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.037091	2025-07-01 04:23:37.037091
4638	48	3	2010	count	72000.00	\N	54000.00	91000.00	72000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.048446	2025-07-01 04:23:37.048446
4639	49	3	2010	count	34000.00	\N	22000.00	57000.00	34000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.066507	2025-07-01 04:23:37.066507
4640	50	3	2010	count	6800.00	\N	6100.00	7400.00	6800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.109154	2025-07-01 04:23:37.109154
4641	51	3	2010	count	26000.00	\N	20000.00	31000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.149836	2025-07-01 04:23:37.149836
4642	52	3	2010	count	35000.00	\N	29000.00	41000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.167729	2025-07-01 04:23:37.167729
4643	53	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.18861	2025-07-01 04:23:37.18861
4644	54	3	2010	count	6000.00	\N	5100.00	6700.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.201777	2025-07-01 04:23:37.201777
4645	55	3	2010	count	160000.00	\N	150000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.248821	2025-07-01 04:23:37.248821
4646	56	3	2010	count	630000.00	\N	480000.00	830000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.266799	2025-07-01 04:23:37.266799
4648	58	3	2010	count	2700.00	\N	2200.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.286913	2025-07-01 04:23:37.286913
4649	59	3	2010	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.306882	2025-07-01 04:23:37.306882
4650	60	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.326271	2025-07-01 04:23:37.326271
4651	61	3	2010	count	18000.00	\N	15000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.346599	2025-07-01 04:23:37.346599
4652	62	3	2010	count	5600.00	\N	4500.00	6700.00	5600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.367342	2025-07-01 04:23:37.367342
4653	63	3	2010	count	69000.00	\N	57000.00	81000.00	69000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.38526	2025-07-01 04:23:37.38526
4654	64	3	2010	count	300000.00	\N	250000.00	340000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.403539	2025-07-01 04:23:37.403539
4656	66	3	2010	count	49000.00	\N	44000.00	53000.00	49000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.447513	2025-07-01 04:23:37.447513
4657	67	3	2010	count	100000.00	\N	90000.00	120000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.46477	2025-07-01 04:23:37.46477
4658	68	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.505188	2025-07-01 04:23:37.505188
4659	69	3	2010	count	6700.00	\N	6000.00	7400.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.521824	2025-07-01 04:23:37.521824
4660	70	3	2010	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.540941	2025-07-01 04:23:37.540941
4661	71	3	2010	count	26000.00	\N	21000.00	32000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.560806	2025-07-01 04:23:37.560806
4662	72	3	2010	count	2000.00	\N	1800.00	2300.00	2000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.578645	2025-07-01 04:23:37.578645
4663	73	3	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.596332	2025-07-01 04:23:37.596332
4665	75	3	2010	count	510000.00	\N	450000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.648115	2025-07-01 04:23:37.648115
4666	76	3	2010	count	50000.00	\N	37000.00	70000.00	50000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.667001	2025-07-01 04:23:37.667001
4667	77	3	2010	count	4800.00	\N	4200.00	5400.00	4800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.716974	2025-07-01 04:23:37.716974
4668	78	3	2010	count	6000.00	\N	5400.00	6800.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.73432	2025-07-01 04:23:37.73432
4669	79	3	2010	count	110000.00	\N	92000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.752928	2025-07-01 04:23:37.752928
4670	80	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.770267	2025-07-01 04:23:37.770267
4671	81	3	2010	count	19000.00	\N	16000.00	22000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.820126	2025-07-01 04:23:37.820126
4672	82	3	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.840375	2025-07-01 04:23:37.840375
4673	83	3	2010	count	11000.00	\N	10000.00	11000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.881911	2025-07-01 04:23:37.881911
4674	84	3	2010	count	1500000.00	\N	1200000.00	1800000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.899821	2025-07-01 04:23:37.899821
4675	85	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.922838	2025-07-01 04:23:37.922838
4676	86	3	2010	count	4100.00	\N	3200.00	5500.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.941726	2025-07-01 04:23:37.941726
4677	87	3	2010	count	9900.00	\N	8800.00	11000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.964683	2025-07-01 04:23:37.964683
4678	88	3	2010	count	4000.00	\N	3500.00	4500.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:37.991637	2025-07-01 04:23:37.991637
4679	89	3	2010	count	1600.00	\N	1400.00	1800.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.0074	2025-07-01 04:23:38.0074
4680	90	3	2010	count	300000.00	\N	280000.00	320000.00	300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.017494	2025-07-01 04:23:38.017494
4681	91	3	2010	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.034169	2025-07-01 04:23:38.034169
4682	92	3	2010	count	6100.00	\N	5600.00	6500.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.051825	2025-07-01 04:23:38.051825
4684	94	3	2010	count	700.00	\N	620.00	780.00	700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.072298	2025-07-01 04:23:38.072298
4685	95	3	2010	count	21000.00	\N	18000.00	24000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.089706	2025-07-01 04:23:38.089706
4686	96	3	2010	count	870000.00	\N	770000.00	960000.00	870000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.107099	2025-07-01 04:23:38.107099
4687	97	3	2010	count	74000.00	\N	65000.00	86000.00	74000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.12117	2025-07-01 04:23:38.12117
4689	99	3	2010	count	120000.00	\N	94000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.132695	2025-07-01 04:23:38.132695
4691	101	3	2010	count	7100.00	\N	5900.00	8400.00	7100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.143381	2025-07-01 04:23:38.143381
4692	102	3	2010	count	11000.00	\N	9500.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.154356	2025-07-01 04:23:38.154356
4693	103	3	2010	count	180000.00	\N	150000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.165655	2025-07-01 04:23:38.165655
4694	104	3	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.174287	2025-07-01 04:23:38.174287
4695	105	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.187718	2025-07-01 04:23:38.187718
4696	106	3	2010	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.198122	2025-07-01 04:23:38.198122
4697	107	3	2010	count	1600000.00	\N	1300000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.20896	2025-07-01 04:23:38.20896
4698	108	3	2010	count	220000.00	\N	190000.00	260000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.220959	2025-07-01 04:23:38.220959
4699	109	3	2010	count	170000.00	\N	160000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.231847	2025-07-01 04:23:38.231847
4700	110	3	2010	count	31000.00	\N	27000.00	36000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.245087	2025-07-01 04:23:38.245087
4701	111	3	2010	count	20000.00	\N	19000.00	21000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.258656	2025-07-01 04:23:38.258656
4702	112	3	2010	count	2500.00	\N	2100.00	2800.00	2500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.271315	2025-07-01 04:23:38.271315
4703	113	3	2010	count	7900.00	\N	6500.00	10000.00	7900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.281641	2025-07-01 04:23:38.281641
4704	114	3	2010	count	37000.00	\N	32000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.292428	2025-07-01 04:23:38.292428
4705	115	3	2010	count	1500000.00	\N	1100000.00	2100000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.303112	2025-07-01 04:23:38.303112
4706	116	3	2010	count	4200.00	\N	3800.00	4600.00	4200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.314937	2025-07-01 04:23:38.314937
4707	117	3	2010	count	2200.00	\N	2000.00	2500.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.325	2025-07-01 04:23:38.325
4708	118	3	2010	count	67000.00	\N	57000.00	76000.00	67000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.335788	2025-07-01 04:23:38.335788
4709	119	3	2010	count	20000.00	\N	18000.00	22000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.345149	2025-07-01 04:23:38.345149
4710	120	3	2010	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.356283	2025-07-01 04:23:38.356283
4711	121	3	2010	count	20000.00	\N	14000.00	27000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.36743	2025-07-01 04:23:38.36743
4712	122	3	2010	count	65000.00	\N	49000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.3791	2025-07-01 04:23:38.3791
4713	123	3	2010	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.390245	2025-07-01 04:23:38.390245
4715	125	3	2010	count	40000.00	\N	35000.00	45000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.401536	2025-07-01 04:23:38.401536
4718	128	3	2010	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.411811	2025-07-01 04:23:38.411811
4719	129	3	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.422837	2025-07-01 04:23:38.422837
4720	130	3	2010	count	14000.00	\N	12000.00	15000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.431358	2025-07-01 04:23:38.431358
4722	132	3	2010	count	220000.00	\N	200000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.441002	2025-07-01 04:23:38.441002
4724	134	3	2010	count	44000.00	\N	39000.00	50000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.451834	2025-07-01 04:23:38.451834
4725	135	3	2010	count	1800.00	\N	1300.00	2200.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.46289	2025-07-01 04:23:38.46289
4726	136	3	2010	count	58000.00	\N	48000.00	70000.00	58000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.472586	2025-07-01 04:23:38.472586
4727	137	3	2010	count	6500.00	\N	5700.00	7300.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.483684	2025-07-01 04:23:38.483684
4728	138	3	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.494999	2025-07-01 04:23:38.494999
4730	140	3	2010	count	17000.00	\N	15000.00	20000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.507055	2025-07-01 04:23:38.507055
4731	141	3	2010	count	6100000.00	\N	5500000.00	6600000.00	6100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.519615	2025-07-01 04:23:38.519615
4732	142	3	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.531862	2025-07-01 04:23:38.531862
4733	143	3	2010	count	140000.00	\N	120000.00	150000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.544361	2025-07-01 04:23:38.544361
4734	144	3	2010	count	4000.00	\N	3400.00	4700.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.554653	2025-07-01 04:23:38.554653
4735	145	3	2010	count	43000.00	\N	36000.00	51000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.565695	2025-07-01 04:23:38.565695
4736	146	3	2010	count	4600.00	\N	3300.00	6200.00	4600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.584793	2025-07-01 04:23:38.584793
4739	149	3	2010	count	570.00	\N	510.00	630.00	570.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.595839	2025-07-01 04:23:38.595839
4740	150	3	2010	count	9200.00	\N	7500.00	11000.00	9200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.606535	2025-07-01 04:23:38.606535
4741	151	3	2010	count	580000.00	\N	490000.00	690000.00	580000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.616703	2025-07-01 04:23:38.616703
4743	153	3	2010	count	100000.00	\N	96000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.626623	2025-07-01 04:23:38.626623
4745	155	3	2010	count	1400.00	\N	980.00	2200.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.638322	2025-07-01 04:23:38.638322
4748	158	3	2010	count	1200000.00	\N	1100000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.64859	2025-07-01 04:23:38.64859
4749	159	3	2010	count	230000.00	\N	220000.00	250000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.665441	2025-07-01 04:23:38.665441
4752	162	3	2010	count	1300000.00	\N	1100000.00	1400000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.675241	2025-07-01 04:23:38.675241
4753	163	3	2010	count	990000.00	\N	880000.00	1100000.00	990000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.68607	2025-07-01 04:23:38.68607
4754	164	3	2010	count	9600.00	\N	8000.00	11000.00	9600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.70148	2025-07-01 04:23:38.70148
4755	165	3	2010	count	30000.00	\N	27000.00	32000.00	30000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.71339	2025-07-01 04:23:38.71339
4757	167	3	2010	count	220000.00	\N	180000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.728102	2025-07-01 04:23:38.728102
4758	168	3	2010	count	5100.00	\N	3500.00	7400.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.739495	2025-07-01 04:23:38.739495
4759	169	3	2010	count	1000000.00	\N	900000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.761886	2025-07-01 04:23:38.761886
4760	170	3	2010	count	1200000.00	\N	1100000.00	1400000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.775498	2025-07-01 04:23:38.775498
4761	1	3	2005	count	2900.00	\N	1700.00	5000.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.798937	2025-07-01 04:23:38.798937
4763	3	3	2005	count	3700.00	\N	3500.00	4000.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.815039	2025-07-01 04:23:38.815039
4764	4	3	2005	count	150000.00	\N	120000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.82499	2025-07-01 04:23:38.82499
4765	5	3	2005	count	85000.00	\N	76000.00	94000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.8401	2025-07-01 04:23:38.8401
4766	6	3	2005	count	2700.00	\N	2000.00	3500.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.869934	2025-07-01 04:23:38.869934
4767	7	3	2005	count	16000.00	\N	14000.00	19000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.886104	2025-07-01 04:23:38.886104
4770	10	3	2005	count	5100.00	\N	4400.00	6000.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.897223	2025-07-01 04:23:38.897223
4772	12	3	2005	count	4000.00	\N	3500.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.913296	2025-07-01 04:23:38.913296
4773	13	3	2005	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.933342	2025-07-01 04:23:38.933342
4774	14	3	2005	count	5400.00	\N	4500.00	6700.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.946356	2025-07-01 04:23:38.946356
4776	16	3	2005	count	2800.00	\N	2600.00	3100.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.956408	2025-07-01 04:23:38.956408
4777	17	3	2005	count	56000.00	\N	37000.00	90000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.96724	2025-07-01 04:23:38.96724
4778	18	3	2005	count	1100.00	\N	500.00	2000.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:38.991181	2025-07-01 04:23:38.991181
4779	19	3	2005	count	26000.00	\N	24000.00	28000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.019443	2025-07-01 04:23:39.019443
4780	20	3	2005	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.031753	2025-07-01 04:23:39.031753
4781	21	3	2005	count	310000.00	\N	280000.00	330000.00	310000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.042371	2025-07-01 04:23:39.042371
4782	22	3	2005	count	550000.00	\N	420000.00	680000.00	550000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.053424	2025-07-01 04:23:39.053424
4784	24	3	2005	count	980.00	\N	910.00	1100.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.065063	2025-07-01 04:23:39.065063
4785	25	3	2005	count	120000.00	\N	95000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.07539	2025-07-01 04:23:39.07539
4786	26	3	2005	count	110000.00	\N	88000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.086229	2025-07-01 04:23:39.086229
4787	27	3	2005	count	1800.00	\N	1400.00	2700.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.096779	2025-07-01 04:23:39.096779
4788	28	3	2005	count	82000.00	\N	70000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.108509	2025-07-01 04:23:39.108509
4789	29	3	2005	count	470000.00	\N	430000.00	500000.00	470000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.124689	2025-07-01 04:23:39.124689
4791	31	3	2005	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.142927	2025-07-01 04:23:39.142927
4792	32	3	2005	count	88000.00	\N	69000.00	110000.00	88000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.161767	2025-07-01 04:23:39.161767
4793	33	3	2005	count	25000.00	\N	22000.00	27000.00	25000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.181357	2025-07-01 04:23:39.181357
4795	35	3	2005	count	120000.00	\N	98000.00	140000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.201068	2025-07-01 04:23:39.201068
4796	36	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.218118	2025-07-01 04:23:39.218118
4797	37	3	2005	count	77000.00	\N	63000.00	90000.00	77000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.238125	2025-07-01 04:23:39.238125
4798	38	3	2005	count	6500.00	\N	5800.00	7200.00	6500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.252871	2025-07-01 04:23:39.252871
4799	39	3	2005	count	510000.00	\N	410000.00	650000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.270645	2025-07-01 04:23:39.270645
4800	40	3	2005	count	710.00	\N	630.00	800.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.286012	2025-07-01 04:23:39.286012
4801	41	3	2005	count	9000.00	\N	6700.00	11000.00	9000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.311284	2025-07-01 04:23:39.311284
4803	43	3	2005	count	970.00	\N	820.00	1100.00	970.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.351407	2025-07-01 04:23:39.351407
4805	45	3	2005	count	510000.00	\N	430000.00	590000.00	510000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.382037	2025-07-01 04:23:39.382037
4806	46	3	2005	count	4900.00	\N	4500.00	5500.00	4900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.412907	2025-07-01 04:23:39.412907
4807	47	3	2005	count	11000.00	\N	9000.00	13000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.455865	2025-07-01 04:23:39.455865
4808	48	3	2005	count	79000.00	\N	61000.00	100000.00	79000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.49565	2025-07-01 04:23:39.49565
4809	49	3	2005	count	29000.00	\N	19000.00	49000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.523483	2025-07-01 04:23:39.523483
4810	50	3	2005	count	3200.00	\N	2800.00	3500.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.539362	2025-07-01 04:23:39.539362
4811	51	3	2005	count	23000.00	\N	17000.00	28000.00	23000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.562543	2025-07-01 04:23:39.562543
4812	52	3	2005	count	22000.00	\N	17000.00	28000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.591863	2025-07-01 04:23:39.591863
4813	53	3	2005	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.613412	2025-07-01 04:23:39.613412
4814	54	3	2005	count	5400.00	\N	4600.00	6000.00	5400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.63465	2025-07-01 04:23:39.63465
4815	55	3	2005	count	130000.00	\N	120000.00	140000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.646853	2025-07-01 04:23:39.646853
4816	56	3	2005	count	640000.00	\N	490000.00	840000.00	640000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.666307	2025-07-01 04:23:39.666307
4818	58	3	2005	count	1900.00	\N	1500.00	2400.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.6757	2025-07-01 04:23:39.6757
4819	59	3	2005	count	110000.00	\N	95000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.702804	2025-07-01 04:23:39.702804
4820	60	3	2005	count	35000.00	\N	27000.00	43000.00	35000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.718557	2025-07-01 04:23:39.718557
4821	61	3	2005	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.732187	2025-07-01 04:23:39.732187
4822	62	3	2005	count	2800.00	\N	2300.00	3400.00	2800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.741645	2025-07-01 04:23:39.741645
4823	63	3	2005	count	56000.00	\N	46000.00	65000.00	56000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.753118	2025-07-01 04:23:39.753118
4824	64	3	2005	count	280000.00	\N	240000.00	320000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.765125	2025-07-01 04:23:39.765125
4826	66	3	2005	count	48000.00	\N	44000.00	51000.00	48000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.775635	2025-07-01 04:23:39.775635
4827	67	3	2005	count	93000.00	\N	81000.00	110000.00	93000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.80384	2025-07-01 04:23:39.80384
4828	68	3	2005	count	31000.00	\N	28000.00	35000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.818179	2025-07-01 04:23:39.818179
4829	69	3	2005	count	5000.00	\N	4400.00	5700.00	5000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.830246	2025-07-01 04:23:39.830246
4830	70	3	2005	count	140000.00	\N	120000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.839813	2025-07-01 04:23:39.839813
4831	71	3	2005	count	31000.00	\N	24000.00	38000.00	31000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.850534	2025-07-01 04:23:39.850534
4832	72	3	2005	count	1200.00	\N	1000.00	1300.00	1200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.861344	2025-07-01 04:23:39.861344
4833	73	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.871887	2025-07-01 04:23:39.871887
4835	75	3	2005	count	290000.00	\N	260000.00	330000.00	290000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.889614	2025-07-01 04:23:39.889614
4836	76	3	2005	count	37000.00	\N	25000.00	56000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.902427	2025-07-01 04:23:39.902427
4837	77	3	2005	count	3200.00	\N	2800.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.912958	2025-07-01 04:23:39.912958
4838	78	3	2005	count	4100.00	\N	3700.00	4600.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.922992	2025-07-01 04:23:39.922992
4839	79	3	2005	count	89000.00	\N	76000.00	100000.00	89000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.934008	2025-07-01 04:23:39.934008
4840	80	3	2005	count	38000.00	\N	33000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.945222	2025-07-01 04:23:39.945222
4841	81	3	2005	count	12000.00	\N	9700.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.957968	2025-07-01 04:23:39.957968
4842	82	3	2005	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.972342	2025-07-01 04:23:39.972342
4843	83	3	2005	count	4000.00	\N	3800.00	4300.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.985677	2025-07-01 04:23:39.985677
4844	84	3	2005	count	1500000.00	\N	1300000.00	1900000.00	1500000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:39.997013	2025-07-01 04:23:39.997013
4845	85	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.01297	2025-07-01 04:23:40.01297
4846	86	3	2005	count	1500.00	\N	1300.00	1900.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.025041	2025-07-01 04:23:40.025041
4847	87	3	2005	count	6700.00	\N	6000.00	7500.00	6700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.037232	2025-07-01 04:23:40.037232
4848	88	3	2005	count	3200.00	\N	2900.00	3600.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.048573	2025-07-01 04:23:40.048573
4849	89	3	2005	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.058684	2025-07-01 04:23:40.058684
4850	90	3	2005	count	280000.00	\N	260000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.068884	2025-07-01 04:23:40.068884
4851	91	3	2005	count	41000.00	\N	38000.00	45000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.079572	2025-07-01 04:23:40.079572
4852	92	3	2005	count	2900.00	\N	2700.00	3100.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.091103	2025-07-01 04:23:40.091103
4854	94	3	2005	count	500.00	\N	500.00	540.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.102192	2025-07-01 04:23:40.102192
4855	95	3	2005	count	19000.00	\N	15000.00	23000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.112349	2025-07-01 04:23:40.112349
4856	96	3	2005	count	820000.00	\N	720000.00	900000.00	820000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.126029	2025-07-01 04:23:40.126029
4857	97	3	2005	count	66000.00	\N	57000.00	77000.00	66000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.154427	2025-07-01 04:23:40.154427
4859	99	3	2005	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.1654	2025-07-01 04:23:40.1654
4861	101	3	2005	count	7500.00	\N	6400.00	8800.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.177391	2025-07-01 04:23:40.177391
4862	102	3	2005	count	8000.00	\N	6100.00	11000.00	8000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.186905	2025-07-01 04:23:40.186905
4863	103	3	2005	count	150000.00	\N	120000.00	200000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.196705	2025-07-01 04:23:40.196705
4864	104	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.2062	2025-07-01 04:23:40.2062
4865	105	3	2005	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.217648	2025-07-01 04:23:40.217648
4866	106	3	2005	count	13000.00	\N	11000.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.22781	2025-07-01 04:23:40.22781
4867	107	3	2005	count	1200000.00	\N	980000.00	1500000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.238117	2025-07-01 04:23:40.238117
4868	108	3	2005	count	210000.00	\N	180000.00	240000.00	210000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.247631	2025-07-01 04:23:40.247631
4869	109	3	2005	count	160000.00	\N	140000.00	170000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.258572	2025-07-01 04:23:40.258572
4870	110	3	2005	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.276122	2025-07-01 04:23:40.276122
4871	111	3	2005	count	16000.00	\N	15000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.285158	2025-07-01 04:23:40.285158
4872	112	3	2005	count	1800.00	\N	1600.00	2100.00	1800.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.294181	2025-07-01 04:23:40.294181
4873	113	3	2005	count	6100.00	\N	4600.00	8300.00	6100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.323976	2025-07-01 04:23:40.323976
4874	114	3	2005	count	40000.00	\N	34000.00	46000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.336225	2025-07-01 04:23:40.336225
4875	115	3	2005	count	1400000.00	\N	1000000.00	1900000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.345099	2025-07-01 04:23:40.345099
4876	116	3	2005	count	3000.00	\N	2700.00	3300.00	3000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.358341	2025-07-01 04:23:40.358341
4877	117	3	2005	count	1700.00	\N	1600.00	1900.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.369698	2025-07-01 04:23:40.369698
4878	118	3	2005	count	12000.00	\N	10000.00	14000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.381895	2025-07-01 04:23:40.381895
4879	119	3	2005	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.391815	2025-07-01 04:23:40.391815
4880	120	3	2005	count	38000.00	\N	34000.00	42000.00	38000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.403919	2025-07-01 04:23:40.403919
4881	121	3	2005	count	19000.00	\N	14000.00	25000.00	19000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.417416	2025-07-01 04:23:40.417416
4882	122	3	2005	count	65000.00	\N	50000.00	91000.00	65000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.427982	2025-07-01 04:23:40.427982
4883	123	3	2005	count	3700.00	\N	3100.00	4300.00	3700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.485111	2025-07-01 04:23:40.485111
4885	125	3	2005	count	37000.00	\N	33000.00	42000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.495745	2025-07-01 04:23:40.495745
4888	128	3	2005	count	12000.00	\N	9600.00	16000.00	12000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.505922	2025-07-01 04:23:40.505922
4889	129	3	2005	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.517273	2025-07-01 04:23:40.517273
4890	130	3	2005	count	11000.00	\N	9800.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.526375	2025-07-01 04:23:40.526375
4892	132	3	2005	count	220000.00	\N	190000.00	250000.00	220000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.536445	2025-07-01 04:23:40.536445
4894	134	3	2005	count	42000.00	\N	38000.00	48000.00	42000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.546705	2025-07-01 04:23:40.546705
4895	135	3	2005	count	1100.00	\N	750.00	1500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.556345	2025-07-01 04:23:40.556345
4896	136	3	2005	count	51000.00	\N	42000.00	61000.00	51000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.568166	2025-07-01 04:23:40.568166
4897	137	3	2005	count	4100.00	\N	3500.00	4700.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.580532	2025-07-01 04:23:40.580532
4898	138	3	2005	count	500.00	\N	200.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.612122	2025-07-01 04:23:40.612122
4900	140	3	2005	count	20000.00	\N	18000.00	23000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.623659	2025-07-01 04:23:40.623659
4901	141	3	2005	count	5000000.00	\N	4400000.00	5400000.00	5000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.63501	2025-07-01 04:23:40.63501
4902	142	3	2005	count	120000.00	\N	89000.00	150000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.645197	2025-07-01 04:23:40.645197
4903	143	3	2005	count	120000.00	\N	100000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.65744	2025-07-01 04:23:40.65744
4904	144	3	2005	count	3600.00	\N	3100.00	4100.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.667069	2025-07-01 04:23:40.667069
4905	145	3	2005	count	29000.00	\N	20000.00	40000.00	29000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.681867	2025-07-01 04:23:40.681867
4906	146	3	2005	count	4000.00	\N	3000.00	5600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.692459	2025-07-01 04:23:40.692459
4909	149	3	2005	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.70608	2025-07-01 04:23:40.70608
4910	150	3	2005	count	5200.00	\N	3700.00	6900.00	5200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.717208	2025-07-01 04:23:40.717208
4911	151	3	2005	count	630000.00	\N	510000.00	780000.00	630000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.732338	2025-07-01 04:23:40.732338
4913	153	3	2005	count	100000.00	\N	94000.00	110000.00	100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.745111	2025-07-01 04:23:40.745111
4915	155	3	2005	count	640.00	\N	500.00	1100.00	640.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.757258	2025-07-01 04:23:40.757258
4918	158	3	2005	count	1100000.00	\N	1000000.00	1100000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.76741	2025-07-01 04:23:40.76741
4919	159	3	2005	count	230000.00	\N	220000.00	240000.00	230000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.776821	2025-07-01 04:23:40.776821
4922	162	3	2005	count	1200000.00	\N	1000000.00	1300000.00	1200000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.788278	2025-07-01 04:23:40.788278
4924	164	3	2005	count	7600.00	\N	6200.00	10000.00	7600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.798742	2025-07-01 04:23:40.798742
4925	165	3	2005	count	21000.00	\N	19000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.808649	2025-07-01 04:23:40.808649
4927	167	3	2005	count	180000.00	\N	160000.00	210000.00	180000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.81887	2025-07-01 04:23:40.81887
4928	168	3	2005	count	2400.00	\N	1500.00	4000.00	2400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.828288	2025-07-01 04:23:40.828288
4929	169	3	2005	count	920000.00	\N	820000.00	1000000.00	920000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.844113	2025-07-01 04:23:40.844113
4930	170	3	2005	count	1400000.00	\N	1200000.00	1600000.00	1400000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.855874	2025-07-01 04:23:40.855874
4931	1	3	2000	count	1600.00	\N	1000.00	3500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.867048	2025-07-01 04:23:40.867048
4933	3	3	2000	count	1900.00	\N	1700.00	2000.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.878654	2025-07-01 04:23:40.878654
4934	4	3	2000	count	87000.00	\N	72000.00	110000.00	87000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.888159	2025-07-01 04:23:40.888159
4935	5	3	2000	count	64000.00	\N	55000.00	71000.00	64000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.899806	2025-07-01 04:23:40.899806
4936	6	3	2000	count	950.00	\N	580.00	1600.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.912068	2025-07-01 04:23:40.912068
4937	7	3	2000	count	13000.00	\N	11000.00	15000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.922318	2025-07-01 04:23:40.922318
4940	10	3	2000	count	5100.00	\N	4400.00	5900.00	5100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.933164	2025-07-01 04:23:40.933164
4942	12	3	2000	count	940.00	\N	800.00	1100.00	940.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.945049	2025-07-01 04:23:40.945049
4943	13	3	2000	count	1100.00	\N	1000.00	1300.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.956136	2025-07-01 04:23:40.956136
4944	14	3	2000	count	1400.00	\N	1100.00	1900.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.965604	2025-07-01 04:23:40.965604
4946	16	3	2000	count	1700.00	\N	1600.00	1800.00	1700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.976562	2025-07-01 04:23:40.976562
4947	17	3	2000	count	47000.00	\N	31000.00	75000.00	47000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.987305	2025-07-01 04:23:40.987305
4948	18	3	2000	count	530.00	\N	200.00	970.00	530.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:40.997724	2025-07-01 04:23:40.997724
4949	19	3	2000	count	21000.00	\N	20000.00	23000.00	21000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.007922	2025-07-01 04:23:41.007922
4950	20	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.017888	2025-07-01 04:23:41.017888
4951	21	3	2000	count	280000.00	\N	270000.00	300000.00	280000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.059501	2025-07-01 04:23:41.059501
4952	22	3	2000	count	410000.00	\N	320000.00	510000.00	410000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.101527	2025-07-01 04:23:41.101527
4954	24	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.117724	2025-07-01 04:23:41.117724
4955	25	3	2000	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.136686	2025-07-01 04:23:41.136686
4956	26	3	2000	count	130000.00	\N	110000.00	150000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.154879	2025-07-01 04:23:41.154879
4957	27	3	2000	count	1600.00	\N	1200.00	2500.00	1600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.196082	2025-07-01 04:23:41.196082
4958	28	3	2000	count	81000.00	\N	73000.00	91000.00	81000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.215131	2025-07-01 04:23:41.215131
4959	29	3	2000	count	370000.00	\N	350000.00	410000.00	370000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.258751	2025-07-01 04:23:41.258751
4961	31	3	2000	count	160000.00	\N	130000.00	190000.00	160000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.275896	2025-07-01 04:23:41.275896
4962	32	3	2000	count	80000.00	\N	60000.00	100000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.294248	2025-07-01 04:23:41.294248
4963	33	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.322907	2025-07-01 04:23:41.322907
4965	35	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.354594	2025-07-01 04:23:41.354594
4966	36	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.400997	2025-07-01 04:23:41.400997
4967	37	3	2000	count	80000.00	\N	64000.00	96000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.468708	2025-07-01 04:23:41.468708
4968	38	3	2000	count	4300.00	\N	3700.00	4700.00	4300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.501164	2025-07-01 04:23:41.501164
4969	39	3	2000	count	590000.00	\N	470000.00	740000.00	590000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.518957	2025-07-01 04:23:41.518957
4970	40	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.550593	2025-07-01 04:23:41.550593
4971	41	3	2000	count	4100.00	\N	2900.00	5000.00	4100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.577379	2025-07-01 04:23:41.577379
4973	43	3	2000	count	510.00	\N	500.00	580.00	510.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.59415	2025-07-01 04:23:41.59415
4975	45	3	2000	count	540000.00	\N	470000.00	610000.00	540000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.616858	2025-07-01 04:23:41.616858
4976	46	3	2000	count	4000.00	\N	3600.00	4600.00	4000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.634877	2025-07-01 04:23:41.634877
4977	47	3	2000	count	9400.00	\N	7200.00	12000.00	9400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.653068	2025-07-01 04:23:41.653068
4978	48	3	2000	count	85000.00	\N	62000.00	120000.00	85000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.677413	2025-07-01 04:23:41.677413
4979	49	3	2000	count	26000.00	\N	15000.00	46000.00	26000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.719455	2025-07-01 04:23:41.719455
4980	50	3	2000	count	1500.00	\N	1400.00	1600.00	1500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.738241	2025-07-01 04:23:41.738241
4981	51	3	2000	count	18000.00	\N	14000.00	23000.00	18000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.75553	2025-07-01 04:23:41.75553
4982	52	3	2000	count	13000.00	\N	9200.00	18000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.772543	2025-07-01 04:23:41.772543
4983	53	3	2000	count	16000.00	\N	12000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.797989	2025-07-01 04:23:41.797989
4984	54	3	2000	count	3400.00	\N	2900.00	3900.00	3400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.815965	2025-07-01 04:23:41.815965
4985	55	3	2000	count	110000.00	\N	98000.00	120000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.836392	2025-07-01 04:23:41.836392
4986	56	3	2000	count	750000.00	\N	570000.00	980000.00	750000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.854719	2025-07-01 04:23:41.854719
4988	58	3	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.874003	2025-07-01 04:23:41.874003
4989	59	3	2000	count	82000.00	\N	69000.00	97000.00	82000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.890548	2025-07-01 04:23:41.890548
4990	60	3	2000	count	28000.00	\N	20000.00	38000.00	28000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.912188	2025-07-01 04:23:41.912188
4991	61	3	2000	count	9900.00	\N	7200.00	13000.00	9900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.926911	2025-07-01 04:23:41.926911
4992	62	3	2000	count	980.00	\N	720.00	1300.00	980.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.952734	2025-07-01 04:23:41.952734
4993	63	3	2000	count	45000.00	\N	37000.00	54000.00	45000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.977674	2025-07-01 04:23:41.977674
4994	64	3	2000	count	270000.00	\N	240000.00	300000.00	270000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:41.992518	2025-07-01 04:23:41.992518
4996	66	3	2000	count	44000.00	\N	41000.00	47000.00	44000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.010194	2025-07-01 04:23:42.010194
4997	67	3	2000	count	83000.00	\N	67000.00	100000.00	83000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.023445	2025-07-01 04:23:42.023445
4998	68	3	2000	count	22000.00	\N	20000.00	25000.00	22000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.041004	2025-07-01 04:23:42.041004
4999	69	3	2000	count	2300.00	\N	1600.00	3100.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.057177	2025-07-01 04:23:42.057177
5000	70	3	2000	count	150000.00	\N	130000.00	180000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.087764	2025-07-01 04:23:42.087764
5001	71	3	2000	count	40000.00	\N	34000.00	49000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.107436	2025-07-01 04:23:42.107436
5002	72	3	2000	count	830.00	\N	700.00	950.00	830.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.139911	2025-07-01 04:23:42.139911
5003	73	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.160781	2025-07-01 04:23:42.160781
5005	75	3	2000	count	80000.00	\N	72000.00	89000.00	80000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.177209	2025-07-01 04:23:42.177209
5006	76	3	2000	count	16000.00	\N	7900.00	35000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.194363	2025-07-01 04:23:42.194363
5007	77	3	2000	count	1900.00	\N	1700.00	2200.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.227205	2025-07-01 04:23:42.227205
5008	78	3	2000	count	2700.00	\N	2400.00	3100.00	2700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.24305	2025-07-01 04:23:42.24305
5009	79	3	2000	count	68000.00	\N	57000.00	78000.00	68000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.259977	2025-07-01 04:23:42.259977
5010	80	3	2000	count	41000.00	\N	37000.00	46000.00	41000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.287832	2025-07-01 04:23:42.287832
5011	81	3	2000	count	6200.00	\N	5100.00	7200.00	6200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.304013	2025-07-01 04:23:42.304013
5012	82	3	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.323951	2025-07-01 04:23:42.323951
5013	83	3	2000	count	1100.00	\N	1100.00	1200.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.353527	2025-07-01 04:23:42.353527
5014	84	3	2000	count	1700000.00	\N	1400000.00	2000000.00	1700000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.36447	2025-07-01 04:23:42.36447
5015	85	3	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.377376	2025-07-01 04:23:42.377376
5016	86	3	2000	count	710.00	\N	580.00	840.00	710.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.388333	2025-07-01 04:23:42.388333
5017	87	3	2000	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.397469	2025-07-01 04:23:42.397469
5018	88	3	2000	count	2300.00	\N	2200.00	2500.00	2300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.406893	2025-07-01 04:23:42.406893
5019	89	3	2000	count	910.00	\N	790.00	1000.00	910.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.417254	2025-07-01 04:23:42.417254
5020	90	3	2000	count	260000.00	\N	240000.00	290000.00	260000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.430378	2025-07-01 04:23:42.430378
5021	91	3	2000	count	43000.00	\N	41000.00	45000.00	43000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.447964	2025-07-01 04:23:42.447964
5022	92	3	2000	count	950.00	\N	870.00	1000.00	950.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.460745	2025-07-01 04:23:42.460745
5024	94	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.501529	2025-07-01 04:23:42.501529
5025	95	3	2000	count	13000.00	\N	7900.00	20000.00	13000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.542872	2025-07-01 04:23:42.542872
5026	96	3	2000	count	810000.00	\N	740000.00	860000.00	810000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.56813	2025-07-01 04:23:42.56813
5027	97	3	2000	count	55000.00	\N	48000.00	65000.00	55000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.578229	2025-07-01 04:23:42.578229
5029	99	3	2000	count	110000.00	\N	91000.00	130000.00	110000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.588794	2025-07-01 04:23:42.588794
5031	101	3	2000	count	5500.00	\N	4500.00	6500.00	5500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.598854	2025-07-01 04:23:42.598854
5032	102	3	2000	count	3200.00	\N	1500.00	6000.00	3200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.608761	2025-07-01 04:23:42.608761
5033	103	3	2000	count	130000.00	\N	94000.00	190000.00	130000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.618167	2025-07-01 04:23:42.618167
5034	104	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.628064	2025-07-01 04:23:42.628064
5035	105	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.669544	2025-07-01 04:23:42.669544
5036	106	3	2000	count	9700.00	\N	7800.00	13000.00	9700.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.679601	2025-07-01 04:23:42.679601
5037	107	3	2000	count	840000.00	\N	670000.00	1000000.00	840000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.689632	2025-07-01 04:23:42.689632
5038	108	3	2000	count	150000.00	\N	130000.00	170000.00	150000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.730777	2025-07-01 04:23:42.730777
5039	109	3	2000	count	140000.00	\N	130000.00	160000.00	140000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.742167	2025-07-01 04:23:42.742167
5040	110	3	2000	count	16000.00	\N	14000.00	17000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.754642	2025-07-01 04:23:42.754642
5041	111	3	2000	count	11000.00	\N	11000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.767389	2025-07-01 04:23:42.767389
5042	112	3	2000	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.777119	2025-07-01 04:23:42.777119
5043	113	3	2000	count	3600.00	\N	2100.00	5300.00	3600.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.788552	2025-07-01 04:23:42.788552
5044	114	3	2000	count	37000.00	\N	31000.00	44000.00	37000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.798398	2025-07-01 04:23:42.798398
5045	115	3	2000	count	1300000.00	\N	940000.00	1700000.00	1300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.839474	2025-07-01 04:23:42.839474
5046	116	3	2000	count	1900.00	\N	1700.00	2100.00	1900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.860245	2025-07-01 04:23:42.860245
5047	117	3	2000	count	1300.00	\N	1100.00	1400.00	1300.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.908641	2025-07-01 04:23:42.908641
5048	118	3	2000	count	500.00	\N	500.00	520.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.923388	2025-07-01 04:23:42.923388
5049	119	3	2000	count	11000.00	\N	10000.00	12000.00	11000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.937816	2025-07-01 04:23:42.937816
5050	120	3	2000	count	20000.00	\N	17000.00	25000.00	20000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.954249	2025-07-01 04:23:42.954249
5051	121	3	2000	count	14000.00	\N	7100.00	21000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.979869	2025-07-01 04:23:42.979869
5052	122	3	2000	count	71000.00	\N	56000.00	94000.00	71000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:42.996147	2025-07-01 04:23:42.996147
5053	123	3	2000	count	1000.00	\N	910.00	1200.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.00914	2025-07-01 04:23:43.00914
5055	125	3	2000	count	32000.00	\N	27000.00	37000.00	32000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.022042	2025-07-01 04:23:43.022042
5058	128	3	2000	count	10000.00	\N	8000.00	13000.00	10000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.035896	2025-07-01 04:23:43.035896
5059	129	3	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.049573	2025-07-01 04:23:43.049573
5060	130	3	2000	count	7500.00	\N	6900.00	8100.00	7500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.062089	2025-07-01 04:23:43.062089
5062	132	3	2000	count	240000.00	\N	220000.00	280000.00	240000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.077911	2025-07-01 04:23:43.077911
5064	134	3	2000	count	33000.00	\N	29000.00	39000.00	33000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.092489	2025-07-01 04:23:43.092489
5065	135	3	2000	count	1000.00	\N	660.00	1400.00	1000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.109656	2025-07-01 04:23:43.109656
5066	136	3	2000	count	40000.00	\N	31000.00	50000.00	40000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.122826	2025-07-01 04:23:43.122826
5067	137	3	2000	count	2900.00	\N	2600.00	3300.00	2900.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.137206	2025-07-01 04:23:43.137206
5068	138	3	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.15402	2025-07-01 04:23:43.15402
5070	140	3	2000	count	16000.00	\N	14000.00	20000.00	16000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.174031	2025-07-01 04:23:43.174031
5071	141	3	2000	count	3300000.00	\N	2900000.00	3700000.00	3300000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.193202	2025-07-01 04:23:43.193202
5072	142	3	2000	count	90000.00	\N	56000.00	120000.00	90000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.206991	2025-07-01 04:23:43.206991
5073	143	3	2000	count	92000.00	\N	78000.00	110000.00	92000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.22103	2025-07-01 04:23:43.22103
5074	144	3	2000	count	2200.00	\N	1900.00	2400.00	2200.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.232917	2025-07-01 04:23:43.232917
5075	145	3	2000	count	15000.00	\N	7500.00	29000.00	15000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.246771	2025-07-01 04:23:43.246771
5076	146	3	2000	count	3100.00	\N	2300.00	4400.00	3100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.261525	2025-07-01 04:23:43.261525
5079	149	3	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.281171	2025-07-01 04:23:43.281171
5080	150	3	2000	count	1400.00	\N	780.00	2700.00	1400.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.296443	2025-07-01 04:23:43.296443
5081	151	3	2000	count	740000.00	\N	610000.00	890000.00	740000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.315727	2025-07-01 04:23:43.315727
5083	153	3	2000	count	94000.00	\N	87000.00	100000.00	94000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.337896	2025-07-01 04:23:43.337896
5085	155	3	2000	count	500.00	\N	200.00	710.00	500.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.347212	2025-07-01 04:23:43.347212
5088	158	3	2000	count	1000000.00	\N	930000.00	1100000.00	1000000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.356417	2025-07-01 04:23:43.356417
5089	159	3	2000	count	170000.00	\N	150000.00	180000.00	170000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.368319	2025-07-01 04:23:43.368319
5092	162	3	2000	count	1100000.00	\N	1000000.00	1200000.00	1100000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.37885	2025-07-01 04:23:43.37885
5094	164	3	2000	count	6000.00	\N	4200.00	12000.00	6000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.388436	2025-07-01 04:23:43.388436
5095	165	3	2000	count	14000.00	\N	13000.00	16000.00	14000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.399803	2025-07-01 04:23:43.399803
5097	167	3	2000	count	120000.00	\N	110000.00	130000.00	120000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.409914	2025-07-01 04:23:43.409914
5098	168	3	2000	count	1100.00	\N	680.00	2500.00	1100.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.419283	2025-07-01 04:23:43.419283
5099	169	3	2000	count	890000.00	\N	800000.00	1000000.00	890000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.43143	2025-07-01 04:23:43.43143
5100	170	3	2000	count	1600000.00	\N	1400000.00	1900000.00	1600000.00	good	no_of_people_living_with_hiv_by_country_clean.csv	\N	2025-07-01 04:23:43.443049	2025-07-01 04:23:43.443049
5101	1	4	2018	count	500.00	\N	200.00	610.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.452026	2025-07-01 04:23:43.452026
5103	3	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.465679	2025-07-01 04:23:43.465679
5104	4	4	2018	count	14000.00	\N	9500.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.476294	2025-07-01 04:23:43.476294
5105	5	4	2018	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.485898	2025-07-01 04:23:43.485898
5106	6	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.494554	2025-07-01 04:23:43.494554
5107	7	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.504889	2025-07-01 04:23:43.504889
5110	10	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.515462	2025-07-01 04:23:43.515462
5112	12	4	2018	count	580.00	\N	500.00	680.00	580.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.526379	2025-07-01 04:23:43.526379
5113	13	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.569897	2025-07-01 04:23:43.569897
5114	14	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.581172	2025-07-01 04:23:43.581172
5116	16	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.621144	2025-07-01 04:23:43.621144
5117	17	4	2018	count	2200.00	\N	1100.00	4400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.652106	2025-07-01 04:23:43.652106
5118	18	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.666351	2025-07-01 04:23:43.666351
5119	19	4	2018	count	670.00	\N	550.00	760.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.675831	2025-07-01 04:23:43.675831
5120	20	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.692955	2025-07-01 04:23:43.692955
5121	21	4	2018	count	4800.00	\N	4100.00	5700.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:43.700621	2025-07-01 04:23:43.700621
5122	22	4	2018	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:44.246826	2025-07-01 04:23:44.246826
5124	24	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:44.35859	2025-07-01 04:23:44.35859
5125	25	4	2018	count	3300.00	\N	2400.00	4400.00	3300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:44.569364	2025-07-01 04:23:44.569364
5126	26	4	2018	count	1900.00	\N	1400.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:44.666316	2025-07-01 04:23:44.666316
5127	27	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:44.889211	2025-07-01 04:23:44.889211
5128	28	4	2018	count	1300.00	\N	920.00	1900.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.125097	2025-07-01 04:23:45.125097
5129	29	4	2018	count	18000.00	\N	15000.00	21000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.251799	2025-07-01 04:23:45.251799
5131	31	4	2018	count	4800.00	\N	3700.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.264975	2025-07-01 04:23:45.264975
5132	32	4	2018	count	3100.00	\N	2000.00	4500.00	3100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.273015	2025-07-01 04:23:45.273015
5133	33	4	2018	count	590.00	\N	500.00	770.00	590.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.284002	2025-07-01 04:23:45.284002
5136	36	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.294743	2025-07-01 04:23:45.294743
5137	37	4	2018	count	4000.00	\N	2800.00	5400.00	4000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.303665	2025-07-01 04:23:45.303665
5138	38	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.311161	2025-07-01 04:23:45.311161
5139	39	4	2018	count	16000.00	\N	11000.00	23000.00	16000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.321238	2025-07-01 04:23:45.321238
5140	40	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.32871	2025-07-01 04:23:45.32871
5141	41	4	2018	count	500.00	\N	500.00	580.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.366654	2025-07-01 04:23:45.366654
5143	43	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.377348	2025-07-01 04:23:45.377348
5145	45	4	2018	count	13000.00	\N	10000.00	17000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.386785	2025-07-01 04:23:45.386785
5146	46	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.43073	2025-07-01 04:23:45.43073
5147	47	4	2018	count	500.00	\N	500.00	550.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.440952	2025-07-01 04:23:45.440952
5148	48	4	2018	count	1200.00	\N	750.00	1900.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.448696	2025-07-01 04:23:45.448696
5149	49	4	2018	count	620.00	\N	500.00	1500.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.4568	2025-07-01 04:23:45.4568
5150	50	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.463875	2025-07-01 04:23:45.463875
5151	51	4	2018	count	700.00	\N	500.00	1000.00	700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.472372	2025-07-01 04:23:45.472372
5152	52	4	2018	count	1800.00	\N	1200.00	2600.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.504266	2025-07-01 04:23:45.504266
5153	53	4	2018	count	500.00	\N	500.00	890.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.519769	2025-07-01 04:23:45.519769
5154	54	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.52838	2025-07-01 04:23:45.52838
5155	55	4	2018	count	2400.00	\N	2000.00	2900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.539241	2025-07-01 04:23:45.539241
5156	56	4	2018	count	11000.00	\N	6800.00	19000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.548851	2025-07-01 04:23:45.548851
5158	58	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.557553	2025-07-01 04:23:45.557553
5159	59	4	2018	count	500.00	\N	500.00	540.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.568036	2025-07-01 04:23:45.568036
5160	60	4	2018	count	1200.00	\N	790.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.574162	2025-07-01 04:23:45.574162
5161	61	4	2018	count	980.00	\N	650.00	1400.00	980.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.580694	2025-07-01 04:23:45.580694
5162	62	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.589067	2025-07-01 04:23:45.589067
5163	63	4	2018	count	500.00	\N	500.00	670.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.608458	2025-07-01 04:23:45.608458
5164	64	4	2018	count	14000.00	\N	11000.00	18000.00	14000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.618887	2025-07-01 04:23:45.618887
5166	66	4	2018	count	2200.00	\N	2000.00	2400.00	2200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.626092	2025-07-01 04:23:45.626092
5167	67	4	2018	count	4300.00	\N	3300.00	5400.00	4300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.663335	2025-07-01 04:23:45.663335
5168	68	4	2018	count	1800.00	\N	1400.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.674028	2025-07-01 04:23:45.674028
5169	69	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.714817	2025-07-01 04:23:45.714817
5170	70	4	2018	count	2700.00	\N	2200.00	3600.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.751808	2025-07-01 04:23:45.751808
5171	71	4	2018	count	780.00	\N	540.00	1100.00	780.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.763902	2025-07-01 04:23:45.763902
5172	72	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.806299	2025-07-01 04:23:45.806299
5173	73	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.817785	2025-07-01 04:23:45.817785
5175	75	4	2018	count	38000.00	\N	33000.00	43000.00	38000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.830523	2025-07-01 04:23:45.830523
5176	76	4	2018	count	2600.00	\N	1400.00	5100.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.869474	2025-07-01 04:23:45.869474
5177	77	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.909556	2025-07-01 04:23:45.909556
5178	78	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.920008	2025-07-01 04:23:45.920008
5179	79	4	2018	count	710.00	\N	510.00	930.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.92723	2025-07-01 04:23:45.92723
5180	80	4	2018	count	1500.00	\N	1300.00	1800.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.961706	2025-07-01 04:23:45.961706
5182	82	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.968453	2025-07-01 04:23:45.968453
5183	83	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.974911	2025-07-01 04:23:45.974911
5184	84	4	2018	count	25000.00	\N	18000.00	38000.00	25000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:45.983682	2025-07-01 04:23:45.983682
5185	85	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.024117	2025-07-01 04:23:46.024117
5186	86	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.086473	2025-07-01 04:23:46.086473
5187	87	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.126352	2025-07-01 04:23:46.126352
5188	88	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.137326	2025-07-01 04:23:46.137326
5189	89	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.178779	2025-07-01 04:23:46.178779
5190	90	4	2018	count	6100.00	\N	5000.00	7600.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.188374	2025-07-01 04:23:46.188374
5191	91	4	2018	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.228927	2025-07-01 04:23:46.228927
5192	92	4	2018	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.272434	2025-07-01 04:23:46.272434
5194	94	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.282027	2025-07-01 04:23:46.282027
5195	95	4	2018	count	1700.00	\N	1200.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.292645	2025-07-01 04:23:46.292645
5196	96	4	2018	count	13000.00	\N	11000.00	16000.00	13000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.362085	2025-07-01 04:23:46.362085
5197	97	4	2018	count	2600.00	\N	2100.00	3300.00	2600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.376156	2025-07-01 04:23:46.376156
5199	99	4	2018	count	6500.00	\N	5000.00	8700.00	6500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.414905	2025-07-01 04:23:46.414905
5201	101	4	2018	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.425442	2025-07-01 04:23:46.425442
5202	102	4	2018	count	610.00	\N	500.00	820.00	610.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.468052	2025-07-01 04:23:46.468052
5204	104	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.476522	2025-07-01 04:23:46.476522
5205	105	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.516226	2025-07-01 04:23:46.516226
5206	106	4	2018	count	500.00	\N	500.00	600.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.523588	2025-07-01 04:23:46.523588
5207	107	4	2018	count	54000.00	\N	39000.00	73000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.530592	2025-07-01 04:23:46.530592
5208	108	4	2018	count	7800.00	\N	5900.00	11000.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.570677	2025-07-01 04:23:46.570677
5209	109	4	2018	count	2700.00	\N	2300.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.583841	2025-07-01 04:23:46.583841
5210	110	4	2018	count	910.00	\N	700.00	1200.00	910.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.627892	2025-07-01 04:23:46.627892
5212	112	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.641855	2025-07-01 04:23:46.641855
5213	113	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.657426	2025-07-01 04:23:46.657426
5214	114	4	2018	count	1200.00	\N	970.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.709313	2025-07-01 04:23:46.709313
5215	115	4	2018	count	53000.00	\N	31000.00	89000.00	53000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.722814	2025-07-01 04:23:46.722814
5216	116	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.773539	2025-07-01 04:23:46.773539
5217	117	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:46.823219	2025-07-01 04:23:46.823219
5218	118	4	2018	count	6400.00	\N	5200.00	7600.00	6400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.045108	2025-07-01 04:23:47.045108
5219	119	4	2018	count	500.00	\N	500.00	530.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.065182	2025-07-01 04:23:47.065182
5221	121	4	2018	count	720.00	\N	500.00	1200.00	720.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.089147	2025-07-01 04:23:47.089147
5222	122	4	2018	count	1000.00	\N	650.00	1900.00	1000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.109675	2025-07-01 04:23:47.109675
5223	123	4	2018	count	1200.00	\N	800.00	1700.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.124488	2025-07-01 04:23:47.124488
5225	125	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.138443	2025-07-01 04:23:47.138443
5228	128	4	2018	count	570.00	\N	500.00	860.00	570.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.163893	2025-07-01 04:23:47.163893
5229	129	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.179428	2025-07-01 04:23:47.179428
5230	130	4	2018	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.199999	2025-07-01 04:23:47.199999
5232	132	4	2018	count	2900.00	\N	2400.00	3500.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.233355	2025-07-01 04:23:47.233355
5234	134	4	2018	count	1300.00	\N	1000.00	1600.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.254835	2025-07-01 04:23:47.254835
5235	135	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.273083	2025-07-01 04:23:47.273083
5236	136	4	2018	count	2100.00	\N	1600.00	2800.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.303696	2025-07-01 04:23:47.303696
5237	137	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.337258	2025-07-01 04:23:47.337258
5238	138	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.352868	2025-07-01 04:23:47.352868
5239	139	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.363723	2025-07-01 04:23:47.363723
5240	140	4	2018	count	710.00	\N	530.00	1000.00	710.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.395389	2025-07-01 04:23:47.395389
5241	141	4	2018	count	71000.00	\N	52000.00	91000.00	71000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.418983	2025-07-01 04:23:47.418983
5242	142	4	2018	count	9900.00	\N	6900.00	13000.00	9900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.437397	2025-07-01 04:23:47.437397
5244	144	4	2018	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.452968	2025-07-01 04:23:47.452968
5245	145	4	2018	count	2900.00	\N	1400.00	5200.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.467045	2025-07-01 04:23:47.467045
5246	146	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.481438	2025-07-01 04:23:47.481438
5249	149	4	2018	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.494921	2025-07-01 04:23:47.494921
5250	150	4	2018	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.506896	2025-07-01 04:23:47.506896
5251	151	4	2018	count	18000.00	\N	13000.00	26000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.514301	2025-07-01 04:23:47.514301
5253	153	4	2018	count	3800.00	\N	3300.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.522514	2025-07-01 04:23:47.522514
5255	155	4	2018	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.529869	2025-07-01 04:23:47.529869
5258	158	4	2018	count	23000.00	\N	19000.00	31000.00	23000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.539792	2025-07-01 04:23:47.539792
5259	159	4	2018	count	6100.00	\N	4700.00	8000.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.550288	2025-07-01 04:23:47.550288
5262	162	4	2018	count	24000.00	\N	20000.00	29000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.562757	2025-07-01 04:23:47.562757
5264	164	4	2018	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.57307	2025-07-01 04:23:47.57307
5265	165	4	2018	count	1300.00	\N	1100.00	1500.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.584391	2025-07-01 04:23:47.584391
5267	167	4	2018	count	4700.00	\N	3200.00	6200.00	4700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.591568	2025-07-01 04:23:47.591568
5268	168	4	2018	count	500.00	\N	200.00	520.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.599129	2025-07-01 04:23:47.599129
5269	169	4	2018	count	17000.00	\N	13000.00	22000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.607821	2025-07-01 04:23:47.607821
5270	170	4	2018	count	22000.00	\N	17000.00	27000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.614641	2025-07-01 04:23:47.614641
5271	1	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.621151	2025-07-01 04:23:47.621151
5273	3	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.628202	2025-07-01 04:23:47.628202
5274	4	4	2010	count	10000.00	\N	7300.00	13000.00	10000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.637986	2025-07-01 04:23:47.637986
5275	5	4	2010	count	1600.00	\N	1300.00	2000.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.648377	2025-07-01 04:23:47.648377
5276	6	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.658762	2025-07-01 04:23:47.658762
5277	7	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.676208	2025-07-01 04:23:47.676208
5280	10	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.686139	2025-07-01 04:23:47.686139
5282	12	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.714282	2025-07-01 04:23:47.714282
5283	13	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.736163	2025-07-01 04:23:47.736163
5284	14	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.748107	2025-07-01 04:23:47.748107
5286	16	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.758263	2025-07-01 04:23:47.758263
5287	17	4	2010	count	2000.00	\N	980.00	4100.00	2000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.770692	2025-07-01 04:23:47.770692
5288	18	4	2010	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.780454	2025-07-01 04:23:47.780454
5289	19	4	2010	count	1600.00	\N	1500.00	1800.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.791724	2025-07-01 04:23:47.791724
5290	20	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.800447	2025-07-01 04:23:47.800447
5291	21	4	2010	count	7300.00	\N	6500.00	8000.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.816013	2025-07-01 04:23:47.816013
5292	22	4	2010	count	15000.00	\N	11000.00	19000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.825248	2025-07-01 04:23:47.825248
5294	24	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.832431	2025-07-01 04:23:47.832431
5295	25	4	2010	count	4800.00	\N	3600.00	6300.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.843633	2025-07-01 04:23:47.843633
5296	26	4	2010	count	5200.00	\N	4100.00	6400.00	5200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.851911	2025-07-01 04:23:47.851911
5297	27	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.859865	2025-07-01 04:23:47.859865
5298	28	4	2010	count	2500.00	\N	1900.00	3400.00	2500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.87661	2025-07-01 04:23:47.87661
5299	29	4	2010	count	22000.00	\N	19000.00	25000.00	22000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.888602	2025-07-01 04:23:47.888602
5301	31	4	2010	count	7800.00	\N	6400.00	9400.00	7800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.896753	2025-07-01 04:23:47.896753
5302	32	4	2010	count	3500.00	\N	2600.00	4800.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.908263	2025-07-01 04:23:47.908263
5306	36	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.920721	2025-07-01 04:23:47.920721
5307	37	4	2010	count	3900.00	\N	3100.00	4800.00	3900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.93004	2025-07-01 04:23:47.93004
5308	38	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.940284	2025-07-01 04:23:47.940284
5309	39	4	2010	count	24000.00	\N	17000.00	34000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.949095	2025-07-01 04:23:47.949095
5310	40	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.959494	2025-07-01 04:23:47.959494
5311	41	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.969268	2025-07-01 04:23:47.969268
5313	43	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.978357	2025-07-01 04:23:47.978357
5315	45	4	2010	count	34000.00	\N	27000.00	40000.00	34000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.986169	2025-07-01 04:23:47.986169
5316	46	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:47.997315	2025-07-01 04:23:47.997315
5317	47	4	2010	count	630.00	\N	500.00	780.00	630.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.010892	2025-07-01 04:23:48.010892
5318	48	4	2010	count	3000.00	\N	2100.00	4300.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.022809	2025-07-01 04:23:48.022809
5319	49	4	2010	count	1100.00	\N	520.00	2200.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.035026	2025-07-01 04:23:48.035026
5320	50	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.044362	2025-07-01 04:23:48.044362
5321	51	4	2010	count	500.00	\N	500.00	730.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.056545	2025-07-01 04:23:48.056545
5322	52	4	2010	count	1400.00	\N	970.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.063845	2025-07-01 04:23:48.063845
5323	53	4	2010	count	620.00	\N	500.00	980.00	620.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.071049	2025-07-01 04:23:48.071049
5324	54	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.080463	2025-07-01 04:23:48.080463
5325	55	4	2010	count	3800.00	\N	3400.00	4200.00	3800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.088692	2025-07-01 04:23:48.088692
5326	56	4	2010	count	20000.00	\N	12000.00	35000.00	20000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.096512	2025-07-01 04:23:48.096512
5328	58	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.104549	2025-07-01 04:23:48.104549
5329	59	4	2010	count	600.00	\N	500.00	780.00	600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.111427	2025-07-01 04:23:48.111427
5330	60	4	2010	count	1600.00	\N	1100.00	2100.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.118497	2025-07-01 04:23:48.118497
5331	61	4	2010	count	970.00	\N	660.00	1400.00	970.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.127055	2025-07-01 04:23:48.127055
5332	62	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.139173	2025-07-01 04:23:48.139173
5333	63	4	2010	count	500.00	\N	500.00	720.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.157814	2025-07-01 04:23:48.157814
5334	64	4	2010	count	17000.00	\N	14000.00	19000.00	17000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.168416	2025-07-01 04:23:48.168416
5336	66	4	2010	count	1700.00	\N	1500.00	1900.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.179594	2025-07-01 04:23:48.179594
5337	67	4	2010	count	4100.00	\N	3300.00	5000.00	4100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.186356	2025-07-01 04:23:48.186356
5338	68	4	2010	count	1900.00	\N	1500.00	2200.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.193174	2025-07-01 04:23:48.193174
5339	69	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.200161	2025-07-01 04:23:48.200161
5340	70	4	2010	count	4900.00	\N	3800.00	6600.00	4900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.207586	2025-07-01 04:23:48.207586
5341	71	4	2010	count	1400.00	\N	990.00	1800.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.214344	2025-07-01 04:23:48.214344
5342	72	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.222817	2025-07-01 04:23:48.222817
5343	73	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.229462	2025-07-01 04:23:48.229462
5345	75	4	2010	count	24000.00	\N	19000.00	28000.00	24000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.236817	2025-07-01 04:23:48.236817
5346	76	4	2010	count	2400.00	\N	1700.00	3500.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.245099	2025-07-01 04:23:48.245099
5347	77	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.25271	2025-07-01 04:23:48.25271
5348	78	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.260096	2025-07-01 04:23:48.260096
5349	79	4	2010	count	830.00	\N	620.00	1100.00	830.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.270953	2025-07-01 04:23:48.270953
5350	80	4	2010	count	1800.00	\N	1500.00	2100.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.281219	2025-07-01 04:23:48.281219
5352	82	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.288145	2025-07-01 04:23:48.288145
5353	83	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.295478	2025-07-01 04:23:48.295478
5354	84	4	2010	count	56000.00	\N	41000.00	86000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.302859	2025-07-01 04:23:48.302859
5355	85	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.310161	2025-07-01 04:23:48.310161
5356	86	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.317515	2025-07-01 04:23:48.317515
5357	87	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.324772	2025-07-01 04:23:48.324772
5358	88	4	2010	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.331447	2025-07-01 04:23:48.331447
5359	89	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.339625	2025-07-01 04:23:48.339625
5360	90	4	2010	count	7200.00	\N	5600.00	10000.00	7200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.348087	2025-07-01 04:23:48.348087
5361	91	4	2010	count	2700.00	\N	2600.00	2900.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.355784	2025-07-01 04:23:48.355784
5362	92	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.363712	2025-07-01 04:23:48.363712
5364	94	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.371511	2025-07-01 04:23:48.371511
5365	95	4	2010	count	1400.00	\N	1000.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.386766	2025-07-01 04:23:48.386766
5366	96	4	2010	count	29000.00	\N	25000.00	33000.00	29000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.395606	2025-07-01 04:23:48.395606
5367	97	4	2010	count	2900.00	\N	2400.00	3300.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.403485	2025-07-01 04:23:48.403485
5369	99	4	2010	count	5300.00	\N	4100.00	6700.00	5300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.411121	2025-07-01 04:23:48.411121
5371	101	4	2010	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.419228	2025-07-01 04:23:48.419228
5372	102	4	2010	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.426544	2025-07-01 04:23:48.426544
5374	104	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.434809	2025-07-01 04:23:48.434809
5375	105	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.442473	2025-07-01 04:23:48.442473
5376	106	4	2010	count	550.00	\N	500.00	840.00	550.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.449495	2025-07-01 04:23:48.449495
5377	107	4	2010	count	64000.00	\N	46000.00	87000.00	64000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.456784	2025-07-01 04:23:48.456784
5378	108	4	2010	count	11000.00	\N	9600.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.463718	2025-07-01 04:23:48.463718
5379	109	4	2010	count	3500.00	\N	3000.00	3900.00	3500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.470871	2025-07-01 04:23:48.470871
5380	110	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.477812	2025-07-01 04:23:48.477812
5381	111	4	2010	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.484806	2025-07-01 04:23:48.484806
5382	112	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.492784	2025-07-01 04:23:48.492784
5383	113	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.500335	2025-07-01 04:23:48.500335
5384	114	4	2010	count	1700.00	\N	1300.00	2100.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.510072	2025-07-01 04:23:48.510072
5385	115	4	2010	count	72000.00	\N	42000.00	120000.00	72000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.517238	2025-07-01 04:23:48.517238
5386	116	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.524588	2025-07-01 04:23:48.524588
5387	117	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.532282	2025-07-01 04:23:48.532282
5388	118	4	2010	count	1400.00	\N	870.00	1900.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.539905	2025-07-01 04:23:48.539905
5389	119	4	2010	count	500.00	\N	500.00	570.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.546921	2025-07-01 04:23:48.546921
5391	121	4	2010	count	790.00	\N	540.00	1200.00	790.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.554443	2025-07-01 04:23:48.554443
5392	122	4	2010	count	2100.00	\N	1400.00	3300.00	2100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.562092	2025-07-01 04:23:48.562092
5393	123	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.569512	2025-07-01 04:23:48.569512
5395	125	4	2010	count	930.00	\N	730.00	1200.00	930.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.579026	2025-07-01 04:23:48.579026
5398	128	4	2010	count	740.00	\N	510.00	1100.00	740.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.59082	2025-07-01 04:23:48.59082
5399	129	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.600747	2025-07-01 04:23:48.600747
5400	130	4	2010	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.608353	2025-07-01 04:23:48.608353
5402	132	4	2010	count	5700.00	\N	4700.00	7100.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.615642	2025-07-01 04:23:48.615642
5404	134	4	2010	count	1300.00	\N	1000.00	1800.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.623621	2025-07-01 04:23:48.623621
5405	135	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.631528	2025-07-01 04:23:48.631528
5406	136	4	2010	count	2900.00	\N	2400.00	3600.00	2900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.639235	2025-07-01 04:23:48.639235
5407	137	4	2010	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.647264	2025-07-01 04:23:48.647264
5408	138	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.655996	2025-07-01 04:23:48.655996
5409	139	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.663592	2025-07-01 04:23:48.663592
5410	140	4	2010	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.672973	2025-07-01 04:23:48.672973
5411	141	4	2010	count	140000.00	\N	110000.00	170000.00	140000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.680877	2025-07-01 04:23:48.680877
5412	142	4	2010	count	9800.00	\N	7300.00	13000.00	9800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.689365	2025-07-01 04:23:48.689365
5413	143	4	2010	count	1300.00	\N	1100.00	1700.00	1300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.697439	2025-07-01 04:23:48.697439
5414	144	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:48.880872	2025-07-01 04:23:48.880872
5415	145	4	2010	count	1900.00	\N	1300.00	2600.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.465787	2025-07-01 04:23:49.465787
5416	146	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.470319	2025-07-01 04:23:49.470319
5419	149	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.480706	2025-07-01 04:23:49.480706
5420	150	4	2010	count	500.00	\N	500.00	560.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.492767	2025-07-01 04:23:49.492767
5421	151	4	2010	count	27000.00	\N	19000.00	36000.00	27000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.498994	2025-07-01 04:23:49.498994
5423	153	4	2010	count	5700.00	\N	5100.00	6300.00	5700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.506798	2025-07-01 04:23:49.506798
5425	155	4	2010	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.515239	2025-07-01 04:23:49.515239
5428	158	4	2010	count	56000.00	\N	48000.00	66000.00	56000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.524114	2025-07-01 04:23:49.524114
5429	159	4	2010	count	12000.00	\N	10000.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.531454	2025-07-01 04:23:49.531454
5432	162	4	2010	count	48000.00	\N	42000.00	53000.00	48000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.543606	2025-07-01 04:23:49.543606
5434	164	4	2010	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.548585	2025-07-01 04:23:49.548585
5435	165	4	2010	count	1800.00	\N	1700.00	1900.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.553636	2025-07-01 04:23:49.553636
5437	167	4	2010	count	8500.00	\N	6400.00	9800.00	8500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.557379	2025-07-01 04:23:49.557379
5438	168	4	2010	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.562712	2025-07-01 04:23:49.562712
5439	169	4	2010	count	26000.00	\N	21000.00	35000.00	26000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.567607	2025-07-01 04:23:49.567607
5440	170	4	2010	count	54000.00	\N	43000.00	68000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.572396	2025-07-01 04:23:49.572396
5441	1	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.57974	2025-07-01 04:23:49.57974
5443	3	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.584196	2025-07-01 04:23:49.584196
5444	4	4	2000	count	4800.00	\N	3500.00	6400.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.590021	2025-07-01 04:23:49.590021
5445	5	4	2000	count	1400.00	\N	1200.00	1700.00	1400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.596143	2025-07-01 04:23:49.596143
5446	6	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.600669	2025-07-01 04:23:49.600669
5447	7	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.605108	2025-07-01 04:23:49.605108
5450	10	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.610018	2025-07-01 04:23:49.610018
5452	12	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.614696	2025-07-01 04:23:49.614696
5453	13	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.620233	2025-07-01 04:23:49.620233
5454	14	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.626766	2025-07-01 04:23:49.626766
5456	16	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.634896	2025-07-01 04:23:49.634896
5457	17	4	2000	count	2400.00	\N	1200.00	4900.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.660728	2025-07-01 04:23:49.660728
5458	18	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.672776	2025-07-01 04:23:49.672776
5459	19	4	2000	count	670.00	\N	500.00	830.00	670.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.678628	2025-07-01 04:23:49.678628
5460	20	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.696142	2025-07-01 04:23:49.696142
5461	21	4	2000	count	15000.00	\N	13000.00	18000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.701784	2025-07-01 04:23:49.701784
5462	22	4	2000	count	15000.00	\N	11000.00	20000.00	15000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.711079	2025-07-01 04:23:49.711079
5464	24	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.715944	2025-07-01 04:23:49.715944
5465	25	4	2000	count	12000.00	\N	9300.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.720832	2025-07-01 04:23:49.720832
5466	26	4	2000	count	11000.00	\N	7800.00	13000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.724144	2025-07-01 04:23:49.724144
5467	27	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.729397	2025-07-01 04:23:49.729397
5468	28	4	2000	count	4500.00	\N	3200.00	5800.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.732537	2025-07-01 04:23:49.732537
5469	29	4	2000	count	19000.00	\N	15000.00	24000.00	19000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.741324	2025-07-01 04:23:49.741324
5471	31	4	2000	count	11000.00	\N	8400.00	14000.00	11000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.749571	2025-07-01 04:23:49.749571
5472	32	4	2000	count	5600.00	\N	3800.00	7700.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.759466	2025-07-01 04:23:49.759466
5476	36	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.767394	2025-07-01 04:23:49.767394
5477	37	4	2000	count	6100.00	\N	4700.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.772142	2025-07-01 04:23:49.772142
5478	38	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.781152	2025-07-01 04:23:49.781152
5479	39	4	2000	count	44000.00	\N	32000.00	63000.00	44000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.790577	2025-07-01 04:23:49.790577
5480	40	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.801237	2025-07-01 04:23:49.801237
5481	41	4	2000	count	200.00	\N	200.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.810594	2025-07-01 04:23:49.810594
5483	43	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.819401	2025-07-01 04:23:49.819401
5485	45	4	2000	count	43000.00	\N	35000.00	49000.00	43000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.829367	2025-07-01 04:23:49.829367
5486	46	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.842319	2025-07-01 04:23:49.842319
5487	47	4	2000	count	500.00	\N	500.00	690.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.852332	2025-07-01 04:23:49.852332
5488	48	4	2000	count	4800.00	\N	3100.00	7100.00	4800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.865208	2025-07-01 04:23:49.865208
5489	49	4	2000	count	1500.00	\N	620.00	2600.00	1500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.875822	2025-07-01 04:23:49.875822
5490	50	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.885657	2025-07-01 04:23:49.885657
5491	51	4	2000	count	810.00	\N	580.00	1000.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.894963	2025-07-01 04:23:49.894963
5492	52	4	2000	count	680.00	\N	500.00	1000.00	680.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.907307	2025-07-01 04:23:49.907307
5493	53	4	2000	count	1100.00	\N	690.00	1500.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.922954	2025-07-01 04:23:49.922954
5494	54	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.932986	2025-07-01 04:23:49.932986
5495	55	4	2000	count	5000.00	\N	4000.00	6100.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.942459	2025-07-01 04:23:49.942459
5496	56	4	2000	count	58000.00	\N	35000.00	100000.00	58000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.955359	2025-07-01 04:23:49.955359
5498	58	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.966234	2025-07-01 04:23:49.966234
5499	59	4	2000	count	880.00	\N	720.00	1000.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.988606	2025-07-01 04:23:49.988606
5500	60	4	2000	count	1600.00	\N	1100.00	2300.00	1600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:49.998257	2025-07-01 04:23:49.998257
5501	61	4	2000	count	500.00	\N	500.00	620.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.010798	2025-07-01 04:23:50.010798
5502	62	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.021112	2025-07-01 04:23:50.021112
5503	63	4	2000	count	880.00	\N	690.00	1100.00	880.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.034681	2025-07-01 04:23:50.034681
5504	64	4	2000	count	18000.00	\N	15000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.051678	2025-07-01 04:23:50.051678
5506	66	4	2000	count	2400.00	\N	2000.00	2700.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.061321	2025-07-01 04:23:50.061321
5507	67	4	2000	count	5000.00	\N	3400.00	7000.00	5000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.074165	2025-07-01 04:23:50.074165
5508	68	4	2000	count	1100.00	\N	850.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.085178	2025-07-01 04:23:50.085178
5509	69	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.098581	2025-07-01 04:23:50.098581
5510	70	4	2000	count	12000.00	\N	9400.00	15000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.108642	2025-07-01 04:23:50.108642
5511	71	4	2000	count	3200.00	\N	2300.00	4000.00	3200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.125941	2025-07-01 04:23:50.125941
5512	72	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.136312	2025-07-01 04:23:50.136312
5513	73	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.18173	2025-07-01 04:23:50.18173
5515	75	4	2000	count	1900.00	\N	1200.00	2500.00	1900.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.193307	2025-07-01 04:23:50.193307
5516	76	4	2000	count	500.00	\N	500.00	1400.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.227228	2025-07-01 04:23:50.227228
5517	77	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.262183	2025-07-01 04:23:50.262183
5518	78	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.273722	2025-07-01 04:23:50.273722
5519	79	4	2000	count	1200.00	\N	1000.00	1500.00	1200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.317167	2025-07-01 04:23:50.317167
5520	80	4	2000	count	2400.00	\N	1900.00	3100.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.326128	2025-07-01 04:23:50.326128
5522	82	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.355899	2025-07-01 04:23:50.355899
5523	83	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.365756	2025-07-01 04:23:50.365756
5524	84	4	2000	count	120000.00	\N	88000.00	190000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.406586	2025-07-01 04:23:50.406586
5525	85	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.451759	2025-07-01 04:23:50.451759
5526	86	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.46582	2025-07-01 04:23:50.46582
5527	87	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.481548	2025-07-01 04:23:50.481548
5528	88	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.487829	2025-07-01 04:23:50.487829
5529	89	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.533471	2025-07-01 04:23:50.533471
5530	90	4	2000	count	12000.00	\N	9000.00	16000.00	12000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.549436	2025-07-01 04:23:50.549436
5531	91	4	2000	count	3000.00	\N	2600.00	3400.00	3000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.577783	2025-07-01 04:23:50.577783
5532	92	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.614531	2025-07-01 04:23:50.614531
5534	94	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.887472	2025-07-01 04:23:50.887472
5535	95	4	2000	count	500.00	\N	200.00	930.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.897568	2025-07-01 04:23:50.897568
5536	96	4	2000	count	57000.00	\N	49000.00	65000.00	57000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.939496	2025-07-01 04:23:50.939496
5537	97	4	2000	count	2700.00	\N	2200.00	3200.00	2700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.951223	2025-07-01 04:23:50.951223
5539	99	4	2000	count	7700.00	\N	5600.00	9800.00	7700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:50.960705	2025-07-01 04:23:50.960705
5541	101	4	2000	count	500.00	\N	200.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.00598	2025-07-01 04:23:51.00598
5542	102	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.051833	2025-07-01 04:23:51.051833
5544	104	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.064142	2025-07-01 04:23:51.064142
5545	105	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.107014	2025-07-01 04:23:51.107014
5546	106	4	2000	count	500.00	\N	500.00	680.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.12006	2025-07-01 04:23:51.12006
5547	107	4	2000	count	40000.00	\N	29000.00	54000.00	40000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.161265	2025-07-01 04:23:51.161265
5548	108	4	2000	count	5800.00	\N	4600.00	6800.00	5800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.204177	2025-07-01 04:23:51.204177
5549	109	4	2000	count	7300.00	\N	5700.00	9100.00	7300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.2133	2025-07-01 04:23:51.2133
5550	110	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.257396	2025-07-01 04:23:51.257396
5551	111	4	2000	count	200.00	\N	200.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.263484	2025-07-01 04:23:51.263484
5552	112	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.306798	2025-07-01 04:23:51.306798
5553	113	4	2000	count	100.00	\N	100.00	500.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.315819	2025-07-01 04:23:51.315819
5554	114	4	2000	count	2300.00	\N	1700.00	3000.00	2300.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.32888	2025-07-01 04:23:51.32888
5555	115	4	2000	count	78000.00	\N	45000.00	130000.00	78000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.36973	2025-07-01 04:23:51.36973
5556	116	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.380309	2025-07-01 04:23:51.380309
5557	117	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.393377	2025-07-01 04:23:51.393377
5558	118	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.43625	2025-07-01 04:23:51.43625
5559	119	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.448507	2025-07-01 04:23:51.448507
5561	121	4	2000	count	500.00	\N	200.00	920.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.457543	2025-07-01 04:23:51.457543
5562	122	4	2000	count	5100.00	\N	3800.00	7000.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.468898	2025-07-01 04:23:51.468898
5563	123	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.508862	2025-07-01 04:23:51.508862
5565	125	4	2000	count	1100.00	\N	890.00	1400.00	1100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.552743	2025-07-01 04:23:51.552743
5568	128	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.644715	2025-07-01 04:23:51.644715
5569	129	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.695141	2025-07-01 04:23:51.695141
5570	130	4	2000	count	500.00	\N	500.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.745748	2025-07-01 04:23:51.745748
5572	132	4	2000	count	18000.00	\N	14000.00	22000.00	18000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.798518	2025-07-01 04:23:51.798518
5574	134	4	2000	count	1700.00	\N	1300.00	2300.00	1700.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.848919	2025-07-01 04:23:51.848919
5575	135	4	2000	count	200.00	\N	100.00	200.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.865264	2025-07-01 04:23:51.865264
5576	136	4	2000	count	2400.00	\N	1600.00	3300.00	2400.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.87975	2025-07-01 04:23:51.87975
5578	138	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.924768	2025-07-01 04:23:51.924768
5579	139	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:51.970145	2025-07-01 04:23:51.970145
5580	140	4	2000	count	810.00	\N	560.00	1100.00	810.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.011325	2025-07-01 04:23:52.011325
5581	141	4	2000	count	100000.00	\N	68000.00	140000.00	100000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.032346	2025-07-01 04:23:52.032346
5582	142	4	2000	count	5100.00	\N	2600.00	7500.00	5100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.072886	2025-07-01 04:23:52.072886
5583	143	4	2000	count	1800.00	\N	1500.00	2300.00	1800.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.081329	2025-07-01 04:23:52.081329
5584	144	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.098782	2025-07-01 04:23:52.098782
5585	145	4	2000	count	650.00	\N	500.00	1700.00	650.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.108411	2025-07-01 04:23:52.108411
5586	146	4	2000	count	200.00	\N	100.00	500.00	200.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.133801	2025-07-01 04:23:52.133801
5589	149	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.141951	2025-07-01 04:23:52.141951
5590	150	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.153226	2025-07-01 04:23:52.153226
5591	151	4	2000	count	54000.00	\N	45000.00	62000.00	54000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.169945	2025-07-01 04:23:52.169945
5593	153	4	2000	count	5600.00	\N	5000.00	6300.00	5600.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.181587	2025-07-01 04:23:52.181587
5595	155	4	2000	count	100.00	\N	100.00	100.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.228631	2025-07-01 04:23:52.228631
5598	158	4	2000	count	85000.00	\N	75000.00	99000.00	85000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.280268	2025-07-01 04:23:52.280268
5599	159	4	2000	count	4500.00	\N	3100.00	6200.00	4500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.362675	2025-07-01 04:23:52.362675
5602	162	4	2000	count	80000.00	\N	69000.00	90000.00	80000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.378739	2025-07-01 04:23:52.378739
5604	164	4	2000	count	500.00	\N	100.00	500.00	500.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.420715	2025-07-01 04:23:52.420715
5605	165	4	2000	count	840.00	\N	740.00	920.00	840.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.474257	2025-07-01 04:23:52.474257
5607	167	4	2000	count	6100.00	\N	4300.00	7800.00	6100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.519996	2025-07-01 04:23:52.519996
5608	168	4	2000	count	100.00	\N	100.00	200.00	100.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.532683	2025-07-01 04:23:52.532683
5609	169	4	2000	count	62000.00	\N	49000.00	81000.00	62000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.577547	2025-07-01 04:23:52.577547
5610	170	4	2000	count	120000.00	\N	98000.00	150000.00	120000.00	good	no_of_deaths_by_country_clean.csv	\N	2025-07-01 04:23:52.591324	2025-07-01 04:23:52.591324
5611	1	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.6367	2025-07-01 04:23:52.6367
5613	3	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.656352	2025-07-01 04:23:52.656352
5614	4	5	2018	count	2.00	\N	1.70	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.680878	2025-07-01 04:23:52.680878
5615	5	5	2018	count	0.40	\N	0.40	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.704491	2025-07-01 04:23:52.704491
5616	6	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.723222	2025-07-01 04:23:52.723222
5617	7	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.768577	2025-07-01 04:23:52.768577
5620	10	5	2018	count	1.80	\N	1.50	1.90	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.782247	2025-07-01 04:23:52.782247
5622	12	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.797614	2025-07-01 04:23:52.797614
5623	13	5	2018	count	1.50	\N	1.30	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.81137	2025-07-01 04:23:52.81137
5624	14	5	2018	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.825928	2025-07-01 04:23:52.825928
5626	16	5	2018	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.842186	2025-07-01 04:23:52.842186
5627	17	5	2018	count	1.00	\N	0.70	1.70	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.887207	2025-07-01 04:23:52.887207
5628	18	5	2018	count	0.30	\N	0.10	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.908344	2025-07-01 04:23:52.908344
5629	19	5	2018	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:52.963808	2025-07-01 04:23:52.963808
5630	20	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.017253	2025-07-01 04:23:53.017253
5631	21	5	2018	count	20.30	\N	17.30	21.80	20.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.038085	2025-07-01 04:23:53.038085
5632	22	5	2018	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.055854	2025-07-01 04:23:53.055854
5634	24	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.107573	2025-07-01 04:23:53.107573
5635	25	5	2018	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.128638	2025-07-01 04:23:53.128638
5636	26	5	2018	count	1.00	\N	0.90	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.177503	2025-07-01 04:23:53.177503
5637	27	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.207271	2025-07-01 04:23:53.207271
5638	28	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.217534	2025-07-01 04:23:53.217534
5639	29	5	2018	count	3.60	\N	3.10	4.00	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.234577	2025-07-01 04:23:53.234577
5641	31	5	2018	count	3.60	\N	2.90	4.50	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.24405	2025-07-01 04:23:53.24405
5642	32	5	2018	count	1.30	\N	1.00	1.70	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.254753	2025-07-01 04:23:53.254753
5643	33	5	2018	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.271043	2025-07-01 04:23:53.271043
5645	35	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.28023	2025-07-01 04:23:53.28023
5646	36	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.29271	2025-07-01 04:23:53.29271
5647	37	5	2018	count	2.60	\N	2.00	3.50	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.312181	2025-07-01 04:23:53.312181
5648	38	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.321539	2025-07-01 04:23:53.321539
5649	39	5	2018	count	2.60	\N	2.00	3.30	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.330931	2025-07-01 04:23:53.330931
5650	40	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.347182	2025-07-01 04:23:53.347182
5651	41	5	2018	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.356538	2025-07-01 04:23:53.356538
5653	43	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.365445	2025-07-01 04:23:53.365445
5655	45	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.383214	2025-07-01 04:23:53.383214
5656	46	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.391462	2025-07-01 04:23:53.391462
5657	47	5	2018	count	1.20	\N	1.00	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.401444	2025-07-01 04:23:53.401444
5658	48	5	2018	count	0.90	\N	0.70	1.30	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.414931	2025-07-01 04:23:53.414931
5659	49	5	2018	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.428042	2025-07-01 04:23:53.428042
5660	50	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.442768	2025-07-01 04:23:53.442768
5661	51	5	2018	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.455659	2025-07-01 04:23:53.455659
5662	52	5	2018	count	7.10	\N	5.60	9.20	7.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.471718	2025-07-01 04:23:53.471718
5663	53	5	2018	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.484199	2025-07-01 04:23:53.484199
5664	54	5	2018	count	0.90	\N	0.70	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.497705	2025-07-01 04:23:53.497705
5665	55	5	2018	count	27.30	\N	25.10	29.00	27.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.515059	2025-07-01 04:23:53.515059
5666	56	5	2018	count	1.00	\N	0.70	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.529221	2025-07-01 04:23:53.529221
5668	58	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.544141	2025-07-01 04:23:53.544141
5669	59	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.557244	2025-07-01 04:23:53.557244
5670	60	5	2018	count	3.80	\N	2.90	4.90	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.563832	2025-07-01 04:23:53.563832
5671	61	5	2018	count	1.90	\N	1.60	2.50	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.57274	2025-07-01 04:23:53.57274
5672	62	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.582554	2025-07-01 04:23:53.582554
5673	63	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.59678	2025-07-01 04:23:53.59678
5674	64	5	2018	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.60642	2025-07-01 04:23:53.60642
5676	66	5	2018	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.61742	2025-07-01 04:23:53.61742
5677	67	5	2018	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.62624	2025-07-01 04:23:53.62624
5678	68	5	2018	count	3.50	\N	3.00	4.00	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.637944	2025-07-01 04:23:53.637944
5679	69	5	2018	count	1.40	\N	1.30	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.645973	2025-07-01 04:23:53.645973
5680	70	5	2018	count	2.00	\N	1.80	2.30	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.654476	2025-07-01 04:23:53.654476
5681	71	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.666816	2025-07-01 04:23:53.666816
5682	72	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.675875	2025-07-01 04:23:53.675875
5683	73	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.686468	2025-07-01 04:23:53.686468
5685	75	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.696165	2025-07-01 04:23:53.696165
5686	76	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.706963	2025-07-01 04:23:53.706963
5687	77	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.715412	2025-07-01 04:23:53.715412
5688	78	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.729864	2025-07-01 04:23:53.729864
5689	79	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.741971	2025-07-01 04:23:53.741971
5690	80	5	2018	count	1.90	\N	1.60	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.748749	2025-07-01 04:23:53.748749
5691	81	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.756263	2025-07-01 04:23:53.756263
5692	82	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.767096	2025-07-01 04:23:53.767096
5693	83	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.775555	2025-07-01 04:23:53.775555
5694	84	5	2018	count	4.70	\N	4.00	5.70	4.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.788957	2025-07-01 04:23:53.788957
5695	85	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.799437	2025-07-01 04:23:53.799437
5696	86	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.812041	2025-07-01 04:23:53.812041
5697	87	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.821762	2025-07-01 04:23:53.821762
5698	88	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.832844	2025-07-01 04:23:53.832844
5699	89	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.845871	2025-07-01 04:23:53.845871
5700	90	5	2018	count	23.60	\N	21.20	24.70	23.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.857183	2025-07-01 04:23:53.857183
5701	91	5	2018	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.866458	2025-07-01 04:23:53.866458
5702	92	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.87715	2025-07-01 04:23:53.87715
5704	94	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.886665	2025-07-01 04:23:53.886665
5705	95	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.897527	2025-07-01 04:23:53.897527
5706	96	5	2018	count	9.20	\N	8.00	10.00	9.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.908276	2025-07-01 04:23:53.908276
5707	97	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.920281	2025-07-01 04:23:53.920281
5709	99	5	2018	count	1.40	\N	1.10	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.929679	2025-07-01 04:23:53.929679
5711	101	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.940112	2025-07-01 04:23:53.940112
5712	102	5	2018	count	1.30	\N	1.10	1.50	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.949079	2025-07-01 04:23:53.949079
5713	103	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.959918	2025-07-01 04:23:53.959918
5714	104	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.969685	2025-07-01 04:23:53.969685
5715	105	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.983356	2025-07-01 04:23:53.983356
5716	106	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:53.994786	2025-07-01 04:23:53.994786
5717	107	5	2018	count	12.60	\N	10.00	15.70	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.007016	2025-07-01 04:23:54.007016
5718	108	5	2018	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.018605	2025-07-01 04:23:54.018605
5719	109	5	2018	count	11.80	\N	10.60	12.70	11.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.035431	2025-07-01 04:23:54.035431
5720	110	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.054872	2025-07-01 04:23:54.054872
5722	112	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.06471	2025-07-01 04:23:54.06471
5723	113	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.076169	2025-07-01 04:23:54.076169
5724	114	5	2018	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.085978	2025-07-01 04:23:54.085978
5725	115	5	2018	count	1.50	\N	1.10	2.10	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.096882	2025-07-01 04:23:54.096882
5726	116	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.108148	2025-07-01 04:23:54.108148
5727	117	5	2018	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.12039	2025-07-01 04:23:54.12039
5728	118	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.132889	2025-07-01 04:23:54.132889
5729	119	5	2018	count	0.90	\N	0.80	1.00	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.145362	2025-07-01 04:23:54.145362
5730	120	5	2018	count	0.80	\N	0.70	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.154859	2025-07-01 04:23:54.154859
5731	121	5	2018	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.166713	2025-07-01 04:23:54.166713
5732	122	5	2018	count	0.30	\N	0.20	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.176906	2025-07-01 04:23:54.176906
5733	123	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.188432	2025-07-01 04:23:54.188432
5735	125	5	2018	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.197662	2025-07-01 04:23:54.197662
5738	128	5	2018	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.209786	2025-07-01 04:23:54.209786
5739	129	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.220688	2025-07-01 04:23:54.220688
5740	130	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.232463	2025-07-01 04:23:54.232463
5742	132	5	2018	count	2.50	\N	2.10	2.80	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.242989	2025-07-01 04:23:54.242989
5744	134	5	2018	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.254464	2025-07-01 04:23:54.254464
5745	135	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.266902	2025-07-01 04:23:54.266902
5746	136	5	2018	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.27923	2025-07-01 04:23:54.27923
5747	137	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.291697	2025-07-01 04:23:54.291697
5748	138	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.303744	2025-07-01 04:23:54.303744
5749	139	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.315708	2025-07-01 04:23:54.315708
5750	140	5	2018	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.330158	2025-07-01 04:23:54.330158
5751	141	5	2018	count	20.40	\N	17.40	22.50	20.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.343263	2025-07-01 04:23:54.343263
5752	142	5	2018	count	2.50	\N	1.90	3.10	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.352618	2025-07-01 04:23:54.352618
5753	143	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.361542	2025-07-01 04:23:54.361542
5754	144	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.374226	2025-07-01 04:23:54.374226
5755	145	5	2018	count	0.20	\N	0.10	0.50	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.386744	2025-07-01 04:23:54.386744
5756	146	5	2018	count	1.40	\N	0.90	2.00	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.398534	2025-07-01 04:23:54.398534
5759	149	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.408073	2025-07-01 04:23:54.408073
5760	150	5	2018	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.420073	2025-07-01 04:23:54.420073
5761	151	5	2018	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.429354	2025-07-01 04:23:54.429354
5763	153	5	2018	count	2.30	\N	2.10	2.50	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.44283	2025-07-01 04:23:54.44283
5765	155	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.452102	2025-07-01 04:23:54.452102
5768	158	5	2018	count	5.70	\N	5.40	6.10	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.46202	2025-07-01 04:23:54.46202
5769	159	5	2018	count	1.00	\N	0.90	1.00	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.474877	2025-07-01 04:23:54.474877
5772	162	5	2018	count	4.60	\N	4.00	5.10	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.484619	2025-07-01 04:23:54.484619
5774	164	5	2018	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.496514	2025-07-01 04:23:54.496514
5775	165	5	2018	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.507762	2025-07-01 04:23:54.507762
5777	167	5	2018	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.523209	2025-07-01 04:23:54.523209
5778	168	5	2018	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.534642	2025-07-01 04:23:54.534642
5779	169	5	2018	count	11.30	\N	10.00	12.60	11.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.549106	2025-07-01 04:23:54.549106
5780	170	5	2018	count	12.70	\N	10.80	14.50	12.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.55915	2025-07-01 04:23:54.55915
5781	1	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.568972	2025-07-01 04:23:54.568972
5783	3	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.581053	2025-07-01 04:23:54.581053
5784	4	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.591783	2025-07-01 04:23:54.591783
5785	5	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.604734	2025-07-01 04:23:54.604734
5786	6	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.618093	2025-07-01 04:23:54.618093
5787	7	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.629971	2025-07-01 04:23:54.629971
5790	10	5	2010	count	2.20	\N	1.90	2.50	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.641106	2025-07-01 04:23:54.641106
5792	12	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.650299	2025-07-01 04:23:54.650299
5793	13	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.659275	2025-07-01 04:23:54.659275
5794	14	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.674287	2025-07-01 04:23:54.674287
5796	16	5	2010	count	1.90	\N	1.70	2.10	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.687083	2025-07-01 04:23:54.687083
5797	17	5	2010	count	1.10	\N	0.70	1.80	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.698636	2025-07-01 04:23:54.698636
5798	18	5	2010	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.70802	2025-07-01 04:23:54.70802
5799	19	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.7168	2025-07-01 04:23:54.7168
5800	20	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.73491	2025-07-01 04:23:54.73491
5801	21	5	2010	count	23.20	\N	20.90	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.751837	2025-07-01 04:23:54.751837
5802	22	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.762027	2025-07-01 04:23:54.762027
5804	24	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.779725	2025-07-01 04:23:54.779725
5805	25	5	2010	count	1.20	\N	0.90	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.789714	2025-07-01 04:23:54.789714
5806	26	5	2010	count	1.60	\N	1.30	1.80	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.802979	2025-07-01 04:23:54.802979
5807	27	5	2010	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.812031	2025-07-01 04:23:54.812031
5808	28	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.831172	2025-07-01 04:23:54.831172
5809	29	5	2010	count	4.50	\N	3.90	4.90	4.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.845144	2025-07-01 04:23:54.845144
5811	31	5	2010	count	5.00	\N	4.20	5.90	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.858677	2025-07-01 04:23:54.858677
5812	32	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.873107	2025-07-01 04:23:54.873107
5813	33	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.886488	2025-07-01 04:23:54.886488
5815	35	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.899461	2025-07-01 04:23:54.899461
5816	36	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.913196	2025-07-01 04:23:54.913196
5817	37	5	2010	count	3.10	\N	2.60	3.70	3.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.929206	2025-07-01 04:23:54.929206
5818	38	5	2010	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.942598	2025-07-01 04:23:54.942598
5819	39	5	2010	count	3.60	\N	2.80	4.60	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.955564	2025-07-01 04:23:54.955564
5820	40	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.969574	2025-07-01 04:23:54.969574
5821	41	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.98441	2025-07-01 04:23:54.98441
5823	43	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:54.998002	2025-07-01 04:23:54.998002
5825	45	5	2010	count	1.10	\N	0.90	1.30	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.010645	2025-07-01 04:23:55.010645
5826	46	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.023959	2025-07-01 04:23:55.023959
5827	47	5	2010	count	1.60	\N	1.20	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.039049	2025-07-01 04:23:55.039049
5828	48	5	2010	count	1.20	\N	0.90	1.50	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.053197	2025-07-01 04:23:55.053197
5829	49	5	2010	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.06613	2025-07-01 04:23:55.06613
5830	50	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.079793	2025-07-01 04:23:55.079793
5831	51	5	2010	count	0.70	\N	0.60	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.092873	2025-07-01 04:23:55.092873
5832	52	5	2010	count	5.70	\N	4.80	6.70	5.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.111631	2025-07-01 04:23:55.111631
5833	53	5	2010	count	0.90	\N	0.70	1.20	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.125547	2025-07-01 04:23:55.125547
5834	54	5	2010	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.158695	2025-07-01 04:23:55.158695
5835	55	5	2010	count	27.40	\N	25.20	29.30	27.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.18761	2025-07-01 04:23:55.18761
5836	56	5	2010	count	1.30	\N	1.00	1.80	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.208592	2025-07-01 04:23:55.208592
5838	58	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.223128	2025-07-01 04:23:55.223128
5839	59	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.237416	2025-07-01 04:23:55.237416
5840	60	5	2010	count	4.10	\N	3.40	5.00	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.250741	2025-07-01 04:23:55.250741
5841	61	5	2010	count	1.90	\N	1.50	2.40	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.265512	2025-07-01 04:23:55.265512
5842	62	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.277693	2025-07-01 04:23:55.277693
5843	63	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.295165	2025-07-01 04:23:55.295165
5844	64	5	2010	count	1.90	\N	1.60	2.20	1.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.310482	2025-07-01 04:23:55.310482
5846	66	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.32183	2025-07-01 04:23:55.32183
5847	67	5	2010	count	1.60	\N	1.30	1.90	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.327508	2025-07-01 04:23:55.327508
5848	68	5	2010	count	3.80	\N	3.40	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.338826	2025-07-01 04:23:55.338826
5849	69	5	2010	count	1.50	\N	1.40	1.70	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.349997	2025-07-01 04:23:55.349997
5850	70	5	2010	count	2.10	\N	2.00	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.363159	2025-07-01 04:23:55.363159
5851	71	5	2010	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.374526	2025-07-01 04:23:55.374526
5852	72	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.383994	2025-07-01 04:23:55.383994
5853	73	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.390716	2025-07-01 04:23:55.390716
5855	75	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.40047	2025-07-01 04:23:55.40047
5856	76	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.413374	2025-07-01 04:23:55.413374
5857	77	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.425684	2025-07-01 04:23:55.425684
5858	78	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.448114	2025-07-01 04:23:55.448114
5859	79	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.461599	2025-07-01 04:23:55.461599
5860	80	5	2010	count	2.10	\N	1.80	2.30	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.470951	2025-07-01 04:23:55.470951
5861	81	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.481452	2025-07-01 04:23:55.481452
5862	82	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.495812	2025-07-01 04:23:55.495812
5863	83	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.506498	2025-07-01 04:23:55.506498
5864	84	5	2010	count	6.00	\N	5.10	7.10	6.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.518764	2025-07-01 04:23:55.518764
5865	85	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.531708	2025-07-01 04:23:55.531708
5866	86	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.729403	2025-07-01 04:23:55.729403
5867	87	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.743731	2025-07-01 04:23:55.743731
5868	88	5	2010	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.754375	2025-07-01 04:23:55.754375
5869	89	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.766877	2025-07-01 04:23:55.766877
5870	90	5	2010	count	24.10	\N	22.70	24.90	24.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.77715	2025-07-01 04:23:55.77715
5871	91	5	2010	count	1.70	\N	1.50	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.789185	2025-07-01 04:23:55.789185
5872	92	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.798076	2025-07-01 04:23:55.798076
5874	94	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.813206	2025-07-01 04:23:55.813206
5875	95	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.837558	2025-07-01 04:23:55.837558
5876	96	5	2010	count	10.60	\N	9.30	11.70	10.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.857431	2025-07-01 04:23:55.857431
5877	97	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.873312	2025-07-01 04:23:55.873312
5879	99	5	2010	count	1.40	\N	1.10	1.60	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.8871	2025-07-01 04:23:55.8871
5881	101	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.9014	2025-07-01 04:23:55.9014
5882	102	5	2010	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.915919	2025-07-01 04:23:55.915919
5883	103	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.930374	2025-07-01 04:23:55.930374
5884	104	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.947115	2025-07-01 04:23:55.947115
5885	105	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.963081	2025-07-01 04:23:55.963081
5886	106	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.976145	2025-07-01 04:23:55.976145
5887	107	5	2010	count	12.00	\N	9.50	14.90	12.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:55.986447	2025-07-01 04:23:55.986447
5888	108	5	2010	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.002277	2025-07-01 04:23:56.002277
5889	109	5	2010	count	13.40	\N	12.20	14.20	13.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.02048	2025-07-01 04:23:56.02048
5890	110	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.032549	2025-07-01 04:23:56.032549
5891	111	5	2010	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.055181	2025-07-01 04:23:56.055181
5892	112	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.081489	2025-07-01 04:23:56.081489
5893	113	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.096108	2025-07-01 04:23:56.096108
5894	114	5	2010	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.109744	2025-07-01 04:23:56.109744
5895	115	5	2010	count	1.60	\N	1.20	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.130298	2025-07-01 04:23:56.130298
5896	116	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.147451	2025-07-01 04:23:56.147451
5897	117	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.169885	2025-07-01 04:23:56.169885
5898	118	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.189302	2025-07-01 04:23:56.189302
5899	119	5	2010	count	0.80	\N	0.80	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.204292	2025-07-01 04:23:56.204292
5900	120	5	2010	count	0.80	\N	0.70	1.00	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.223776	2025-07-01 04:23:56.223776
5901	121	5	2010	count	0.50	\N	0.40	0.80	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.240769	2025-07-01 04:23:56.240769
5902	122	5	2010	count	0.30	\N	0.30	0.50	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.253929	2025-07-01 04:23:56.253929
5903	123	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.266561	2025-07-01 04:23:56.266561
5905	125	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.279793	2025-07-01 04:23:56.279793
5908	128	5	2010	count	0.50	\N	0.40	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.294808	2025-07-01 04:23:56.294808
5909	129	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.309659	2025-07-01 04:23:56.309659
5910	130	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.321642	2025-07-01 04:23:56.321642
5912	132	5	2010	count	3.30	\N	2.80	3.70	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.346421	2025-07-01 04:23:56.346421
5914	134	5	2010	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.358254	2025-07-01 04:23:56.358254
5915	135	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.400414	2025-07-01 04:23:56.400414
5916	136	5	2010	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.413391	2025-07-01 04:23:56.413391
5917	137	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.423628	2025-07-01 04:23:56.423628
5918	138	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.433726	2025-07-01 04:23:56.433726
5919	139	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.445571	2025-07-01 04:23:56.445571
5920	140	5	2010	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.47071	2025-07-01 04:23:56.47071
5921	141	5	2010	count	18.90	\N	16.80	20.70	18.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.482274	2025-07-01 04:23:56.482274
5922	142	5	2010	count	2.40	\N	1.90	3.00	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.522946	2025-07-01 04:23:56.522946
5923	143	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.532029	2025-07-01 04:23:56.532029
5924	144	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.544928	2025-07-01 04:23:56.544928
5925	145	5	2010	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.558806	2025-07-01 04:23:56.558806
5926	146	5	2010	count	1.40	\N	1.00	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.589778	2025-07-01 04:23:56.589778
5929	149	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.602157	2025-07-01 04:23:56.602157
5930	150	5	2010	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.613654	2025-07-01 04:23:56.613654
5931	151	5	2010	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.625475	2025-07-01 04:23:56.625475
5933	153	5	2010	count	2.90	\N	2.60	3.10	2.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.652821	2025-07-01 04:23:56.652821
5935	155	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.662027	2025-07-01 04:23:56.662027
5938	158	5	2010	count	6.80	\N	6.50	7.10	6.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.70314	2025-07-01 04:23:56.70314
5939	159	5	2010	count	0.90	\N	0.90	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.748531	2025-07-01 04:23:56.748531
5942	162	5	2010	count	5.00	\N	4.30	5.70	5.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.757502	2025-07-01 04:23:56.757502
5943	163	5	2010	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.804348	2025-07-01 04:23:56.804348
5944	164	5	2010	count	0.50	\N	0.40	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.826802	2025-07-01 04:23:56.826802
5945	165	5	2010	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.849762	2025-07-01 04:23:56.849762
5947	167	5	2010	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.875364	2025-07-01 04:23:56.875364
5948	168	5	2010	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.924347	2025-07-01 04:23:56.924347
5949	169	5	2010	count	13.00	\N	11.50	14.50	13.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.936997	2025-07-01 04:23:56.936997
5950	170	5	2010	count	15.40	\N	13.10	17.50	15.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.951385	2025-07-01 04:23:56.951385
5951	1	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:56.990821	2025-07-01 04:23:56.990821
5953	3	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.004313	2025-07-01 04:23:57.004313
5954	4	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.019145	2025-07-01 04:23:57.019145
5955	5	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.061762	2025-07-01 04:23:57.061762
5956	6	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.078903	2025-07-01 04:23:57.078903
5957	7	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.09322	2025-07-01 04:23:57.09322
5960	10	5	2005	count	2.30	\N	1.90	2.70	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.137707	2025-07-01 04:23:57.137707
5962	12	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.152239	2025-07-01 04:23:57.152239
5963	13	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.165791	2025-07-01 04:23:57.165791
5964	14	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.180172	2025-07-01 04:23:57.180172
5966	16	5	2005	count	1.70	\N	1.50	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.22895	2025-07-01 04:23:57.22895
5967	17	5	2005	count	1.30	\N	0.80	2.10	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.247755	2025-07-01 04:23:57.247755
5968	18	5	2005	count	0.30	\N	0.10	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.279524	2025-07-01 04:23:57.279524
5969	19	5	2005	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.297675	2025-07-01 04:23:57.297675
5970	20	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.343772	2025-07-01 04:23:57.343772
5971	21	5	2005	count	24.60	\N	22.10	25.90	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.360956	2025-07-01 04:23:57.360956
5972	22	5	2005	count	0.50	\N	0.30	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.3731	2025-07-01 04:23:57.3731
5974	24	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.413552	2025-07-01 04:23:57.413552
5975	25	5	2005	count	1.50	\N	1.10	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.429646	2025-07-01 04:23:57.429646
5976	26	5	2005	count	2.20	\N	1.70	2.60	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.473834	2025-07-01 04:23:57.473834
5977	27	5	2005	count	0.60	\N	0.50	1.00	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.483741	2025-07-01 04:23:57.483741
5978	28	5	2005	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.493521	2025-07-01 04:23:57.493521
5979	29	5	2005	count	4.80	\N	4.30	5.10	4.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.54194	2025-07-01 04:23:57.54194
5981	31	5	2005	count	5.90	\N	4.90	7.00	5.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.554684	2025-07-01 04:23:57.554684
5982	32	5	2005	count	1.50	\N	1.20	2.00	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.595961	2025-07-01 04:23:57.595961
5983	33	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.612554	2025-07-01 04:23:57.612554
5985	35	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.657248	2025-07-01 04:23:57.657248
5986	36	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.672154	2025-07-01 04:23:57.672154
5987	37	5	2005	count	3.50	\N	2.80	4.10	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.68657	2025-07-01 04:23:57.68657
5988	38	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.7111	2025-07-01 04:23:57.7111
5989	39	5	2005	count	4.40	\N	3.40	5.60	4.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.723334	2025-07-01 04:23:57.723334
5990	40	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.75923	2025-07-01 04:23:57.75923
5991	41	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.778914	2025-07-01 04:23:57.778914
5993	43	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.817707	2025-07-01 04:23:57.817707
5995	45	5	2005	count	1.40	\N	1.20	1.70	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.842662	2025-07-01 04:23:57.842662
5996	46	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.859477	2025-07-01 04:23:57.859477
5997	47	5	2005	count	2.10	\N	1.80	2.50	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.908758	2025-07-01 04:23:57.908758
5998	48	5	2005	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.964319	2025-07-01 04:23:57.964319
5999	49	5	2005	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:57.985659	2025-07-01 04:23:57.985659
6000	50	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.000613	2025-07-01 04:23:58.000613
6001	51	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.024119	2025-07-01 04:23:58.024119
6002	52	5	2005	count	4.60	\N	3.60	5.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.06892	2025-07-01 04:23:58.06892
6003	53	5	2005	count	1.10	\N	0.80	1.50	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.092359	2025-07-01 04:23:58.092359
6004	54	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.136597	2025-07-01 04:23:58.136597
6005	55	5	2005	count	26.30	\N	23.90	27.80	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.155327	2025-07-01 04:23:58.155327
6006	56	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.210273	2025-07-01 04:23:58.210273
6008	58	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.225016	2025-07-01 04:23:58.225016
6009	59	5	2005	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.272815	2025-07-01 04:23:58.272815
6010	60	5	2005	count	4.20	\N	3.30	5.30	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.321998	2025-07-01 04:23:58.321998
6011	61	5	2005	count	1.80	\N	1.40	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.341717	2025-07-01 04:23:58.341717
6012	62	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.388006	2025-07-01 04:23:58.388006
6013	63	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.399313	2025-07-01 04:23:58.399313
6014	64	5	2005	count	2.10	\N	1.80	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.414051	2025-07-01 04:23:58.414051
6016	66	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.42624	2025-07-01 04:23:58.42624
6017	67	5	2005	count	1.70	\N	1.40	1.90	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.438482	2025-07-01 04:23:58.438482
6018	68	5	2005	count	3.80	\N	3.40	4.20	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.45213	2025-07-01 04:23:58.45213
6019	69	5	2005	count	1.30	\N	1.10	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.464519	2025-07-01 04:23:58.464519
6020	70	5	2005	count	2.40	\N	2.20	2.60	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.477906	2025-07-01 04:23:58.477906
6021	71	5	2005	count	0.70	\N	0.50	0.90	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.49053	2025-07-01 04:23:58.49053
6022	72	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.503999	2025-07-01 04:23:58.503999
6023	73	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.516758	2025-07-01 04:23:58.516758
6025	75	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.530953	2025-07-01 04:23:58.530953
6026	76	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.542935	2025-07-01 04:23:58.542935
6027	77	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.562774	2025-07-01 04:23:58.562774
6028	78	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.570525	2025-07-01 04:23:58.570525
6029	79	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.576653	2025-07-01 04:23:58.576653
6030	80	5	2005	count	2.30	\N	2.00	2.60	2.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.589062	2025-07-01 04:23:58.589062
6031	81	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.602492	2025-07-01 04:23:58.602492
6032	82	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.613107	2025-07-01 04:23:58.613107
6033	83	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.62315	2025-07-01 04:23:58.62315
6034	84	5	2005	count	7.30	\N	6.20	8.70	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.634459	2025-07-01 04:23:58.634459
6035	85	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.64301	2025-07-01 04:23:58.64301
6036	86	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.651314	2025-07-01 04:23:58.651314
6037	87	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.665292	2025-07-01 04:23:58.665292
6038	88	5	2005	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.674165	2025-07-01 04:23:58.674165
6039	89	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.684871	2025-07-01 04:23:58.684871
6040	90	5	2005	count	23.80	\N	22.90	24.80	23.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.693866	2025-07-01 04:23:58.693866
6041	91	5	2005	count	2.10	\N	1.90	2.40	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.703495	2025-07-01 04:23:58.703495
6042	92	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.716253	2025-07-01 04:23:58.716253
6044	94	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.724808	2025-07-01 04:23:58.724808
6045	95	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.737321	2025-07-01 04:23:58.737321
6046	96	5	2005	count	12.20	\N	10.50	13.40	12.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.74923	2025-07-01 04:23:58.74923
6047	97	5	2005	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.761214	2025-07-01 04:23:58.761214
6049	99	5	2005	count	1.50	\N	1.20	1.80	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.771073	2025-07-01 04:23:58.771073
6051	101	5	2005	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.779722	2025-07-01 04:23:58.779722
6052	102	5	2005	count	1.00	\N	0.80	1.40	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.788572	2025-07-01 04:23:58.788572
6053	103	5	2005	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.797885	2025-07-01 04:23:58.797885
6054	104	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.809339	2025-07-01 04:23:58.809339
6055	105	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.820022	2025-07-01 04:23:58.820022
6056	106	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.828988	2025-07-01 04:23:58.828988
6057	107	5	2005	count	11.10	\N	8.90	13.80	11.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.840986	2025-07-01 04:23:58.840986
6058	108	5	2005	count	0.80	\N	0.60	0.90	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.849759	2025-07-01 04:23:58.849759
6059	109	5	2005	count	13.80	\N	12.60	14.70	13.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.859653	2025-07-01 04:23:58.859653
6060	110	5	2005	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.869287	2025-07-01 04:23:58.869287
6061	111	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.878848	2025-07-01 04:23:58.878848
6062	112	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.892145	2025-07-01 04:23:58.892145
6063	113	5	2005	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.900781	2025-07-01 04:23:58.900781
6064	114	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.909774	2025-07-01 04:23:58.909774
6065	115	5	2005	count	1.70	\N	1.20	2.20	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.918785	2025-07-01 04:23:58.918785
6066	116	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.927863	2025-07-01 04:23:58.927863
6067	117	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.93803	2025-07-01 04:23:58.93803
6068	118	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.950607	2025-07-01 04:23:58.950607
6069	119	5	2005	count	0.80	\N	0.70	0.80	0.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.959821	2025-07-01 04:23:58.959821
6070	120	5	2005	count	1.00	\N	0.90	1.10	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.966114	2025-07-01 04:23:58.966114
6071	121	5	2005	count	0.60	\N	0.40	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.974646	2025-07-01 04:23:58.974646
6072	122	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.983391	2025-07-01 04:23:58.983391
6073	123	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:58.993115	2025-07-01 04:23:58.993115
6075	125	5	2005	count	0.60	\N	0.50	0.60	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.001715	2025-07-01 04:23:59.001715
6078	128	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.011834	2025-07-01 04:23:59.011834
6079	129	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.020888	2025-07-01 04:23:59.020888
6080	130	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.030216	2025-07-01 04:23:59.030216
6082	132	5	2005	count	3.80	\N	3.20	4.30	3.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.039063	2025-07-01 04:23:59.039063
6084	134	5	2005	count	0.70	\N	0.60	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.052181	2025-07-01 04:23:59.052181
6085	135	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.061421	2025-07-01 04:23:59.061421
6086	136	5	2005	count	1.50	\N	1.30	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.071035	2025-07-01 04:23:59.071035
6087	137	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.083657	2025-07-01 04:23:59.083657
6088	138	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.092389	2025-07-01 04:23:59.092389
6089	139	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.105629	2025-07-01 04:23:59.105629
6090	140	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.115594	2025-07-01 04:23:59.115594
6091	141	5	2005	count	16.80	\N	15.00	18.40	16.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.128141	2025-07-01 04:23:59.128141
6092	142	5	2005	count	2.50	\N	2.00	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.138769	2025-07-01 04:23:59.138769
6093	143	5	2005	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.148156	2025-07-01 04:23:59.148156
6094	144	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.158792	2025-07-01 04:23:59.158792
6095	145	5	2005	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.169377	2025-07-01 04:23:59.169377
6096	146	5	2005	count	1.30	\N	1.00	1.90	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.18193	2025-07-01 04:23:59.18193
6099	149	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.191171	2025-07-01 04:23:59.191171
6100	150	5	2005	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.202929	2025-07-01 04:23:59.202929
6101	151	5	2005	count	1.60	\N	1.30	2.10	1.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.212479	2025-07-01 04:23:59.212479
6103	153	5	2005	count	3.30	\N	3.00	3.60	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.220884	2025-07-01 04:23:59.220884
6105	155	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.230953	2025-07-01 04:23:59.230953
6108	158	5	2005	count	7.30	\N	6.90	7.60	7.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.240369	2025-07-01 04:23:59.240369
6109	159	5	2005	count	0.90	\N	0.80	0.90	0.90	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.249109	2025-07-01 04:23:59.249109
6112	162	5	2005	count	5.40	\N	4.60	6.10	5.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.261677	2025-07-01 04:23:59.261677
6114	164	5	2005	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.270917	2025-07-01 04:23:59.270917
6115	165	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.282259	2025-07-01 04:23:59.282259
6117	167	5	2005	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.293448	2025-07-01 04:23:59.293448
6118	168	5	2005	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.302378	2025-07-01 04:23:59.302378
6119	169	5	2005	count	14.10	\N	12.50	15.80	14.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.312289	2025-07-01 04:23:59.312289
6120	170	5	2005	count	19.00	\N	16.20	21.60	19.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.330708	2025-07-01 04:23:59.330708
6121	1	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.344146	2025-07-01 04:23:59.344146
6123	3	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.358099	2025-07-01 04:23:59.358099
6124	4	5	2000	count	1.00	\N	0.80	1.20	1.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.372609	2025-07-01 04:23:59.372609
6125	5	5	2000	count	0.30	\N	0.30	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.384927	2025-07-01 04:23:59.384927
6126	6	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.398876	2025-07-01 04:23:59.398876
6127	7	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.40825	2025-07-01 04:23:59.40825
6130	10	5	2000	count	2.60	\N	2.20	3.10	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.424896	2025-07-01 04:23:59.424896
6132	12	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.433885	2025-07-01 04:23:59.433885
6133	13	5	2000	count	0.70	\N	0.60	0.80	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.444108	2025-07-01 04:23:59.444108
6134	14	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.458	2025-07-01 04:23:59.458
6136	16	5	2000	count	1.30	\N	1.20	1.40	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.470768	2025-07-01 04:23:59.470768
6137	17	5	2000	count	1.30	\N	0.90	2.20	1.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.485757	2025-07-01 04:23:59.485757
6138	18	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.498236	2025-07-01 04:23:59.498236
6139	19	5	2000	count	0.50	\N	0.50	0.50	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.511122	2025-07-01 04:23:59.511122
6140	20	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.528462	2025-07-01 04:23:59.528462
6141	21	5	2000	count	26.30	\N	25.10	27.20	26.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.544026	2025-07-01 04:23:59.544026
6142	22	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.557143	2025-07-01 04:23:59.557143
6144	24	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.571123	2025-07-01 04:23:59.571123
6145	25	5	2000	count	2.10	\N	1.70	2.60	2.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.585517	2025-07-01 04:23:59.585517
6146	26	5	2000	count	3.30	\N	2.80	4.00	3.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.596859	2025-07-01 04:23:59.596859
6147	27	5	2000	count	0.70	\N	0.50	1.10	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.609012	2025-07-01 04:23:59.609012
6148	28	5	2000	count	1.20	\N	1.10	1.40	1.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.623682	2025-07-01 04:23:59.623682
6149	29	5	2000	count	4.60	\N	4.30	4.90	4.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.638671	2025-07-01 04:23:59.638671
6151	31	5	2000	count	7.20	\N	6.10	8.60	7.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.650877	2025-07-01 04:23:59.650877
6152	32	5	2000	count	1.80	\N	1.30	2.30	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.669895	2025-07-01 04:23:59.669895
6153	33	5	2000	count	0.20	\N	0.10	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.685648	2025-07-01 04:23:59.685648
6155	35	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.70027	2025-07-01 04:23:59.70027
6156	36	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.711241	2025-07-01 04:23:59.711241
6157	37	5	2000	count	4.20	\N	3.40	5.10	4.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.731538	2025-07-01 04:23:59.731538
6158	38	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.744667	2025-07-01 04:23:59.744667
6159	39	5	2000	count	5.60	\N	4.40	7.20	5.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.760077	2025-07-01 04:23:59.760077
6160	40	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.774337	2025-07-01 04:23:59.774337
6161	41	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.790576	2025-07-01 04:23:59.790576
6163	43	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.80534	2025-07-01 04:23:59.80534
6165	45	5	2000	count	1.80	\N	1.50	2.10	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.8185	2025-07-01 04:23:59.8185
6166	46	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.82875	2025-07-01 04:23:59.82875
6167	47	5	2000	count	2.20	\N	1.70	2.90	2.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.83943	2025-07-01 04:23:59.83943
6168	48	5	2000	count	1.70	\N	1.30	2.40	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.851405	2025-07-01 04:23:59.851405
6169	49	5	2000	count	0.40	\N	0.20	0.60	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.860728	2025-07-01 04:23:59.860728
6170	50	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.873145	2025-07-01 04:23:59.873145
6171	51	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.883437	2025-07-01 04:23:59.883437
6172	52	5	2000	count	3.50	\N	2.50	4.90	3.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.894764	2025-07-01 04:23:59.894764
6173	53	5	2000	count	1.50	\N	1.10	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.906669	2025-07-01 04:23:59.906669
6174	54	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.919751	2025-07-01 04:23:59.919751
6175	55	5	2000	count	24.60	\N	23.00	26.50	24.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.929291	2025-07-01 04:23:59.929291
6176	56	5	2000	count	2.40	\N	1.70	3.20	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.940235	2025-07-01 04:23:59.940235
6178	58	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.949388	2025-07-01 04:23:59.949388
6179	59	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.962289	2025-07-01 04:23:59.962289
6180	60	5	2000	count	4.10	\N	3.00	5.60	4.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.97157	2025-07-01 04:23:59.97157
6181	61	5	2000	count	1.40	\N	1.10	1.90	1.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.984512	2025-07-01 04:23:59.984512
6182	62	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:23:59.995615	2025-07-01 04:23:59.995615
6183	63	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.004919	2025-07-01 04:24:00.004919
6184	64	5	2000	count	2.40	\N	2.10	2.70	2.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.014078	2025-07-01 04:24:00.014078
6186	66	5	2000	count	0.70	\N	0.70	0.70	0.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.023816	2025-07-01 04:24:00.023816
6187	67	5	2000	count	1.70	\N	1.40	2.00	1.70	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.034987	2025-07-01 04:24:00.034987
6188	68	5	2000	count	3.20	\N	2.80	3.50	3.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.045867	2025-07-01 04:24:00.045867
6189	69	5	2000	count	0.60	\N	0.40	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.057803	2025-07-01 04:24:00.057803
6190	70	5	2000	count	3.00	\N	2.70	3.40	3.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.067364	2025-07-01 04:24:00.067364
6191	71	5	2000	count	1.10	\N	0.90	1.40	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.077856	2025-07-01 04:24:00.077856
6192	72	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.088448	2025-07-01 04:24:00.088448
6193	73	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.097731	2025-07-01 04:24:00.097731
6195	75	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.107186	2025-07-01 04:24:00.107186
6196	76	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.114587	2025-07-01 04:24:00.114587
6197	77	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.125741	2025-07-01 04:24:00.125741
6198	78	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.168431	2025-07-01 04:24:00.168431
6199	79	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.208882	2025-07-01 04:24:00.208882
6200	80	5	2000	count	2.80	\N	2.50	3.00	2.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.253583	2025-07-01 04:24:00.253583
6201	81	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.264251	2025-07-01 04:24:00.264251
6202	82	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.276792	2025-07-01 04:24:00.276792
6203	83	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.313668	2025-07-01 04:24:00.313668
6204	84	5	2000	count	9.80	\N	8.40	11.70	9.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.330465	2025-07-01 04:24:00.330465
6205	85	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.343106	2025-07-01 04:24:00.343106
6206	86	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.383868	2025-07-01 04:24:00.383868
6207	87	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.395948	2025-07-01 04:24:00.395948
6208	88	5	2000	count	0.20	\N	0.20	0.20	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.444353	2025-07-01 04:24:00.444353
6209	89	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.460879	2025-07-01 04:24:00.460879
6210	90	5	2000	count	23.20	\N	21.50	24.80	23.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.47519	2025-07-01 04:24:00.47519
6211	91	5	2000	count	2.60	\N	2.40	2.70	2.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.487284	2025-07-01 04:24:00.487284
6212	92	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.500122	2025-07-01 04:24:00.500122
6214	94	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.514174	2025-07-01 04:24:00.514174
6215	95	5	2000	count	0.20	\N	0.10	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.529948	2025-07-01 04:24:00.529948
6216	96	5	2000	count	14.40	\N	13.00	15.40	14.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.544099	2025-07-01 04:24:00.544099
6217	97	5	2000	count	0.40	\N	0.30	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.558066	2025-07-01 04:24:00.558066
6219	99	5	2000	count	1.80	\N	1.50	2.20	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.582573	2025-07-01 04:24:00.582573
6221	101	5	2000	count	0.40	\N	0.40	0.50	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.627347	2025-07-01 04:24:00.627347
6222	102	5	2000	count	0.40	\N	0.20	0.80	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.63988	2025-07-01 04:24:00.63988
6223	103	5	2000	count	0.20	\N	0.20	0.30	0.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.847939	2025-07-01 04:24:00.847939
6224	104	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.86136	2025-07-01 04:24:00.86136
6225	105	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.89784	2025-07-01 04:24:00.89784
6226	106	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.910618	2025-07-01 04:24:00.910618
6227	107	5	2000	count	8.80	\N	7.00	11.00	8.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.950071	2025-07-01 04:24:00.950071
6228	108	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:00.993853	2025-07-01 04:24:00.993853
6229	109	5	2000	count	14.00	\N	13.10	15.10	14.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.00339	2025-07-01 04:24:01.00339
6230	110	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.04372	2025-07-01 04:24:01.04372
6231	111	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.055608	2025-07-01 04:24:01.055608
6232	112	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.09659	2025-07-01 04:24:01.09659
6233	113	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.108921	2025-07-01 04:24:01.108921
6234	114	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.12214	2025-07-01 04:24:01.12214
6235	115	5	2000	count	1.80	\N	1.30	2.40	1.80	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.133029	2025-07-01 04:24:01.133029
6236	116	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.143305	2025-07-01 04:24:01.143305
6237	117	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.155523	2025-07-01 04:24:01.155523
6238	118	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.164809	2025-07-01 04:24:01.164809
6239	119	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.17692	2025-07-01 04:24:01.17692
6240	120	5	2000	count	0.60	\N	0.50	0.80	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.18615	2025-07-01 04:24:01.18615
6241	121	5	2000	count	0.50	\N	0.30	0.70	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.198214	2025-07-01 04:24:01.198214
6242	122	5	2000	count	0.50	\N	0.40	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.210054	2025-07-01 04:24:01.210054
6243	123	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.221328	2025-07-01 04:24:01.221328
6245	125	5	2000	count	0.50	\N	0.50	0.60	0.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.231943	2025-07-01 04:24:01.231943
6248	128	5	2000	count	0.30	\N	0.30	0.40	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.243117	2025-07-01 04:24:01.243117
6249	129	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.25178	2025-07-01 04:24:01.25178
6250	130	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.264887	2025-07-01 04:24:01.264887
6252	132	5	2000	count	5.20	\N	4.60	5.90	5.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.276547	2025-07-01 04:24:01.276547
6254	134	5	2000	count	0.60	\N	0.50	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.289919	2025-07-01 04:24:01.289919
6255	135	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.300853	2025-07-01 04:24:01.300853
6256	136	5	2000	count	1.50	\N	1.20	1.90	1.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.309934	2025-07-01 04:24:01.309934
6257	137	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.32139	2025-07-01 04:24:01.32139
6258	138	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.330136	2025-07-01 04:24:01.330136
6259	139	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.343565	2025-07-01 04:24:01.343565
6260	140	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.353968	2025-07-01 04:24:01.353968
6261	141	5	2000	count	12.60	\N	10.70	13.90	12.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.369697	2025-07-01 04:24:01.369697
6262	142	5	2000	count	2.50	\N	1.50	3.20	2.50	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.378888	2025-07-01 04:24:01.378888
6263	143	5	2000	count	0.40	\N	0.30	0.40	0.40	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.390779	2025-07-01 04:24:01.390779
6264	144	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.401801	2025-07-01 04:24:01.401801
6265	145	5	2000	count	0.10	\N	0.10	0.20	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.413674	2025-07-01 04:24:01.413674
6266	146	5	2000	count	1.10	\N	0.80	1.60	1.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.424194	2025-07-01 04:24:01.424194
6269	149	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.433518	2025-07-01 04:24:01.433518
6270	150	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.441592	2025-07-01 04:24:01.441592
6271	151	5	2000	count	2.00	\N	1.60	2.50	2.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.451097	2025-07-01 04:24:01.451097
6273	153	5	2000	count	3.60	\N	3.20	3.80	3.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.461958	2025-07-01 04:24:01.461958
6275	155	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.473397	2025-07-01 04:24:01.473397
6278	158	5	2000	count	8.30	\N	7.70	8.90	8.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.484487	2025-07-01 04:24:01.484487
6279	159	5	2000	count	0.60	\N	0.60	0.70	0.60	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.493396	2025-07-01 04:24:01.493396
6282	162	5	2000	count	6.30	\N	5.50	6.90	6.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.502772	2025-07-01 04:24:01.502772
6284	164	5	2000	count	0.30	\N	0.20	0.60	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.513809	2025-07-01 04:24:01.513809
6285	165	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.522709	2025-07-01 04:24:01.522709
6287	167	5	2000	count	0.30	\N	0.20	0.30	0.30	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.534717	2025-07-01 04:24:01.534717
6288	168	5	2000	count	0.10	\N	0.10	0.10	0.10	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.543622	2025-07-01 04:24:01.543622
6289	169	5	2000	count	16.20	\N	14.30	18.20	16.20	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.55436	2025-07-01 04:24:01.55436
6290	170	5	2000	count	25.00	\N	21.20	28.30	25.00	good	no_of_cases_adults_15_to_49_by_country_clean.csv	\N	2025-07-01 04:24:01.607912	2025-07-01 04:24:01.607912
6291	1	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.615217	2025-07-01 04:24:01.615217
6292	1	6	2023	estimated_children_needing_art	500.00	\N	500.00	530.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.625617	2025-07-01 04:24:01.625617
6293	1	6	2023	estimated_children_art_coverage_percent	17.00	\N	10.00	26.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.637859	2025-07-01 04:24:01.637859
6294	2	6	2023	reported_children_receiving_art	20.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.646388	2025-07-01 04:24:01.646388
6297	3	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.659682	2025-07-01 04:24:01.659682
6298	3	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.670263	2025-07-01 04:24:01.670263
6299	3	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.679139	2025-07-01 04:24:01.679139
6300	4	6	2023	reported_children_receiving_art	4800.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.687819	2025-07-01 04:24:01.687819
6301	4	6	2023	estimated_children_needing_art	38000.00	\N	30000.00	47000.00	38000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.697943	2025-07-01 04:24:01.697943
6302	4	6	2023	estimated_children_art_coverage_percent	13.00	\N	10.00	16.00	13.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.707712	2025-07-01 04:24:01.707712
6303	5	6	2023	reported_children_receiving_art	1700.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.724071	2025-07-01 04:24:01.724071
6304	5	6	2023	estimated_children_needing_art	1800.00	\N	1600.00	2100.00	1800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.735659	2025-07-01 04:24:01.735659
6305	5	6	2023	estimated_children_art_coverage_percent	92.00	\N	84.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.745714	2025-07-01 04:24:01.745714
6310	7	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.754415	2025-07-01 04:24:01.754415
6315	9	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.768906	2025-07-01 04:24:01.768906
6318	10	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.777687	2025-07-01 04:24:01.777687
6319	10	6	2023	estimated_children_needing_art	200.00	\N	200.00	500.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.784086	2025-07-01 04:24:01.784086
6320	10	6	2023	estimated_children_art_coverage_percent	21.00	\N	18.00	26.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.791493	2025-07-01 04:24:01.791493
6324	12	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.832107	2025-07-01 04:24:01.832107
6325	12	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.842447	2025-07-01 04:24:01.842447
6326	12	6	2023	estimated_children_art_coverage_percent	33.00	\N	28.00	38.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.851237	2025-07-01 04:24:01.851237
6330	14	6	2023	reported_children_receiving_art	220.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.859916	2025-07-01 04:24:01.859916
6331	14	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.866826	2025-07-01 04:24:01.866826
6332	14	6	2023	estimated_children_art_coverage_percent	88.00	\N	64.00	95.00	88.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.873185	2025-07-01 04:24:01.873185
6336	16	6	2023	reported_children_receiving_art	60.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.879991	2025-07-01 04:24:01.879991
6337	16	6	2023	estimated_children_needing_art	200.00	\N	200.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.887816	2025-07-01 04:24:01.887816
6338	16	6	2023	estimated_children_art_coverage_percent	34.00	\N	31.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.89467	2025-07-01 04:24:01.89467
6339	17	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.910014	2025-07-01 04:24:01.910014
6340	17	6	2023	estimated_children_needing_art	4600.00	\N	2800.00	8000.00	4600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.919394	2025-07-01 04:24:01.919394
6341	17	6	2023	estimated_children_art_coverage_percent	44.00	\N	27.00	77.00	44.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.959224	2025-07-01 04:24:01.959224
6345	19	6	2023	reported_children_receiving_art	250.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.968386	2025-07-01 04:24:01.968386
6346	19	6	2023	estimated_children_needing_art	620.00	\N	560.00	670.00	620.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:01.97735	2025-07-01 04:24:01.97735
6347	19	6	2023	estimated_children_art_coverage_percent	40.00	\N	37.00	43.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.020289	2025-07-01 04:24:02.020289
6351	21	6	2023	reported_children_receiving_art	5400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.029046	2025-07-01 04:24:02.029046
6352	21	6	2023	estimated_children_needing_art	14000.00	\N	10000.00	17000.00	14000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.06955	2025-07-01 04:24:02.06955
6353	21	6	2023	estimated_children_art_coverage_percent	38.00	\N	28.00	46.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.09197	2025-07-01 04:24:02.09197
6357	23	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.146172	2025-07-01 04:24:02.146172
6363	25	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.169353	2025-07-01 04:24:02.169353
6364	25	6	2023	estimated_children_needing_art	9100.00	\N	6300.00	12000.00	9100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.222135	2025-07-01 04:24:02.222135
6365	25	6	2023	estimated_children_art_coverage_percent	21.00	\N	15.00	29.00	21.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.236389	2025-07-01 04:24:02.236389
6366	26	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.250301	2025-07-01 04:24:02.250301
6367	26	6	2023	estimated_children_needing_art	11000.00	\N	8000.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.30181	2025-07-01 04:24:02.30181
6368	26	6	2023	estimated_children_art_coverage_percent	30.00	\N	22.00	38.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.319661	2025-07-01 04:24:02.319661
6372	28	6	2023	reported_children_receiving_art	3000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.369692	2025-07-01 04:24:02.369692
6373	28	6	2023	estimated_children_needing_art	3300.00	\N	2800.00	3900.00	3300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.406045	2025-07-01 04:24:02.406045
6374	28	6	2023	estimated_children_art_coverage_percent	92.00	\N	78.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.419912	2025-07-01 04:24:02.419912
6375	29	6	2023	reported_children_receiving_art	10300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.433336	2025-07-01 04:24:02.433336
6376	29	6	2023	estimated_children_needing_art	43000.00	\N	33000.00	51000.00	43000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.447949	2025-07-01 04:24:02.447949
6377	29	6	2023	estimated_children_art_coverage_percent	24.00	\N	18.00	28.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.460344	2025-07-01 04:24:02.460344
6381	31	6	2023	reported_children_receiving_art	2500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.474251	2025-07-01 04:24:02.474251
6382	31	6	2023	estimated_children_needing_art	11000.00	\N	8200.00	14000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.486688	2025-07-01 04:24:02.486688
6383	31	6	2023	estimated_children_art_coverage_percent	23.00	\N	18.00	29.00	23.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.49999	2025-07-01 04:24:02.49999
6384	32	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.512881	2025-07-01 04:24:02.512881
6385	32	6	2023	estimated_children_needing_art	16000.00	\N	11000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.526199	2025-07-01 04:24:02.526199
6386	32	6	2023	estimated_children_art_coverage_percent	16.00	\N	11.00	22.00	16.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.540839	2025-07-01 04:24:02.540839
6387	33	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.55382	2025-07-01 04:24:02.55382
6388	33	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.567625	2025-07-01 04:24:02.567625
6389	33	6	2023	estimated_children_art_coverage_percent	56.00	\N	50.00	61.00	56.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.583064	2025-07-01 04:24:02.583064
6390	34	6	2023	reported_children_receiving_art	6200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.595736	2025-07-01 04:24:02.595736
6393	35	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.60896	2025-07-01 04:24:02.60896
6394	35	6	2023	estimated_children_needing_art	3600.00	\N	2900.00	4300.00	3600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.632731	2025-07-01 04:24:02.632731
6395	35	6	2023	estimated_children_art_coverage_percent	41.00	\N	32.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.650793	2025-07-01 04:24:02.650793
6399	37	6	2023	reported_children_receiving_art	2000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.663729	2025-07-01 04:24:02.663729
6400	37	6	2023	estimated_children_needing_art	7700.00	\N	5800.00	10000.00	7700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.677323	2025-07-01 04:24:02.677323
6401	37	6	2023	estimated_children_art_coverage_percent	25.00	\N	19.00	33.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.690066	2025-07-01 04:24:02.690066
6405	39	6	2023	reported_children_receiving_art	12300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.703091	2025-07-01 04:24:02.703091
6406	39	6	2023	estimated_children_needing_art	31000.00	\N	23000.00	41000.00	31000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.716087	2025-07-01 04:24:02.716087
6407	39	6	2023	estimated_children_art_coverage_percent	40.00	\N	29.00	54.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.730921	2025-07-01 04:24:02.730921
6411	41	6	2023	reported_children_receiving_art	30.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.74348	2025-07-01 04:24:02.74348
6412	41	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.756216	2025-07-01 04:24:02.756216
6413	41	6	2023	estimated_children_art_coverage_percent	34.00	\N	23.00	46.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.768266	2025-07-01 04:24:02.768266
6423	45	6	2023	reported_children_receiving_art	16000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.78128	2025-07-01 04:24:02.78128
6424	45	6	2023	estimated_children_needing_art	64000.00	\N	50000.00	76000.00	64000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.793644	2025-07-01 04:24:02.793644
6425	45	6	2023	estimated_children_art_coverage_percent	25.00	\N	20.00	30.00	25.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.805621	2025-07-01 04:24:02.805621
6429	47	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.811855	2025-07-01 04:24:02.811855
6430	47	6	2023	estimated_children_needing_art	810.00	\N	640.00	1000.00	810.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.821773	2025-07-01 04:24:02.821773
6431	47	6	2023	estimated_children_art_coverage_percent	10.00	\N	8.00	13.00	10.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.830643	2025-07-01 04:24:02.830643
6432	48	6	2023	reported_children_receiving_art	780.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.844012	2025-07-01 04:24:02.844012
6433	48	6	2023	estimated_children_needing_art	1400.00	\N	1000.00	1900.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.855429	2025-07-01 04:24:02.855429
6434	48	6	2023	estimated_children_art_coverage_percent	55.00	\N	39.00	74.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.868091	2025-07-01 04:24:02.868091
6435	49	6	2023	reported_children_receiving_art	540.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.877589	2025-07-01 04:24:02.877589
6436	49	6	2023	estimated_children_needing_art	660.00	\N	500.00	1200.00	660.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.884517	2025-07-01 04:24:02.884517
6437	49	6	2023	estimated_children_art_coverage_percent	82.00	\N	54.00	95.00	82.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.897704	2025-07-01 04:24:02.897704
6438	50	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.910654	2025-07-01 04:24:02.910654
6439	50	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.921133	2025-07-01 04:24:02.921133
6440	50	6	2023	estimated_children_art_coverage_percent	39.00	\N	36.00	42.00	39.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.935162	2025-07-01 04:24:02.935162
6441	51	6	2023	reported_children_receiving_art	150.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.946079	2025-07-01 04:24:02.946079
6442	51	6	2023	estimated_children_needing_art	610.00	\N	500.00	740.00	610.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.957332	2025-07-01 04:24:02.957332
6443	51	6	2023	estimated_children_art_coverage_percent	24.00	\N	19.00	30.00	24.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.966843	2025-07-01 04:24:02.966843
6444	52	6	2023	reported_children_receiving_art	770.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.979979	2025-07-01 04:24:02.979979
6445	52	6	2023	estimated_children_needing_art	5300.00	\N	3800.00	7100.00	5300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:02.993402	2025-07-01 04:24:02.993402
6446	52	6	2023	estimated_children_art_coverage_percent	14.00	\N	10.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.006698	2025-07-01 04:24:03.006698
6447	53	6	2023	reported_children_receiving_art	500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.01604	2025-07-01 04:24:03.01604
6448	53	6	2023	estimated_children_needing_art	1300.00	\N	930.00	2000.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.025965	2025-07-01 04:24:03.025965
6449	53	6	2023	estimated_children_art_coverage_percent	37.00	\N	26.00	55.00	37.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.037987	2025-07-01 04:24:03.037987
6453	55	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.046827	2025-07-01 04:24:03.046827
6454	55	6	2023	estimated_children_needing_art	11000.00	\N	9400.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.059132	2025-07-01 04:24:03.059132
6455	55	6	2023	estimated_children_art_coverage_percent	76.00	\N	63.00	88.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.069686	2025-07-01 04:24:03.069686
6456	56	6	2023	reported_children_receiving_art	21500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.081424	2025-07-01 04:24:03.081424
6457	56	6	2023	estimated_children_needing_art	36000.00	\N	23000.00	55000.00	36000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.090652	2025-07-01 04:24:03.090652
6458	56	6	2023	estimated_children_art_coverage_percent	59.00	\N	38.00	90.00	59.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.102508	2025-07-01 04:24:03.102508
6466	59	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.113221	2025-07-01 04:24:03.113221
6468	60	6	2023	reported_children_receiving_art	1900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.123845	2025-07-01 04:24:03.123845
6469	60	6	2023	estimated_children_needing_art	3200.00	\N	2300.00	4400.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.134973	2025-07-01 04:24:03.134973
6470	60	6	2023	estimated_children_art_coverage_percent	57.00	\N	41.00	78.00	57.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.147074	2025-07-01 04:24:03.147074
6471	61	6	2023	reported_children_receiving_art	550.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.157583	2025-07-01 04:24:03.157583
6472	61	6	2023	estimated_children_needing_art	1900.00	\N	1400.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.183412	2025-07-01 04:24:03.183412
6473	61	6	2023	estimated_children_art_coverage_percent	30.00	\N	23.00	39.00	30.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.194029	2025-07-01 04:24:03.194029
6478	63	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.203035	2025-07-01 04:24:03.203035
6480	64	6	2023	reported_children_receiving_art	5900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.213101	2025-07-01 04:24:03.213101
6481	64	6	2023	estimated_children_needing_art	30000.00	\N	23000.00	37000.00	30000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.222977	2025-07-01 04:24:03.222977
6482	64	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.264367	2025-07-01 04:24:03.264367
6486	66	6	2023	reported_children_receiving_art	730.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.274637	2025-07-01 04:24:03.274637
6487	66	6	2023	estimated_children_needing_art	2000.00	\N	1800.00	2200.00	2000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.30175	2025-07-01 04:24:03.30175
6488	66	6	2023	estimated_children_art_coverage_percent	36.00	\N	33.00	39.00	36.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.318619	2025-07-01 04:24:03.318619
6489	67	6	2023	reported_children_receiving_art	2100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.338397	2025-07-01 04:24:03.338397
6490	67	6	2023	estimated_children_needing_art	10000.00	\N	7900.00	13000.00	10000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.351672	2025-07-01 04:24:03.351672
6491	67	6	2023	estimated_children_art_coverage_percent	20.00	\N	15.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.399063	2025-07-01 04:24:03.399063
6492	68	6	2023	reported_children_receiving_art	350.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.416184	2025-07-01 04:24:03.416184
6493	68	6	2023	estimated_children_needing_art	5700.00	\N	4700.00	6600.00	5700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.441481	2025-07-01 04:24:03.441481
6494	68	6	2023	estimated_children_art_coverage_percent	6.00	\N	5.00	7.00	6.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.492316	2025-07-01 04:24:03.492316
6495	69	6	2023	reported_children_receiving_art	110.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.509067	2025-07-01 04:24:03.509067
6496	69	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.532905	2025-07-01 04:24:03.532905
6497	69	6	2023	estimated_children_art_coverage_percent	38.00	\N	31.00	44.00	38.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.551391	2025-07-01 04:24:03.551391
6498	70	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.584669	2025-07-01 04:24:03.584669
6499	70	6	2023	estimated_children_needing_art	8700.00	\N	7000.00	9900.00	8700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.608059	2025-07-01 04:24:03.608059
6500	70	6	2023	estimated_children_art_coverage_percent	40.00	\N	32.00	45.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.644197	2025-07-01 04:24:03.644197
6501	71	6	2023	reported_children_receiving_art	360.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.65817	2025-07-01 04:24:03.65817
6502	71	6	2023	estimated_children_needing_art	890.00	\N	710.00	1100.00	890.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.671464	2025-07-01 04:24:03.671464
6503	71	6	2023	estimated_children_art_coverage_percent	41.00	\N	33.00	49.00	41.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.718708	2025-07-01 04:24:03.718708
6513	75	6	2023	reported_children_receiving_art	3900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.736977	2025-07-01 04:24:03.736977
6514	75	6	2023	estimated_children_needing_art	18000.00	\N	15000.00	20000.00	18000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.754393	2025-07-01 04:24:03.754393
6515	75	6	2023	estimated_children_art_coverage_percent	22.00	\N	19.00	26.00	22.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.788861	2025-07-01 04:24:03.788861
6516	76	6	2023	reported_children_receiving_art	510.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.808819	2025-07-01 04:24:03.808819
6517	76	6	2023	estimated_children_needing_art	880.00	\N	580.00	1600.00	880.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.831187	2025-07-01 04:24:03.831187
6518	76	6	2023	estimated_children_art_coverage_percent	58.00	\N	39.00	95.00	58.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.846799	2025-07-01 04:24:03.846799
6520	77	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.894583	2025-07-01 04:24:03.894583
6523	78	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.90561	2025-07-01 04:24:03.90561
6526	79	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.919152	2025-07-01 04:24:03.919152
6528	80	6	2023	reported_children_receiving_art	140.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:03.953068	2025-07-01 04:24:03.953068
6529	80	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.00565	2025-07-01 04:24:04.00565
6530	80	6	2023	estimated_children_art_coverage_percent	51.00	\N	46.00	57.00	51.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.020611	2025-07-01 04:24:04.020611
6537	83	6	2023	reported_children_receiving_art	430.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.050723	2025-07-01 04:24:04.050723
6538	83	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.070238	2025-07-01 04:24:04.070238
6539	83	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.103705	2025-07-01 04:24:04.103705
6540	84	6	2023	reported_children_receiving_art	74300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.150449	2025-07-01 04:24:04.150449
6541	84	6	2023	estimated_children_needing_art	120000.00	\N	95000.00	160000.00	120000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.167572	2025-07-01 04:24:04.167572
6542	84	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	78.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.187613	2025-07-01 04:24:04.187613
6546	86	6	2023	reported_children_receiving_art	450.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.204427	2025-07-01 04:24:04.204427
6547	86	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.244885	2025-07-01 04:24:04.244885
6548	86	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.296086	2025-07-01 04:24:04.296086
6549	87	6	2023	reported_children_receiving_art	280.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.319004	2025-07-01 04:24:04.319004
6550	87	6	2023	estimated_children_needing_art	700.00	\N	620.00	820.00	700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.33597	2025-07-01 04:24:04.33597
6551	87	6	2023	estimated_children_art_coverage_percent	40.00	\N	35.00	46.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.364521	2025-07-01 04:24:04.364521
6558	90	6	2023	reported_children_receiving_art	8500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.380365	2025-07-01 04:24:04.380365
6559	90	6	2023	estimated_children_needing_art	12000.00	\N	9500.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.401554	2025-07-01 04:24:04.401554
6560	90	6	2023	estimated_children_art_coverage_percent	70.00	\N	55.00	81.00	70.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.416315	2025-07-01 04:24:04.416315
6561	91	6	2023	reported_children_receiving_art	680.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.430703	2025-07-01 04:24:04.430703
6562	91	6	2023	estimated_children_needing_art	3700.00	\N	3000.00	4400.00	3700.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.447207	2025-07-01 04:24:04.447207
6563	91	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	21.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.458314	2025-07-01 04:24:04.458314
6564	92	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.471917	2025-07-01 04:24:04.471917
6565	92	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.484616	2025-07-01 04:24:04.484616
6566	92	6	2023	estimated_children_art_coverage_percent	33.00	\N	30.00	35.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.498618	2025-07-01 04:24:04.498618
6573	95	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.512993	2025-07-01 04:24:04.512993
6574	95	6	2023	estimated_children_needing_art	1900.00	\N	1600.00	2500.00	1900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.531458	2025-07-01 04:24:04.531458
6575	95	6	2023	estimated_children_art_coverage_percent	5.00	\N	4.00	6.00	5.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.554103	2025-07-01 04:24:04.554103
6576	96	6	2023	reported_children_receiving_art	45100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.569617	2025-07-01 04:24:04.569617
6577	96	6	2023	estimated_children_needing_art	74000.00	\N	57000.00	89000.00	74000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.580591	2025-07-01 04:24:04.580591
6578	96	6	2023	estimated_children_art_coverage_percent	61.00	\N	47.00	73.00	61.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.590358	2025-07-01 04:24:04.590358
6579	97	6	2023	reported_children_receiving_art	400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.601915	2025-07-01 04:24:04.601915
6580	97	6	2023	estimated_children_needing_art	500.00	\N	500.00	520.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.613403	2025-07-01 04:24:04.613403
6581	97	6	2023	estimated_children_art_coverage_percent	94.00	\N	77.00	95.00	94.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.623445	2025-07-01 04:24:04.623445
6585	99	6	2023	reported_children_receiving_art	3400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.634929	2025-07-01 04:24:04.634929
6586	99	6	2023	estimated_children_needing_art	19000.00	\N	15000.00	24000.00	19000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.645012	2025-07-01 04:24:04.645012
6587	99	6	2023	estimated_children_art_coverage_percent	18.00	\N	14.00	23.00	18.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.655739	2025-07-01 04:24:04.655739
6591	101	6	2023	reported_children_receiving_art	180.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.666483	2025-07-01 04:24:04.666483
6592	101	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.673831	2025-07-01 04:24:04.673831
6593	101	6	2023	estimated_children_art_coverage_percent	54.00	\N	46.00	66.00	54.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.680498	2025-07-01 04:24:04.680498
6594	102	6	2023	reported_children_receiving_art	40.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.688509	2025-07-01 04:24:04.688509
6595	102	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.93064	2025-07-01 04:24:04.93064
6596	102	6	2023	estimated_children_art_coverage_percent	45.00	\N	40.00	50.00	45.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.952155	2025-07-01 04:24:04.952155
6598	103	6	2023	estimated_children_needing_art	2300.00	\N	1900.00	2600.00	2300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.958894	2025-07-01 04:24:04.958894
6606	106	6	2023	reported_children_receiving_art	670.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.967032	2025-07-01 04:24:04.967032
6607	106	6	2023	estimated_children_needing_art	560.00	\N	500.00	770.00	560.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.979151	2025-07-01 04:24:04.979151
6608	106	6	2023	estimated_children_art_coverage_percent	95.00	\N	88.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.988704	2025-07-01 04:24:04.988704
6609	107	6	2023	reported_children_receiving_art	86900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:04.999997	2025-07-01 04:24:04.999997
6610	107	6	2023	estimated_children_needing_art	140000.00	\N	110000.00	190000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.011889	2025-07-01 04:24:05.011889
6611	107	6	2023	estimated_children_art_coverage_percent	60.00	\N	45.00	81.00	60.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.022142	2025-07-01 04:24:05.022142
6612	108	6	2023	reported_children_receiving_art	7900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.03252	2025-07-01 04:24:05.03252
6613	108	6	2023	estimated_children_needing_art	9800.00	\N	8400.00	11000.00	9800.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.043795	2025-07-01 04:24:05.043795
6614	108	6	2023	estimated_children_art_coverage_percent	80.00	\N	69.00	93.00	80.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.055559	2025-07-01 04:24:05.055559
6615	109	6	2023	reported_children_receiving_art	8600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.0684	2025-07-01 04:24:05.0684
6616	109	6	2023	estimated_children_needing_art	11000.00	\N	8700.00	13000.00	11000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.078432	2025-07-01 04:24:05.078432
6617	109	6	2023	estimated_children_art_coverage_percent	78.00	\N	61.00	89.00	78.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.089823	2025-07-01 04:24:05.089823
6618	110	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.102011	2025-07-01 04:24:05.102011
6619	110	6	2023	estimated_children_needing_art	1400.00	\N	1200.00	1600.00	1400.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.112421	2025-07-01 04:24:05.112421
6620	110	6	2023	estimated_children_art_coverage_percent	91.00	\N	80.00	95.00	91.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.12364	2025-07-01 04:24:05.12364
6627	113	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.134722	2025-07-01 04:24:05.134722
6628	113	6	2023	estimated_children_needing_art	500.00	\N	200.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.146797	2025-07-01 04:24:05.146797
6629	113	6	2023	estimated_children_art_coverage_percent	55.00	\N	41.00	76.00	55.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.155067	2025-07-01 04:24:05.155067
6630	114	6	2023	reported_children_receiving_art	1300.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.167084	2025-07-01 04:24:05.167084
6631	114	6	2023	estimated_children_needing_art	2500.00	\N	2100.00	3200.00	2500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.174636	2025-07-01 04:24:05.174636
6632	114	6	2023	estimated_children_art_coverage_percent	52.00	\N	42.00	66.00	52.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.183249	2025-07-01 04:24:05.183249
6633	115	6	2023	reported_children_receiving_art	50200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.194079	2025-07-01 04:24:05.194079
6634	115	6	2023	estimated_children_needing_art	140000.00	\N	91000.00	220000.00	140000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.203348	2025-07-01 04:24:05.203348
6635	115	6	2023	estimated_children_art_coverage_percent	35.00	\N	22.00	53.00	35.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.213436	2025-07-01 04:24:05.213436
6642	118	6	2023	reported_children_receiving_art	610.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.225046	2025-07-01 04:24:05.225046
6643	118	6	2023	estimated_children_needing_art	5500.00	\N	4700.00	6300.00	5500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.235382	2025-07-01 04:24:05.235382
6644	118	6	2023	estimated_children_art_coverage_percent	11.00	\N	10.00	13.00	11.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.24546	2025-07-01 04:24:05.24546
6645	119	6	2023	reported_children_receiving_art	200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.258006	2025-07-01 04:24:05.258006
6646	119	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.268433	2025-07-01 04:24:05.268433
6647	119	6	2023	estimated_children_art_coverage_percent	76.00	\N	69.00	84.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.277702	2025-07-01 04:24:05.277702
6648	120	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.292694	2025-07-01 04:24:05.292694
6649	120	6	2023	estimated_children_needing_art	2900.00	\N	2300.00	3500.00	2900.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.301591	2025-07-01 04:24:05.301591
6650	120	6	2023	estimated_children_art_coverage_percent	49.00	\N	39.00	58.00	49.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.311633	2025-07-01 04:24:05.311633
6651	121	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.322336	2025-07-01 04:24:05.322336
6652	121	6	2023	estimated_children_needing_art	500.00	\N	500.00	640.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.330473	2025-07-01 04:24:05.330473
6653	121	6	2023	estimated_children_art_coverage_percent	43.00	\N	28.00	68.00	43.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.341471	2025-07-01 04:24:05.341471
6654	122	6	2023	reported_children_receiving_art	740.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.352467	2025-07-01 04:24:05.352467
6655	122	6	2023	estimated_children_needing_art	1600.00	\N	1100.00	2300.00	1600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.36296	2025-07-01 04:24:05.36296
6656	122	6	2023	estimated_children_art_coverage_percent	48.00	\N	34.00	70.00	48.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.374943	2025-07-01 04:24:05.374943
6657	123	6	2023	reported_children_receiving_art	90.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.384791	2025-07-01 04:24:05.384791
6658	123	6	2023	estimated_children_needing_art	500.00	\N	500.00	510.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.395451	2025-07-01 04:24:05.395451
6659	123	6	2023	estimated_children_art_coverage_percent	20.00	\N	16.00	25.00	20.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.405461	2025-07-01 04:24:05.405461
6664	125	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.416623	2025-07-01 04:24:05.416623
6666	126	6	2023	reported_children_receiving_art	0.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.432371	2025-07-01 04:24:05.432371
6672	128	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.441224	2025-07-01 04:24:05.441224
6673	128	6	2023	estimated_children_needing_art	500.00	\N	500.00	500.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.451062	2025-07-01 04:24:05.451062
6674	128	6	2023	estimated_children_art_coverage_percent	40.00	\N	30.00	55.00	40.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.461361	2025-07-01 04:24:05.461361
6678	130	6	2023	reported_children_receiving_art	170.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.470613	2025-07-01 04:24:05.470613
6679	130	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.480528	2025-07-01 04:24:05.480528
6680	130	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.491903	2025-07-01 04:24:05.491903
6684	132	6	2023	reported_children_receiving_art	7500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.501736	2025-07-01 04:24:05.501736
6685	132	6	2023	estimated_children_needing_art	12000.00	\N	8900.00	15000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.510365	2025-07-01 04:24:05.510365
6686	132	6	2023	estimated_children_art_coverage_percent	63.00	\N	47.00	80.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.520987	2025-07-01 04:24:05.520987
6687	133	6	2023	reported_children_receiving_art	120.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.530124	2025-07-01 04:24:05.530124
6690	134	6	2023	reported_children_receiving_art	1400.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.54121	2025-07-01 04:24:05.54121
6691	134	6	2023	estimated_children_needing_art	4500.00	\N	3700.00	5100.00	4500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.553055	2025-07-01 04:24:05.553055
6692	134	6	2023	estimated_children_art_coverage_percent	31.00	\N	26.00	35.00	31.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.562431	2025-07-01 04:24:05.562431
6696	136	6	2023	reported_children_receiving_art	1100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.572246	2025-07-01 04:24:05.572246
6697	136	6	2023	estimated_children_needing_art	6600.00	\N	5100.00	8500.00	6600.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.60069	2025-07-01 04:24:05.60069
6698	136	6	2023	estimated_children_art_coverage_percent	17.00	\N	13.00	22.00	17.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.6416	2025-07-01 04:24:05.6416
6708	140	6	2023	reported_children_receiving_art	190.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.683256	2025-07-01 04:24:05.683256
6709	140	6	2023	estimated_children_needing_art	1300.00	\N	1100.00	1800.00	1300.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.694637	2025-07-01 04:24:05.694637
6710	140	6	2023	estimated_children_art_coverage_percent	14.00	\N	12.00	19.00	14.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.736724	2025-07-01 04:24:05.736724
6711	141	6	2023	reported_children_receiving_art	163000.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.778508	2025-07-01 04:24:05.778508
6712	141	6	2023	estimated_children_needing_art	260000.00	\N	200000.00	360000.00	260000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.7892	2025-07-01 04:24:05.7892
6713	141	6	2023	estimated_children_art_coverage_percent	63.00	\N	49.00	87.00	63.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.837744	2025-07-01 04:24:05.837744
6714	142	6	2023	reported_children_receiving_art	1500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.883613	2025-07-01 04:24:05.883613
6715	142	6	2023	estimated_children_needing_art	16000.00	\N	12000.00	21000.00	16000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.896854	2025-07-01 04:24:05.896854
6716	142	6	2023	estimated_children_art_coverage_percent	9.00	\N	7.00	12.00	9.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.909819	2025-07-01 04:24:05.909819
6718	143	6	2023	estimated_children_needing_art	100.00	\N	100.00	200.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.920739	2025-07-01 04:24:05.920739
6723	145	6	2023	reported_children_receiving_art	620.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.933425	2025-07-01 04:24:05.933425
6724	145	6	2023	estimated_children_needing_art	4200.00	\N	2400.00	6800.00	4200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.947378	2025-07-01 04:24:05.947378
6725	145	6	2023	estimated_children_art_coverage_percent	15.00	\N	8.00	23.00	15.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:05.998023	2025-07-01 04:24:05.998023
6726	146	6	2023	reported_children_receiving_art	50.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.012536	2025-07-01 04:24:06.012536
6727	146	6	2023	estimated_children_needing_art	100.00	\N	100.00	100.00	100.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.056753	2025-07-01 04:24:06.056753
6728	146	6	2023	estimated_children_art_coverage_percent	72.00	\N	45.00	95.00	72.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.070288	2025-07-01 04:24:06.070288
6738	150	6	2023	reported_children_receiving_art	750.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.083217	2025-07-01 04:24:06.083217
6739	150	6	2023	estimated_children_needing_art	540.00	\N	500.00	630.00	540.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.102152	2025-07-01 04:24:06.102152
6740	150	6	2023	estimated_children_art_coverage_percent	95.00	\N	95.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.153796	2025-07-01 04:24:06.153796
6741	151	6	2023	reported_children_receiving_art	2600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.171647	2025-07-01 04:24:06.171647
6742	151	6	2023	estimated_children_needing_art	3200.00	\N	2600.00	3800.00	3200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.189326	2025-07-01 04:24:06.189326
6743	151	6	2023	estimated_children_art_coverage_percent	83.00	\N	68.00	95.00	83.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.202287	2025-07-01 04:24:06.202287
6747	153	6	2023	reported_children_receiving_art	4200.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.229382	2025-07-01 04:24:06.229382
6748	153	6	2023	estimated_children_needing_art	12000.00	\N	11000.00	14000.00	12000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.245385	2025-07-01 04:24:06.245385
6749	153	6	2023	estimated_children_art_coverage_percent	34.00	\N	29.00	38.00	34.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.26334	2025-07-01 04:24:06.26334
6762	158	6	2023	reported_children_receiving_art	67100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.276522	2025-07-01 04:24:06.276522
6763	158	6	2023	estimated_children_needing_art	100000.00	\N	88000.00	110000.00	100000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.287751	2025-07-01 04:24:06.287751
6764	158	6	2023	estimated_children_art_coverage_percent	66.00	\N	57.00	74.00	66.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.30469	2025-07-01 04:24:06.30469
6765	159	6	2023	reported_children_receiving_art	820.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.316948	2025-07-01 04:24:06.316948
6766	159	6	2023	estimated_children_needing_art	850.00	\N	750.00	980.00	850.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.329773	2025-07-01 04:24:06.329773
6767	159	6	2023	estimated_children_art_coverage_percent	95.00	\N	84.00	95.00	95.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.342705	2025-07-01 04:24:06.342705
6774	162	6	2023	reported_children_receiving_art	59600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.3578	2025-07-01 04:24:06.3578
6775	162	6	2023	estimated_children_needing_art	92000.00	\N	72000.00	110000.00	92000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.374666	2025-07-01 04:24:06.374666
6776	162	6	2023	estimated_children_art_coverage_percent	65.00	\N	51.00	80.00	65.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.384319	2025-07-01 04:24:06.384319
6780	164	6	2023	reported_children_receiving_art	80.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.402493	2025-07-01 04:24:06.402493
6781	164	6	2023	estimated_children_needing_art	200.00	\N	100.00	200.00	200.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.41962	2025-07-01 04:24:06.41962
6782	164	6	2023	estimated_children_art_coverage_percent	64.00	\N	47.00	90.00	64.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.439224	2025-07-01 04:24:06.439224
6783	165	6	2023	reported_children_receiving_art	5500.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.456171	2025-07-01 04:24:06.456171
6784	165	6	2023	estimated_children_needing_art	6000.00	\N	5600.00	6300.00	6000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.476422	2025-07-01 04:24:06.476422
6785	165	6	2023	estimated_children_art_coverage_percent	93.00	\N	87.00	95.00	93.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.494942	2025-07-01 04:24:06.494942
6789	167	6	2023	reported_children_receiving_art	4600.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.51486	2025-07-01 04:24:06.51486
6790	167	6	2023	estimated_children_needing_art	5000.00	\N	4000.00	5900.00	5000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.533861	2025-07-01 04:24:06.533861
6791	167	6	2023	estimated_children_art_coverage_percent	92.00	\N	74.00	95.00	92.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.55528	2025-07-01 04:24:06.55528
6792	168	6	2023	reported_children_receiving_art	130.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.565302	2025-07-01 04:24:06.565302
6793	168	6	2023	estimated_children_needing_art	500.00	\N	500.00	580.00	500.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.575004	2025-07-01 04:24:06.575004
6794	168	6	2023	estimated_children_art_coverage_percent	33.00	\N	24.00	50.00	33.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.585695	2025-07-01 04:24:06.585695
6795	169	6	2023	reported_children_receiving_art	49100.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.596826	2025-07-01 04:24:06.596826
6796	169	6	2023	estimated_children_needing_art	62000.00	\N	52000.00	74000.00	62000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.605879	2025-07-01 04:24:06.605879
6797	169	6	2023	estimated_children_art_coverage_percent	79.00	\N	65.00	93.00	79.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.615068	2025-07-01 04:24:06.615068
6798	170	6	2023	reported_children_receiving_art	63900.00	\N	\N	\N	\N	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.624391	2025-07-01 04:24:06.624391
6799	170	6	2023	estimated_children_needing_art	84000.00	\N	65000.00	100000.00	84000.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.635259	2025-07-01 04:24:06.635259
6800	170	6	2023	estimated_children_art_coverage_percent	76.00	\N	59.00	93.00	76.00	good	art_pediatric_coverage_by_country_clean.csv	\N	2025-07-01 04:24:06.642748	2025-07-01 04:24:06.642748
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-07-01 04:23:18.131831
2	ART Coverage	\N	\N	2025-07-01 04:23:18.142362
3	People Living with HIV	\N	\N	2025-07-01 04:23:18.152487
4	HIV-related Deaths	\N	\N	2025-07-01 04:23:18.161779
5	HIV Cases Adults 15-49	\N	\N	2025-07-01 04:23:18.173505
6	ART Pediatric Coverage	\N	\N	2025-07-01 04:23:18.183601
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$/vWsCoV0OBYRnlFOQB7Kq.gzw4HpEJN0relocjjHBeUwEiUoMnWdm	admin	0	2025-07-01 04:23:18.10677	2025-07-01 04:23:18.10677
2	userch	$2b$12$U2zUF6EvWuFcn/8zufkpPeMRNzSmYyeEvuIzOvxj8gJfdRnNKQK3.	user	0	2025-07-01 04:23:18.114582	2025-07-01 04:23:18.114582
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

