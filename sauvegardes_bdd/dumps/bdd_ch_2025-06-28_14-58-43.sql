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
-- Data for Name: mortalite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mortalite (id, id_pays, annee, valeur, id_unite) FROM stdin;
\.


--
-- Name: mortalite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mortalite_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

