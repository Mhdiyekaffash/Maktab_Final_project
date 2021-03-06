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
    is_starred boolean NOT NULL,
    is_draft boolean NOT NULL,
    is_trash boolean NOT NULL,
    is_read boolean NOT NULL,
    sign_id bigint,
    slug character varying(20),
    sender_id bigint,
    email_obj_id bigint
);


ALTER TABLE public.web_page_email OWNER TO postgres;

--
-- Name: web_page_email_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_filter (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    filter_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_filter OWNER TO postgres;

--
-- Name: web_page_email_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_filter_id_seq OWNER TO postgres;

--
-- Name: web_page_email_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_filter_id_seq OWNED BY public.web_page_email_filter.id;


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
-- Name: web_page_email_receiver_bcc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_receiver_bcc (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_receiver_bcc OWNER TO postgres;

--
-- Name: web_page_email_receiver_bcc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_receiver_bcc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_receiver_bcc_id_seq OWNER TO postgres;

--
-- Name: web_page_email_receiver_bcc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_receiver_bcc_id_seq OWNED BY public.web_page_email_receiver_bcc.id;


--
-- Name: web_page_email_receiver_cc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_receiver_cc (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_receiver_cc OWNER TO postgres;

--
-- Name: web_page_email_receiver_cc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_receiver_cc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_receiver_cc_id_seq OWNER TO postgres;

--
-- Name: web_page_email_receiver_cc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_receiver_cc_id_seq OWNED BY public.web_page_email_receiver_cc.id;


--
-- Name: web_page_email_receiver_to; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_email_receiver_to (
    id bigint NOT NULL,
    email_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_email_receiver_to OWNER TO postgres;

--
-- Name: web_page_email_receiver_to_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_email_receiver_to_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_email_receiver_to_id_seq OWNER TO postgres;

--
-- Name: web_page_email_receiver_to_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_email_receiver_to_id_seq OWNED BY public.web_page_email_receiver_to.id;


--
-- Name: web_page_emailfolder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_emailfolder (
    id bigint NOT NULL,
    is_trash boolean NOT NULL,
    is_archive boolean NOT NULL,
    is_draft boolean NOT NULL,
    email_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.web_page_emailfolder OWNER TO postgres;

--
-- Name: web_page_emailfolder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_emailfolder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_emailfolder_id_seq OWNER TO postgres;

--
-- Name: web_page_emailfolder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_emailfolder_id_seq OWNED BY public.web_page_emailfolder.id;


--
-- Name: web_page_filter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_filter (
    id bigint NOT NULL,
    title character varying(50) NOT NULL,
    owner_id bigint,
    filter_by character varying(100)
);


ALTER TABLE public.web_page_filter OWNER TO postgres;

--
-- Name: web_page_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.web_page_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_page_filter_id_seq OWNER TO postgres;

--
-- Name: web_page_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.web_page_filter_id_seq OWNED BY public.web_page_filter.id;


--
-- Name: web_page_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_label (
    id bigint NOT NULL,
    title character varying(20) NOT NULL,
    slug character varying(20),
    user_id bigint
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
    slug character varying(20),
    other_email character varying(254),
    user_id bigint
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
-- Name: web_page_signature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_page_signature (
    id bigint NOT NULL,
    text character varying(20) NOT NULL,
    photo character varying(100),
    user_id bigint
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
-- Name: web_page_email_filter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_filter ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_filter_id_seq'::regclass);


--
-- Name: web_page_email_label id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_label ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_label_id_seq'::regclass);


--
-- Name: web_page_email_receiver_bcc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_bcc ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_receiver_bcc_id_seq'::regclass);


--
-- Name: web_page_email_receiver_cc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_cc ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_receiver_cc_id_seq'::regclass);


--
-- Name: web_page_email_receiver_to id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_to ALTER COLUMN id SET DEFAULT nextval('public.web_page_email_receiver_to_id_seq'::regclass);


--
-- Name: web_page_emailfolder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_emailfolder ALTER COLUMN id SET DEFAULT nextval('public.web_page_emailfolder_id_seq'::regclass);


--
-- Name: web_page_filter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_filter ALTER COLUMN id SET DEFAULT nextval('public.web_page_filter_id_seq'::regclass);


--
-- Name: web_page_label id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_label ALTER COLUMN id SET DEFAULT nextval('public.web_page_label_id_seq'::regclass);


--
-- Name: web_page_profilecontact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact ALTER COLUMN id SET DEFAULT nextval('public.web_page_profilecontact_id_seq'::regclass);


--
-- Name: web_page_signature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_signature ALTER COLUMN id SET DEFAULT nextval('public.web_page_signature_id_seq'::regclass);


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone_number, birthday, gender_type, country_type, slug, email_user) FROM stdin;
46	pbkdf2_sha256$260000$HUUOVGUQuckcauB54NC0aX$mPvQtkefTnccGPWv/llcQGcHTJ5vfWZ+vT55AmO0Qtw=	\N	f	Mahdiye				f	f	2022-02-24 18:33:38.634012+03:30	\N	1999-05-18	C	ir	\N	\N
64	pbkdf2_sha256$260000$ccLpyqzW9lrVF8A23EpPMe$APVACohxwgdwSCz59Vgq1XvgdsZeWKS80h6weWe1f0A=	2022-02-24 22:20:33.756149+03:30	f	salar@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-24 22:19:53.292116+03:30	\N	\N	R	\N	\N	\N
65	pbkdf2_sha256$260000$ktgIC3AzHqbfujJLfCP6E9$jQq8GrdM8A5IjdZGqT2rdFEalw2r6QZGYDI9arr6nTE=	2022-02-25 09:53:38.101766+03:30	f	mahshad@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-25 09:52:05.677291+03:30	\N	\N	\N	UK	\N	\N
68	pbkdf2_sha256$260000$n9yh9htEgoXeQUb0UkbNSC$5jVPV5VI52fxSnEyBO3xDrFdIRZ6jnT5M0A2EnguRMM=	2022-02-27 13:38:18+03:30	t	admin1			test@gmail.com	t	t	2022-02-27 13:36:44+03:30	\N	\N	\N	\N	12w	\N
72	mk1309	\N	f	Adele@gmail.com			Adele2@gmail.com	f	t	2022-03-04 10:09:28+03:30	\N	\N	\N	\N	11111111111122	\N
62	pbkdf2_sha256$260000$gsjVZ9QOSqRRmvCIxqvoSp$9xDL/Ggjw5O/n957xhNQXq3D2H8fdvShtLJYuiHa7bI=	2022-02-24 19:47:10+03:30	f	mahdiye@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-24 19:46:26+03:30	\N	\N	\N	\N	123wa	\N
70	mk1234	\N	f	maryam@gmail.com				f	t	2022-03-01 11:23:31+03:30	\N	\N	\N	\N	1234e	\N
73	pbkdf2_sha256$260000$1b66TwIpSoOVOThqkRVYUD$ofzoTSTUeSH7Awbd/0bLIWmlDnDv4Sw3wOlSD4iTJSw=	2022-03-17 17:33:21.865591+03:30	f	elnaz@gmail.com			kfashmhdyh@gmail.com	f	t	2022-03-04 11:15:37.254739+03:30	\N	\N	\N	\N	\N	\N
71	pbkdf2_sha256$260000$G0Us2AE8x6D0qOZtxKLTLa$UAhp3ISZLpZtSPPDllb5iCKyJpURq/lI0jI42jXfdGE=	2022-03-04 10:36:37.339356+03:30	t	admin3			admin3@gmail.com	t	t	2022-03-04 09:51:14.211773+03:30	\N	\N	\N	\N	\N	\N
69	pbkdf2_sha256$260000$HFxn1MlHvyaqXqY1cKxCiz$UylPvZiTI5pebVJWshEvDuzh0ExG/ZFCZChmr0IN45U=	2022-03-07 21:39:10.865496+03:30	t	admin2			admin@gmail.com	t	t	2022-02-28 12:50:06.199286+03:30	\N	\N	\N	\N	\N	\N
75	pbkdf2_sha256$260000$JD87i2fL7JwI7jG9Pm5xgL$wR+qe2dnlmCGEGg52PTZ8yZY2LVg0B39RbE3eVAzRVs=	2022-03-14 21:23:21.712381+03:30	f	zahra@gmail.com			kfashmhdyh@gmail.com	f	t	2022-03-11 10:50:28.664744+03:30	\N	\N	\N	\N	\N	\N
74	pbkdf2_sha256$260000$b0LV1WYCTwWsvQb7WsXlLd$v1r4vm+xGCh0zQ4QKvuWCZDtRaiUSOSOB53itTLfUr8=	2022-03-17 20:15:49.117004+03:30	f	fateme@gmail.com			kfashmhdyh@gmail.com	f	t	2022-03-11 10:49:08.645623+03:30	\N	\N	\N	\N	\N	\N
1	pbkdf2_sha256$260000$L8vTZwMNRIkB8FPjuBx0Y9$LVm8pMZoaXZPDOltqgACwnB2DwV3CXL3eBQydM/uhfM=	2022-03-17 22:46:20.99033+03:30	t	admin				t	t	2022-02-20 20:09:05.370004+03:30		\N	\N	\N		\N
66	pbkdf2_sha256$260000$xH9drMEjq1sL7zHAZOQK5C$T5OAgqjhIkQPVedNNCIjgqXE+clXA0DHm4T2Y+L0dHU=	2022-03-17 23:33:07.28099+03:30	f	neda@gmail.com			kfashmhdyh@gmail.com	f	t	2022-02-25 10:53:39.234671+03:30	\N	\N	F	\N	\N	\N
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
45	Can add filter	12	add_filter
46	Can change filter	12	change_filter
47	Can delete filter	12	delete_filter
48	Can view filter	12	view_filter
49	Can add email folder	13	add_emailfolder
50	Can change email folder	13	change_emailfolder
51	Can delete email folder	13	delete_emailfolder
52	Can view email folder	13	view_emailfolder
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
32	2022-02-27 13:34:15.126865+03:30	1	ghafoori	2	[{"changed": {"fields": ["User"]}}]	10	1
33	2022-02-27 13:47:41.112228+03:30	68	test@gmail.com	2	[{"changed": {"fields": ["Email Recovery", "Slug"]}}]	6	68
34	2022-02-27 13:56:10.739391+03:30	2	test	1	[{"added": {}}]	10	68
35	2022-02-27 14:11:38.897098+03:30	3	parsaii	1	[{"added": {}}]	10	68
36	2022-02-27 14:32:05.135686+03:30	4	parsaii	1	[{"added": {}}]	10	68
37	2022-02-27 18:42:59.375175+03:30	1	Signature object (1)	1	[{"added": {}}]	9	68
38	2022-02-27 20:37:54.691464+03:30	2	Email object (2)	1	[{"added": {}}]	11	68
39	2022-02-27 21:46:32.380916+03:30	2	Email object (2)	2	[{"changed": {"fields": ["Is starred"]}}]	11	68
40	2022-02-28 13:21:22.48627+03:30	2	Signature object (2)	1	[{"added": {}}]	9	69
41	2022-02-28 13:26:01.693065+03:30	5	ali2	1	[{"added": {}}]	10	69
42	2022-02-28 13:26:32.061801+03:30	6	benyamin	1	[{"added": {}}]	10	69
43	2022-02-28 19:04:34.855551+03:30	6	benyamin	3		10	69
44	2022-02-28 19:04:34.85855+03:30	5	ali2	3		10	69
45	2022-02-28 19:04:34.859551+03:30	4	parsaii	3		10	69
46	2022-02-28 19:04:34.860549+03:30	3	parsaii	3		10	69
47	2022-02-28 19:04:34.861548+03:30	2	test	3		10	69
48	2022-02-28 19:04:34.861548+03:30	1	ghafoori	3		10	69
49	2022-02-28 19:05:42.614333+03:30	7	test	1	[{"added": {}}]	10	69
50	2022-02-28 19:06:15.412049+03:30	8	maryam	1	[{"added": {}}]	10	69
51	2022-02-28 19:07:35.06415+03:30	9	mahdiye	1	[{"added": {}}]	10	69
52	2022-02-28 19:20:36.874078+03:30	62	kfashmhdyh@gmail.com	2	[{"changed": {"fields": ["Username", "Slug"]}}]	6	69
53	2022-02-28 19:27:09.68613+03:30	10	soltani	1	[{"added": {}}]	10	69
54	2022-02-28 21:03:24.537951+03:30	11	salari	1	[{"added": {}}]	10	69
55	2022-03-01 11:24:17.856284+03:30	70	maryam@gmail.com	1	[{"added": {}}]	6	69
56	2022-03-02 23:22:38.782712+03:30	41	Email object (41)	2	[{"changed": {"fields": ["Label", "Slug"]}}]	11	69
57	2022-03-02 23:22:51.629221+03:30	40	Email object (40)	2	[{"changed": {"fields": ["Label", "Slug"]}}]	11	69
58	2022-03-03 12:38:23.647837+03:30	20	admin2	2	[{"changed": {"fields": ["Receiver cc", "Slug"]}}]	11	69
59	2022-03-03 18:36:57.805457+03:30	33	hi ok	2	[{"changed": {"fields": ["Label", "Slug"]}}]	11	69
60	2022-03-03 18:37:27.6406+03:30	36	This is Test	2	[{"changed": {"fields": ["Label", "Slug"]}}]	11	69
61	2022-03-03 18:56:59.045009+03:30	38	This is test3 ...	2	[{"changed": {"fields": ["Receiver cc", "Receiver bcc", "Slug"]}}]	11	69
62	2022-03-03 18:59:03.980811+03:30	29	ddd	2	[{"changed": {"fields": ["Subject", "Receiver to", "Receiver cc", "Receiver bcc", "Slug"]}}]	11	69
63	2022-03-03 19:00:17.432271+03:30	41	bcc	2	[{"changed": {"fields": ["Subject", "Text", "Receiver bcc"]}}]	11	69
64	2022-03-03 19:03:27.533361+03:30	42	this is email 100	1	[{"added": {}}]	11	69
65	2022-03-03 20:45:11.432849+03:30	42	this is email 100	2	[{"changed": {"fields": ["File"]}}]	11	69
66	2022-03-03 20:54:06.990304+03:30	42	Email object (42)	2	[{"changed": {"fields": ["File"]}}]	11	69
67	2022-03-03 21:03:00.322962+03:30	41	Email object (41)	2	[{"changed": {"fields": ["File"]}}]	11	69
68	2022-03-03 22:14:24.577366+03:30	6	archive	2	[{"changed": {"fields": ["Title"]}}]	7	69
69	2022-03-03 22:42:57.789777+03:30	73	Email object (73)	3		11	69
70	2022-03-03 22:42:57.793655+03:30	72	Email object (72)	3		11	69
71	2022-03-03 22:42:57.794671+03:30	71	Email object (71)	3		11	69
72	2022-03-03 22:42:57.795703+03:30	70	Email object (70)	3		11	69
73	2022-03-03 22:42:57.796672+03:30	69	Email object (69)	3		11	69
74	2022-03-03 22:42:57.797672+03:30	68	Email object (68)	3		11	69
75	2022-03-03 22:42:57.798673+03:30	67	Email object (67)	3		11	69
76	2022-03-03 22:42:57.799672+03:30	66	Email object (66)	3		11	69
77	2022-03-03 22:42:57.800671+03:30	65	Email object (65)	3		11	69
78	2022-03-03 22:42:57.800671+03:30	64	Email object (64)	3		11	69
79	2022-03-03 22:42:57.801673+03:30	63	Email object (63)	3		11	69
80	2022-03-03 22:42:57.801673+03:30	62	Email object (62)	3		11	69
81	2022-03-03 22:42:57.80267+03:30	61	Email object (61)	3		11	69
82	2022-03-03 22:42:57.803671+03:30	60	Email object (60)	3		11	69
83	2022-03-03 22:42:57.803671+03:30	59	Email object (59)	3		11	69
84	2022-03-03 22:42:57.804671+03:30	58	Email object (58)	3		11	69
85	2022-03-03 22:42:57.805693+03:30	57	Email object (57)	3		11	69
86	2022-03-03 22:42:57.805693+03:30	56	Email object (56)	3		11	69
87	2022-03-03 22:42:57.806672+03:30	55	Email object (55)	3		11	69
88	2022-03-03 22:42:57.806672+03:30	54	Email object (54)	3		11	69
187	2022-03-07 11:40:11.092731+03:30	98	vcv	3		11	69
89	2022-03-03 22:42:57.807671+03:30	53	Email object (53)	3		11	69
90	2022-03-03 22:42:57.810677+03:30	52	Email object (52)	3		11	69
91	2022-03-03 22:42:57.811774+03:30	51	Email object (51)	3		11	69
92	2022-03-03 22:42:57.811774+03:30	50	Email object (50)	3		11	69
93	2022-03-03 22:42:57.812783+03:30	49	Email object (49)	3		11	69
94	2022-03-03 22:42:57.812783+03:30	48	Email object (48)	3		11	69
95	2022-03-03 22:42:57.813779+03:30	47	Email object (47)	3		11	69
96	2022-03-03 22:42:57.813779+03:30	46	Email object (46)	3		11	69
97	2022-03-03 22:42:57.814779+03:30	45	Email object (45)	3		11	69
98	2022-03-03 22:42:57.814779+03:30	44	Email object (44)	3		11	69
99	2022-03-03 22:42:57.815807+03:30	43	Email object (43)	3		11	69
100	2022-03-03 22:42:57.81678+03:30	42	Email object (42)	3		11	69
101	2022-03-03 22:42:57.81678+03:30	41	Email object (41)	3		11	69
102	2022-03-03 22:42:57.81678+03:30	40	Email object (40)	3		11	69
103	2022-03-03 22:42:57.817778+03:30	39	Email object (39)	3		11	69
104	2022-03-03 22:42:57.817778+03:30	38	Email object (38)	3		11	69
105	2022-03-03 22:42:57.81878+03:30	37	Email object (37)	3		11	69
106	2022-03-03 22:42:57.81878+03:30	36	Email object (36)	3		11	69
107	2022-03-03 22:42:57.81878+03:30	35	Email object (35)	3		11	69
108	2022-03-03 22:42:57.819779+03:30	33	Email object (33)	3		11	69
109	2022-03-03 22:42:57.819779+03:30	32	Email object (32)	3		11	69
110	2022-03-03 22:42:57.819779+03:30	31	Email object (31)	3		11	69
111	2022-03-03 22:42:57.820779+03:30	30	Email object (30)	3		11	69
112	2022-03-03 22:42:57.820779+03:30	29	Email object (29)	3		11	69
113	2022-03-03 22:42:57.820779+03:30	28	Email object (28)	3		11	69
114	2022-03-03 22:42:57.821781+03:30	27	Email object (27)	3		11	69
115	2022-03-03 22:42:57.821781+03:30	26	Email object (26)	3		11	69
116	2022-03-03 22:42:57.822784+03:30	25	Email object (25)	3		11	69
117	2022-03-03 22:42:57.823789+03:30	24	Email object (24)	3		11	69
118	2022-03-03 22:42:57.823789+03:30	23	Email object (23)	3		11	69
119	2022-03-03 22:42:57.82478+03:30	22	Email object (22)	3		11	69
120	2022-03-03 22:42:57.82478+03:30	21	Email object (21)	3		11	69
121	2022-03-03 22:42:57.82478+03:30	20	Email object (20)	3		11	69
122	2022-03-03 22:42:57.82578+03:30	19	Email object (19)	3		11	69
123	2022-03-03 22:42:57.82578+03:30	18	Email object (18)	3		11	69
124	2022-03-03 22:42:57.82578+03:30	17	Email object (17)	3		11	69
125	2022-03-03 22:42:57.826779+03:30	16	Email object (16)	3		11	69
126	2022-03-03 22:42:57.826779+03:30	15	Email object (15)	3		11	69
127	2022-03-03 22:42:57.826779+03:30	14	Email object (14)	3		11	69
128	2022-03-03 22:42:57.827849+03:30	12	Email object (12)	3		11	69
129	2022-03-03 22:42:57.828161+03:30	11	Email object (11)	3		11	69
130	2022-03-03 22:42:57.828161+03:30	10	Email object (10)	3		11	69
131	2022-03-03 22:42:57.829167+03:30	9	Email object (9)	3		11	69
132	2022-03-03 22:42:57.83023+03:30	8	Email object (8)	3		11	69
133	2022-03-03 22:42:57.831168+03:30	7	Email object (7)	3		11	69
134	2022-03-03 22:42:57.831168+03:30	6	Email object (6)	3		11	69
135	2022-03-03 22:42:57.831168+03:30	4	Email object (4)	3		11	69
136	2022-03-03 22:42:57.832169+03:30	2	Email object (2)	3		11	69
137	2022-03-03 22:42:57.832169+03:30	1	Email object (1)	3		11	69
138	2022-03-03 22:44:19.397032+03:30	74	Email object (74)	1	[{"added": {}}]	11	69
139	2022-03-03 22:45:07.694457+03:30	75	Email object (75)	1	[{"added": {}}]	11	69
140	2022-03-03 22:45:59.952396+03:30	76	Email object (76)	1	[{"added": {}}]	11	69
141	2022-03-03 22:59:44.546653+03:30	9	archive2	3		7	69
142	2022-03-03 22:59:44.548654+03:30	6	archive	3		7	69
143	2022-03-03 22:59:44.550651+03:30	5	family3	3		7	69
144	2022-03-03 22:59:44.551654+03:30	4	family2	3		7	69
145	2022-03-03 22:59:56.73359+03:30	2	Family	2	[{"changed": {"fields": ["Title", "Slug"]}}]	7	69
146	2022-03-03 23:00:22.418948+03:30	11	Uni	1	[{"added": {}}]	7	69
147	2022-03-04 09:59:53.735155+03:30	80	maktab	2	[{"changed": {"fields": ["Slug"]}}]	11	69
148	2022-03-04 10:08:13.670971+03:30	82	maktab	2	[{"changed": {"fields": ["File", "Slug"]}}]	11	69
149	2022-03-04 10:10:33.529304+03:30	72	Adele@gmail.com	1	[{"added": {}}]	6	69
150	2022-03-04 10:11:10.590943+03:30	17	alibaigi	1	[{"added": {}}]	10	69
151	2022-03-04 10:26:15.879934+03:30	83	alaki1	1	[{"added": {}}]	11	71
152	2022-03-04 10:26:59.70377+03:30	83	alaki1	2	[{"changed": {"fields": ["File"]}}]	11	71
153	2022-03-06 12:35:51.191647+03:30	67	wwwwwwwww	3		6	69
154	2022-03-06 12:35:51.195646+03:30	63	fateme	3		6	69
155	2022-03-06 12:35:51.196814+03:30	61	wwwwwwww	3		6	69
156	2022-03-06 12:35:51.197636+03:30	60	Mahdiye3222@gmail.com	3		6	69
157	2022-03-06 12:35:51.198643+03:30	59	Mahdiye32	3		6	69
158	2022-03-06 12:35:51.198643+03:30	58	ggggggggggww	3		6	69
159	2022-03-06 12:35:51.199643+03:30	57	gggggggggg	3		6	69
160	2022-03-06 12:35:51.200668+03:30	56	sssss	3		6	69
161	2022-03-06 12:35:51.200668+03:30	55	eeeeeeeeeeeeeeeeeee	3		6	69
162	2022-03-06 12:35:51.202648+03:30	54	eeeeeeeeeeeeeeeee	3		6	69
163	2022-03-06 12:35:51.204642+03:30	53	sadaf222	3		6	69
164	2022-03-06 12:35:51.205642+03:30	52	sadaf	3		6	69
165	2022-03-06 12:35:51.205642+03:30	51	gholiiiiiii	3		6	69
166	2022-03-06 12:35:51.206644+03:30	50	gholi	3		6	69
167	2022-03-06 12:35:51.207646+03:30	49	gisha2	3		6	69
168	2022-03-06 12:35:51.208665+03:30	48	mhdiye	3		6	69
169	2022-03-06 12:35:51.209679+03:30	47	gisha	3		6	69
170	2022-03-07 11:40:11.076728+03:30	115	multi	3		11	69
171	2022-03-07 11:40:11.080728+03:30	114	bvbvbv	3		11	69
172	2022-03-07 11:40:11.081743+03:30	113	bvbvbv	3		11	69
173	2022-03-07 11:40:11.082729+03:30	112	bvbvbv	3		11	69
174	2022-03-07 11:40:11.083728+03:30	111	bvbvbv	3		11	69
175	2022-03-07 11:40:11.083728+03:30	110	bvbvbv	3		11	69
176	2022-03-07 11:40:11.08473+03:30	109	bvbvbv	3		11	69
177	2022-03-07 11:40:11.085728+03:30	108	pop	3		11	69
178	2022-03-07 11:40:11.086732+03:30	107	pop	3		11	69
179	2022-03-07 11:40:11.087729+03:30	106	-0987n	3		11	69
180	2022-03-07 11:40:11.087729+03:30	105	teset1268	3		11	69
181	2022-03-07 11:40:11.088728+03:30	104	teset123	3		11	69
182	2022-03-07 11:40:11.089729+03:30	103	ccccccccccccccc	3		11	69
183	2022-03-07 11:40:11.089729+03:30	102	bbb	3		11	69
184	2022-03-07 11:40:11.090728+03:30	101	ccc	3		11	69
185	2022-03-07 11:40:11.091729+03:30	100	vvn	3		11	69
186	2022-03-07 11:40:11.091729+03:30	99	''/'	3		11	69
188	2022-03-07 11:40:11.093733+03:30	97	svs	3		11	69
189	2022-03-07 11:40:11.094728+03:30	96	sss	3		11	69
190	2022-03-07 11:40:11.094728+03:30	95	vbv	3		11	69
191	2022-03-07 11:40:11.095728+03:30	94	testi	3		11	69
192	2022-03-07 11:40:11.095728+03:30	93	testi	3		11	69
193	2022-03-07 11:40:11.096729+03:30	92	ttttt	3		11	69
194	2022-03-07 11:40:11.096729+03:30	91	testi	3		11	69
195	2022-03-07 11:40:11.097728+03:30	90	testi	3		11	69
196	2022-03-07 11:40:11.097728+03:30	89	testi	3		11	69
197	2022-03-07 11:40:11.097728+03:30	88	alaki1	3		11	69
198	2022-03-07 11:40:11.098728+03:30	87	alaki1	3		11	69
199	2022-03-07 11:40:11.098728+03:30	86	replay...	3		11	69
200	2022-03-07 11:40:11.099729+03:30	85	replay...	3		11	69
201	2022-03-07 11:40:11.100732+03:30	84	replay...	3		11	69
202	2022-03-07 11:40:11.101728+03:30	83	alaki1	3		11	69
203	2022-03-07 11:40:11.102729+03:30	82	maktab	3		11	69
204	2022-03-07 11:40:11.102729+03:30	81	replay	3		11	69
205	2022-03-07 11:40:11.103733+03:30	80	maktab	3		11	69
206	2022-03-07 11:40:11.104732+03:30	76		3		11	69
207	2022-03-07 16:09:19.578934+03:30	79	email007	2	[{"changed": {"fields": ["Receiver cc", "Receiver bcc", "Slug"]}}]	11	1
208	2022-03-07 16:22:28.123838+03:30	78	email0006	2	[{"changed": {"fields": ["Slug", "Is trash"]}}]	11	1
209	2022-03-07 16:35:56.489675+03:30	79	email007	2	[{"changed": {"fields": ["Is starred"]}}]	11	1
210	2022-03-07 16:50:40.705835+03:30	78	email0006	2	[{"changed": {"fields": ["Is starred"]}}]	11	1
211	2022-03-07 16:55:36.984226+03:30	78	email0006	2	[{"changed": {"fields": ["Is trash"]}}]	11	1
212	2022-03-07 20:49:55.159351+03:30	15	sheikhhadi	2	[{"changed": {"fields": ["Slug", "User"]}}]	10	1
213	2022-03-08 12:04:17.905706+03:30	132	erdazf	3		11	69
214	2022-03-08 12:04:17.909712+03:30	131	fghergv	3		11	69
215	2022-03-08 12:04:17.910685+03:30	130	jfjfjfjfj	3		11	69
216	2022-03-08 12:04:17.911687+03:30	129	jfjfjfjfj	3		11	69
217	2022-03-08 12:04:17.912686+03:30	128	jfjfjfjfj	3		11	69
218	2022-03-08 12:04:17.913686+03:30	127	jfjfjfjfj	3		11	69
219	2022-03-08 12:04:17.913686+03:30	126	ttttttttttttttttttt	3		11	69
220	2022-03-08 12:04:17.914686+03:30	125	ttttttttttttttttttt	3		11	69
221	2022-03-08 12:04:17.915706+03:30	124	ttttttttttttttttttt	3		11	69
222	2022-03-08 12:04:17.916705+03:30	123	vvvvvvvvvvvvvv	3		11	69
223	2022-03-08 12:04:17.916705+03:30	122	ddddd	3		11	69
224	2022-03-08 12:04:17.917703+03:30	121	salamtest	3		11	69
225	2022-03-08 12:04:17.918703+03:30	120	salamtest	3		11	69
226	2022-03-08 12:04:17.919706+03:30	119	hi	3		11	69
227	2022-03-08 12:04:17.919706+03:30	118	hi	3		11	69
228	2022-03-08 12:04:17.921721+03:30	117	hi	3		11	69
229	2022-03-08 12:04:17.922685+03:30	116	testmail	3		11	69
230	2022-03-08 18:57:16.656723+03:30	11	Uni	2	[{"changed": {"fields": ["User"]}}]	7	69
231	2022-03-08 22:50:56.610806+03:30	146	yyyyyyyyyyyy	3		11	1
232	2022-03-08 22:50:56.612855+03:30	145	ffffff	3		11	1
233	2022-03-08 22:50:56.613832+03:30	144	ffffff	3		11	1
234	2022-03-08 22:50:56.614836+03:30	143	ffffff	3		11	1
235	2022-03-08 22:50:56.615845+03:30	142	testiii	3		11	1
236	2022-03-08 22:50:56.616836+03:30	141	testiii	3		11	1
237	2022-03-08 22:50:56.617837+03:30	140	fffffffffffffffffffffff	3		11	1
238	2022-03-08 22:50:56.617837+03:30	139	fffffffffffffffffffffff	3		11	1
239	2022-03-08 22:50:56.618836+03:30	138	sssssssssssssssssssssssssssssss	3		11	1
240	2022-03-08 22:50:56.619859+03:30	137	gggggggggggggggggggggggg	3		11	1
241	2022-03-08 22:50:56.619859+03:30	136	ffffffffffff	3		11	1
242	2022-03-08 22:50:56.620836+03:30	135	ddddddd	3		11	1
243	2022-03-08 22:50:56.621835+03:30	134	mcccccccccccccccccc	3		11	1
244	2022-03-08 22:50:56.621835+03:30	133	kfkf	3		11	1
245	2022-03-09 18:57:06.024875+03:30	78	email0006	2	[{"changed": {"fields": ["Receiver bcc"]}}]	11	1
246	2022-03-09 18:57:16.151997+03:30	74	emai001	2	[{"changed": {"fields": ["Receiver cc"]}}]	11	1
247	2022-03-09 19:01:44.246409+03:30	2	Family	2	[{"changed": {"fields": ["User"]}}]	7	1
248	2022-03-09 19:01:50.477676+03:30	1	Archived	2	[{"changed": {"fields": ["User"]}}]	7	1
249	2022-03-09 22:00:56.798582+03:30	157	test	3		11	1
250	2022-03-09 22:00:56.80057+03:30	156	test	3		11	1
251	2022-03-09 22:00:56.80206+03:30	155	test	3		11	1
252	2022-03-09 22:00:56.80206+03:30	153	email009	3		11	1
253	2022-03-09 22:00:56.80307+03:30	152	email009	3		11	1
254	2022-03-09 22:01:18.299081+03:30	151	email0006	3		11	1
255	2022-03-09 22:01:18.301087+03:30	150	email0006	3		11	1
256	2022-03-09 22:01:18.302123+03:30	149	email0006	3		11	1
257	2022-03-09 22:01:18.303127+03:30	78	email0006	3		11	1
258	2022-03-09 22:01:29.016448+03:30	148	email009	3		11	1
259	2022-03-09 22:04:00.90547+03:30	147	email008	2	[{"changed": {"fields": ["Receiver to", "Slug"]}}]	11	1
260	2022-03-10 00:19:42.181367+03:30	14	exporti2	3		7	1
261	2022-03-10 00:19:52.519352+03:30	2	Family	2	[{"changed": {"fields": ["User"]}}]	7	1
262	2022-03-10 00:37:08.864312+03:30	2	Signature object (2)	2	[{"changed": {"fields": ["User"]}}]	9	1
263	2022-03-13 17:42:56.202487+03:30	163	sss	3		11	1
264	2022-03-13 17:42:56.208501+03:30	162	s	3		11	1
265	2022-03-13 17:42:56.210244+03:30	161	file	3		11	1
266	2022-03-13 17:42:56.210244+03:30	160	phase2	3		11	1
267	2022-03-13 17:42:56.211252+03:30	159	rep	3		11	1
268	2022-03-14 18:32:39.801167+03:30	188	eliiiiiiiiiiiiiiiiiii -> 2022-03-13 20:25:15.515388+00:00	3		11	1
269	2022-03-14 18:32:39.807926+03:30	187	┘¥█îÏº┘à Ï¿┘ç Ïº┘ä┘åÏºÏ▓ -> 2022-03-13 20:07:31.345294+00:00	3		11	1
270	2022-03-14 18:32:39.807926+03:30	186	from to zahra -> 2022-03-13 19:49:44.213386+00:00	3		11	1
271	2022-03-14 18:32:39.808926+03:30	185	pm to elnaz -> 2022-03-13 19:45:22.069190+00:00	3		11	1
272	2022-03-14 18:32:39.809929+03:30	184	elnaz -> 2022-03-13 19:30:22.302366+00:00	3		11	1
273	2022-03-14 18:32:39.809929+03:30	183	fromzahra2 -> 2022-03-13 19:15:29.567237+00:00	3		11	1
274	2022-03-14 18:32:39.810926+03:30	181	pop -> 2022-03-13 19:03:16.881949+00:00	3		11	1
275	2022-03-14 18:32:39.810926+03:30	180	404 -> 2022-03-13 18:48:29.577088+00:00	3		11	1
276	2022-03-14 18:32:39.811927+03:30	179	asdf -> 2022-03-13 17:52:00.705131+00:00	3		11	1
277	2022-03-14 18:32:39.812926+03:30	178	///// -> 2022-03-13 17:21:47.043304+00:00	3		11	1
278	2022-03-14 18:32:39.812926+03:30	177	uuui -> 2022-03-13 16:39:09.722238+00:00	3		11	1
279	2022-03-14 18:32:39.813925+03:30	176	dsdsds -> 2022-03-13 16:32:09.339052+00:00	3		11	1
378	2022-03-17 22:47:23.500246+03:30	2	Filter object (2)	3		12	1
280	2022-03-14 18:32:39.813925+03:30	175	hi -> 2022-03-13 16:29:38.435020+00:00	3		11	1
281	2022-03-14 18:32:39.814926+03:30	174	odod -> 2022-03-13 15:45:41.026747+00:00	3		11	1
282	2022-03-14 18:32:39.814926+03:30	173	;;; -> 2022-03-13 15:44:47.025076+00:00	3		11	1
283	2022-03-14 18:32:39.815927+03:30	172	slam -> 2022-03-13 15:33:07.327102+00:00	3		11	1
284	2022-03-14 18:32:39.815927+03:30	171	eli -> 2022-03-13 15:19:58.420033+00:00	3		11	1
285	2022-03-14 18:32:39.816927+03:30	170	hhhhhhhhh -> 2022-03-13 15:18:49.084758+00:00	3		11	1
286	2022-03-14 18:32:39.816927+03:30	169	fff -> 2022-03-13 14:34:06.595334+00:00	3		11	1
287	2022-03-14 18:32:39.817926+03:30	168	ggggggggggg -> 2022-03-13 14:32:16.724687+00:00	3		11	1
288	2022-03-14 18:32:39.818424+03:30	167	message -> 2022-03-13 14:29:13.706869+00:00	3		11	1
289	2022-03-14 18:32:39.818792+03:30	166	wwwwwwwwwwww -> 2022-03-13 14:27:35.975318+00:00	3		11	1
290	2022-03-14 18:32:39.819253+03:30	165	vc -> 2022-03-13 14:17:38.032887+00:00	3		11	1
291	2022-03-14 18:32:39.819253+03:30	164	message -> 2022-03-13 14:14:17.964519+00:00	3		11	1
292	2022-03-16 10:32:05.239107+03:30	4	EmailFolder object (4)	2	[{"changed": {"fields": ["Is draft"]}}]	13	1
293	2022-03-16 10:34:39.261821+03:30	1	EmailFolder object (1)	2	[]	13	1
294	2022-03-16 12:22:29.479922+03:30	4	neda	3		9	1
295	2022-03-17 19:05:26.649676+03:30	238	098746	3		11	1
296	2022-03-17 19:05:26.654028+03:30	237	098746	3		11	1
297	2022-03-17 19:05:26.655045+03:30	236	check	3		11	1
298	2022-03-17 19:05:26.656044+03:30	235	be elnaz	3		11	1
299	2022-03-17 19:05:26.656044+03:30	234	film	3		11	1
300	2022-03-17 19:05:26.657046+03:30	233	emptyyyy	3		11	1
301	2022-03-17 19:05:26.658044+03:30	232	empty to	3		11	1
302	2022-03-17 19:05:26.658044+03:30	231	()	3		11	1
303	2022-03-17 19:05:26.658044+03:30	229	null	3		11	1
304	2022-03-17 19:05:26.659045+03:30	228	sign_ff	3		11	1
305	2022-03-17 19:05:26.659045+03:30	227	None	3		11	1
306	2022-03-17 19:05:26.660047+03:30	226	57	3		11	1
307	2022-03-17 19:05:26.660047+03:30	225	trash	3		11	1
308	2022-03-17 19:05:26.661044+03:30	224	trash	3		11	1
309	2022-03-17 19:05:26.661044+03:30	223	trash	3		11	1
310	2022-03-17 19:05:26.662044+03:30	222	trash	3		11	1
311	2022-03-17 19:05:26.662044+03:30	221	trash	3		11	1
312	2022-03-17 19:05:26.663049+03:30	220	trash	3		11	1
313	2022-03-17 19:05:26.663049+03:30	219	trash	3		11	1
314	2022-03-17 19:05:26.664044+03:30	218	trash	3		11	1
315	2022-03-17 19:05:26.664044+03:30	217	trash	3		11	1
316	2022-03-17 19:05:26.665045+03:30	216	trash	3		11	1
317	2022-03-17 19:05:26.665045+03:30	215	new	3		11	1
318	2022-03-17 19:05:26.665045+03:30	214	trash	3		11	1
319	2022-03-17 19:05:26.666044+03:30	213	op	3		11	1
320	2022-03-17 19:05:26.666044+03:30	212	khoda2	3		11	1
321	2022-03-17 19:05:26.666044+03:30	211	Ï«Ï»Ïº	3		11	1
322	2022-03-17 19:05:26.667046+03:30	209	test	3		11	1
323	2022-03-17 19:05:26.667046+03:30	208	mahdi	3		11	1
324	2022-03-17 19:05:26.667046+03:30	207	tina	3		11	1
325	2022-03-17 19:05:26.668044+03:30	206	+-+-	3		11	1
326	2022-03-17 19:05:26.668044+03:30	205	++++	3		11	1
327	2022-03-17 19:05:26.668044+03:30	204	newmail	3		11	1
328	2022-03-17 19:05:26.669044+03:30	203	new	3		11	1
329	2022-03-17 19:05:26.669044+03:30	202	Ïº█î┘à█î┘ä Ïº┘ê┘ä	3		11	1
330	2022-03-17 19:05:26.670045+03:30	201	fdf	3		11	1
331	2022-03-17 19:05:26.670045+03:30	200	12345	3		11	1
332	2022-03-17 19:05:26.671044+03:30	199	78964	3		11	1
333	2022-03-17 19:05:26.671044+03:30	198	123	3		11	1
334	2022-03-17 19:05:26.671044+03:30	196	vvvv	3		11	1
335	2022-03-17 19:05:26.672043+03:30	195	ok	3		11	1
336	2022-03-17 19:05:26.672043+03:30	194	vcv	3		11	1
337	2022-03-17 19:05:26.672043+03:30	192	ddddddddddddd	3		11	1
338	2022-03-17 19:05:26.673043+03:30	191	zahraaaaaaaaa	3		11	1
339	2022-03-17 19:05:26.673043+03:30	189	fromzahra	3		11	1
340	2022-03-17 19:05:26.673043+03:30	182	fromzahra	3		11	1
341	2022-03-17 19:05:26.674044+03:30	158	email008	3		11	1
342	2022-03-17 19:05:26.674335+03:30	154	email009	3		11	1
343	2022-03-17 19:05:26.674335+03:30	147	email008	3		11	1
344	2022-03-17 19:05:26.675345+03:30	79	email007	3		11	1
345	2022-03-17 19:05:26.675345+03:30	77	email004	3		11	1
346	2022-03-17 19:05:26.676342+03:30	75	emai002	3		11	1
347	2022-03-17 19:05:26.676342+03:30	74	emai001	3		11	1
348	2022-03-17 22:47:23.479081+03:30	32	Filter object (32)	3		12	1
349	2022-03-17 22:47:23.481083+03:30	31	Filter object (31)	3		12	1
350	2022-03-17 22:47:23.482056+03:30	30	Filter object (30)	3		12	1
351	2022-03-17 22:47:23.483056+03:30	29	Filter object (29)	3		12	1
352	2022-03-17 22:47:23.484057+03:30	28	Filter object (28)	3		12	1
353	2022-03-17 22:47:23.485241+03:30	27	Filter object (27)	3		12	1
354	2022-03-17 22:47:23.486249+03:30	26	Filter object (26)	3		12	1
355	2022-03-17 22:47:23.486249+03:30	25	Filter object (25)	3		12	1
356	2022-03-17 22:47:23.487247+03:30	24	Filter object (24)	3		12	1
357	2022-03-17 22:47:23.488248+03:30	23	Filter object (23)	3		12	1
358	2022-03-17 22:47:23.488248+03:30	22	Filter object (22)	3		12	1
359	2022-03-17 22:47:23.489247+03:30	21	Filter object (21)	3		12	1
360	2022-03-17 22:47:23.490262+03:30	20	Filter object (20)	3		12	1
361	2022-03-17 22:47:23.491246+03:30	19	Filter object (19)	3		12	1
362	2022-03-17 22:47:23.492246+03:30	18	Filter object (18)	3		12	1
363	2022-03-17 22:47:23.492246+03:30	17	Filter object (17)	3		12	1
364	2022-03-17 22:47:23.493246+03:30	16	Filter object (16)	3		12	1
365	2022-03-17 22:47:23.493246+03:30	15	Filter object (15)	3		12	1
366	2022-03-17 22:47:23.494247+03:30	14	Filter object (14)	3		12	1
367	2022-03-17 22:47:23.494247+03:30	13	Filter object (13)	3		12	1
368	2022-03-17 22:47:23.495247+03:30	12	Filter object (12)	3		12	1
369	2022-03-17 22:47:23.495247+03:30	11	Filter object (11)	3		12	1
370	2022-03-17 22:47:23.496247+03:30	10	Filter object (10)	3		12	1
371	2022-03-17 22:47:23.496247+03:30	9	Filter object (9)	3		12	1
372	2022-03-17 22:47:23.497286+03:30	8	Filter object (8)	3		12	1
373	2022-03-17 22:47:23.498246+03:30	7	Filter object (7)	3		12	1
374	2022-03-17 22:47:23.498246+03:30	6	Filter object (6)	3		12	1
375	2022-03-17 22:47:23.499246+03:30	5	Filter object (5)	3		12	1
376	2022-03-17 22:47:23.499246+03:30	4	Filter object (4)	3		12	1
377	2022-03-17 22:47:23.500246+03:30	3	Filter object (3)	3		12	1
379	2022-03-17 22:47:23.501247+03:30	1	Filter object (1)	3		12	1
380	2022-03-17 22:49:36.35233+03:30	252	email002	3		11	1
381	2022-03-17 22:49:36.357325+03:30	251	­ƒÄÂ	3		11	1
382	2022-03-17 22:49:36.358321+03:30	250	Ô£ö	3		11	1
383	2022-03-17 22:49:36.359323+03:30	249	­ƒÄÂ	3		11	1
384	2022-03-17 22:49:36.360324+03:30	248	ok shod	3		11	1
385	2022-03-17 22:49:36.361325+03:30	247	test	3		11	1
386	2022-03-17 22:49:36.362222+03:30	246	replayemail	3		11	1
387	2022-03-17 22:49:36.36291+03:30	245	replayemail	3		11	1
388	2022-03-17 22:49:36.363275+03:30	244	email004	3		11	1
389	2022-03-17 22:49:36.364283+03:30	243	email003	3		11	1
390	2022-03-17 22:49:36.364283+03:30	242	email002	3		11	1
391	2022-03-17 22:49:36.365283+03:30	241	email002	3		11	1
392	2022-03-17 22:49:36.365283+03:30	240	email002	3		11	1
393	2022-03-17 22:49:36.366282+03:30	239	email001	3		11	1
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
12	web_page	filter
13	web_page	emailfolder
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
34	web_page	0006_auto_20220226_2221	2022-02-26 22:40:38.389408+03:30
35	web_page	0007_auto_20220301_2228	2022-03-01 22:28:34.446992+03:30
36	account	0002_alter_user_phone_number	2022-03-07 23:26:24.102485+03:30
37	web_page	0008_label_user	2022-03-07 23:26:24.132502+03:30
38	web_page	0009_auto_20220308_1828	2022-03-08 18:28:59.769069+03:30
39	web_page	0010_auto_20220308_2241	2022-03-08 22:42:00.819939+03:30
40	web_page	0011_auto_20220314_2256	2022-03-14 22:56:40.596189+03:30
41	web_page	0012_emailfolder	2022-03-16 10:09:47.341943+03:30
42	web_page	0013_filter_filter_by	2022-03-17 22:53:43.350319+03:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
cna8lso2cf6l51msuhydt1kk8ae5d7nu	.eJxVjDsOwjAUBO_iGln-xI6Xkj5nsJ7tBw6gRIqTCnF3iJQC2p2ZfYlI21rj1niJYxFn0Vtx-h0T5QdPOyl3mm6zzPO0LmOSuyIP2uQwF35eDvfvoFKr39ppcKctnM5dz2xgnLMBbNlbD4JDQmHF4drBgwMZZQKIoQyUV0a8P9yqNrk:1nUqin:0Ihs41CmCFzLTVnNYxqWiJ9S_iR7cxQBLla6TUweQls	2022-03-31 18:33:21.866589+04:30
3yyem4mgxe6dq6g1dvclpu1k3x7697j8	.eJxVjDsOwjAUBO_iGln-xI6Xkj5nsJ7tBw6gRIqTCnF3iJQC2p2ZfYlI21rj1niJYxFn0Vtx-h0T5QdPOyl3mm6zzPO0LmOSuyIP2uQwF35eDvfvoFKr39ppcKctnM5dz2xgnLMBbNlbD4JDQmHF4drBgwMZZQKIoQyUV0a8P9yqNrk:1nTUmW:1_VzfrlyLH-T1037AgPDzB0e89kYYPxblOLQgsM43HM	2022-03-28 00:55:36.179786+04:30
6slv1c9khav2plycvg3sg5mejmorwf99	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nM7bH:tXVQT3y8a6zf0YbgC_ZNF4vEH579dVFpBoVylz5y9AY	2022-03-07 15:45:31.198001+03:30
yr6dftyt46omigdbhnfrzussrmtnmxdd	e30:1nMIOJ:EZVjGqic3s909Ccqkf1a-yETdOdQb-jFsj3W9ODikVQ	2022-03-08 03:16:51.225001+03:30
kdodnjdcbihx0st6giw65e0g7s2jvh3g	e30:1nRD9B:1Fij6h7z7Q-Mackg0SizluhiqU13bcackbInPj8MxxE	2022-03-21 16:41:33.521729+03:30
8lbif6l2h2spqetweydbtawfof7ggmu8	e30:1nRDCG:F1l_ATSx_95Wzy7XkIsxOGJjjDCN97EU8givgkIQS94	2022-03-21 16:44:44.25583+03:30
299x42ngofht1pf3l5oul3swlpzcpzl0	e30:1nRDDw:4WZrOiPGW7KIVmnN9TyXlZzanbwbY_WbMEZOz5MhEWY	2022-03-21 16:46:28.563113+03:30
v7c01g7ub57v291k2o18vc30pj8iwfkt	e30:1nRDFR:aaWPSMjMh6ztYbfqlECdVndHfXhN30zVI2dSXyS5CAk	2022-03-21 16:48:01.17986+03:30
1m3lzjs9j9b5uv09x3lj6dqbk3i4duvz	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nMmnd:4RCmHbrpVC9Or6q_l3W2UjvOhWs1IFiEHNL8_tmmIeI	2022-03-09 11:45:01.102421+03:30
bhtrz59dowgmwlqtx0huyfjpiyelw3i5	.eJxVjMsOwiAQRf-FtSHAIExduu83kGEYpGrapI-V8d-1SRe6veec-1KJtrWlbZE5DUVdlFWn3y0TP2TcQbnTeJs0T-M6D1nvij7oovupyPN6uH8HjZb2rV1HwoRnhA4Yo62hQvW5OgbTCXCIbFDIuozZAIiPPljvSrCCxiKo9wfihDdE:1nNFWt:Gf3Iu9Q3BThMXeg9RDX7JDrVxeeJMc_uxHZz8GJTIcA	2022-03-10 18:25:39.761166+03:30
ts8qwjq50p6hzvd81iz5zpssgq19h066	.eJxVjDsOwjAQBe_iGlm2418o6TmDtfbu4gBypDipEHeHSCmgfTPzXiLBtta0dVrShOIsghWn3zFDeVDbCd6h3WZZ5rYuU5a7Ig_a5XVGel4O9--gQq_f2pfBqBAd5hI9WyrECtli1tqEUQOh8Rk4uFg8BGuHyKxBRRdYm1FH8f4AIlQ4Rg:1nUtG1:3tCcAy8XNXrpHYwzfM2Jb-JLjSLN_-uOKEgvHqCyXH4	2022-03-31 21:15:49.119019+04:30
6p9mm2q1slxqhgj1mkn9fk7bmcxewcid	.eJxVjEEOwiAQRe_C2hAHBygu3XuGZmYAqRpISrsy3l2bdKHb_977LzXSupRx7Wkep6jOyjl1-B2Z5JHqRuKd6q1paXWZJ9abonfa9bXF9Lzs7t9BoV6-tc-WxBxzCJCcER8TZgqZHQiwMTwMQQgSAkT0TiJgQMNCmG1me0L1_gAkbjia:1nUwKx:cUKs4mkXU2vfAqw8V_qV4UHW3YI4NDzobWg2sDJ3Krk	2022-04-01 00:33:07.282034+04:30
v5ngp14urrzskpud7kg5cjm4zm50i9dj	.eJxVjDsOwjAQBe_iGlnG6y8lfc5g7XodHECOFCcV4u4QKQW0b2beSyTc1pq2XpY0sbgIF8TpdyTMj9J2wndst1nmua3LRHJX5EG7HGYuz-vh_h1U7PVbh2zAx8hnb7NH50wGch45-DFqDUzKoGXi0WUKCpQCBgKrtLEhWFbi_QEABjd-:1nOGTS:zMFpYGAI-rMdFnruVH9YqnJGmm7TcGYf3vCFqzv3B4g	2022-03-13 13:38:18.225042+03:30
\.


--
-- Data for Name: web_page_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email (id, subject, text, file, created, edited, is_starred, is_draft, is_trash, is_read, sign_id, slug, sender_id, email_obj_id) FROM stdin;
253	email001	email001		2022-03-17 23:33:30.196508+03:30	2022-03-17 23:33:30.196508+03:30	f	f	f	f	\N	\N	66	\N
254	email002			2022-03-17 23:37:53.83141+03:30	2022-03-17 23:37:53.83141+03:30	f	f	f	f	\N	\N	66	\N
255	email002			2022-03-17 23:43:17.334389+03:30	2022-03-17 23:43:17.334389+03:30	f	f	f	f	\N	\N	66	\N
256	email002			2022-03-17 23:48:11.403326+03:30	2022-03-17 23:48:11.403326+03:30	f	f	f	f	\N	\N	66	\N
257	salam mahdiye	salam mahdiye		2022-03-17 23:48:44.217257+03:30	2022-03-17 23:48:44.217257+03:30	f	f	f	f	\N	\N	66	\N
258	neda			2022-03-17 23:51:40.773326+03:30	2022-03-17 23:51:40.773326+03:30	f	f	f	f	\N	\N	66	\N
259	09193780946	09153780946		2022-03-17 23:59:42.071609+03:30	2022-03-17 23:59:42.071609+03:30	f	f	f	f	\N	\N	66	\N
\.


--
-- Data for Name: web_page_email_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_filter (id, email_id, filter_id) FROM stdin;
206	253	33
207	257	34
208	258	33
209	259	33
210	259	35
\.


--
-- Data for Name: web_page_email_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_label (id, email_id, label_id) FROM stdin;
\.


--
-- Data for Name: web_page_email_receiver_bcc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_receiver_bcc (id, email_id, user_id) FROM stdin;
\.


--
-- Data for Name: web_page_email_receiver_cc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_receiver_cc (id, email_id, user_id) FROM stdin;
88	259	73
\.


--
-- Data for Name: web_page_email_receiver_to; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_email_receiver_to (id, email_id, user_id) FROM stdin;
180	253	73
181	254	73
182	255	73
183	256	73
184	257	73
185	258	73
186	259	72
\.


--
-- Data for Name: web_page_emailfolder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_emailfolder (id, is_trash, is_archive, is_draft, email_id, user_id) FROM stdin;
77	f	f	f	253	66
78	f	f	f	253	73
79	f	f	f	254	66
80	f	f	f	255	66
81	f	f	f	256	66
82	f	f	f	256	73
83	f	f	f	257	66
84	f	f	f	257	73
85	f	f	f	258	66
86	f	f	f	258	73
87	f	f	f	259	66
88	f	f	f	259	72
89	f	f	f	259	73
\.


--
-- Data for Name: web_page_filter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_filter (id, title, owner_id, filter_by) FROM stdin;
33	neda	73	neda@gmail.com
34	mahdiye	73	mahdiye
35	irancell	73	0915
\.


--
-- Data for Name: web_page_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_label (id, title, slug, user_id) FROM stdin;
11	Uni	Uni	73
1	Archived	Archived	73
12	exporti	exporti	73
2	Family	Family	66
15	test1	test1	73
16	test2	test2	66
18	food	food	74
\.


--
-- Data for Name: web_page_profilecontact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_profilecontact (id, first_name, last_name, email, profile_photo, phone_number, birthday, slug, other_email, user_id) FROM stdin;
7	test	test	test@gmail.com		\N	\N	12q	\N	68
8	maryam	maryam	maryam@gmail.com		\N	\N	123w	\N	68
9	mahdiye	mahdiye	mahdiye@gmail.com		\N	\N	1234q	\N	69
10	neda	soltani	neda@gmail.com		\N	\N	53dgjj	\N	69
12	maryam2	sheikhhadi	maryam2@gmail.com		\N	\N	\N	\N	69
14	maryam2	sheikhhadi	maryam22@gmail.com		\N	\N	\N	\N	69
17	Adele	alibaigi	Adele@gmail.com		\N	\N	12346	\N	69
11	salari	salari	salar@gmail.com		\N	\N	dfgj	\N	69
18	mahdis	taghizade	fateme@gmail.com		\N	\N	\N	\N	75
19	Maryam	sheikhhadi	maryam@gmail.com		\N	\N	\N	\N	66
20	mahdiye	kaffash	kfashmhdyh@gmail.com		09337300980	\N	\N	\N	66
21	fateme	javadi	fateme@gmail.com		09337300980	\N	\N	\N	66
\.


--
-- Data for Name: web_page_signature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_page_signature (id, text, photo, user_id) FROM stdin;
1	hi		68
2	ok		68
3	test1		73
5	zahra		75
6	fatema		74
7	neda		66
\.


--
-- Name: account_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_groups_id_seq', 1, false);


--
-- Name: account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_id_seq', 75, true);


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 52, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 393, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 13, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 42, true);


--
-- Name: web_page_email_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_filter_id_seq', 210, true);


--
-- Name: web_page_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_id_seq', 259, true);


--
-- Name: web_page_email_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_label_id_seq', 54, true);


--
-- Name: web_page_email_receiver_bcc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_receiver_bcc_id_seq', 154, true);


--
-- Name: web_page_email_receiver_cc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_receiver_cc_id_seq', 88, true);


--
-- Name: web_page_email_receiver_to_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_email_receiver_to_id_seq', 186, true);


--
-- Name: web_page_emailfolder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_emailfolder_id_seq', 89, true);


--
-- Name: web_page_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_filter_id_seq', 35, true);


--
-- Name: web_page_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_label_id_seq', 18, true);


--
-- Name: web_page_profilecontact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_profilecontact_id_seq', 21, true);


--
-- Name: web_page_signature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.web_page_signature_id_seq', 7, true);


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
-- Name: web_page_email_filter web_page_email_filter_email_id_filter_id_65b94563_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_filter
    ADD CONSTRAINT web_page_email_filter_email_id_filter_id_65b94563_uniq UNIQUE (email_id, filter_id);


--
-- Name: web_page_email_filter web_page_email_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_filter
    ADD CONSTRAINT web_page_email_filter_pkey PRIMARY KEY (id);


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
-- Name: web_page_email_receiver_bcc web_page_email_receiver_bcc_email_id_user_id_2a63a655_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_bcc
    ADD CONSTRAINT web_page_email_receiver_bcc_email_id_user_id_2a63a655_uniq UNIQUE (email_id, user_id);


--
-- Name: web_page_email_receiver_bcc web_page_email_receiver_bcc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_bcc
    ADD CONSTRAINT web_page_email_receiver_bcc_pkey PRIMARY KEY (id);


--
-- Name: web_page_email_receiver_cc web_page_email_receiver_cc_email_id_user_id_344349bc_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_cc
    ADD CONSTRAINT web_page_email_receiver_cc_email_id_user_id_344349bc_uniq UNIQUE (email_id, user_id);


--
-- Name: web_page_email_receiver_cc web_page_email_receiver_cc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_cc
    ADD CONSTRAINT web_page_email_receiver_cc_pkey PRIMARY KEY (id);


--
-- Name: web_page_email_receiver_to web_page_email_receiver_to_email_id_user_id_f932b70f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_to
    ADD CONSTRAINT web_page_email_receiver_to_email_id_user_id_f932b70f_uniq UNIQUE (email_id, user_id);


--
-- Name: web_page_email_receiver_to web_page_email_receiver_to_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_to
    ADD CONSTRAINT web_page_email_receiver_to_pkey PRIMARY KEY (id);


--
-- Name: web_page_email web_page_email_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_slug_key UNIQUE (slug);


--
-- Name: web_page_emailfolder web_page_emailfolder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_emailfolder
    ADD CONSTRAINT web_page_emailfolder_pkey PRIMARY KEY (id);


--
-- Name: web_page_filter web_page_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_filter
    ADD CONSTRAINT web_page_filter_pkey PRIMARY KEY (id);


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
-- Name: web_page_profilecontact web_page_profilecontact_user_id_email_bd7a8339_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact
    ADD CONSTRAINT web_page_profilecontact_user_id_email_bd7a8339_uniq UNIQUE (user_id, email);


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
-- Name: web_page_email_email_obj_id_b5f2099e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_email_obj_id_b5f2099e ON public.web_page_email USING btree (email_obj_id);


--
-- Name: web_page_email_filter_email_id_703f72c1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_filter_email_id_703f72c1 ON public.web_page_email_filter USING btree (email_id);


--
-- Name: web_page_email_filter_filter_id_4236823d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_filter_filter_id_4236823d ON public.web_page_email_filter USING btree (filter_id);


--
-- Name: web_page_email_label_email_id_f603b8a1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_label_email_id_f603b8a1 ON public.web_page_email_label USING btree (email_id);


--
-- Name: web_page_email_label_label_id_30e8206a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_label_label_id_30e8206a ON public.web_page_email_label USING btree (label_id);


--
-- Name: web_page_email_receiver_bcc_email_id_abd1c275; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_bcc_email_id_abd1c275 ON public.web_page_email_receiver_bcc USING btree (email_id);


--
-- Name: web_page_email_receiver_bcc_user_id_c1f4f2f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_bcc_user_id_c1f4f2f5 ON public.web_page_email_receiver_bcc USING btree (user_id);


--
-- Name: web_page_email_receiver_cc_email_id_d565a55b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_cc_email_id_d565a55b ON public.web_page_email_receiver_cc USING btree (email_id);


--
-- Name: web_page_email_receiver_cc_user_id_cb766723; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_cc_user_id_cb766723 ON public.web_page_email_receiver_cc USING btree (user_id);


--
-- Name: web_page_email_receiver_to_email_id_7e095c68; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_to_email_id_7e095c68 ON public.web_page_email_receiver_to USING btree (email_id);


--
-- Name: web_page_email_receiver_to_user_id_5e974f99; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_email_receiver_to_user_id_5e974f99 ON public.web_page_email_receiver_to USING btree (user_id);


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
-- Name: web_page_emailfolder_email_id_f85f06f8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_emailfolder_email_id_f85f06f8 ON public.web_page_emailfolder USING btree (email_id);


--
-- Name: web_page_emailfolder_user_id_10d23faf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_emailfolder_user_id_10d23faf ON public.web_page_emailfolder USING btree (user_id);


--
-- Name: web_page_filter_owner_id_c3b89795; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_filter_owner_id_c3b89795 ON public.web_page_filter USING btree (owner_id);


--
-- Name: web_page_label_slug_213cefa7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_label_slug_213cefa7_like ON public.web_page_label USING btree (slug varchar_pattern_ops);


--
-- Name: web_page_label_user_id_8a5db429; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_label_user_id_8a5db429 ON public.web_page_label USING btree (user_id);


--
-- Name: web_page_profilecontact_slug_c9b957e3_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_profilecontact_slug_c9b957e3_like ON public.web_page_profilecontact USING btree (slug varchar_pattern_ops);


--
-- Name: web_page_profilecontact_user_id_db8890ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX web_page_profilecontact_user_id_db8890ab ON public.web_page_profilecontact USING btree (user_id);


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
-- Name: web_page_email web_page_email_email_obj_id_b5f2099e_fk_web_page_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email
    ADD CONSTRAINT web_page_email_email_obj_id_b5f2099e_fk_web_page_email_id FOREIGN KEY (email_obj_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_filter web_page_email_filter_email_id_703f72c1_fk_web_page_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_filter
    ADD CONSTRAINT web_page_email_filter_email_id_703f72c1_fk_web_page_email_id FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_filter web_page_email_filter_filter_id_4236823d_fk_web_page_filter_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_filter
    ADD CONSTRAINT web_page_email_filter_filter_id_4236823d_fk_web_page_filter_id FOREIGN KEY (filter_id) REFERENCES public.web_page_filter(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: web_page_email_receiver_to web_page_email_recei_email_id_7e095c68_fk_web_page_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_to
    ADD CONSTRAINT web_page_email_recei_email_id_7e095c68_fk_web_page_ FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver_bcc web_page_email_recei_email_id_abd1c275_fk_web_page_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_bcc
    ADD CONSTRAINT web_page_email_recei_email_id_abd1c275_fk_web_page_ FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver_cc web_page_email_recei_email_id_d565a55b_fk_web_page_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_cc
    ADD CONSTRAINT web_page_email_recei_email_id_d565a55b_fk_web_page_ FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver_bcc web_page_email_receiver_bcc_user_id_c1f4f2f5_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_bcc
    ADD CONSTRAINT web_page_email_receiver_bcc_user_id_c1f4f2f5_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver_cc web_page_email_receiver_cc_user_id_cb766723_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_cc
    ADD CONSTRAINT web_page_email_receiver_cc_user_id_cb766723_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_email_receiver_to web_page_email_receiver_to_user_id_5e974f99_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_email_receiver_to
    ADD CONSTRAINT web_page_email_receiver_to_user_id_5e974f99_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: web_page_emailfolder web_page_emailfolder_email_id_f85f06f8_fk_web_page_email_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_emailfolder
    ADD CONSTRAINT web_page_emailfolder_email_id_f85f06f8_fk_web_page_email_id FOREIGN KEY (email_id) REFERENCES public.web_page_email(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_emailfolder web_page_emailfolder_user_id_10d23faf_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_emailfolder
    ADD CONSTRAINT web_page_emailfolder_user_id_10d23faf_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_filter web_page_filter_owner_id_c3b89795_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_filter
    ADD CONSTRAINT web_page_filter_owner_id_c3b89795_fk_account_user_id FOREIGN KEY (owner_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_label web_page_label_user_id_8a5db429_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_label
    ADD CONSTRAINT web_page_label_user_id_8a5db429_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_profilecontact web_page_profilecontact_user_id_db8890ab_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_profilecontact
    ADD CONSTRAINT web_page_profilecontact_user_id_db8890ab_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_page_signature web_page_signature_user_id_90813285_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_page_signature
    ADD CONSTRAINT web_page_signature_user_id_90813285_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

