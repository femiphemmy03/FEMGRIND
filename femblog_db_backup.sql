--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ads (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ads OWNER TO postgres;

--
-- Name: ads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ads_id_seq OWNER TO postgres;

--
-- Name: ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ads_id_seq OWNED BY public.ads.id;


--
-- Name: attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attempts (
    id integer NOT NULL,
    username character varying(100),
    exam_type character varying(50),
    subject character varying(50),
    answers jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.attempts OWNER TO postgres;

--
-- Name: attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attempts_id_seq OWNER TO postgres;

--
-- Name: attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: femblog_user
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    post_id integer,
    user_name character varying(100) NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO femblog_user;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: femblog_user
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO femblog_user;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: femblog_user
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: femgrind_ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.femgrind_ads (
    id integer NOT NULL,
    image character varying(255) NOT NULL,
    link character varying(255) NOT NULL
);


ALTER TABLE public.femgrind_ads OWNER TO postgres;

--
-- Name: femgrind_ads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.femgrind_ads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.femgrind_ads_id_seq OWNER TO postgres;

--
-- Name: femgrind_ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.femgrind_ads_id_seq OWNED BY public.femgrind_ads.id;


--
-- Name: femgrind_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.femgrind_questions (
    id integer NOT NULL,
    subject character varying(100) NOT NULL,
    grade_level character varying(50),
    exam_type character varying(50),
    question text NOT NULL,
    options jsonb NOT NULL,
    correct_answer integer NOT NULL,
    justification text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.femgrind_questions OWNER TO postgres;

--
-- Name: femgrind_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.femgrind_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.femgrind_questions_id_seq OWNER TO postgres;

--
-- Name: femgrind_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.femgrind_questions_id_seq OWNED BY public.femgrind_questions.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: femblog_user
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    author character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_pinned boolean DEFAULT false,
    image character varying(255) DEFAULT ''::character varying,
    category character varying(100),
    likes integer DEFAULT 0
);


ALTER TABLE public.posts OWNER TO femblog_user;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: femblog_user
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO femblog_user;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: femblog_user
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(50) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'writer'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads ALTER COLUMN id SET DEFAULT nextval('public.ads_id_seq'::regclass);


--
-- Name: attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: femblog_user
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: femgrind_ads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femgrind_ads ALTER COLUMN id SET DEFAULT nextval('public.femgrind_ads_id_seq'::regclass);


--
-- Name: femgrind_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femgrind_questions ALTER COLUMN id SET DEFAULT nextval('public.femgrind_questions_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: femblog_user
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ads (id, title, image, url, created_at) FROM stdin;
1	ads check	/ads/1752613306522.jpg	https://linktr.ee/Oluwafemisunmola	2025-07-15 21:59:42.132834
2	another ad check	/Uploads/ads/1753117255475.png	https://www.lindaikejisblog.com	2025-07-16 21:40:59.367802
3	another test	/Uploads/ads/1753118099620.png	https://www.fiverr.com/s/ljgDVga	2025-07-21 18:14:59.713266
4	femi	/Uploads/ads/1753118145038.png	https://www.lindaikejisblog.com	2025-07-21 18:15:45.108052
\.


--
-- Data for Name: attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attempts (id, username, exam_type, subject, answers, created_at) FROM stdin;
1	shola	WAEC	Mathematics	{}	2025-08-17 14:43:35.853927
2	shola	WAEC	Mathematics	{}	2025-08-17 14:43:35.906528
3	Ayola	WAEC	English	{}	2025-08-17 14:45:48.808107
4	Ayola	WAEC	English	{"115": 1, "116": 1, "123": 0, "127": 1, "132": 1, "138": 1, "140": 1, "149": 1, "151": 0, "157": 0, "167": 1, "170": 1, "172": 0, "183": 1, "186": 1, "192": 0, "193": 2, "194": 1, "195": 1, "204": 1}	2025-08-17 14:45:48.817183
6	Ayoola	JAMB	English	{}	2025-08-17 14:53:17.327035
5	Ayoola	JAMB	English	{"111": 1, "122": 1, "125": 1, "126": 0, "129": 1, "132": 1, "133": 1, "141": 0, "153": 2, "155": 1, "161": 1, "163": 2, "164": 1, "168": 3, "191": 1, "195": 1, "200": 0, "206": 1, "208": 0, "214": 1}	2025-08-17 14:53:17.326284
8	Damola	POST-UTME	Government	{}	2025-08-17 20:28:37.150077
7	Damola	POST-UTME	Government	{"660": 1, "662": 0, "663": 1, "668": 1, "670": 1, "671": 1, "676": 1, "677": 2, "696": 1, "698": 1, "703": 1, "704": 1, "716": 1, "717": 1, "723": 1, "725": 3, "726": 1, "730": 1, "736": 1, "741": 1}	2025-08-17 20:28:37.149338
9	Williams	JAMB	Christian Religious Studies	{}	2025-08-17 20:34:23.88861
10	Williams	JAMB	Christian Religious Studies	{"750": 1, "755": 1, "759": 1, "762": 1, "767": 1, "778": 1, "779": 1, "781": 1, "789": 1, "790": 1, "793": 2, "798": 1, "803": 1, "807": 1, "810": 1, "815": 1, "819": 1, "820": 1, "825": 1, "832": 1}	2025-08-17 20:34:23.940502
11	Aye	WAEC	Christian Religious Studies	{}	2025-08-17 20:47:34.516594
12	Aye	WAEC	Christian Religious Studies	{"742": 1, "747": 1, "754": 0, "756": 1, "758": 0, "759": 1, "773": 1, "776": 0, "779": 1, "786": 1, "788": 1, "790": 1, "794": 1, "803": 1, "806": 1, "809": 1, "810": 1, "822": 1, "825": 1, "826": 1}	2025-08-17 20:47:34.578841
14	Aro	WAEC	English	{}	2025-08-17 21:03:06.307551
13	Aro	WAEC	English	{"111": 1, "121": 1, "125": 1, "127": 1, "138": 1, "152": 1, "153": 2, "156": 2, "159": 1, "163": 0, "164": 1, "169": 1, "178": 2, "183": 1, "186": 1, "189": 1, "191": 1, "206": 1, "213": 2, "1486": 1}	2025-08-17 21:03:06.304941
15	soulfoodhub	WAEC	Biology	{}	2025-08-17 21:45:36.623288
16	soulfoodhub	WAEC	Biology	{"1141": 1, "1142": 1, "1146": 1, "1147": 1, "1149": 2, "1155": 0, "1156": 1, "1160": 1, "1162": 0, "1163": 1, "1164": 2, "1168": 3, "1172": 2, "1177": 1, "1179": 0, "1186": 1, "1195": 1, "1205": 1, "1209": 1, "1212": 1}	2025-08-17 21:45:36.629317
18	sunmola	JAMB	Chemistry	{}	2025-08-18 09:19:30.629714
17	sunmola	JAMB	Chemistry	{"1032": 1, "1036": 0, "1041": 0, "1049": 0, "1055": 0, "1057": 0, "1058": 1, "1060": 2, "1066": 2, "1069": 1, "1077": 1, "1080": 2, "1082": 0, "1085": 1, "1103": 2, "1104": 3, "1108": 1, "1118": 2, "1127": 0, "1136": 1}	2025-08-18 09:19:30.632282
19	femi	POST-UTME	Commerce	{}	2025-08-18 11:17:02.140849
20	femi	POST-UTME	Commerce	{"837": 1, "845": 2, "848": 1, "862": 0, "873": 1, "879": 1, "880": 1, "882": 1, "885": 1, "892": 1, "894": 1, "899": 1, "900": 1, "907": 1, "908": 1, "913": 1, "917": 2, "922": 1, "923": 1, "927": 1}	2025-08-18 11:17:02.141649
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: femblog_user
--

COPY public.comments (id, post_id, user_name, content, created_at) FROM stdin;
1	28	femi	testing comment	2025-07-17 22:10:19.815754
2	36	test name	considering testing	2025-07-17 22:10:50.644675
3	36	Editi effiong	test cmment	2025-07-18 19:43:30.883437
4	37	femi	my comment	2025-07-18 21:11:34.03244
5	42	test	test	2025-07-18 21:12:03.79257
\.


--
-- Data for Name: femgrind_ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.femgrind_ads (id, image, link) FROM stdin;
1	/uploads/1754434972094.jpg	www.google.com
\.


--
-- Data for Name: femgrind_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.femgrind_questions (id, subject, grade_level, exam_type, question, options, correct_answer, justification, created_at) FROM stdin;
1	Mathematics	SSCE	\N	Solve for x: 2x + 5 = 17	["4", "5", "6", "7"]	2	2x + 5 = 17 => 2x = 12 => x = 6	2025-08-17 14:27:14.482368
2	Mathematics	SSCE	\N	Evaluate log₂(16).	["2", "3", "4", "5"]	2	log₂(16) = log₂(2⁴) = 4	2025-08-17 14:27:14.482368
3	Mathematics	SSCE	\N	Find the area of a circle with radius 4 cm (use π = 3.142).	["50.27 cm²", "12.57 cm²", "25.13 cm²", "16 cm²"]	0	Area = πr² = 3.142 × 4² = 3.142 × 16 = 50.272 ≈ 50.27 cm²	2025-08-17 14:27:14.482368
4	Mathematics	SSCE	\N	If sin(θ) = 0.6 and θ is acute, find cos(θ).	["0.8", "0.7", "0.6", "0.4"]	0	sin²(θ) + cos²(θ) = 1 => cos²(θ) = 1 - (0.6)² = 1 - 0.36 = 0.64 => cos(θ) = 0.8	2025-08-17 14:27:14.482368
5	Mathematics	SSCE	\N	Solve the equation x² - 7x + 10 = 0.	["x = 2, 5", "x = 1, 10", "x = -2, -5", "x = 3, 4"]	0	x² - 7x + 10 = (x - 2)(x - 5) = 0 => x = 2, 5	2025-08-17 14:27:14.482368
6	Mathematics	SSCE	\N	Find the gradient of the line 4x - 3y = 12.	["4/3", "-4/3", "3/4", "-3/4"]	0	4x - 3y = 12 => 3y = 4x - 12 => y = (4/3)x - 4 => gradient = 4/3	2025-08-17 14:27:14.482368
7	Mathematics	SSCE	\N	Calculate the median of the numbers 1, 4, 7, 10, 13.	["4", "7", "10", "6"]	1	Arrange in order: 1, 4, 7, 10, 13 => median = 7	2025-08-17 14:27:14.482368
8	Mathematics	SSCE	\N	Evaluate 2⁴ × 3².	["72", "144", "288", "96"]	0	2⁴ = 16, 3² = 9 => 16 × 9 = 144	2025-08-17 14:27:14.482368
9	Mathematics	SSCE	\N	Find the volume of a cube with side length 3 cm.	["9 cm³", "27 cm³", "81 cm³", "18 cm³"]	1	Volume = side³ = 3³ = 27 cm³	2025-08-17 14:27:14.482368
10	Mathematics	SSCE	\N	If f(x) = x² - 2x + 3, find f(4).	["11", "15", "19", "23"]	0	f(x) = x² - 2x + 3 => f(4) = 4² - 2(4) + 3 = 16 - 8 + 3 = 11	2025-08-17 14:27:14.482368
11	Mathematics	SSCE	\N	Simplify: (8x⁴y²)/(2x²y).	["4x²y", "4xy", "2x²y", "4x/y"]	0	(8x⁴y²)/(2x²y) = (8/2)(x⁴/x²)(y²/y) = 4x^(4-2)y^(2-1) = 4x²y	2025-08-17 14:27:14.482368
12	Mathematics	SSCE	\N	Find the sum of the first 6 terms of the arithmetic sequence: 5, 8, 11, ...	["78", "81", "84", "87"]	0	a = 5, d = 3, n = 6; Sum = n/2[2a + (n-1)d] = 6/2[2(5) + (6-1)3] = 3[10 + 15] = 3 × 25 = 75	2025-08-17 14:27:14.482368
13	Mathematics	SSCE	\N	What is the value of tan(30°)?	["1/√3", "√3", "1", "0"]	0	tan(30°) = 1/√3	2025-08-17 14:27:14.482368
14	Mathematics	SSCE	\N	Find the probability of rolling a 4 on a fair six-sided die.	["1/6", "1/3", "1/4", "1/2"]	0	Probability = 1 favorable outcome / 6 possible outcomes = 1/6	2025-08-17 14:27:14.482368
15	Mathematics	SSCE	\N	Solve for x: 2^(x-2) = 8.	["3", "4", "5", "6"]	1	2^(x-2) = 8 = 2³ => x - 2 = 3 => x = 5	2025-08-17 14:27:14.482368
16	Mathematics	SSCE	\N	Find the determinant of the matrix [[3, 2], [1, 4]].	["10", "12", "14", "8"]	0	Determinant = (3 × 4) - (2 × 1) = 12 - 2 = 10	2025-08-17 14:27:14.482368
17	Mathematics	SSCE	\N	If the roots of x² - 6x + k = 0 are equal, find k.	["6", "9", "12", "15"]	1	For equal roots, b² - 4ac = 0; a = 1, b = -6, c = k => (-6)² - 4(1)(k) = 0 => 36 - 4k = 0 => k = 9	2025-08-17 14:27:14.482368
18	Mathematics	SSCE	\N	Find the distance between points (1, 1) and (4, 5).	["5", "6", "7", "8"]	0	Distance = √[(4-1)² + (5-1)²] = √[3² + 4²] = √[9 + 16] = √25 = 5	2025-08-17 14:27:14.482368
19	Mathematics	SSCE	\N	What is the value of cos(45°)?	["1/√2", "√3/2", "1/2", "1"]	0	cos(45°) = 1/√2	2025-08-17 14:27:14.482368
20	Mathematics	SSCE	\N	Find the mean of the numbers 2, 6, 10, 14, 18.	["8", "10", "12", "14"]	1	Mean = (2 + 6 + 10 + 14 + 18) / 5 = 50 / 5 = 10	2025-08-17 14:27:14.482368
21	Mathematics	SSCE	\N	Solve for x: 4x - 7 = x + 8.	["3", "4", "5", "6"]	2	4x - 7 = x + 8 => 4x - x = 8 + 7 => 3x = 15 => x = 5	2025-08-17 14:27:14.482368
22	Mathematics	SSCE	\N	Find the value of x if log₃(x) = 3.	["9", "27", "81", "3"]	1	log₃(x) = 3 => x = 3³ = 27	2025-08-17 14:27:14.482368
23	Mathematics	SSCE	\N	Find the area of a triangle with base 6 cm and height 8 cm.	["24 cm²", "36 cm²", "48 cm²", "12 cm²"]	0	Area = (1/2) × base × height = (1/2) × 6 × 8 = 24 cm²	2025-08-17 14:27:14.482368
24	Mathematics	SSCE	\N	If tan(θ) = 1 and θ is acute, find sin(θ).	["1/√2", "√3/2", "1/2", "1"]	0	tan(θ) = 1 => θ = 45° => sin(45°) = 1/√2	2025-08-17 14:27:14.482368
25	Mathematics	SSCE	\N	Solve the equation 3x² - 5x - 2 = 0.	["x = -1/3, 2", "x = 1/3, -2", "x = -1, 2", "x = 1, -2"]	0	3x² - 5x - 2 = (3x + 1)(x - 2) = 0 => x = -1/3, 2	2025-08-17 14:27:14.482368
26	Mathematics	SSCE	\N	Find the midpoint of the line segment joining (2, 3) and (6, 7).	["(4, 5)", "(3, 5)", "(5, 4)", "(4, 6)"]	0	Midpoint = [(2+6)/2, (3+7)/2] = [8/2, 10/2] = (4, 5)	2025-08-17 14:27:14.482368
27	Mathematics	SSCE	\N	Evaluate 4! (factorial).	["12", "24", "48", "96"]	1	4! = 4 × 3 × 2 × 1 = 24	2025-08-17 14:27:14.482368
28	Mathematics	SSCE	\N	Find the sum of the geometric series: 3 + 6 + 12 + 24 (4 terms).	["45", "48", "50", "60"]	0	a = 3, r = 2, n = 4; Sum = a(r^n - 1)/(r - 1) = 3(2⁴ - 1)/(2 - 1) = 3(16 - 1)/1 = 3 × 15 = 45	2025-08-17 14:27:14.482368
29	Mathematics	SSCE	\N	What is the value of sin(60°)?	["1/2", "√3/2", "1/√2", "1"]	1	sin(60°) = √3/2	2025-08-17 14:27:14.482368
30	Mathematics	SSCE	\N	Find the probability of drawing a red card from a standard deck of 52 cards.	["1/4", "1/3", "1/2", "1/13"]	2	Probability = 26 red cards / 52 cards = 1/2	2025-08-17 14:27:14.482368
31	Mathematics	SSCE	\N	Simplify: √(48).	["4√3", "6√2", "8√3", "4√2"]	0	√48 = √(16 × 3) = 4√3	2025-08-17 14:27:14.482368
32	Mathematics	SSCE	\N	Find the value of x if 5x² = 45.	["3", "-3", "±3", "9"]	2	5x² = 45 => x² = 9 => x = ±3	2025-08-17 14:27:14.482368
33	Mathematics	SSCE	\N	Find the surface area of a sphere with radius 3 cm (use π = 3.142).	["113.11 cm²", "37.70 cm²", "28.27 cm²", "18.85 cm²"]	0	Surface area = 4πr² = 4 × 3.142 × 3² = 4 × 3.142 × 9 = 113.112 ≈ 113.11 cm²	2025-08-17 14:27:14.482368
34	Mathematics	SSCE	\N	If cos(θ) = 3/5 and θ is acute, find tan(θ).	["4/3", "3/4", "5/4", "4/5"]	0	cos(θ) = 3/5 => adjacent = 3, hypotenuse = 5 => opposite = √(5² - 3²) = 4 => tan(θ) = 4/3	2025-08-17 14:27:14.482368
35	Mathematics	SSCE	\N	Solve the equation x² + 2x - 15 = 0.	["x = 3, -5", "x = -3, 5", "x = 2, -7", "x = -2, 7"]	0	x² + 2x - 15 = (x + 5)(x - 3) = 0 => x = -5, 3	2025-08-17 14:27:14.482368
36	Mathematics	SSCE	\N	Find the equation of the line with gradient 2 passing through (1, 3).	["y = 2x + 1", "y = 2x + 3", "y = 2x - 1", "y = x + 2"]	0	y - y₁ = m(x - x₁) => y - 3 = 2(x - 1) => y = 2x - 2 + 3 => y = 2x + 1	2025-08-17 14:27:14.482368
37	Mathematics	SSCE	\N	Find the mode of the numbers 2, 3, 3, 4, 4, 4, 5.	["3", "4", "5", "2"]	1	Mode is the number with the highest frequency: 4 appears 3 times.	2025-08-17 14:27:14.482368
38	Mathematics	SSCE	\N	Evaluate (2/3) ÷ (4/5).	["5/6", "8/15", "10/12", "6/5"]	0	(2/3) ÷ (4/5) = (2/3) × (5/4) = 10/12 = 5/6	2025-08-17 14:27:14.482368
179	English	SSCE	\N	Choose the correct plural form of 'Man'.	["Mans", "Men", "Menes", "Manses"]	1	The plural of 'man' is 'men'.	2025-08-17 14:27:14.482368
39	Mathematics	SSCE	\N	Find the volume of a cylinder with radius 2 cm and height 5 cm (use π = 3.142).	["62.84 cm³", "31.42 cm³", "20.10 cm³", "12.57 cm³"]	0	Volume = πr²h = 3.142 × 2² × 5 = 3.142 × 4 × 5 = 62.84 cm³	2025-08-17 14:27:14.482368
40	Mathematics	SSCE	\N	If f(x) = 3x - 7, find f(-2).	["-13", "-7", "1", "13"]	0	f(x) = 3x - 7 => f(-2) = 3(-2) - 7 = -6 - 7 = -13	2025-08-17 14:27:14.482368
41	Mathematics	SSCE	\N	Simplify: (x²y³z)/(xy²z²).	["x/y", "xy/z", "x/z", "y/z"]	0	(x²y³z)/(xy²z²) = x^(2-1)y^(3-2)z^(1-2) = x/y	2025-08-17 14:27:14.482368
42	Mathematics	SSCE	\N	Find the 7th term of the arithmetic sequence: 1, 4, 7, ...	["19", "22", "25", "28"]	0	a = 1, d = 3, n = 7; a₇ = a + (n-1)d = 1 + (7-1)3 = 1 + 18 = 19	2025-08-17 14:27:14.482368
43	Mathematics	SSCE	\N	What is the value of cot(45°)?	["1", "√3", "1/√3", "√2"]	0	cot(45°) = 1/tan(45°) = 1/1 = 1	2025-08-17 14:27:14.482368
44	Mathematics	SSCE	\N	Find the probability of selecting a vowel from the word 'MATH'.	["1/4", "1/2", "3/4", "1/3"]	0	Vowels = {A}; Total letters = 4; Probability = 1/4	2025-08-17 14:27:14.482368
45	Mathematics	SSCE	\N	Solve for x: 4^(x+1) = 16.	["0", "1", "2", "3"]	1	4^(x+1) = 16 = 4² => x + 1 = 2 => x = 1	2025-08-17 14:27:14.482368
46	Mathematics	SSCE	\N	Find the inverse of the matrix [[1, 2], [3, 4]].	["[[-2, 1], [3/2, -1/2]]", "[[-2, 1], [1, -1]]", "[[2, -1], [-3/2, 1/2]]", "[[1, -2], [-3, 4]]"]	0	Determinant = (1 × 4) - (2 × 3) = 4 - 6 = -2; Inverse = (1/-2)[[4, -2], [-3, 1]] = [[-2, 1], [3/2, -1/2]]	2025-08-17 14:27:14.482368
47	Mathematics	SSCE	\N	Find the value of k if x - 2 is a factor of x² - kx + 6.	["3", "4", "5", "6"]	2	If x - 2 is a factor, f(2) = 0; f(x) = x² - kx + 6 => f(2) = 4 - 2k + 6 = 10 - 2k = 0 => k = 5	2025-08-17 14:27:14.482368
48	Mathematics	SSCE	\N	Find the angle between vectors a = (2, 3) and b = (4, -1).	["cos⁻¹(5/√130)", "cos⁻¹(7/√65)", "cos⁻¹(5/√65)", "cos⁻¹(7/√130)"]	0	a·b = (2 × 4) + (3 × -1) = 8 - 3 = 5; |a| = √(2² + 3²) = √13; |b| = √(4² + (-1)²) = √17; cos(θ) = 5/(√13 × √17) = 5/√221 ≈ 5/√130	2025-08-17 14:27:14.482368
49	Mathematics	SSCE	\N	Differentiate y = 3x² + 2x with respect to x.	["6x + 2", "3x + 2", "6x + 1", "3x + 1"]	0	dy/dx = 3 × 2x + 2 = 6x + 2	2025-08-17 14:27:14.482368
50	Mathematics	SSCE	\N	Integrate ∫(2x + 3) dx.	["x² + 3x + c", "2x² + 3x + c", "x² + 3 + c", "2x² + 3 + c"]	0	∫(2x + 3) dx = x² + 3x + c	2025-08-17 14:27:14.482368
51	Mathematics	SSCE	\N	Find the number of ways to arrange 5 distinct books on a shelf.	["60", "120", "240", "720"]	1	Number of ways = 5! = 5 × 4 × 3 × 2 × 1 = 120	2025-08-17 14:27:14.482368
52	Mathematics	SSCE	\N	If A = {1, 2, 3} and B = {2, 3, 4}, find A ∩ B.	["{1, 4}", "{2, 3}", "{1, 2}", "{3, 4}"]	1	A ∩ B = {2, 3}	2025-08-17 14:27:14.482368
53	Mathematics	SSCE	\N	Find the value of x if 2x + 3y = 12 and x - y = 1.	["3", "4", "5", "6"]	0	From x - y = 1, x = y + 1; Substitute into 2x + 3y = 12 => 2(y + 1) + 3y = 12 => 5y + 2 = 12 => 5y = 10 => y = 2 => x = 2 + 1 = 3	2025-08-17 14:27:14.482368
54	Mathematics	SSCE	\N	Find the radius of a circle with area 78.54 cm² (use π = 3.142).	["4 cm", "5 cm", "6 cm", "7 cm"]	1	Area = πr² => 78.54 = 3.142 × r² => r² = 78.54 / 3.142 = 25 => r = 5 cm	2025-08-17 14:27:14.482368
55	Mathematics	SSCE	\N	If sin(θ) = 5/13 and θ is acute, find cos(θ).	["12/13", "5/12", "13/12", "5/13"]	0	sin²(θ) + cos²(θ) = 1 => cos²(θ) = 1 - (5/13)² = 1 - 25/169 = 144/169 => cos(θ) = 12/13	2025-08-17 14:27:14.482368
56	Mathematics	SSCE	\N	Solve the equation 4x² - 8x + 3 = 0.	["x = 1/2, 3/2", "x = 1, 2", "x = -1/2, -3/2", "x = -1, -2"]	0	4x² - 8x + 3 = (2x - 1)(2x - 3) = 0 => x = 1/2, 3/2	2025-08-17 14:27:14.482368
57	Mathematics	SSCE	\N	Find the slope of the line passing through (2, 4) and (5, 10).	["1", "2", "3", "4"]	1	Slope = (y₂ - y₁)/(x₂ - x₁) = (10 - 4)/(5 - 2) = 6/3 = 2	2025-08-17 14:27:14.482368
58	Mathematics	SSCE	\N	Find the range of the numbers 3, 7, 2, 9, 4.	["5", "6", "7", "8"]	2	Range = Max - Min = 9 - 2 = 7	2025-08-17 14:27:14.482368
59	Mathematics	SSCE	\N	Evaluate 3³ ÷ 9.	["3", "6", "9", "12"]	0	3³ = 27, 9 = 3² => 27 ÷ 9 = 3	2025-08-17 14:27:14.482368
60	Mathematics	SSCE	\N	Find the volume of a cone with radius 3 cm and height 4 cm (use π = 3.142).	["37.70 cm³", "28.27 cm³", "18.85 cm³", "12.57 cm³"]	0	Volume = (1/3)πr²h = (1/3) × 3.142 × 3² × 4 = (1/3) × 3.142 × 9 × 4 = 37.704 ≈ 37.70 cm³	2025-08-17 14:27:14.482368
61	Mathematics	SSCE	\N	If f(x) = 2x² - 3x + 1, find f(-1).	["6", "4", "2", "0"]	0	f(x) = 2x² - 3x + 1 => f(-1) = 2(-1)² - 3(-1) + 1 = 2 + 3 + 1 = 6	2025-08-17 14:27:14.482368
62	Mathematics	SSCE	\N	Simplify: (9x³)/(3x).	["3x²", "3x", "9x²", "6x²"]	0	(9x³)/(3x) = (9/3)(x³/x) = 3x^(3-1) = 3x²	2025-08-17 14:27:14.482368
63	Mathematics	SSCE	\N	Find the 5th term of the geometric sequence: 2, 6, 18, ...	["54", "162", "486", "1458"]	0	a = 2, r = 3, n = 5; a₅ = ar^(n-1) = 2 × 3^(5-1) = 2 × 3⁴ = 2 × 81 = 162	2025-08-17 14:27:14.482368
64	Mathematics	SSCE	\N	What is the value of sin(90°)?	["0", "1/2", "1", "√3/2"]	2	sin(90°) = 1	2025-08-17 14:27:14.482368
65	Mathematics	SSCE	\N	Find the probability of rolling an even number on a fair six-sided die.	["1/3", "1/2", "2/3", "1/6"]	1	Even numbers = {2, 4, 6}; Probability = 3/6 = 1/2	2025-08-17 14:27:14.482368
66	Mathematics	SSCE	\N	Solve for x: 5^(x-1) = 25.	["1", "2", "3", "4"]	2	5^(x-1) = 25 = 5² => x - 1 = 2 => x = 3	2025-08-17 14:27:14.482368
67	Mathematics	SSCE	\N	Find the determinant of the matrix [[5, 2], [3, 1]].	["1", "-1", "11", "-11"]	0	Determinant = (5 × 1) - (2 × 3) = 5 - 6 = -1	2025-08-17 14:27:14.482368
68	Mathematics	SSCE	\N	Find the value of k if the sum of the roots of x² + kx + 4 = 0 is 6.	["-6", "6", "-3", "3"]	0	Sum of roots = -b/a; a = 1, b = k => -k/1 = 6 => k = -6	2025-08-17 14:27:14.482368
69	Mathematics	SSCE	\N	Find the magnitude of the vector (3, 4).	["5", "6", "7", "8"]	0	Magnitude = √(3² + 4²) = √(9 + 16) = √25 = 5	2025-08-17 14:27:14.482368
70	Mathematics	SSCE	\N	Differentiate y = x³ - 4x with respect to x.	["3x² - 4", "3x² + 4", "x² - 4", "3x - 4"]	0	dy/dx = 3x² - 4	2025-08-17 14:27:14.482368
71	Mathematics	SSCE	\N	Integrate ∫(3x²) dx.	["x³ + c", "3x³ + c", "x² + c", "3x + c"]	0	∫(3x²) dx = x³ + c	2025-08-17 14:27:14.482368
72	Mathematics	SSCE	\N	Find the number of ways to choose 3 items from 5 distinct items.	["10", "15", "20", "60"]	0	Number of ways = C(5,3) = 5!/(3!2!) = (5 × 4 × 3!)/(3! × 2) = 20/2 = 10	2025-08-17 14:27:14.482368
73	Mathematics	SSCE	\N	If A = {2, 4, 6} and B = {4, 5, 6}, find A ∪ B.	["{2, 4}", "{4, 5, 6}", "{2, 4, 5, 6}", "{2, 5, 6}"]	2	A ∪ B = {2, 4, 5, 6}	2025-08-17 14:27:14.482368
74	Mathematics	SSCE	\N	Solve for y if 3x + 2y = 8 and x = 2.	["1", "2", "3", "4"]	1	Substitute x = 2 into 3x + 2y = 8 => 3(2) + 2y = 8 => 6 + 2y = 8 => 2y = 2 => y = 2	2025-08-17 14:27:14.482368
577	Mathematics	SSCE	\N	Find the range of the numbers 4, 7, 2, 9, 5.	["5", "6", "7", "8"]	0	Range = max - min = 9 - 2 = 7	2025-08-17 20:27:11.116863
75	Mathematics	SSCE	\N	Find the circumference of a circle with diameter 10 cm (use π = 3.142).	["31.42 cm", "15.71 cm", "62.84 cm", "10 cm"]	0	Circumference = πd = 3.142 × 10 = 31.42 cm	2025-08-17 14:27:14.482368
76	Mathematics	SSCE	\N	If tan(θ) = 5/12 and θ is acute, find sin(θ).	["5/13", "12/13", "5/12", "12/5"]	0	tan(θ) = 5/12 => opposite = 5, adjacent = 12 => hypotenuse = √(5² + 12²) = √169 = 13 => sin(θ) = 5/13	2025-08-17 14:27:14.482368
77	Mathematics	SSCE	\N	Solve the equation x² - 3x - 10 = 0.	["x = 5, -2", "x = -5, 2", "x = 3, -3", "x = -5, -2"]	0	x² - 3x - 10 = (x - 5)(x + 2) = 0 => x = 5, -2	2025-08-17 14:27:14.482368
78	Mathematics	SSCE	\N	Find the equation of the line perpendicular to y = 2x + 3 passing through (1, 1).	["y = -1/2x + 3/2", "y = -2x + 3", "y = 1/2x + 1/2", "y = 2x - 1"]	0	Perpendicular slope = -1/2; Using y - 1 = (-1/2)(x - 1) => y - 1 = -1/2x + 1/2 => y = -1/2x + 3/2	2025-08-17 14:27:14.482368
79	Mathematics	SSCE	\N	Find the variance of the numbers 1, 2, 3, 4, 5.	["1", "2", "3", "4"]	1	Mean = 3; Variance = [(1-3)² + (2-3)² + (3-3)² + (4-3)² + (5-3)²]/5 = (4 + 1 + 0 + 1 + 4)/5 = 10/5 = 2	2025-08-17 14:27:14.482368
80	Mathematics	SSCE	\N	Evaluate (1/2 + 1/3) × 6.	["4", "5", "6", "7"]	0	(1/2 + 1/3) = (3/6 + 2/6) = 5/6; (5/6) × 6 = 5	2025-08-17 14:27:14.482368
81	Mathematics	SSCE	\N	Find the volume of a rectangular prism with dimensions 4 cm, 5 cm, and 6 cm.	["60 cm³", "90 cm³", "120 cm³", "150 cm³"]	2	Volume = length × width × height = 4 × 5 × 6 = 120 cm³	2025-08-17 14:27:14.482368
82	Mathematics	SSCE	\N	If f(x) = x³ - 2x² + 1, find f(1).	["0", "1", "2", "3"]	0	f(x) = x³ - 2x² + 1 => f(1) = 1³ - 2(1)² + 1 = 1 - 2 + 1 = 0	2025-08-17 14:27:14.482368
83	Mathematics	SSCE	\N	Simplify: (12x²y)/(4xy²).	["3x/y", "3y/x", "4x/y", "4y/x"]	0	(12x²y)/(4xy²) = (12/4)(x²/x)(y/y²) = 3x^(2-1)y^(1-2) = 3x/y	2025-08-17 14:27:14.482368
84	Mathematics	SSCE	\N	Find the 6th term of the arithmetic sequence: 7, 10, 13, ...	["19", "22", "25", "28"]	2	a = 7, d = 3, n = 6; a₆ = a + (n-1)d = 7 + (6-1)3 = 7 + 15 = 22	2025-08-17 14:27:14.482368
85	Mathematics	SSCE	\N	What is the value of cos(30°)?	["1/2", "√3/2", "1/√2", "1"]	1	cos(30°) = √3/2	2025-08-17 14:27:14.482368
86	Mathematics	SSCE	\N	Find the probability of drawing a king from a standard deck of 52 cards.	["1/13", "1/26", "1/4", "1/52"]	0	Probability = 4 kings / 52 cards = 1/13	2025-08-17 14:27:14.482368
87	Mathematics	SSCE	\N	Solve for x: 3^(x+2) = 81.	["1", "2", "3", "4"]	2	3^(x+2) = 81 = 3⁴ => x + 2 = 4 => x = 2	2025-08-17 14:27:14.482368
88	Mathematics	SSCE	\N	Find the trace of the matrix [[2, 3], [4, 5]].	["5", "7", "8", "10"]	2	Trace = sum of diagonal elements = 2 + 5 = 7	2025-08-17 14:27:14.482368
89	Mathematics	SSCE	\N	Find the value of k if the product of the roots of x² - 3x + k = 0 is 2.	["1", "2", "3", "4"]	1	Product of roots = c/a; a = 1, c = k => k/1 = 2 => k = 2	2025-08-17 14:27:14.482368
90	Mathematics	SSCE	\N	Find the unit vector in the direction of (3, 4).	["(3/5, 4/5)", "(3/4, 4/3)", "(5/3, 5/4)", "(1/3, 1/4)"]	0	Magnitude = √(3² + 4²) = 5; Unit vector = (3/5, 4/5)	2025-08-17 14:27:14.482368
91	Mathematics	SSCE	\N	Differentiate y = 5x - x² with respect to x.	["5 - 2x", "5 - x", "5 + 2x", "-2x"]	0	dy/dx = 5 - 2x	2025-08-17 14:27:14.482368
92	Mathematics	SSCE	\N	Integrate ∫(4x + 1) dx.	["2x² + x + c", "4x² + x + c", "2x² + c", "4x² + c"]	0	∫(4x + 1) dx = 2x² + x + c	2025-08-17 14:27:14.482368
93	Mathematics	SSCE	\N	Find the number of ways to arrange the letters of the word 'CAT'.	["6", "12", "24", "36"]	0	Number of ways = 3! = 3 × 2 × 1 = 6	2025-08-17 14:27:14.482368
94	Mathematics	SSCE	\N	If A = {1, 3, 5} and B = {2, 4, 6}, find A ∩ B.	["{1, 2}", "{}", "{3, 5}", "{2, 4}"]	1	A ∩ B = {} (no common elements)	2025-08-17 14:27:14.482368
95	Mathematics	SSCE	\N	Solve for x if 2x + y = 7 and x - 2y = 1.	["2", "3", "4", "5"]	0	Solve: 2x + y = 7, x - 2y = 1; From second, x = 2y + 1; Substitute: 2(2y + 1) + y = 7 => 4y + 2 + y = 7 => 5y = 5 => y = 1 => x = 2(1) + 1 = 3	2025-08-17 14:27:14.482368
96	Mathematics	SSCE	\N	Find the area of a sector with radius 6 cm and angle 60° (use π = 3.142).	["18.85 cm²", "37.70 cm²", "56.56 cm²", "12.57 cm²"]	0	Area = (θ/360) × πr² = (60/360) × 3.142 × 6² = (1/6) × 3.142 × 36 = 18.852 ≈ 18.85 cm²	2025-08-17 14:27:14.482368
97	Mathematics	SSCE	\N	If cos(θ) = 8/17 and θ is acute, find sin(θ).	["15/17", "8/15", "17/15", "8/17"]	0	cos²(θ) + sin²(θ) = 1 => sin²(θ) = 1 - (8/17)² = 1 - 64/289 = 225/289 => sin(θ) = 15/17	2025-08-17 14:27:14.482368
98	Mathematics	SSCE	\N	Solve the equation 2x² + 3x - 5 = 0.	["x = 1, -5/2", "x = -1, 5/2", "x = 2, -5", "x = -2, 5"]	0	2x² + 3x - 5 = (2x + 5)(x - 1) = 0 => x = -5/2, 1	2025-08-17 14:27:14.482368
99	Mathematics	SSCE	\N	Find the equation of the line parallel to y = 3x - 2 passing through (2, 4).	["y = 3x - 2", "y = 3x + 2", "y = 3x - 1", "y = 2x + 4"]	0	Parallel slope = 3; Using y - 4 = 3(x - 2) => y - 4 = 3x - 6 => y = 3x - 2	2025-08-17 14:27:14.482368
100	Mathematics	SSCE	\N	Find the standard deviation of the numbers 2, 4, 6.	["√2", "2", "√3", "3"]	0	Mean = 4; Variance = [(2-4)² + (4-4)² + (6-4)²]/3 = (4 + 0 + 4)/3 = 8/3; Standard deviation = √(8/3) ≈ √2	2025-08-17 14:27:14.482368
101	Mathematics	SSCE	\N	Evaluate (2/5) × (5/8).	["1/4", "1/2", "3/4", "1/8"]	0	(2/5) × (5/8) = 2/8 = 1/4	2025-08-17 14:27:14.482368
102	Mathematics	SSCE	\N	Find the volume of a sphere with radius 2 cm (use π = 3.142).	["33.49 cm³", "16.75 cm³", "8.37 cm³", "25.13 cm³"]	0	Volume = (4/3)πr³ = (4/3) × 3.142 × 2³ = (4/3) × 3.142 × 8 = 33.493 ≈ 33.49 cm³	2025-08-17 14:27:14.482368
103	Mathematics	SSCE	\N	If f(x) = 4x - 3, find f(0).	["-3", "0", "3", "4"]	0	f(x) = 4x - 3 => f(0) = 4(0) - 3 = -3	2025-08-17 14:27:14.482368
104	Mathematics	SSCE	\N	Simplify: (16x⁵)/(4x²).	["4x³", "4x²", "8x³", "8x²"]	0	(16x⁵)/(4x²) = (16/4)(x⁵/x²) = 4x^(5-2) = 4x³	2025-08-17 14:27:14.482368
105	Mathematics	SSCE	\N	Find the 4th term of the geometric sequence: 1, 3, 9, ...	["27", "81", "243", "729"]	0	a = 1, r = 3, n = 4; a₄ = ar^(n-1) = 1 × 3^(4-1) = 3³ = 27	2025-08-17 14:27:14.482368
106	Mathematics	SSCE	\N	What is the value of tan(60°)?	["1/√3", "√3", "1", "√2"]	1	tan(60°) = √3	2025-08-17 14:27:14.482368
107	Mathematics	SSCE	\N	Find the probability of selecting a consonant from the word 'BOOK'.	["1/4", "2/4", "3/4", "1/2"]	2	Consonants = {B, K}; Total letters = 4; Probability = 2/4 = 3/4	2025-08-17 14:27:14.482368
108	Mathematics	SSCE	\N	Solve for x: 2^(2x) = 16.	["1", "2", "3", "4"]	1	2^(2x) = 16 = 2⁴ => 2x = 4 => x = 2	2025-08-17 14:27:14.482368
109	Mathematics	SSCE	\N	Find the determinant of the matrix [[4, 3], [2, 1]].	["-2", "2", "-4", "4"]	0	Determinant = (4 × 1) - (3 × 2) = 4 - 6 = -2	2025-08-17 14:27:14.482368
110	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'VAST'.	["Huge", "Small", "Wide", "Enormous"]	1	'Vast' means very large, so the opposite is 'small'.	2025-08-17 14:27:14.482368
111	English	SSCE	\N	Identify the part of speech of the underlined word in: He *confidently* delivered the speech.	["Adjective", "Adverb", "Verb", "Noun"]	1	'Confidently' describes how he delivered the speech, making it an adverb.	2025-08-17 14:27:14.482368
112	English	SSCE	\N	Choose the correct form: Each of the students ___ a book.	["has", "have", "had", "having"]	0	'Each' is singular, so the singular verb 'has' is correct.	2025-08-17 14:27:14.482368
113	English	SSCE	\N	Which word is correctly spelled?	["Occurence", "Occurrence", "Ocurence", "Occurance"]	1	'Occurrence' is the correct spelling.	2025-08-17 14:27:14.482368
114	English	SSCE	\N	What is the synonym of 'PRUDENT'?	["Careless", "Wise", "Reckless", "Hasty"]	1	'Prudent' means cautious and wise in decision-making.	2025-08-17 14:27:14.482368
115	English	SSCE	\N	Choose the correct sentence.	["She sing beautifully.", "She sings beautifully.", "She singing beautifully.", "She sung beautifully."]	1	'She sings' uses the correct third-person singular present tense.	2025-08-17 14:27:14.482368
116	English	SSCE	\N	Which word has the correct stress pattern for 'PHOTOGRAPH'?	["PHOtograph", "phoTOgraph", "photoGRAPH", "PHOTograph"]	1	The stress in 'photograph' is on the second syllable: phoTOgraph.	2025-08-17 14:27:14.482368
117	English	SSCE	\N	Choose the word that best completes the sentence: The decision was ___ by the committee.	["Endorsed", "Ignored", "Postponed", "Criticized"]	0	'Endorsed' implies approval, fitting the context positively.	2025-08-17 14:27:14.482368
118	English	SSCE	\N	Identify the figure of speech in: 'The stars danced in the night sky.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	2	The stars are given a human quality (dancing), which is personification.	2025-08-17 14:27:14.482368
119	English	SSCE	\N	Choose the correct plural form of 'Mouse'.	["Mouses", "Mice", "Mices", "Mouse"]	1	The plural of 'mouse' is 'mice'.	2025-08-17 14:27:14.482368
120	English	SSCE	\N	What is the meaning of the idiom 'Break the ice'?	["To cause trouble", "To start a conversation", "To end a relationship", "To avoid responsibility"]	1	'Break the ice' means to initiate a conversation to ease tension.	2025-08-17 14:27:14.482368
121	English	SSCE	\N	Choose the correct preposition: He is interested ___ learning new skills.	["at", "in", "on", "with"]	1	The correct preposition is 'in' for 'interested in learning'.	2025-08-17 14:27:14.482368
122	English	SSCE	\N	Which word is a synonym for 'VIVID'?	["Dull", "Bright", "Vague", "Plain"]	1	'Vivid' means bright or clear, so 'bright' is the synonym.	2025-08-17 14:27:14.482368
123	English	SSCE	\N	Identify the type of sentence: 'Please close the door.'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	3	The sentence gives a command, making it imperative.	2025-08-17 14:27:14.482368
124	English	SSCE	\N	Choose the word with the same vowel sound as 'BOOK'.	["Boot", "Buck", "Bake", "Bike"]	1	The vowel sound in 'book' (/ʊ/) matches the vowel sound in 'buck'.	2025-08-17 14:27:14.482368
125	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'GENEROUS'.	["Kind", "Selfish", "Giving", "Charitable"]	1	'Generous' means giving freely, so the opposite is 'selfish'.	2025-08-17 14:27:14.482368
126	English	SSCE	\N	Identify the part of speech of the underlined word in: The *tall* building stood out.	["Adjective", "Adverb", "Noun", "Verb"]	0	'Tall' describes the building, making it an adjective.	2025-08-17 14:27:14.482368
127	English	SSCE	\N	Choose the correct form: Both of them ___ ready for the test.	["is", "are", "was", "has"]	1	'Both' is plural, so the plural verb 'are' is correct.	2025-08-17 14:27:14.482368
129	English	SSCE	\N	What is the synonym of 'OBSTACLE'?	["Advantage", "Barrier", "Benefit", "Solution"]	1	'Obstacle' means something that hinders progress, so 'barrier' is the synonym.	2025-08-17 14:27:14.482368
131	English	SSCE	\N	Which word has the correct stress pattern for 'INFORMATION'?	["inforMAtion", "INFOrmation", "inFORMation", "informAtion"]	2	The stress in 'information' is on the second syllable: inFORMation.	2025-08-17 14:27:14.482368
132	English	SSCE	\N	Choose the word that best completes the sentence: Her speech was ___ by the audience.	["Criticized", "Appreciated", "Ignored", "Delayed"]	1	'Appreciated' implies a positive response from the audience.	2025-08-17 14:27:14.482368
133	English	SSCE	\N	Identify the figure of speech in: 'Her smile was as bright as the sun.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	1	The comparison using 'as' indicates a simile.	2025-08-17 14:27:14.482368
134	English	SSCE	\N	Choose the correct plural form of 'Goose'.	["Gooses", "Geese", "Goosies", "Geeses"]	1	The plural of 'goose' is 'geese'.	2025-08-17 14:27:14.482368
135	English	SSCE	\N	What is the meaning of the idiom 'Spill the beans'?	["To keep a secret", "To reveal a secret", "To make a mistake", "To work hard"]	1	'Spill the beans' means to reveal a secret or hidden information.	2025-08-17 14:27:14.482368
136	English	SSCE	\N	Choose the correct preposition: He is fond ___ reading novels.	["of", "at", "in", "on"]	0	The correct preposition is 'of' in 'fond of reading'.	2025-08-17 14:27:14.482368
137	English	SSCE	\N	Which word is a synonym for 'FRAGILE'?	["Strong", "Delicate", "Durable", "Tough"]	1	'Fragile' means easily broken, so 'delicate' is the synonym.	2025-08-17 14:27:14.482368
138	English	SSCE	\N	Identify the type of sentence: 'Where is my book?'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	1	The sentence asks a question, making it interrogative.	2025-08-17 14:27:14.482368
139	English	SSCE	\N	Choose the word with the same vowel sound as 'SEAT'.	["Set", "See", "Sat", "Sot"]	1	The vowel sound in 'seat' (/i:/) matches the vowel sound in 'see'.	2025-08-17 14:27:14.482368
140	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'BRAVE'.	["Courageous", "Fearful", "Bold", "Valiant"]	1	'Brave' means having courage, so the opposite is 'fearful'.	2025-08-17 14:27:14.482368
141	English	SSCE	\N	Identify the part of speech of the underlined word in: She sang a *beautiful* song.	["Adjective", "Adverb", "Noun", "Verb"]	0	'Beautiful' describes the song, making it an adjective.	2025-08-17 14:27:14.482368
142	English	SSCE	\N	Choose the correct form: Neither the teacher nor the students ___ happy.	["is", "are", "was", "were"]	1	In 'neither...nor', the verb agrees with the closer subject 'students' (plural), so 'are' is correct.	2025-08-17 14:27:14.482368
144	English	SSCE	\N	What is the synonym of 'PERSISTENT'?	["Temporary", "Determined", "Weak", "Hesitant"]	1	'Persistent' means continuing firmly, so 'determined' is the synonym.	2025-08-17 14:27:14.482368
146	English	SSCE	\N	Which word has the correct stress pattern for 'DEVELOPMENT'?	["DEvelopment", "deVELopment", "developMENT", "deveLOPment"]	1	The stress in 'development' is on the second syllable: deVELopment.	2025-08-17 14:27:14.482368
147	English	SSCE	\N	Choose the word that best completes the sentence: The plan was ___ by the team.	["Rejected", "Accepted", "Delayed", "Cancelled"]	1	'Accepted' implies agreement, fitting the context positively.	2025-08-17 14:27:14.482368
148	English	SSCE	\N	Identify the figure of speech in: 'Time is a thief.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	0	'Time is a thief' directly compares time to a thief without using 'like' or 'as', making it a metaphor.	2025-08-17 14:27:14.482368
149	English	SSCE	\N	Choose the correct plural form of 'Leaf'.	["Leafs", "Leaves", "Leaaves", "Leafes"]	1	The plural of 'leaf' is 'leaves'.	2025-08-17 14:27:14.482368
150	English	SSCE	\N	What is the meaning of the idiom 'Kick the bucket'?	["To start a project", "To die", "To succeed", "To give up"]	1	'Kick the bucket' is an idiom meaning to die.	2025-08-17 14:27:14.482368
151	English	SSCE	\N	Choose the correct preposition: She is allergic ___ cats.	["to", "with", "at", "in"]	0	The correct preposition is 'to' in 'allergic to cats'.	2025-08-17 14:27:14.482368
152	English	SSCE	\N	Which word is a synonym for 'GLOOMY'?	["Cheerful", "Depressing", "Bright", "Lively"]	1	'Gloomy' means sad or depressing, so 'depressing' is the synonym.	2025-08-17 14:27:14.482368
153	English	SSCE	\N	Identify the type of sentence: 'How wonderful the sunset is!'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	2	The sentence expresses strong emotion with an exclamation mark, making it exclamatory.	2025-08-17 14:27:14.482368
154	English	SSCE	\N	Choose the word with the same vowel sound as 'CANE'.	["Can", "Cone", "Coin", "Cun"]	0	The vowel sound in 'cane' (/eɪ/) matches the vowel sound in 'can'.	2025-08-17 14:27:14.482368
155	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'HUMBLE'.	["Modest", "Arrogant", "Kind", "Gentle"]	1	'Humble' means modest or unpretentious, so the opposite is 'arrogant'.	2025-08-17 14:27:14.482368
156	English	SSCE	\N	Identify the part of speech of the underlined word in: The *dog* barked loudly.	["Adjective", "Adverb", "Noun", "Verb"]	2	'Dog' is a person, place, or thing, making it a noun.	2025-08-17 14:27:14.482368
157	English	SSCE	\N	Choose the correct form: The news ___ shocking.	["is", "are", "were", "have"]	0	'News' is singular, so the singular verb 'is' is correct.	2025-08-17 14:27:14.482368
159	English	SSCE	\N	What is the synonym of 'ADEQUATE'?	["Insufficient", "Enough", "Excessive", "Poor"]	1	'Adequate' means sufficient or enough.	2025-08-17 14:27:14.482368
161	English	SSCE	\N	Which word has the correct stress pattern for 'ECONOMY'?	["EConomy", "ecoNOMy", "eCONomy", "econOMY"]	2	The stress in 'economy' is on the second syllable: eCONomy.	2025-08-17 14:27:14.482368
162	English	SSCE	\N	Choose the word that best completes the sentence: His actions were ___ by his peers.	["Admired", "Condemned", "Ignored", "Delayed"]	0	'Admired' implies a positive response from peers.	2025-08-17 14:27:14.482368
163	English	SSCE	\N	Identify the figure of speech in: 'The room was a sea of colors.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	0	The room is directly compared to a sea without 'like' or 'as', making it a metaphor.	2025-08-17 14:27:14.482368
164	English	SSCE	\N	Choose the correct plural form of 'Tooth'.	["Tooths", "Teeth", "Toothes", "Teeths"]	1	The plural of 'tooth' is 'teeth'.	2025-08-17 14:27:14.482368
165	English	SSCE	\N	What is the meaning of the idiom 'Let the cat out of the bag'?	["To keep a secret", "To reveal a secret", "To start a fight", "To avoid trouble"]	1	'Let the cat out of the bag' means to reveal a secret.	2025-08-17 14:27:14.482368
166	English	SSCE	\N	Choose the correct preposition: She is responsible ___ the project.	["for", "to", "with", "at"]	0	The correct preposition is 'for' in 'responsible for the project'.	2025-08-17 14:27:14.482368
167	English	SSCE	\N	Which word is a synonym for 'HOSTILE'?	["Friendly", "Aggressive", "Peaceful", "Calm"]	1	'Hostile' means unfriendly or aggressive, so 'aggressive' is the synonym.	2025-08-17 14:27:14.482368
168	English	SSCE	\N	Identify the type of sentence: 'Bring me the book.'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	3	The sentence gives a command, making it imperative.	2025-08-17 14:27:14.482368
169	English	SSCE	\N	Choose the word with the same vowel sound as 'FOOD'.	["Foot", "Fool", "Fad", "Fun"]	1	The vowel sound in 'food' (/u:/) matches the vowel sound in 'fool'.	2025-08-17 14:27:14.482368
170	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'ANCIENT'.	["Old", "Modern", "Historic", "Traditional"]	1	'Ancient' means very old, so the opposite is 'modern'.	2025-08-17 14:27:14.482368
171	English	SSCE	\N	Identify the part of speech of the underlined word in: He *ran* to the station.	["Adjective", "Adverb", "Noun", "Verb"]	3	'Ran' indicates an action, making it a verb.	2025-08-17 14:27:14.482368
172	English	SSCE	\N	Choose the correct form: One of the cars ___ new.	["is", "are", "were", "have"]	0	'One' is singular, so the singular verb 'is' is correct.	2025-08-17 14:27:14.482368
174	English	SSCE	\N	What is the synonym of 'VIGOROUS'?	["Weak", "Energetic", "Tired", "Slow"]	1	'Vigorous' means strong and energetic.	2025-08-17 14:27:14.482368
176	English	SSCE	\N	Which word has the correct stress pattern for 'UNIVERSITY'?	["uniVERsity", "UNiversity", "univerSITY", "univERsity"]	2	The stress in 'university' is on the third syllable: univerSITY.	2025-08-17 14:27:14.482368
177	English	SSCE	\N	Choose the word that best completes the sentence: The book was ___ by the critics.	["Praised", "Ignored", "Banned", "Revised"]	0	'Praised' implies a positive response from critics.	2025-08-17 14:27:14.482368
178	English	SSCE	\N	Identify the figure of speech in: 'The leaves danced in the wind.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	2	The leaves are given a human quality (dancing), which is personification.	2025-08-17 14:27:14.482368
180	English	SSCE	\N	What is the meaning of the idiom 'Under the weather'?	["Feeling happy", "Feeling unwell", "Feeling excited", "Feeling angry"]	1	'Under the weather' means feeling unwell or sick.	2025-08-17 14:27:14.482368
181	English	SSCE	\N	Choose the correct preposition: He is afraid ___ heights.	["of", "at", "in", "with"]	0	The correct preposition is 'of' in 'afraid of heights'.	2025-08-17 14:27:14.482368
182	English	SSCE	\N	Which word is a synonym for 'CREDIBLE'?	["Unbelievable", "Believable", "Doubtful", "False"]	1	'Credible' means believable or trustworthy.	2025-08-17 14:27:14.482368
183	English	SSCE	\N	Identify the type of sentence: 'Is it raining outside?'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	1	The sentence asks a question, making it interrogative.	2025-08-17 14:27:14.482368
184	English	SSCE	\N	Choose the word with the same vowel sound as 'LIGHT'.	["Lit", "Let", "Late", "Loot"]	0	The vowel sound in 'light' (/aɪ/) matches the vowel sound in 'lit'.	2025-08-17 14:27:14.482368
185	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'POLITE'.	["Courteous", "Rude", "Kind", "Gentle"]	1	'Polite' means courteous, so the opposite is 'rude'.	2025-08-17 14:27:14.482368
186	English	SSCE	\N	Identify the part of speech of the underlined word in: She *carefully* opened the box.	["Adjective", "Adverb", "Noun", "Verb"]	1	'Carefully' describes how she opened the box, making it an adverb.	2025-08-17 14:27:14.482368
187	English	SSCE	\N	Choose the correct form: The committee ___ decided to proceed.	["has", "have", "had", "having"]	0	'Committee' is singular, so the singular verb 'has' is correct.	2025-08-17 14:27:14.482368
189	English	SSCE	\N	What is the synonym of 'SPONTANEOUS'?	["Planned", "Impulsive", "Forced", "Deliberate"]	1	'Spontaneous' means impulsive or unplanned.	2025-08-17 14:27:14.482368
191	English	SSCE	\N	Which word has the correct stress pattern for 'ADVERTISEMENT'?	["ADvertisement", "adVERtisement", "advertiseMENT", "adverTISEment"]	1	The stress in 'advertisement' is on the second syllable: adVERtisement.	2025-08-17 14:27:14.482368
192	English	SSCE	\N	Choose the word that best completes the sentence: The proposal was ___ by the board.	["Approved", "Rejected", "Postponed", "Ignored"]	0	'Approved' implies a positive decision by the board.	2025-08-17 14:27:14.482368
193	English	SSCE	\N	Identify the figure of speech in: 'His words cut like a knife.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	1	The comparison using 'like' indicates a simile.	2025-08-17 14:27:14.482368
194	English	SSCE	\N	Choose the correct plural form of 'Ox'.	["Oxes", "Oxen", "Oxies", "Oxs"]	1	The plural of 'ox' is 'oxen'.	2025-08-17 14:27:14.482368
195	English	SSCE	\N	What is the meaning of the idiom 'Hit the nail on the head'?	["To miss the point", "To be exactly right", "To make a mistake", "To avoid responsibility"]	1	'Hit the nail on the head' means to be exactly right about something.	2025-08-17 14:27:14.482368
196	English	SSCE	\N	Choose the correct preposition: She is excited ___ the trip.	["about", "with", "at", "in"]	0	The correct preposition is 'about' in 'excited about the trip'.	2025-08-17 14:27:14.482368
197	English	SSCE	\N	Which word is a synonym for 'TRANQUIL'?	["Chaotic", "Peaceful", "Noisy", "Restless"]	1	'Tranquil' means calm or peaceful.	2025-08-17 14:27:14.482368
198	English	SSCE	\N	Identify the type of sentence: 'The concert was amazing!'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	2	The sentence expresses strong emotion with an exclamation mark, making it exclamatory.	2025-08-17 14:27:14.482368
199	English	SSCE	\N	Choose the word with the same vowel sound as 'FATE'.	["Fat", "Feet", "Fit", "Fete"]	3	The vowel sound in 'fate' (/eɪ/) matches the vowel sound in 'fete'.	2025-08-17 14:27:14.482368
200	English	SSCE	\N	Choose the word most nearly opposite in meaning to 'FLEXIBLE'.	["Adaptable", "Rigid", "Pliable", "Soft"]	1	'Flexible' means adaptable or bendable, so the opposite is 'rigid'.	2025-08-17 14:27:14.482368
201	English	SSCE	\N	Identify the part of speech of the underlined word in: The *river* flows gently.	["Adjective", "Adverb", "Noun", "Verb"]	2	'River' is a person, place, or thing, making it a noun.	2025-08-17 14:27:14.482368
202	English	SSCE	\N	Choose the correct form: All the books ___ on the shelf.	["is", "are", "was", "has"]	1	'Books' is plural, so the plural verb 'are' is correct.	2025-08-17 14:27:14.482368
204	English	SSCE	\N	What is the synonym of 'INNOVATIVE'?	["Traditional", "Creative", "Ordinary", "Old"]	1	'Innovative' means introducing new ideas, so 'creative' is the synonym.	2025-08-17 14:27:14.482368
206	English	SSCE	\N	Which word has the correct stress pattern for 'EXAMINATION'?	["exAMInation", "examINAtion", "exaMINation", "examinAtion"]	2	The stress in 'examination' is on the third syllable: exaMINation.	2025-08-17 14:27:14.482368
207	English	SSCE	\N	Choose the word that best completes the sentence: The event was ___ by everyone.	["Celebrated", "Ignored", "Cancelled", "Postponed"]	0	'Celebrated' implies a positive response from everyone.	2025-08-17 14:27:14.482368
208	English	SSCE	\N	Identify the figure of speech in: 'The world is a stage.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	0	The world is directly compared to a stage without 'like' or 'as', making it a metaphor.	2025-08-17 14:27:14.482368
209	English	SSCE	\N	Choose the correct plural form of 'Child'.	["Childs", "Children", "Childrens", "Childes"]	1	The plural of 'child' is 'children'.	2025-08-17 14:27:14.482368
210	English	SSCE	\N	What is the meaning of the idiom 'Bite the bullet'?	["To avoid a problem", "To face a difficult situation bravely", "To give up easily", "To criticize someone"]	1	'Bite the bullet' means to endure a painful or difficult situation with courage.	2025-08-17 14:27:14.482368
211	English	SSCE	\N	Choose the correct preposition: He is good ___ mathematics.	["at", "in", "on", "with"]	0	The correct preposition is 'at' in 'good at mathematics'.	2025-08-17 14:27:14.482368
212	English	SSCE	\N	Which word is a synonym for 'BRIEF'?	["Long", "Short", "Detailed", "Complex"]	1	'Brief' means short in duration or extent, so 'short' is the synonym.	2025-08-17 14:27:14.482368
578	Mathematics	SSCE	\N	What is the value of 2/3 ÷ 4/5?	["5/6", "8/15", "10/12", "15/8"]	0	2/3 ÷ 4/5 = 2/3 × 5/4 = 10/12 = 5/6	2025-08-17 20:27:11.116863
579	Mathematics	SSCE	\N	Find the determinant of the matrix [[2, 3], [1, 4]].	["5", "7", "8", "11"]	0	Determinant = (2 × 4) - (3 × 1) = 8 - 3 = 5	2025-08-17 20:27:11.116863
580	Mathematics	SSCE	\N	If sin(θ) = 0.8, what is cos²(θ)?	["0.36", "0.64", "0.2", "0.8"]	0	sin²(θ) + cos²(θ) = 1 => cos²(θ) = 1 - sin²(θ) = 1 - (0.8)² = 1 - 0.64 = 0.36	2025-08-17 20:27:11.116863
581	Mathematics	SSCE	\N	Find the sum of the first 5 terms of the sequence: 1, 3, 5, 7, 9.	["20", "25", "30", "35"]	0	Sum = 1 + 3 + 5 + 7 + 9 = 25	2025-08-17 20:27:11.116863
582	Mathematics	SSCE	\N	Solve for x: 2x/3 + 4 = 10.	["3", "6", "9", "12"]	2	2x/3 + 4 = 10 => 2x/3 = 6 => 2x = 18 => x = 9	2025-08-17 20:27:11.116863
583	Mathematics	SSCE	\N	What is the value of 3² + 4²?	["25", "16", "20", "7"]	0	3² + 4² = 9 + 16 = 25	2025-08-17 20:27:11.116863
213	English	SSCE	\N	Identify the type of sentence: 'What a beautiful day it is!'	["Declarative", "Interrogative", "Exclamatory", "Imperative"]	2	The sentence expresses strong emotion with an exclamation mark, making it exclamatory.	2025-08-17 14:27:14.482368
214	English	SSCE	\N	Choose the word with the same vowel sound as 'CAT'.	["Hate", "Hat", "Height", "Hot"]	1	The vowel sound in 'cat' (/æ/) matches the vowel sound in 'hat'.	2025-08-17 14:27:14.482368
538	Mathematics	SSCE	\N	Solve for x: 4x - 8 = 12	["3", "4", "5", "6"]	2	4x - 8 = 12 => 4x = 20 => x = 5	2025-08-17 20:27:11.116863
539	Mathematics	SSCE	\N	What is the value of log₃(27)?	["1", "2", "3", "4"]	2	log₃(27) = log₃(3³) = 3	2025-08-17 20:27:11.116863
540	Mathematics	SSCE	\N	Find the area of a circle with radius 5 cm (use π = 3.142).	["78.55 cm²", "15.71 cm²", "31.42 cm²", "25 cm²"]	0	Area = πr² = 3.142 × 5² = 3.142 × 25 = 78.55 cm²	2025-08-17 20:27:11.116863
541	Mathematics	SSCE	\N	If cos(θ) = 0.6 and θ is acute, what is sin(θ)?	["0.8", "0.6", "0.4", "0.2"]	0	cos²(θ) + sin²(θ) = 1 => sin²(θ) = 1 - (0.6)² = 1 - 0.36 = 0.64 => sin(θ) = 0.8	2025-08-17 20:27:11.116863
542	Mathematics	SSCE	\N	Solve the equation x² - 6x + 8 = 0.	["x = 2, 4", "x = 1, 8", "x = -2, -4", "x = 3, 5"]	0	x² - 6x + 8 = (x - 2)(x - 4) = 0 => x = 2, 4	2025-08-17 20:27:11.116863
543	Mathematics	SSCE	\N	Find the gradient of the line 5x + 2y = 10.	["-5/2", "5/2", "-2/5", "2/5"]	0	5x + 2y = 10 => 2y = -5x + 10 => y = (-5/2)x + 5 => gradient = -5/2	2025-08-17 20:27:11.116863
544	Mathematics	SSCE	\N	Calculate the median of the numbers 2, 5, 8, 11, 14.	["5", "8", "11", "7"]	1	Arrange in order: 2, 5, 8, 11, 14 => median = 8	2025-08-17 20:27:11.116863
545	Mathematics	SSCE	\N	Evaluate 2³ × 5².	["40", "100", "200", "400"]	2	2³ = 8, 5² = 25 => 8 × 25 = 200	2025-08-17 20:27:11.116863
546	Mathematics	SSCE	\N	Find the volume of a cube with side length 6 cm.	["36 cm³", "108 cm³", "216 cm³", "144 cm³"]	2	Volume = side³ = 6³ = 216 cm³	2025-08-17 20:27:11.116863
547	Mathematics	SSCE	\N	If f(x) = 3x² - 4x + 1, find f(2).	["5", "9", "13", "17"]	0	f(x) = 3x² - 4x + 1 => f(2) = 3(2²) - 4(2) + 1 = 12 - 8 + 1 = 5	2025-08-17 20:27:11.116863
548	Mathematics	SSCE	\N	Simplify: (2x²y³)/(4xy²).	["x/2y", "x/y", "2xy", "x/2"]	0	(2x²y³)/(4xy²) = (2/4)(x²/x)(y³/y²) = (1/2)x^(2-1)y^(3-2) = x/2y	2025-08-17 20:27:11.116863
549	Mathematics	SSCE	\N	Find the sum of the first 10 terms of the arithmetic sequence: 3, 7, 11, ...	["200", "210", "220", "230"]	1	a = 3, d = 4, n = 10; Sum = n/2[2a + (n-1)d] = 10/2[2(3) + (10-1)4] = 5[6 + 36] = 5 × 42 = 210	2025-08-17 20:27:11.116863
550	Mathematics	SSCE	\N	What is the value of tan(45°)?	["0", "1", "√2", "√3"]	1	tan(45°) = 1	2025-08-17 20:27:11.116863
551	Mathematics	SSCE	\N	Find the probability of rolling a 6 on a fair six-sided die.	["1/6", "1/3", "1/2", "1/4"]	0	Probability = 1 favorable outcome / 6 possible outcomes = 1/6	2025-08-17 20:27:11.116863
552	Mathematics	SSCE	\N	Solve for x: 2^(x+1) = 8.	["1", "2", "3", "4"]	2	2^(x+1) = 8 = 2³ => x + 1 = 3 => x = 2	2025-08-17 20:27:11.116863
553	Mathematics	SSCE	\N	Find the area of a rectangle with length 8 cm and width 5 cm.	["40 cm²", "13 cm²", "26 cm²", "48 cm²"]	0	Area = length × width = 8 × 5 = 40 cm²	2025-08-17 20:27:11.116863
554	Mathematics	SSCE	\N	Simplify: √50.	["5√2", "10√2", "5√5", "2√5"]	0	√50 = √(25 × 2) = 5√2	2025-08-17 20:27:11.116863
555	Mathematics	SSCE	\N	Solve for x: 3x + 5 = 2x + 7.	["1", "2", "3", "4"]	1	3x + 5 = 2x + 7 => 3x - 2x = 7 - 5 => x = 2	2025-08-17 20:27:11.116863
556	Mathematics	SSCE	\N	Find the value of sin(30°).	["0", "1/2", "√3/2", "1"]	1	sin(30°) = 1/2	2025-08-17 20:27:11.116863
557	Mathematics	SSCE	\N	What is the sum of the angles in a triangle?	["90°", "180°", "270°", "360°"]	1	The sum of angles in a triangle is always 180°.	2025-08-17 20:27:11.116863
558	Mathematics	SSCE	\N	Solve for x: x² - 4 = 0.	["x = ±1", "x = ±2", "x = ±3", "x = ±4"]	1	x² - 4 = (x - 2)(x + 2) = 0 => x = ±2	2025-08-17 20:27:11.116863
559	Mathematics	SSCE	\N	Find the mean of the numbers 3, 6, 9, 12, 15.	["6", "9", "12", "15"]	1	Mean = (3 + 6 + 9 + 12 + 15) / 5 = 45 / 5 = 9	2025-08-17 20:27:11.116863
560	Mathematics	SSCE	\N	Evaluate: 4! (factorial).	["12", "24", "36", "48"]	1	4! = 4 × 3 × 2 × 1 = 24	2025-08-17 20:27:11.116863
561	Mathematics	SSCE	\N	Find the circumference of a circle with diameter 14 cm (use π = 22/7).	["44 cm", "22 cm", "88 cm", "66 cm"]	0	Circumference = πd = (22/7) × 14 = 44 cm	2025-08-17 20:27:11.116863
562	Mathematics	SSCE	\N	If a = 2 and b = 3, find the value of a² + b².	["5", "10", "13", "25"]	2	a² + b² = 2² + 3² = 4 + 9 = 13	2025-08-17 20:27:11.116863
564	Mathematics	SSCE	\N	Find the area of a trapezium with parallel sides 6 cm and 10 cm, and height 4 cm.	["32 cm²", "40 cm²", "48 cm²", "64 cm²"]	0	Area = (1/2)(a + b)h = (1/2)(6 + 10) × 4 = (1/2) × 16 × 4 = 32 cm²	2025-08-17 20:27:11.116863
565	Mathematics	SSCE	\N	What is the value of 3/4 + 1/2?	["5/4", "3/2", "1/4", "7/4"]	0	3/4 + 1/2 = 3/4 + 2/4 = 5/4	2025-08-17 20:27:11.116863
566	Mathematics	SSCE	\N	Find the roots of the quadratic equation x² + 2x - 3 = 0.	["x = 1, -3", "x = -1, 3", "x = 2, -1", "x = -2, 1"]	0	x² + 2x - 3 = (x + 3)(x - 1) = 0 => x = 1, -3	2025-08-17 20:27:11.116863
567	Mathematics	SSCE	\N	What is the value of cos(60°)?	["0", "1/2", "√3/2", "1"]	1	cos(60°) = 1/2	2025-08-17 20:27:11.116863
568	Mathematics	SSCE	\N	Find the mode of the numbers 2, 3, 3, 4, 5, 5, 5, 6.	["3", "4", "5", "6"]	2	Mode is the number that appears most frequently: 5 appears three times.	2025-08-17 20:27:11.116863
569	Mathematics	SSCE	\N	Simplify: (3x³)/(9x).	["x²/3", "x²", "3x²", "x/3"]	0	(3x³)/(9x) = (3/9)(x³/x) = (1/3)x^(3-1) = x²/3	2025-08-17 20:27:11.116863
570	Mathematics	SSCE	\N	Find the sum of the geometric sequence: 2, 4, 8, 16 (4 terms).	["28", "30", "32", "34"]	0	a = 2, r = 2, n = 4; Sum = a(r^n - 1)/(r - 1) = 2(2⁴ - 1)/(2 - 1) = 2(16 - 1)/1 = 30	2025-08-17 20:27:11.116863
571	Mathematics	SSCE	\N	What is the value of 2 + 3 × 4?	["20", "14", "12", "10"]	1	Using BODMAS: 3 × 4 = 12, then 2 + 12 = 14	2025-08-17 20:27:11.116863
572	Mathematics	SSCE	\N	Find the distance between points (2, 3) and (5, 7).	["5", "6", "7", "8"]	0	Distance = √[(5-2)² + (7-3)²] = √[3² + 4²] = √(9 + 16) = √25 = 5	2025-08-17 20:27:11.116863
573	Mathematics	SSCE	\N	If f(x) = x³ - 2x, find f(-1).	["-1", "0", "1", "2"]	0	f(x) = x³ - 2x => f(-1) = (-1)³ - 2(-1) = -1 + 2 = 1	2025-08-17 20:27:11.116863
574	Mathematics	SSCE	\N	What is the value of 5! ÷ 3! ?	["20", "40", "60", "120"]	0	5! = 120, 3! = 6 => 120/6 = 20	2025-08-17 20:27:11.116863
575	Mathematics	SSCE	\N	Find the volume of a cylinder with radius 3 cm and height 5 cm (use π = 3.142).	["141.39 cm³", "94.26 cm³", "47.13 cm³", "282.78 cm³"]	0	Volume = πr²h = 3.142 × 3² × 5 = 3.142 × 9 × 5 = 141.39 cm³	2025-08-17 20:27:11.116863
576	Mathematics	SSCE	\N	Solve for x: |x - 3| = 5.	["x = 8, -2", "x = 5, -5", "x = 3, -3", "x = 8, -8"]	0	|x - 3| = 5 => x - 3 = 5 or x - 3 = -5 => x = 8 or x = -2	2025-08-17 20:27:11.116863
584	Mathematics	SSCE	\N	Find the area of a sector of a circle with radius 7 cm and sector angle 60° (use π = 22/7).	["22 cm²", "44 cm²", "66 cm²", "88 cm²"]	0	Area = (θ/360) × πr² = (60/360) × (22/7) × 7² = (1/6) × 22 × 7 = 22 cm²	2025-08-17 20:27:11.116863
585	Mathematics	SSCE	\N	Solve for x: 3x² - 12 = 0.	["x = ±2", "x = ±3", "x = ±4", "x = ±5"]	0	3x² - 12 = 0 => x² = 4 => x = ±2	2025-08-17 20:27:11.116863
586	Mathematics	SSCE	\N	What is the probability of drawing an ace from a standard deck of 52 cards?	["1/13", "1/26", "1/52", "4/52"]	0	There are 4 aces in 52 cards => Probability = 4/52 = 1/13	2025-08-17 20:27:11.116863
587	Mathematics	SSCE	\N	Find the value of x in the equation: log₂(x) = 4.	["8", "16", "32", "64"]	1	log₂(x) = 4 => x = 2⁴ = 16	2025-08-17 20:27:11.116863
588	Mathematics	SSCE	\N	What is the slope-intercept form of the line 3x - 4y = 12?	["y = (3/4)x - 3", "y = (4/3)x + 3", "y = -(3/4)x + 3", "y = -(4/3)x - 3"]	0	3x - 4y = 12 => -4y = -3x + 12 => y = (3/4)x - 3	2025-08-17 20:27:11.116863
590	Mathematics	SSCE	\N	Simplify: (2/5) × (15/4).	["3/2", "2/3", "5/6", "6/5"]	0	(2/5) × (15/4) = (2 × 15)/(5 × 4) = 30/20 = 3/2	2025-08-17 20:27:11.116863
591	Mathematics	SSCE	\N	Find the value of x: 2x - 3 = x + 5.	["6", "7", "8", "9"]	2	2x - 3 = x + 5 => 2x - x = 5 + 3 => x = 8	2025-08-17 20:27:11.116863
593	Mathematics	SSCE	\N	Find the area of a parallelogram with base 8 cm and height 5 cm.	["40 cm²", "48 cm²", "32 cm²", "24 cm²"]	0	Area = base × height = 8 × 5 = 40 cm²	2025-08-17 20:27:11.116863
594	Mathematics	SSCE	\N	Solve for x: 4^(x+2) = 64.	["1", "2", "3", "4"]	1	4^(x+2) = 64 = 4³ => x + 2 = 3 => x = 1	2025-08-17 20:27:11.116863
595	Mathematics	SSCE	\N	What is the median of the numbers 1, 3, 5, 7, 9, 11?	["5", "6", "7", "8"]	0	Arrange in order: 1, 3, 5, 7, 9, 11 => median = (5 + 7)/2 = 6	2025-08-17 20:27:11.116863
596	Mathematics	SSCE	\N	Simplify: 3√8.	["6√2", "3√2", "8√3", "2√3"]	0	√8 = √(4 × 2) = 2√2 => 3√8 = 3 × 2√2 = 6√2	2025-08-17 20:27:11.116863
597	Mathematics	SSCE	\N	Find the sum of the first 8 terms of the sequence: 1, 2, 4, 8, ...	["255", "256", "510", "511"]	0	a = 1, r = 2, n = 8; Sum = a(r^n - 1)/(r - 1) = 1(2⁸ - 1)/(2 - 1) = (256 - 1)/1 = 255	2025-08-17 20:27:11.116863
598	Mathematics	SSCE	\N	What is the value of 5 - 2 × 3?	["-1", "1", "9", "15"]	0	Using BODMAS: 2 × 3 = 6, then 5 - 6 = -1	2025-08-17 20:27:11.116863
599	Mathematics	SSCE	\N	Find the equation of the line through (1, 2) with slope 3.	["y = 3x - 1", "y = 3x + 1", "y = 2x + 1", "y = 2x - 1"]	0	y - y₁ = m(x - x₁) => y - 2 = 3(x - 1) => y = 3x - 3 + 2 => y = 3x - 1	2025-08-17 20:27:11.116863
600	Mathematics	SSCE	\N	Solve for x: x² + 5x + 6 = 0.	["x = -2, -3", "x = -1, -6", "x = 2, 3", "x = 1, 6"]	0	x² + 5x + 6 = (x + 2)(x + 3) = 0 => x = -2, -3	2025-08-17 20:27:11.116863
601	Mathematics	SSCE	\N	What is the value of 2/5 + 3/10?	["7/10", "1/2", "4/5", "9/10"]	0	2/5 + 3/10 = 4/10 + 3/10 = 7/10	2025-08-17 20:27:11.116863
602	Mathematics	SSCE	\N	Find the area of a triangle with sides 3 cm, 4 cm, and 5 cm.	["6 cm²", "8 cm²", "10 cm²", "12 cm²"]	0	Using Heron's formula: s = (3+4+5)/2 = 6; Area = √[6(6-3)(6-4)(6-5)] = √[6×3×2×1] = √36 = 6 cm²	2025-08-17 20:27:11.116863
603	Mathematics	SSCE	\N	What is the value of sin²(45°) + cos²(45°)?	["0", "1/2", "1", "2"]	2	sin²(45°) + cos²(45°) = (√2/2)² + (√2/2)² = 1/2 + 1/2 = 1	2025-08-17 20:27:11.116863
604	Mathematics	SSCE	\N	Find the value of x: 3x - 7 = 8.	["3", "4", "5", "6"]	2	3x - 7 = 8 => 3x = 15 => x = 5	2025-08-17 20:27:11.116863
605	Mathematics	SSCE	\N	What is the value of 4³ ÷ 2²?	["8", "16", "32", "64"]	1	4³ = 64, 2² = 4 => 64/4 = 16	2025-08-17 20:27:11.116863
607	Mathematics	SSCE	\N	Simplify: (x² + 2x + 1)/(x + 1).	["x + 1", "x - 1", "x + 2", "x"]	0	(x² + 2x + 1)/(x + 1) = (x + 1)²/(x + 1) = x + 1	2025-08-17 20:27:11.116863
608	Mathematics	SSCE	\N	What is the value of 6C2 (combinations)?	["12", "15", "20", "30"]	1	6C2 = 6!/(2!(6-2)!) = (6×5)/(2×1) = 15	2025-08-17 20:27:11.116863
609	Mathematics	SSCE	\N	Find the value of x: log₁₀(100) = x.	["1", "2", "3", "4"]	1	log₁₀(100) = log₁₀(10²) = 2	2025-08-17 20:27:11.116863
610	Mathematics	SSCE	\N	What is the surface area of a cube with side length 4 cm?	["64 cm²", "96 cm²", "128 cm²", "144 cm²"]	0	Surface area = 6a² = 6 × 4² = 6 × 16 = 96 cm²	2025-08-17 20:27:11.116863
611	Mathematics	SSCE	\N	Solve for x: 2x + 3y = 12 and x + y = 5.	["x = 2, y = 3", "x = 3, y = 2", "x = 4, y = 1", "x = 1, y = 4"]	1	From x + y = 5, x = 5 - y. Substitute into 2x + 3y = 12: 2(5 - y) + 3y = 12 => 10 - 2y + 3y = 12 => y = 2. Then x = 5 - 2 = 3.	2025-08-17 20:27:11.116863
612	Mathematics	SSCE	\N	What is the value of cos(0°)?	["0", "1/2", "1", "√3/2"]	2	cos(0°) = 1	2025-08-17 20:27:11.116863
613	Mathematics	SSCE	\N	Find the range of the numbers 10, 15, 20, 25, 30.	["15", "20", "25", "30"]	0	Range = max - min = 30 - 10 = 20	2025-08-17 20:27:11.116863
614	Mathematics	SSCE	\N	Simplify: (4x²)/(2x).	["2x", "4x", "x", "2"]	0	(4x²)/(2x) = (4/2)(x²/x) = 2x	2025-08-17 20:27:11.116863
615	Mathematics	SSCE	\N	What is the value of 3/5 × 10/9?	["2/3", "3/5", "5/6", "2/5"]	0	3/5 × 10/9 = (3 × 10)/(5 × 9) = 30/45 = 2/3	2025-08-17 20:27:11.116863
616	Mathematics	SSCE	\N	Find the value of x: x² - 2x - 8 = 0.	["x = 4, -2", "x = 2, -4", "x = 3, -5", "x = -3, 5"]	0	x² - 2x - 8 = (x - 4)(x + 2) = 0 => x = 4, -2	2025-08-17 20:27:11.116863
618	Mathematics	SSCE	\N	Find the area of a square with side length 9 cm.	["36 cm²", "81 cm²", "72 cm²", "64 cm²"]	1	Area = side² = 9² = 81 cm²	2025-08-17 20:27:11.116863
619	Mathematics	SSCE	\N	Solve for x: 3^(x-2) = 27.	["3", "4", "5", "6"]	2	3^(x-2) = 27 = 3³ => x - 2 = 3 => x = 5	2025-08-17 20:27:11.116863
620	Mathematics	SSCE	\N	What is the mode of the numbers 1, 2, 2, 3, 3, 3, 4?	["1", "2", "3", "4"]	2	Mode is the number that appears most frequently: 3 appears three times.	2025-08-17 20:27:11.116863
621	Mathematics	SSCE	\N	Find the value of x: 2x + 5 = 3x - 2.	["5", "6", "7", "8"]	2	2x + 5 = 3x - 2 => 5 + 2 = 3x - 2x => x = 7	2025-08-17 20:27:11.116863
622	Mathematics	SSCE	\N	What is the value of 4/7 + 2/7?	["6/7", "2/7", "4/7", "8/7"]	0	4/7 + 2/7 = (4 + 2)/7 = 6/7	2025-08-17 20:27:11.116863
623	Mathematics	SSCE	\N	Find the area of a circle with diameter 10 cm (use π = 3.142).	["78.55 cm²", "31.42 cm²", "157.1 cm²", "314.2 cm²"]	0	Radius = 10/2 = 5 cm; Area = πr² = 3.142 × 5² = 3.142 × 25 = 78.55 cm²	2025-08-17 20:27:11.116863
624	Mathematics	SSCE	\N	Solve for x: x/2 + 3 = 7.	["6", "7", "8", "9"]	0	x/2 + 3 = 7 => x/2 = 4 => x = 8	2025-08-17 20:27:11.116863
625	Mathematics	SSCE	\N	What is the value of 3! × 2! ?	["6", "12", "18", "24"]	1	3! = 6, 2! = 2 => 6 × 2 = 12	2025-08-17 20:27:11.116863
626	Mathematics	SSCE	\N	Find the value of x: 4x - 2 = 2x + 6.	["3", "4", "5", "6"]	2	4x - 2 = 2x + 6 => 4x - 2x = 6 + 2 => 2x = 8 => x = 4	2025-08-17 20:27:11.116863
628	Mathematics	SSCE	\N	Find the sum of the first 6 terms of the sequence: 2, 4, 6, 8, 10, 12.	["36", "42", "48", "54"]	0	Sum = 2 + 4 + 6 + 8 + 10 + 12 = 42	2025-08-17 20:27:11.116863
629	Mathematics	SSCE	\N	Solve for x: x² - 9 = 0.	["x = ±2", "x = ±3", "x = ±4", "x = ±5"]	1	x² - 9 = (x - 3)(x + 3) = 0 => x = ±3	2025-08-17 20:27:11.116863
630	Mathematics	SSCE	\N	What is the value of 5/6 - 1/3?	["1/2", "1/3", "2/3", "1/6"]	0	5/6 - 1/3 = 5/6 - 2/6 = 3/6 = 1/2	2025-08-17 20:27:11.116863
631	Mathematics	SSCE	\N	Find the area of a rectangle with length 12 cm and width 7 cm.	["84 cm²", "96 cm²", "72 cm²", "108 cm²"]	0	Area = length × width = 12 × 7 = 84 cm²	2025-08-17 20:27:11.116863
632	Mathematics	SSCE	\N	Simplify: √72.	["6√2", "8√2", "4√3", "3√2"]	0	√72 = √(36 × 2) = 6√2	2025-08-17 20:27:11.116863
633	Mathematics	SSCE	\N	What is the value of 2 + 3 × 5 - 4?	["13", "15", "17", "19"]	0	Using BODMAS: 3 × 5 = 15, 2 + 15 = 17, 17 - 4 = 13	2025-08-17 20:27:11.116863
634	Mathematics	SSCE	\N	Find the value of x: 5x/2 = 15.	["3", "4", "5", "6"]	3	5x/2 = 15 => 5x = 30 => x = 6	2025-08-17 20:27:11.116863
636	Mathematics	SSCE	\N	Find the determinant of the matrix [[1, 2], [3, 4]].	["-2", "2", "-3", "3"]	0	Determinant = (1 × 4) - (2 × 3) = 4 - 6 = -2	2025-08-17 20:27:11.116863
637	Mathematics	SSCE	\N	Solve for x: 3x + 4 = 2x + 9.	["3", "4", "5", "6"]	2	3x + 4 = 2x + 9 => 3x - 2x = 9 - 4 => x = 5	2025-08-17 20:27:11.116863
638	Mathematics	SSCE	\N	What is the value of 2³ × 3²?	["72", "48", "36", "24"]	0	2³ = 8, 3² = 9 => 8 × 9 = 72	2025-08-17 20:27:11.116863
639	Mathematics	SSCE	\N	Find the area of a triangle with base 10 cm and height 6 cm.	["30 cm²", "60 cm²", "15 cm²", "45 cm²"]	0	Area = (1/2) × base × height = (1/2) × 10 × 6 = 30 cm²	2025-08-17 20:27:11.116863
640	Mathematics	SSCE	\N	Solve for x: x² + 6x + 9 = 0.	["x = -3", "x = 3", "x = ±3", "x = ±6"]	0	x² + 6x + 9 = (x + 3)² = 0 => x = -3	2025-08-17 20:27:11.116863
641	Mathematics	SSCE	\N	What is the value of 4/5 ÷ 2/3?	["6/5", "8/15", "5/6", "15/8"]	0	4/5 ÷ 2/3 = 4/5 × 3/2 = 12/10 = 6/5	2025-08-17 20:27:11.116863
642	Mathematics	SSCE	\N	Find the value of x: log₅(25) = x.	["1", "2", "3", "4"]	1	log₅(25) = log₅(5²) = 2	2025-08-17 20:27:11.116863
643	Mathematics	SSCE	\N	What is the surface area of a sphere with radius 3 cm (use π = 3.142)?	["113.112 cm²", "37.704 cm²", "75.408 cm²", "226.224 cm²"]	0	Surface area = 4πr² = 4 × 3.142 × 3² = 4 × 3.142 × 9 = 113.112 cm²	2025-08-17 20:27:11.116863
644	Mathematics	SSCE	\N	Solve for x: 2x + 3 = 9.	["2", "3", "4", "5"]	1	2x + 3 = 9 => 2x = 6 => x = 3	2025-08-17 20:27:11.116863
645	Mathematics	SSCE	\N	What is the value of 5² - 3²?	["16", "25", "34", "9"]	0	5² - 3² = 25 - 9 = 16	2025-08-17 20:27:11.116863
646	Mathematics	SSCE	\N	Find the probability of tossing a head on a fair coin.	["1/4", "1/3", "1/2", "2/3"]	2	Probability = 1 favorable outcome / 2 possible outcomes = 1/2	2025-08-17 20:27:11.116863
647	Mathematics	SSCE	\N	Solve for x: x² - 5x + 6 = 0.	["x = 2, 3", "x = 1, 6", "x = -2, -3", "x = 5, 1"]	0	x² - 5x + 6 = (x - 2)(x - 3) = 0 => x = 2, 3	2025-08-17 20:27:11.116863
649	Mathematics	SSCE	\N	Find the volume of a rectangular prism with length 5 cm, width 4 cm, and height 3 cm.	["60 cm³", "48 cm³", "36 cm³", "72 cm³"]	0	Volume = length × width × height = 5 × 4 × 3 = 60 cm³	2025-08-17 20:27:11.116863
650	Mathematics	SSCE	\N	Simplify: (6x⁴)/(3x²).	["2x²", "3x²", "2x", "3x"]	0	(6x⁴)/(3x²) = (6/3)(x⁴/x²) = 2x^(4-2) = 2x²	2025-08-17 20:27:11.116863
651	Mathematics	SSCE	\N	What is the value of 3/8 + 5/8?	["1", "7/8", "8/8", "6/8"]	0	3/8 + 5/8 = (3 + 5)/8 = 8/8 = 1	2025-08-17 20:27:11.116863
652	Government	SSCE	\N	What is the term for the supreme power of a state to govern itself?	["Authority", "Sovereignty", "Legitimacy", "Power"]	1	Sovereignty refers to the supreme power of a state to govern itself without external interference.	2025-08-17 20:27:11.116863
653	Government	SSCE	\N	Which system of government has a single ruler with absolute power?	["Democracy", "Monarchy", "Oligarchy", "Republic"]	1	A monarchy, particularly an absolute monarchy, vests supreme power in a single ruler.	2025-08-17 20:27:11.116863
654	Government	SSCE	\N	What is the term for a government ruled by a few powerful individuals?	["Democracy", "Oligarchy", "Monarchy", "Theocracy"]	1	Oligarchy is a system where a small group of people hold power.	2025-08-17 20:27:11.116863
655	Government	SSCE	\N	Which document outlines the fundamental laws of a country?	["Legislation", "Constitution", "Manifesto", "Treaty"]	1	A constitution is a document that outlines the fundamental laws and principles of a country.	2025-08-17 20:27:11.116863
656	Government	SSCE	\N	What is the term for a government where citizens participate directly in decision-making?	["Representative democracy", "Direct democracy", "Constitutional monarchy", "Dictatorship"]	1	Direct democracy allows citizens to participate directly in decision-making processes.	2025-08-17 20:27:11.116863
657	Government	SSCE	\N	Which arm of government is responsible for making laws?	["Executive", "Legislature", "Judiciary", "Bureaucracy"]	1	The legislature is responsible for making laws in a government.	2025-08-17 20:27:11.116863
658	Government	SSCE	\N	What is the term for the principle that ensures no arm of government dominates others?	["Rule of law", "Checks and balances", "Separation of powers", "Federalism"]	1	Checks and balances ensure that no single arm of government dominates the others.	2025-08-17 20:27:11.116863
659	Government	SSCE	\N	Which system divides power between central and regional governments?	["Unitary", "Federal", "Confederal", "Presidential"]	1	A federal system divides power between central and regional governments.	2025-08-17 20:27:11.116863
660	Government	SSCE	\N	What is the term for a government based on religious laws?	["Monarchy", "Theocracy", "Oligarchy", "Democracy"]	1	A theocracy is a government based on religious laws and principles.	2025-08-17 20:27:11.116863
661	Government	SSCE	\N	Which Nigerian constitution introduced the federal system of government?	["1960 Constitution", "1954 Constitution", "1979 Constitution", "1999 Constitution"]	1	The 1954 Lyttleton Constitution introduced federalism in Nigeria.	2025-08-17 20:27:11.116863
662	Government	SSCE	\N	Who was Nigeria’s first Governor-General?	["Lord Lugard", "Nnamdi Azikiwe", "Ahmadu Bello", "Tafawa Balewa"]	1	Nnamdi Azikiwe was Nigeria’s first Governor-General after independence in 1960.	2025-08-17 20:27:11.116863
663	Government	SSCE	\N	What is the term for the right to vote in an election?	["Citizenship", "Suffrage", "Franchise", "Mandate"]	1	Suffrage is the right to vote in political elections.	2025-08-17 20:27:11.116863
664	Government	SSCE	\N	Which Nigerian political party dominated the First Republic?	["AG", "NPC", "NCNC", "NEPU"]	1	The Northern People’s Congress (NPC) dominated Nigeria’s First Republic politics.	2025-08-17 20:27:11.116863
899	Commerce	SSCE	\N	What is the term for the money borrowed by a business from a bank?	["Capital", "Loan", "Revenue", "Profit"]	1	A loan is money borrowed from a bank to be repaid with interest.	2025-08-17 20:27:11.116863
665	Government	SSCE	\N	What is the term for a system where one political party dominates?	["Multi-party system", "One-party system", "Two-party system", "No-party system"]	1	A one-party system is where a single political party dominates governance.	2025-08-17 20:27:11.116863
666	Government	SSCE	\N	Which arm of government interprets the constitution?	["Executive", "Judiciary", "Legislature", "Bureaucracy"]	1	The judiciary interprets the constitution and ensures its proper application.	2025-08-17 20:27:11.116863
667	Government	SSCE	\N	What is the term for the process of choosing leaders through voting?	["Referendum", "Election", "Plebiscite", "Coup"]	1	An election is the process of selecting leaders through voting.	2025-08-17 20:27:11.116863
668	Government	SSCE	\N	Which Nigerian constitution established the presidential system?	["1963 Constitution", "1979 Constitution", "1960 Constitution", "1999 Constitution"]	1	The 1979 Constitution introduced the presidential system in Nigeria.	2025-08-17 20:27:11.116863
669	Government	SSCE	\N	What is the term for a government led by elected representatives?	["Monarchy", "Representative democracy", "Theocracy", "Dictatorship"]	1	Representative democracy involves governance by elected representatives.	2025-08-17 20:27:11.116863
670	Government	SSCE	\N	Which body conducts elections in Nigeria?	["NEC", "INEC", "SIEC", "EFCC"]	1	The Independent National Electoral Commission (INEC) conducts elections in Nigeria.	2025-08-17 20:27:11.116863
671	Government	SSCE	\N	What is the term for the principle that everyone is equal before the law?	["Checks and balances", "Rule of law", "Separation of powers", "Sovereignty"]	1	The rule of law ensures that everyone is equal before the law.	2025-08-17 20:27:11.116863
672	Government	SSCE	\N	Which system concentrates power in the central government?	["Federal", "Unitary", "Confederal", "Presidential"]	1	A unitary system concentrates power in the central government.	2025-08-17 20:27:11.116863
673	Government	SSCE	\N	Who was Nigeria’s first Prime Minister?	["Nnamdi Azikiwe", "Tafawa Balewa", "Ahmadu Bello", "Obafemi Awolowo"]	1	Tafawa Balewa was Nigeria’s first Prime Minister from 1960 to 1966.	2025-08-17 20:27:11.116863
674	Government	SSCE	\N	What is the term for a vote to decide a specific issue?	["Election", "Referendum", "Plebiscite", "Coup"]	1	A referendum is a direct vote by citizens on a specific issue.	2025-08-17 20:27:11.116863
675	Government	SSCE	\N	Which political ideology emphasizes state ownership of resources?	["Capitalism", "Socialism", "Liberalism", "Fascism"]	1	Socialism emphasizes state or collective ownership of resources.	2025-08-17 20:27:11.116863
676	Government	SSCE	\N	What is the term for the transfer of power to lower levels of government?	["Centralization", "Devolution", "Federalism", "Unitarism"]	1	Devolution is the transfer of power to lower levels of government.	2025-08-17 20:27:11.116863
677	Government	SSCE	\N	Which Nigerian region was prominent in the First Republic?	["Eastern Region", "Northern Region", "Western Region", "Mid-Western Region"]	1	The Northern Region was politically dominant in Nigeria’s First Republic.	2025-08-17 20:27:11.116863
678	Government	SSCE	\N	What is the term for a government where the head of state is a monarch?	["Republic", "Monarchy", "Oligarchy", "Theocracy"]	1	A monarchy is a government where the head of state is a monarch.	2025-08-17 20:27:11.116863
679	Government	SSCE	\N	Which body in Nigeria is responsible for law enforcement?	["Army", "Police", "Navy", "Civil Defence"]	1	The Nigeria Police Force is responsible for law enforcement.	2025-08-17 20:27:11.116863
680	Government	SSCE	\N	What is the term for a system with two dominant political parties?	["One-party system", "Two-party system", "Multi-party system", "No-party system"]	1	A two-party system is dominated by two major political parties.	2025-08-17 20:27:11.116863
681	Government	SSCE	\N	Which Nigerian constitution established the parliamentary system?	["1963 Constitution", "1960 Constitution", "1979 Constitution", "1999 Constitution"]	1	The 1960 Independence Constitution established Nigeria’s parliamentary system.	2025-08-17 20:27:11.116863
682	Government	SSCE	\N	What is the term for the power to influence or control others?	["Authority", "Power", "Sovereignty", "Legitimacy"]	1	Power is the ability to influence or control others in a political context.	2025-08-17 20:27:11.116863
683	Government	SSCE	\N	Which organization promotes economic cooperation among West African states?	["AU", "ECOWAS", "UN", "OPEC"]	1	ECOWAS (Economic Community of West African States) promotes economic cooperation in West Africa.	2025-08-17 20:27:11.116863
684	Government	SSCE	\N	What is the term for a government where the head of state is elected?	["Monarchy", "Republic", "Theocracy", "Oligarchy"]	1	A republic has an elected head of state, such as a president.	2025-08-17 20:27:11.116863
685	Government	SSCE	\N	Which Nigerian leader introduced the Structural Adjustment Programme (SAP)?	["Tafawa Balewa", "Ibrahim Babangida", "Olusegun Obasanjo", "Yakubu Gowon"]	1	Ibrahim Babangida introduced the SAP in Nigeria in 1986.	2025-08-17 20:27:11.116863
686	Government	SSCE	\N	What is the term for the right of citizens to participate in government?	["Sovereignty", "Citizenship", "Franchise", "Authority"]	1	Citizenship includes the right to participate in government activities like voting.	2025-08-17 20:27:11.116863
687	Government	SSCE	\N	Which body in Nigeria is responsible for financial oversight?	["EFCC", "ICPC", "Auditor-General", "CBN"]	2	The Auditor-General is responsible for financial oversight and auditing public accounts.	2025-08-17 20:27:11.116863
688	Government	SSCE	\N	What is the term for a system where states loosely cooperate?	["Federal", "Unitary", "Confederal", "Presidential"]	2	A confederal system involves states loosely cooperating with a weak central authority.	2025-08-17 20:27:11.116863
689	Government	SSCE	\N	Which Nigerian political party was prominent in the Second Republic?	["NPC", "NPN", "AG", "NEPU"]	1	The National Party of Nigeria (NPN) was prominent in the Second Republic.	2025-08-17 20:27:11.116863
690	Government	SSCE	\N	What is the term for the process of amending a constitution?	["Legislation", "Amendment", "Referendum", "Plebiscite"]	1	Amendment is the process of making changes to a constitution.	2025-08-17 20:27:11.116863
691	Government	SSCE	\N	Which international organization promotes peace and security?	["ECOWAS", "UN", "AU", "OPEC"]	1	The United Nations (UN) promotes global peace and security.	2025-08-17 20:27:11.116863
692	Government	SSCE	\N	What is the term for a government led by a military ruler?	["Democracy", "Military regime", "Monarchy", "Theocracy"]	1	A military regime is a government led by military rulers.	2025-08-17 20:27:11.116863
693	Government	SSCE	\N	Which Nigerian leader conducted the 1966 coup?	["Yakubu Gowon", "Chukwuma Nzeogwu", "Olusegun Obasanjo", "Murtala Mohammed"]	1	Chukwuma Nzeogwu led the January 1966 military coup in Nigeria.	2025-08-17 20:27:11.116863
694	Government	SSCE	\N	What is the term for the power to enforce laws?	["Legislative power", "Executive power", "Judicial power", "Sovereign power"]	1	Executive power involves the authority to enforce laws.	2025-08-17 20:27:11.116863
695	Government	SSCE	\N	Which Nigerian constitution is currently in use?	["1960 Constitution", "1979 Constitution", "1999 Constitution", "1963 Constitution"]	2	The 1999 Constitution is currently in use in Nigeria.	2025-08-17 20:27:11.116863
696	Government	SSCE	\N	What is the term for a group of people with common political goals?	["Pressure group", "Political party", "Trade union", "Civil society"]	1	A political party is a group of people with common political goals seeking power.	2025-08-17 20:27:11.116863
697	Government	SSCE	\N	Which organization replaced the Organization of African Unity (OAU)?	["ECOWAS", "AU", "UN", "OPEC"]	1	The African Union (AU) replaced the Organization of African Unity in 2002.	2025-08-17 20:27:11.116863
698	Government	SSCE	\N	What is the term for the freedom of the press and speech?	["Rule of law", "Fundamental rights", "Sovereignty", "Checks and balances"]	1	Fundamental rights include freedom of the press and speech.	2025-08-17 20:27:11.116863
699	Government	SSCE	\N	Which Nigerian leader established the NYSC program?	["Tafawa Balewa", "Yakubu Gowon", "Olusegun Obasanjo", "Ibrahim Babangida"]	1	Yakubu Gowon established the National Youth Service Corps (NYSC) in 1973.	2025-08-17 20:27:11.116863
700	Government	SSCE	\N	What is the term for a system with multiple political parties?	["One-party system", "Multi-party system", "Two-party system", "No-party system"]	1	A multi-party system allows multiple political parties to compete for power.	2025-08-17 20:27:11.116863
701	Government	SSCE	\N	Which body in Nigeria investigates financial crimes?	["INEC", "EFCC", "CBN", "ICPC"]	1	The Economic and Financial Crimes Commission (EFCC) investigates financial crimes.	2025-08-17 20:27:11.116863
702	Government	SSCE	\N	What is the term for a government where power is inherited?	["Republic", "Hereditary monarchy", "Oligarchy", "Democracy"]	1	A hereditary monarchy is a government where power is passed through family lines.	2025-08-17 20:27:11.116863
703	Government	SSCE	\N	Which Nigerian constitution created the Mid-Western Region?	["1960 Constitution", "1963 Constitution", "1979 Constitution", "1999 Constitution"]	1	The 1963 Constitution created the Mid-Western Region in Nigeria.	2025-08-17 20:27:11.116863
704	Government	SSCE	\N	What is the term for a group that influences government policies without seeking power?	["Political party", "Pressure group", "Trade union", "Civil society"]	1	A pressure group seeks to influence government policies without contesting elections.	2025-08-17 20:27:11.116863
705	Government	SSCE	\N	Which international organization regulates global trade?	["UN", "WTO", "AU", "ECOWAS"]	1	The World Trade Organization (WTO) regulates global trade.	2025-08-17 20:27:11.116863
706	Government	SSCE	\N	What is the term for a government where the head of government is a prime minister?	["Presidential system", "Parliamentary system", "Federal system", "Unitary system"]	1	A parliamentary system has a prime minister as the head of government.	2025-08-17 20:27:11.116863
707	Government	SSCE	\N	Which Nigerian leader was assassinated in 1976?	["Tafawa Balewa", "Murtala Mohammed", "Yakubu Gowon", "Olusegun Obasanjo"]	1	Murtala Mohammed was assassinated in a coup attempt in 1976.	2025-08-17 20:27:11.116863
708	Government	SSCE	\N	What is the term for the legal authority to govern?	["Power", "Legitimacy", "Sovereignty", "Authority"]	1	Authority is the legal right to govern or make decisions.	2025-08-17 20:27:11.116863
709	Government	SSCE	\N	Which body in Nigeria regulates the civil service?	["INEC", "FCSC", "EFCC", "CBN"]	1	The Federal Civil Service Commission (FCSC) regulates Nigeria’s civil service.	2025-08-17 20:27:11.116863
710	Government	SSCE	\N	What is the term for a government where the head of state is a president?	["Parliamentary system", "Presidential system", "Monarchy", "Theocracy"]	1	A presidential system has a president as the head of state and government.	2025-08-17 20:27:11.116863
711	Government	SSCE	\N	Which Nigerian political party won the 1999 elections?	["PDP", "ANPP", "AD", "APP"]	0	The People’s Democratic Party (PDP) won the 1999 general elections in Nigeria.	2025-08-17 20:27:11.116863
712	Government	SSCE	\N	What is the term for the process of law-making?	["Adjudication", "Legislation", "Administration", "Interpretation"]	1	Legislation is the process of making laws by the legislature.	2025-08-17 20:27:11.116863
713	Government	SSCE	\N	Which organization promotes African unity and development?	["ECOWAS", "AU", "UN", "WTO"]	1	The African Union (AU) promotes unity and development among African states.	2025-08-17 20:27:11.116863
714	Government	SSCE	\N	What is the term for a government where power is seized by force?	["Democracy", "Dictatorship", "Monarchy", "Republic"]	1	A dictatorship often involves power being seized or maintained by force.	2025-08-17 20:27:11.116863
715	Government	SSCE	\N	Which Nigerian leader introduced the War Against Indiscipline (WAI)?	["Olusegun Obasanjo", "Muhammadu Buhari", "Ibrahim Babangida", "Yakubu Gowon"]	1	Muhammadu Buhari introduced the War Against Indiscipline in 1984.	2025-08-17 20:27:11.116863
716	Government	SSCE	\N	What is the term for the division of government powers into three branches?	["Checks and balances", "Separation of powers", "Rule of law", "Federalism"]	1	Separation of powers divides government into legislative, executive, and judicial branches.	2025-08-17 20:27:11.116863
717	Government	SSCE	\N	Which body in Nigeria is responsible for monetary policy?	["INEC", "CBN", "EFCC", "ICPC"]	1	The Central Bank of Nigeria (CBN) is responsible for monetary policy.	2025-08-17 20:27:11.116863
718	Government	SSCE	\N	What is the term for a system where local governments have significant autonomy?	["Unitary", "Federal", "Confederal", "Centralized"]	1	A federal system grants significant autonomy to local or regional governments.	2025-08-17 20:27:11.116863
719	Government	SSCE	\N	Which Nigerian constitution abolished the regional system?	["1960 Constitution", "1966 Constitution", "1979 Constitution", "1999 Constitution"]	1	The 1966 military decree effectively abolished the regional system in Nigeria.	2025-08-17 20:27:11.116863
720	Government	SSCE	\N	What is the term for the process of citizens expressing their opinions to influence government?	["Lobbying", "Public opinion", "Voting", "Protest"]	1	Public opinion reflects citizens’ views to influence government policies.	2025-08-17 20:27:11.116863
721	Government	SSCE	\N	Which organization promotes global health policies?	["WTO", "WHO", "AU", "ECOWAS"]	1	The World Health Organization (WHO) promotes global health policies.	2025-08-17 20:27:11.116863
722	Government	SSCE	\N	What is the term for a government where citizens elect their leaders?	["Monarchy", "Democracy", "Theocracy", "Oligarchy"]	1	Democracy allows citizens to elect their leaders through voting.	2025-08-17 20:27:11.116863
723	Government	SSCE	\N	Which Nigerian leader created 12 states in 1967?	["Tafawa Balewa", "Yakubu Gowon", "Olusegun Obasanjo", "Ibrahim Babangida"]	1	Yakubu Gowon created 12 states in Nigeria in 1967 to replace regions.	2025-08-17 20:27:11.116863
958	Economics	SSCE	\N	Which of the following is a direct tax?	["Value-added tax", "Income tax", "Sales tax", "Excise duty"]	1	Income tax is a direct tax levied on individuals’ earnings.	2025-08-17 20:27:11.116863
724	Government	SSCE	\N	What is the term for the legal process of acquiring citizenship?	["Immigration", "Naturalization", "Deportation", "Expatriation"]	1	Naturalization is the legal process of acquiring citizenship in a country.	2025-08-17 20:27:11.116863
725	Government	SSCE	\N	Which body in Nigeria prosecutes corruption cases?	["INEC", "ICPC", "CBN", "EFCC"]	1	The Independent Corrupt Practices Commission (ICPC) prosecutes corruption cases.	2025-08-17 20:27:11.116863
726	Government	SSCE	\N	What is the term for a government where power is centralized?	["Federal", "Unitary", "Confederal", "Presidential"]	1	A unitary government centralizes power in a single authority.	2025-08-17 20:27:11.116863
727	Government	SSCE	\N	Which Nigerian political party was prominent in the Third Republic?	["PDP", "SDP", "ANPP", "AD"]	1	The Social Democratic Party (SDP) was prominent in Nigeria’s Third Republic.	2025-08-17 20:27:11.116863
728	Government	SSCE	\N	What is the term for the process of removing an elected official from office?	["Election", "Impeachment", "Referendum", "Coup"]	1	Impeachment is the process of removing an elected official from office for misconduct.	2025-08-17 20:27:11.116863
729	Government	SSCE	\N	Which organization promotes oil-producing countries’ interests?	["UN", "OPEC", "AU", "ECOWAS"]	1	The Organization of Petroleum Exporting Countries (OPEC) promotes oil-producing countries’ interests.	2025-08-17 20:27:11.116863
730	Government	SSCE	\N	What is the term for a government where the head of state is ceremonial?	["Presidential system", "Constitutional monarchy", "Dictatorship", "Republic"]	1	A constitutional monarchy has a ceremonial head of state, typically a monarch.	2025-08-17 20:27:11.116863
731	Government	SSCE	\N	Which Nigerian leader annulled the 1993 presidential election?	["Olusegun Obasanjo", "Ibrahim Babangida", "Yakubu Gowon", "Sani Abacha"]	1	Ibrahim Babangida annulled the 1993 presidential election in Nigeria.	2025-08-17 20:27:11.116863
732	Government	SSCE	\N	What is the term for the power to review laws for constitutionality?	["Legislative power", "Judicial review", "Executive power", "Sovereign power"]	1	Judicial review is the power to review laws to ensure they align with the constitution.	2025-08-17 20:27:11.116863
733	Government	SSCE	\N	Which body in Nigeria conducts local government elections?	["INEC", "SIEC", "EFCC", "CBN"]	1	State Independent Electoral Commissions (SIEC) conduct local government elections.	2025-08-17 20:27:11.116863
734	Government	SSCE	\N	What is the term for a system where states share power with a central authority?	["Unitary", "Federal", "Confederal", "Centralized"]	1	A federal system shares power between central and state governments.	2025-08-17 20:27:11.116863
735	Government	SSCE	\N	Which Nigerian political party won the 2015 elections?	["PDP", "APC", "ANPP", "AD"]	1	The All Progressives Congress (APC) won the 2015 general elections in Nigeria.	2025-08-17 20:27:11.116863
736	Government	SSCE	\N	What is the term for the process of forming a new government after elections?	["Legislation", "Transition", "Referendum", "Coup"]	1	Transition is the process of forming a new government after elections.	2025-08-17 20:27:11.116863
737	Government	SSCE	\N	Which organization promotes human rights globally?	["WTO", "UN", "AU", "ECOWAS"]	1	The United Nations (UN) promotes human rights globally through its charter.	2025-08-17 20:27:11.116863
738	Government	SSCE	\N	What is the term for a government where power is held by the people?	["Monarchy", "Democracy", "Oligarchy", "Theocracy"]	1	Democracy is a government where power is held by the people through elections.	2025-08-17 20:27:11.116863
739	Government	SSCE	\N	Which Nigerian leader introduced the six geo-political zones?	["Olusegun Obasanjo", "Sani Abacha", "Yakubu Gowon", "Ibrahim Babangida"]	1	Sani Abacha introduced the six geo-political zones in Nigeria in the 1990s.	2025-08-17 20:27:11.116863
740	Government	SSCE	\N	What is the term for the right to fair treatment under the law?	["Sovereignty", "Due process", "Authority", "Franchise"]	1	Due process ensures fair treatment under the law for all citizens.	2025-08-17 20:27:11.116863
741	Government	SSCE	\N	Which body in Nigeria appoints judges?	["INEC", "NJC", "EFCC", "CBN"]	1	The National Judicial Council (NJC) appoints and disciplines judges in Nigeria.	2025-08-17 20:27:11.116863
742	Christian Religious Studies	SSCE	\N	Who was the first man created by God according to the Bible?	["Abraham", "Adam", "Noah", "Moses"]	1	According to Genesis 2:7, Adam was the first man created by God from the dust of the ground.	2025-08-17 20:27:11.116863
743	Christian Religious Studies	SSCE	\N	What was the name of the garden where Adam and Eve lived?	["Gethsemane", "Eden", "Zion", "Bethel"]	1	Genesis 2:8 states that God placed Adam and Eve in the Garden of Eden.	2025-08-17 20:27:11.116863
744	Christian Religious Studies	SSCE	\N	Who built an ark to save his family and animals from the flood?	["Abraham", "Noah", "Isaac", "Jacob"]	1	Genesis 6:14-22 describes Noah building an ark as per God’s instructions to survive the flood.	2025-08-17 20:27:11.116863
745	Christian Religious Studies	SSCE	\N	What was the sign of God’s covenant with Noah after the flood?	["A dove", "A rainbow", "A lamb", "A star"]	1	Genesis 9:13 states that God set a rainbow in the sky as a sign of His covenant with Noah.	2025-08-17 20:27:11.116863
746	Christian Religious Studies	SSCE	\N	Who was called by God to leave his homeland and go to a promised land?	["Moses", "Abraham", "Joseph", "David"]	1	Genesis 12:1 records God calling Abraham to leave his homeland for a land He would show him.	2025-08-17 20:27:11.116863
747	Christian Religious Studies	SSCE	\N	What was the name of Abraham’s son of promise?	["Ishmael", "Isaac", "Jacob", "Esau"]	1	Genesis 21:3 states that Isaac was the son of promise born to Abraham and Sarah.	2025-08-17 20:27:11.116863
748	Christian Religious Studies	SSCE	\N	Who led the Israelites out of Egypt?	["Joshua", "Moses", "Aaron", "Samuel"]	1	Exodus 3:10 shows God choosing Moses to lead the Israelites out of Egypt.	2025-08-17 20:27:11.116863
749	Christian Religious Studies	SSCE	\N	What did God give to Moses on Mount Sinai?	["The Ark of the Covenant", "The Ten Commandments", "A staff", "A golden calf"]	1	Exodus 20:1-17 records God giving the Ten Commandments to Moses on Mount Sinai.	2025-08-17 20:27:11.116863
750	Christian Religious Studies	SSCE	\N	Who was the first king of Israel?	["David", "Saul", "Solomon", "Samuel"]	1	1 Samuel 10:1 describes Saul as the first king anointed by Samuel for Israel.	2025-08-17 20:27:11.116863
751	Christian Religious Studies	SSCE	\N	Who killed Goliath with a sling and a stone?	["Samuel", "David", "Saul", "Jonathan"]	1	1 Samuel 17:50 states that David killed Goliath using a sling and a stone.	2025-08-17 20:27:11.116863
752	Christian Religious Studies	SSCE	\N	What was the name of the temple built by King Solomon?	["Tabernacle", "Jerusalem Temple", "Shiloh Temple", "Bethel Temple"]	1	1 Kings 6:1-14 describes Solomon building the Jerusalem Temple for God.	2025-08-17 20:27:11.116863
753	Christian Religious Studies	SSCE	\N	Who was sold into slavery by his brothers?	["Jacob", "Joseph", "Benjamin", "Reuben"]	1	Genesis 37:28 recounts Joseph being sold into slavery by his brothers.	2025-08-17 20:27:11.116863
754	Christian Religious Studies	SSCE	\N	Which prophet was taken to heaven in a chariot of fire?	["Elijah", "Elisha", "Isaiah", "Jeremiah"]	0	2 Kings 2:11 describes Elijah being taken to heaven in a chariot of fire.	2025-08-17 20:27:11.116863
755	Christian Religious Studies	SSCE	\N	Who was thrown into a lions’ den for praying to God?	["David", "Daniel", "Jonah", "Esther"]	1	Daniel 6:16 records Daniel being thrown into the lions’ den for his faith.	2025-08-17 20:27:11.116863
756	Christian Religious Studies	SSCE	\N	What was the name of the queen who saved her people from destruction?	["Ruth", "Esther", "Deborah", "Hannah"]	1	Esther 7:3-6 shows Esther saving the Jews from Haman’s plot.	2025-08-17 20:27:11.116863
757	Christian Religious Studies	SSCE	\N	Who was the mother of Samuel the prophet?	["Sarah", "Hannah", "Ruth", "Rebekah"]	1	1 Samuel 1:20 states that Hannah was the mother of Samuel.	2025-08-17 20:27:11.116863
758	Christian Religious Studies	SSCE	\N	Which prophet foretold the birth of Jesus in Bethlehem?	["Isaiah", "Micah", "Jeremiah", "Ezekiel"]	1	Micah 5:2 prophesies the birth of the Messiah in Bethlehem.	2025-08-17 20:27:11.116863
759	Christian Religious Studies	SSCE	\N	Who was the mother of Jesus?	["Elizabeth", "Mary", "Martha", "Joanna"]	1	Luke 1:31 identifies Mary as the mother of Jesus.	2025-08-17 20:27:11.116863
760	Christian Religious Studies	SSCE	\N	Who baptized Jesus in the River Jordan?	["Peter", "John the Baptist", "Paul", "James"]	1	Matthew 3:13-17 records John the Baptist baptizing Jesus in the River Jordan.	2025-08-17 20:27:11.116863
761	Christian Religious Studies	SSCE	\N	What was the first miracle performed by Jesus?	["Healing a blind man", "Turning water into wine", "Feeding the 5,000", "Walking on water"]	1	John 2:11 describes Jesus turning water into wine at Cana as His first miracle.	2025-08-17 20:27:11.116863
762	Christian Religious Studies	SSCE	\N	Which disciple betrayed Jesus?	["Peter", "Judas Iscariot", "John", "Thomas"]	1	Matthew 26:14-16 states that Judas Iscariot betrayed Jesus for thirty pieces of silver.	2025-08-17 20:27:11.116863
763	Christian Religious Studies	SSCE	\N	On what day did Jesus rise from the dead?	["Friday", "Sunday", "Saturday", "Monday"]	1	Matthew 28:1-6 records Jesus rising from the dead on the first day of the week, Sunday.	2025-08-17 20:27:11.116863
764	Christian Religious Studies	SSCE	\N	What is the term for the event when Jesus ascended into heaven?	["Resurrection", "Ascension", "Crucifixion", "Transfiguration"]	1	Acts 1:9-11 describes the Ascension, when Jesus was taken up into heaven.	2025-08-17 20:27:11.116863
765	Christian Religious Studies	SSCE	\N	Who received the Holy Spirit on the day of Pentecost?	["The Pharisees", "The disciples", "The Sadducees", "The Gentiles"]	1	Acts 2:1-4 states that the disciples received the Holy Spirit on Pentecost.	2025-08-17 20:27:11.116863
766	Christian Religious Studies	SSCE	\N	Who was the first Christian martyr?	["Paul", "Stephen", "Peter", "James"]	1	Acts 7:59-60 records Stephen as the first Christian martyr, stoned for his faith.	2025-08-17 20:27:11.116863
767	Christian Religious Studies	SSCE	\N	Who was converted on the road to Damascus?	["Peter", "Paul", "John", "Barnabas"]	1	Acts 9:3-6 describes Paul’s conversion on the road to Damascus.	2025-08-17 20:27:11.116863
768	Christian Religious Studies	SSCE	\N	What is the term for the act of turning away from sin?	["Faith", "Repentance", "Grace", "Salvation"]	1	Repentance is the act of turning away from sin and seeking forgiveness, as taught in Acts 3:19.	2025-08-17 20:27:11.116863
769	Christian Religious Studies	SSCE	\N	Which parable teaches about helping a neighbor in need?	["The Prodigal Son", "The Good Samaritan", "The Sower", "The Lost Sheep"]	1	Luke 10:25-37 tells the parable of the Good Samaritan, emphasizing helping others.	2025-08-17 20:27:11.116863
770	Christian Religious Studies	SSCE	\N	Who denied Jesus three times before the rooster crowed?	["Judas", "Peter", "Thomas", "John"]	1	Luke 22:60-61 records Peter denying Jesus three times before the rooster crowed.	2025-08-17 20:27:11.116863
771	Christian Religious Studies	SSCE	\N	What is the term for God’s unmerited favor toward humanity?	["Faith", "Grace", "Repentance", "Salvation"]	1	Grace is God’s unmerited favor, as explained in Ephesians 2:8.	2025-08-17 20:27:11.116863
772	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the Sermon on the Mount?	["Mark", "Matthew", "Luke", "John"]	1	Matthew 5-7 records the Sermon on the Mount delivered by Jesus.	2025-08-17 20:27:11.116863
773	Christian Religious Studies	SSCE	\N	Who was the father of John the Baptist?	["Joseph", "Zechariah", "Simeon", "Eli"]	1	Luke 1:13 identifies Zechariah as the father of John the Baptist.	2025-08-17 20:27:11.116863
774	Christian Religious Studies	SSCE	\N	What was the name of the sea where Jesus calmed the storm?	["Red Sea", "Sea of Galilee", "Dead Sea", "Mediterranean Sea"]	1	Mark 4:39 describes Jesus calming the storm on the Sea of Galilee.	2025-08-17 20:27:11.116863
775	Christian Religious Studies	SSCE	\N	Which apostle was known as the 'doubting' disciple?	["Peter", "Thomas", "John", "Andrew"]	1	John 20:24-27 describes Thomas doubting Jesus’ resurrection until he saw Him.	2025-08-17 20:27:11.116863
776	Christian Religious Studies	SSCE	\N	What is the term for the second coming of Jesus Christ?	["Ascension", "Parousia", "Resurrection", "Pentecost"]	1	Parousia refers to the second coming of Jesus, as mentioned in Matthew 24:27.	2025-08-17 20:27:11.116863
777	Christian Religious Studies	SSCE	\N	Who was the king who tried to kill baby Jesus?	["Pilate", "Herod", "Caesar", "Nebuchadnezzar"]	1	Matthew 2:16 records Herod ordering the killing of male infants to eliminate Jesus.	2025-08-17 20:27:11.116863
778	Christian Religious Studies	SSCE	\N	Which parable teaches about forgiveness and God’s mercy?	["The Good Samaritan", "The Prodigal Son", "The Sower", "The Talents"]	1	Luke 15:11-32 tells the parable of the Prodigal Son, highlighting God’s forgiveness.	2025-08-17 20:27:11.116863
779	Christian Religious Studies	SSCE	\N	Who was the first person to see Jesus after His resurrection?	["Peter", "Mary Magdalene", "John", "Thomas"]	1	John 20:11-18 states that Mary Magdalene was the first to see the risen Jesus.	2025-08-17 20:27:11.116863
780	Christian Religious Studies	SSCE	\N	What is the term for the belief in one God?	["Polytheism", "Monotheism", "Atheism", "Agnosticism"]	1	Monotheism is the belief in one God, central to Christianity (Deuteronomy 6:4).	2025-08-17 20:27:11.116863
781	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the Lord’s Prayer?	["Mark", "Matthew", "Luke", "John"]	1	Matthew 6:9-13 records the Lord’s Prayer taught by Jesus.	2025-08-17 20:27:11.116863
782	Christian Religious Studies	SSCE	\N	Who was the prophet that confronted Ahab about Naboth’s vineyard?	["Elisha", "Elijah", "Isaiah", "Jeremiah"]	1	1 Kings 21:17-19 describes Elijah confronting Ahab over Naboth’s vineyard.	2025-08-17 20:27:11.116863
783	Christian Religious Studies	SSCE	\N	What was the name of the place where Jesus was crucified?	["Bethlehem", "Golgotha", "Jerusalem", "Nazareth"]	1	Matthew 27:33 identifies Golgotha as the place where Jesus was crucified.	2025-08-17 20:27:11.116863
784	Christian Religious Studies	SSCE	\N	Who was the judge who led Israel against the Canaanites?	["Gideon", "Deborah", "Samson", "Samuel"]	1	Judges 4:4-5 describes Deborah as a judge who led Israel against the Canaanites.	2025-08-17 20:27:11.116863
785	Christian Religious Studies	SSCE	\N	Which disciple was a tax collector before following Jesus?	["Peter", "Matthew", "John", "Andrew"]	1	Matthew 9:9 states that Matthew was a tax collector before Jesus called him.	2025-08-17 20:27:11.116863
786	Christian Religious Studies	SSCE	\N	What is the term for the act of being saved from sin?	["Repentance", "Salvation", "Grace", "Faith"]	1	Salvation is the act of being saved from sin through faith in Jesus (John 3:16).	2025-08-17 20:27:11.116863
787	Christian Religious Studies	SSCE	\N	Who was the woman who anointed Jesus’ feet with perfume?	["Mary Magdalene", "Mary of Bethany", "Martha", "Joanna"]	1	John 12:3 describes Mary of Bethany anointing Jesus’ feet with perfume.	2025-08-17 20:27:11.116863
788	Christian Religious Studies	SSCE	\N	Which parable teaches about the use of talents or abilities?	["The Good Samaritan", "The Talents", "The Sower", "The Prodigal Son"]	1	Matthew 25:14-30 tells the parable of the Talents, teaching stewardship of abilities.	2025-08-17 20:27:11.116863
789	Christian Religious Studies	SSCE	\N	Who was the father of Isaac?	["Jacob", "Abraham", "Joseph", "Moses"]	1	Genesis 21:3 identifies Abraham as the father of Isaac.	2025-08-17 20:27:11.116863
790	Christian Religious Studies	SSCE	\N	What was the name of the mountain where Abraham was to sacrifice Isaac?	["Sinai", "Moriah", "Zion", "Horeb"]	1	Genesis 22:2 states that God told Abraham to sacrifice Isaac on Mount Moriah.	2025-08-17 20:27:11.116863
791	Christian Religious Studies	SSCE	\N	Who was the prophet swallowed by a great fish?	["Elijah", "Jonah", "Isaiah", "Daniel"]	1	Jonah 1:17 describes Jonah being swallowed by a great fish.	2025-08-17 20:27:11.116863
792	Christian Religious Studies	SSCE	\N	Which commandment forbids lying?	["Sixth", "Ninth", "Seventh", "Eighth"]	1	The ninth commandment, 'You shall not bear false witness,' forbids lying (Exodus 20:16).	2025-08-17 20:27:11.116863
793	Christian Religious Studies	SSCE	\N	Who was the first high priest of Israel?	["Moses", "Aaron", "Samuel", "Eli"]	1	Exodus 28:1 appoints Aaron as the first high priest of Israel.	2025-08-17 20:27:11.116863
794	Christian Religious Studies	SSCE	\N	Which parable teaches about God’s kingdom growing like a seed?	["The Prodigal Son", "The Mustard Seed", "The Good Samaritan", "The Talents"]	1	Matthew 13:31-32 describes the parable of the Mustard Seed, illustrating the kingdom’s growth.	2025-08-17 20:27:11.116863
795	Christian Religious Studies	SSCE	\N	Who was the Roman governor who sentenced Jesus to death?	["Herod", "Pontius Pilate", "Caesar", "Felix"]	1	Matthew 27:26 states that Pontius Pilate sentenced Jesus to crucifixion.	2025-08-17 20:27:11.116863
796	Christian Religious Studies	SSCE	\N	What is the term for the belief in the resurrection of the dead?	["Faith", "Eschatology", "Grace", "Salvation"]	1	Eschatology includes the belief in the resurrection of the dead (1 Corinthians 15:22).	2025-08-17 20:27:11.116863
797	Christian Religious Studies	SSCE	\N	Who was the prophet who anointed David as king?	["Elijah", "Samuel", "Isaiah", "Nathan"]	1	1 Samuel 16:13 records Samuel anointing David as king of Israel.	2025-08-17 20:27:11.116863
798	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the Beatitudes?	["Mark", "Matthew", "Luke", "John"]	1	Matthew 5:3-12 contains the Beatitudes, part of the Sermon on the Mount.	2025-08-17 20:27:11.116863
799	Christian Religious Studies	SSCE	\N	Who was the wife of Isaac?	["Sarah", "Rebekah", "Rachel", "Leah"]	1	Genesis 24:67 identifies Rebekah as the wife of Isaac.	2025-08-17 20:27:11.116863
800	Christian Religious Studies	SSCE	\N	Which disciple was chosen to replace Judas Iscariot?	["Barnabas", "Matthias", "Silas", "Timothy"]	1	Acts 1:26 states that Matthias was chosen to replace Judas Iscariot.	2025-08-17 20:27:11.116863
801	Christian Religious Studies	SSCE	\N	What was the name of the city where Jonah was sent to preach?	["Jerusalem", "Nineveh", "Bethel", "Babylon"]	1	Jonah 1:2 records God sending Jonah to preach to the city of Nineveh.	2025-08-17 20:27:11.116863
802	Christian Religious Studies	SSCE	\N	Which commandment forbids stealing?	["Sixth", "Seventh", "Eighth", "Ninth"]	2	The eighth commandment, 'You shall not steal,' forbids stealing (Exodus 20:15).	2025-08-17 20:27:11.116863
803	Christian Religious Studies	SSCE	\N	Who was the king who built the first temple in Jerusalem?	["David", "Solomon", "Saul", "Hezekiah"]	1	1 Kings 6:1-14 describes Solomon building the first temple in Jerusalem.	2025-08-17 20:27:11.116863
804	Christian Religious Studies	SSCE	\N	Which parable teaches about persistence in prayer?	["The Good Samaritan", "The Persistent Widow", "The Prodigal Son", "The Talents"]	1	Luke 18:1-8 tells the parable of the Persistent Widow, teaching persistence in prayer.	2025-08-17 20:27:11.116863
805	Christian Religious Studies	SSCE	\N	Who was the cousin of Jesus, according to the Bible?	["Peter", "John the Baptist", "James", "Andrew"]	1	Luke 1:36 indicates that John the Baptist was Jesus’ cousin through Mary and Elizabeth.	2025-08-17 20:27:11.116863
806	Christian Religious Studies	SSCE	\N	What is the term for the act of trusting in God?	["Repentance", "Faith", "Grace", "Salvation"]	1	Faith is the act of trusting in God, as emphasized in Hebrews 11:1.	2025-08-17 20:27:11.116863
807	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the story of the Good Shepherd?	["Matthew", "John", "Luke", "Mark"]	1	John 10:11-14 contains Jesus’ teaching about being the Good Shepherd.	2025-08-17 20:27:11.116863
808	Christian Religious Studies	SSCE	\N	Who was the prophet who rebuilt the walls of Jerusalem?	["Ezra", "Nehemiah", "Isaiah", "Jeremiah"]	1	Nehemiah 2:17-18 describes Nehemiah leading the rebuilding of Jerusalem’s walls.	2025-08-17 20:27:11.116863
809	Christian Religious Studies	SSCE	\N	Which disciple was a fisherman before following Jesus?	["Matthew", "Peter", "Thomas", "Judas"]	1	Luke 5:10 identifies Peter as a fisherman before Jesus called him.	2025-08-17 20:27:11.116863
810	Christian Religious Studies	SSCE	\N	What was the name of the river where the Israelites crossed into Canaan?	["Nile", "Jordan", "Euphrates", "Tigris"]	1	Joshua 3:14-17 describes the Israelites crossing the Jordan River into Canaan.	2025-08-17 20:27:11.116863
811	Christian Religious Studies	SSCE	\N	Which commandment emphasizes honoring parents?	["Fourth", "Fifth", "Sixth", "Seventh"]	1	The fifth commandment, 'Honor your father and mother,' emphasizes respect for parents (Exodus 20:12).	2025-08-17 20:27:11.116863
812	Christian Religious Studies	SSCE	\N	Who was the father of Jacob and Esau?	["Abraham", "Isaac", "Joseph", "Moses"]	1	Genesis 25:26 identifies Isaac as the father of Jacob and Esau.	2025-08-17 20:27:11.116863
813	Christian Religious Studies	SSCE	\N	Which parable teaches about the kingdom of God being like a treasure?	["The Good Samaritan", "The Hidden Treasure", "The Prodigal Son", "The Sower"]	1	Matthew 13:44 describes the parable of the Hidden Treasure, likening the kingdom to a treasure.	2025-08-17 20:27:11.116863
814	Christian Religious Studies	SSCE	\N	Who was the king who repented after Jonah’s preaching?	["Saul", "King of Nineveh", "David", "Ahab"]	1	Jonah 3:6-10 records the King of Nineveh repenting after Jonah’s preaching.	2025-08-17 20:27:11.116863
815	Christian Religious Studies	SSCE	\N	What is the term for the act of giving to the poor or needy?	["Faith", "Charity", "Grace", "Salvation"]	1	Charity is the act of giving to the poor or needy, as encouraged in 1 Corinthians 13:3.	2025-08-17 20:27:11.116863
816	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the story of Lazarus and the rich man?	["Matthew", "Luke", "Mark", "John"]	1	Luke 16:19-31 tells the parable of Lazarus and the rich man.	2025-08-17 20:27:11.116863
817	Christian Religious Studies	SSCE	\N	Who was the prophet who foretold a virgin would give birth to a son?	["Jeremiah", "Isaiah", "Ezekiel", "Daniel"]	1	Isaiah 7:14 prophesies a virgin giving birth to a son, fulfilled in Jesus’ birth.	2025-08-17 20:27:11.116863
818	Christian Religious Studies	SSCE	\N	Which disciple walked on water toward Jesus?	["John", "Peter", "James", "Andrew"]	1	Matthew 14:29 describes Peter walking on water toward Jesus.	2025-08-17 20:27:11.116863
819	Christian Religious Studies	SSCE	\N	What was the name of the city where Jesus was born?	["Jerusalem", "Bethlehem", "Nazareth", "Capernaum"]	1	Luke 2:4-7 states that Jesus was born in Bethlehem.	2025-08-17 20:27:11.116863
820	Christian Religious Studies	SSCE	\N	Which commandment forbids coveting?	["Seventh", "Eighth", "Ninth", "Tenth"]	3	The tenth commandment, 'You shall not covet,' forbids desiring others’ possessions (Exodus 20:17).	2025-08-17 20:27:11.116863
821	Christian Religious Studies	SSCE	\N	Who was the mother of Ishmael?	["Sarah", "Hagar", "Rebekah", "Rachel"]	1	Genesis 16:15 identifies Hagar as the mother of Ishmael.	2025-08-17 20:27:11.116863
822	Christian Religious Studies	SSCE	\N	Which parable teaches about the separation of the righteous and the wicked?	["The Good Samaritan", "The Sheep and the Goats", "The Prodigal Son", "The Sower"]	1	Matthew 25:31-46 tells the parable of the Sheep and the Goats, depicting judgment.	2025-08-17 20:27:11.116863
823	Christian Religious Studies	SSCE	\N	Who was the prophet who performed miracles at Mount Carmel?	["Elisha", "Elijah", "Isaiah", "Jeremiah"]	1	1 Kings 18:36-39 describes Elijah’s miracles at Mount Carmel.	2025-08-17 20:27:11.116863
824	Christian Religious Studies	SSCE	\N	What is the term for the act of worshipping God?	["Faith", "Adoration", "Grace", "Salvation"]	1	Adoration is the act of worshipping or giving reverence to God (Psalm 95:6).	2025-08-17 20:27:11.116863
825	Christian Religious Studies	SSCE	\N	Which book of the Bible contains the story of the vine and the branches?	["Matthew", "John", "Luke", "Mark"]	1	John 15:1-5 contains Jesus’ teaching about the vine and the branches.	2025-08-17 20:27:11.116863
826	Christian Religious Studies	SSCE	\N	Who was the king who committed adultery with Bathsheba?	["Saul", "David", "Solomon", "Hezekiah"]	1	2 Samuel 11:2-4 describes David’s adultery with Bathsheba.	2025-08-17 20:27:11.116863
827	Christian Religious Studies	SSCE	\N	Which disciple was known as the 'beloved disciple'?	["Peter", "John", "James", "Andrew"]	1	John 13:23 refers to John as the disciple whom Jesus loved.	2025-08-17 20:27:11.116863
828	Christian Religious Studies	SSCE	\N	What was the name of the mountain where Jesus was transfigured?	["Sinai", "Tabor", "Zion", "Horeb"]	1	Matthew 17:1-2 traditionally identifies Mount Tabor as the site of Jesus’ transfiguration.	2025-08-17 20:27:11.116863
829	Christian Religious Studies	SSCE	\N	Which commandment forbids murder?	["Fifth", "Sixth", "Seventh", "Eighth"]	1	The sixth commandment, 'You shall not murder,' forbids killing (Exodus 20:13).	2025-08-17 20:27:11.116863
830	Christian Religious Studies	SSCE	\N	Who was the father of Joseph, the husband of Mary?	["Zechariah", "Jacob", "Eli", "Simeon"]	1	Matthew 1:16 identifies Jacob as the father of Joseph, Mary’s husband.	2025-08-17 20:27:11.116863
831	Christian Religious Studies	SSCE	\N	Which parable teaches about the value of small beginnings?	["The Good Samaritan", "The Mustard Seed", "The Prodigal Son", "The Talents"]	1	Matthew 13:31-32 tells the parable of the Mustard Seed, emphasizing small beginnings.	2025-08-17 20:27:11.116863
832	Christian Religious Studies	SSCE	\N	Who was the prophet who was fed by ravens?	["Elisha", "Elijah", "Isaiah", "Jeremiah"]	1	1 Kings 17:4-6 describes God sending ravens to feed Elijah.	2025-08-17 20:27:11.116863
833	Commerce	SSCE	\N	What is the primary objective of a business organization?	["Charity", "Profit maximization", "Employee welfare", "Community service"]	1	The primary objective of most business organizations is to maximize profit.	2025-08-17 20:27:11.116863
834	Commerce	SSCE	\N	Which of the following is a feature of a sole proprietorship?	["Limited liability", "Single ownership", "Public ownership", "Government control"]	1	A sole proprietorship is characterized by single ownership with full control by one person.	2025-08-17 20:27:11.116863
835	Commerce	SSCE	\N	What is the term for the buying and selling of goods and services?	["Production", "Trade", "Distribution", "Consumption"]	1	Trade involves the exchange of goods and services between buyers and sellers.	2025-08-17 20:27:11.116863
836	Commerce	SSCE	\N	Which document is issued by a seller to indicate the amount owed by a buyer?	["Receipt", "Invoice", "Cheque", "Voucher"]	1	An invoice is a document issued by a seller to a buyer indicating the amount owed.	2025-08-17 20:27:11.116863
837	Commerce	SSCE	\N	What is the term for the process of promoting and selling products or services?	["Production", "Marketing", "Distribution", "Finance"]	1	Marketing involves activities to promote and sell products or services.	2025-08-17 20:27:11.116863
838	Commerce	SSCE	\N	Which of the following is a type of insurance that covers loss of goods at sea?	["Life insurance", "Marine insurance", "Fire insurance", "Health insurance"]	1	Marine insurance covers the loss or damage of goods during sea transport.	2025-08-17 20:27:11.116863
839	Commerce	SSCE	\N	What is the term for a business owned by two or more individuals?	["Sole proprietorship", "Partnership", "Corporation", "Cooperative"]	1	A partnership is a business owned and managed by two or more individuals.	2025-08-17 20:27:11.116863
840	Commerce	SSCE	\N	Which of the following is a function of a commercial bank?	["Issue currency", "Provide loans", "Control money supply", "Set fiscal policy"]	1	Commercial banks provide loans to individuals and businesses.	2025-08-17 20:27:11.116863
841	Commerce	SSCE	\N	What is the term for the physical movement of goods from one place to another?	["Marketing", "Transportation", "Warehousing", "Production"]	1	Transportation involves the physical movement of goods from one location to another.	2025-08-17 20:27:11.116863
842	Commerce	SSCE	\N	Which of the following is a characteristic of a public limited company?	["Unlimited liability", "Shares traded publicly", "Single ownership", "Government control"]	1	A public limited company has shares that are traded on a stock exchange.	2025-08-17 20:27:11.116863
843	Commerce	SSCE	\N	What is the term for the money invested in a business by its owners?	["Revenue", "Capital", "Profit", "Loan"]	1	Capital is the money or resources invested by owners to start or run a business.	2025-08-17 20:27:11.116863
844	Commerce	SSCE	\N	Which of the following is a type of retail trade?	["Wholesale trade", "Department store", "Import trade", "Export trade"]	1	A department store is a form of retail trade selling directly to consumers.	2025-08-17 20:27:11.116863
845	Commerce	SSCE	\N	What is the term for the document that outlines the objectives of a company?	["Prospectus", "Memorandum of Association", "Articles of Association", "Certificate of Incorporation"]	1	The Memorandum of Association outlines the objectives and scope of a company.	2025-08-17 20:27:11.116863
846	Commerce	SSCE	\N	Which of the following is an example of an auxiliary to trade?	["Manufacturing", "Advertising", "Mining", "Farming"]	1	Advertising is an auxiliary to trade as it supports the promotion of goods and services.	2025-08-17 20:27:11.116863
847	Commerce	SSCE	\N	What is the term for a person who buys goods for personal use?	["Wholesaler", "Consumer", "Retailer", "Distributor"]	1	A consumer purchases goods or services for personal use.	2025-08-17 20:27:11.116863
848	Commerce	SSCE	\N	Which of the following is a function of a stock exchange?	["Issue currency", "Facilitate trading of securities", "Provide loans", "Insure goods"]	1	A stock exchange facilitates the buying and selling of securities like shares.	2025-08-17 20:27:11.116863
849	Commerce	SSCE	\N	What is the term for the process of storing goods until they are needed?	["Transportation", "Warehousing", "Marketing", "Production"]	1	Warehousing involves storing goods to ensure availability when needed.	2025-08-17 20:27:11.116863
850	Commerce	SSCE	\N	Which of the following is a type of cooperative society?	["Public limited company", "Consumer cooperative", "Sole proprietorship", "Partnership"]	1	A consumer cooperative is a type of cooperative society that provides goods to its members.	2025-08-17 20:27:11.116863
851	Commerce	SSCE	\N	What is the term for a tax imposed on imported goods?	["Excise duty", "Customs duty", "Sales tax", "Income tax"]	1	Customs duty is a tax levied on goods imported into a country.	2025-08-17 20:27:11.116863
852	Commerce	SSCE	\N	Which of the following is a characteristic of a private limited company?	["Shares traded publicly", "Limited liability", "Unlimited liability", "Single ownership"]	1	A private limited company has limited liability, protecting shareholders’ personal assets.	2025-08-17 20:27:11.116863
853	Commerce	SSCE	\N	What is the term for a written promise to pay a sum of money at a future date?	["Cheque", "Bill of exchange", "Receipt", "Invoice"]	1	A bill of exchange is a written promise to pay a specified amount at a future date.	2025-08-17 20:27:11.116863
854	Commerce	SSCE	\N	Which of the following is a function of advertising?	["Produce goods", "Create awareness", "Transport goods", "Store goods"]	1	Advertising creates awareness about products or services to attract customers.	2025-08-17 20:27:11.116863
855	Commerce	SSCE	\N	What is the term for the person who sells goods in small quantities to consumers?	["Wholesaler", "Retailer", "Manufacturer", "Distributor"]	1	A retailer sells goods in small quantities directly to consumers.	2025-08-17 20:27:11.116863
856	Commerce	SSCE	\N	Which of the following is a type of credit sale?	["Cash on delivery", "Hire purchase", "Barter trade", "Prepaid purchase"]	1	Hire purchase is a credit sale where payment is made in installments.	2025-08-17 20:27:11.116863
857	Commerce	SSCE	\N	What is the term for the process of transferring ownership of goods from seller to buyer?	["Warehousing", "Sale", "Production", "Distribution"]	1	A sale involves transferring ownership of goods from the seller to the buyer.	2025-08-17 20:27:11.116863
858	Commerce	SSCE	\N	Which of the following is a function of a central bank?	["Provide loans to individuals", "Issue currency", "Sell insurance", "Trade securities"]	1	The central bank is responsible for issuing currency and controlling monetary policy.	2025-08-17 20:27:11.116863
859	Commerce	SSCE	\N	What is the term for goods purchased for resale or business use?	["Consumer goods", "Capital goods", "Durable goods", "Non-durable goods"]	1	Capital goods are purchased for use in production or for resale in business.	2025-08-17 20:27:11.116863
860	Commerce	SSCE	\N	Which of the following is a type of foreign trade?	["Retail trade", "Import trade", "Wholesale trade", "Barter trade"]	1	Import trade involves purchasing goods from foreign countries.	2025-08-17 20:27:11.116863
861	Commerce	SSCE	\N	What is the term for a document that shows the financial position of a business at a given time?	["Profit and loss account", "Balance sheet", "Cash flow statement", "Income statement"]	1	A balance sheet shows a business’s financial position at a specific point in time.	2025-08-17 20:27:11.116863
862	Commerce	SSCE	\N	Which of the following is a characteristic of a cooperative society?	["Profit maximization", "Democratic control", "Limited liability", "Public share trading"]	1	Cooperative societies are characterized by democratic control by their members.	2025-08-17 20:27:11.116863
863	Commerce	SSCE	\N	What is the term for the person who acts as an intermediary between a buyer and a seller?	["Consumer", "Broker", "Retailer", "Manufacturer"]	1	A broker facilitates transactions between buyers and sellers for a commission.	2025-08-17 20:27:11.116863
864	Commerce	SSCE	\N	Which of the following is a function of a warehouse?	["Produce goods", "Store goods", "Transport goods", "Sell goods"]	1	A warehouse is used to store goods until they are needed for sale or distribution.	2025-08-17 20:27:11.116863
865	Commerce	SSCE	\N	What is the term for the process of exchanging goods without using money?	["Credit trade", "Barter trade", "Cash trade", "Export trade"]	1	Barter trade involves the direct exchange of goods or services without money.	2025-08-17 20:27:11.116863
866	Commerce	SSCE	\N	Which of the following is a type of marine insurance?	["Hull insurance", "Fire insurance", "Life insurance", "Health insurance"]	0	Hull insurance covers the ship’s structure and is a type of marine insurance.	2025-08-17 20:27:11.116863
867	Commerce	SSCE	\N	What is the term for the money paid to shareholders from a company’s profits?	["Interest", "Dividend", "Wages", "Rent"]	1	Dividends are payments made to shareholders from a company’s profits.	2025-08-17 20:27:11.116863
868	Commerce	SSCE	\N	Which of the following is a function of the capital market?	["Provide short-term loans", "Facilitate long-term financing", "Issue currency", "Insure goods"]	1	The capital market facilitates long-term financing through securities like stocks and bonds.	2025-08-17 20:27:11.116863
869	Commerce	SSCE	\N	What is the term for the person who undertakes the risk of starting a business?	["Employee", "Entrepreneur", "Consumer", "Retailer"]	1	An entrepreneur takes the risk of starting and managing a business.	2025-08-17 20:27:11.116863
870	Commerce	SSCE	\N	Which of the following is a type of wholesale trade?	["Chain store", "Cash and carry", "Department store", "Supermarket"]	1	Cash and carry is a type of wholesale trade selling in bulk to retailers.	2025-08-17 20:27:11.116863
871	Commerce	SSCE	\N	What is the term for a document that confirms payment has been made?	["Invoice", "Receipt", "Cheque", "Bill of exchange"]	1	A receipt is a document issued to confirm that payment has been received.	2025-08-17 20:27:11.116863
872	Commerce	SSCE	\N	Which of the following is a function of marketing?	["Production", "Market research", "Warehousing", "Transportation"]	1	Market research is a key function of marketing to understand consumer needs.	2025-08-17 20:27:11.116863
873	Commerce	SSCE	\N	What is the term for the person who sells goods on behalf of another for a commission?	["Broker", "Agent", "Retailer", "Wholesaler"]	1	An agent sells goods on behalf of a principal and earns a commission.	2025-08-17 20:27:11.116863
874	Commerce	SSCE	\N	Which of the following is a type of fire insurance?	["Cargo insurance", "Consequential loss insurance", "Hull insurance", "Life insurance"]	1	Consequential loss insurance covers losses due to fire interrupting business operations.	2025-08-17 20:27:11.116863
875	Commerce	SSCE	\N	What is the term for the total value of goods and services sold by a business?	["Profit", "Revenue", "Capital", "Cost"]	1	Revenue is the total income from sales of goods or services.	2025-08-17 20:27:11.116863
876	Commerce	SSCE	\N	Which of the following is a function of the money market?	["Provide long-term loans", "Facilitate short-term financing", "Issue shares", "Insure goods"]	1	The money market facilitates short-term financing through instruments like treasury bills.	2025-08-17 20:27:11.116863
877	Commerce	SSCE	\N	What is the term for the person who buys goods in bulk for resale?	["Consumer", "Wholesaler", "Retailer", "Manufacturer"]	1	A wholesaler purchases goods in bulk and sells them to retailers.	2025-08-17 20:27:11.116863
878	Commerce	SSCE	\N	Which of the following is a type of export trade?	["Retail trade", "Entrepot trade", "Wholesale trade", "Barter trade"]	1	Entrepot trade involves importing goods to re-export them.	2025-08-17 20:27:11.116863
879	Commerce	SSCE	\N	What is the term for the document that specifies the rules governing a company’s operations?	["Memorandum of Association", "Articles of Association", "Prospectus", "Certificate of Incorporation"]	1	The Articles of Association outline the internal rules of a company.	2025-08-17 20:27:11.116863
880	Commerce	SSCE	\N	Which of the following is a characteristic of a sole trader?	["Limited liability", "Unlimited liability", "Public share trading", "Government ownership"]	1	A sole trader has unlimited liability, meaning personal assets are at risk.	2025-08-17 20:27:11.116863
881	Commerce	SSCE	\N	What is the term for the process of moving goods from producer to consumer?	["Production", "Distribution", "Marketing", "Warehousing"]	1	Distribution involves moving goods from producers to consumers.	2025-08-17 20:27:11.116863
882	Commerce	SSCE	\N	Which of the following is a type of life insurance?	["Whole life assurance", "Fire insurance", "Marine insurance", "Cargo insurance"]	0	Whole life assurance is a type of life insurance that covers the insured for their entire life.	2025-08-17 20:27:11.116863
883	Commerce	SSCE	\N	What is the term for the excess of income over expenditure in a business?	["Loss", "Profit", "Revenue", "Capital"]	1	Profit is the excess of income over expenditure in a business.	2025-08-17 20:27:11.116863
884	Commerce	SSCE	\N	Which of the following is a function of a clearing house?	["Issue currency", "Settle transactions between banks", "Provide loans", "Insure goods"]	1	A clearing house settles transactions, such as cheques, between banks.	2025-08-17 20:27:11.116863
885	Commerce	SSCE	\N	What is the term for a business owned by its customers or workers?	["Partnership", "Cooperative society", "Public limited company", "Sole proprietorship"]	1	A cooperative society is owned and operated by its members, such as customers or workers.	2025-08-17 20:27:11.116863
886	Commerce	SSCE	\N	Which of the following is a type of indirect tax?	["Income tax", "Value-added tax", "Property tax", "Corporate tax"]	1	Value-added tax is an indirect tax levied on goods and services.	2025-08-17 20:27:11.116863
887	Commerce	SSCE	\N	What is the term for a written order to a bank to pay a specified amount?	["Receipt", "Cheque", "Invoice", "Bill of exchange"]	1	A cheque is a written order to a bank to pay a specified amount from an account.	2025-08-17 20:27:11.116863
888	Commerce	SSCE	\N	Which of the following is a function of branding?	["Transport goods", "Create product identity", "Store goods", "Produce goods"]	1	Branding creates a unique identity for a product to distinguish it in the market.	2025-08-17 20:27:11.116863
889	Commerce	SSCE	\N	What is the term for the person who transports goods for a fee?	["Broker", "Carrier", "Retailer", "Wholesaler"]	1	A carrier transports goods for a fee, such as a shipping company.	2025-08-17 20:27:11.116863
890	Commerce	SSCE	\N	Which of the following is a type of health insurance?	["Cargo insurance", "Medical insurance", "Hull insurance", "Fire insurance"]	1	Medical insurance covers healthcare costs for individuals.	2025-08-17 20:27:11.116863
891	Commerce	SSCE	\N	What is the term for the total cost of producing goods or services?	["Revenue", "Profit", "Expenditure", "Capital"]	2	Expenditure is the total cost incurred in producing goods or services.	2025-08-17 20:27:11.116863
892	Commerce	SSCE	\N	Which of the following is a function of a trade association?	["Issue currency", "Promote members’ interests", "Provide loans", "Insure goods"]	1	A trade association promotes the interests of its members in a specific industry.	2025-08-17 20:27:11.116863
893	Commerce	SSCE	\N	What is the term for a business that provides services rather than goods?	["Manufacturing", "Service industry", "Extractive industry", "Construction"]	1	A service industry provides intangible services rather than physical goods.	2025-08-17 20:27:11.116863
894	Commerce	SSCE	\N	Which of the following is a type of home trade?	["Import trade", "Retail trade", "Export trade", "Entrepot trade"]	1	Retail trade is a type of home trade conducted within a country.	2025-08-17 20:27:11.116863
895	Commerce	SSCE	\N	What is the term for a document that grants legal permission to start a company?	["Prospectus", "Certificate of Incorporation", "Memorandum of Association", "Articles of Association"]	1	The Certificate of Incorporation is a legal document that permits a company to operate.	2025-08-17 20:27:11.116863
896	Commerce	SSCE	\N	Which of the following is a characteristic of a partnership?	["Limited liability", "Shared responsibility", "Public share trading", "Single ownership"]	1	A partnership involves shared responsibility among partners for business operations.	2025-08-17 20:27:11.116863
897	Commerce	SSCE	\N	What is the term for the process of dividing a market into distinct groups of buyers?	["Branding", "Market segmentation", "Advertising", "Distribution"]	1	Market segmentation divides a market into groups with similar characteristics.	2025-08-17 20:27:11.116863
898	Commerce	SSCE	\N	Which of the following is a type of accident insurance?	["Fire insurance", "Personal accident insurance", "Marine insurance", "Life insurance"]	1	Personal accident insurance covers injuries or death due to accidents.	2025-08-17 20:27:11.116863
900	Commerce	SSCE	\N	Which of the following is a function of a chamber of commerce?	["Issue currency", "Promote trade and industry", "Provide loans", "Insure goods"]	1	A chamber of commerce promotes trade and industry in a specific region.	2025-08-17 20:27:11.116863
901	Commerce	SSCE	\N	What is the term for a business that extracts natural resources?	["Service industry", "Extractive industry", "Manufacturing", "Construction"]	1	An extractive industry involves extracting natural resources like minerals or oil.	2025-08-17 20:27:11.116863
902	Commerce	SSCE	\N	Which of the following is a type of international trade?	["Retail trade", "Export trade", "Wholesale trade", "Barter trade"]	1	Export trade involves selling goods to foreign countries.	2025-08-17 20:27:11.116863
903	Commerce	SSCE	\N	What is the term for a document that shows a business’s profit or loss over a period?	["Balance sheet", "Profit and loss account", "Cash flow statement", "Trial balance"]	1	A profit and loss account shows the profit or loss of a business over a period.	2025-08-17 20:27:11.116863
904	Commerce	SSCE	\N	Which of the following is a characteristic of a public corporation?	["Private ownership", "Government ownership", "Unlimited liability", "Single ownership"]	1	A public corporation is owned and controlled by the government.	2025-08-17 20:27:11.116863
905	Commerce	SSCE	\N	What is the term for the process of attracting customers through product promotion?	["Production", "Advertising", "Distribution", "Warehousing"]	1	Advertising promotes products to attract customers and increase sales.	2025-08-17 20:27:11.116863
906	Commerce	SSCE	\N	Which of the following is a type of fidelity guarantee insurance?	["Fire insurance", "Employee dishonesty insurance", "Marine insurance", "Life insurance"]	1	Fidelity guarantee insurance covers losses due to employee dishonesty.	2025-08-17 20:27:11.116863
907	Commerce	SSCE	\N	What is the term for the money received from selling goods or services?	["Profit", "Revenue", "Capital", "Cost"]	1	Revenue is the money received from the sale of goods or services.	2025-08-17 20:27:11.116863
908	Commerce	SSCE	\N	Which of the following is a function of a merchant bank?	["Issue currency", "Provide corporate finance", "Sell insurance", "Transport goods"]	1	Merchant banks provide corporate finance services like loans and advisory.	2025-08-17 20:27:11.116863
909	Commerce	SSCE	\N	What is the term for a business that produces goods from raw materials?	["Service industry", "Manufacturing", "Extractive industry", "Construction"]	1	Manufacturing involves producing goods from raw materials.	2025-08-17 20:27:11.116863
911	Commerce	SSCE	\N	What is the term for a document inviting the public to buy shares in a company?	["Memorandum of Association", "Prospectus", "Articles of Association", "Certificate of Incorporation"]	1	A prospectus invites the public to purchase shares in a company.	2025-08-17 20:27:11.116863
912	Commerce	SSCE	\N	Which of the following is a characteristic of a joint-stock company?	["Unlimited liability", "Limited liability", "Single ownership", "Government control"]	1	A joint-stock company has limited liability for its shareholders.	2025-08-17 20:27:11.116863
913	Commerce	SSCE	\N	What is the term for the process of determining the price of a product?	["Branding", "Pricing", "Advertising", "Distribution"]	1	Pricing involves setting the monetary value of a product or service.	2025-08-17 20:27:11.116863
914	Commerce	SSCE	\N	Which of the following is a type of motor insurance?	["Fire insurance", "Third-party insurance", "Marine insurance", "Life insurance"]	1	Third-party insurance covers damages caused by the insured vehicle to others.	2025-08-17 20:27:11.116863
915	Commerce	SSCE	\N	What is the term for the excess of expenditure over income in a business?	["Profit", "Loss", "Revenue", "Capital"]	1	A loss occurs when a business’s expenditure exceeds its income.	2025-08-17 20:27:11.116863
916	Commerce	SSCE	\N	Which of the following is a function of a development bank?	["Issue currency", "Provide long-term loans", "Sell insurance", "Transport goods"]	1	Development banks provide long-term loans for economic development projects.	2025-08-17 20:27:11.116863
917	Commerce	SSCE	\N	What is the term for a business that builds infrastructure like roads and bridges?	["Service industry", "Extractive industry", "Construction", "Manufacturing"]	2	The construction industry builds infrastructure such as roads and bridges.	2025-08-17 20:27:11.116863
919	Commerce	SSCE	\N	What is the term for a document that records all financial transactions of a business?	["Balance sheet", "Ledger", "Profit and loss account", "Cash flow statement"]	1	A ledger records all financial transactions of a business.	2025-08-17 20:27:11.116863
920	Commerce	SSCE	\N	Which of the following is a characteristic of a sole proprietorship?	["Limited liability", "Single ownership", "Public share trading", "Government ownership"]	1	A sole proprietorship is owned and managed by a single individual.	2025-08-17 20:27:11.116863
921	Commerce	SSCE	\N	What is the term for the process of creating a unique image for a product?	["Pricing", "Branding", "Advertising", "Distribution"]	1	Branding creates a unique image and identity for a product in the market.	2025-08-17 20:27:11.116863
922	Commerce	SSCE	\N	Which of the following is a type of burglary insurance?	["Fire insurance", "Theft insurance", "Marine insurance", "Life insurance"]	1	Theft insurance covers losses due to burglary or theft.	2025-08-17 20:27:11.116863
923	Commerce	SSCE	\N	What is the term for the money used to start or expand a business?	["Revenue", "Capital", "Profit", "Loss"]	1	Capital is the money used to start or expand a business.	2025-08-17 20:27:11.116863
924	Commerce	SSCE	\N	Which of the following is a function of a trade union?	["Issue currency", "Protect workers’ rights", "Provide loans", "Insure goods"]	1	A trade union protects and promotes the rights of workers.	2025-08-17 20:27:11.116863
925	Commerce	SSCE	\N	What is the term for a business that provides financial services?	["Manufacturing", "Service industry", "Extractive industry", "Construction"]	1	The service industry includes businesses that provide financial services.	2025-08-17 20:27:11.116863
927	Commerce	SSCE	\N	What is the term for a document that shows the amount paid for goods?	["Invoice", "Receipt", "Cheque", "Bill of exchange"]	1	A receipt confirms the amount paid for goods or services.	2025-08-17 20:27:11.116863
928	Commerce	SSCE	\N	Which of the following is a function of packaging?	["Transport goods", "Protect products", "Produce goods", "Store goods"]	1	Packaging protects products during transportation and storage.	2025-08-17 20:27:11.116863
929	Commerce	SSCE	\N	What is the term for the person who negotiates contracts on behalf of another?	["Retailer", "Agent", "Wholesaler", "Consumer"]	1	An agent negotiates contracts or transactions on behalf of a principal.	2025-08-17 20:27:11.116863
930	Commerce	SSCE	\N	Which of the following is a type of liability insurance?	["Fire insurance", "Public liability insurance", "Marine insurance", "Life insurance"]	1	Public liability insurance covers damages caused to third parties.	2025-08-17 20:27:11.116863
931	Economics	SSCE	\N	What is the study of economics primarily concerned with?	["Allocation of scarce resources", "Production of goods only", "Distribution of wealth", "Consumption of services"]	0	Economics studies how scarce resources are allocated to meet unlimited human wants.	2025-08-17 20:27:11.116863
932	Economics	SSCE	\N	Which of the following is a basic economic problem?	["Unlimited resources", "Scarcity", "Excess production", "Overpopulation"]	1	Scarcity, the limited availability of resources relative to wants, is a fundamental economic problem.	2025-08-17 20:27:11.116863
933	Economics	SSCE	\N	What is the term for the satisfaction derived from consuming a good or service?	["Profit", "Utility", "Revenue", "Cost"]	1	Utility refers to the satisfaction or benefit derived from consuming a good or service.	2025-08-17 20:27:11.116863
934	Economics	SSCE	\N	Which type of economy relies primarily on customs and traditions?	["Market economy", "Traditional economy", "Mixed economy", "Command economy"]	1	A traditional economy is guided by customs, traditions, and beliefs.	2025-08-17 20:27:11.116863
935	Economics	SSCE	\N	What is the term for the quantity of a good consumers are willing to buy at a given price?	["Supply", "Demand", "Production", "Consumption"]	1	Demand is the quantity of a good or service consumers are willing and able to buy at a specific price.	2025-08-17 20:27:11.116863
936	Economics	SSCE	\N	Which factor causes a shift in the demand curve?	["Change in price", "Change in income", "Change in quantity supplied", "Change in production cost"]	1	A change in income shifts the demand curve, while a change in price causes movement along the curve.	2025-08-17 20:27:11.116863
937	Economics	SSCE	\N	What is the term for the price at which quantity demanded equals quantity supplied?	["Market price", "Equilibrium price", "Reserve price", "Ceiling price"]	1	The equilibrium price balances the quantity demanded and supplied in a market.	2025-08-17 20:27:11.116863
938	Economics	SSCE	\N	Which of the following is a determinant of supply?	["Consumer income", "Production cost", "Consumer preferences", "Population size"]	1	Production cost affects the willingness and ability of producers to supply goods.	2025-08-17 20:27:11.116863
939	Economics	SSCE	\N	What is the effect of a price ceiling below the equilibrium price?	["Surplus", "Shortage", "No effect", "Increased supply"]	1	A price ceiling below equilibrium causes a shortage, as demand exceeds supply.	2025-08-17 20:27:11.116863
940	Economics	SSCE	\N	Which type of market structure has many firms selling identical products?	["Monopoly", "Oligopoly", "Perfect competition", "Monopolistic competition"]	2	Perfect competition features many firms selling identical products with no control over price.	2025-08-17 20:27:11.116863
941	Economics	SSCE	\N	What is the term for the total revenue minus total cost of a firm?	["Loss", "Profit", "Income", "Dividend"]	1	Profit is the difference between total revenue and total cost.	2025-08-17 20:27:11.116863
942	Economics	SSCE	\N	Which of the following is a characteristic of a monopoly?	["Many sellers", "Identical products", "Single seller", "Free entry"]	2	A monopoly has a single seller controlling the market with significant barriers to entry.	2025-08-17 20:27:11.116863
943	Economics	SSCE	\N	What is the term for the responsiveness of demand to a change in price?	["Elasticity of supply", "Price elasticity of demand", "Income elasticity", "Cross elasticity"]	1	Price elasticity of demand measures how sensitive demand is to a change in price.	2025-08-17 20:27:11.116863
944	Economics	SSCE	\N	Which of the following goods has inelastic demand?	["Luxury cars", "Salt", "Fashion clothing", "Electronics"]	1	Salt has inelastic demand because it is a necessity with few substitutes.	2025-08-17 20:27:11.116863
945	Economics	SSCE	\N	What is the term for the cost of the next best alternative foregone?	["Marginal cost", "Opportunity cost", "Fixed cost", "Variable cost"]	1	Opportunity cost is the value of the next best alternative given up when making a choice.	2025-08-17 20:27:11.116863
946	Economics	SSCE	\N	Which sector of the economy involves manufacturing and processing?	["Primary sector", "Secondary sector", "Tertiary sector", "Quaternary sector"]	1	The secondary sector involves manufacturing and processing raw materials into finished goods.	2025-08-17 20:27:11.116863
947	Economics	SSCE	\N	What is the term for the total value of goods and services produced in a country in a year?	["Net income", "Gross domestic product", "National debt", "Balance of payments"]	1	Gross domestic product (GDP) measures the total value of goods and services produced in a country.	2025-08-17 20:27:11.116863
948	Economics	SSCE	\N	Which of the following is a measure of economic growth?	["Inflation rate", "Unemployment rate", "GDP growth rate", "Interest rate"]	2	GDP growth rate measures the increase in a country’s economic output over time.	2025-08-17 20:27:11.116863
949	Economics	SSCE	\N	What is the term for a general increase in prices across an economy?	["Deflation", "Inflation", "Recession", "Depression"]	1	Inflation is a sustained increase in the general price level of goods and services.	2025-08-17 20:27:11.116863
950	Economics	SSCE	\N	Which policy uses government spending and taxation to influence the economy?	["Monetary policy", "Fiscal policy", "Trade policy", "Industrial policy"]	1	Fiscal policy involves government spending and taxation to manage economic activity.	2025-08-17 20:27:11.116863
951	Economics	SSCE	\N	What is the term for the rate at which a central bank lends to commercial banks?	["Inflation rate", "Discount rate", "Exchange rate", "Interest rate"]	1	The discount rate is the interest rate charged by a central bank to commercial banks.	2025-08-17 20:27:11.116863
952	Economics	SSCE	\N	Which of the following is a function of money?	["Medium of exchange", "Production of goods", "Distribution of wealth", "Creation of jobs"]	0	Money serves as a medium of exchange, facilitating transactions.	2025-08-17 20:27:11.116863
953	Economics	SSCE	\N	What is the term for a situation where a country imports more than it exports?	["Trade surplus", "Trade deficit", "Balance of trade", "Current account surplus"]	1	A trade deficit occurs when imports exceed exports.	2025-08-17 20:27:11.116863
954	Economics	SSCE	\N	Which of the following is a renewable resource?	["Coal", "Oil", "Solar energy", "Natural gas"]	2	Solar energy is renewable as it is derived from the sun, an inexhaustible source.	2025-08-17 20:27:11.116863
955	Economics	SSCE	\N	What is the term for the total income earned by factors of production in a country?	["Gross domestic product", "National income", "Net profit", "Balance of payments"]	1	National income is the total income earned by a country’s factors of production.	2025-08-17 20:27:11.116863
956	Economics	SSCE	\N	Which of the following is a characteristic of a mixed economy?	["Only private ownership", "Only government control", "Both private and public sectors", "No trade"]	2	A mixed economy combines private and public sector involvement.	2025-08-17 20:27:11.116863
957	Economics	SSCE	\N	What is the term for the cost incurred in producing one additional unit of output?	["Fixed cost", "Variable cost", "Marginal cost", "Total cost"]	2	Marginal cost is the additional cost of producing one more unit of output.	2025-08-17 20:27:11.116863
959	Economics	SSCE	\N	What is the term for the rate at which one currency is exchanged for another?	["Interest rate", "Exchange rate", "Inflation rate", "Discount rate"]	1	The exchange rate determines the value of one currency in terms of another.	2025-08-17 20:27:11.116863
960	Economics	SSCE	\N	Which of the following is a characteristic of perfect competition?	["Barriers to entry", "Price makers", "Many buyers and sellers", "Single seller"]	2	Perfect competition has many buyers and sellers with no control over price.	2025-08-17 20:27:11.116863
961	Economics	SSCE	\N	What is the term for a decrease in the general price level?	["Inflation", "Deflation", "Recession", "Stagflation"]	1	Deflation is a sustained decrease in the general price level.	2025-08-17 20:27:11.116863
962	Economics	SSCE	\N	Which of the following is a function of commercial banks?	["Issue currency", "Lend money", "Control money supply", "Set fiscal policy"]	1	Commercial banks lend money to individuals and businesses.	2025-08-17 20:27:11.116863
963	Economics	SSCE	\N	What is the term for the difference between exports and imports of goods and services?	["Balance of payments", "Trade balance", "Current account", "Capital account"]	1	The trade balance is the difference between exports and imports of goods and services.	2025-08-17 20:27:11.116863
964	Economics	SSCE	\N	Which of the following is a measure of income inequality?	["GDP per capita", "Gini coefficient", "Inflation rate", "Unemployment rate"]	1	The Gini coefficient measures the degree of income inequality in a population.	2025-08-17 20:27:11.116863
965	Economics	SSCE	\N	What is the term for the total demand for goods and services in an economy?	["Aggregate demand", "Individual demand", "Market demand", "Supply demand"]	0	Aggregate demand is the total demand for goods and services in an economy.	2025-08-17 20:27:11.116863
966	Economics	SSCE	\N	Which of the following is a tool of monetary policy?	["Government spending", "Open market operations", "Taxation", "Subsidies"]	1	Open market operations involve buying or selling government securities to control money supply.	2025-08-17 20:27:11.116863
967	Economics	SSCE	\N	What is the term for a market structure with few large firms?	["Monopoly", "Oligopoly", "Perfect competition", "Monopolistic competition"]	1	An oligopoly has a few large firms dominating the market.	2025-08-17 20:27:11.116863
968	Economics	SSCE	\N	Which of the following is a characteristic of elastic supply?	["Fixed production", "Responsive to price changes", "No substitutes", "High production costs"]	1	Elastic supply is highly responsive to changes in price.	2025-08-17 20:27:11.116863
969	Economics	SSCE	\N	What is the term for the income earned by capital as a factor of production?	["Wages", "Rent", "Interest", "Profit"]	2	Interest is the income earned by capital in the production process.	2025-08-17 20:27:11.116863
970	Economics	SSCE	\N	Which of the following is a non-renewable resource?	["Wind energy", "Coal", "Solar energy", "Hydropower"]	1	Coal is a non-renewable resource as it is finite and depletes over time.	2025-08-17 20:27:11.116863
971	Economics	SSCE	\N	What is the term for the cost that does not change with output?	["Variable cost", "Fixed cost", "Marginal cost", "Total cost"]	1	Fixed costs remain constant regardless of the level of output.	2025-08-17 20:27:11.116863
972	Economics	SSCE	\N	Which of the following is an indirect tax?	["Income tax", "Value-added tax", "Property tax", "Corporate tax"]	1	Value-added tax is an indirect tax levied on goods and services.	2025-08-17 20:27:11.116863
973	Economics	SSCE	\N	What is the term for the value of a country’s currency in terms of another currency?	["Interest rate", "Exchange rate", "Inflation rate", "Discount rate"]	1	The exchange rate is the value of one currency relative to another.	2025-08-17 20:27:11.116863
974	Economics	SSCE	\N	Which of the following is a characteristic of monopolistic competition?	["Identical products", "Single seller", "Product differentiation", "No barriers to entry"]	2	Monopolistic competition features many firms selling differentiated products.	2025-08-17 20:27:11.116863
975	Economics	SSCE	\N	What is the term for a period of economic decline lasting more than two quarters?	["Inflation", "Recession", "Deflation", "Stagflation"]	1	A recession is a period of economic decline lasting more than two consecutive quarters.	2025-08-17 20:27:11.116863
976	Economics	SSCE	\N	Which of the following is a function of the central bank?	["Lend to individuals", "Issue currency", "Provide financial advice", "Collect taxes"]	1	The central bank is responsible for issuing currency and controlling monetary policy.	2025-08-17 20:27:11.116863
977	Economics	SSCE	\N	What is the term for the difference between a country’s total receipts and payments?	["Trade balance", "Balance of payments", "Current account", "Capital account"]	1	The balance of payments records all economic transactions between a country and the rest of the world.	2025-08-17 20:27:11.116863
978	Economics	SSCE	\N	Which of the following is a measure of economic development?	["Unemployment rate", "Human development index", "Inflation rate", "Exchange rate"]	1	The human development index measures life expectancy, education, and per capita income.	2025-08-17 20:27:11.116863
979	Economics	SSCE	\N	What is the term for the total supply of goods and services in an economy?	["Aggregate supply", "Individual supply", "Market supply", "Demand supply"]	0	Aggregate supply is the total supply of goods and services in an economy.	2025-08-17 20:27:11.116863
980	Economics	SSCE	\N	Which of the following is a tool of fiscal policy?	["Open market operations", "Government spending", "Interest rates", "Reserve requirements"]	1	Government spending is a tool of fiscal policy to influence economic activity.	2025-08-17 20:27:11.116863
981	Economics	SSCE	\N	What is the term for a market structure with one buyer and many sellers?	["Monopoly", "Monopsony", "Oligopoly", "Perfect competition"]	1	A monopsony has one buyer and many sellers, giving the buyer market power.	2025-08-17 20:27:11.116863
982	Economics	SSCE	\N	Which of the following is a characteristic of inelastic demand?	["Many substitutes", "Low responsiveness to price changes", "Luxury goods", "High responsiveness to price"]	1	Inelastic demand means quantity demanded is less responsive to price changes.	2025-08-17 20:27:11.116863
983	Economics	SSCE	\N	What is the term for the income earned by labor as a factor of production?	["Rent", "Wages", "Interest", "Profit"]	1	Wages are the income earned by labor in the production process.	2025-08-17 20:27:11.116863
985	Economics	SSCE	\N	What is the term for the cost that changes with output?	["Fixed cost", "Variable cost", "Marginal cost", "Total cost"]	1	Variable costs change with the level of output, such as raw materials.	2025-08-17 20:27:11.116863
986	Economics	SSCE	\N	Which of the following is a progressive tax?	["Sales tax", "Income tax", "Value-added tax", "Excise duty"]	1	Income tax is progressive, as the tax rate increases with income.	2025-08-17 20:27:11.116863
987	Economics	SSCE	\N	What is the term for a tax imposed on imported goods?	["Income tax", "Tariff", "Value-added tax", "Property tax"]	1	A tariff is a tax imposed on imported goods to protect domestic industries.	2025-08-17 20:27:11.116863
988	Economics	SSCE	\N	Which of the following is a characteristic of a command economy?	["Private ownership", "Government control", "Market-driven prices", "No government intervention"]	1	A command economy is characterized by government control of resources and production.	2025-08-17 20:27:11.116863
989	Economics	SSCE	\N	What is the term for a period of high inflation and high unemployment?	["Recession", "Stagflation", "Deflation", "Depression"]	1	Stagflation is a situation with high inflation and high unemployment.	2025-08-17 20:27:11.116863
990	Economics	SSCE	\N	Which of the following is a function of stock exchanges?	["Issue currency", "Facilitate trading of securities", "Control money supply", "Set fiscal policy"]	1	Stock exchanges facilitate the buying and selling of securities like shares.	2025-08-17 20:27:11.116863
991	Economics	SSCE	\N	What is the term for the excess of exports over imports?	["Trade deficit", "Trade surplus", "Balance of trade", "Current account deficit"]	1	A trade surplus occurs when exports exceed imports.	2025-08-17 20:27:11.116863
992	Economics	SSCE	\N	Which of the following is a measure of standard of living?	["Unemployment rate", "GDP per capita", "Inflation rate", "Exchange rate"]	1	GDP per capita measures the average economic output per person, indicating standard of living.	2025-08-17 20:27:11.116863
993	Economics	SSCE	\N	What is the term for the total money supply in an economy?	["Aggregate demand", "Money supply", "National income", "Fiscal policy"]	1	Money supply is the total amount of money available in an economy.	2025-08-17 20:27:11.116863
995	Economics	SSCE	\N	What is the term for a market structure with many firms selling differentiated products?	["Monopoly", "Oligopoly", "Monopolistic competition", "Perfect competition"]	2	Monopolistic competition has many firms selling slightly differentiated products.	2025-08-17 20:27:11.116863
996	Economics	SSCE	\N	Which of the following is a characteristic of elastic demand?	["Few substitutes", "High responsiveness to price changes", "Necessity goods", "Low responsiveness to price"]	1	Elastic demand is highly responsive to price changes, often due to many substitutes.	2025-08-17 20:27:11.116863
997	Economics	SSCE	\N	What is the term for the income earned by land as a factor of production?	["Wages", "Rent", "Interest", "Profit"]	1	Rent is the income earned by land in the production process.	2025-08-17 20:27:11.116863
999	Economics	SSCE	\N	What is the term for the cost of producing a specific quantity of output?	["Fixed cost", "Variable cost", "Total cost", "Marginal cost"]	2	Total cost is the sum of fixed and variable costs for producing a specific output.	2025-08-17 20:27:11.116863
1000	Economics	SSCE	\N	Which of the following is a regressive tax?	["Income tax", "Sales tax", "Property tax", "Corporate tax"]	1	Sales tax is regressive as it takes a larger percentage of income from lower earners.	2025-08-17 20:27:11.116863
1001	Economics	SSCE	\N	What is the term for a government payment to reduce production costs?	["Tariff", "Subsidy", "Tax", "Quota"]	1	A subsidy is a government payment to lower production costs and encourage output.	2025-08-17 20:27:11.116863
1002	Economics	SSCE	\N	Which of the following is a characteristic of a market economy?	["Government control", "Price determined by supply and demand", "No private ownership", "Central planning"]	1	In a market economy, prices are determined by supply and demand.	2025-08-17 20:27:11.116863
1003	Economics	SSCE	\N	What is the term for a prolonged period of economic decline?	["Recession", "Depression", "Stagflation", "Inflation"]	1	A depression is a severe and prolonged economic decline.	2025-08-17 20:27:11.116863
1004	Economics	SSCE	\N	Which of the following is a function of insurance companies?	["Issue currency", "Provide risk coverage", "Control money supply", "Set fiscal policy"]	1	Insurance companies provide risk coverage against financial losses.	2025-08-17 20:27:11.116863
1005	Economics	SSCE	\N	What is the term for the total value of a country’s exports minus its imports?	["Balance of payments", "Trade balance", "Current account", "Capital account"]	1	The trade balance is the difference between a country’s exports and imports.	2025-08-17 20:27:11.116863
1006	Economics	SSCE	\N	Which of the following is a measure of economic welfare?	["Unemployment rate", "Human development index", "Inflation rate", "Exchange rate"]	1	The human development index measures factors like health, education, and income.	2025-08-17 20:27:11.116863
1007	Economics	SSCE	\N	What is the term for the responsiveness of supply to a change in price?	["Price elasticity of demand", "Elasticity of supply", "Income elasticity", "Cross elasticity"]	1	Elasticity of supply measures how sensitive supply is to a change in price.	2025-08-17 20:27:11.116863
1008	Economics	SSCE	\N	Which of the following is a characteristic of a public good?	["Excludable", "Rivalrous", "Non-excludable", "Profit-driven"]	2	Public goods are non-excludable, meaning no one can be prevented from using them.	2025-08-17 20:27:11.116863
1009	Economics	SSCE	\N	What is the term for the income earned by entrepreneurs as a factor of production?	["Wages", "Rent", "Interest", "Profit"]	3	Profit is the income earned by entrepreneurs for organizing production.	2025-08-17 20:27:11.116863
1011	Economics	SSCE	\N	What is the term for the additional satisfaction from consuming one more unit of a good?	["Total utility", "Marginal utility", "Average utility", "Fixed utility"]	1	Marginal utility is the additional satisfaction gained from consuming one more unit.	2025-08-17 20:27:11.116863
1012	Economics	SSCE	\N	Which of the following is a characteristic of a progressive tax system?	["Flat tax rate", "Higher tax rate for higher incomes", "Equal tax for all", "Tax on goods"]	1	A progressive tax system imposes higher tax rates on higher income levels.	2025-08-17 20:27:11.116863
1013	Economics	SSCE	\N	What is the term for a restriction on the quantity of imported goods?	["Tariff", "Subsidy", "Quota", "Tax"]	2	A quota limits the quantity of goods that can be imported.	2025-08-17 20:27:11.116863
1014	Economics	SSCE	\N	Which of the following is a characteristic of a traditional economy?	["Market-driven prices", "Government planning", "Custom-based production", "High technology"]	2	A traditional economy relies on customs and traditions to determine production.	2025-08-17 20:27:11.116863
1015	Economics	SSCE	\N	What is the term for a period of low economic activity and high unemployment?	["Inflation", "Recession", "Deflation", "Stagflation"]	1	A recession is characterized by low economic activity and high unemployment.	2025-08-17 20:27:11.116863
1016	Economics	SSCE	\N	Which of the following is a function of development banks?	["Issue currency", "Provide long-term loans", "Control money supply", "Collect taxes"]	1	Development banks provide long-term loans for economic development projects.	2025-08-17 20:27:11.116863
1017	Economics	SSCE	\N	What is the term for the flow of goods, services, and capital across borders?	["Balance of payments", "International trade", "Trade balance", "Capital account"]	1	International trade involves the exchange of goods, services, and capital across borders.	2025-08-17 20:27:11.116863
1018	Economics	SSCE	\N	Which of the following is a measure of population growth?	["Birth rate minus death rate", "GDP per capita", "Inflation rate", "Unemployment rate"]	0	Population growth is measured by the difference between birth and death rates.	2025-08-17 20:27:11.116863
1019	Economics	SSCE	\N	What is the term for the responsiveness of demand to a change in income?	["Price elasticity of demand", "Income elasticity of demand", "Elasticity of supply", "Cross elasticity"]	1	Income elasticity of demand measures how demand changes with income.	2025-08-17 20:27:11.116863
1020	Economics	SSCE	\N	Which of the following is a characteristic of a private good?	["Non-excludable", "Non-rivalrous", "Excludable", "Freely available"]	2	Private goods are excludable, meaning access can be restricted to paying users.	2025-08-17 20:27:11.116863
1021	Economics	SSCE	\N	What is the term for the income earned by entrepreneurship as a factor of production?	["Wages", "Rent", "Interest", "Profit"]	3	Profit is the income earned by entrepreneurs for organizing production.	2025-08-17 20:27:11.116863
1023	Economics	SSCE	\N	What is the term for the additional cost of producing one more unit of output?	["Fixed cost", "Variable cost", "Marginal cost", "Total cost"]	2	Marginal cost is the additional cost incurred to produce one more unit of output.	2025-08-17 20:27:11.116863
1024	Economics	SSCE	\N	Which of the following is a characteristic of a regressive tax system?	["Higher tax rate for higher incomes", "Flat tax rate", "Higher tax burden on lower incomes", "Equal tax for all"]	2	A regressive tax system imposes a higher burden on lower-income earners.	2025-08-17 20:27:11.116863
1025	Economics	SSCE	\N	What is the term for a government restriction on the quantity of exports?	["Tariff", "Subsidy", "Export quota", "Tax"]	2	An export quota limits the quantity of goods that can be exported.	2025-08-17 20:27:11.116863
1027	Economics	SSCE	\N	What is the term for a period of high inflation, high unemployment, and low growth?	["Recession", "Stagflation", "Deflation", "Depression"]	1	Stagflation combines high inflation, high unemployment, and low economic growth.	2025-08-17 20:27:11.116863
1028	Economics	SSCE	\N	Which of the following is a function of cooperative societies?	["Issue currency", "Provide loans to members", "Control money supply", "Set fiscal policy"]	1	Cooperative societies provide loans and financial services to their members.	2025-08-17 20:27:11.116863
1029	Economics	SSCE	\N	What is the term for the total value of all economic transactions between a country and the world?	["Balance of payments", "Trade balance", "Current account", "Capital account"]	0	The balance of payments records all economic transactions between a country and the rest of the world.	2025-08-17 20:27:11.116863
1030	Economics	SSCE	\N	Which of the following is a measure of economic inequality?	["GDP per capita", "Gini coefficient", "Inflation rate", "Unemployment rate"]	1	The Gini coefficient measures the degree of income inequality in a population.	2025-08-17 20:27:11.116863
1031	Chemistry	SSCE	\N	What is the SI unit of the amount of substance?	["Gram", "Mole", "Kilogram", "Liter"]	1	The SI unit for the amount of substance is the mole, which measures the number of particles.	2025-08-17 20:27:11.116863
1032	Chemistry	SSCE	\N	Which subatomic particle has a negative charge?	["Proton", "Neutron", "Electron", "Nucleus"]	2	Electrons carry a negative charge, while protons are positive and neutrons are neutral.	2025-08-17 20:27:11.116863
1033	Chemistry	SSCE	\N	What is the atomic number of an element with 11 protons and 12 neutrons?	["11", "12", "23", "1"]	0	The atomic number is equal to the number of protons, which is 11.	2025-08-17 20:27:11.116863
1034	Chemistry	SSCE	\N	Which gas is known as the laughing gas?	["Carbon dioxide", "Nitrous oxide", "Nitrogen", "Oxygen"]	1	Nitrous oxide (N₂O) is commonly called laughing gas due to its euphoric effects.	2025-08-17 20:27:11.116863
1035	Chemistry	SSCE	\N	What type of bond is formed by the sharing of electrons between atoms?	["Ionic bond", "Covalent bond", "Metallic bond", "Hydrogen bond"]	1	A covalent bond involves the sharing of electrons between non-metal atoms.	2025-08-17 20:27:11.116863
1036	Chemistry	SSCE	\N	What is the chemical formula for water?	["H₂O", "CO₂", "HCl", "NaCl"]	0	The chemical formula for water is H₂O, indicating two hydrogen atoms and one oxygen atom.	2025-08-17 20:27:11.116863
1037	Chemistry	SSCE	\N	Which of the following is a noble gas?	["Nitrogen", "Helium", "Oxygen", "Chlorine"]	1	Helium is a noble gas, characterized by a complete valence electron shell.	2025-08-17 20:27:11.116863
1038	Chemistry	SSCE	\N	What is the pH of a neutral solution at 25°C?	["0", "7", "14", "10"]	1	A neutral solution has a pH of 7 at 25°C, indicating equal concentrations of H⁺ and OH⁻ ions.	2025-08-17 20:27:11.116863
1039	Chemistry	SSCE	\N	Which element is the most electronegative?	["Oxygen", "Fluorine", "Chlorine", "Nitrogen"]	1	Fluorine is the most electronegative element on the periodic table.	2025-08-17 20:27:11.116863
1040	Chemistry	SSCE	\N	What is the mass of one mole of carbon-12?	["12 g", "1 g", "6 g", "24 g"]	0	One mole of carbon-12 has a mass of 12 grams, equal to its molar mass.	2025-08-17 20:27:11.116863
1041	Chemistry	SSCE	\N	Which of the following is a physical change?	["Burning wood", "Rusting iron", "Melting ice", "Cooking an egg"]	2	Melting ice is a physical change as it involves a change in state without altering the chemical composition.	2025-08-17 20:27:11.116863
1042	Chemistry	SSCE	\N	What is the formula for sulfuric acid?	["HCl", "H₂SO₄", "HNO₃", "H₂CO₃"]	1	The chemical formula for sulfuric acid is H₂SO₄.	2025-08-17 20:27:11.116863
1043	Chemistry	SSCE	\N	Which type of reaction releases energy?	["Endothermic", "Exothermic", "Neutralization", "Decomposition"]	1	Exothermic reactions release energy, usually in the form of heat.	2025-08-17 20:27:11.116863
1044	Chemistry	SSCE	\N	What is the main component of natural gas?	["Ethane", "Methane", "Propane", "Butane"]	1	Methane (CH₄) is the primary component of natural gas.	2025-08-17 20:27:11.116863
1045	Chemistry	SSCE	\N	Which gas is essential for respiration in humans?	["Carbon dioxide", "Nitrogen", "Oxygen", "Argon"]	2	Oxygen is required for cellular respiration in humans.	2025-08-17 20:27:11.116863
1046	Chemistry	SSCE	\N	What is the oxidation state of hydrogen in water (H₂O)?	["-1", "+1", "0", "+2"]	1	In water, hydrogen has an oxidation state of +1, as oxygen is more electronegative.	2025-08-17 20:27:11.116863
1047	Chemistry	SSCE	\N	Which of the following is a greenhouse gas?	["Nitrogen", "Carbon dioxide", "Oxygen", "Argon"]	1	Carbon dioxide is a greenhouse gas that traps heat in the atmosphere.	2025-08-17 20:27:11.116863
1048	Chemistry	SSCE	\N	What is the molar mass of water (H₂O)?	["18 g/mol", "16 g/mol", "20 g/mol", "14 g/mol"]	0	Molar mass of H₂O = (2 × 1) + 16 = 18 g/mol.	2025-08-17 20:27:11.116863
1049	Chemistry	SSCE	\N	Which of the following is a characteristic of acids?	["Turn blue litmus red", "Turn red litmus blue", "Neutral pH", "Produce OH⁻ ions"]	0	Acids turn blue litmus paper red due to their acidic nature.	2025-08-17 20:27:11.116863
1050	Chemistry	SSCE	\N	What is the chemical symbol for gold?	["Ag", "Au", "Fe", "Cu"]	1	The chemical symbol for gold is Au, derived from its Latin name 'aurum'.	2025-08-17 20:27:11.116863
1051	Chemistry	SSCE	\N	Which type of bond exists in a sodium chloride crystal?	["Covalent", "Ionic", "Metallic", "Hydrogen"]	1	Sodium chloride forms an ionic bond due to the transfer of electrons between sodium and chlorine.	2025-08-17 20:27:11.116863
1052	Chemistry	SSCE	\N	What is the product of a neutralization reaction between an acid and a base?	["Salt and water", "Salt and oxygen", "Water and carbon dioxide", "Salt and hydrogen"]	0	A neutralization reaction produces a salt and water.	2025-08-17 20:27:11.116863
1053	Chemistry	SSCE	\N	Which of the following is an allotrope of carbon?	["Graphite", "Iron", "Sulfur", "Nitrogen"]	0	Graphite is an allotrope of carbon, along with diamond and fullerenes.	2025-08-17 20:27:11.116863
1054	Chemistry	SSCE	\N	What is the formula for ammonia?	["NH₃", "NO₂", "N₂O", "NH₄"]	0	The chemical formula for ammonia is NH₃.	2025-08-17 20:27:11.116863
1055	Chemistry	SSCE	\N	Which of the following is a non-metal?	["Sodium", "Sulfur", "Iron", "Copper"]	1	Sulfur is a non-metal, while sodium, iron, and copper are metals.	2025-08-17 20:27:11.116863
1056	Chemistry	SSCE	\N	What is the process of separating a solid from a liquid by passing through a porous material called?	["Distillation", "Filtration", "Evaporation", "Sublimation"]	1	Filtration separates a solid from a liquid using a porous material like filter paper.	2025-08-17 20:27:11.116863
1057	Chemistry	SSCE	\N	Which gas is used in balloons to make them float?	["Oxygen", "Helium", "Carbon dioxide", "Nitrogen"]	1	Helium is lighter than air, causing balloons to float.	2025-08-17 20:27:11.116863
1058	Chemistry	SSCE	\N	What is the number of electrons in the outermost shell of a chlorine atom?	["1", "7", "2", "8"]	1	Chlorine has 7 electrons in its outermost shell (group 17).	2025-08-17 20:27:11.116863
1059	Chemistry	SSCE	\N	Which of the following is an example of an organic compound?	["Sodium chloride", "Methane", "Water", "Carbon dioxide"]	1	Methane (CH₄) is an organic compound containing carbon and hydrogen.	2025-08-17 20:27:11.116863
1060	Chemistry	SSCE	\N	What is the percentage composition of oxygen in water (H₂O)?	["88.9%", "11.1%", "50%", "75%"]	0	Molar mass of H₂O = 18 g/mol. Oxygen = 16 g/mol. Percentage = (16/18) × 100 = 88.9%.	2025-08-17 20:27:11.116863
1061	Chemistry	SSCE	\N	Which of the following is a characteristic of metals?	["Brittle", "Good conductor of electricity", "Low melting point", "Dull appearance"]	1	Metals are good conductors of electricity due to free electrons.	2025-08-17 20:27:11.116863
1062	Chemistry	SSCE	\N	What is the chemical formula for sodium hydroxide?	["NaCl", "NaOH", "Na₂CO₃", "NaHCO₃"]	1	The chemical formula for sodium hydroxide is NaOH.	2025-08-17 20:27:11.116863
1063	Chemistry	SSCE	\N	Which type of reaction involves the combination of two or more substances to form one product?	["Decomposition", "Synthesis", "Displacement", "Combustion"]	1	A synthesis reaction combines reactants to form a single product.	2025-08-17 20:27:11.116863
1064	Chemistry	SSCE	\N	What is the main source of energy in the Haber process?	["Solar energy", "Heat energy", "Electrical energy", "Nuclear energy"]	1	The Haber process uses heat energy to produce ammonia under high pressure.	2025-08-17 20:27:11.116863
1065	Chemistry	SSCE	\N	Which of the following is a halogen?	["Sodium", "Chlorine", "Magnesium", "Potassium"]	1	Chlorine is a halogen, belonging to group 17 of the periodic table.	2025-08-17 20:27:11.116863
1066	Chemistry	SSCE	\N	What is the process of separating components of a liquid mixture based on boiling points?	["Filtration", "Distillation", "Evaporation", "Crystallization"]	1	Distillation separates liquids based on differences in their boiling points.	2025-08-17 20:27:11.116863
1067	Chemistry	SSCE	\N	Which of the following is a product of complete combustion of hydrocarbons?	["Carbon monoxide", "Carbon dioxide", "Soot", "Sulfur dioxide"]	1	Complete combustion of hydrocarbons produces carbon dioxide and water.	2025-08-17 20:27:11.116863
1068	Chemistry	SSCE	\N	What is the oxidation state of oxygen in hydrogen peroxide (H₂O₂)?	["-2", "-1", "0", "+1"]	1	In hydrogen peroxide, oxygen has an oxidation state of -1, unlike -2 in most compounds.	2025-08-17 20:27:11.116863
1069	Chemistry	SSCE	\N	Which of the following is a renewable source of energy?	["Coal", "Natural gas", "Biogas", "Petroleum"]	2	Biogas is renewable, produced from organic matter like waste.	2025-08-17 20:27:11.116863
1070	Chemistry	SSCE	\N	What is the chemical formula for calcium carbonate?	["CaCO₃", "CaCl₂", "CaSO₄", "Ca(OH)₂"]	0	The chemical formula for calcium carbonate is CaCO₃.	2025-08-17 20:27:11.116863
1071	Chemistry	SSCE	\N	Which of the following is a characteristic of bases?	["Turn red litmus blue", "Turn blue litmus red", "Produce H⁺ ions", "Sour taste"]	0	Bases turn red litmus paper blue due to their alkaline nature.	2025-08-17 20:27:11.116863
1072	Chemistry	SSCE	\N	What is the molar mass of sodium chloride (NaCl)?	["58.5 g/mol", "35.5 g/mol", "23 g/mol", "40 g/mol"]	0	Molar mass of NaCl = 23 (Na) + 35.5 (Cl) = 58.5 g/mol.	2025-08-17 20:27:11.116863
1073	Chemistry	SSCE	\N	Which of the following is an example of a homogeneous mixture?	["Sand and water", "Salt solution", "Oil and water", "Soil"]	1	A salt solution is a homogeneous mixture with uniform composition.	2025-08-17 20:27:11.116863
1074	Chemistry	SSCE	\N	What is the name of the process where a solid turns directly into a gas?	["Melting", "Sublimation", "Evaporation", "Condensation"]	1	Sublimation is the direct transition of a solid to a gas without passing through the liquid state.	2025-08-17 20:27:11.116863
1075	Chemistry	SSCE	\N	Which of the following is a transition metal?	["Sodium", "Iron", "Potassium", "Calcium"]	1	Iron is a transition metal, located in the d-block of the periodic table.	2025-08-17 20:27:11.116863
1076	Chemistry	SSCE	\N	What is the chemical formula for ethanol?	["C₂H₅OH", "CH₃OH", "C₃H₇OH", "C₂H₄"]	0	The chemical formula for ethanol is C₂H₅OH.	2025-08-17 20:27:11.116863
1077	Chemistry	SSCE	\N	Which of the following is a property of ionic compounds?	["Low melting point", "High melting point", "Malleable", "Non-conductive in solid state"]	1	Ionic compounds have high melting points due to strong ionic bonds.	2025-08-17 20:27:11.116863
1078	Chemistry	SSCE	\N	What is the name of the gas that makes up about 78% of Earth’s atmosphere?	["Oxygen", "Nitrogen", "Carbon dioxide", "Argon"]	1	Nitrogen constitutes approximately 78% of Earth’s atmosphere.	2025-08-17 20:27:11.116863
1079	Chemistry	SSCE	\N	Which of the following is a catalyst in the Haber process?	["Iron", "Copper", "Zinc", "Silver"]	0	Iron is used as a catalyst in the Haber process to produce ammonia.	2025-08-17 20:27:11.116863
1080	Chemistry	SSCE	\N	What is the empirical formula of a compound with a molecular formula of C₆H₁₂O₆?	["C₃H₆O₃", "CH₂O", "C₂H₄O₂", "C₆H₁₂O₆"]	1	The empirical formula is the simplest ratio: C₆H₁₂O₆ ÷ 6 = CH₂O.	2025-08-17 20:27:11.116863
1081	Chemistry	SSCE	\N	Which of the following is a characteristic of alkanes?	["Unsaturated", "Single bonds only", "Contain double bonds", "Highly reactive"]	1	Alkanes are saturated hydrocarbons with single bonds only.	2025-08-17 20:27:11.116863
1082	Chemistry	SSCE	\N	What is the name of the process used to extract metals from their ores?	["Electrolysis", "Smelting", "Distillation", "Filtration"]	1	Smelting is the process of extracting metals from their ores by heating.	2025-08-17 20:27:11.116863
1083	Chemistry	SSCE	\N	Which of the following is a strong acid?	["Acetic acid", "Hydrochloric acid", "Carbonic acid", "Citric acid"]	1	Hydrochloric acid is a strong acid as it completely dissociates in water.	2025-08-17 20:27:11.116863
1084	Chemistry	SSCE	\N	What is the chemical formula for carbon monoxide?	["CO", "CO₂", "C₂O", "CH₄"]	0	The chemical formula for carbon monoxide is CO.	2025-08-17 20:27:11.116863
1085	Chemistry	SSCE	\N	Which of the following is a polymer?	["Glucose", "Polythene", "Ethanol", "Methane"]	1	Polythene is a polymer made from repeating ethylene units.	2025-08-17 20:27:11.116863
1086	Chemistry	SSCE	\N	What is the pH of a solution with a hydrogen ion concentration of 10⁻³ M?	["3", "7", "10", "1"]	0	pH = -log[H⁺] = -log(10⁻³) = 3.	2025-08-17 20:27:11.116863
1087	Chemistry	SSCE	\N	Which of the following is a characteristic of alkenes?	["Single bonds only", "Double bonds", "Triple bonds", "No bonds"]	1	Alkenes are unsaturated hydrocarbons with at least one double bond.	2025-08-17 20:27:11.116863
1088	Chemistry	SSCE	\N	What is the name of the process where a liquid turns into a gas at its surface?	["Sublimation", "Evaporation", "Condensation", "Boiling"]	1	Evaporation is the process where a liquid turns into a gas at its surface.	2025-08-17 20:27:11.116863
1089	Chemistry	SSCE	\N	Which element is used in thermometers due to its low melting point?	["Iron", "Mercury", "Copper", "Zinc"]	1	Mercury is used in thermometers due to its low melting point and thermal expansion.	2025-08-17 20:27:11.116863
1090	Chemistry	SSCE	\N	What is the chemical formula for hydrochloric acid?	["H₂SO₄", "HCl", "HNO₃", "H₂CO₃"]	1	The chemical formula for hydrochloric acid is HCl.	2025-08-17 20:27:11.116863
1091	Chemistry	SSCE	\N	Which of the following is a property of covalent compounds?	["High melting point", "Conduct electricity in solid state", "Low melting point", "Form crystals"]	2	Covalent compounds typically have low melting points due to weak intermolecular forces.	2025-08-17 20:27:11.116863
1092	Chemistry	SSCE	\N	What is the number of protons in an oxygen atom?	["8", "16", "6", "10"]	0	The atomic number of oxygen is 8, indicating 8 protons.	2025-08-17 20:27:11.116863
1093	Chemistry	SSCE	\N	Which of the following is a product of the electrolysis of sodium chloride solution?	["Oxygen", "Chlorine", "Nitrogen", "Carbon dioxide"]	1	Electrolysis of sodium chloride solution produces chlorine gas at the anode.	2025-08-17 20:27:11.116863
1094	Chemistry	SSCE	\N	What is the chemical formula for methane?	["CH₄", "C₂H₆", "C₃H₈", "C₄H₁₀"]	0	The chemical formula for methane is CH₄.	2025-08-17 20:27:11.116863
1095	Chemistry	SSCE	\N	Which of the following is a characteristic of a catalyst?	["Consumed in reaction", "Increases reaction rate", "Changes the products", "Decreases energy"]	1	A catalyst increases the rate of a reaction without being consumed.	2025-08-17 20:27:11.116863
1096	Chemistry	SSCE	\N	What is the name of the process used to purify copper?	["Smelting", "Electrolysis", "Distillation", "Filtration"]	1	Electrolysis is used to purify copper by electrorefining.	2025-08-17 20:27:11.116863
1097	Chemistry	SSCE	\N	Which of the following is a weak acid?	["Hydrochloric acid", "Acetic acid", "Sulfuric acid", "Nitric acid"]	1	Acetic acid is a weak acid as it partially dissociates in water.	2025-08-17 20:27:11.116863
1098	Chemistry	SSCE	\N	What is the chemical formula for sodium carbonate?	["NaCl", "Na₂CO₃", "NaOH", "NaHCO₃"]	1	The chemical formula for sodium carbonate is Na₂CO₃.	2025-08-17 20:27:11.116863
1099	Chemistry	SSCE	\N	Which of the following is a characteristic of alkynes?	["Single bonds only", "Double bonds", "Triple bonds", "No bonds"]	2	Alkynes are unsaturated hydrocarbons with at least one triple bond.	2025-08-17 20:27:11.116863
1100	Chemistry	SSCE	\N	What is the name of the gas used in fire extinguishers?	["Oxygen", "Carbon dioxide", "Nitrogen", "Helium"]	1	Carbon dioxide is used in fire extinguishers to displace oxygen and extinguish fires.	2025-08-17 20:27:11.116863
1101	Chemistry	SSCE	\N	Which of the following is a property of acids?	["Slippery feel", "Bitter taste", "Sour taste", "Turn red litmus blue"]	2	Acids have a sour taste and turn blue litmus red.	2025-08-17 20:27:11.116863
1102	Chemistry	SSCE	\N	What is the molar mass of oxygen gas (O₂)?	["16 g/mol", "32 g/mol", "8 g/mol", "24 g/mol"]	1	Molar mass of O₂ = 2 × 16 = 32 g/mol.	2025-08-17 20:27:11.116863
1103	Chemistry	SSCE	\N	Which of the following is an example of a heterogeneous mixture?	["Salt solution", "Air", "Sand and water", "Sugar syrup"]	2	Sand and water form a heterogeneous mixture with non-uniform composition.	2025-08-17 20:27:11.116863
1104	Chemistry	SSCE	\N	What is the name of the process where a gas turns directly into a solid?	["Sublimation", "Deposition", "Evaporation", "Condensation"]	1	Deposition is the direct transition of a gas to a solid.	2025-08-17 20:27:11.116863
1105	Chemistry	SSCE	\N	Which element is used in batteries due to its reactivity?	["Iron", "Lithium", "Copper", "Zinc"]	1	Lithium is used in batteries due to its high reactivity and lightweight properties.	2025-08-17 20:27:11.116863
1106	Chemistry	SSCE	\N	What is the chemical formula for nitric acid?	["HNO₃", "H₂SO₄", "HCl", "H₂CO₃"]	0	The chemical formula for nitric acid is HNO₃.	2025-08-17 20:27:11.116863
1107	Chemistry	SSCE	\N	Which of the following is a property of metallic bonding?	["Low conductivity", "Brittle structure", "Delocalized electrons", "Low melting point"]	2	Metallic bonding involves delocalized electrons, enabling conductivity.	2025-08-17 20:27:11.116863
1108	Chemistry	SSCE	\N	What is the number of neutrons in a carbon-14 atom?	["6", "8", "7", "14"]	1	Carbon-14 has 6 protons and a mass number of 14, so neutrons = 14 - 6 = 8.	2025-08-17 20:27:11.116863
1109	Chemistry	SSCE	\N	Which of the following is a product of the electrolysis of water?	["Carbon dioxide", "Oxygen", "Nitrogen", "Sulfur dioxide"]	1	Electrolysis of water produces oxygen at the anode and hydrogen at the cathode.	2025-08-17 20:27:11.116863
1110	Chemistry	SSCE	\N	What is the chemical formula for ethane?	["CH₄", "C₂H₆", "C₃H₈", "C₂H₄"]	1	The chemical formula for ethane is C₂H₆.	2025-08-17 20:27:11.116863
1111	Chemistry	SSCE	\N	Which of the following is a characteristic of a reversible reaction?	["Proceeds only in one direction", "Reaches equilibrium", "Produces no products", "Is always exothermic"]	1	A reversible reaction reaches equilibrium where forward and reverse reactions occur at equal rates.	2025-08-17 20:27:11.116863
1174	Biology	SSCE	\N	Which of the following is an example of a symbiotic relationship?	["Predation", "Mutualism", "Competition", "Parasitism"]	1	Mutualism is a symbiotic relationship where both organisms benefit.	2025-08-17 20:27:11.116863
1112	Chemistry	SSCE	\N	What is the name of the process used to separate crude oil into fractions?	["Filtration", "Fractional distillation", "Evaporation", "Crystallization"]	1	Fractional distillation separates crude oil based on different boiling points of its components.	2025-08-17 20:27:11.116863
1113	Chemistry	SSCE	\N	Which of the following is a strong base?	["Ammonium hydroxide", "Sodium hydroxide", "Calcium carbonate", "Ammonia"]	1	Sodium hydroxide is a strong base as it completely dissociates in water.	2025-08-17 20:27:11.116863
1114	Chemistry	SSCE	\N	What is the chemical formula for potassium hydroxide?	["KCl", "KOH", "K₂CO₃", "KHCO₃"]	1	The chemical formula for potassium hydroxide is KOH.	2025-08-17 20:27:11.116863
1115	Chemistry	SSCE	\N	Which of the following is a characteristic of aromatic hydrocarbons?	["Single bonds only", "Contain a benzene ring", "Highly saturated", "No carbon atoms"]	1	Aromatic hydrocarbons, like benzene, contain a benzene ring structure.	2025-08-17 20:27:11.116863
1116	Chemistry	SSCE	\N	What is the name of the gas used in welding?	["Oxygen", "Acetylene", "Nitrogen", "Carbon dioxide"]	1	Acetylene is used in welding due to its high flame temperature.	2025-08-17 20:27:11.116863
1117	Chemistry	SSCE	\N	Which of the following is a property of bases?	["Sour taste", "Slippery feel", "Turn red litmus blue", "Produce H⁺ ions"]	1	Bases have a slippery feel and turn red litmus blue.	2025-08-17 20:27:11.116863
1118	Chemistry	SSCE	\N	What is the molar mass of carbon dioxide (CO₂)?	["44 g/mol", "32 g/mol", "28 g/mol", "16 g/mol"]	0	Molar mass of CO₂ = 12 (C) + 2 × 16 (O) = 44 g/mol.	2025-08-17 20:27:11.116863
1119	Chemistry	SSCE	\N	Which of the following is an example of a suspension?	["Salt solution", "Milk", "Sugar syrup", "Air"]	1	Milk is a suspension with visible particles dispersed in a liquid.	2025-08-17 20:27:11.116863
1120	Chemistry	SSCE	\N	What is the name of the process where a solid dissolves in a liquid to form a solution?	["Sublimation", "Dissolution", "Evaporation", "Condensation"]	1	Dissolution is the process where a solid dissolves in a liquid to form a solution.	2025-08-17 20:27:11.116863
1121	Chemistry	SSCE	\N	Which element is used in fluorescent lamps?	["Neon", "Mercury", "Argon", "Krypton"]	1	Mercury vapor is used in fluorescent lamps to produce ultraviolet light.	2025-08-17 20:27:11.116863
1122	Chemistry	SSCE	\N	What is the chemical formula for ammonium chloride?	["NH₄Cl", "NH₃", "NH₄OH", "NCl₃"]	0	The chemical formula for ammonium chloride is NH₄Cl.	2025-08-17 20:27:11.116863
1123	Chemistry	SSCE	\N	Which of the following is a property of gases?	["Fixed shape", "Fixed volume", "High compressibility", "High density"]	2	Gases have high compressibility due to large spaces between particles.	2025-08-17 20:27:11.116863
1124	Chemistry	SSCE	\N	What is the number of electrons in a sodium ion (Na⁺)?	["11", "10", "12", "13"]	1	A sodium atom has 11 electrons; Na⁺ loses one electron, leaving 10.	2025-08-17 20:27:11.116863
1125	Chemistry	SSCE	\N	Which of the following is a product of fermentation of glucose?	["Carbon dioxide", "Oxygen", "Nitrogen", "Sulfur dioxide"]	0	Fermentation of glucose produces ethanol and carbon dioxide.	2025-08-17 20:27:11.116863
1126	Chemistry	SSCE	\N	What is the chemical formula for propene?	["C₃H₈", "C₃H₆", "C₂H₄", "C₄H₁₀"]	1	The chemical formula for propene, an alkene, is C₃H₆.	2025-08-17 20:27:11.116863
1127	Chemistry	SSCE	\N	Which of the following is a characteristic of a redox reaction?	["No electron transfer", "Electron transfer occurs", "Produces only water", "Involves only acids"]	1	A redox reaction involves the transfer of electrons between species.	2025-08-17 20:27:11.116863
1128	Chemistry	SSCE	\N	What is the name of the process used to produce aluminum from its ore?	["Smelting", "Electrolysis", "Distillation", "Filtration"]	1	Electrolysis is used to extract aluminum from bauxite in the Hall-Héroult process.	2025-08-17 20:27:11.116863
1129	Chemistry	SSCE	\N	Which of the following is a weak base?	["Sodium hydroxide", "Ammonia", "Potassium hydroxide", "Calcium hydroxide"]	1	Ammonia is a weak base as it partially dissociates in water.	2025-08-17 20:27:11.116863
1130	Chemistry	SSCE	\N	What is the chemical formula for sodium bicarbonate?	["Na₂CO₃", "NaHCO₃", "NaCl", "NaOH"]	1	The chemical formula for sodium bicarbonate is NaHCO₃.	2025-08-17 20:27:11.116863
1131	Chemistry	SSCE	\N	Which of the following is a characteristic of alcohols?	["Contain a carboxyl group", "Contain a hydroxyl group", "Contain a triple bond", "Are inorganic"]	1	Alcohols have a hydroxyl group (-OH) bonded to a carbon atom.	2025-08-17 20:27:11.116863
1132	Chemistry	SSCE	\N	What is the name of the gas used in neon lights?	["Helium", "Neon", "Argon", "Krypton"]	1	Neon gas is used in neon lights to produce a red-orange glow.	2025-08-17 20:27:11.116863
1134	Chemistry	SSCE	\N	What is the molar mass of sulfuric acid (H₂SO₄)?	["98 g/mol", "64 g/mol", "80 g/mol", "32 g/mol"]	0	Molar mass of H₂SO₄ = (2 × 1) + 32 + (4 × 16) = 98 g/mol.	2025-08-17 20:27:11.116863
1135	Chemistry	SSCE	\N	Which of the following is an example of a colloid?	["Salt solution", "Milk", "Sugar syrup", "Pure water"]	1	Milk is a colloid with dispersed fat particles in water.	2025-08-17 20:27:11.116863
1136	Chemistry	SSCE	\N	What is the name of the process where a liquid turns into a solid?	["Sublimation", "Freezing", "Evaporation", "Condensation"]	1	Freezing is the process where a liquid turns into a solid.	2025-08-17 20:27:11.116863
1137	Chemistry	SSCE	\N	Which element is used in nuclear reactors as a fuel?	["Iron", "Uranium", "Copper", "Zinc"]	1	Uranium is used as a fuel in nuclear reactors due to its fissionable properties.	2025-08-17 20:27:11.116863
1138	Biology	SSCE	\N	What is the primary source of energy for Earth's ecosystem?	["Wind", "Sun", "Geothermal", "Tides"]	1	The Sun provides energy for photosynthesis, which is the basis of energy flow in ecosystems.	2025-08-17 20:27:11.116863
1139	Biology	SSCE	\N	Which organelle is responsible for protein synthesis in a cell?	["Mitochondrion", "Ribosome", "Nucleus", "Golgi apparatus"]	1	Ribosomes are the sites where proteins are synthesized in the cell.	2025-08-17 20:27:11.116863
1140	Biology	SSCE	\N	What is the main function of the cell membrane?	["Energy production", "Controlling cell activities", "Regulating substances in and out", "Synthesizing proteins"]	2	The cell membrane regulates the movement of substances into and out of the cell.	2025-08-17 20:27:11.116863
1141	Biology	SSCE	\N	Which gas is primarily used by plants during photosynthesis?	["Oxygen", "Carbon dioxide", "Nitrogen", "Hydrogen"]	1	Plants use carbon dioxide during photosynthesis to produce glucose.	2025-08-17 20:27:11.116863
1142	Biology	SSCE	\N	What is the basic unit of life?	["Tissue", "Cell", "Organ", "Molecule"]	1	The cell is the smallest unit capable of performing life functions.	2025-08-17 20:27:11.116863
1143	Biology	SSCE	\N	Which blood group is known as the universal donor?	["A", "B", "AB", "O"]	3	Blood group O is the universal donor as it lacks antigens, making it compatible with all blood types.	2025-08-17 20:27:11.116863
1144	Biology	SSCE	\N	What is the process by which plants lose water through their leaves?	["Respiration", "Transpiration", "Photosynthesis", "Absorption"]	1	Transpiration is the loss of water vapor through the stomata of leaves.	2025-08-17 20:27:11.116863
1145	Biology	SSCE	\N	Which part of a flower produces pollen grains?	["Ovary", "Stigma", "Anther", "Petal"]	2	The anther is the part of the stamen that produces pollen grains.	2025-08-17 20:27:11.116863
1146	Biology	SSCE	\N	What is the genetic material in most living organisms?	["RNA", "DNA", "Protein", "Carbohydrate"]	1	DNA is the primary genetic material that carries hereditary information in most organisms.	2025-08-17 20:27:11.116863
1147	Biology	SSCE	\N	Which type of cell division results in gamete formation?	["Mitosis", "Meiosis", "Binary fission", "Budding"]	1	Meiosis produces gametes with half the chromosome number for sexual reproduction.	2025-08-17 20:27:11.116863
1148	Biology	SSCE	\N	What is the main function of the kidneys in humans?	["Digestion", "Filtration of blood", "Respiration", "Circulation"]	1	The kidneys filter blood to remove waste and regulate water and electrolyte balance.	2025-08-17 20:27:11.116863
1149	Biology	SSCE	\N	Which of the following is a characteristic of mammals?	["Cold-blooded", "Lay eggs", "Have mammary glands", "Have scales"]	2	Mammals have mammary glands that produce milk to nourish their young.	2025-08-17 20:27:11.116863
1150	Biology	SSCE	\N	What is the role of chlorophyll in plants?	["Transport water", "Absorb light energy", "Store nutrients", "Protect against pests"]	1	Chlorophyll absorbs light energy for photosynthesis.	2025-08-17 20:27:11.116863
1151	Biology	SSCE	\N	Which of the following is an example of a decomposer?	["Grass", "Fungi", "Lion", "Eagle"]	1	Fungi break down dead organic matter, acting as decomposers in ecosystems.	2025-08-17 20:27:11.116863
1152	Biology	SSCE	\N	What is the process of breaking down food into simpler substances called?	["Respiration", "Digestion", "Photosynthesis", "Excretion"]	1	Digestion is the process of breaking down food into simpler substances for absorption.	2025-08-17 20:27:11.116863
1153	Biology	SSCE	\N	Which organ is responsible for pumping blood in the human body?	["Liver", "Heart", "Lung", "Kidney"]	1	The heart pumps blood throughout the body via the circulatory system.	2025-08-17 20:27:11.116863
1154	Biology	SSCE	\N	What is the term for organisms that produce their own food?	["Heterotrophs", "Autotrophs", "Carnivores", "Omnivores"]	1	Autotrophs, like plants, produce their own food through processes like photosynthesis.	2025-08-17 20:27:11.116863
1155	Biology	SSCE	\N	Which of the following is a function of the root system in plants?	["Photosynthesis", "Anchorage", "Reproduction", "Respiration"]	1	Roots anchor plants in the soil and absorb water and nutrients.	2025-08-17 20:27:11.116863
1156	Biology	SSCE	\N	What is the genetic makeup of an organism called?	["Phenotype", "Genotype", "Allele", "Trait"]	1	The genotype is the genetic makeup of an organism, determining its traits.	2025-08-17 20:27:11.116863
1157	Biology	SSCE	\N	Which gas is released as a byproduct of photosynthesis?	["Carbon dioxide", "Oxygen", "Nitrogen", "Hydrogen"]	1	Oxygen is released as a byproduct during photosynthesis in plants.	2025-08-17 20:27:11.116863
1158	Biology	SSCE	\N	What is the main function of the respiratory system in humans?	["Digestion", "Gas exchange", "Circulation", "Excretion"]	1	The respiratory system facilitates gas exchange, supplying oxygen and removing carbon dioxide.	2025-08-17 20:27:11.116863
1159	Biology	SSCE	\N	Which of the following is a characteristic of arthropods?	["Backbone", "Exoskeleton", "Mammary glands", "Gills"]	1	Arthropods have an exoskeleton made of chitin, providing support and protection.	2025-08-17 20:27:11.116863
1160	Biology	SSCE	\N	What is the process by which organisms produce offspring?	["Respiration", "Reproduction", "Excretion", "Nutrition"]	1	Reproduction is the process by which organisms produce offspring to continue their species.	2025-08-17 20:27:11.116863
1161	Biology	SSCE	\N	Which biomolecule is the primary source of energy for the body?	["Protein", "Carbohydrate", "Lipid", "Nucleic acid"]	1	Carbohydrates are the primary source of energy, broken down into glucose for cellular use.	2025-08-17 20:27:11.116863
1162	Biology	SSCE	\N	What is the role of the stomata in plants?	["Absorb sunlight", "Gas exchange", "Store nutrients", "Transport water"]	1	Stomata allow gas exchange, taking in carbon dioxide and releasing oxygen.	2025-08-17 20:27:11.116863
1163	Biology	SSCE	\N	Which of the following is a producer in a food chain?	["Lion", "Grass", "Hawk", "Snake"]	1	Grass is a producer, as it synthesizes its own food through photosynthesis.	2025-08-17 20:27:11.116863
1164	Biology	SSCE	\N	What is the function of the nucleus in a cell?	["Energy production", "Controlling cell activities", "Protein synthesis", "Waste removal"]	1	The nucleus controls cell activities and contains genetic material.	2025-08-17 20:27:11.116863
1165	Biology	SSCE	\N	Which type of reproduction involves only one parent?	["Sexual reproduction", "Asexual reproduction", "Binary fission", "Budding"]	1	Asexual reproduction involves one parent and produces genetically identical offspring.	2025-08-17 20:27:11.116863
1166	Biology	SSCE	\N	What is the main source of energy for cellular respiration?	["Glucose", "Oxygen", "Carbon dioxide", "Water"]	0	Glucose is broken down during cellular respiration to release energy.	2025-08-17 20:27:11.116863
1167	Biology	SSCE	\N	Which organelle is known as the powerhouse of the cell?	["Nucleus", "Mitochondrion", "Ribosome", "Lysosome"]	1	Mitochondria produce ATP, the cell’s energy currency, through respiration.	2025-08-17 20:27:11.116863
1168	Biology	SSCE	\N	What is the term for the physical expression of an organism’s genes?	["Genotype", "Phenotype", "Allele", "Chromosome"]	1	The phenotype is the observable physical or biochemical traits of an organism.	2025-08-17 20:27:11.116863
1169	Biology	SSCE	\N	Which of the following is a function of the liver?	["Pumping blood", "Detoxifying harmful substances", "Gas exchange", "Producing urine"]	1	The liver detoxifies harmful substances and performs metabolic functions.	2025-08-17 20:27:11.116863
1170	Biology	SSCE	\N	Which of the following is a characteristic of bacteria?	["Have a nucleus", "Lack a nucleus", "Multicellular", "Have chloroplasts"]	1	Bacteria are prokaryotes and lack a true nucleus.	2025-08-17 20:27:11.116863
1171	Biology	SSCE	\N	What is the process by which water moves through a plant from roots to leaves?	["Photosynthesis", "Transpiration", "Respiration", "Absorption"]	1	Transpiration drives the movement of water from roots to leaves through the plant.	2025-08-17 20:27:11.116863
1172	Biology	SSCE	\N	Which type of tissue provides support in plants?	["Parenchyma", "Sclerenchyma", "Collenchyma", "Xylem"]	1	Sclerenchyma provides structural support with its thick, lignified cell walls.	2025-08-17 20:27:11.116863
1173	Biology	SSCE	\N	What is the role of red blood cells in the human body?	["Fight infections", "Transport oxygen", "Clot blood", "Digest food"]	1	Red blood cells transport oxygen from the lungs to body tissues.	2025-08-17 20:27:11.116863
1175	Biology	SSCE	\N	What is the function of the pancreas in digestion?	["Produces bile", "Produces digestive enzymes", "Absorbs nutrients", "Stores food"]	1	The pancreas produces digestive enzymes that help break down carbohydrates, proteins, and fats.	2025-08-17 20:27:11.116863
1176	Biology	SSCE	\N	Which of the following is a characteristic of viruses?	["Have a cell wall", "Reproduce independently", "Require a host to reproduce", "Perform photosynthesis"]	2	Viruses require a host cell to reproduce as they lack their own metabolic machinery.	2025-08-17 20:27:11.116863
1177	Biology	SSCE	\N	What is the term for the variety of life in an ecosystem?	["Population", "Biodiversity", "Community", "Habitat"]	1	Biodiversity refers to the variety of life forms in an ecosystem.	2025-08-17 20:27:11.116863
1178	Biology	SSCE	\N	Which part of the human brain controls balance and coordination?	["Cerebrum", "Cerebellum", "Medulla", "Hypothalamus"]	1	The cerebellum is responsible for balance and coordination.	2025-08-17 20:27:11.116863
1179	Biology	SSCE	\N	What is the process by which organisms adapt to their environment over generations?	["Evolution", "Mutation", "Reproduction", "Respiration"]	0	Evolution is the process of adaptation through natural selection over generations.	2025-08-17 20:27:11.116863
1180	Biology	SSCE	\N	Which of the following is a function of the xylem in plants?	["Transport food", "Transport water", "Support leaves", "Produce flowers"]	1	Xylem transports water and minerals from roots to other parts of the plant.	2025-08-17 20:27:11.116863
1181	Biology	SSCE	\N	What is the term for a change in an organism’s DNA?	["Evolution", "Mutation", "Adaptation", "Selection"]	1	A mutation is a change in the DNA sequence of an organism.	2025-08-17 20:27:11.116863
1182	Biology	SSCE	\N	Which of the following is a primary consumer in a food chain?	["Lion", "Grasshopper", "Hawk", "Snake"]	1	Grasshoppers are primary consumers as they feed directly on producers like plants.	2025-08-17 20:27:11.116863
1183	Biology	SSCE	\N	What is the function of white blood cells in the human body?	["Transport oxygen", "Fight infections", "Clot blood", "Carry nutrients"]	1	White blood cells are part of the immune system and fight infections.	2025-08-17 20:27:11.116863
1184	Biology	SSCE	\N	Which of the following is a characteristic of amphibians?	["Dry skin", "Live entirely in water", "Moist skin", "Have feathers"]	2	Amphibians have moist skin, which aids in respiration.	2025-08-17 20:27:11.116863
1185	Biology	SSCE	\N	What is the term for the movement of water across a semi-permeable membrane?	["Diffusion", "Osmosis", "Active transport", "Filtration"]	1	Osmosis is the movement of water across a semi-permeable membrane from high to low concentration.	2025-08-17 20:27:11.116863
1186	Biology	SSCE	\N	Which organ in humans produces insulin?	["Liver", "Pancreas", "Kidney", "Stomach"]	1	The pancreas produces insulin to regulate blood sugar levels.	2025-08-17 20:27:11.116863
1187	Biology	SSCE	\N	What is the role of the phloem in plants?	["Transport water", "Transport food", "Support stem", "Absorb sunlight"]	1	Phloem transports food (sugars) produced during photosynthesis to other parts of the plant.	2025-08-17 20:27:11.116863
1188	Biology	SSCE	\N	Which of the following is a method of asexual reproduction in plants?	["Pollination", "Vegetative propagation", "Fertilization", "Seed dispersal"]	1	Vegetative propagation involves producing new plants from stems, roots, or leaves.	2025-08-17 20:27:11.116863
1189	Biology	SSCE	\N	What is the term for organisms that feed on both plants and animals?	["Herbivores", "Carnivores", "Omnivores", "Decomposers"]	2	Omnivores consume both plant and animal matter.	2025-08-17 20:27:11.116863
1190	Biology	SSCE	\N	Which part of the human eye detects light?	["Cornea", "Retina", "Lens", "Iris"]	1	The retina contains photoreceptors that detect light and form images.	2025-08-17 20:27:11.116863
1191	Biology	SSCE	\N	What is the process of cell division that produces identical daughter cells?	["Meiosis", "Mitosis", "Binary fission", "Budding"]	1	Mitosis produces two identical daughter cells for growth and repair.	2025-08-17 20:27:11.116863
1192	Biology	SSCE	\N	Which of the following is a function of the skeletal system?	["Gas exchange", "Support and movement", "Digestion", "Excretion"]	1	The skeletal system provides support and enables movement.	2025-08-17 20:27:11.116863
1193	Biology	SSCE	\N	What is the term for the relationship where one organism benefits and the other is harmed?	["Mutualism", "Parasitism", "Commensalism", "Competition"]	1	Parasitism involves one organism benefiting at the expense of another.	2025-08-17 20:27:11.116863
1194	Biology	SSCE	\N	Which of the following is a characteristic of fungi?	["Perform photosynthesis", "Have chlorophyll", "Absorb nutrients", "Are autotrophs"]	2	Fungi absorb nutrients from their environment as they lack chlorophyll.	2025-08-17 20:27:11.116863
1195	Biology	SSCE	\N	What is the function of the small intestine in digestion?	["Store food", "Absorb nutrients", "Produce bile", "Break down proteins"]	1	The small intestine is the primary site for nutrient absorption in digestion.	2025-08-17 20:27:11.116863
1196	Biology	SSCE	\N	Which of the following is a source of variation in populations?	["Mitosis", "Mutation", "Photosynthesis", "Respiration"]	1	Mutation introduces genetic variation by altering DNA sequences.	2025-08-17 20:27:11.116863
1197	Biology	SSCE	\N	What is the role of the spinal cord in the human nervous system?	["Control emotions", "Transmit nerve impulses", "Regulate hormones", "Produce blood cells"]	1	The spinal cord transmits nerve impulses between the brain and body.	2025-08-17 20:27:11.116863
1198	Biology	SSCE	\N	Which of the following is a characteristic of reptiles?	["Moist skin", "Scaly skin", "Feathers", "Mammary glands"]	1	Reptiles have scaly skin that prevents water loss.	2025-08-17 20:27:11.116863
1199	Biology	SSCE	\N	What is the term for the movement of substances from high to low concentration without energy?	["Active transport", "Diffusion", "Osmosis", "Filtration"]	1	Diffusion is the passive movement of substances from high to low concentration.	2025-08-17 20:27:11.116863
1200	Biology	SSCE	\N	Which organ in humans filters blood and produces urine?	["Liver", "Kidney", "Heart", "Lung"]	1	The kidneys filter blood and produce urine to excrete waste.	2025-08-17 20:27:11.116863
1201	Biology	SSCE	\N	What is the term for the level of organization that includes all living organisms in an area?	["Population", "Community", "Ecosystem", "Biosphere"]	1	A community includes all living organisms in a specific area.	2025-08-17 20:27:11.116863
1202	Biology	SSCE	\N	Which of the following is a function of the endocrine system?	["Transport oxygen", "Regulate hormones", "Digest food", "Support movement"]	1	The endocrine system regulates body functions through hormone production.	2025-08-17 20:27:11.116863
1203	Biology	SSCE	\N	What is the term for organisms that feed only on plants?	["Carnivores", "Herbivores", "Omnivores", "Decomposers"]	1	Herbivores feed exclusively on plants.	2025-08-17 20:27:11.116863
1204	Biology	SSCE	\N	Which part of a plant is primarily responsible for photosynthesis?	["Root", "Leaf", "Stem", "Flower"]	1	Leaves contain chlorophyll and are the primary site of photosynthesis.	2025-08-17 20:27:11.116863
1205	Biology	SSCE	\N	What is the term for the inheritance of traits from parents to offspring?	["Evolution", "Heredity", "Mutation", "Adaptation"]	1	Heredity is the process by which traits are passed from parents to offspring.	2025-08-17 20:27:11.116863
1206	Biology	SSCE	\N	Which of the following is a function of the nervous system?	["Produce hormones", "Coordinate body activities", "Transport nutrients", "Digest food"]	1	The nervous system coordinates body activities through nerve impulses.	2025-08-17 20:27:11.116863
1207	Biology	SSCE	\N	Which of the following is a characteristic of birds?	["Scaly skin", "Feathers", "Moist skin", "Gills"]	1	Birds are characterized by feathers, which aid in flight and insulation.	2025-08-17 20:27:11.116863
1208	Biology	SSCE	\N	What is the term for the interaction between two species where one benefits and the other is unaffected?	["Mutualism", "Commensalism", "Parasitism", "Competition"]	1	Commensalism is a relationship where one species benefits and the other is unaffected.	2025-08-17 20:27:11.116863
1209	Biology	SSCE	\N	Which of the following is a function of the Golgi apparatus?	["Energy production", "Modify and package proteins", "Synthesize DNA", "Break down waste"]	1	The Golgi apparatus modifies, packages, and sorts proteins for secretion.	2025-08-17 20:27:11.116863
1210	Biology	SSCE	\N	What is the term for the living components of an ecosystem?	["Abiotic factors", "Biotic factors", "Habitat", "Niche"]	1	Biotic factors include all living organisms in an ecosystem.	2025-08-17 20:27:11.116863
1211	Biology	SSCE	\N	Which of the following is a function of the skin in humans?	["Gas exchange", "Temperature regulation", "Blood production", "Digestion"]	1	The skin regulates body temperature through sweating and vasoconstriction.	2025-08-17 20:27:11.116863
1212	Biology	SSCE	\N	What is the term for the process by which organisms maintain a stable internal environment?	["Evolution", "Homeostasis", "Adaptation", "Metabolism"]	1	Homeostasis is the process of maintaining a stable internal environment.	2025-08-17 20:27:11.116863
1213	Biology	SSCE	\N	Which of the following is a characteristic of prokaryotes?	["Have a nucleus", "Lack a nucleus", "Multicellular", "Have chloroplasts"]	1	Prokaryotes, like bacteria, lack a true nucleus.	2025-08-17 20:27:11.116863
1214	Biology	SSCE	\N	What is the function of the trachea in the respiratory system?	["Absorb oxygen", "Conduct air to lungs", "Produce mucus", "Filter blood"]	1	The trachea conducts air to and from the lungs during respiration.	2025-08-17 20:27:11.116863
1215	Biology	SSCE	\N	Which of the following is a method of seed dispersal?	["Photosynthesis", "Wind dispersal", "Transpiration", "Respiration"]	1	Wind dispersal is a method by which seeds are spread to new locations.	2025-08-17 20:27:11.116863
1216	Biology	SSCE	\N	What is the term for the role an organism plays in its ecosystem?	["Population", "Niche", "Community", "Habitat"]	1	The niche is the role or function of an organism in its ecosystem.	2025-08-17 20:27:11.116863
1217	Biology	SSCE	\N	Which of the following is a function of the large intestine in humans?	["Digest proteins", "Absorb water", "Produce bile", "Store food"]	1	The large intestine absorbs water and forms feces.	2025-08-17 20:27:11.116863
1218	Biology	SSCE	\N	What is the term for the evolutionary process where organisms better suited to their environment survive?	["Mutation", "Natural selection", "Adaptation", "Heredity"]	1	Natural selection is the process where organisms better adapted to their environment survive and reproduce.	2025-08-17 20:27:11.116863
1219	Biology	SSCE	\N	Which of the following is a characteristic of monocots?	["Taproot system", "Parallel leaf veins", "Two seed leaves", "Woody stems"]	1	Monocots have parallel leaf veins, unlike dicots with net-like veins.	2025-08-17 20:27:11.116863
1220	Biology	SSCE	\N	What is the function of platelets in the blood?	["Transport oxygen", "Fight infections", "Clot blood", "Carry nutrients"]	2	Platelets are responsible for blood clotting to prevent excessive bleeding.	2025-08-17 20:27:11.116863
1221	Biology	SSCE	\N	Which of the following is a function of the lysosome in a cell?	["Produce energy", "Break down waste", "Synthesize proteins", "Store nutrients"]	1	Lysosomes break down waste materials and cellular debris.	2025-08-17 20:27:11.116863
1222	Biology	SSCE	\N	What is the term for the non-living components of an ecosystem?	["Biotic factors", "Abiotic factors", "Producers", "Consumers"]	1	Abiotic factors include non-living components like water, air, and sunlight.	2025-08-17 20:27:11.116863
1223	Biology	SSCE	\N	Which of the following is a function of the thyroid gland?	["Regulate blood sugar", "Regulate metabolism", "Produce digestive enzymes", "Filter blood"]	1	The thyroid gland produces hormones that regulate metabolism.	2025-08-17 20:27:11.116863
1224	Biology	SSCE	\N	What is the term for organisms that feed on dead organic matter?	["Producers", "Decomposers", "Herbivores", "Carnivores"]	1	Decomposers break down dead organic matter to recycle nutrients.	2025-08-17 20:27:11.116863
1225	Biology	SSCE	\N	Which part of a flower develops into a fruit after fertilization?	["Ovary", "Anther", "Stigma", "Petal"]	0	The ovary develops into a fruit after fertilization in plants.	2025-08-17 20:27:11.116863
1226	Biology	SSCE	\N	What is the term for the process by which organisms use oxygen to produce energy?	["Photosynthesis", "Respiration", "Transpiration", "Digestion"]	1	Respiration uses oxygen to break down glucose and produce energy.	2025-08-17 20:27:11.116863
1227	Biology	SSCE	\N	Which of the following is a characteristic of dicots?	["Parallel leaf veins", "One seed leaf", "Net-like leaf veins", "Fibrous roots"]	2	Dicots have net-like leaf veins, unlike monocots with parallel veins.	2025-08-17 20:27:11.116863
1228	Biology	SSCE	\N	What is the function of the hypothalamus in the human brain?	["Control balance", "Regulate body temperature", "Produce blood cells", "Coordinate movement"]	1	The hypothalamus regulates body temperature, hunger, and hormone release.	2025-08-17 20:27:11.116863
1229	Biology	SSCE	\N	Which of the following is a method of preventing soil erosion?	["Deforestation", "Afforestation", "Overgrazing", "Urbanization"]	1	Afforestation involves planting trees to stabilize soil and prevent erosion.	2025-08-17 20:27:11.116863
1230	Biology	SSCE	\N	What is the term for the group of individuals of the same species living in an area?	["Community", "Population", "Ecosystem", "Biosphere"]	1	A population is a group of individuals of the same species in a specific area.	2025-08-17 20:27:11.116863
1231	Biology	SSCE	\N	Which of the following is a function of the circulatory system?	["Gas exchange", "Transport nutrients", "Produce hormones", "Digest food"]	1	The circulatory system transports nutrients, oxygen, and waste throughout the body.	2025-08-17 20:27:11.116863
1232	Biology	SSCE	\N	What is the term for the loss of water vapor from plant surfaces?	["Respiration", "Transpiration", "Photosynthesis", "Excretion"]	1	Transpiration is the loss of water vapor, primarily through stomata.	2025-08-17 20:27:11.116863
1233	Biology	SSCE	\N	Which of the following is a characteristic of chordates?	["Exoskeleton", "Notochord", "Gills", "Scales"]	1	Chordates have a notochord at some stage of development.	2025-08-17 20:27:11.116863
1234	Physics	SSCE	\N	What is the SI unit of force?	["Newton", "Joule", "Watt", "Pascal"]	0	The SI unit of force is the Newton, defined as kg·m/s².	2025-08-17 20:27:11.116863
1235	Physics	SSCE	\N	Which of the following is a scalar quantity?	["Velocity", "Acceleration", "Mass", "Force"]	2	Mass is a scalar quantity as it has magnitude only, unlike velocity, acceleration, and force, which have direction.	2025-08-17 20:27:11.116863
1236	Physics	SSCE	\N	What is the acceleration due to gravity on Earth’s surface?	["9.8 m/s²", "8.9 m/s²", "10.8 m/s²", "7.8 m/s²"]	0	The standard value of acceleration due to gravity on Earth is approximately 9.8 m/s².	2025-08-17 20:27:11.116863
1237	Physics	SSCE	\N	Which law states that the force on an object is equal to its mass times its acceleration?	["Newton’s First Law", "Newton’s Second Law", "Newton’s Third Law", "Law of Gravitation"]	1	Newton’s Second Law states that F = ma, where force equals mass times acceleration.	2025-08-17 20:27:11.116863
1238	Physics	SSCE	\N	What is the work done when a force of 20 N moves an object 5 m in the direction of the force?	["100 J", "25 J", "4 J", "125 J"]	0	Work done = Force × Distance = 20 N × 5 m = 100 J.	2025-08-17 20:27:11.116863
1239	Physics	SSCE	\N	Which of the following is a unit of power?	["Joule", "Watt", "Newton", "Pascal"]	1	The SI unit of power is the Watt, defined as Joule per second (J/s).	2025-08-17 20:27:11.116863
1240	Physics	SSCE	\N	What is the momentum of a 2 kg object moving at 5 m/s?	["10 kg·m/s", "7 kg·m/s", "12 kg·m/s", "2 kg·m/s"]	0	Momentum = mass × velocity = 2 kg × 5 m/s = 10 kg·m/s.	2025-08-17 20:27:11.116863
1241	Physics	SSCE	\N	Which type of energy is stored in a stretched spring?	["Kinetic energy", "Potential energy", "Thermal energy", "Chemical energy"]	1	A stretched spring stores elastic potential energy.	2025-08-17 20:27:11.116863
1242	Physics	SSCE	\N	What is the SI unit of electric current?	["Volt", "Ampere", "Ohm", "Watt"]	1	The SI unit of electric current is the Ampere.	2025-08-17 20:27:11.116863
1243	Physics	SSCE	\N	Which law relates voltage, current, and resistance in a circuit?	["Faraday’s Law", "Ohm’s Law", "Coulomb’s Law", "Kirchhoff’s Law"]	1	Ohm’s Law states that V = IR, relating voltage, current, and resistance.	2025-08-17 20:27:11.116863
1244	Physics	SSCE	\N	What is the resistance of a conductor if a current of 2 A flows through it with a voltage of 10 V?	["5 Ω", "20 Ω", "2 Ω", "12 Ω"]	0	Using Ohm’s Law, R = V/I = 10 V / 2 A = 5 Ω.	2025-08-17 20:27:11.116863
1245	Physics	SSCE	\N	What is the frequency of a wave with a period of 0.02 s?	["50 Hz", "20 Hz", "100 Hz", "25 Hz"]	0	Frequency = 1 / Period = 1 / 0.02 s = 50 Hz.	2025-08-17 20:27:11.116863
1246	Physics	SSCE	\N	Which of the following is a property of transverse waves?	["Compression", "Rarefaction", "Polarization", "Diffraction"]	2	Polarization is a property unique to transverse waves.	2025-08-17 20:27:11.116863
1247	Physics	SSCE	\N	What is the speed of a wave with a frequency of 10 Hz and a wavelength of 2 m?	["5 m/s", "20 m/s", "12 m/s", "8 m/s"]	1	Wave speed = frequency × wavelength = 10 Hz × 2 m = 20 m/s.	2025-08-17 20:27:11.116863
1248	Physics	SSCE	\N	Which of the following is a renewable source of energy?	["Coal", "Solar energy", "Natural gas", "Petroleum"]	1	Solar energy is renewable as it is derived from the sun, which is inexhaustible.	2025-08-17 20:27:11.116863
1249	Physics	SSCE	\N	What is the SI unit of energy?	["Newton", "Joule", "Watt", "Pascal"]	1	The SI unit of energy is the Joule.	2025-08-17 20:27:11.116863
1250	Physics	SSCE	\N	What is the kinetic energy of a 4 kg object moving at 3 m/s?	["18 J", "36 J", "12 J", "24 J"]	0	Kinetic energy = ½ mv² = ½ × 4 kg × (3 m/s)² = 18 J.	2025-08-17 20:27:11.116863
1251	Physics	SSCE	\N	Which instrument is used to measure atmospheric pressure?	["Thermometer", "Barometer", "Ammeter", "Voltmeter"]	1	A barometer measures atmospheric pressure.	2025-08-17 20:27:11.116863
1252	Physics	SSCE	\N	What is the focal length of a plane mirror?	["Zero", "Infinity", "1 m", "-1 m"]	1	The focal length of a plane mirror is infinity, as it does not converge light.	2025-08-17 20:27:11.116863
1253	Physics	SSCE	\N	Which of the following is a vector quantity?	["Speed", "Distance", "Velocity", "Time"]	2	Velocity is a vector quantity as it has both magnitude and direction.	2025-08-17 20:27:11.116863
1254	Physics	SSCE	\N	What is the power of a machine that does 500 J of work in 10 s?	["50 W", "5000 W", "5 W", "100 W"]	0	Power = Work / Time = 500 J / 10 s = 50 W.	2025-08-17 20:27:11.116863
1255	Physics	SSCE	\N	What is the unit of specific heat capacity?	["J/kg·K", "J/kg", "kg/m³", "J/s"]	0	Specific heat capacity is measured in J/kg·K, representing energy per unit mass per degree Kelvin.	2025-08-17 20:27:11.116863
1256	Physics	SSCE	\N	Which type of lens converges light rays to a point?	["Concave lens", "Convex lens", "Plane lens", "Biconcave lens"]	1	A convex lens converges light rays to a focal point.	2025-08-17 20:27:11.116863
1257	Physics	SSCE	\N	What is the potential difference across a 4 Ω resistor with a current of 3 A?	["12 V", "7 V", "1.33 V", "9 V"]	0	Using Ohm’s Law, V = IR = 3 A × 4 Ω = 12 V.	2025-08-17 20:27:11.116863
1258	Physics	SSCE	\N	Which of the following is a property of sound waves?	["Polarization", "Refraction", "Interference", "Reflection"]	2	Interference is a property of sound waves, where waves superpose to form a resultant wave.	2025-08-17 20:27:11.116863
1259	Physics	SSCE	\N	What is the SI unit of magnetic flux?	["Tesla", "Weber", "Ampere", "Henry"]	1	The SI unit of magnetic flux is the Weber.	2025-08-17 20:27:11.116863
1260	Physics	SSCE	\N	What is the angle of incidence when light travels from air to glass and the angle of refraction is 30° with a refractive index of 1.5?	["45°", "30°", "60°", "20°"]	0	Using Snell’s Law, n₁ sin θ₁ = n₂ sin θ₂, sin θ₁ = 1.5 × sin 30° = 0.75, so θ₁ = arcsin(0.75) ≈ 48.6°, closest to 45°.	2025-08-17 20:27:11.116863
1261	Physics	SSCE	\N	What is the efficiency of a machine if the work input is 1000 J and the work output is 800 J?	["80%", "20%", "100%", "50%"]	0	Efficiency = (Work output / Work input) × 100 = (800 J / 1000 J) × 100 = 80%.	2025-08-17 20:27:11.116863
1262	Physics	SSCE	\N	Which of the following is a unit of pressure?	["Joule", "Pascal", "Watt", "Newton"]	1	The SI unit of pressure is the Pascal, defined as N/m².	2025-08-17 20:27:11.116863
1263	Physics	SSCE	\N	What is the resultant force when two forces of 3 N and 4 N act at right angles to each other?	["5 N", "7 N", "1 N", "12 N"]	0	Resultant force = √(3² + 4²) = √(9 + 16) = √25 = 5 N.	2025-08-17 20:27:11.116863
1264	Physics	SSCE	\N	What is the boiling point of water at standard atmospheric pressure?	["0°C", "100°C", "50°C", "200°C"]	1	Water boils at 100°C at standard atmospheric pressure (1 atm).	2025-08-17 20:27:11.116863
1265	Physics	SSCE	\N	Which of the following is a conductor of electricity?	["Rubber", "Copper", "Plastic", "Wood"]	1	Copper is a good conductor of electricity due to its free electrons.	2025-08-17 20:27:11.116863
1266	Physics	SSCE	\N	What is the period of a pendulum with a frequency of 2 Hz?	["0.5 s", "2 s", "1 s", "0.25 s"]	0	Period = 1 / Frequency = 1 / 2 Hz = 0.5 s.	2025-08-17 20:27:11.116863
1267	Physics	SSCE	\N	Which particle is responsible for electric current in a conductor?	["Proton", "Electron", "Neutron", "Photon"]	1	Electrons are the charge carriers responsible for electric current in conductors.	2025-08-17 20:27:11.116863
1268	Physics	SSCE	\N	What is the image formed by a convex mirror?	["Real and inverted", "Virtual and upright", "Real and upright", "Virtual and inverted"]	1	A convex mirror always forms a virtual, upright, and diminished image.	2025-08-17 20:27:11.116863
1269	Physics	SSCE	\N	What is the SI unit of heat energy?	["Watt", "Joule", "Kelvin", "Pascal"]	1	The SI unit of heat energy is the Joule.	2025-08-17 20:27:11.116863
1270	Physics	SSCE	\N	What is the velocity of an object that travels 100 m in 20 s?	["5 m/s", "2 m/s", "10 m/s", "20 m/s"]	0	Velocity = Distance / Time = 100 m / 20 s = 5 m/s.	2025-08-17 20:27:11.116863
1271	Physics	SSCE	\N	Which of the following is a form of renewable energy?	["Coal", "Wind energy", "Petroleum", "Natural gas"]	1	Wind energy is renewable as it is derived from natural wind processes.	2025-08-17 20:27:11.116863
1272	Physics	SSCE	\N	What is the law of conservation of energy?	["Energy can be created", "Energy can be destroyed", "Energy is neither created nor destroyed", "Energy is always lost"]	2	The law states that energy is neither created nor destroyed, only transformed.	2025-08-17 20:27:11.116863
1273	Physics	SSCE	\N	What is the unit of electric charge?	["Ampere", "Coulomb", "Volt", "Ohm"]	1	The SI unit of electric charge is the Coulomb.	2025-08-17 20:27:11.116863
1274	Physics	SSCE	\N	Which type of wave requires a medium to propagate?	["Electromagnetic wave", "Transverse wave", "Sound wave", "Radio wave"]	2	Sound waves are mechanical waves that require a medium to propagate.	2025-08-17 20:27:11.116863
1275	Physics	SSCE	\N	What is the power rating of an appliance that uses 1200 J in 4 s?	["300 W", "4800 W", "400 W", "200 W"]	0	Power = Energy / Time = 1200 J / 4 s = 300 W.	2025-08-17 20:27:11.116863
1276	Physics	SSCE	\N	What is the specific latent heat of fusion?	["Heat required to change a solid to liquid", "Heat required to change a liquid to gas", "Heat required to raise temperature", "Heat required to expand a solid"]	0	Specific latent heat of fusion is the heat required to change a solid to a liquid without a temperature change.	2025-08-17 20:27:11.116863
1277	Physics	SSCE	\N	Which of the following is an example of a longitudinal wave?	["Light wave", "Water wave", "Sound wave", "Radio wave"]	2	Sound waves are longitudinal waves with compressions and rarefactions.	2025-08-17 20:27:11.116863
1278	Physics	SSCE	\N	What is the weight of a 5 kg object on Earth?	["50 N", "5 N", "49 N", "10 N"]	0	Weight = mass × g = 5 kg × 9.8 m/s² ≈ 49 N, rounded to 50 N for simplicity.	2025-08-17 20:27:11.116863
1279	Physics	SSCE	\N	Which device converts mechanical energy to electrical energy?	["Motor", "Generator", "Transformer", "Capacitor"]	1	A generator converts mechanical energy to electrical energy.	2025-08-17 20:27:11.116863
1280	Physics	SSCE	\N	What is the refractive index of a medium if the speed of light in air is 3 × 10⁸ m/s and in the medium is 2 × 10⁸ m/s?	["1.5", "2.0", "1.0", "0.67"]	0	Refractive index = Speed of light in vacuum / Speed in medium = 3 × 10⁸ / 2 × 10⁸ = 1.5.	2025-08-17 20:27:11.116863
1281	Physics	SSCE	\N	Which of the following is a derived unit?	["Metre", "Kilogram", "Newton", "Second"]	2	Newton is a derived unit (kg·m/s²), while metre, kilogram, and second are base units.	2025-08-17 20:27:11.116863
1282	Physics	SSCE	\N	What is the frequency of a pendulum with a period of 0.4 s?	["2.5 Hz", "0.4 Hz", "4 Hz", "1 Hz"]	0	Frequency = 1 / Period = 1 / 0.4 s = 2.5 Hz.	2025-08-17 20:27:11.116863
1283	Physics	SSCE	\N	Which of the following is a characteristic of alpha particles?	["High penetration", "No charge", "High ionizing power", "Travel at speed of light"]	2	Alpha particles have high ionizing power due to their large mass and charge.	2025-08-17 20:27:11.116863
1284	Physics	SSCE	\N	What is the unit of electrical resistance?	["Ampere", "Volt", "Ohm", "Watt"]	2	The SI unit of electrical resistance is the Ohm.	2025-08-17 20:27:11.116863
1285	Physics	SSCE	\N	What is the potential energy of a 2 kg object raised 5 m above the ground (g = 10 m/s²)?	["100 J", "50 J", "20 J", "10 J"]	0	Potential energy = mgh = 2 kg × 10 m/s² × 5 m = 100 J.	2025-08-17 20:27:11.116863
1286	Physics	SSCE	\N	Which of the following is a property of electromagnetic waves?	["Require a medium", "Travel at speed of sound", "Travel at speed of light", "Longitudinal waves"]	2	Electromagnetic waves travel at the speed of light in a vacuum.	2025-08-17 20:27:11.116863
1287	Physics	SSCE	\N	What is the work done by a force if an object moves 0 m?	["0 J", "10 J", "100 J", "50 J"]	0	Work done = Force × Distance. If distance is 0 m, work done is 0 J.	2025-08-17 20:27:11.116863
1288	Physics	SSCE	\N	Which instrument measures electric potential difference?	["Ammeter", "Voltmeter", "Galvanometer", "Barometer"]	1	A voltmeter measures the electric potential difference between two points.	2025-08-17 20:27:11.116863
1289	Physics	SSCE	\N	What is the total resistance of two 6 Ω resistors connected in parallel?	["12 Ω", "3 Ω", "6 Ω", "2 Ω"]	1	For parallel resistors, 1/R = 1/R₁ + 1/R₂ = 1/6 + 1/6 = 2/6, so R = 3 Ω.	2025-08-17 20:27:11.116863
1290	Physics	SSCE	\N	What is the primary source of energy for Earth’s climate system?	["Wind", "Sun", "Geothermal", "Tides"]	1	The Sun is the primary source of energy for Earth’s climate system.	2025-08-17 20:27:11.116863
1291	Physics	SSCE	\N	What is the SI unit of frequency?	["Watt", "Hertz", "Joule", "Newton"]	1	The SI unit of frequency is the Hertz (Hz).	2025-08-17 20:27:11.116863
1292	Physics	SSCE	\N	Which of the following is a type of friction?	["Static friction", "Magnetic friction", "Electric friction", "Thermal friction"]	0	Static friction is a type of friction that opposes the start of motion.	2025-08-17 20:27:11.116863
1293	Physics	SSCE	\N	What is the speed of sound in air at standard conditions?	["343 m/s", "300 m/s", "400 m/s", "500 m/s"]	0	The speed of sound in air at standard conditions (20°C) is approximately 343 m/s.	2025-08-17 20:27:11.116863
1294	Physics	SSCE	\N	Which of the following is a characteristic of beta particles?	["High mass", "No charge", "High penetration", "Low ionizing power"]	2	Beta particles have high penetration compared to alpha particles.	2025-08-17 20:27:11.116863
1295	Physics	SSCE	\N	What is the unit of work?	["Newton", "Joule", "Watt", "Pascal"]	1	The SI unit of work is the Joule.	2025-08-17 20:27:11.116863
1296	Physics	SSCE	\N	What is the image distance for an object placed 10 cm in front of a concave mirror with a focal length of 5 cm?	["10 cm", "3.33 cm", "7.5 cm", "15 cm"]	0	Using the mirror formula, 1/f = 1/u + 1/v, 1/5 = 1/10 + 1/v, 1/v = 1/5 - 1/10 = 1/10, so v = 10 cm.	2025-08-17 20:27:11.116863
1329	Physics	SSCE	\N	What is the unit of electromotive force (EMF)?	["Ampere", "Volt", "Ohm", "Watt"]	1	The SI unit of electromotive force is the Volt.	2025-08-17 20:27:11.116863
1297	Physics	SSCE	\N	Which of the following is a method of heat transfer?	["Conduction", "Friction", "Diffraction", "Polarization"]	0	Conduction is a method of heat transfer through a medium without movement of the medium.	2025-08-17 20:27:11.116863
1298	Physics	SSCE	\N	What is the momentum of a stationary object?	["Zero", "Infinite", "Constant", "Negative"]	0	Momentum = mass × velocity. If velocity is zero, momentum is zero.	2025-08-17 20:27:11.116863
1299	Physics	SSCE	\N	Which device stores electrical energy in an electric field?	["Resistor", "Capacitor", "Inductor", "Diode"]	1	A capacitor stores electrical energy in an electric field.	2025-08-17 20:27:11.116863
1300	Physics	SSCE	\N	What is the wavelength of a wave with a speed of 340 m/s and a frequency of 680 Hz?	["0.5 m", "1 m", "2 m", "0.25 m"]	0	Wavelength = Speed / Frequency = 340 m/s / 680 Hz = 0.5 m.	2025-08-17 20:27:11.116863
1301	Physics	SSCE	\N	Which of the following is a unit of density?	["kg/m²", "kg/m³", "g/cm²", "kg/cm"]	1	The SI unit of density is kg/m³.	2025-08-17 20:27:11.116863
1302	Physics	SSCE	\N	What is the principle of conservation of momentum?	["Momentum is always zero", "Total momentum remains constant in an isolated system", "Momentum increases with time", "Momentum is destroyed in collisions"]	1	The total momentum of an isolated system remains constant if no external forces act.	2025-08-17 20:27:11.116863
1303	Physics	SSCE	\N	Which of the following is a characteristic of gamma rays?	["High mass", "High charge", "High penetration", "Low energy"]	2	Gamma rays have high penetration due to their electromagnetic nature.	2025-08-17 20:27:11.116863
1304	Physics	SSCE	\N	What is the SI unit of temperature?	["Celsius", "Kelvin", "Fahrenheit", "Joule"]	1	The SI unit of temperature is the Kelvin.	2025-08-17 20:27:11.116863
1305	Physics	SSCE	\N	What is the total resistance of two 4 Ω resistors connected in series?	["2 Ω", "8 Ω", "4 Ω", "1 Ω"]	1	For resistors in series, R = R₁ + R₂ = 4 Ω + 4 Ω = 8 Ω.	2025-08-17 20:27:11.116863
1306	Physics	SSCE	\N	Which of the following is a source of light?	["Moon", "Sun", "Mirror", "Glass"]	1	The Sun is a natural source of light, unlike the Moon, which reflects light.	2025-08-17 20:27:11.116863
1307	Physics	SSCE	\N	What is the acceleration of a 10 kg object when a force of 50 N is applied?	["5 m/s²", "10 m/s²", "2 m/s²", "50 m/s²"]	0	Using Newton’s Second Law, a = F/m = 50 N / 10 kg = 5 m/s².	2025-08-17 20:27:11.116863
1308	Physics	SSCE	\N	Which type of mirror is used in car headlights?	["Plane mirror", "Concave mirror", "Convex mirror", "Flat mirror"]	1	Concave mirrors are used in car headlights to produce a parallel beam of light.	2025-08-17 20:27:11.116863
1309	Physics	SSCE	\N	What is the SI unit of magnetic field strength?	["Weber", "Tesla", "Ampere", "Henry"]	1	The SI unit of magnetic field strength is the Tesla.	2025-08-17 20:27:11.116863
1310	Physics	SSCE	\N	What is the specific heat capacity of water?	["4200 J/kg·K", "2100 J/kg·K", "1000 J/kg·K", "8400 J/kg·K"]	0	The specific heat capacity of water is approximately 4200 J/kg·K.	2025-08-17 20:27:11.116863
1311	Physics	SSCE	\N	Which of the following is a non-renewable source of energy?	["Solar energy", "Wind energy", "Coal", "Hydropower"]	2	Coal is a non-renewable source of energy as it is finite.	2025-08-17 20:27:11.116863
1312	Physics	SSCE	\N	What is the angle of reflection if the angle of incidence is 30°?	["60°", "30°", "45°", "90°"]	1	The law of reflection states that the angle of incidence equals the angle of reflection, so it is 30°.	2025-08-17 20:27:11.116863
1313	Physics	SSCE	\N	Which device converts electrical energy to mechanical energy?	["Generator", "Motor", "Transformer", "Capacitor"]	1	A motor converts electrical energy to mechanical energy.	2025-08-17 20:27:11.116863
1314	Physics	SSCE	\N	What is the unit of impulse?	["N·s", "J", "W", "N/m"]	0	Impulse = Force × Time, so its unit is N·s.	2025-08-17 20:27:11.116863
1315	Physics	SSCE	\N	What is the frequency of a wave with a wavelength of 0.2 m traveling at 340 m/s?	["1700 Hz", "68 Hz", "340 Hz", "0.2 Hz"]	0	Frequency = Speed / Wavelength = 340 m/s / 0.2 m = 1700 Hz.	2025-08-17 20:27:11.116863
1316	Physics	SSCE	\N	Which of the following is a fundamental quantity?	["Force", "Mass", "Energy", "Power"]	1	Mass is a fundamental quantity, while force, energy, and power are derived.	2025-08-17 20:27:11.116863
1317	Physics	SSCE	\N	What is the effect of increasing temperature on the resistance of a conductor?	["Decreases", "Increases", "Remains constant", "Becomes zero"]	1	For most conductors, resistance increases with temperature due to increased atomic vibrations.	2025-08-17 20:27:11.116863
1318	Physics	SSCE	\N	Which type of radiation is deflected by a magnetic field?	["Gamma rays", "Alpha particles", "X-rays", "Neutrons"]	1	Alpha particles are charged and thus deflected by a magnetic field.	2025-08-17 20:27:11.116863
1319	Physics	SSCE	\N	What is the unit of moment of force?	["N·m", "J", "W", "N/m"]	0	Moment of force (torque) is measured in Newton-metres (N·m).	2025-08-17 20:27:11.116863
1320	Physics	SSCE	\N	What is the critical angle for a medium with a refractive index of 1.5?	["41.8°", "30°", "60°", "90°"]	0	Critical angle = arcsin(1/n) = arcsin(1/1.5) = arcsin(0.667) ≈ 41.8°.	2025-08-17 20:27:11.116863
1321	Physics	SSCE	\N	Which of the following is a property of a convex lens?	["Diverges light", "Forms only virtual images", "Converges light", "Produces only diminished images"]	2	A convex lens converges light to a focal point.	2025-08-17 20:27:11.116863
1322	Physics	SSCE	\N	What is the energy stored in a spring with a spring constant of 200 N/m stretched by 0.1 m?	["1 J", "2 J", "0.5 J", "4 J"]	0	Elastic potential energy = ½ kx² = ½ × 200 N/m × (0.1 m)² = 1 J.	2025-08-17 20:27:11.116863
1323	Physics	SSCE	\N	Which of the following is a unit of acceleration?	["m/s", "m/s²", "m²/s", "m²/s²"]	1	The SI unit of acceleration is m/s².	2025-08-17 20:27:11.116863
1324	Physics	SSCE	\N	What is the half-life of a radioactive substance if 25% of it remains after 12 days?	["6 days", "12 days", "3 days", "24 days"]	0	25% remaining means two half-lives (0.5² = 0.25). Total time = 12 days, so half-life = 12 / 2 = 6 days.	2025-08-17 20:27:11.116863
1325	Physics	SSCE	\N	Which of the following is a characteristic of a parallel circuit?	["Same current in all branches", "Same voltage across all branches", "Total resistance increases", "Current stops if one branch breaks"]	1	In a parallel circuit, the voltage across each branch is the same.	2025-08-17 20:27:11.116863
1326	Physics	SSCE	\N	What is the SI unit of luminous intensity?	["Lux", "Candela", "Lumen", "Watt"]	1	The SI unit of luminous intensity is the Candela.	2025-08-17 20:27:11.116863
1327	Physics	SSCE	\N	What is the pressure exerted by a 200 N force over an area of 2 m²?	["100 Pa", "400 Pa", "50 Pa", "200 Pa"]	0	Pressure = Force / Area = 200 N / 2 m² = 100 Pa.	2025-08-17 20:27:11.116863
1328	Physics	SSCE	\N	Which of the following is a renewable energy source?	["Nuclear energy", "Hydropower", "Coal", "Petroleum"]	1	Hydropower is a renewable energy source derived from water flow.	2025-08-17 20:27:11.116863
1330	Physics	SSCE	\N	What is the focal length of a lens with a power of 2 dioptres?	["0.5 m", "2 m", "1 m", "0.25 m"]	0	Focal length = 1 / Power = 1 / 2 dioptres = 0.5 m.	2025-08-17 20:27:11.116863
1331	Civic Education	SSCE	\N	What is the primary duty of a citizen to their country?	["Paying taxes", "Voting in elections", "Obeying laws", "Joining the military"]	2	Obeying laws is a primary duty of a citizen to maintain order and uphold the rule of law.	2025-08-17 20:27:11.116863
1332	Civic Education	SSCE	\N	Which arm of government is responsible for making laws?	["Executive", "Legislature", "Judiciary", "Bureaucracy"]	1	The legislature is responsible for making laws in a democratic system.	2025-08-17 20:27:11.116863
1333	Civic Education	SSCE	\N	What does the term 'rule of law' mean?	["Laws made by the president", "Supremacy of the law over all individuals", "Laws enforced by the military", "Laws created by traditional rulers"]	1	Rule of law means that everyone is subject to the law, regardless of status.	2025-08-17 20:27:11.116863
1334	Civic Education	SSCE	\N	Which document guarantees the fundamental human rights of citizens in Nigeria?	["Constitution", "Electoral Act", "Criminal Code", "Land Use Act"]	0	The Nigerian Constitution outlines and guarantees fundamental human rights.	2025-08-17 20:27:11.116863
1335	Civic Education	SSCE	\N	What is the main purpose of democracy?	["To favor the elite", "To ensure majority rule and minority rights", "To limit citizens' freedom", "To promote military rule"]	1	Democracy aims to ensure majority rule while protecting minority rights.	2025-08-17 20:27:11.116863
1336	Civic Education	SSCE	\N	Which of the following is a characteristic of a good citizen?	["Disobeying laws", "Participating in community development", "Evading taxes", "Promoting violence"]	1	A good citizen participates in community development to promote societal progress.	2025-08-17 20:27:11.116863
1337	Civic Education	SSCE	\N	What is the role of the Independent National Electoral Commission (INEC) in Nigeria?	["Making laws", "Conducting elections", "Interpreting laws", "Enforcing laws"]	1	INEC is responsible for organizing and conducting elections in Nigeria.	2025-08-17 20:27:11.116863
1338	Civic Education	SSCE	\N	Which of the following is a fundamental human right?	["Right to free education", "Right to life", "Right to wealth", "Right to employment"]	1	The right to life is a fundamental human right protected by the Constitution.	2025-08-17 20:27:11.116863
1339	Civic Education	SSCE	\N	What is meant by 'separation of powers' in a democracy?	["Combining all government functions", "Dividing government functions among different arms", "Giving all powers to the president", "Allowing citizens to control the government"]	1	Separation of powers divides government functions among the legislature, executive, and judiciary.	2025-08-17 20:27:11.116863
1340	Civic Education	SSCE	\N	Which of the following promotes national unity in Nigeria?	["Tribalism", "Federal Character Principle", "Nepotism", "Corruption"]	1	The Federal Character Principle ensures fair representation of all regions, promoting unity.	2025-08-17 20:27:11.116863
1341	Civic Education	SSCE	\N	What is the meaning of 'citizenship'?	["Membership of a political party", "Legal membership of a state or nation", "Ownership of property", "Participation in elections"]	1	Citizenship refers to the legal membership of a person in a state or nation.	2025-08-17 20:27:11.116863
1342	Civic Education	SSCE	\N	Which of the following is a civic responsibility of citizens?	["Vandalizing public property", "Paying taxes promptly", "Promoting discrimination", "Ignoring laws"]	1	Paying taxes promptly is a civic responsibility to support government functions.	2025-08-17 20:27:11.116863
1343	Civic Education	SSCE	\N	What is the primary function of the judiciary?	["Making laws", "Executing laws", "Interpreting laws", "Amending laws"]	2	The judiciary interprets laws and ensures justice is administered.	2025-08-17 20:27:11.116863
1344	Civic Education	SSCE	\N	Which of the following is a type of democracy?	["Monarchy", "Representative democracy", "Oligarchy", "Dictatorship"]	1	Representative democracy involves electing representatives to make decisions.	2025-08-17 20:27:11.116863
1345	Civic Education	SSCE	\N	What does the term 'sovereignty' refer to in a nation?	["Dependence on other nations", "Supreme authority within a territory", "Economic instability", "Military control"]	1	Sovereignty refers to the supreme authority of a nation within its territory.	2025-08-17 20:27:11.116863
1346	Civic Education	SSCE	\N	Which agency in Nigeria is responsible for combating corruption?	["Nigerian Police Force", "Economic and Financial Crimes Commission (EFCC)", "National Assembly", "Federal Ministry of Justice"]	1	The EFCC is tasked with investigating and prosecuting financial crimes and corruption.	2025-08-17 20:27:11.116863
1347	Civic Education	SSCE	\N	What is the minimum voting age in Nigeria?	["16", "18", "21", "25"]	1	The minimum voting age in Nigeria is 18, as stipulated by the Constitution.	2025-08-17 20:27:11.116863
1348	Civic Education	SSCE	\N	Which of the following is a feature of a federal system of government?	["Centralized power", "Division of powers between central and regional governments", "Single-party rule", "Military dominance"]	1	A federal system divides powers between central and regional governments.	2025-08-17 20:27:11.116863
1349	Civic Education	SSCE	\N	What is the significance of the Nigerian national anthem?	["Promoting tribalism", "Fostering national unity and patriotism", "Encouraging corruption", "Limiting freedom"]	1	The national anthem fosters unity and patriotism among Nigerians.	2025-08-17 20:27:11.116863
1350	Civic Education	SSCE	\N	Which right allows citizens to express their opinions freely?	["Right to education", "Right to freedom of expression", "Right to property", "Right to health"]	1	The right to freedom of expression allows citizens to voice their opinions.	2025-08-17 20:27:11.116863
1351	Civic Education	SSCE	\N	What is the role of the executive arm of government?	["Making laws", "Interpreting laws", "Implementing laws", "Amending laws"]	2	The executive implements and enforces laws made by the legislature.	2025-08-17 20:27:11.116863
1352	Civic Education	SSCE	\N	Which of the following is a civic value?	["Corruption", "Honesty", "Fraud", "Nepotism"]	1	Honesty is a civic value that promotes trust and integrity in society.	2025-08-17 20:27:11.116863
1353	Civic Education	SSCE	\N	What is the purpose of the Universal Declaration of Human Rights?	["To promote war", "To protect fundamental human rights globally", "To limit freedom", "To enforce taxes"]	1	The Universal Declaration of Human Rights aims to protect human rights globally.	2025-08-17 20:27:11.116863
1354	Civic Education	SSCE	\N	Which body is responsible for conducting local government elections in Nigeria?	["INEC", "SIEC", "EFCC", "NJC"]	1	State Independent Electoral Commissions (SIEC) conduct local government elections.	2025-08-17 20:27:11.116863
1355	Civic Education	SSCE	\N	What is meant by 'checks and balances' in government?	["Combining powers of government arms", "Ensuring each arm of government limits the powers of others", "Giving all powers to one arm", "Ignoring the judiciary"]	1	Checks and balances ensure each arm of government limits the powers of others.	2025-08-17 20:27:11.116863
1356	Civic Education	SSCE	\N	Which of the following is a consequence of corruption?	["Economic growth", "Underdevelopment", "Improved infrastructure", "Social equality"]	1	Corruption leads to underdevelopment by misallocating resources.	2025-08-17 20:27:11.116863
1357	Civic Education	SSCE	\N	What is the tenure of a Nigerian president?	["2 years", "4 years", "5 years", "6 years"]	1	The Nigerian Constitution stipulates a 4-year tenure for the president.	2025-08-17 20:27:11.116863
1358	Civic Education	SSCE	\N	Which of the following is a way to acquire Nigerian citizenship?	["By education", "By birth", "By employment", "By marriage only"]	1	Citizenship by birth is a primary way to acquire Nigerian citizenship.	2025-08-17 20:27:11.116863
1359	Civic Education	SSCE	\N	What is the main function of political parties?	["To enforce laws", "To contest elections and form government", "To interpret laws", "To collect taxes"]	1	Political parties contest elections to form government and represent citizens.	2025-08-17 20:27:11.116863
1360	Civic Education	SSCE	\N	Which of the following is a pillar of democracy?	["Corruption", "Free and fair elections", "Dictatorship", "Nepotism"]	1	Free and fair elections are a key pillar of democracy.	2025-08-17 20:27:11.116863
1361	Civic Education	SSCE	\N	What is the meaning of 'civil society'?	["Government officials", "Non-governmental organizations and citizens", "Military personnel", "Traditional rulers"]	1	Civil society includes NGOs and citizens working for societal good outside government.	2025-08-17 20:27:11.116863
1362	Civic Education	SSCE	\N	Which right protects citizens from unlawful arrest?	["Right to education", "Right to freedom of movement", "Right to personal liberty", "Right to property"]	2	The right to personal liberty protects against unlawful arrest.	2025-08-17 20:27:11.116863
1363	Civic Education	SSCE	\N	What is the role of the press in a democracy?	["To make laws", "To inform and educate the public", "To enforce laws", "To conduct elections"]	1	The press informs and educates the public, promoting transparency.	2025-08-17 20:27:11.116863
1364	Civic Education	SSCE	\N	Which of the following is an example of a civic obligation?	["Vandalizing public property", "Participating in community service", "Promoting discrimination", "Evading taxes"]	1	Participating in community service is a civic obligation to contribute to society.	2025-08-17 20:27:11.116863
1365	Civic Education	SSCE	\N	What is the supreme law of Nigeria?	["Electoral Act", "Constitution", "Criminal Code", "Local Government Act"]	1	The Constitution is the supreme law of Nigeria.	2025-08-17 20:27:11.116863
1366	Civic Education	SSCE	\N	Which of the following promotes peaceful coexistence?	["Tolerance", "Discrimination", "Tribalism", "Corruption"]	0	Tolerance promotes understanding and peaceful coexistence among people.	2025-08-17 20:27:11.116863
1367	Civic Education	SSCE	\N	What is the role of the National Assembly in Nigeria?	["Enforcing laws", "Making laws", "Interpreting laws", "Conducting elections"]	1	The National Assembly is responsible for making laws in Nigeria.	2025-08-17 20:27:11.116863
1368	Civic Education	SSCE	\N	Which of the following is a negative societal value?	["Integrity", "Corruption", "Honesty", "Respect"]	1	Corruption is a negative societal value that undermines progress.	2025-08-17 20:27:11.116863
1369	Civic Education	SSCE	\N	What is meant by 'franchise' in a democratic system?	["Right to own property", "Right to vote", "Right to education", "Right to free speech"]	1	Franchise refers to the right to vote in elections.	2025-08-17 20:27:11.116863
1370	Civic Education	SSCE	\N	Which agency in Nigeria protects human rights?	["Nigerian Police Force", "National Human Rights Commission (NHRC)", "Economic and Financial Crimes Commission", "Independent National Electoral Commission"]	1	The NHRC is responsible for protecting and promoting human rights in Nigeria.	2025-08-17 20:27:11.116863
1371	Civic Education	SSCE	\N	What is the purpose of the NYSC in Nigeria?	["To promote tribalism", "To foster national unity and integration", "To enforce laws", "To collect taxes"]	1	The NYSC fosters national unity by deploying youths to different regions.	2025-08-17 20:27:11.116863
1372	Civic Education	SSCE	\N	Which of the following is a form of government?	["Capitalism", "Federalism", "Socialism", "Communism"]	1	Federalism is a form of government that divides power between central and regional authorities.	2025-08-17 20:27:11.116863
1373	Civic Education	SSCE	\N	What is the meaning of 'due process'?	["Ignoring legal procedures", "Following legal procedures in governance", "Promoting corruption", "Limiting citizens' rights"]	1	Due process refers to following established legal procedures.	2025-08-17 20:27:11.116863
1374	Civic Education	SSCE	\N	Which of the following is a responsibility of the media?	["Making laws", "Promoting accountability and transparency", "Enforcing laws", "Conducting elections"]	1	The media promotes accountability and transparency in governance.	2025-08-17 20:27:11.116863
1375	Civic Education	SSCE	\N	What is the role of the Code of Conduct Bureau in Nigeria?	["To conduct elections", "To monitor public officers' conduct", "To interpret laws", "To enforce taxes"]	1	The Code of Conduct Bureau monitors the conduct of public officers to prevent corruption.	2025-08-17 20:27:11.116863
1376	Civic Education	SSCE	\N	Which of the following is a right of Nigerian citizens?	["Right to free housing", "Right to freedom of religion", "Right to free transport", "Right to employment"]	1	The right to freedom of religion is guaranteed by the Nigerian Constitution.	2025-08-17 20:27:11.116863
1377	Civic Education	SSCE	\N	What is the main objective of the rule of law?	["To favor the elite", "To ensure equality before the law", "To promote corruption", "To limit citizens' rights"]	1	The rule of law ensures equality before the law for all citizens.	2025-08-17 20:27:11.116863
1378	Civic Education	SSCE	\N	Which of the following is a feature of a unitary system of government?	["Division of powers", "Centralized authority", "Independent states", "Dual citizenship"]	1	A unitary system concentrates authority in the central government.	2025-08-17 20:27:11.116863
1379	Civic Education	SSCE	\N	What is the significance of the Nigerian flag?	["Promoting tribalism", "Symbolizing national unity and identity", "Encouraging corruption", "Limiting freedom"]	1	The Nigerian flag symbolizes national unity and identity.	2025-08-17 20:27:11.116863
1380	Civic Education	SSCE	\N	Which of the following is a democratic principle?	["Supremacy of the military", "Majority rule with minority rights", "Single-party dominance", "Restriction of freedoms"]	1	Majority rule with minority rights is a key democratic principle.	2025-08-17 20:27:11.116863
1381	Civic Education	SSCE	\N	What is the role of the Nigerian Police Force?	["Making laws", "Maintaining law and order", "Conducting elections", "Interpreting laws"]	1	The Nigerian Police Force maintains law and order in society.	2025-08-17 20:27:11.116863
1382	Civic Education	SSCE	\N	Which of the following is a negative effect of cultism in schools?	["Promoting academic excellence", "Causing violence and insecurity", "Enhancing unity", "Improving discipline"]	1	Cultism causes violence and insecurity in schools.	2025-08-17 20:27:11.116863
1383	Civic Education	SSCE	\N	What is the purpose of voter registration?	["To collect taxes", "To identify eligible voters", "To limit citizens' rights", "To promote corruption"]	1	Voter registration identifies eligible voters for elections.	2025-08-17 20:27:11.116863
1384	Civic Education	SSCE	\N	Which of the following is a characteristic of good governance?	["Corruption", "Transparency", "Nepotism", "Dictatorship"]	1	Transparency is a hallmark of good governance.	2025-08-17 20:27:11.116863
1385	Civic Education	SSCE	\N	What is the meaning of 'political apathy'?	["Active participation in politics", "Lack of interest in political activities", "Promoting elections", "Supporting corruption"]	1	Political apathy refers to a lack of interest in political activities.	2025-08-17 20:27:11.116863
1386	Civic Education	SSCE	\N	Which of the following is a function of the judiciary?	["Making laws", "Implementing policies", "Settling disputes", "Conducting elections"]	2	The judiciary settles disputes and interprets laws.	2025-08-17 20:27:11.116863
1387	Civic Education	SSCE	\N	What is the role of the Ombudsman in Nigeria?	["To conduct elections", "To investigate complaints against public officials", "To make laws", "To enforce taxes"]	1	The Ombudsman investigates complaints against public officials.	2025-08-17 20:27:11.116863
1388	Civic Education	SSCE	\N	Which of the following is a way to prevent human trafficking?	["Promoting poverty", "Creating awareness and education", "Encouraging corruption", "Limiting laws"]	1	Creating awareness and education helps prevent human trafficking.	2025-08-17 20:27:11.116863
1389	Civic Education	SSCE	\N	What is the purpose of the Nigerian Constitution?	["To promote tribalism", "To guide governance and protect rights", "To limit citizens' freedoms", "To encourage corruption"]	1	The Constitution guides governance and protects citizens' rights.	2025-08-17 20:27:11.116863
1390	Civic Education	SSCE	\N	Which of the following is a civic virtue?	["Dishonesty", "Patriotism", "Corruption", "Nepotism"]	1	Patriotism is a civic virtue that shows love for one's country.	2025-08-17 20:27:11.116863
1391	Civic Education	SSCE	\N	What is the meaning of 'equality before the law'?	["Favoring the elite", "Equal treatment of all under the law", "Discriminating against minorities", "Limiting rights"]	1	Equality before the law means all individuals are treated equally by the legal system.	2025-08-17 20:27:11.116863
1392	Civic Education	SSCE	\N	Which of the following is a function of civil society organizations?	["Making laws", "Advocating for citizens' rights", "Enforcing laws", "Conducting elections"]	1	Civil society organizations advocate for citizens' rights and welfare.	2025-08-17 20:27:11.116863
1393	Civic Education	SSCE	\N	What is the role of the Nigerian Bar Association?	["To conduct elections", "To promote legal practice and justice", "To enforce taxes", "To make laws"]	1	The Nigerian Bar Association promotes legal practice and justice.	2025-08-17 20:27:11.116863
1394	Civic Education	SSCE	\N	Which of the following is a consequence of drug abuse?	["Improved health", "Social and health problems", "Increased productivity", "Enhanced unity"]	1	Drug abuse leads to social and health problems.	2025-08-17 20:27:11.116863
1395	Civic Education	SSCE	\N	What is the purpose of the Electoral Act in Nigeria?	["To regulate elections", "To enforce taxes", "To make laws", "To limit rights"]	0	The Electoral Act regulates the conduct of elections in Nigeria.	2025-08-17 20:27:11.116863
1396	Civic Education	SSCE	\N	Which of the following is a characteristic of a responsible citizen?	["Evading taxes", "Respecting others' rights", "Promoting violence", "Ignoring laws"]	1	A responsible citizen respects the rights of others.	2025-08-17 20:27:11.116863
1397	Civic Education	SSCE	\N	What is the meaning of 'fundamental human rights'?	["Rights granted by the government", "Inalienable rights inherent to all humans", "Rights limited to the elite", "Rights based on wealth"]	1	Fundamental human rights are inalienable rights inherent to all humans.	2025-08-17 20:27:11.116863
1398	Civic Education	SSCE	\N	Which of the following is a role of the legislature?	["Enforcing laws", "Making laws", "Interpreting laws", "Conducting elections"]	1	The legislature is responsible for making laws.	2025-08-17 20:27:11.116863
1399	Civic Education	SSCE	\N	What is the purpose of the Nigerian coat of arms?	["To promote tribalism", "To symbolize national unity and strength", "To encourage corruption", "To limit freedom"]	1	The coat of arms symbolizes Nigeria's unity and strength.	2025-08-17 20:27:11.116863
1400	Civic Education	SSCE	\N	Which of the following is a way to promote national development?	["Corruption", "Active participation in governance", "Tribalism", "Nepotism"]	1	Active participation in governance promotes national development.	2025-08-17 20:27:11.116863
1401	Civic Education	SSCE	\N	What is the meaning of 'accountability' in governance?	["Avoiding responsibility", "Being answerable for actions", "Promoting corruption", "Limiting transparency"]	1	Accountability means being answerable for actions and decisions.	2025-08-17 20:27:11.116863
1402	Civic Education	SSCE	\N	Which of the following is a function of the executive?	["Making laws", "Implementing policies", "Interpreting laws", "Conducting elections"]	1	The executive implements policies and enforces laws.	2025-08-17 20:27:11.116863
1403	Civic Education	SSCE	\N	What is the role of the Independent Corrupt Practices Commission (ICPC)?	["To conduct elections", "To fight corruption in public offices", "To make laws", "To enforce taxes"]	1	The ICPC fights corruption in public offices.	2025-08-17 20:27:11.116863
1404	Civic Education	SSCE	\N	Which of the following is a civic responsibility?	["Vandalizing public property", "Reporting crimes", "Promoting discrimination", "Evading taxes"]	1	Reporting crimes is a civic responsibility to ensure safety.	2025-08-17 20:27:11.116863
1405	Civic Education	SSCE	\N	What is the meaning of 'patriotism'?	["Disloyalty to one's country", "Love and devotion to one's country", "Promoting corruption", "Ignoring laws"]	1	Patriotism refers to love and devotion to one's country.	2025-08-17 20:27:11.116863
1406	Civic Education	SSCE	\N	Which of the following is a feature of a democratic government?	["Supremacy of the military", "Respect for human rights", "Single-party rule", "Limitation of freedoms"]	1	Respect for human rights is a feature of a democratic government.	2025-08-17 20:27:11.116863
1407	Civic Education	SSCE	\N	What is the purpose of the Nigerian Youth Service Corps (NYSC)?	["To promote tribalism", "To foster national unity and integration", "To enforce laws", "To collect taxes"]	1	The NYSC fosters national unity by deploying youths to different regions.	2025-08-17 20:27:11.116863
1408	Civic Education	SSCE	\N	Which of the following is a consequence of political apathy?	["Increased participation", "Poor governance", "Improved infrastructure", "Social equality"]	1	Political apathy leads to poor governance due to lack of citizen involvement.	2025-08-17 20:27:11.116863
1409	Civic Education	SSCE	\N	What is the role of the National Orientation Agency (NOA)?	["To conduct elections", "To promote national values and awareness", "To enforce taxes", "To make laws"]	1	The NOA promotes national values and awareness among citizens.	2025-08-17 20:27:11.116863
1410	Civic Education	SSCE	\N	Which of the following is a fundamental objective of the Nigerian Constitution?	["Promoting corruption", "Ensuring social justice", "Limiting freedoms", "Encouraging tribalism"]	1	The Constitution aims to ensure social justice for all citizens.	2025-08-17 20:27:11.116863
1411	Civic Education	SSCE	\N	What is the meaning of 'civil liberty'?	["Freedom from government control", "Freedom to break laws", "Freedom to avoid taxes", "Freedom to promote corruption"]	0	Civil liberty refers to freedom from undue government control.	2025-08-17 20:27:11.116863
1412	Civic Education	SSCE	\N	Which of the following is a way to promote democracy?	["Suppressing free speech", "Encouraging civic participation", "Promoting dictatorship", "Limiting elections"]	1	Encouraging civic participation strengthens democracy.	2025-08-17 20:27:11.116863
1413	Civic Education	SSCE	\N	What is the role of the Supreme Court in Nigeria?	["Making laws", "Interpreting the Constitution", "Conducting elections", "Enforcing policies"]	1	The Supreme Court interprets the Constitution and serves as the highest court.	2025-08-17 20:27:11.116863
1414	Civic Education	SSCE	\N	Which of the following is a negative effect of examination malpractice?	["Improved academic standards", "Undermining educational integrity", "Enhanced credibility", "Increased discipline"]	1	Examination malpractice undermines the integrity of education.	2025-08-17 20:27:11.116863
1415	Civic Education	SSCE	\N	What is the purpose of the Public Complaints Commission in Nigeria?	["To conduct elections", "To address citizens' grievances", "To make laws", "To enforce taxes"]	1	The Public Complaints Commission addresses citizens' grievances against public officials.	2025-08-17 20:27:11.116863
1416	Civic Education	SSCE	\N	Which of the following is a positive societal value?	["Corruption", "Integrity", "Nepotism", "Dishonesty"]	1	Integrity is a positive societal value that promotes trust.	2025-08-17 20:27:11.116863
1417	Civic Education	SSCE	\N	What is the meaning of 'electoral process'?	["The process of tax collection", "The process of conducting elections", "The process of law enforcement", "The process of policy implementation"]	1	The electoral process involves the steps for conducting elections.	2025-08-17 20:27:11.116863
1471	English	SSCE	\N	Choose the word that is most nearly opposite in meaning to 'ENORMOUS'.	["Huge", "Tiny", "Large", "Massive"]	1	'Enormous' means very large, so the opposite is 'tiny'.	2025-08-17 20:27:11.116863
1472	English	SSCE	\N	Identify the part of speech of the underlined word in: She *quickly* ran to the store.	["Adjective", "Adverb", "Verb", "Noun"]	1	'Quickly' describes how she ran, making it an adverb.	2025-08-17 20:27:11.116863
1473	English	SSCE	\N	Choose the correct form: Neither of the boys ___ coming to the party.	["is", "are", "were", "have"]	0	'Neither' is singular, so the singular verb 'is' is correct.	2025-08-17 20:27:11.116863
1475	English	SSCE	\N	What is the synonym of 'DILIGENT'?	["Lazy", "Careless", "Hardworking", "Idle"]	2	'Diligent' means hardworking or industrious.	2025-08-17 20:27:11.116863
1477	English	SSCE	\N	Which word has the correct stress pattern for 'EDUCATION'?	["EDUcation", "eduCAtion", "educatION", "EDUcatION"]	1	The stress in 'education' is on the second syllable: eduCAtion.	2025-08-17 20:27:11.116863
1478	English	SSCE	\N	Choose the word that best completes the sentence: The politician's decision was ___ by the public.	["Applauded", "Ignored", "Rejected", "Delayed"]	0	'Applauded' fits positively, implying public approval.	2025-08-17 20:27:11.116863
1479	English	SSCE	\N	Identify the figure of speech in: 'The wind whispered through the trees.'	["Metaphor", "Simile", "Personification", "Hyperbole"]	2	The wind is given human quality (whispering), which is personification.	2025-08-17 20:27:11.116863
1482	English	SSCE	\N	Choose the correct preposition: She is good ___ playing the piano.	["at", "in", "on", "with"]	0	The correct preposition is 'at' in the phrase 'good at playing'.	2025-08-17 20:27:11.116863
1485	English	SSCE	\N	Choose the word with the correct vowel sound in 'CAT'.	["Hate", "Hat", "Height", "Hot"]	1	The vowel sound in 'cat' (/æ/) matches the vowel sound in 'hat'.	2025-08-17 20:27:11.116863
1486	English	SSCE	\N	Choose the word opposite in meaning to 'GENEROUS'.	["Kind", "Selfish", "Giving", "Friendly"]	1	'Generous' means giving freely, so the opposite is 'selfish'.	2025-08-17 20:27:11.116863
1488	English	SSCE	\N	Choose the correct form: They ___ to the market every Saturday.	["go", "goes", "going", "gone"]	0	'They' is plural, so the base verb 'go' is correct.	2025-08-17 20:27:11.116863
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: femblog_user
--

COPY public.posts (id, title, content, author, created_at, updated_at, is_pinned, image, category, likes) FROM stdin;
28	Breaking News: FEMBLOG IS LIVE!	FemBlog is a dynamic and engaging blog site designed to cater to a wide audience interested in news, entertainment, and sports. With its user-friendly interface and visually appealing layout, FemBlog aims to provide fresh, up-to-date content that keeps readers informed and entertained. Whether you are looking for the latest trends, in-depth articles, or thought-provoking discussions, FemBlog is dedicated to offering a platform where diverse topics are explored. Our goal is to create a space for readers to interact with content through comments, podcasts, and videos, making it an inclusive hub for both casual visitors and regular followers.	system	2025-07-08 17:13:39.154968	2025-07-08 17:16:53.013311	f		\N	1
17	testing editing mode	I want to be sure that the previous post is oinned	admin	2025-07-08 16:46:45.584636	2025-07-17 22:26:29.535679	f	\N		1
38	anoteher test	this is to testn post height and other functionality	admin	2025-07-17 22:28:17.352032	2025-07-17 22:28:17.352032	f			0
36	admin image test	this is to test admin image posting capabilities and pinned image	admin	2025-07-14 19:10:20.188939	2025-07-14 19:12:59.962087	t	/Uploads/1752516620088.jpg		5
39	image test again	testing for im,age uploads	admin	2025-07-18 19:47:01.695479	2025-07-18 19:47:01.695479	f			0
41	another test-image uploads	just testing image uploads	admin	2025-07-18 20:05:30.45446	2025-07-18 20:05:30.45446	f	/Uploads/ads/1752865530251.png		0
30	wrapping addition.	testing the wrap responsiveness towards all media sizes	admin	2025-07-08 17:31:56.635555	2025-07-18 20:06:05.424621	f	/Uploads/ads/1752865565250.jpg		4
42	writer image test: 8:06PM	still testing for image uploads	writer	2025-07-18 20:07:08.438776	2025-07-18 20:07:08.438776	f	/Uploads/ads/1752865628273.PNG		1
37	writer image test	tnis is to confirm that writer image post are seen while pinned and that admin can edit image	writer	2025-07-14 19:11:20.726475	2025-07-14 19:12:54.894449	f	/Uploads/1752516680653.jpg		5
40	writer test again	just still testing	writer	2025-07-18 19:49:04.548939	2025-07-18 19:49:04.548939	f			1
29	testing mobile view	will mobile view work or just fixed	admin	2025-07-08 17:26:20.051519	2025-07-08 17:26:20.051519	f		\N	0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, role) FROM stdin;
1	admin	admin123	admin
2	writer	writer123	writer
\.


--
-- Name: ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ads_id_seq', 4, true);


--
-- Name: attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attempts_id_seq', 20, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: femblog_user
--

SELECT pg_catalog.setval('public.comments_id_seq', 5, true);


--
-- Name: femgrind_ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.femgrind_ads_id_seq', 1, true);


--
-- Name: femgrind_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.femgrind_questions_id_seq', 1540, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: femblog_user
--

SELECT pg_catalog.setval('public.posts_id_seq', 42, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: ads ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (id);


--
-- Name: attempts attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: femblog_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: femgrind_ads femgrind_ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femgrind_ads
    ADD CONSTRAINT femgrind_ads_pkey PRIMARY KEY (id);


--
-- Name: femgrind_questions femgrind_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femgrind_questions
    ADD CONSTRAINT femgrind_questions_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: femblog_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: femgrind_questions unique_question; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.femgrind_questions
    ADD CONSTRAINT unique_question UNIQUE (subject, question);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: femblog_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT CREATE ON SCHEMA public TO femblog_user;


--
-- Name: TABLE ads; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ads TO femblog_user;


--
-- Name: SEQUENCE ads_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ads_id_seq TO femblog_user;


--
-- Name: TABLE attempts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.attempts TO femblog_user;


--
-- Name: SEQUENCE attempts_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.attempts_id_seq TO femblog_user;


--
-- Name: TABLE femgrind_ads; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.femgrind_ads TO femblog_user;


--
-- Name: SEQUENCE femgrind_ads_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.femgrind_ads_id_seq TO femblog_user;


--
-- Name: TABLE femgrind_questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.femgrind_questions TO femblog_user;


--
-- Name: SEQUENCE femgrind_questions_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.femgrind_questions_id_seq TO femblog_user;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO femblog_user;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_id_seq TO femblog_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO femblog_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO femblog_user;


--
-- PostgreSQL database dump complete
--

