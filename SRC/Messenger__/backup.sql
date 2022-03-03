--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: account_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    phone_number character varying(12),
    birthday date,
    gender_type character varying(1),
    country_type character varying(2),
    slug character varying(100),
    email_user character varying(150)
);


ALTER TABLE public.account_user OWNER TO postgres;

--
-- Name: account_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.account_user_groups OWNER TO postgres;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_groups_id_seq OWNER TO postgres;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_groups_id_seq OWNED BY public.account_user_groups.id;


--
-- Name: account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_id_seq OWNER TO postgres;

--
-- Name: account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_id_seq OWNED BY public.account_user.id;


--
-- Name: account_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.account_user_user_permissions OWNER TO postgres;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_user_permissions_id_seq OWNED BY public.account_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: web_page_email; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email (
    id bigint NOT NULL,
    subject character varying(100),
    text text,
    file character varying(100),
    created timestamp with time zone NOT NULL,
    edited timestamp with time zone NOT NULL,
    is_sent boolean NOT NULL,
    is_inbox boolean NOT NULL,
    is_starred boolean NOT NULL,
    is_draft boolean NOT NULL,
    is_trash boolean NOT NULL,
    is_read boolean NOT NULL,
    sign_id bigint,
    slug character varying(20),
    sender_id bigint
);


ALTER TABLE public.web_page_email OWNER TO postgres;

--
-- Name: web_page_email_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_id_seq OWNER TO postgres;

--
-- Name: web_page_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_id_seq OWNED BY public.web_page_email.id;


--
-- Name: web_page_email_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_label (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    label_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_label OWNER TO postgres;

--
-- Name: web_page_email_label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_label_id_seq OWNER TO postgres;

--
-- Name: web_page_email_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_label_id_seq OWNED BY public.web_page_email_label.id;


--
-- Name: web_page_email_receiver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_receiver (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    profilecontact_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_receiver OWNER TO postgres;

--
-- Name: web_page_email_receiver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_receiver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_receiver_id_seq OWNER TO postgres;

--
-- Name: web_page_email_receiver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_receiver_id_seq OWNED BY public.web_page_email_receiver.id;


--
-- Name: web_page_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_label (
    id bigint NOT NULL,
    title character varying(20) NOT NULL,
    slug character varying(20)
);


ALTER TABLE public.web_page_label OWNER TO postgres;

--
-- Name: web_page_label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_label_id_seq OWNER TO postgres;

--
-- Name: web_page_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_label_id_seq OWNED BY public.web_page_label.id;


--
-- Name: web_page_profilecontact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_profilecontact (
    id bigint NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    profile_photo character varying(100),
    phone_number character varying(11),
    birthday date,
    slug character varying(20)
);


ALTER TABLE public.web_page_profilecontact OWNER TO postgres;

--
-- Name: web_page_profilecontact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_profilecontact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_profilecontact_id_seq OWNER TO postgres;

--
-- Name: web_page_profilecontact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_profilecontact_id_seq OWNED BY public.web_page_profilecontact.id;


--
-- Name: web_page_profilecontact_owner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_profilecontact_owner (
    id bigint NOT NULL,
    profilecontact_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_profilecontact_owner OWNER TO postgres;

--
-- Name: web_page_profilecontact_owner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_profilecontact_owner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_profilecontact_owner_id_seq OWNER TO postgres;

--
-- Name: web_page_profilecontact_owner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_profilecontact_owner_id_seq OWNED BY public.web_page_profilecontact_owner.id;


--
-- Name: web_page_signature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_signature (
    id bigint NOT NULL,
    text character varying(20) NOT NULL,
    photo character varying(100),
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_signature OWNER TO postgres;

--
-- Name: web_page_signature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_signature_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_signature_id_seq OWNER TO postgres;

--
-- Name: web_page_signature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_signature_id_seq OWNED BY public.web_page_signature.id;


--
-- Name: account_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user ALTER COLUMN id SET DEFAULT nextval('public.account_user_id_seq'::regclass);


--
-- Name: account_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups ALTER COLUMN id SET DEFAULT nextval('public.account_user_groups_id_seq'::regclass);


--
-- Name: account_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.account_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: web_page_email id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_id_seq'::regclass);


--
-- Name: web_page_email_label id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_label_id_seq'::regclass);


--
-- Name: web_page_email_receiver id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_receiver_id_seq'::regclass);


--
-- Name: web_page_label id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_label ALTER COLUMN id SET DEFAULT nextval('public.web_page_label_id_seq'::regclass);


--
-- Name: web_page_profilecontact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact ALTER COLUMN id SET DEFAULT nextval('public.web_page_profilecontact_id_seq'::regclass);


--
-- Name: web_page_profilecontact_owner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact_owner ALTER COLUMN id SET DEFAULT nextval('public.web_page_profilecontact_owner_id_seq'::regclass);


--
-- Name: web_page_signature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_signature ALTER COLUMN id SET DEFAULT nextval('public.web_page_signature_id_seq'::regclass);


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone_number, birthday, gender_type, country_type, slug, email_user) FROM stdin;
46	pbkdf2_sha256$260000$HUUOVGUQuckcauB54NC0aX$mPvQtkefTnccGPWv/llcQGcHTJ5vfWZ+vT55AmO0Qtw=	\N	f	Mahdiye				f	f	2022-02-24 18:33:38.634012+03:30	\N	1999-05-18	C	ir	\N	\N
47	pbkdf2_sha256$260000$aVk1Llo1IGhKV9r3Xb3VeV$HhtGnUq3ZMNtxoKYMa3xETeR1r/3rxrt6/gDNudkUxs=	\N	f	gisha				f	f	2022-02-24 18:39:34.900804+03:30	\N	\N	\N	\N	\N	\N
48	pbkdf2_sha256$260000$0MPTVNWdwZC8d4RrAsMnTv$uASIx6LPS/C+bK7Yo9WjRzOOYz4kK5mZZrmL08fTuQY=	\N	f	mhdiye				f	f	2022-02-24 18:44:29.96645+03:30	\N	\N	\N	\N	\N	\N
49	pbkdf2_sha256$260000$7EReyAhq37jPCCqw7FK0hr$CDYyhKxAyf7nngJlGZEKMs1uSesN5dKJJfwLgGYq3oA=	\N	f	gisha2				f	f	2022-02-24 18:45:58.120038+03:30	\N	\N	\N	\N	\N	\N
50	pbkdf2_sha256$260000$WIw2mYw1Una365rbgnO8j5$x4oARf4Sut9b+SX7vzdyF6paSnaRrcrpraKzNrcrCm8=	\N	f	gholi				f	f	2022-02-24 18:48:15.696263+03:30	\N	\N	\N	\N	\N	\N
51	pbkdf2_sha256$260000$ENgh4c4pU0VoSZilsNftUk$3sU7HUY8c/KKx9sved74R9568EEqtkicoxWA261B6BU=	\N	f	gholiiiiiii				f	f	2022-02-24 18:52:09.586365+03:30	\N	\N	\N	\N	\N	\N
52	pbkdf2_sha256$260000$mlVPhXfY9a7vyVqrJnbmo4$soD4fwhuSDjeN0pGDxeh15wkiDnLmk8mYaWpXJBo/7I=	\N	f	sadaf				f	f	2022-02-24 18:59:19.901474+03:30	\N	\N	\N	\N	\N	\N
53	pbkdf2_sha256$260000$43abWWfKDVjRukhQlYgA9t$Waim7cGgHJiJFFc0XevB9KdBaWheBpXZDu6kxc4M+JE=	\N	f	sadaf222				f	f	2022-02-24 19:02:42.94258+03:30	\N	\N	\N	UK	\N	\N
54	pbkdf2_sha256$260000$l7uSh6xHf7YhENgBS000Ec$B9QeQZ8RkWt5wylMvpSE87p5HI6v6UW7TbD2yK3QZXw=	\N	f	eeeeeeeeeeeeeeeee				f	f	2022-02-24 19:06:56.814789+03:30	\N	\N	M	\N	\N	\N
55	pbkdf2_sha256$260000$uTlUjaoRBcrj3zqngn2vye$rDnaMlvU4H4sheaj7lNbhUtlsgDbEbXUaYXiX4Dk/10=	\N	f	eeeeeeeeeeeeeeeeeee				f	f	2022-02-24 19:08:19.314809+03:30	\N	\N	M	\N	\N	\N
56	pbkdf2_sha256$260000$JAHLIWyOfxsUol7DP0KWrF$oPofjpgrwXkYr2KWWoDvHxVXLRP1ETvVJ+ZHlAuWMnQ=	\N	f	sssss				f	f	2022-02-24 19:11:18.544303+03:30	\N	\N	C	FR	\N	\N
57	pbkdf2_sha256$260000$veMc3MXysH4X5X4bxR1Clz$yRgC6ti5UAPXffYP39RB0KS8ikFGUsCBLr8AWBCHwc4=	\N	f	gggggggggg				f	f	2022-02-24 19:17:33.149383+03:30	\N	\N	M	FR	\N	\N
58	1234hello	\N	f	ggggggggggww				f	f	2022-02-24 19:30:06.725172+03:30	\N	\N	M	FR	\N	\N
59	1234hello	\N	f	Mahdiye32				f	f	2022-02-24 19:34:46.798068+03:30	\N	\N	C	US	\N	\N
60	pbkdf2_sha256$260000$p5WisHlPR66Brd6FWuSj0L$52uUvb+t2Ne2liFozLiOIWqolDW4RRkgKHmkufnHThA=	2022-02-24 19:42:32.256206+03:30	f	Mahdiye3222@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-24 19:41:36.160937+03:30	\N	\N	C	\N	\N	\N
61	1234hello	\N	f	wwwwwwww				f	f	2022-02-24 19:45:00.615722+03:30	\N	\N	\N	UK	\N	\N
62	pbkdf2_sha256$260000$gsjVZ9QOSqRRmvCIxqvoSp$9xDL/Ggjw5O/n957xhNQXq3D2H8fdvShtLJYuiHa7bI=	2022-02-24 19:47:10.522961+03:30	f	ettttttrr@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-24 19:46:26.862653+03:30	\N	\N	\N	\N	\N	\N
63	1234hello	\N	f	fateme				f	f	2022-02-24 20:04:57.550385+03:30	\N	\N	C	FR	\N	\N
64	pbkdf2_sha256$260000$ccLpyqzW9lrVF8A23EpPMe$APVACohxwgdwSCz59Vgq1XvgdsZeWKS80h6weWe1f0A=	2022-02-24 22:20:33.756149+03:30	f	salar@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-24 22:19:53.292116+03:30	\N	\N	R	\N	\N	\N
1	pbkdf2_sha256$260000$L8vTZwMNRIkB8FPjuBx0Y9$LVm8pMZoaXZPDOltqgACwnB2DwV3CXL3eBQydM/uhfM=	2022-02-24 23:10:17.595023+03:30	t	admin				t	t	2022-02-20 20:09:05.370004+03:30		\N	\N	\N		\N
65	pbkdf2_sha256$260000$ktgIC3AzHqbfujJLfCP6E9$jQq8GrdM8A5IjdZGqT2rdFEalw2r6QZGYDI9arr6nTE=	2022-02-25 09:53:38.101766+03:30	f	mahshad@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-25 09:52:05.677291+03:30	\N	\N	\N	UK	\N	\N
66	pbkdf2_sha256$260000$xH9drMEjq1sL7zHAZOQK5C$T5OAgqjhIkQPVedNNCIjgqXE+clXA0DHm4T2Y+L0dHU=	2022-02-25 10:54:40.937945+03:30	f	neda@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-25 10:53:39.234671+03:30	\N	\N	F	\N	\N	\N
67	pbkdf2_sha256$260000$M1hpOuKmapoxQBxe7sBRuz$f8c4OohaMIPZA6Tg8oPKt4+hNDe7fdA7Aqi6gHqU/nw=	\N	f	wwwwwwwww				f	f	2022-02-25 15:44:55.500189+03:30	\N	\N	\N	FR	\N	\N
\.


--
-- Data for Name: account_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: account_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add label	7	add_label
26	Can change label	7	change_label
27	Can delete label	7	delete_label
28	Can view label	7	view_label
29	Can add signature category	8	add_signaturecategory
30	Can change signature category	8	change_signaturecategory
31	Can delete signature category	8	delete_signaturecategory
32	Can view signature category	8	view_signaturecategory
33	Can add signature	9	add_signature
34	Can change signature	9	change_signature
35	Can delete signature	9	delete_signature
36	Can view signature	9	view_signature
37	Can add profile contact	10	add_profilecontact
38	Can change profile contact	10	change_profilecontact
39	Can delete profile contact	10	delete_profilecontact
40	Can view profile contact	10	view_profilecontact
41	Can add email	11	add_email
42	Can change email	11	change_email
43	Can delete email	11	delete_email
44	Can view email	11	view_email
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-02-21 10:37:24.035511+03:30	3	Mahdiye	1	[{"added": {}}]	6	1
2	2022-02-22 02:36:41.412336+03:30	19	jjjjj@gmail.com	3		6	1
3	2022-02-22 02:37:40.658044+03:30	32	mhdiye	3		6	1
4	2022-02-22 02:37:40.660112+03:30	31	qqqqqqqqqqww	3		6	1
5	2022-02-22 02:37:40.660112+03:30	30	qqqqqqqq	3		6	1
6	2022-02-22 02:37:40.661916+03:30	28	qqqqqqqq@gmail.com	3		6	1
7	2022-02-22 02:37:40.662716+03:30	25	aaaaaaaa11@gmail.com	3		6	1
8	2022-02-22 02:37:40.662716+03:30	24	aaaaaaaa	3		6	1
9	2022-02-22 02:37:40.66372+03:30	22	aaaaaaaa@gmail.com	3		6	1
10	2022-02-22 02:37:40.664717+03:30	18	benyamin2@gmail.com	3		6	1
11	2022-02-22 02:37:40.664717+03:30	17	qqqq@gmail.com	3		6	1
12	2022-02-22 02:37:40.665713+03:30	16	sss@gmail.com	3		6	1
13	2022-02-22 02:37:40.665713+03:30	14	benyamin@gmail.com	3		6	1
14	2022-02-23 11:58:22.12875+03:30	1	ProfileContact object (1)	1	[{"added": {}}]	10	1
15	2022-02-23 23:25:24.23937+03:30	1	Archived	1	[{"added": {}}]	7	1
16	2022-02-24 18:26:04.295114+03:30	44	Mahdiye23@gmail.com	3		6	1
17	2022-02-24 18:26:04.302206+03:30	43	admin4	3		6	1
18	2022-02-24 18:26:04.303209+03:30	42	admin4@gmail.com	3		6	1
19	2022-02-24 18:26:04.30419+03:30	41	admin2@gmail.com	3		6	1
20	2022-02-24 18:26:04.30419+03:30	40	sadaf4@gmail.com	3		6	1
21	2022-02-24 18:26:04.306201+03:30	39	sadaf3@gmail.com	3		6	1
22	2022-02-24 18:26:04.307191+03:30	38	sadaf2@gmail.com	3		6	1
23	2022-02-24 18:26:04.307191+03:30	37	sadaf	3		6	1
24	2022-02-24 18:26:04.30819+03:30	36	ffffffff@gmail.com	3		6	1
25	2022-02-24 18:26:04.30819+03:30	35	wwwwwwwwwwwww	3		6	1
26	2022-02-24 18:26:04.309189+03:30	34	lllllll@gmail.com	3		6	1
27	2022-02-24 18:26:04.309189+03:30	33	mohammadali_sheikhhadi	3		6	1
28	2022-02-24 18:26:04.310189+03:30	15	pouya@gmail.com	3		6	1
29	2022-02-24 18:26:04.310189+03:30	12	maryam@gmail.com	3		6	1
30	2022-02-24 18:26:04.310189+03:30	10	ali@gmail.com	3		6	1
31	2022-02-24 18:26:04.31119+03:30	3	Mahdiye	3		6	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	account	user
7	web_page	label
8	web_page	signaturecategory
9	web_page	signature
10	web_page	profilecontact
11	web_page	email
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-02-20 20:07:42.034876+03:30
2	contenttypes	0002_remove_content_type_name	2022-02-20 20:07:42.042855+03:30
3	auth	0001_initial	2022-02-20 20:07:42.078838+03:30
4	auth	0002_alter_permission_name_max_length	2022-02-20 20:07:42.081838+03:30
5	auth	0003_alter_user_email_max_length	2022-02-20 20:07:42.086193+03:30
6	auth	0004_alter_user_username_opts	2022-02-20 20:07:42.091176+03:30
7	auth	0005_alter_user_last_login_null	2022-02-20 20:07:42.095337+03:30
8	auth	0006_require_contenttypes_0002	2022-02-20 20:07:42.096425+03:30
9	auth	0007_alter_validators_add_error_messages	2022-02-20 20:07:42.100422+03:30
10	auth	0008_alter_user_username_max_length	2022-02-20 20:07:42.103416+03:30
11	auth	0009_alter_user_last_name_max_length	2022-02-20 20:07:42.108387+03:30
12	auth	0010_alter_group_name_max_length	2022-02-20 20:07:42.113268+03:30
13	auth	0011_update_proxy_permissions	2022-02-20 20:07:42.117276+03:30
14	auth	0012_alter_user_first_name_max_length	2022-02-20 20:07:42.120244+03:30
15	account	0001_initial	2022-02-20 20:07:42.162855+03:30
16	admin	0001_initial	2022-02-20 20:07:42.181963+03:30
17	admin	0002_logentry_remove_auto_add	2022-02-20 20:07:42.187181+03:30
18	admin	0003_logentry_add_action_flag_choices	2022-02-20 20:07:42.191973+03:30
19	sessions	0001_initial	2022-02-20 20:07:42.202644+03:30
20	web_page	0001_initial	2022-02-20 20:07:42.279992+03:30
21	account	0002_auto_20220221_2130	2022-02-21 21:31:22.786123+03:30
22	web_page	0002_auto_20220221_2130	2022-02-21 21:31:22.934992+03:30
23	account	0003_auto_20220221_2213	2022-02-21 22:13:44.208737+03:30
24	web_page	0003_alter_label_slug	2022-02-21 22:13:44.219699+03:30
25	account	0004_user_email_confirmed	2022-02-22 01:03:48.911885+03:30
26	account	0005_alter_user_managers	2022-02-24 01:34:20.211421+03:30
27	web_page	0004_auto_20220224_0134	2022-02-24 01:34:20.263251+03:30
28	web_page	0005_email_sender	2022-02-24 02:37:36.890222+03:30
29	account	0006_auto_20220224_1758	2022-02-24 18:26:34.386577+03:30
30	account	0007_alter_user_username	2022-02-24 18:26:34.397579+03:30
31	account	0008_auto_20220224_1816	2022-02-24 18:26:34.450578+03:30
32	account	0009_remove_user_email_user	2022-02-24 18:26:34.459541+03:30
33	account	0010_user_email_user	2022-02-24 18:26:34.475297+03:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
6slv1c9khav2plycvg3sg5mejmorwf99	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nM7bH:tXVQT3y8a6zf0YbgC_ZNF4vEH579dVFpBoVylz5y9AY	2022-03-07 15:45:31.198001+03:30
yr6dftyt46omigdbhnfrzussrmtnmxdd	e30:1nMIOJ:EZVjGqic3s909Ccqkf1a-yETdOdQb-jFsj3W9ODikVQ	2022-03-08 03:16:51.225001+03:30
1m3lzjs9j9b5uv09x3lj6dqbk3i4duvz	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nMmnd:4RCmHbrpVC9Or6q_l3W2UjvOhWs1IFiEHNL8_tmmIeI	2022-03-09 11:45:01.102421+03:30
bhtrz59dowgmwlqtx0huyfjpiyelw3i5	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nNFWt:Gf3Iu9Q3BThMXeg9RDX7JDrVxeeJMc_uxHZz8GJTIcA	2022-03-10 18:25:39.761166+03:30
warb6bx8glo3srv47c7bp17z5c5cmhhr	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nNJyL:70CbKiEuaHiejXnWzPk9DuTePNUSN8Dp9aKWLCq8FrM	2022-03-10 23:10:17.597026+03:30
44nspa6avdl4vno7n90mz6x583kc98vm	.eJxVjEEOwiAQRe_C2hAHBygu3XuGZmYAqRpISrsy3l2bdKHb_977LzXSupRx7Wkep6jOyjl1-B2Z5JHqRuKd6q1paXWZJ9abonfa9bXF9Lzs7t9BoV6-tc-WxBxzCJCcER8TZgqZHQiwMTwMQQgSAkT0TiJgQMNCmG1me0L1_gAkbjia:1nNUy0:9qgD-DDBc0x1RFBhzH2jiDts2IS3kRGcKaAzZMin50w	2022-03-11 10:54:40.940292+03:30
\.


--
-- Data for Name: web_page_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email (id, subject, text, file, created, edited, is_sent, is_inbox, is_starred, is_draft, is_trash, is_read, sign_id, slug, sender_id) FROM stdin;
\.


--
-- Data for Name: web_page_email_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_label (id, email_id, label_id) FROM stdin;
\.


--
-- Data for Name: web_page_email_receiver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_receiver (id, email_id, profilecontact_id) FROM stdin;
\.


--
-- Data for Name: web_page_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_label (id, title, slug) FROM stdin;
1	Archived	Archived
\.


--
-- Data for Name: web_page_profilecontact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_profilecontact (id, first_name, last_name, email, profile_photo, phone_number, birthday, slug) FROM stdin;
1	parsa	ghafoori	parsa@gmail.com		\N	\N	parsa
\.


--
-- Data for Name: web_page_profilecontact_owner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_profilecontact_owner (id, profilecontact_id, user_id) FROM stdin;
\.


--
-- Data for Name: web_page_signature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_signature (id, text, photo, user_id) FROM stdin;
\.


--
-- Name: account_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_groups_id_seq', 1, false);


--
-- Name: account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_id_seq', 67, true);


--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 44, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 31, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 11, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 33, true);


--
-- Name: web_page_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_id_seq', 1, false);


--
-- Name: web_page_email_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_label_id_seq', 1, false);


--
-- Name: web_page_email_receiver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_receiver_id_seq', 1, false);


--
-- Name: web_page_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_label_id_seq', 1, true);


--
-- Name: web_page_profilecontact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_profilecontact_id_seq', 1, true);


--
-- Name: web_page_profilecontact_owner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_profilecontact_owner_id_seq', 1, true);


--
-- Name: web_page_signature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_signature_id_seq', 1, false);


--
-- Name: account_user account_user_email_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_email_user_key UNIQUE (email_user);


--
-- Name: account_user_groups account_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_pkey PRIMARY KEY (id);


--
-- Name: account_user_groups account_user_groups_user_id_group_id_4d09af3e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_group_id_4d09af3e_uniq UNIQUE (user_id, group_id);


--
-- Name: account_user account_user_phone_number_f0b7bc12_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_phone_number_f0b7bc12_uniq UNIQUE (phone_number);


--
-- Name: account_user account_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_pkey PRIMARY KEY (id);


--
-- Name: account_user account_user_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_slug_key UNIQUE (slug);


--
-- Name: account_user_user_permissions account_user_user_permis_user_id_permission_id_48bdd28b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permis_user_id_permission_id_48bdd28b_uniq UNIQUE (user_id, permission_id);


--
-- Name: account_user_user_permissions account_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: account_user account_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: web_page_email_label web_page_email_label_email_id_label_id_83cbda9f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label
    ADD CONSTRAINT web_page_email_label_email_id_label_id_83cbda9f_uniq UNIQUE (email_id, label_id);


--
-- Name: web_page_email_label web_page_email_label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label
    ADD CONSTRAINT web_page_email_label_pkey PRIMARY KEY (id);


--
-- Name: web_page_email web_page_email_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_pkey PRIMARY KEY (id);


--
-- Name: web_page_email_receiver web_page_email_receiver_email_id_user_id_d4e31a7e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver
    ADD CONSTRAINT web_page_email_receiver_email_id_user_id_d4e31a7e_uniq UNIQUE (email_id, profilecontact_id);


--
-- Name: web_page_email_receiver web_page_email_receiver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver
    ADD CONSTRAINT web_page_email_receiver_pkey PRIMARY KEY (id);


--
-- Name: web_page_email web_page_email_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_slug_key UNIQUE (slug);


--
-- Name: web_page_label web_page_label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_label
    ADD CONSTRAINT web_page_label_pkey PRIMARY KEY (id);


--
-- Name: web_page_label web_page_label_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_label
    ADD CONSTRAINT web_page_label_slug_key UNIQUE (slug);


--
-- Name: web_page_profilecontact_owner web_page_profilecontact__profilecontact_id_user_i_ea67ce15_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact_owner
    ADD CONSTRAINT web_page_profilecontact__profilecontact_id_user_i_ea67ce15_uniq UNIQUE (profilecontact_id, user_id);


--
-- Name: web_page_profilecontact_owner web_page_profilecontact_owner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact_owner
    ADD CONSTRAINT web_page_profilecontact_owner_pkey PRIMARY KEY (id);


--
-- Name: web_page_profilecontact web_page_profilecontact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact
    ADD CONSTRAINT web_page_profilecontact_pkey PRIMARY KEY (id);


--
-- Name: web_page_profilecontact web_page_profilecontact_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact
    ADD CONSTRAINT web_page_profilecontact_slug_key UNIQUE (slug);


--
-- Name: web_page_signature web_page_signature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_signature
    ADD CONSTRAINT web_page_signature_pkey PRIMARY KEY (id);


--
-- Name: account_user_email_user_654c6b69_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_email_user_654c6b69_like ON public.account_user USING btree (email_user varchar_pattern_ops);


--
-- Name: account_user_groups_group_id_6c71f749; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_groups_group_id_6c71f749 ON public.account_user_groups USING btree (group_id);


--
-- Name: account_user_groups_user_id_14345e7b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_groups_user_id_14345e7b ON public.account_user_groups USING btree (user_id);


--
-- Name: account_user_phone_number_f0b7bc12_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_phone_number_f0b7bc12_like ON public.account_user USING btree (phone_number varchar_pattern_ops);


--
-- Name: account_user_slug_099839df_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_slug_099839df_like ON public.account_user USING btree (slug varchar_pattern_ops);


--
-- Name: account_user_user_permissions_permission_id_66c44191; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_user_permissions_permission_id_66c44191 ON public.account_user_user_permissions USING btree (permission_id);


--
-- Name: account_user_user_permissions_user_id_cc42d270; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_user_permissions_user_id_cc42d270 ON public.account_user_user_permissions USING btree (user_id);


--
-- Name: account_user_username_d393f583_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_username_d393f583_like ON public.account_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: web_page_email_label_email_id_f603b8a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_label_email_id_f603b8a1 ON public.web_page_email_label USING btree (email_id);


--
-- Name: web_page_email_label_label_id_30e8206a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_label_label_id_30e8206a ON public.web_page_email_label USING btree (label_id);


--
-- Name: web_page_email_receiver_email_id_68466bd4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_email_id_68466bd4 ON public.web_page_email_receiver USING btree (email_id);


--
-- Name: web_page_email_receiver_user_id_8436398e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_user_id_8436398e ON public.web_page_email_receiver USING btree (profilecontact_id);


--
-- Name: web_page_email_sender_id_c0a0b598; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_sender_id_c0a0b598 ON public.web_page_email USING btree (sender_id);


--
-- Name: web_page_email_sign_id_98c62777; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_sign_id_98c62777 ON public.web_page_email USING btree (sign_id);


--
-- Name: web_page_email_slug_2fa04289_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_slug_2fa04289_like ON public.web_page_email USING btree (slug varchar_pattern_ops);


--
-- Name: web_page_label_slug_213cefa7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_label_slug_213cefa7_like ON public.web_page_label USING btree (slug varchar_pattern_ops);


--
-- Name: web_page_profilecontact_owner_profilecontact_id_69e570fb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_profilecontact_owner_profilecontact_id_69e570fb ON public.web_page_profilecontact_owner USING btree (profilecontact_id);


--
-- Name: web_page_profilecontact_owner_user_id_9de6b1f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_profilecontact_owner_user_id_9de6b1f5 ON public.web_page_profilecontact_owner USING btree (user_id);


--
-- Name: web_page_profilecontact_slug_c9b957e3_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_profilecontact_slug_c9b957e3_like ON public.web_page_profilecontact USING btree (slug varchar_pattern_ops);


--
-- Name: web_page_signature_user_id_90813285; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_signature_user_id_90813285 ON public.web_page_signature USING btree (user_id);


--
-- Name: account_user_groups account_user_groups_group_id_6c71f749_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_group_id_6c71f749_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups account_user_groups_user_id_14345e7b_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_14345e7b_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_permission_id_66c44191_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_permission_id_66c44191_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_user_id_cc42d270_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_user_id_cc42d270_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_label web_page_email_label_email_id_f603b8a1_fk_web_page_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label
    ADD CONSTRAINT web_page_email_label_email_id_f603b8a1_fk_web_page_email_id FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_label web_page_email_label_label_id_30e8206a_fk_web_page_label_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label
    ADD CONSTRAINT web_page_email_label_label_id_30e8206a_fk_web_page_label_id FOREIGN KEY (label_id) REFERENCES public.web_page_label(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver web_page_email_recei_profilecontact_id_717664fa_fk_web_page_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver
    ADD CONSTRAINT web_page_email_recei_profilecontact_id_717664fa_fk_web_page_ FOREIGN KEY (profilecontact_id) REFERENCES public.web_page_profilecontact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver web_page_email_receiver_email_id_68466bd4_fk_web_page_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver
    ADD CONSTRAINT web_page_email_receiver_email_id_68466bd4_fk_web_page_email_id FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email web_page_email_sender_id_c0a0b598_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_sender_id_c0a0b598_fk_account_user_id FOREIGN KEY (sender_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email web_page_email_sign_id_98c62777_fk_web_page_signature_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_sign_id_98c62777_fk_web_page_signature_id FOREIGN KEY (sign_id) REFERENCES public.web_page_signature(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_profilecontact_owner web_page_profilecont_profilecontact_id_69e570fb_fk_web_page_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact_owner
    ADD CONSTRAINT web_page_profilecont_profilecontact_id_69e570fb_fk_web_page_ FOREIGN KEY (profilecontact_id) REFERENCES public.web_page_profilecontact(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_profilecontact_owner web_page_profilecont_user_id_9de6b1f5_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact_owner
    ADD CONSTRAINT web_page_profilecont_user_id_9de6b1f5_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_signature web_page_signature_user_id_90813285_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_signature
    ADD CONSTRAINT web_page_signature_user_id_90813285_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

