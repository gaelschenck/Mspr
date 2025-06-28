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

COPY public.transmission_mere_enfant (id_transmission, id_pays, besoin_arv_min, besoin_arv_median, besoin_arv_max, pourcentage_recu_min, pourcentage_recu_median, pourcentage_recu_max) FROM stdin;
\.


--
-- Data for Name: type_statistique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_statistique (id_type_statistique, nom_type_statistique) FROM stdin;
\.


--
-- Data for Name: type_traitement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_traitement (id_type_traitement, nom_type_traitement) FROM stdin;
\.


--
-- Data for Name: unite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unite (id_unite, unite) FROM stdin;
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

