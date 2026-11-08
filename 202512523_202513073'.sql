--
-- PostgreSQL database dump
--

\restrict Q0O8faetto751rVDmWZu2H6A8H53aERIzWvn7gFBNtUfweQyyp6yPJ2wEM5by0J

-- Dumped from database version 16.15
-- Dumped by pg_dump version 16.15

-- Started on 2026-11-08 13:05:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- TOC entry 217 (class 1259 OID 33001)
-- Name: missions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missions (
    mission_id integer NOT NULL,
    mission_name character varying(100) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    CONSTRAINT missions_check CHECK (((end_date IS NULL) OR (end_date >= start_date)))
);


ALTER TABLE public.missions OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 32986)
-- Name: ranks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ranks (
    rank_id integer NOT NULL,
    rank_name character varying(50) NOT NULL,
    rank_level integer NOT NULL,
    CONSTRAINT ranks_rank_level_check CHECK (((rank_level >= 1) AND (rank_level <= 6)))
);


ALTER TABLE public.ranks OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33031)
-- Name: soldier_missions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.soldier_missions (
    soldier_id integer NOT NULL,
    mission_id integer NOT NULL,
    mission_role character varying(100) NOT NULL
);


ALTER TABLE public.soldier_missions OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33010)
-- Name: soldiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.soldiers (
    soldier_id integer NOT NULL,
    service_number character varying(30) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    date_of_birth date NOT NULL,
    enlistment_date date NOT NULL,
    status character varying(20) DEFAULT 'Active'::character varying NOT NULL,
    rank_id integer NOT NULL,
    unit_id integer NOT NULL,
    CONSTRAINT soldiers_check CHECK ((enlistment_date > date_of_birth)),
    CONSTRAINT soldiers_status_check CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'On Leave'::character varying, 'Retired'::character varying])::text[])))
);


ALTER TABLE public.soldiers OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 33009)
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.soldiers_soldier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.soldiers_soldier_id_seq OWNER TO postgres;

--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 218
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.soldiers_soldier_id_seq OWNED BY public.soldiers.soldier_id;


--
-- TOC entry 216 (class 1259 OID 32994)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    unit_id integer NOT NULL,
    unit_name character varying(100) NOT NULL,
    location character varying(100) NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 4650 (class 2604 OID 33013)
-- Name: soldiers soldier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers ALTER COLUMN soldier_id SET DEFAULT nextval('public.soldiers_soldier_id_seq'::regclass);


--
-- TOC entry 4823 (class 0 OID 33001)
-- Dependencies: 217
-- Data for Name: missions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missions (mission_id, mission_name, start_date, end_date) FROM stdin;
1	Exercise Falcon	2025-02-03	2025-02-28
2	Flood Relief	2025-04-14	2025-05-30
3	Border Patrol	2025-07-01	\N
4	Peace Support	2025-09-15	\N
5	Field Medical Camp	2026-01-12	2026-01-23
\.


--
-- TOC entry 4821 (class 0 OID 32986)
-- Dependencies: 215
-- Data for Name: ranks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ranks (rank_id, rank_name, rank_level) FROM stdin;
1	Private	1
2	Corporal	2
3	Sergeant	3
4	Lieutenant	4
5	Captain	5
6	Major	6
\.


--
-- TOC entry 4826 (class 0 OID 33031)
-- Dependencies: 220
-- Data for Name: soldier_missions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.soldier_missions (soldier_id, mission_id, mission_role) FROM stdin;
31	3	Rifleman
32	3	Team Leader
\.


--
-- TOC entry 4825 (class 0 OID 33010)
-- Dependencies: 219
-- Data for Name: soldiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.soldiers (soldier_id, service_number, first_name, last_name, date_of_birth, enlistment_date, status, rank_id, unit_id) FROM stdin;
31	ST-2401237	John	Doe	2000-05-15	2021-01-10	Active	1	2
32	ST-2401237-2	Jane	Smith	1998-08-22	2020-03-15	Active	2	2
33	ST-2401237-3	Alex	Jones	1999-11-05	2022-06-01	Active	2	3
\.


--
-- TOC entry 4822 (class 0 OID 32994)
-- Dependencies: 216
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (unit_id, unit_name, location) FROM stdin;
1	Alpha Company	North Camp
2	Bravo Company	South Camp
3	Charlie Company	East Camp
4	Delta Company	West Camp
5	Signals Unit	Central Camp
6	Medical Unit	Central Camp
\.


--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 218
-- Name: soldiers_soldier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.soldiers_soldier_id_seq', 1, false);


--
-- TOC entry 4665 (class 2606 OID 33008)
-- Name: missions missions_mission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_mission_name_key UNIQUE (mission_name);


--
-- TOC entry 4667 (class 2606 OID 33006)
-- Name: missions missions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_pkey PRIMARY KEY (mission_id);


--
-- TOC entry 4657 (class 2606 OID 32991)
-- Name: ranks ranks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranks
    ADD CONSTRAINT ranks_pkey PRIMARY KEY (rank_id);


--
-- TOC entry 4659 (class 2606 OID 32993)
-- Name: ranks ranks_rank_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranks
    ADD CONSTRAINT ranks_rank_name_key UNIQUE (rank_name);


--
-- TOC entry 4673 (class 2606 OID 33035)
-- Name: soldier_missions soldier_missions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_missions
    ADD CONSTRAINT soldier_missions_pkey PRIMARY KEY (soldier_id, mission_id);


--
-- TOC entry 4669 (class 2606 OID 33018)
-- Name: soldiers soldiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_pkey PRIMARY KEY (soldier_id);


--
-- TOC entry 4671 (class 2606 OID 33020)
-- Name: soldiers soldiers_service_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_service_number_key UNIQUE (service_number);


--
-- TOC entry 4661 (class 2606 OID 32998)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (unit_id);


--
-- TOC entry 4663 (class 2606 OID 33000)
-- Name: units units_unit_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_unit_name_key UNIQUE (unit_name);


--
-- TOC entry 4676 (class 2606 OID 33041)
-- Name: soldier_missions soldier_missions_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_missions
    ADD CONSTRAINT soldier_missions_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(mission_id);


--
-- TOC entry 4677 (class 2606 OID 33036)
-- Name: soldier_missions soldier_missions_soldier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldier_missions
    ADD CONSTRAINT soldier_missions_soldier_id_fkey FOREIGN KEY (soldier_id) REFERENCES public.soldiers(soldier_id);


--
-- TOC entry 4674 (class 2606 OID 33021)
-- Name: soldiers soldiers_rank_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_rank_id_fkey FOREIGN KEY (rank_id) REFERENCES public.ranks(rank_id);


--
-- TOC entry 4675 (class 2606 OID 33026)
-- Name: soldiers soldiers_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.soldiers
    ADD CONSTRAINT soldiers_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(unit_id);


-- Completed on 2026-11-08 13:05:13

--
-- PostgreSQL database dump complete
--

\unrestrict Q0O8faetto751rVDmWZu2H6A8H53aERIzWvn7gFBNtUfweQyyp6yPJ2wEM5by0J

