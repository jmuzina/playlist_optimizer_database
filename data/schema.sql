--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

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

--
-- Name: playlist_optimizer; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA playlist_optimizer;


ALTER SCHEMA playlist_optimizer OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: user; Type: TABLE; Schema: playlist_optimizer; Owner: postgres
--

CREATE TABLE playlist_optimizer."user" (
    id integer NOT NULL
);


ALTER TABLE playlist_optimizer."user" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: playlist_optimizer; Owner: postgres
--

CREATE SEQUENCE playlist_optimizer."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE playlist_optimizer."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: playlist_optimizer; Owner: postgres
--

ALTER SEQUENCE playlist_optimizer."User_id_seq" OWNED BY playlist_optimizer."user".id;


--
-- Name: spotify_user; Type: TABLE; Schema: playlist_optimizer; Owner: postgres
--

CREATE TABLE playlist_optimizer.spotify_user (
    id text NOT NULL,
    u_id_fk integer NOT NULL
);


ALTER TABLE playlist_optimizer.spotify_user OWNER TO postgres;

--
-- Name: v_users; Type: VIEW; Schema: playlist_optimizer; Owner: postgres
--

CREATE VIEW playlist_optimizer.v_users AS
 SELECT usr.id AS u_id,
    spotifyuser.id AS spotify_u_id
   FROM (playlist_optimizer."user" usr
     RIGHT JOIN playlist_optimizer.spotify_user spotifyuser ON ((usr.id = spotifyuser.u_id_fk)));


ALTER TABLE playlist_optimizer.v_users OWNER TO postgres;

--
-- Name: user id; Type: DEFAULT; Schema: playlist_optimizer; Owner: postgres
--

ALTER TABLE ONLY playlist_optimizer."user" ALTER COLUMN id SET DEFAULT nextval('playlist_optimizer."User_id_seq"'::regclass);


--
-- Data for Name: spotify_user; Type: TABLE DATA; Schema: playlist_optimizer; Owner: postgres
--

COPY playlist_optimizer.spotify_user (id, u_id_fk) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: playlist_optimizer; Owner: postgres
--

COPY playlist_optimizer."user" (id) FROM stdin;
\.


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: playlist_optimizer; Owner: postgres
--

SELECT pg_catalog.setval('playlist_optimizer."User_id_seq"', 1, false);


--
-- Name: spotify_user SpotifyUser_pkey; Type: CONSTRAINT; Schema: playlist_optimizer; Owner: postgres
--

ALTER TABLE ONLY playlist_optimizer.spotify_user
    ADD CONSTRAINT "SpotifyUser_pkey" PRIMARY KEY (id);


--
-- Name: user User_pkey; Type: CONSTRAINT; Schema: playlist_optimizer; Owner: postgres
--

ALTER TABLE ONLY playlist_optimizer."user"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: spotify_user user_unique_spotify_account; Type: CONSTRAINT; Schema: playlist_optimizer; Owner: postgres
--

ALTER TABLE ONLY playlist_optimizer.spotify_user
    ADD CONSTRAINT user_unique_spotify_account UNIQUE (u_id_fk);


--
-- Name: spotify_user AppUser; Type: FK CONSTRAINT; Schema: playlist_optimizer; Owner: postgres
--

ALTER TABLE ONLY playlist_optimizer.spotify_user
    ADD CONSTRAINT "AppUser" FOREIGN KEY (u_id_fk) REFERENCES playlist_optimizer."user"(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

