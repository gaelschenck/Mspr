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
    id_pays integer,
    annee integer,
    valeur integer,
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
    nom_pays character varying(100) NOT NULL,
    region character varying(100),
    sous_region character varying(100)
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
    id_pays integer,
    annee integer,
    valeur integer,
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
    id_pays integer,
    annee integer,
    valeur integer,
    id_unite integer,
    id_type_statistique integer
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
    id_pays integer,
    valeur integer,
    id_unite integer,
    id_type_traitement integer
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
    id integer NOT NULL,
    id_pays integer,
    besoin_arv_min integer,
    besoin_arv_median integer,
    besoin_arv_max integer,
    pourcentage_recu_min integer,
    pourcentage_recu_median integer,
    pourcentage_recu_max integer,
    id_unite integer
);


ALTER TABLE public.transmission_mere_enfant OWNER TO postgres;

--
-- Name: transmission_mere_enfant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transmission_mere_enfant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transmission_mere_enfant_id_seq OWNER TO postgres;

--
-- Name: transmission_mere_enfant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transmission_mere_enfant_id_seq OWNED BY public.transmission_mere_enfant.id;


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
    nom_unite character varying(50) NOT NULL
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
-- Name: transmission_mere_enfant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant ALTER COLUMN id SET DEFAULT nextval('public.transmission_mere_enfant_id_seq'::regclass);


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

COPY public.pays (id_pays, nom_pays, region, sous_region) FROM stdin;
1	afghanistan	eastern mediterranean	\N
2	albania	europe	\N
3	algeria	africa	\N
4	angola	africa	\N
5	argentina	americas	\N
6	armenia	europe	\N
7	australia	western pacific	\N
8	austria	europe	\N
9	azerbaijan	europe	\N
10	bahamas	americas	\N
11	bahrain	eastern mediterranean	\N
12	bangladesh	south-east asia	\N
13	barbados	americas	\N
14	belarus	europe	\N
15	belgium	europe	\N
16	belize	americas	\N
17	benin	africa	\N
18	bhutan	south-east asia	\N
19	bolivia (plurinational state of)	americas	\N
20	bosnia and herzegovina	europe	\N
21	botswana	africa	\N
22	brazil	americas	\N
23	brunei darussalam	western pacific	\N
24	bulgaria	europe	\N
25	burkina faso	africa	\N
26	burundi	africa	\N
27	cabo verde	africa	\N
28	cambodia	western pacific	\N
29	cameroon	africa	\N
30	canada	americas	\N
31	central african republic	africa	\N
32	chad	africa	\N
33	chile	americas	\N
34	china	western pacific	\N
35	colombia	americas	\N
36	comoros	africa	\N
37	congo	americas	\N
38	costa rica	americas	\N
39	côte d'ivoire	africa	\N
40	croatia	europe	\N
41	cuba	americas	\N
42	cyprus	europe	\N
43	czechia	europe	\N
44	democratic people's republic of korea	western pacific	\N
45	democratic republic of the congo	africa	\N
46	denmark	europe	\N
47	djibouti	eastern mediterranean	\N
48	dominican republic	americas	\N
49	ecuador	americas	\N
50	egypt	eastern mediterranean	\N
51	el salvador	americas	\N
52	equatorial guinea	africa	\N
53	eritrea	africa	\N
54	estonia	europe	\N
55	eswatini	africa	\N
56	ethiopia	africa	\N
57	fiji	western pacific	\N
58	finland	europe	\N
59	france	europe	\N
60	gabon	africa	\N
61	gambia	africa	\N
62	georgia	europe	\N
63	germany	europe	\N
64	ghana	africa	\N
65	greece	europe	\N
66	guatemala	americas	\N
67	guinea	africa	\N
68	guinea-bissau	africa	\N
69	guyana	americas	\N
70	haiti	americas	\N
71	honduras	americas	\N
72	hungary	europe	\N
73	iceland	europe	\N
74	india	south-east asia	\N
75	indonesia	south-east asia	\N
76	iran (islamic republic of)	eastern mediterranean	\N
77	ireland	europe	\N
78	israel	europe	\N
79	italy	europe	\N
80	jamaica	americas	\N
81	japan	western pacific	\N
82	jordan	eastern mediterranean	\N
83	kazakhstan	europe	\N
84	kenya	africa	\N
85	kuwait	eastern mediterranean	\N
86	kyrgyzstan	europe	\N
87	lao people's democratic republic	western pacific	\N
88	latvia	europe	\N
89	lebanon	eastern mediterranean	\N
90	lesotho	africa	\N
91	liberia	africa	\N
92	libya	eastern mediterranean	\N
93	lithuania	europe	\N
94	luxembourg	europe	\N
95	madagascar	africa	\N
96	malawi	africa	\N
97	malaysia	western pacific	\N
98	maldives	south-east asia	\N
99	mali	africa	\N
100	malta	europe	\N
101	mauritania	africa	\N
102	mauritius	africa	\N
103	mexico	americas	\N
104	mongolia	western pacific	\N
105	montenegro	europe	\N
106	morocco	eastern mediterranean	\N
107	mozambique	africa	\N
108	myanmar	south-east asia	\N
109	namibia	africa	\N
110	nepal	south-east asia	\N
111	netherlands	europe	\N
112	new zealand	western pacific	\N
113	nicaragua	americas	\N
114	niger	africa	\N
115	nigeria	africa	\N
116	norway	europe	\N
117	oman	eastern mediterranean	\N
118	pakistan	eastern mediterranean	\N
119	panama	americas	\N
120	papua new guinea	western pacific	\N
121	paraguay	americas	\N
122	peru	americas	\N
123	philippines	western pacific	\N
124	poland	europe	\N
125	portugal	europe	\N
126	qatar	eastern mediterranean	\N
127	republic of korea	western pacific	\N
128	republic of moldova	europe	\N
129	republic of north macedonia	europe	\N
130	romania	europe	\N
131	russian federation	europe	\N
132	rwanda	africa	\N
133	saudi arabia	eastern mediterranean	\N
134	senegal	africa	\N
135	serbia	europe	\N
136	sierra leone	africa	\N
137	singapore	western pacific	\N
138	slovakia	europe	\N
139	slovenia	europe	\N
140	somalia	eastern mediterranean	\N
141	south africa	africa	\N
142	south sudan	africa	\N
143	spain	europe	\N
144	sri lanka	south-east asia	\N
145	sudan	eastern mediterranean	\N
146	suriname	americas	\N
147	sweden	europe	\N
148	switzerland	europe	\N
149	syrian arab republic	eastern mediterranean	\N
150	tajikistan	europe	\N
151	thailand	south-east asia	\N
152	timor-leste	south-east asia	\N
153	togo	africa	\N
154	trinidad and tobago	americas	\N
155	tunisia	eastern mediterranean	\N
156	turkey	europe	\N
157	turkmenistan	europe	\N
158	uganda	africa	\N
159	ukraine	europe	\N
160	united arab emirates	eastern mediterranean	\N
161	united kingdom of great britain and northern ireland	europe	\N
162	united republic of tanzania	africa	\N
163	united states of america	americas	\N
164	uruguay	americas	\N
165	uzbekistan	europe	\N
166	venezuela (bolivarian republic of)	americas	\N
167	viet nam	western pacific	\N
168	yemen	eastern mediterranean	\N
169	zambia	africa	\N
170	zimbabwe	africa	\N
\.


--
-- Data for Name: population_hiv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.population_hiv (id, id_pays, annee, valeur, id_unite) FROM stdin;
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

COPY public.transmission_mere_enfant (id, id_pays, besoin_arv_min, besoin_arv_median, besoin_arv_max, pourcentage_recu_min, pourcentage_recu_median, pourcentage_recu_max, id_unite) FROM stdin;
1	1	100	200	500	7	11	18	\N
2	3	500	500	500	69	74	78	\N
3	4	19000	25000	32000	29	38	48	\N
4	5	1600	1800	2000	85	95	95	\N
5	7	100	100	100	0	0	0	\N
6	10	100	100	200	51	58	65	\N
7	12	200	200	200	24	28	33	\N
8	14	200	500	500	67	90	95	\N
9	16	100	100	200	39	44	49	\N
10	17	1600	2600	4300	95	95	95	\N
11	19	500	500	500	95	95	95	\N
12	21	10000	13000	14000	77	95	95	\N
13	25	3600	4900	6100	71	95	95	\N
14	26	3800	5000	6000	61	80	95	\N
15	28	600	730	850	71	85	95	\N
16	29	21000	27000	32000	61	80	94	\N
17	31	3300	4500	5800	52	71	91	\N
18	32	7200	10000	13000	40	56	72	\N
19	33	500	500	500	95	95	95	\N
20	35	1900	2300	2700	17	21	25	\N
21	37	2800	4100	5800	17	25	36	\N
22	39	13000	18000	24000	65	90	95	\N
23	41	200	200	200	86	95	95	\N
24	45	20000	26000	31000	33	44	52	\N
25	47	200	500	500	22	30	39	\N
26	48	690	910	1200	64	84	95	\N
27	49	500	500	620	68	95	95	\N
28	50	500	500	500	15	16	18	\N
29	51	500	500	500	33	40	46	\N
30	52	1800	2600	3500	35	50	68	\N
31	53	500	500	690	34	48	69	\N
32	55	9000	11000	12000	66	79	89	\N
33	56	14000	20000	28000	63	92	95	\N
34	59	1100	1200	1300	0	0	0	\N
35	60	1900	2700	3600	52	72	95	\N
36	61	820	1000	1300	54	68	86	\N
37	63	500	500	500	0	0	0	\N
38	64	12000	16000	21000	58	79	95	\N
39	66	720	790	870	31	34	38	\N
40	67	3800	5100	6600	48	65	84	\N
41	68	1700	2100	2500	38	48	58	\N
42	69	200	200	500	67	89	95	\N
43	70	4700	5900	6800	67	83	95	\N
44	71	500	500	500	48	59	72	\N
45	75	10000	12000	14000	13	15	18	\N
46	76	200	500	840	41	81	95	\N
47	77	100	100	100	0	0	0	\N
48	78	100	100	100	0	0	0	\N
49	79	500	500	500	0	0	0	\N
50	80	500	500	500	95	95	95	\N
51	83	550	610	660	54	59	65	\N
52	84	49000	63000	80000	70	91	95	\N
53	86	200	200	500	69	88	95	\N
54	87	500	500	500	31	35	41	\N
55	90	8200	11000	12000	59	77	89	\N
56	91	1500	2000	2300	70	93	95	\N
57	92	100	200	200	56	63	69	\N
58	95	820	1100	1600	19	25	36	\N
59	96	34000	45000	53000	80	95	95	\N
60	97	500	500	500	86	95	95	\N
61	99	8300	10000	13000	19	24	31	\N
62	101	200	200	200	31	38	47	\N
63	102	100	100	100	95	95	95	\N
64	106	500	500	500	50	61	78	\N
65	107	78000	110000	140000	73	95	95	\N
66	108	4700	5400	6100	69	80	89	\N
67	109	8200	10000	12000	92	95	95	\N
68	110	500	500	500	43	51	60	\N
69	113	200	200	200	73	90	95	\N
70	114	1400	1600	2000	48	58	70	\N
71	115	65000	100000	140000	28	44	62	\N
72	118	2700	3200	3800	8	10	12	\N
73	119	200	500	500	83	92	95	\N
74	120	910	1200	1500	59	79	95	\N
75	121	200	500	500	60	88	95	\N
76	122	880	1100	1500	67	85	95	\N
77	123	500	500	500	15	18	22	\N
78	125	100	200	200	0	0	0	\N
79	128	200	500	500	54	73	95	\N
80	130	200	200	200	95	95	95	\N
81	132	6000	8100	9400	79	95	95	\N
82	134	1800	2200	2500	56	65	75	\N
83	140	500	500	730	14	19	31	\N
84	141	210000	290000	350000	63	87	95	\N
85	142	7200	9900	13000	41	56	74	\N
86	143	200	500	500	0	0	0	\N
87	145	760	2000	3700	2	5	9	\N
88	146	100	100	100	84	95	95	\N
89	150	500	500	560	39	46	56	\N
90	151	3200	3900	4500	81	95	95	\N
91	153	4200	5400	6200	62	80	92	\N
92	158	81000	100000	120000	73	93	95	\N
93	159	1900	2200	2500	89	95	95	\N
94	162	62000	83000	98000	70	93	95	\N
95	164	100	200	200	71	95	95	\N
96	165	1400	1500	1600	33	35	38	\N
97	167	2000	2400	2800	69	81	95	\N
98	168	200	500	500	8	13	20	\N
99	169	38000	48000	57000	94	95	95	\N
100	170	48000	63000	76000	71	94	95	\N
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

COPY public.unite (id_unite, nom_unite) FROM stdin;
1	nombre de personnes
2	pourcentage
3	ratio
4	année
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept) FROM stdin;
1	adminus	$2b$12$9u4R8B98FkP3XJPpgWW/yOC9fafZxqYo95i3X.WivBguKBivMjDRe	admin	0
2	userus	$2b$12$8ErYdW4sj8kEPuyp3NfiQ.IMDjyOhNwdynYPBD1EQWACrlnV8WI2S	user	0
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
-- Name: transmission_mere_enfant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transmission_mere_enfant_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.utilisateur_id_seq', 2, true);


--
-- Name: mortalite mortalite_id_pays_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mortalite
    ADD CONSTRAINT mortalite_id_pays_annee_key UNIQUE (id_pays, annee);


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
-- Name: population_hiv population_hiv_id_pays_annee_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv
    ADD CONSTRAINT population_hiv_id_pays_annee_key UNIQUE (id_pays, annee);


--
-- Name: population_hiv population_hiv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.population_hiv
    ADD CONSTRAINT population_hiv_pkey PRIMARY KEY (id);


--
-- Name: statistique statistique_id_pays_annee_id_type_statistique_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_id_pays_annee_id_type_statistique_key UNIQUE (id_pays, annee, id_type_statistique);


--
-- Name: statistique statistique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistique
    ADD CONSTRAINT statistique_pkey PRIMARY KEY (id);


--
-- Name: traitement traitement_id_pays_id_type_traitement_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_id_pays_id_type_traitement_key UNIQUE (id_pays, id_type_traitement);


--
-- Name: traitement traitement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitement
    ADD CONSTRAINT traitement_pkey PRIMARY KEY (id);


--
-- Name: transmission_mere_enfant transmission_mere_enfant_id_pays_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant
    ADD CONSTRAINT transmission_mere_enfant_id_pays_key UNIQUE (id_pays);


--
-- Name: transmission_mere_enfant transmission_mere_enfant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant
    ADD CONSTRAINT transmission_mere_enfant_pkey PRIMARY KEY (id);


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
-- Name: transmission_mere_enfant transmission_mere_enfant_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transmission_mere_enfant
    ADD CONSTRAINT transmission_mere_enfant_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unite(id_unite);


--
-- PostgreSQL database dump complete
--

