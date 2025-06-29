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
-- Name: mortalite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mortalite (
    id integer NOT NULL,
    id_pays integer NOT NULL,
    annee integer NOT NULL,
    valeur numeric(10,2) NOT NULL,
    id_unite integer
);


ALTER TABLE public.mortalite OWNER TO postgres;

--
-- Name: mortalite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mortalite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mortalite_id_seq OWNER TO postgres;

--
-- Name: mortalite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mortalite_id_seq OWNED BY public.mortalite.id;


--
-- Name: pays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pays (
    id_pays integer NOT NULL,
    pays character varying(100) NOT NULL,
    region_who character varying(100)
);


ALTER TABLE public.pays OWNER TO postgres;

--
-- Name: pays_id_pays_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pays_id_pays_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pays_id_pays_seq OWNER TO postgres;

--
-- Name: pays_id_pays_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pays_id_pays_seq OWNED BY public.pays.id_pays;


--
-- Name: population_hiv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.population_hiv (
    id integer NOT NULL,
    id_pays integer NOT NULL,
    annee integer NOT NULL,
    valeur numeric(10,2) NOT NULL,
    id_unite integer
);


ALTER TABLE public.population_hiv OWNER TO postgres;

--
-- Name: population_hiv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.population_hiv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.population_hiv_id_seq OWNER TO postgres;

--
-- Name: population_hiv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.population_hiv_id_seq OWNED BY public.population_hiv.id;


--
-- Name: statistique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statistique (
    id integer NOT NULL,
    id_pays integer NOT NULL,
    annee integer NOT NULL,
    valeur numeric(10,2) NOT NULL,
    id_unite integer,
    id_type_statistique integer NOT NULL
);


ALTER TABLE public.statistique OWNER TO postgres;

--
-- Name: statistique_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statistique_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.statistique_id_seq OWNER TO postgres;

--
-- Name: statistique_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statistique_id_seq OWNED BY public.statistique.id;


--
-- Name: traitement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traitement (
    id integer NOT NULL,
    id_pays integer NOT NULL,
    valeur numeric(10,2) NOT NULL,
    id_unite integer,
    id_type_traitement integer NOT NULL
);


ALTER TABLE public.traitement OWNER TO postgres;

--
-- Name: traitement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.traitement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.traitement_id_seq OWNER TO postgres;

--
-- Name: traitement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.traitement_id_seq OWNED BY public.traitement.id;


--
-- Name: transmission_mere_enfant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transmission_mere_enfant (
    id_transmission integer NOT NULL,
    id_pays integer NOT NULL,
    besoin_arv_min numeric(10,2) NOT NULL,
    besoin_arv_median numeric(10,2) NOT NULL,
    besoin_arv_max numeric(10,2) NOT NULL,
    pourcentage_recu_min numeric(5,2) NOT NULL,
    pourcentage_recu_median numeric(5,2) NOT NULL,
    pourcentage_recu_max numeric(5,2) NOT NULL
);


ALTER TABLE public.transmission_mere_enfant OWNER TO postgres;

--
-- Name: transmission_mere_enfant_id_transmission_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transmission_mere_enfant_id_transmission_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transmission_mere_enfant_id_transmission_seq OWNER TO postgres;

--
-- Name: transmission_mere_enfant_id_transmission_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transmission_mere_enfant_id_transmission_seq OWNED BY public.transmission_mere_enfant.id_transmission;


--
-- Name: type_statistique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_statistique (
    id_type_statistique integer NOT NULL,
    nom_type_statistique character varying(100) NOT NULL
);


ALTER TABLE public.type_statistique OWNER TO postgres;

--
-- Name: type_statistique_id_type_statistique_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.type_statistique_id_type_statistique_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.type_statistique_id_type_statistique_seq OWNER TO postgres;

--
-- Name: type_statistique_id_type_statistique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.type_statistique_id_type_statistique_seq OWNED BY public.type_statistique.id_type_statistique;


--
-- Name: type_traitement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_traitement (
    id_type_traitement integer NOT NULL,
    nom_type_traitement character varying(100) NOT NULL
);


ALTER TABLE public.type_traitement OWNER TO postgres;

--
-- Name: type_traitement_id_type_traitement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.type_traitement_id_type_traitement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.type_traitement_id_type_traitement_seq OWNER TO postgres;

--
-- Name: type_traitement_id_type_traitement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.type_traitement_id_type_traitement_seq OWNED BY public.type_traitement.id_type_traitement;


--
-- Name: unite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unite (
    id_unite integer NOT NULL,
    unite character varying(50) NOT NULL
);


ALTER TABLE public.unite OWNER TO postgres;

--
-- Name: unite_id_unite_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unite_id_unite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unite_id_unite_seq OWNER TO postgres;

--
-- Name: unite_id_unite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unite_id_unite_seq OWNED BY public.unite.id_unite;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id integer NOT NULL,
    username character varying NOT NULL,
    hashed_password character varying NOT NULL,
    role character varying NOT NULL,
    rgpd_accept integer DEFAULT 0 NOT NULL
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
-- Name: mortalite id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mortalite ALTER COLUMN id SET DEFAULT nextval('public.mortalite_id_seq'::regclass);


--
-- Name: pays id_pays; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pays ALTER COLUMN id_pays SET DEFAULT nextval('public.pays_id_pays_seq'::regclass);


--
-- Name: population_hiv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv ALTER COLUMN id SET DEFAULT nextval('public.population_hiv_id_seq'::regclass);


--
-- Name: statistique id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique ALTER COLUMN id SET DEFAULT nextval('public.statistique_id_seq'::regclass);


--
-- Name: traitement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement ALTER COLUMN id SET DEFAULT nextval('public.traitement_id_seq'::regclass);


--
-- Name: transmission_mere_enfant id_transmission; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant ALTER COLUMN id_transmission SET DEFAULT nextval('public.transmission_mere_enfant_id_transmission_seq'::regclass);


--
-- Name: type_statistique id_type_statistique; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_statistique ALTER COLUMN id_type_statistique SET DEFAULT nextval('public.type_statistique_id_type_statistique_seq'::regclass);


--
-- Name: type_traitement id_type_traitement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_traitement ALTER COLUMN id_type_traitement SET DEFAULT nextval('public.type_traitement_id_type_traitement_seq'::regclass);


--
-- Name: unite id_unite; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unite ALTER COLUMN id_unite SET DEFAULT nextval('public.unite_id_unite_seq'::regclass);


--
-- Name: utilisateur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_id_seq'::regclass);


--
-- Data for Name: mortalite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mortalite (id, id_pays, annee, valeur, id_unite) FROM stdin;
\.


--
-- Data for Name: pays; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pays (id_pays, pays, region_who) FROM stdin;
1	afghanistan	eastern mediterranean
2	albania	europe
3	algeria	africa
4	angola	africa
5	argentina	americas
6	armenia	europe
7	australia	western pacific
8	austria	europe
9	azerbaijan	europe
10	bahamas	americas
11	bahrain	eastern mediterranean
12	bangladesh	south-east asia
13	barbados	americas
14	belarus	europe
15	belgium	europe
16	belize	americas
17	benin	africa
18	bhutan	south-east asia
19	bolivia (plurinational state of)	americas
20	bosnia and herzegovina	europe
21	botswana	africa
22	brazil	americas
23	brunei darussalam	western pacific
24	bulgaria	europe
25	burkina faso	africa
26	burundi	africa
27	cabo verde	africa
28	cambodia	western pacific
29	cameroon	africa
30	canada	americas
31	central african republic	africa
32	chad	africa
33	chile	americas
34	china	western pacific
35	colombia	americas
36	comoros	africa
37	congo	americas
38	costa rica	americas
39	côte d'ivoire	africa
40	croatia	europe
41	cuba	americas
42	cyprus	europe
43	czechia	europe
44	democratic people's republic of korea	western pacific
45	democratic republic of the congo	africa
46	denmark	europe
47	djibouti	eastern mediterranean
48	dominican republic	americas
49	ecuador	americas
50	egypt	eastern mediterranean
51	el salvador	americas
52	equatorial guinea	africa
53	eritrea	africa
54	estonia	europe
55	eswatini	africa
56	ethiopia	africa
57	fiji	western pacific
58	finland	europe
59	france	europe
60	gabon	africa
61	gambia	africa
62	georgia	europe
63	germany	europe
64	ghana	africa
65	greece	europe
66	guatemala	americas
67	guinea	africa
68	guinea-bissau	africa
69	guyana	americas
70	haiti	americas
71	honduras	americas
72	hungary	europe
73	iceland	europe
74	india	south-east asia
75	indonesia	south-east asia
76	iran (islamic republic of)	eastern mediterranean
77	ireland	europe
78	israel	europe
79	italy	europe
80	jamaica	americas
81	japan	western pacific
82	jordan	eastern mediterranean
83	kazakhstan	europe
84	kenya	africa
85	kuwait	eastern mediterranean
86	kyrgyzstan	europe
87	lao people's democratic republic	western pacific
88	latvia	europe
89	lebanon	eastern mediterranean
90	lesotho	africa
91	liberia	africa
92	libya	eastern mediterranean
93	lithuania	europe
94	luxembourg	europe
95	madagascar	africa
96	malawi	africa
97	malaysia	western pacific
98	maldives	south-east asia
99	mali	africa
100	malta	europe
101	mauritania	africa
102	mauritius	africa
103	mexico	americas
104	mongolia	western pacific
105	montenegro	europe
106	morocco	eastern mediterranean
107	mozambique	africa
108	myanmar	south-east asia
109	namibia	africa
110	nepal	south-east asia
111	netherlands	europe
112	new zealand	western pacific
113	nicaragua	americas
114	niger	africa
115	nigeria	africa
116	norway	europe
117	oman	eastern mediterranean
118	pakistan	eastern mediterranean
119	panama	americas
120	papua new guinea	western pacific
121	paraguay	americas
122	peru	americas
123	philippines	western pacific
124	poland	europe
125	portugal	europe
126	qatar	eastern mediterranean
127	republic of korea	western pacific
128	republic of moldova	europe
129	republic of north macedonia	europe
130	romania	europe
131	russian federation	europe
132	rwanda	africa
133	saudi arabia	eastern mediterranean
134	senegal	africa
135	serbia	europe
136	sierra leone	africa
137	singapore	western pacific
138	slovakia	europe
139	slovenia	europe
140	somalia	eastern mediterranean
141	south africa	africa
142	south sudan	africa
143	spain	europe
144	sri lanka	south-east asia
145	sudan	eastern mediterranean
146	suriname	americas
147	sweden	europe
148	switzerland	europe
149	syrian arab republic	eastern mediterranean
150	tajikistan	europe
151	thailand	south-east asia
152	timor-leste	south-east asia
153	togo	africa
154	trinidad and tobago	americas
155	tunisia	eastern mediterranean
156	turkey	europe
157	turkmenistan	europe
158	uganda	africa
159	ukraine	europe
160	united arab emirates	eastern mediterranean
161	united kingdom of great britain and northern ireland	europe
162	united republic of tanzania	africa
163	united states of america	americas
164	uruguay	americas
165	uzbekistan	europe
166	venezuela (bolivarian republic of)	americas
167	viet nam	western pacific
168	yemen	eastern mediterranean
169	zambia	africa
170	zimbabwe	africa
\.


--
-- Data for Name: population_hiv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.population_hiv (id, id_pays, annee, valeur, id_unite) FROM stdin;
1	1	2018	7200.00	1
2	3	2018	16000.00	1
3	4	2018	330000.00	1
4	5	2018	140000.00	1
5	6	2018	3500.00	1
6	7	2018	28000.00	1
7	10	2018	6000.00	1
8	12	2018	14000.00	1
9	13	2018	3000.00	1
10	14	2018	27000.00	1
11	16	2018	4900.00	1
12	17	2018	73000.00	1
13	18	2018	1300.00	1
14	19	2018	22000.00	1
15	20	2018	500.00	1
16	21	2018	370000.00	1
17	22	2018	900000.00	1
18	24	2018	3500.00	1
19	25	2018	96000.00	1
20	26	2018	82000.00	1
21	27	2018	2400.00	1
22	28	2018	73000.00	1
23	29	2018	540000.00	1
24	31	2018	110000.00	1
25	32	2018	120000.00	1
26	33	2018	71000.00	1
27	35	2018	160000.00	1
28	36	2018	200.00	1
29	37	2018	89000.00	1
30	38	2018	15000.00	1
31	39	2018	460000.00	1
32	40	2018	1600.00	1
33	41	2018	31000.00	1
34	43	2018	4400.00	1
35	45	2018	450000.00	1
36	46	2018	6200.00	1
37	47	2018	8800.00	1
38	48	2018	70000.00	1
39	49	2018	44000.00	1
40	50	2018	22000.00	1
41	51	2018	25000.00	1
42	52	2018	62000.00	1
43	53	2018	18000.00	1
44	54	2018	7400.00	1
45	55	2018	210000.00	1
46	56	2018	690000.00	1
47	58	2018	4000.00	1
48	59	2018	180000.00	1
49	60	2018	53000.00	1
50	61	2018	26000.00	1
51	62	2018	9400.00	1
52	63	2018	87000.00	1
53	64	2018	330000.00	1
54	66	2018	47000.00	1
55	67	2018	120000.00	1
56	68	2018	44000.00	1
57	69	2018	8200.00	1
58	70	2018	160000.00	1
59	71	2018	23000.00	1
60	72	2018	3700.00	1
61	73	2018	500.00	1
62	75	2018	640000.00	1
63	76	2018	61000.00	1
64	77	2018	7200.00	1
65	78	2018	9000.00	1
66	79	2018	130000.00	1
67	80	2018	40000.00	1
68	81	2018	30000.00	1
69	82	2018	500.00	1
70	83	2018	26000.00	1
71	84	2018	1600000.00	1
72	85	2018	640.00	1
73	86	2018	8500.00	1
74	87	2018	12000.00	1
75	88	2018	5300.00	1
76	89	2018	2500.00	1
77	90	2018	340000.00	1
78	91	2018	39000.00	1
79	92	2018	9200.00	1
80	94	2018	1200.00	1
81	95	2018	39000.00	1
82	96	2018	1000000.00	1
83	97	2018	87000.00	1
84	99	2018	150000.00	1
85	101	2018	5600.00	1
86	102	2018	13000.00	1
87	103	2018	230000.00	1
88	104	2018	600.00	1
89	105	2018	500.00	1
90	106	2018	21000.00	1
91	107	2018	2200000.00	1
92	108	2018	240000.00	1
93	109	2018	200000.00	1
94	110	2018	30000.00	1
95	112	2018	3600.00	1
96	113	2018	9400.00	1
97	114	2018	36000.00	1
98	115	2018	1900000.00	1
99	116	2018	5800.00	1
100	117	2018	3200.00	1
101	118	2018	160000.00	1
102	119	2018	26000.00	1
103	120	2018	45000.00	1
104	121	2018	21000.00	1
105	122	2018	79000.00	1
106	123	2018	77000.00	1
107	125	2018	41000.00	1
108	128	2018	17000.00	1
109	129	2018	500.00	1
110	130	2018	18000.00	1
111	132	2018	220000.00	1
112	134	2018	42000.00	1
113	135	2018	3000.00	1
114	136	2018	70000.00	1
115	137	2018	7900.00	1
116	138	2018	1200.00	1
117	140	2018	11000.00	1
118	141	2018	7700000.00	1
119	142	2018	190000.00	1
120	143	2018	150000.00	1
121	144	2018	3500.00	1
122	145	2018	59000.00	1
123	146	2018	5600.00	1
124	149	2018	660.00	1
125	150	2018	13000.00	1
126	151	2018	480000.00	1
127	153	2018	110000.00	1
128	155	2018	2800.00	1
129	158	2018	1400000.00	1
130	159	2018	240000.00	1
131	162	2018	1600000.00	1
132	164	2018	14000.00	1
133	165	2018	52000.00	1
134	166	2018	120000.00	1
135	167	2018	230000.00	1
136	168	2018	11000.00	1
137	169	2018	1200000.00	1
138	170	2018	1300000.00	1
139	1	2010	4200.00	1
140	3	2010	7100.00	1
141	4	2010	220000.00	1
142	5	2010	110000.00	1
143	6	2010	3300.00	1
144	7	2010	21000.00	1
145	10	2010	5800.00	1
146	12	2010	7700.00	1
147	13	2010	2300.00	1
148	14	2010	12000.00	1
149	16	2010	3700.00	1
150	17	2010	61000.00	1
151	18	2010	1300.00	1
152	19	2010	23000.00	1
153	20	2010	200.00	1
154	21	2010	340000.00	1
155	22	2010	670000.00	1
156	24	2010	1700.00	1
157	25	2010	110000.00	1
158	26	2010	93000.00	1
159	27	2010	2100.00	1
160	28	2010	79000.00	1
161	29	2010	520000.00	1
162	31	2010	140000.00	1
163	32	2010	99000.00	1
164	33	2010	39000.00	1
165	35	2010	130000.00	1
166	36	2010	200.00	1
167	37	2010	82000.00	1
168	38	2010	9300.00	1
169	39	2010	480000.00	1
170	40	2010	1000.00	1
171	41	2010	17000.00	1
172	43	2010	1800.00	1
173	45	2010	480000.00	1
174	46	2010	5500.00	1
175	47	2010	9400.00	1
176	48	2010	72000.00	1
177	49	2010	34000.00	1
178	50	2010	6800.00	1
179	51	2010	26000.00	1
180	52	2010	35000.00	1
181	53	2010	17000.00	1
182	54	2010	6000.00	1
183	55	2010	160000.00	1
184	56	2010	630000.00	1
185	58	2010	2700.00	1
186	59	2010	140000.00	1
187	60	2010	43000.00	1
188	61	2010	18000.00	1
189	62	2010	5600.00	1
190	63	2010	69000.00	1
191	64	2010	300000.00	1
192	66	2010	49000.00	1
193	67	2010	100000.00	1
194	68	2010	38000.00	1
195	69	2010	6700.00	1
196	70	2010	140000.00	1
197	71	2010	26000.00	1
198	72	2010	2000.00	1
199	73	2010	500.00	1
200	75	2010	510000.00	1
201	76	2010	50000.00	1
202	77	2010	4800.00	1
203	78	2010	6000.00	1
204	79	2010	110000.00	1
205	80	2010	37000.00	1
206	81	2010	19000.00	1
207	82	2010	200.00	1
208	83	2010	11000.00	1
209	84	2010	1500000.00	1
210	85	2010	500.00	1
211	86	2010	4100.00	1
212	87	2010	9900.00	1
213	88	2010	4000.00	1
214	89	2010	1600.00	1
215	90	2010	300000.00	1
216	91	2010	41000.00	1
217	92	2010	6100.00	1
218	94	2010	700.00	1
219	95	2010	21000.00	1
220	96	2010	870000.00	1
221	97	2010	74000.00	1
222	99	2010	120000.00	1
223	101	2010	7100.00	1
224	102	2010	11000.00	1
225	103	2010	180000.00	1
226	104	2010	500.00	1
227	105	2010	200.00	1
228	106	2010	17000.00	1
229	107	2010	1600000.00	1
230	108	2010	220000.00	1
231	109	2010	170000.00	1
232	110	2010	31000.00	1
233	111	2010	20000.00	1
234	112	2010	2500.00	1
235	113	2010	7900.00	1
236	114	2010	37000.00	1
237	115	2010	1500000.00	1
238	116	2010	4200.00	1
239	117	2010	2200.00	1
240	118	2010	67000.00	1
241	119	2010	20000.00	1
242	120	2010	38000.00	1
243	121	2010	20000.00	1
244	122	2010	65000.00	1
245	123	2010	15000.00	1
246	125	2010	40000.00	1
247	128	2010	16000.00	1
248	129	2010	200.00	1
249	130	2010	14000.00	1
250	132	2010	220000.00	1
251	134	2010	44000.00	1
252	135	2010	1800.00	1
253	136	2010	58000.00	1
254	137	2010	6500.00	1
255	138	2010	500.00	1
256	140	2010	17000.00	1
257	141	2010	6100000.00	1
258	142	2010	140000.00	1
259	143	2010	140000.00	1
260	144	2010	4000.00	1
261	145	2010	43000.00	1
262	146	2010	4600.00	1
263	149	2010	570.00	1
264	150	2010	9200.00	1
265	151	2010	580000.00	1
266	153	2010	100000.00	1
267	155	2010	1400.00	1
268	158	2010	1200000.00	1
269	159	2010	230000.00	1
270	162	2010	1300000.00	1
271	163	2010	990000.00	1
272	164	2010	9600.00	1
273	165	2010	30000.00	1
274	167	2010	220000.00	1
275	168	2010	5100.00	1
276	169	2010	1000000.00	1
277	170	2010	1200000.00	1
278	1	2005	2900.00	1
279	3	2005	3700.00	1
280	4	2005	150000.00	1
281	5	2005	85000.00	1
282	6	2005	2700.00	1
283	7	2005	16000.00	1
284	10	2005	5100.00	1
285	12	2005	4000.00	1
286	13	2005	1700.00	1
287	14	2005	5400.00	1
288	16	2005	2800.00	1
289	17	2005	56000.00	1
290	18	2005	1100.00	1
291	19	2005	26000.00	1
292	20	2005	200.00	1
293	21	2005	310000.00	1
294	22	2005	550000.00	1
295	24	2005	980.00	1
296	25	2005	120000.00	1
297	26	2005	110000.00	1
298	27	2005	1800.00	1
299	28	2005	82000.00	1
300	29	2005	470000.00	1
301	31	2005	150000.00	1
302	32	2005	88000.00	1
303	33	2005	25000.00	1
304	35	2005	120000.00	1
305	36	2005	100.00	1
306	37	2005	77000.00	1
307	38	2005	6500.00	1
308	39	2005	510000.00	1
309	40	2005	710.00	1
310	41	2005	9000.00	1
311	43	2005	970.00	1
312	45	2005	510000.00	1
313	46	2005	4900.00	1
314	47	2005	11000.00	1
315	48	2005	79000.00	1
316	49	2005	29000.00	1
317	50	2005	3200.00	1
318	51	2005	23000.00	1
319	52	2005	22000.00	1
320	53	2005	17000.00	1
321	54	2005	5400.00	1
322	55	2005	130000.00	1
323	56	2005	640000.00	1
324	58	2005	1900.00	1
325	59	2005	110000.00	1
326	60	2005	35000.00	1
327	61	2005	15000.00	1
328	62	2005	2800.00	1
329	63	2005	56000.00	1
330	64	2005	280000.00	1
331	66	2005	48000.00	1
332	67	2005	93000.00	1
333	68	2005	31000.00	1
334	69	2005	5000.00	1
335	70	2005	140000.00	1
336	71	2005	31000.00	1
337	72	2005	1200.00	1
338	73	2005	200.00	1
339	75	2005	290000.00	1
340	76	2005	37000.00	1
341	77	2005	3200.00	1
342	78	2005	4100.00	1
343	79	2005	89000.00	1
344	80	2005	38000.00	1
345	81	2005	12000.00	1
346	82	2005	200.00	1
347	83	2005	4000.00	1
348	84	2005	1500000.00	1
349	85	2005	500.00	1
350	86	2005	1500.00	1
351	87	2005	6700.00	1
352	88	2005	3200.00	1
353	89	2005	1300.00	1
354	90	2005	280000.00	1
355	91	2005	41000.00	1
356	92	2005	2900.00	1
357	94	2005	500.00	1
358	95	2005	19000.00	1
359	96	2005	820000.00	1
360	97	2005	66000.00	1
361	99	2005	110000.00	1
362	101	2005	7500.00	1
363	102	2005	8000.00	1
364	103	2005	150000.00	1
365	104	2005	500.00	1
\.


--
-- Data for Name: statistique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statistique (id, id_pays, annee, valeur, id_unite, id_type_statistique) FROM stdin;
\.


--
-- Data for Name: traitement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traitement (id, id_pays, valeur, id_unite, id_type_traitement) FROM stdin;
\.


--
-- Data for Name: transmission_mere_enfant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transmission_mere_enfant (id_transmission, id_pays, besoin_arv_min, besoin_arv_median, besoin_arv_max, pourcentage_recu_min, pourcentage_recu_median, pourcentage_recu_max) FROM stdin;
\.


--
-- Data for Name: type_statistique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_statistique (id_type_statistique, nom_type_statistique) FROM stdin;
1	taux de prévalence
2	taux de mortalité
3	taux de transmission mère-enfant
4	taux de couverture traitement
5	taux de nouvelles infections
\.


--
-- Data for Name: type_traitement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_traitement (id_type_traitement, nom_type_traitement) FROM stdin;
1	traitement adulte
2	traitement pédiatrique
3	traitement prévention transmission
\.


--
-- Data for Name: unite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unite (id_unite, unite) FROM stdin;
1	nombre de personnes
2	pourcentage
3	ratio
4	année
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept) FROM stdin;
\.


--
-- Name: mortalite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mortalite_id_seq', 1, false);


--
-- Name: pays_id_pays_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pays_id_pays_seq', 1, false);


--
-- Name: population_hiv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.population_hiv_id_seq', 1, false);


--
-- Name: statistique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statistique_id_seq', 1, false);


--
-- Name: traitement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.traitement_id_seq', 1, false);


--
-- Name: transmission_mere_enfant_id_transmission_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transmission_mere_enfant_id_transmission_seq', 1, false);


--
-- Name: type_statistique_id_type_statistique_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_statistique_id_type_statistique_seq', 1, false);


--
-- Name: type_traitement_id_type_traitement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_traitement_id_type_traitement_seq', 1, false);


--
-- Name: unite_id_unite_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unite_id_unite_seq', 1, false);


--
-- Name: utilisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_seq', 1, false);


--
-- Name: mortalite mortalite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mortalite
    ADD CONSTRAINT mortalite_pkey PRIMARY KEY (id);


--
-- Name: pays pays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pays
    ADD CONSTRAINT pays_pkey PRIMARY KEY (id_pays);


--
-- Name: population_hiv population_hiv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv
    ADD CONSTRAINT population_hiv_pkey PRIMARY KEY (id);


--
-- Name: statistique statistique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_pkey PRIMARY KEY (id);


--
-- Name: traitement traitement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_pkey PRIMARY KEY (id);


--
-- Name: transmission_mere_enfant transmission_mere_enfant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant
    ADD CONSTRAINT transmission_mere_enfant_pkey PRIMARY KEY (id_transmission);


--
-- Name: type_statistique type_statistique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_statistique
    ADD CONSTRAINT type_statistique_pkey PRIMARY KEY (id_type_statistique);


--
-- Name: type_traitement type_traitement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_traitement
    ADD CONSTRAINT type_traitement_pkey PRIMARY KEY (id_type_traitement);


--
-- Name: unite unite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unite
    ADD CONSTRAINT unite_pkey PRIMARY KEY (id_unite);


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
-- Name: idx_mortalite_annee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mortalite_annee ON public.mortalite USING btree (annee);


--
-- Name: idx_mortalite_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mortalite_pays ON public.mortalite USING btree (id_pays);


--
-- Name: idx_pays_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pays_pays ON public.pays USING btree (pays);


--
-- Name: idx_population_hiv_annee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_population_hiv_annee ON public.population_hiv USING btree (annee);


--
-- Name: idx_population_hiv_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_population_hiv_pays ON public.population_hiv USING btree (id_pays);


--
-- Name: idx_statistique_annee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_statistique_annee ON public.statistique USING btree (annee);


--
-- Name: idx_statistique_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_statistique_pays ON public.statistique USING btree (id_pays);


--
-- Name: idx_traitement_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_traitement_pays ON public.traitement USING btree (id_pays);


--
-- Name: idx_transmission_pays; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transmission_pays ON public.transmission_mere_enfant USING btree (id_pays);


--
-- Name: idx_utilisateur_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_utilisateur_username ON public.utilisateur USING btree (username);


--
-- Name: mortalite mortalite_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mortalite
    ADD CONSTRAINT mortalite_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


--
-- Name: mortalite mortalite_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mortalite
    ADD CONSTRAINT mortalite_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unite(id_unite);


--
-- Name: population_hiv population_hiv_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv
    ADD CONSTRAINT population_hiv_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


--
-- Name: population_hiv population_hiv_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv
    ADD CONSTRAINT population_hiv_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unite(id_unite);


--
-- Name: statistique statistique_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


--
-- Name: statistique statistique_id_type_statistique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_id_type_statistique_fkey FOREIGN KEY (id_type_statistique) REFERENCES public.type_statistique(id_type_statistique);


--
-- Name: statistique statistique_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unite(id_unite);


--
-- Name: traitement traitement_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


--
-- Name: traitement traitement_id_type_traitement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_id_type_traitement_fkey FOREIGN KEY (id_type_traitement) REFERENCES public.type_traitement(id_type_traitement);


--
-- Name: traitement traitement_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unite(id_unite);


--
-- Name: transmission_mere_enfant transmission_mere_enfant_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant
    ADD CONSTRAINT transmission_mere_enfant_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


--
-- PostgreSQL database dump complete
--

