--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO postgres;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(40) NOT NULL,
    collision text,
    infected_by_humans boolean NOT NULL,
    shape character varying(20)
);


ALTER TABLE public.galaxy OWNER TO postgres;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO postgres;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(40) NOT NULL,
    planet_id integer NOT NULL,
    radius_km numeric(1000,2),
    water_exists boolean
);


ALTER TABLE public.moon OWNER TO postgres;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO postgres;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(40) NOT NULL,
    star_id integer NOT NULL,
    surface_water_percentage numeric(100,2),
    has_moon boolean NOT NULL,
    number_of_moons integer
);


ALTER TABLE public.planet OWNER TO postgres;

--
-- Name: planet_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planet_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_photos_id_seq OWNER TO postgres;

--
-- Name: planet_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_photos (
    planet_id integer NOT NULL,
    photo_exists boolean NOT NULL,
    first_photo_date date,
    name character varying(30),
    planet_photos_id integer DEFAULT nextval('public.planet_photos_id_seq'::regclass) NOT NULL
);


ALTER TABLE public.planet_photos OWNER TO postgres;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO postgres;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(40) NOT NULL,
    galaxy_id integer NOT NULL,
    number_of_planets integer,
    star_colour character varying(20)
);


ALTER TABLE public.star OWNER TO postgres;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO postgres;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'The Andromeda galaxy is currently approaching the Milky Way at about 110 kilometers per second, and if a collision occurs, both galaxies will eventually merge into a single one.', true, 'Barred Spiral');
INSERT INTO public.galaxy VALUES (2, 'Andromeda Galaxy', 'There is about a 50% chance that the Milky Way will collide and merge with the Andromeda galaxy within the next 10 billion years.', false, 'Spiral');
INSERT INTO public.galaxy VALUES (3, 'Triangulum Galaxy', 'The Triangulum Galaxy is expected to either orbit or eventually merge with the Milky Way-Andromeda remnant after their collision', false, 'Spiral');
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy', 'The Sombrero Galaxy experienced a massive collision with a substantial disk galaxy over 3.5 billion years ago.', false, 'Lenticular');
INSERT INTO public.galaxy VALUES (5, 'Whirlpool Galaxy', 'The Whirlpool Galaxy is currently merging with its smaller companion, M51b.', false, 'Grand-Design Spiral');
INSERT INTO public.galaxy VALUES (6, 'Large Magellanic Cloud', 'The Large Magellanic Cloud survived a close encounter with the Milky Way, losing much of its gaseous halo due to the collision but retaining enough gas to continue forming new stars', false, 'Irregular');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.moon VALUES (1, 'Moon', 3, 1737.10, false);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 11.10, false);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 6.20, false);
INSERT INTO public.moon VALUES (4, 'Ganymede', 6, 2634.10, true);
INSERT INTO public.moon VALUES (5, 'Callisto', 6, 2410.30, true);
INSERT INTO public.moon VALUES (6, 'Io', 6, 1821.60, true);
INSERT INTO public.moon VALUES (7, 'Europa', 6, 1560.80, true);
INSERT INTO public.moon VALUES (8, 'Amalthea', 6, 83.50, false);
INSERT INTO public.moon VALUES (9, 'Titan', 7, 2574.70, true);
INSERT INTO public.moon VALUES (10, 'Rhea', 7, 763.80, false);
INSERT INTO public.moon VALUES (11, 'Lapetus', 7, 734.50, false);
INSERT INTO public.moon VALUES (12, 'Dione', 7, 561.40, false);
INSERT INTO public.moon VALUES (13, 'Tethys', 7, 531.10, false);
INSERT INTO public.moon VALUES (14, 'Enceladus', 7, 252.10, true);
INSERT INTO public.moon VALUES (15, 'Mimas', 7, 198.20, false);
INSERT INTO public.moon VALUES (16, 'Hyperion', 7, 135.00, false);
INSERT INTO public.moon VALUES (17, 'Titania', 2, 788.90, false);
INSERT INTO public.moon VALUES (18, 'Oberon', 2, 761.40, false);
INSERT INTO public.moon VALUES (19, 'Umbriel', 2, 584.70, false);
INSERT INTO public.moon VALUES (20, 'Ariel', 2, 578.90, false);
INSERT INTO public.moon VALUES (21, 'Triton', 2, 1353.40, true);
INSERT INTO public.moon VALUES (22, 'Miranda', 2, 235.80, false);
INSERT INTO public.moon VALUES (23, 'Pan', 7, 14.10, false);
INSERT INTO public.moon VALUES (24, 'Metis', 6, 21.50, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.planet VALUES (1, 'Brown Dwarf planet', 6, NULL, false, NULL);
INSERT INTO public.planet VALUES (3, 'Earth', 15, 71.00, true, 1);
INSERT INTO public.planet VALUES (4, 'Mars', 15, 1.00, true, 2);
INSERT INTO public.planet VALUES (5, 'Venus', 15, 0.00, false, 0);
INSERT INTO public.planet VALUES (6, 'Jupiter', 15, 0.00, true, 95);
INSERT INTO public.planet VALUES (7, 'Saturn', 15, 0.00, true, 83);
INSERT INTO public.planet VALUES (8, 'Kepler-138c', 11, 100.00, false, 0);
INSERT INTO public.planet VALUES (9, 'Kepler-138d', 11, 100.00, false, 0);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri b', 12, NULL, false, NULL);
INSERT INTO public.planet VALUES (11, 'TRAPPIST-1e', 13, NULL, false, 0);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1f', 13, NULL, false, 0);
INSERT INTO public.planet VALUES (13, 'HD 82943b', 14, 0.00, false, NULL);
INSERT INTO public.planet VALUES (14, 'HD 82943c', 14, 0.00, false, 0);
INSERT INTO public.planet VALUES (2, 'Uranus', 15, 0.00, true, 27);


--
-- Data for Name: planet_photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.planet_photos VALUES (3, true, '1946-01-01', 'Earth', 1);
INSERT INTO public.planet_photos VALUES (4, true, '1965-07-14', 'Mars', 2);
INSERT INTO public.planet_photos VALUES (5, true, '1962-12-14', 'Venus', 3);
INSERT INTO public.planet_photos VALUES (6, true, '1973-12-03', 'Jupiter', 4);
INSERT INTO public.planet_photos VALUES (7, true, '1979-09-01', 'Saturn', 5);
INSERT INTO public.planet_photos VALUES (2, true, '1986-01-24', 'Uranus', 6);
INSERT INTO public.planet_photos VALUES (8, false, NULL, 'Kepler-138c', 7);
INSERT INTO public.planet_photos VALUES (9, false, NULL, 'Kepler-138d', 8);
INSERT INTO public.planet_photos VALUES (10, false, NULL, 'Proxima Centauri b', 9);
INSERT INTO public.planet_photos VALUES (11, false, NULL, 'TRAPPIST-1e', 10);
INSERT INTO public.planet_photos VALUES (12, false, NULL, 'TRAPPIST-1f', 11);
INSERT INTO public.planet_photos VALUES (13, false, NULL, 'HD 82943b', 12);
INSERT INTO public.planet_photos VALUES (14, false, NULL, 'HD 82943c', 13);
INSERT INTO public.planet_photos VALUES (1, false, NULL, 'Brown Dwarf planet', 14);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.star VALUES (2, 'VY Canis Majoris', 1, NULL, 'Red');
INSERT INTO public.star VALUES (3, 'Mu Cephei', 1, NULL, 'Red');
INSERT INTO public.star VALUES (4, 'KY Cygni', 1, NULL, 'Red');
INSERT INTO public.star VALUES (5, 'Alpheratz', 2, NULL, 'Blue-White');
INSERT INTO public.star VALUES (6, 'Mirach', 2, 1, 'Red');
INSERT INTO public.star VALUES (7, 'Beta Trianguli', 3, 0, 'Blue-White');
INSERT INTO public.star VALUES (8, 'Gamma Trianguli', 3, 0, 'White');
INSERT INTO public.star VALUES (9, 'WOH G64', 6, 0, 'Red');
INSERT INTO public.star VALUES (10, 'S Doradus', 6, 0, 'Blue');
INSERT INTO public.star VALUES (11, 'Kepler-138', 1, 4, 'Red');
INSERT INTO public.star VALUES (12, 'Proxima Centauri', 1, 3, 'Red');
INSERT INTO public.star VALUES (13, 'TRAPPIST-1', 1, 7, 'Red');
INSERT INTO public.star VALUES (14, 'HD 82943', 1, 2, 'Yellow-White');
INSERT INTO public.star VALUES (15, 'Sun', 1, 8, 'Yellow');
INSERT INTO public.star VALUES (1, 'Betelgeuse', 1, NULL, 'Red');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 24, true);


--
-- Name: planet_photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planet_photos_id_seq', 14, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.star_star_id_seq', 15, true);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet_photos planet_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet_photos
    ADD CONSTRAINT planet_id_unique UNIQUE (planet_id);


--
-- Name: planet_photos planet_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet_photos
    ADD CONSTRAINT planet_photos_pkey PRIMARY KEY (planet_photos_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy unique_galaxy_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT unique_galaxy_name UNIQUE (name);


--
-- Name: moon unique_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT unique_names UNIQUE (name);


--
-- Name: planet unique_planet_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT unique_planet_names UNIQUE (name);


--
-- Name: star unique_star_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT unique_star_name UNIQUE (name);


--
-- Name: moon moon_moon_name_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_moon_name_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_planet_name_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_name_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_name_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

