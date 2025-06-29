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
1	Afghanistan	Eastern Mediterranean	\N	2025-06-29 15:03:40.857841	2025-06-29 15:03:40.857841
2	Albania	Europe	\N	2025-06-29 15:03:40.873813	2025-06-29 15:03:40.873813
3	Algeria	Africa	\N	2025-06-29 15:03:40.890782	2025-06-29 15:03:40.890782
4	Angola	Africa	\N	2025-06-29 15:03:40.901443	2025-06-29 15:03:40.901443
5	Argentina	Americas	\N	2025-06-29 15:03:40.911882	2025-06-29 15:03:40.911882
6	Armenia	Europe	\N	2025-06-29 15:03:40.92228	2025-06-29 15:03:40.92228
7	Australia	Western Pacific	\N	2025-06-29 15:03:40.933769	2025-06-29 15:03:40.933769
8	Austria	Europe	\N	2025-06-29 15:03:40.946368	2025-06-29 15:03:40.946368
9	Azerbaijan	Europe	\N	2025-06-29 15:03:40.958018	2025-06-29 15:03:40.958018
10	Bahamas	Americas	\N	2025-06-29 15:03:40.972257	2025-06-29 15:03:40.972257
11	Bahrain	Eastern Mediterranean	\N	2025-06-29 15:03:40.99365	2025-06-29 15:03:40.99365
12	Bangladesh	South-East Asia	\N	2025-06-29 15:03:41.006368	2025-06-29 15:03:41.006368
13	Barbados	Americas	\N	2025-06-29 15:03:41.021928	2025-06-29 15:03:41.021928
14	Belarus	Europe	\N	2025-06-29 15:03:41.035602	2025-06-29 15:03:41.035602
15	Belgium	Europe	\N	2025-06-29 15:03:41.053404	2025-06-29 15:03:41.053404
16	Belize	Americas	\N	2025-06-29 15:03:41.071416	2025-06-29 15:03:41.071416
17	Benin	Africa	\N	2025-06-29 15:03:41.090035	2025-06-29 15:03:41.090035
18	Bhutan	South-East Asia	\N	2025-06-29 15:03:41.103355	2025-06-29 15:03:41.103355
19	Bolivia	Americas	\N	2025-06-29 15:03:41.117144	2025-06-29 15:03:41.117144
20	Bosnia and Herzegovina	Europe	\N	2025-06-29 15:03:41.128416	2025-06-29 15:03:41.128416
21	Botswana	Africa	\N	2025-06-29 15:03:41.139528	2025-06-29 15:03:41.139528
22	Brazil	Americas	\N	2025-06-29 15:03:41.154559	2025-06-29 15:03:41.154559
23	Brunei Darussalam	Western Pacific	\N	2025-06-29 15:03:41.166739	2025-06-29 15:03:41.166739
24	Bulgaria	Europe	\N	2025-06-29 15:03:41.176961	2025-06-29 15:03:41.176961
25	Burkina Faso	Africa	\N	2025-06-29 15:03:41.219476	2025-06-29 15:03:41.219476
26	Burundi	Africa	\N	2025-06-29 15:03:41.227048	2025-06-29 15:03:41.227048
27	Cabo Verde	Africa	\N	2025-06-29 15:03:41.266786	2025-06-29 15:03:41.266786
28	Cambodia	Western Pacific	\N	2025-06-29 15:03:41.275578	2025-06-29 15:03:41.275578
29	Cameroon	Africa	\N	2025-06-29 15:03:41.286949	2025-06-29 15:03:41.286949
30	Canada	Americas	\N	2025-06-29 15:03:41.298005	2025-06-29 15:03:41.298005
31	Central African Republic	Africa	\N	2025-06-29 15:03:41.30702	2025-06-29 15:03:41.30702
32	Chad	Africa	\N	2025-06-29 15:03:41.314935	2025-06-29 15:03:41.314935
33	Chile	Americas	\N	2025-06-29 15:03:41.333973	2025-06-29 15:03:41.333973
34	China	Western Pacific	\N	2025-06-29 15:03:41.342345	2025-06-29 15:03:41.342345
35	Colombia	Americas	\N	2025-06-29 15:03:41.363938	2025-06-29 15:03:41.363938
36	Comoros	Africa	\N	2025-06-29 15:03:41.370825	2025-06-29 15:03:41.370825
37	Congo	Americas	\N	2025-06-29 15:03:41.395242	2025-06-29 15:03:41.395242
38	Costa Rica	Americas	\N	2025-06-29 15:03:41.406111	2025-06-29 15:03:41.406111
39	Côte d'Ivoire	Africa	\N	2025-06-29 15:03:41.443675	2025-06-29 15:03:41.443675
40	Croatia	Europe	\N	2025-06-29 15:03:41.472914	2025-06-29 15:03:41.472914
41	Cuba	Americas	\N	2025-06-29 15:03:41.482409	2025-06-29 15:03:41.482409
42	Cyprus	Europe	\N	2025-06-29 15:03:41.490019	2025-06-29 15:03:41.490019
43	Czechia	Europe	\N	2025-06-29 15:03:41.500117	2025-06-29 15:03:41.500117
44	North Korea	Western Pacific	\N	2025-06-29 15:03:41.513827	2025-06-29 15:03:41.513827
45	DR Congo	Africa	\N	2025-06-29 15:03:41.521599	2025-06-29 15:03:41.521599
46	Denmark	Europe	\N	2025-06-29 15:03:41.533208	2025-06-29 15:03:41.533208
47	Djibouti	Eastern Mediterranean	\N	2025-06-29 15:03:41.539664	2025-06-29 15:03:41.539664
48	Dominican Republic	Americas	\N	2025-06-29 15:03:41.548375	2025-06-29 15:03:41.548375
49	Ecuador	Americas	\N	2025-06-29 15:03:41.556373	2025-06-29 15:03:41.556373
50	Egypt	Eastern Mediterranean	\N	2025-06-29 15:03:41.569801	2025-06-29 15:03:41.569801
51	El Salvador	Americas	\N	2025-06-29 15:03:41.576756	2025-06-29 15:03:41.576756
52	Equatorial Guinea	Africa	\N	2025-06-29 15:03:41.583716	2025-06-29 15:03:41.583716
53	Eritrea	Africa	\N	2025-06-29 15:03:41.590543	2025-06-29 15:03:41.590543
54	Estonia	Europe	\N	2025-06-29 15:03:41.599141	2025-06-29 15:03:41.599141
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
\.


--
-- Data for Name: indicator_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.indicator_types (id, name, description, unit, created_at) FROM stdin;
1	Prevention of Mother-to-Child Transmission	\N	\N	2025-06-29 15:03:40.777365
2	ART Coverage	\N	\N	2025-06-29 15:03:40.801037
3	People Living with HIV	\N	\N	2025-06-29 15:03:40.810173
4	HIV-related Deaths	\N	\N	2025-06-29 15:03:40.819564
5	HIV Cases Adults 15-49	\N	\N	2025-06-29 15:03:40.829755
6	ART Pediatric Coverage	\N	\N	2025-06-29 15:03:40.843393
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, username, hashed_password, role, rgpd_accept, created_at, updated_at) FROM stdin;
1	adminch	$2b$12$c4vPjcMlJOqQZ34wOKnDke8TtqMDLu.eTzH8JR9NeZlzjpTCxTr3G	admin	0	2025-06-29 15:03:40.728807	2025-06-29 15:03:40.728807
2	userch	$2b$12$joU1oJbGL9MMduJGEVWp4.Jt/Gd3s6PjAyrcc6a1USN7EvGx5kM8q	user	0	2025-06-29 15:03:40.747432	2025-06-29 15:03:40.747432
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

