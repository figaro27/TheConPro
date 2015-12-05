--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE account (
    id uuid NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    passwordtype bigint DEFAULT 0 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby character varying NOT NULL
);


ALTER TABLE account OWNER TO dbreader;

--
-- Name: accountrole; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE accountrole (
    id uuid NOT NULL,
    accountid uuid NOT NULL,
    role character varying(64) DEFAULT 'user'::character varying NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby character varying NOT NULL
);


ALTER TABLE accountrole OWNER TO dbreader;

--
-- Name: address; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE address (
    id uuid NOT NULL,
    personid uuid NOT NULL,
    address1 character varying(100) DEFAULT ''::character varying,
    address2 character varying(100) DEFAULT ''::character varying,
    city character varying(100) DEFAULT ''::character varying,
    state character varying(10) DEFAULT ''::character varying,
    zip character varying(10) DEFAULT ''::character varying,
    type character varying(20) NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    "primary" boolean DEFAULT false NOT NULL
);


ALTER TABLE address OWNER TO dbreader;

--
-- Name: addresstype; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE addresstype (
    addresstype character varying(10) NOT NULL
);


ALTER TABLE addresstype OWNER TO dbreader;

--
-- Name: color; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE color (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby character varying NOT NULL
);


ALTER TABLE color OWNER TO dbreader;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE countries (
    id character varying(10) NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE countries OWNER TO dbreader;

--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE ingredient (
    id uuid NOT NULL,
    name character varying(500) NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    coverage bigint DEFAULT 0 NOT NULL,
    purchaseprice numeric DEFAULT 0 NOT NULL
);


ALTER TABLE ingredient OWNER TO dbreader;

--
-- Name: ingredientcolor; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE ingredientcolor (
    id uuid NOT NULL,
    ingredientid uuid NOT NULL,
    colorid uuid NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE ingredientcolor OWNER TO dbreader;

--
-- Name: ingredientpattern; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE ingredientpattern (
    id uuid NOT NULL,
    ingredientid uuid NOT NULL,
    patternid uuid NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE ingredientpattern OWNER TO dbreader;

--
-- Name: lead; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE lead (
    id uuid NOT NULL,
    personid uuid NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE lead OWNER TO dbreader;

--
-- Name: COLUMN lead.personid; Type: COMMENT; Schema: public; Owner: dbreader
--

COMMENT ON COLUMN lead.personid IS 'PersonId - points to the person as a lead';


--
-- Name: leaddetail; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE leaddetail (
    id uuid NOT NULL,
    leadid uuid NOT NULL,
    email character varying(100),
    besttimetocall character varying(100),
    hearaboutus text,
    howcanwehelp text,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE leaddetail OWNER TO dbreader;

--
-- Name: COLUMN leaddetail.leadid; Type: COMMENT; Schema: public; Owner: dbreader
--

COMMENT ON COLUMN leaddetail.leadid IS 'This is the id from the person table as a lead is a type of person ';


--
-- Name: note; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE note (
    id uuid NOT NULL,
    fid uuid NOT NULL,
    body character varying(500) DEFAULT ''::character varying,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE note OWNER TO dbreader;

--
-- Name: pattern; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE pattern (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby character varying NOT NULL
);


ALTER TABLE pattern OWNER TO dbreader;

--
-- Name: person; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE person (
    id uuid NOT NULL,
    firstname character varying(100) DEFAULT ''::character varying,
    lastname character varying(100) DEFAULT ''::character varying,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    company character varying(250) DEFAULT ''::character varying
);


ALTER TABLE person OWNER TO dbreader;

--
-- Name: phone; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE phone (
    id uuid NOT NULL,
    personid uuid NOT NULL,
    number character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    "primary" boolean DEFAULT false NOT NULL
);


ALTER TABLE phone OWNER TO dbreader;

--
-- Name: phonetype; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE phonetype (
    phonetype character varying(10) NOT NULL
);


ALTER TABLE phonetype OWNER TO dbreader;

--
-- Name: project; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE project (
    id uuid NOT NULL,
    leadid uuid NOT NULL,
    install timestamp(6) with time zone,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    completed timestamp(6) with time zone,
    addressid uuid,
    removed boolean,
    designconsult timestamp(6) with time zone,
    projectstatus character varying(100) DEFAULT 'estimate'::character varying NOT NULL
);


ALTER TABLE project OWNER TO dbreader;

--
-- Name: projectdetail; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE projectdetail (
    id uuid NOT NULL,
    projectid uuid NOT NULL,
    systemid uuid,
    area double precision DEFAULT 0,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    name character varying(250) NOT NULL,
    systemsneeded double precision,
    arealength double precision,
    areawidth double precision,
    removed boolean,
    saleprice numeric DEFAULT 0 NOT NULL
);


ALTER TABLE projectdetail OWNER TO dbreader;

--
-- Name: projectdetailstyle; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE projectdetailstyle (
    id uuid NOT NULL,
    ingredientid uuid NOT NULL,
    projectdetailid uuid NOT NULL,
    colorid uuid,
    patternid uuid,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE projectdetailstyle OWNER TO dbreader;

--
-- Name: states; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE states (
    id character varying(10) NOT NULL,
    countryid character varying(10) NOT NULL,
    state character varying(50) NOT NULL
);


ALTER TABLE states OWNER TO dbreader;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE storage (
    id uuid NOT NULL,
    fid uuid NOT NULL,
    filename character varying(100) NOT NULL,
    contenttype character varying(100) NOT NULL,
    type character varying(100) NOT NULL,
    hash character varying(100) NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    container character varying(200) NOT NULL,
    size numeric DEFAULT 0 NOT NULL
);


ALTER TABLE storage OWNER TO dbreader;

--
-- Name: system; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE system (
    id uuid NOT NULL,
    name character varying(500) NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    status bigint NOT NULL,
    share boolean DEFAULT false NOT NULL,
    saleprice numeric DEFAULT 0 NOT NULL
);


ALTER TABLE system OWNER TO dbreader;

--
-- Name: systemdetail; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE systemdetail (
    id uuid NOT NULL,
    systemid uuid NOT NULL,
    ingredientid uuid NOT NULL,
    extra character varying(100) DEFAULT ''::character varying NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL,
    status bigint NOT NULL,
    factor bigint DEFAULT 1 NOT NULL,
    price numeric DEFAULT 0 NOT NULL
);


ALTER TABLE systemdetail OWNER TO dbreader;

--
-- Name: team; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE team (
    id uuid NOT NULL,
    name character varying(500) NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE team OWNER TO dbreader;

--
-- Name: teamdetail; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE teamdetail (
    id uuid NOT NULL,
    teamid uuid NOT NULL,
    personid uuid NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    status bigint NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE teamdetail OWNER TO dbreader;

--
-- Name: teamlead; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE teamlead (
    id uuid NOT NULL,
    teamid uuid NOT NULL,
    personid uuid NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE teamlead OWNER TO dbreader;

--
-- Name: teamsystem; Type: TABLE; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE TABLE teamsystem (
    id uuid NOT NULL,
    teamid uuid NOT NULL,
    systemid uuid NOT NULL,
    status bigint DEFAULT 1 NOT NULL,
    version bigint DEFAULT 0 NOT NULL,
    added timestamp(6) with time zone NOT NULL,
    addedby uuid NOT NULL,
    changed timestamp(6) with time zone NOT NULL,
    changedby uuid NOT NULL
);


ALTER TABLE teamsystem OWNER TO dbreader;

--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY account (id, username, password, passwordtype, version, status, added, addedby, changed, changedby) FROM stdin;
9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	flyflyerson2@gmail.com	$2a$10$z5h0b56gaH/vi1DS3ODnPu98BMZJLSGW1zST0tJ3k9XrkHondMR6u	0	1	1	2015-02-03 22:12:57.913-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	2015-02-03 22:12:58.334-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a
7ce708d8-63c0-4faf-bb52-8a645fc1a819	info@theconcreteprotector.com	$2a$10$2k6i7RonjRpA9zWHktYJyOLp.T0AfaK90dCkPvXUazzHIQzzo4mqC	0	1	1	2015-01-21 22:08:51.99-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-01-21 22:08:52.41-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819
b4a956c2-4dab-4eaa-9b2a-be679af1efe4	chappedbunz@gmail.com	$2a$10$NS6ZS.c5.KpAtcjfI4vILOgJuBJ0SoH.RHNfK28O8fXwOC6TIImFe	0	1	1	2015-02-04 06:26:41.059-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4	2015-02-04 06:26:41.472-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4
794d15d6-67d3-40b7-982c-17e4d81b73f9	concretepolishingservices@gmail.com	$2a$10$R/OSuVhJolVFI9y3KhHbyOQyQVeCom92.FL8W1ji.QVhDKijNinwO	0	1	1	2015-02-04 12:09:34.645-05	794d15d6-67d3-40b7-982c-17e4d81b73f9	2015-02-04 12:09:35.083-05	794d15d6-67d3-40b7-982c-17e4d81b73f9
06169b04-bb68-4868-b995-98388fa33e16	joe@theconcreteprotector.com	$2a$10$0cLbZaaTnDKqz.A6o893pe/0leUP1SbGQRPlFBPpUpbulBaCqwtdW	0	3	1	2015-01-21 11:20:39.55-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-04 23:29:49.078-05	06169b04-bb68-4868-b995-98388fa33e16
067b4635-5840-48fd-980d-ccddbe1b173d	bradyoder2011@gmail.com	$2a$10$zTRhVNqkBinEk3Zyw/Pu/uCCL2fIWgXZ2NrBuqBUltbIY.AE3bz7m	0	3	1	2015-02-08 18:48:56.231-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-20 12:22:00.542-04	067b4635-5840-48fd-980d-ccddbe1b173d
c1c09c37-9dad-4c77-860e-26a64bdedba2	1advancedepoxy@gmail.com	$2a$10$lkgLiOBUtJNDbWR8oFel.eMtPVam4KSrKN5GXmK.b.3RCH74t3WIu	0	1	1	2015-02-04 13:45:23.675-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-04 13:45:24.103-05	c1c09c37-9dad-4c77-860e-26a64bdedba2
61795214-a067-497f-8c4d-c307d5f658be	kerleys@yahoo.com	$2a$10$/ugfdZJH2zYdzzllXJb5P.R4K/NAnxpi1qnF2m97kzod4/0unFKqW	0	1	1	2015-02-04 13:51:42.256-05	61795214-a067-497f-8c4d-c307d5f658be	2015-02-04 13:51:55.056-05	61795214-a067-497f-8c4d-c307d5f658be
1676623f-4657-410f-87b6-db11cf461ba9	tbbates@gmail.com	$2a$10$FhaEg5X0n7dQNxivFqd2Z.GCjlVfbVtoNdnVGEnKGFTlGP7pIHCIq	0	9	1	2015-01-20 00:58:41.658-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-05-06 15:55:49.736-04	1676623f-4657-410f-87b6-db11cf461ba9
c605da3d-19d9-4a0e-9d42-a1d48d70196a	supremecrete@gmail.com	$2a$10$6iy3qkcaiOTnDrNtEu.LJeoAtwcwfCvJvYrxm0SNsQzoVckuZHnia	0	1	1	2015-01-29 23:28:03.12-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-29 23:28:03.598-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
556f727b-33ea-479e-b87d-b32c7a7099fc	andy@theconcreteprotector.com	$2a$10$ytUlG8Xf0mR/1CfUhywNuOu9OiMPKhXlFtMl0aEYcHVeibnreSyZi	0	1	1	2015-01-30 11:43:25.629-05	556f727b-33ea-479e-b87d-b32c7a7099fc	2015-01-30 11:43:26.062-05	556f727b-33ea-479e-b87d-b32c7a7099fc
dbc55b9a-354a-41ce-a527-2ad709c81b5f	info@natomis.com	$2a$10$CUNCBXtn6DZsMBiEwv//OuLwcFAlWsn9HC036.KFegVNAwYMPAPju	0	1	1	2015-02-02 22:01:49.682-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f	2015-02-02 22:01:50.125-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f
377be275-bf06-4325-9879-406db5290aba	jennartistic@yahoo.com	$2a$10$0..aHSo4gC3m4mkZTN4CJeK4aiN7Ik1En5MfxpL2dZEf2tEVzqswa	0	1	1	2015-02-02 23:43:58.637-05	377be275-bf06-4325-9879-406db5290aba	2015-02-02 23:43:59.049-05	377be275-bf06-4325-9879-406db5290aba
4398be50-e6ac-4662-8598-3783af2fa4f3	james.downing@theconcreteprotector.com	$2a$10$QuaNYvsfrnw8l9/ZPQPSZeuEbqelPFrKIVZ9YvHZ5E8BM3zbVbOaG	0	3	1	2015-02-03 09:49:36.398-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-08-12 09:17:08.825-04	4398be50-e6ac-4662-8598-3783af2fa4f3
1506ba01-68a5-426b-969b-3cd4541907de	tech1@sanitred.com	$2a$10$ACC44l9tNA8FNGV8fiuq1.5ESYSIHS5mv5VLA.JMCijydB0OokAau	0	1	1	2015-02-03 12:41:26.197-05	1506ba01-68a5-426b-969b-3cd4541907de	2015-02-03 12:41:26.603-05	1506ba01-68a5-426b-969b-3cd4541907de
04e30689-c615-4fac-9106-f07b4159c62e	kcartisticconcrete@yahoo.com	$2a$10$w8GvbZCT9YTEGjTU2ZlwKeAOObNlMJvpJrFFWCf3eGzK0PqBfChZ.	0	1	1	2015-02-03 17:16:28.402-05	04e30689-c615-4fac-9106-f07b4159c62e	2015-02-03 17:16:28.811-05	04e30689-c615-4fac-9106-f07b4159c62e
ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	decorativeconcretegretna@gmail.com	$2a$10$BQ//uE9/k2BUgjIsnIPmfenTUGbPLpFrpAEe6qU73Y4lM6hd67m9i	0	1	1	2015-02-04 13:54:25.44-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	2015-02-04 13:54:25.865-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4
d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	sepulvedajin@gmail.com	$2a$10$Xz7r.tHsqegojd/FehUjnO.LhcTfzIy3faOf1iNdOPWndft8EbWSe	0	1	1	2015-02-04 22:55:25.223-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	2015-02-04 22:55:25.772-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12
1aaaf421-b18d-49cb-b3a9-1926fe5b748b	alan@affordpaint.com	$2a$10$jSrSLc5bR2uz4lmFZsFkPuxKzZ1QZ.OwScyRzIFCJ0Knmg4gsVGPS	0	1	1	2015-02-05 10:59:19.006-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b	2015-02-05 10:59:19.465-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b
c2901ab1-bc1f-4d59-aa31-2472bb7447bb	rocksareus@gmail.com	$2a$10$2XKolecT20.Bxq158.6IGekH4FgtLHpYtyxc0sfzs0XHPbdadw3aO	0	1	1	2015-02-05 11:53:49.943-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb	2015-02-05 11:53:50.421-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb
eb430119-b551-4141-8db9-9c87ec182c62	robinson.ryan31@gmail.com	$2a$10$xIDbMZURom3tyoNPte9TUuClqtV2RNvHIoDeFwPbZulHTrJgee2R2	0	1	1	2015-02-05 12:07:40.727-05	eb430119-b551-4141-8db9-9c87ec182c62	2015-02-05 12:07:41.147-05	eb430119-b551-4141-8db9-9c87ec182c62
d8b25099-6e8f-404f-a634-491a5987bc62	info@cementsurfaces.com	$2a$10$0CzIEg8ZwdM4qdwYFPYOZu5CNmnsKAQCnuZCj1EMAUZwasaUq9as.	0	1	1	2015-02-05 12:58:22.88-05	d8b25099-6e8f-404f-a634-491a5987bc62	2015-02-05 12:58:23.332-05	d8b25099-6e8f-404f-a634-491a5987bc62
ae0fd311-08da-40a3-95be-380fa613de0e	chadweaver2@gmail.com	$2a$10$bB2.icUtGciW2J9WbqZz8uBWaVl9DW37nHfUXRhQoCZ2bB0JxtIXq	0	1	1	2015-02-05 13:14:46.388-05	ae0fd311-08da-40a3-95be-380fa613de0e	2015-02-05 13:14:46.816-05	ae0fd311-08da-40a3-95be-380fa613de0e
59502cc0-bd28-4746-9872-8950ad1570fd	smoothgrooveconcrete@gmail.com	$2a$10$muQlwrQNSyDO3rrbI.frcu0/nAkoHcuK1k2AP01CWUdG3tDBglSXy	0	1	1	2015-02-05 18:53:37.22-05	59502cc0-bd28-4746-9872-8950ad1570fd	2015-02-05 18:53:37.673-05	59502cc0-bd28-4746-9872-8950ad1570fd
e64f4e10-cb56-4b6f-897e-c6e25b2fb083	gatorstrengthconstruction@gmail. com	$2a$10$n3/iesGI0JqQ1ntYBdcsbu4gxpb06B6JHdDH93CE5UL.DbS9mCLaS	0	3	1	2015-02-05 21:32:55.469-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083	2015-02-28 23:41:51.58-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083
f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2tonyscontracting@gmail.com	$2a$10$XKmuG3hWyPcMYOrJmkQmGO994yH6B19AITEGh1SEXa9TmtezVI.5y	0	1	1	2015-02-06 16:38:26.995-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:38:27.441-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6
8053c776-d7a4-4d09-bd03-cbd95cff842d	proconcrete2013@gmail.com	$2a$10$Gd9kX6cuPcsP3WO/f6YpYu.t5m7uby2Z2ZOAalYmrYqRnpS7s9nZ.	0	1	1	2015-02-06 16:45:50.353-05	8053c776-d7a4-4d09-bd03-cbd95cff842d	2015-02-06 16:45:50.757-05	8053c776-d7a4-4d09-bd03-cbd95cff842d
45c5679e-8596-4758-86cf-ca40c4ee38ee	ryan.samford@elitecrete.com	$2a$10$mL7tiDvoJExtNyhlC/9TauJ7KH7Ug/S1nXCed0Ro7ilcF.JPMbJJW	0	1	1	2015-02-07 11:33:27.875-05	45c5679e-8596-4758-86cf-ca40c4ee38ee	2015-02-07 11:33:28.311-05	45c5679e-8596-4758-86cf-ca40c4ee38ee
592d90f2-3979-4806-aa2a-9c59814b22ee	spartandevelopments@gmail.com	$2a$10$yqBBuJFp6yS/AnqhldLVN.ch8oh3vrYHwDjXDDX6qlATJcJbU1kvi	0	1	1	2015-02-07 13:36:55.581-05	592d90f2-3979-4806-aa2a-9c59814b22ee	2015-02-07 13:36:55.982-05	592d90f2-3979-4806-aa2a-9c59814b22ee
f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	courtney@theconcreteprotector.com	$2a$10$AOLIVyZ45Uv5oYp07dNM4.SGQD766uI8O/rD.XaXVKzd7Y8BZNPjm	0	2	1	2015-01-29 14:14:59.792-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-05-04 13:27:58.196-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
4bd70027-faff-47f9-bcd6-f56ac2bd92f0	pccofcolumbus@gmail.com	$2a$10$j8iTJ4cGw5RYMifro/tIa.R093D/iLqB.tK2CQVaq/9qYl.UZWn9.	0	1	1	2015-02-08 21:02:05.192-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0	2015-02-08 21:02:05.62-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0
f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	rick@customconcretedesign.info	$2a$10$d8R8SOhahvMJkbB11G.WTOOYf2jcL.Ns4aobJ2sHtzYR515ky7Ddi	0	1	1	2015-02-10 09:46:30.672-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:46:31.089-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057
d86a76c4-4d99-4d16-b590-1df3c3122404	clearchoicecoatings@gmail.com	$2a$10$8snmoCBLVYpl6k.7ZwWC5uT4RS.nZg1RHUEhQcQ37IiTJ3AipoTGG	0	2	1	2015-02-05 12:24:30.001-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 14:52:52.692-05	d86a76c4-4d99-4d16-b590-1df3c3122404
0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	adam.my the concrete protector.com	$2a$10$qUGtNQfdSi2UJd5zBmGjRuH4rukS.rKAiaXTmunWp9brdtUZA.c7a	0	1	1	2015-02-10 10:52:44.476-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	2015-02-10 10:52:44.932-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1
964c0f18-ab25-41fe-b1b2-ad8db379d2cf	mddamon@hotmail.com	$2a$10$PekDhjQVSIi06e3cyd2fmukenTYtDxkWPtd7/tVdu8QwbdwyLeRUO	0	1	1	2015-02-10 17:00:33.732-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-10 17:00:34.192-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
d9a3aeff-b191-4b86-ac09-dd08fb239eae	flyflyerson3@gmail.com	$2a$10$pHm7Mg2Vd3ZWX6AD0bItHOhNmUj.FIgtQNoqAnVXXE9DzVq4vF62W	0	1	1	2015-02-11 11:27:46.803-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae	2015-02-11 11:27:47.237-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae
56428d0f-310c-4d39-85b5-62296d4a14ec	gavinalbright1983@gmail.com	$2a$10$O763NFoAVpVoGnOVoOQwMeaOsj8nh65jhyBW9mWsZ6AKrQU9lJsZK	0	1	1	2015-02-11 15:42:27.82-05	56428d0f-310c-4d39-85b5-62296d4a14ec	2015-02-11 15:42:28.237-05	56428d0f-310c-4d39-85b5-62296d4a14ec
769a920c-df49-4e06-9913-4d7a6d83f073	desj713@mac.com	$2a$10$c.MEhkBKgxO67wn0gt3MWOe5hs/FdAsCnjHhGmxd/DmhLriD2NNY6	0	1	1	2015-02-11 21:22:20.289-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-11 21:22:20.705-05	769a920c-df49-4e06-9913-4d7a6d83f073
9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	smithiv47@gmail.com	$2a$10$Yvs3s3Q1v4PyIx5eOHgPbuiw/NyQq6UGbg7dP294rhXymsQnbvG5i	0	1	1	2015-02-16 17:23:08.376-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	2015-02-16 17:23:08.829-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9
21ea39bb-285f-479e-8643-f9f963edd1a3	kerleya@yahoo.com	$2a$10$jV.Wt4DPVrPWkk3AswlsQecRFT6nprhXMXFSN1qCTdJrE5bqFzmrS	0	1	1	2015-02-16 18:07:17.596-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-16 18:07:18.088-05	21ea39bb-285f-479e-8643-f9f963edd1a3
be03f1e7-207c-4a6a-964f-ab6e7fb85ace	dprconcrete@gmail.com	$2a$10$l/0SGIOByybhhS/LGd3bp.hF1Das8ESVPOiuUPNouOkO4QX2bpsp.	0	1	1	2015-02-17 17:48:28.025-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace	2015-02-17 17:48:28.484-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace
0f68d399-eef2-466d-ab22-733bd2b2737e	danjdonohue@theconcreteprotector.com	$2a$10$tL90UO5BGVn2FLbNMYH2FeMdlhG6wGsixFHsnWxDo6gGm1K5OdtKO	0	1	1	2015-02-18 10:31:52.629-05	0f68d399-eef2-466d-ab22-733bd2b2737e	2015-02-18 10:31:53.152-05	0f68d399-eef2-466d-ab22-733bd2b2737e
45d94947-c576-453e-8e95-3fb0bdc538fc	mikestid5556@gmail.com	$2a$10$01dN8YFR81DSrLTKG5N0P.IkbPDgcgqxrUliK0PmtFq.GYLr8WQCu	0	1	1	2015-02-19 09:17:04.518-05	45d94947-c576-453e-8e95-3fb0bdc538fc	2015-02-19 09:17:05.039-05	45d94947-c576-453e-8e95-3fb0bdc538fc
e81db145-8364-495e-b45e-709987d0c0f7	sales@dynamicengravedconcrete.com	$2a$10$LCxl1UWYXwbMTb3N8a3liOu1GdiJDZ1mZvhz3X5CEcLwXcz.44xnS	0	1	1	2015-02-20 06:07:30.906-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-20 06:07:31.35-05	e81db145-8364-495e-b45e-709987d0c0f7
03c98a1a-8880-4d4e-9d7c-5d7440331ad0	jegofl@gmail.com	$2a$10$iYNlZhuioLGzHjYXPtIW2ezAt8tjuVepMG.m6ZW0Ylo85i6n7GicW	0	1	1	2015-02-20 11:23:16.323-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0	2015-02-20 11:23:16.744-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0
ff6f636c-57d8-4627-9133-509bb40f75ac	samgreenside@gmail.com	$2a$10$Kw.S71y3jtsSKe0VOoQTPujF.lIkzOOBX1Dnf6AQnBYAlPhst6tby	0	1	1	2015-02-20 16:12:47.259-05	ff6f636c-57d8-4627-9133-509bb40f75ac	2015-02-20 16:12:47.838-05	ff6f636c-57d8-4627-9133-509bb40f75ac
58254cba-f7c2-4939-9444-db0aafceea13	nick@coconcreterepair.com	$2a$10$OjvkEskA4ueWR/GdqKjvLO33SC38F9Sx/jZUqSAaUns5AJEVFIh/6	0	1	1	2015-02-20 19:28:04.27-05	58254cba-f7c2-4939-9444-db0aafceea13	2015-02-20 19:28:04.695-05	58254cba-f7c2-4939-9444-db0aafceea13
b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	chdherrick16@gmail.com	$2a$10$hyvVT7P8aGZT3RbmTIVKmuzTvFQmHftNAzQAh2azLyem8X4aHee6O	0	1	1	2015-02-20 20:26:21.147-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	2015-02-20 20:26:21.618-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96
ce456be6-d7c4-4fed-aab7-d3088f1b39b4	andypaulson167@gmail.com	$2a$10$r9QeN77iou8GIJDfZKfg.uiL45ZqjXf48bdBm.WOKw2ZeUsIDK4VW	0	1	1	2015-02-21 13:30:03.613-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4	2015-02-21 13:31:19.16-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4
bf294499-6877-4421-8fb5-a5a5a86c4bda	chad.moore@utoledo.edu	$2a$10$kNnU26Op4sncgHTuDYdjL.1xIZNMu.47hAesMyDC6pEU0w4jOTvpm	0	1	1	2015-02-21 23:08:48.765-05	bf294499-6877-4421-8fb5-a5a5a86c4bda	2015-02-21 23:08:49.188-05	bf294499-6877-4421-8fb5-a5a5a86c4bda
3aff8907-6c52-437a-9016-ef7243c3dbbd	bigstidham14@yahoo.com	$2a$10$0xmR6/5u1wAEuN3uL5P5RueUIC2X9HUEiJhaA2Oi7cJiiV3MTaIPa	0	1	1	2015-02-22 01:21:13.686-05	3aff8907-6c52-437a-9016-ef7243c3dbbd	2015-02-22 01:21:14.094-05	3aff8907-6c52-437a-9016-ef7243c3dbbd
dc91c128-7614-4592-b94e-c19660131a55	ricklafata@gmail.com	$2a$10$59susU2Bo5K.JRdYKq8waes5zB2DdJUJv4TR9QNM9sgoa5aaBE.jS	0	1	1	2015-02-23 13:41:01.827-05	dc91c128-7614-4592-b94e-c19660131a55	2015-02-23 13:41:02.273-05	dc91c128-7614-4592-b94e-c19660131a55
c27e733b-f247-498a-a945-7521cca65c3b	corey@redeckonwo.com	$2a$10$gMAd3Zl8k3zYrIlHdLiYzeMlREauu5mYjdHUBUwQN1WdD9hEzkVIK	0	1	1	2015-02-23 21:24:49.955-05	c27e733b-f247-498a-a945-7521cca65c3b	2015-02-23 21:24:50.415-05	c27e733b-f247-498a-a945-7521cca65c3b
6664d1b2-7618-401f-bde9-d8f5d1c7b757	lstroyer77@gmail.com	$2a$10$VNpNDVFUamXfVVXZsWycEu6iOswkBbznAkIYvIRNm6LZTrZ4lHRfO	0	1	1	2015-02-24 17:11:36-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-24 17:12:11.48-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
6c5725e7-5064-4126-a056-d36ad0efd1b7	jpasquarelli@rogers.com	$2a$10$1N.tYgscZz9my/8k0.01u.wcWj4eWqbPvIwOU5B2o3OeufFOxRq12	0	1	1	2015-02-25 00:09:34.904-05	6c5725e7-5064-4126-a056-d36ad0efd1b7	2015-02-25 00:09:35.352-05	6c5725e7-5064-4126-a056-d36ad0efd1b7
fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	azoldetyme@comcast.net	$2a$10$NfnLPRebjJ5IQPiNyyYgauRaWwRsic56wnjRCLQkh6muqD/F2DyNa	0	1	1	2015-02-25 10:22:16.719-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	2015-02-25 10:22:17.176-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72
03f15565-36da-4c06-a61f-ae401fc4722c	remveld1@gmail.com	$2a$10$81Y2oketjHXnZiZCCD.Oj.EPeUhHrzJ1ozu.FsoLhRqxXYGGCuRTu	0	1	1	2015-02-25 11:41:23.386-05	03f15565-36da-4c06-a61f-ae401fc4722c	2015-02-25 11:41:23.8-05	03f15565-36da-4c06-a61f-ae401fc4722c
a442335a-b15d-42e7-96bf-20de14fd1fd8	klkona@aol.com	$2a$10$ZMeUXrfOcynHsAVU9M8xeOiHw.MQR2nn0mprjAgDbUJdxhWD9Y9Ly	0	1	1	2015-02-26 23:57:57.142-05	a442335a-b15d-42e7-96bf-20de14fd1fd8	2015-02-26 23:57:57.615-05	a442335a-b15d-42e7-96bf-20de14fd1fd8
5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	judy@squeakycleanrestoration.com	$2a$10$SAE6EQy6C/1bX9QpghfRN.KMN1bvSMchhqmpynglz5rKBZX8Zi936	0	1	1	2015-03-02 18:03:42.568-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-02 18:03:43.008-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	terry@masterautomotive.ca	$2a$10$K24hXJzvZ7NR5bo/w1sTdOKORPr/wOkzLgCkevTJDmX2Cp6pvYYEm	0	1	1	2015-03-02 18:45:06.372-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	2015-03-02 18:45:06.809-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d
f43c207e-54b3-433d-a55c-a55521f818e4	boe@maximumfinish.com	$2a$10$M5LZ48z7mj0nDObVnBaHRO2gCbp3qe6UKOlFecB6OQebQg1L2iEse	0	1	1	2015-03-07 09:11:39.995-05	f43c207e-54b3-433d-a55c-a55521f818e4	2015-03-07 09:11:40.5-05	f43c207e-54b3-433d-a55c-a55521f818e4
8d13a8ee-d89c-483e-ae4b-6923185d5c0c	jared.360coatings@gmail.com	$2a$10$Cy.YFuL9hoduOIcLKDTl/.cQCoZwna1g6fLSQLGEFHnjPKL40g.VS	0	3	1	2015-02-20 16:43:07.003-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-06 15:44:40.241-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
7642061f-8f03-462b-a50b-2c712fa4e952	darryl_jtspools@sbcglobal.net	$2a$10$SxmAiiFcmGTdCdBqkzZ9Vem3D9Lo/u/HLtfT3QK4nitC8k2dKe9P6	0	1	1	2015-03-07 12:51:39.915-05	7642061f-8f03-462b-a50b-2c712fa4e952	2015-03-07 12:51:40.421-05	7642061f-8f03-462b-a50b-2c712fa4e952
c35a84cb-0f2f-45e2-8ef8-0165189944c7	bpasswaiter@ymail.com	$2a$10$bCmUhsFUcBHMMwVy46HGSewdJaj8XX6HOQs1BTQF6ELfRn2TOjTna	0	1	1	2015-03-07 21:29:13.717-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-07 21:29:14.245-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7
1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	wisiibie3@gmail.com	$2a$10$gpCuL9mB2IuvcL7DKXBdWunzidyYBe09sqJujfurQqB7U6k7dlojG	0	1	1	2015-03-08 22:08:12.317-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	2015-03-08 22:08:12.785-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0
abe59033-dbbd-4bbc-92a4-93f395ba289c	russhalbert@yahoo.com	$2a$10$dnaC1na3jUltG6ExAO/K6utrDZUjsCqyekg6buCbuT7yNTaweJc52	0	1	1	2015-03-09 10:32:43.791-04	abe59033-dbbd-4bbc-92a4-93f395ba289c	2015-03-09 10:32:44.257-04	abe59033-dbbd-4bbc-92a4-93f395ba289c
f975c50a-beb9-4277-ba91-6505d1b37f59	elianapanagakos@gmail.com	$2a$10$z9bTxlzt07ktmTbBZFckQesTfN0pymegeVZK4WuQafvVghwjg/8Xe	0	4	1	2015-03-04 20:33:08.672-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-11-12 00:30:04.62-05	f975c50a-beb9-4277-ba91-6505d1b37f59
3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	ossie_4@yahoo.com	$2a$10$ijG4tiz6VXIwEDnJ0F/wQuzcKLw2dCjHD5wMo8CaMx0Rt4ojDpJEm	0	1	1	2015-03-09 22:11:55.118-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	2015-03-09 22:11:55.559-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe
1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	richard_26507@msn.com	$2a$10$d/B9r5wXOA1L9bmStM1k4umUk/s2ZWWcUZHCX.2Lx3/T1T/4piA5G	0	1	1	2015-03-11 21:39:38.351-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	2015-03-11 21:39:38.828-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb
31797590-b84e-43d8-b0f1-32a1bdc37131	dndcoatingsndsealing@gmail.com	$2a$10$BB/khcXh1fdKYzWh/ODUS.b3X.QDpsq74c2h0ZnfxH/SnmOZaGh.K	0	1	1	2015-03-12 16:09:38.471-04	31797590-b84e-43d8-b0f1-32a1bdc37131	2015-03-12 16:09:38.894-04	31797590-b84e-43d8-b0f1-32a1bdc37131
8550e1eb-fb9a-4574-b952-0fbad9725725	f.r.n.electricalhandyman@gmail.com	$2a$10$7SKFjxFjXhcWWXJrm/GnAOJvrZTDeUCnumVow8EqJP/5B.IfB5yPa	0	1	1	2015-04-01 12:36:30.267-04	8550e1eb-fb9a-4574-b952-0fbad9725725	2015-04-01 12:36:30.69-04	8550e1eb-fb9a-4574-b952-0fbad9725725
77b5b917-c79f-4954-bc1e-675e7d0fea9e	fidelhernandez91@yahoo.com	$2a$10$7Dz6EONC8S9uT8yOgfqHOeDiclOgGTy2tWDbEKDQ8OdH3F3W5vX0O	0	1	1	2015-03-17 21:55:21.941-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e	2015-03-17 21:55:22.418-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e
745bde7b-294a-4716-8d8a-29e79f3bc3d0	northcutt_luke@yahoo.com	$2a$10$/MRmYmcmddkMb9B0K5r9P.JaHfPHvJh3Idx7kC4RPS2Bovk/fcqum	0	1	1	2015-03-19 13:01:09.093-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0	2015-03-19 13:01:09.518-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0
6bdbf380-19f2-4749-adf3-c5e077387f81	dan.thomas84@yahoo.com	$2a$10$TbS1NwJoyKA2JlCc9UZgouhKEHs9o/jaMT3wmOMSidVQ82sXnf1qS	0	1	1	2015-03-19 13:52:29.907-04	6bdbf380-19f2-4749-adf3-c5e077387f81	2015-03-19 13:52:30.324-04	6bdbf380-19f2-4749-adf3-c5e077387f81
3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	dpasswaiter@indianaharley.com	$2a$10$YWVmM9tpzndNg3NqTu4D4u466y6ULGlI0bcDfSG1p0C5ruX1.KYDK	0	1	1	2015-03-19 13:56:35.27-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 13:56:35.685-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
dcaae353-6d1a-4933-b1ab-243d01d6ed34	2361 joshua drive	$2a$10$RiW/gmTcwU7ZmRF0sJuZyej8rTjQ7.rcGwQ4MWxCLcqjxvHt8qnJy	0	1	1	2015-03-19 14:00:22.834-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34	2015-03-19 14:00:23.231-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34
503a77c4-05d0-4a6d-b282-61284bdefdf8	gperry87@ymail.com	$2a$10$Z4oRWFwuc5bqRfnva500Zuks/lJ0IlHqFAG.Z6aIsu7H.tYn8pcnq	0	1	1	2015-03-19 17:15:25.055-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 17:15:25.492-04	503a77c4-05d0-4a6d-b282-61284bdefdf8
05dbb3b8-9caf-405e-ae5e-a6074822a169	dakota.e.dunn@gmail.com	$2a$10$zKRWfurYruxHusZY0tDgte.w4ZUk0ax5vKYoPuLrtxgo3IPyIga7G	0	1	1	2015-03-19 18:09:34.668-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-19 18:09:35.136-04	05dbb3b8-9caf-405e-ae5e-a6074822a169
1c8a8a08-87c5-4fc6-adde-a8aac73bba34	chrishartley@me.com	$2a$10$x7kPgZjL3WclhJtHqT955OXAzarsIE8igxIcLTGgNTn7NKhZUvf2.	0	1	1	2015-03-20 07:03:52.405-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34	2015-03-20 07:03:52.855-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34
fd0457a0-2d66-4a63-857b-21f224a14a47	jerin@zandersolutions.com	$2a$10$VDCe5zhi1D.XAENJKylMkuzlyrLe6/eYmHmlk7d93s66QcBT34ZaW	0	1	1	2015-03-20 11:30:19.519-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 11:30:19.937-04	fd0457a0-2d66-4a63-857b-21f224a14a47
5c54b12e-42e9-4222-9d43-04de05218061	closets_unlimited@yahoo.com	$2a$10$nvPYmKcYfg/FJtJz/VxxPOv47JQcFdqinh2kbTSDRJqVyXyo6jslK	0	1	1	2015-03-20 11:37:34.644-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:37:35.106-04	5c54b12e-42e9-4222-9d43-04de05218061
1e6a7ced-23ad-4369-b72f-9af65493972a	juantme40@yahoo.com	$2a$10$iImmSFIXmrmxLTuIAjbu3Oz66QKoO2OK49jcPlj15gOtuFpjfrfua	0	1	1	2015-03-20 11:41:01.232-04	1e6a7ced-23ad-4369-b72f-9af65493972a	2015-03-20 11:41:01.627-04	1e6a7ced-23ad-4369-b72f-9af65493972a
0d974cc6-045d-4ec5-a533-38ab0b8f115b	proguard12@comcast.net	$2a$10$IKxSn54nr1qPGlnHfg136urqv6NuFkHiAANTgtDcFhNYNRkMSJCQ2	0	1	1	2015-03-20 11:45:53.777-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 11:45:54.157-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b
9ef858fa-13d8-4152-aff7-28daea5a0842	yoi_ri@hotmail.com	$2a$10$cATA0jppxO0hKVImyXbc2ezhmjV1KtbDvBPgun7VK1xIyOkZKSUUu	0	1	1	2015-03-20 11:46:26.427-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-20 11:46:26.828-04	9ef858fa-13d8-4152-aff7-28daea5a0842
1e36b7cc-664c-4e8c-b778-39461c0cb4e6	global3darts@aol.com	$2a$10$Ry2CESiGJ0JP2bdh7ZgvEuNgSH1423hLv/5s9do.SFvDbw05u7Zcm	0	1	1	2015-03-20 11:58:01.613-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 11:58:02.006-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	pjvarganyi@gmail.com	$2a$10$i.ot8DwMkDxhsqRxTxTSxOU0otyy0CVdLuOUQRz2iEtGRPfGbNGAK	0	1	1	2015-03-20 11:58:41.391-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	2015-03-20 11:58:41.826-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a
84525335-0f50-4354-8dd8-f9fe584df21a	cheddieenterprises@gmail.com	$2a$10$VMauT15HZaqnV8iYEiofgetqxMbz2otkRqr5UgJXbEQiLPaYRXLKm	0	1	1	2015-03-20 19:26:48.773-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-03-20 19:28:07.498-04	84525335-0f50-4354-8dd8-f9fe584df21a
3d6c5760-1a2a-4920-b821-d5f986988941	robert.watson 50@yahoo. com	$2a$10$ZupTBM4A7SsYJyy7bZ1GleXfdwKgCzSPJhIrTFmtlN1J8B9ruIOsG	0	1	1	2015-03-21 09:45:55.84-04	3d6c5760-1a2a-4920-b821-d5f986988941	2015-03-21 09:45:56.324-04	3d6c5760-1a2a-4920-b821-d5f986988941
5d51d14d-0147-4816-8325-38dfe31eca50	acmatketa77@aol.com	$2a$10$QLsnCU41C21b2zhdJcAW2OX/1aacNIxWEFmOlwvbZ0sJJ4TkpD012	0	1	1	2015-03-24 14:51:36.131-04	5d51d14d-0147-4816-8325-38dfe31eca50	2015-03-24 14:51:36.587-04	5d51d14d-0147-4816-8325-38dfe31eca50
fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	gjkrogfuss@krogfuss.com	$2a$10$DL2YmcmQ4BeV2Mrs4NKytuB8JZDwLMh1AbwZuZZ6PgJK.JieAlGjy	0	1	1	2015-03-24 18:18:05.255-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	2015-03-24 18:18:05.663-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c
c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	shankarsorab@icloud.com	$2a$10$fp..9oPIip3WEPvSxndQs.i7W6cLOJ69pkQqLlb1uM5iI1k26UOXW	0	1	1	2015-03-25 12:16:15.065-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	2015-03-25 12:16:15.534-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b
fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	info@salikgroup.com	$2a$10$cl2vYVNEUrxHRgUqt5ZGK.b.aksEySD67IqY5XPvO.e0g5E5te0/q	0	1	1	2015-03-25 17:33:20.292-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	2015-03-25 17:33:20.745-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4
66274f2a-93f5-4977-932b-9e9df88f4eaf	newlooksolutionsllc@gmail.com	$2a$10$KHTLyjouLxX3RVOPbK/r8e1UhvvPZSCW0i8HdcgChvXpeFK0Nfc2m	0	1	1	2015-03-25 18:40:15.644-04	66274f2a-93f5-4977-932b-9e9df88f4eaf	2015-03-25 18:40:16.054-04	66274f2a-93f5-4977-932b-9e9df88f4eaf
c9585e20-20ab-4d6f-8fc6-e97a098be96f	dan_yoyo_1993@yahoo.com	$2a$10$BdFg1VBND3Uq2qJ1hJ0Tu.bb5sTJiPlcUynloYbEy5MWCcOOvX.0C	0	1	1	2015-03-27 07:16:41.058-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f	2015-03-27 07:16:41.477-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f
e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	gaddam.mannoj@gmail.com	$2a$10$cORhK1SXIrfLUDKXxM4HKeyBQdVyq0EbtNMtUiiaPOfYyAGkCg3CG	0	1	1	2015-03-27 12:54:16.03-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	2015-03-27 12:54:16.436-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c
d7bb1e62-fe40-4774-a432-03bd53510708	lovickx5@yahoo.com	$2a$10$gbJ4e1zWIFbttpDJd1BrB.5GrM1JJaImTfaGTp./d.DRonTF6yW4.	0	1	1	2015-03-28 20:42:16.89-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-03-28 20:42:17.32-04	d7bb1e62-fe40-4774-a432-03bd53510708
dfaf0205-40d2-495c-8197-cf0e0ec838b4	dan.clune@theconcreteprotector.com	$2a$10$LcxKmRPJhs61BUxlwAM0MOz4mJlDE2wHJDe5TPTWJLcnUzF0hZLyi	0	1	1	2015-03-30 17:57:06.246-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 17:57:06.705-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
7878e434-6854-422a-91aa-212f8b175aa3	diegorzmz@gmail.com	$2a$10$lyrPxGnB/awWLRPADmsn4.o97rEfOHRNG/olsO/OseMSI.iHkIou.	0	2	1	2015-03-14 20:44:16.324-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-31 09:59:32.89-04	7878e434-6854-422a-91aa-212f8b175aa3
2e7be263-d520-4063-b4f0-beeb99e67619	rimvydasbru@gmail.com	$2a$10$i0JN1LNq6OdDHOOpDDgYIOg3ZWD/4eCzPvO9mvF1MRpiDtaAXW7kC	0	1	1	2015-04-04 11:28:31.058-04	2e7be263-d520-4063-b4f0-beeb99e67619	2015-04-04 11:28:31.486-04	2e7be263-d520-4063-b4f0-beeb99e67619
78726cf5-db49-4766-a5fb-e4b230ba1db9	mountainscapes@q.com	$2a$10$JAgorYRV21Q80ByVSrpgc.G8h8QbVyXjQOgGqfQYAFJiY2CeNz00u	0	1	1	2015-04-04 14:09:35.253-04	78726cf5-db49-4766-a5fb-e4b230ba1db9	2015-04-04 14:09:35.666-04	78726cf5-db49-4766-a5fb-e4b230ba1db9
c4546d68-3577-444e-8e24-918f627d42fd	eliana@qualityconcretedesignfl.com	$2a$10$b7Tdfad7qeUAKWoGL43Vs.mrWczmf6WyfQkxoSwah7ap1RS4Ipp4y	0	1	1	2015-04-10 00:29:21.381-04	c4546d68-3577-444e-8e24-918f627d42fd	2015-04-10 00:29:21.791-04	c4546d68-3577-444e-8e24-918f627d42fd
e5402660-9cee-48ef-9782-46756e22aad0	gstein@evsconcretedesigns.com	$2a$10$wRBdX0XGoM74fDza7/Vy2uQHvchezr7SdTyt84EqeDgrNyr.kjEgW	0	1	1	2015-04-11 09:49:21.068-04	e5402660-9cee-48ef-9782-46756e22aad0	2015-04-11 09:49:21.558-04	e5402660-9cee-48ef-9782-46756e22aad0
5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	ron@ctiofacadiana.com	$2a$10$opCedaZsn/EM32bgIWXBKOgBsMQqobCmimZgyFtxtScz7n5I21yti	0	1	1	2015-04-14 09:17:07.363-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 09:17:07.806-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
d2723b90-ebcd-4856-8e02-56b9983f130b	hvalant@icloud.com	$2a$10$gu7VhN3ZkgVNH6VLvcpQOePjLFMSWzhMv8hRwRV18b1zlsBEwPL9O	0	1	1	2015-04-15 17:34:35.035-04	d2723b90-ebcd-4856-8e02-56b9983f130b	2015-04-15 17:34:35.451-04	d2723b90-ebcd-4856-8e02-56b9983f130b
b2056c93-cb7d-470f-b9cb-f043cb5328a7	houstonsbr@gmail.com	$2a$10$I4tzJutpv0WgwsRTe5c3zupTCmtI.QXR7lzqTnYuHsBmSQG6pUD/S	0	1	1	2015-04-17 22:49:31.8-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7	2015-04-17 22:49:32.301-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7
cf0177ba-e1e1-4685-82fe-7432bd02fb98	buddy.ecs@gmail.com	$2a$10$Kcx.Atw.ZrpApKZ0VsSk6uh56NUDX9TQgD6YiEQX3ahtHQpLf86sW	0	1	1	2015-04-17 23:10:15.953-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	2015-04-17 23:10:16.42-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98
f4ff4de4-2322-447c-ae14-d1e9945c523f	sambat35@gmail.com	$2a$10$hlOY3yvkZr09lrTZvVtfPui7HESRmu.StkEjsTnQ5YMhi6f9zi78C	0	1	1	2015-04-18 02:15:16.029-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:15:16.5-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
41072458-fade-43dc-a1d8-543db6c37a49	marcshotblastepoxy@ yahoo.com	$2a$10$kuY8CXPhIy6jqFxykTmJoOgjtHT8yJiAVhX3zDEAUgjrlhKhf9RcC	0	1	1	2015-04-18 03:24:15.136-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:24:15.569-04	41072458-fade-43dc-a1d8-543db6c37a49
1e03402a-162a-4499-9691-233112668148	indunilchathu@hotmail.com	$2a$10$60pXi.m7Rgcrn8kG./k7ZODyff2TTBqjlP.h2ca1Mq.hfoBTVum.6	0	1	1	2015-04-18 09:58:57.269-04	1e03402a-162a-4499-9691-233112668148	2015-04-18 09:58:57.806-04	1e03402a-162a-4499-9691-233112668148
5614f192-f2bf-48d7-8912-f6ab1286bd7d	diamond_coatings@yahoo.com	$2a$10$Js2.m9kORyfZzl9uopjoZuTt3Kcatr2sySQksDWN6nkrJUGJgBXtC	0	1	1	2015-04-18 11:21:39.607-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:21:40.09-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d
5341f975-1bfb-4991-acd2-3c1b58ac1b30	wcc82inc@yahoo.com	$2a$10$2QMcLboNo1wHzCa//f2xuem0us2JFhQW5B0nkofq3csR6KMWfNJY.	0	1	1	2015-04-18 14:14:22.689-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30	2015-04-18 14:14:23.122-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30
263edbd8-24c6-488b-ad4b-76abc61b76ed	concretecraig5@gmail.com	$2a$10$SZ92Uw/pk2ZVZRPHKnRkseYLCo4mR1xpaR85Mb7MEALqcbQ9aJ.Ou	0	1	1	2015-04-19 08:20:02.279-04	263edbd8-24c6-488b-ad4b-76abc61b76ed	2015-04-19 08:20:02.757-04	263edbd8-24c6-488b-ad4b-76abc61b76ed
737398f9-28e7-4a98-bc58-442a6783a5fe	mark@epoxy2u.com	$2a$10$J1qVurVHVasnpsEB.coIsesODBzQlA2ly9ctakITc1omwpfiYGADu	0	1	1	2015-04-19 10:43:51.902-04	737398f9-28e7-4a98-bc58-442a6783a5fe	2015-04-19 10:43:52.441-04	737398f9-28e7-4a98-bc58-442a6783a5fe
ade5256e-c8d9-44f3-9714-262fafb8a475	concreterevolution.keefe@gmail.com	$2a$10$zETh7VORigR9Eh1Xjh1yp.8R4XVuJB7kJkS5bILubwlIoxtu412TW	0	1	1	2015-04-19 12:07:58.217-04	ade5256e-c8d9-44f3-9714-262fafb8a475	2015-04-19 12:07:58.664-04	ade5256e-c8d9-44f3-9714-262fafb8a475
c11cfe2d-a585-42e2-a570-08b850e9a894	edelgadillo@grupocsq.com	$2a$10$kHY2pajkk31NnFU9eVV5MuJ5O33tuNZ82Za7C7wStSZV7vou.fyeW	0	1	1	2015-05-05 18:26:07.234-04	c11cfe2d-a585-42e2-a570-08b850e9a894	2015-05-05 18:26:07.686-04	c11cfe2d-a585-42e2-a570-08b850e9a894
2c9df1e2-cb59-4f63-b854-241e044ece4d	theconcreteguy@roadrunner.com	$2a$10$fVPicAJipKv2zrJWjz0dUeXSxAWq9L3WyjPHQ/HhdFtHWyFEVY.J2	0	1	1	2015-04-25 14:48:00.617-04	2c9df1e2-cb59-4f63-b854-241e044ece4d	2015-04-25 14:48:01.048-04	2c9df1e2-cb59-4f63-b854-241e044ece4d
b6f4370a-2301-4810-9745-5b8a2deb728d	360coating.brad@gmail.com	$2a$10$8qjfhaCGlL6djFQuUZzrluETXQUdc8a5VO3ah6c6QoeVykA0uU8T2	0	1	1	2015-04-26 21:32:22.894-04	b6f4370a-2301-4810-9745-5b8a2deb728d	2015-04-26 21:32:23.343-04	b6f4370a-2301-4810-9745-5b8a2deb728d
bea77c25-d4c4-4821-b935-f4908ec9c0a4	lalampara56@hotmail.com	$2a$10$di0KzNqWL5sUQhLAXBZ4a.ArbAg7cCfWxlVAO.06ZYqVI3hEU8fEe	0	1	1	2015-04-27 20:12:25.618-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4	2015-04-27 20:12:26.085-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4
5a95c207-4d12-4712-a0dd-df4227795142	brucesize@gmail.com	$2a$10$5.Fnqr4s1hx3cDTTZX1rC.nEvEDU2E.LWnPAErjcta3q3BGYNJ36u	0	1	1	2015-04-28 06:28:46.474-04	5a95c207-4d12-4712-a0dd-df4227795142	2015-04-28 06:29:58.087-04	5a95c207-4d12-4712-a0dd-df4227795142
547b9e45-ff74-4626-a9b2-1df9b6001d84	olsenroofing@verizon.net	$2a$10$/4UobKCW5cHSnG2RMrvM4ebml9R/yNwkSZq.0Sk7At/.c.q5edyHS	0	3	1	2015-04-23 11:17:48.213-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 07:38:59.606-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
05ffe28f-ec37-4b04-b3f7-68aeb6cda998	bruno.theoret1@gmail.com	$2a$10$p76MDN8R0b6zJen5hc0NIePmzxI5owtKBCJCsLSWJg7qBn2.IX0GC	0	1	1	2015-04-29 09:14:30.694-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998	2015-04-29 09:14:31.119-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998
c276de4d-a087-4025-922b-73cabe491bd3	cccandlawn@gmail.com	$2a$10$9/F1KDBDDHYPKhNYIZPqn.SBA0s1krj3oI1JpYkOYEr1D0odU1xPq	0	1	1	2015-05-04 17:08:03.342-04	c276de4d-a087-4025-922b-73cabe491bd3	2015-05-04 17:08:03.76-04	c276de4d-a087-4025-922b-73cabe491bd3
ecaa82b2-d881-4d3a-8322-726a45e42c11	rbchris2934@gmail.com	$2a$10$YP3oiw8RGHDl9ILXtDEJheZkyDKVK5Th5OUFb0X35..ACo9X6qkDe	0	1	1	2015-05-05 07:51:56.856-04	ecaa82b2-d881-4d3a-8322-726a45e42c11	2015-05-05 07:51:57.297-04	ecaa82b2-d881-4d3a-8322-726a45e42c11
fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	christheconcreteprotector@yahoo.com	$2a$10$sRS3A2sfpuDweIbPb24aP.inuFQ5K1KZVKCQhFcK1aoJzsIu3MJpW	0	1	1	2015-05-08 11:17:09.09-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	2015-05-08 11:17:09.55-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429
1c996f95-6044-4110-8a19-eb1c2c40d597	relforddameer@yahoo.com	$2a$10$PTfAAa0eBn/CDrE50UXa1ef7NVKfTBuuKy/Vcov8HEw5M9X7z8Ov.	0	1	1	2015-05-08 14:40:54.539-04	1c996f95-6044-4110-8a19-eb1c2c40d597	2015-05-08 14:40:54.982-04	1c996f95-6044-4110-8a19-eb1c2c40d597
346ff4ec-5d01-464f-94a6-b282484b7d8b	j.lydon29@gmail.com	$2a$10$oeuM1Eg21THAoFqw4GLRoejHa9ASZqNdLP/UozMTaDP61Q1bjatXK	0	1	1	2015-05-11 11:55:04.807-04	346ff4ec-5d01-464f-94a6-b282484b7d8b	2015-05-11 11:55:05.248-04	346ff4ec-5d01-464f-94a6-b282484b7d8b
609ec79e-ea84-4c4a-abe1-67f4c38bbe92	jakemariano1124@yahoo.com	$2a$10$W8xdmelCs68/Knf0ssRcRO6eG1JoUY7YvzKzeEdyrFQbhSZmfP902	0	1	1	2015-05-11 21:33:12.839-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92	2015-05-11 21:33:13.288-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92
bcff8f11-ed0d-4a44-a96a-08a3c646d737	alan.batts@yahoo.com	$2a$10$ItVQQpAQKTq.U2/xSuVcneKmWIoyH0JYzImFcFhfPUeG5WNBOWtMi	0	1	1	2015-05-11 22:58:52.452-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737	2015-05-11 22:58:52.877-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737
4ed2745b-5397-4290-9e4b-971eea1e1359	mario.morales61@gmail.com	$2a$10$5igxo9GK50ALoZdX9lhnEO0PD8fPrYVQ5C88Trq3dUKmmfjrFx3nC	0	2	1	2015-04-30 21:03:20.991-04	4ed2745b-5397-4290-9e4b-971eea1e1359	2015-05-12 11:40:41.816-04	4ed2745b-5397-4290-9e4b-971eea1e1359
304f78a7-8428-415f-b526-1aa3326b6244	sconnolly@tycrop.com	$2a$10$Hq91.bBqXjABSSe5hMZwMuAPOcaVr40rZh74ZrQ/BjhjOy1pOIBDC	0	1	1	2015-05-14 12:00:02.538-04	304f78a7-8428-415f-b526-1aa3326b6244	2015-05-14 12:00:02.976-04	304f78a7-8428-415f-b526-1aa3326b6244
6da7d4f7-c747-4955-ab23-1b62554db9ce	hotcakes@msn.com	$2a$10$6AFWIkeByeZzxxsMyMRpU.Jc4G1M.kUS9CvEnkkjtYd8dwo3U1Ife	0	1	1	2015-05-14 17:11:40.301-04	6da7d4f7-c747-4955-ab23-1b62554db9ce	2015-05-14 17:11:40.757-04	6da7d4f7-c747-4955-ab23-1b62554db9ce
884721c6-aea2-4d0d-9d9d-6fa329d1f539	kyleddeckard@gmail.com	$2a$10$ORcJKlZ6XjfNMc3JGwJuv.penTW8xkuMGCmJEHzVxvKSYuSn7RJRu	0	1	1	2015-05-15 17:41:19.218-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539	2015-05-15 17:41:19.671-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539
c53ab4cb-e0be-4c86-86eb-46773c9551e0	acbanish97@hotmail.com	$2a$10$J3QxUK1SWKUgGUAMKfcbFujgrQuD9Rfbee2noRA8JrUHgI/BvO2Se	0	1	1	2015-05-16 14:44:40.66-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0	2015-05-16 14:44:41.137-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0
12034988-1c47-4bdd-b7ac-1751e04269ad	laytonsflooring@icloud.com	$2a$10$dd9dtUVIr0vR4k1iheycyeMD2JktchKSu8vjK.F6YnH8lSj2qnQfO	0	1	1	2015-05-18 21:57:43.732-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-18 21:57:44.189-04	12034988-1c47-4bdd-b7ac-1751e04269ad
350a236f-f780-40e9-85e3-2b9227f4d76f	info@reclaimmygarage.com	$2a$10$QO3GrM5AaRuN8n290UmGyeiT7eXnngtZIn4ecp9P5fj8p8MXb6Kg.	0	2	1	2015-05-02 18:10:04.753-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-06-20 18:29:33.947-04	350a236f-f780-40e9-85e3-2b9227f4d76f
7f13a571-83af-4b72-ae3f-5777badf0027	bg@powerfloorsolutions.com	$2a$10$HAxJhUA8owHkneIxwOrVTeaj7IPjkERG3u6wUCOVhYF3WfaEIGc.G	0	1	1	2015-05-21 20:33:39.802-04	7f13a571-83af-4b72-ae3f-5777badf0027	2015-05-21 20:33:40.21-04	7f13a571-83af-4b72-ae3f-5777badf0027
2a63f4b8-4436-45bf-9439-866ac59e1911	andyamyf@gmail.com	$2a$10$LFXUXL39UX3Zwx8M6cpJLOz/AmDG243fhYq.r7r0r.a.s8tZ4V1KK	0	1	1	2015-05-24 11:02:43.38-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-05-24 11:02:43.788-04	2a63f4b8-4436-45bf-9439-866ac59e1911
4023e17e-c332-4669-9dd5-63f796508059	timbabcock14@yahoo.com	$2a$10$NEAG6tUVJ7sQM2L7bA32ruqXE0h..m61t85Ks9FBB5jOxowhp8I12	0	1	1	2015-05-24 15:12:17.561-04	4023e17e-c332-4669-9dd5-63f796508059	2015-05-24 15:12:17.982-04	4023e17e-c332-4669-9dd5-63f796508059
464972d2-3955-40a6-abf5-5ada5cd9e4ea	davidwatruba@gmail.com	$2a$10$BAF7Cfxbr6FBka9YcdaxIeA80vIFc.MufSQFvw.YGp4q2Xxp8egb6	0	1	1	2015-05-26 10:08:16.317-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea	2015-05-26 10:08:16.786-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea
fb81d126-c102-4e37-a1d6-a709a5eb7d1a	kaydeejane17@gmail.com	$2a$10$Ykpfj6IqvF/vcdZD73Nqxu5gkOy/zTVzLNhhzEkdcfzMjRlUzlfRy	0	1	1	2015-05-27 00:18:45.109-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a	2015-05-27 00:18:45.647-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a
e70477ac-5ece-430d-9287-a92dd7cc190c	teetwocontracting@gmail.com	$2a$10$wkpm2lxwBemSOJx.BUIQ3OuxmrU2wMTiQNNYR.LL40lCDCpK334fG	0	1	1	2015-05-30 10:37:05.364-04	e70477ac-5ece-430d-9287-a92dd7cc190c	2015-05-30 10:37:05.856-04	e70477ac-5ece-430d-9287-a92dd7cc190c
5f96f064-10c1-4278-af7c-35b9e0df8728	jtkoschmider@gmail.com	$2a$10$5c6.R.ZSEBBz4K2qTyMcWuj91cb5ilDQaQYyOA/ata8e3k.5h9O7u	0	1	1	2015-06-05 11:56:04.825-04	5f96f064-10c1-4278-af7c-35b9e0df8728	2015-06-05 11:56:05.252-04	5f96f064-10c1-4278-af7c-35b9e0df8728
2d259e86-2515-4439-9ad9-8c97d751bc88	wichos64@yahoo. com	$2a$10$qZRp94ba72M2NMl0pIonK.WczSLcqHeCjBluf2QK2iAVZfniMgyPO	0	1	1	2015-06-13 22:51:15.121-04	2d259e86-2515-4439-9ad9-8c97d751bc88	2015-06-13 22:51:15.56-04	2d259e86-2515-4439-9ad9-8c97d751bc88
abc5acf5-6911-4a9d-b8ff-7f740a9267ba	alvaradovalentino52@gmail.com	$2a$10$I0OhN3tTnBv6emZvkAFRvuUCCDOmrRuviy0i7eIulYMcdww3v6HBy	0	1	1	2015-06-16 19:25:41.794-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba	2015-06-16 19:25:42.281-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba
da7076fb-15b5-4d73-8595-98dc8d53170c	steve.s@theconcreteprotector.com	$2a$10$OIGJ3oi8H8jiqMODezYLxOaxlNAje8qilvndnieUpY/03N.6evZv2	0	1	1	2015-06-25 08:02:51.031-04	da7076fb-15b5-4d73-8595-98dc8d53170c	2015-06-25 08:02:51.509-04	da7076fb-15b5-4d73-8595-98dc8d53170c
4f954bb7-744d-49ab-9990-7395720ae3ed	kathy@theconcreteprotector.com	$2a$10$P1JWbgO7VZsMKhq3FiaShuI7w5e5573Uj11GsGYVVZUVhPQCjrFwy	0	1	1	2015-06-25 08:06:17.109-04	4f954bb7-744d-49ab-9990-7395720ae3ed	2015-06-25 08:06:17.506-04	4f954bb7-744d-49ab-9990-7395720ae3ed
55b80699-7270-4cf1-a342-2d0c63684b02	alphiessaco@gmail.com	$2a$10$3y/Pc8P3FZv2YQ2zM0vxkOp9eVMnDyr/j.4xkKdKgLhQtnAmtxsk2	0	1	1	2015-06-25 18:36:19.126-04	55b80699-7270-4cf1-a342-2d0c63684b02	2015-06-25 18:36:19.556-04	55b80699-7270-4cf1-a342-2d0c63684b02
0a215950-e391-4575-8d45-e5c36c6cb723	tstinc@live.com	$2a$10$F5.euKq9x17.IFM5zF7yJ.6NGbIvwJIktPsvBcvkUrXOsCm9s2EOa	0	1	1	2015-06-26 14:22:19.862-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-06-26 14:22:20.356-04	0a215950-e391-4575-8d45-e5c36c6cb723
f1a9a130-48b6-4843-a5e3-d8c0403b9276	stevencfd20@yahoo.com	$2a$10$NstiksdZdRLcNGRiXYqpB.vPaEZa3VtQwe1rmM6t2.7s9Y403ZQiG	0	1	1	2015-06-29 16:10:51.977-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276	2015-06-29 16:10:52.487-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276
cc0c563b-880f-445d-8026-8265c2de2f88	jesweeney@charter.net	$2a$10$8cETPLGM92lmV0Yhps0p6e8MbrLt8QUhMlr6WzyKCNi81ahth6Qnm	0	1	1	2015-06-29 17:08:27.795-04	cc0c563b-880f-445d-8026-8265c2de2f88	2015-06-29 17:08:28.267-04	cc0c563b-880f-445d-8026-8265c2de2f88
85a17430-3568-44af-a520-175faaf6a9ee	michaelpuac@gmail.com	$2a$10$fbLnFI0Ail3KS2c2OUUm0eC/oS2bh1aPXZ8wPJNBxbHRt9O2hwJVq	0	1	1	2015-06-29 18:55:57.853-04	85a17430-3568-44af-a520-175faaf6a9ee	2015-06-29 18:55:58.259-04	85a17430-3568-44af-a520-175faaf6a9ee
536d9218-deaa-44fb-b9f2-7c81447ee863	checksepoxy@yahoo.com	$2a$10$JOFHXqUYuJDPjfEZVI7/nOZIPrq20ssV81vXPGRAR50l8Y0anICty	0	1	1	2015-07-01 21:42:35.012-04	536d9218-deaa-44fb-b9f2-7c81447ee863	2015-07-01 21:42:35.469-04	536d9218-deaa-44fb-b9f2-7c81447ee863
61709628-4bca-418f-8dc4-1ad358c785d6	dan@haverfordhomedesign.com	$2a$10$tO97u6c67XsdCusUys6WjetCybJLQo.ifFh92fIYso5U/jWcs38yO	0	1	1	2015-07-05 23:23:48.828-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:24:13.361-04	61709628-4bca-418f-8dc4-1ad358c785d6
73bc3ee0-49d2-4ff0-a456-0c42634b1c40	ksstainseal@gmail.com	$2a$10$NPeyKUkMcLaRcXJiMkiXoOMxs5pCpejHy03ZEdSfaIbnhYuHxiHay	0	1	1	2015-07-06 10:56:09.376-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40	2015-07-06 10:56:09.806-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40
5414f676-63e9-4117-87bd-ec5577e932b7	harrisonburgepoxy@gmail.com	$2a$10$WQ6u6Cx1KevDhpOexohz1e.eC.SFw9BUCtJ5upv2dvWeh9sjdEgzu	0	1	1	2015-07-13 08:14:53.384-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:14:53.795-04	5414f676-63e9-4117-87bd-ec5577e932b7
6c014dcf-e073-4d33-ad87-5b626c9bd967	richard_harman7@hotmail.com	$2a$10$z2haX7Ft8B1oHTtnwqdDrOqURfGS9rY4OmXD2QwG25opmufiN3saG	0	1	1	2015-07-14 10:41:30.671-04	6c014dcf-e073-4d33-ad87-5b626c9bd967	2015-07-14 10:41:31.083-04	6c014dcf-e073-4d33-ad87-5b626c9bd967
f165e76a-6fd6-4bbc-a241-c08be8cf4212	kevinvanelsen@icloud.com	$2a$10$sqwKeIOmnx1FT8Hn.1Aw0Om2dqYf4IjTJP4yiPxqJcI2igCdrZlyW	0	1	1	2015-07-22 22:06:49.587-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:06:50.064-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	custardnv@gmail.om	$2a$10$wyhtRjdSh2knv8CCZnBdX.usdVJmgW0AUdetKQCAxq37/8geQKyZK	0	1	1	2015-07-24 15:59:07.461-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 15:59:08.036-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
be93b045-2bd1-43a0-94f2-29af3280a0db	custardnv@gmail.com	$2a$10$CXYreTcJA1BJQp9oy4N.FuPVWOTN11cyWrmKz3ej2WPDgIZPklo1G	0	1	1	2015-07-25 14:29:54.274-04	be93b045-2bd1-43a0-94f2-29af3280a0db	2015-07-25 14:29:54.771-04	be93b045-2bd1-43a0-94f2-29af3280a0db
12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	lakerblood24@yahoo.com	$2a$10$o3i/HeW5JIPl0x8Fst4PbeMZUQORoGeBke.I9dngDbNSWFJhY0O06	0	1	1	2015-07-28 11:17:34.891-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	2015-07-28 11:17:35.341-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e
4847bb7d-1587-4e1b-b93b-87a5df1257fe	lukebrunetti@hotmail.com	$2a$10$UyxkTKp7qr.3UsacS1aK5O7OOU3//uQKLy46oAoJO82gpkKpwjcoO	0	1	1	2015-07-28 13:25:03.998-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe	2015-07-28 13:25:04.443-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe
505aa5d3-9028-4827-9cfa-e35992f4d963	briandiffin@yahoo.com	$2a$10$EcadyDJG7VwUzKhD.zB.nuV/KqSuplqofW/yzQmcG7V8trTS/ZxSW	0	1	1	2015-07-31 10:34:12.531-04	505aa5d3-9028-4827-9cfa-e35992f4d963	2015-07-31 10:34:12.998-04	505aa5d3-9028-4827-9cfa-e35992f4d963
d0b3d250-9659-4717-b583-2fd7ecbdf913	jwmcelveen@hughes.net	$2a$10$Ja7Bdn1h6eHHRdVcchLyyu6PVedLY5wUhOZgZOmVHYB64kQBD2UBC	0	1	1	2015-08-02 19:08:27.231-04	d0b3d250-9659-4717-b583-2fd7ecbdf913	2015-08-02 19:08:27.931-04	d0b3d250-9659-4717-b583-2fd7ecbdf913
32aea253-36e7-4b71-8fb3-e46e9f757bfc	nateresa@aol.com	$2a$10$c5JGHNfwBQBVxriAL/RZEO55NM8ReZTeltrrI6o5mVjcS05XOBUoO	0	1	1	2015-08-03 18:52:52.11-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc	2015-08-03 18:52:52.536-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc
c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	dolsenvt@gmail.com	$2a$10$4D5avMKNMq5xML/1tEa09O0O6MVyke0OLjnkYRiV77oVdkWJTCGMu	0	1	1	2015-08-04 08:08:49.964-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	2015-08-04 08:08:50.456-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1
8efcd5d9-df90-49c5-bae1-6420e8628e74	jae5086@gmail.com	$2a$10$R0AkgDtBy0sPmmqjOLOAieYEiO5LxeA0vOLtqRTWlUXxrRB.cJuD6	0	1	1	2015-08-06 10:53:26.92-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-06 10:53:27.382-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
84bf0d55-d547-416a-8bce-0e5d7d7ddc96	nfaulkner81@yahoo.com	$2a$10$vM1K/iSrXcpYGVzVACGitOOrffIDO/rL7u6F1Ck2Lc1PRrU6t5NUu	0	1	1	2015-08-06 17:47:09.872-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96	2015-08-06 17:47:10.354-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96
adbb7632-8173-4c03-9211-2dbb3e5e64c4	jwhull2008@aol.com	$2a$10$wuYND8UAg/njr8NvK83p9OVHFbyJf8sgYrcEhkpjlxH5KjewYNjaG	0	1	1	2015-08-08 12:39:13.435-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4	2015-08-08 12:39:13.889-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4
11ee25db-8720-4e02-aacd-f33e2e313375	melanie@rhinonorthwest.com	$2a$10$6ESjRp2niYffITdr4l5zXuTsTjUMoHY1Bi/1ilZj5AhcMzxwH/CUS	0	1	1	2015-08-09 05:18:21.718-04	11ee25db-8720-4e02-aacd-f33e2e313375	2015-08-09 05:18:22.179-04	11ee25db-8720-4e02-aacd-f33e2e313375
47da5910-d577-4386-89a9-e271be4a2f4f	impactse@bigpond.net.au	$2a$10$bXwWQjqmSJOUxrlVbzi2zeHAQ1Y3b8rpZLyYXQ7HYYrWqvLRIRJQK	0	1	1	2015-08-13 08:42:11.399-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:42:11.846-04	47da5910-d577-4386-89a9-e271be4a2f4f
470cb0b5-a9f5-4c7a-b261-329056220023	info@artisticresinouscoatings.com	$2a$10$DekBsmERWlJ/r94tNAXiD.lH49DLjdzYKe0TBAc1WWPjB0fB/xVeq	0	1	1	2015-08-13 10:42:23.859-04	470cb0b5-a9f5-4c7a-b261-329056220023	2015-08-13 10:42:24.278-04	470cb0b5-a9f5-4c7a-b261-329056220023
d5e8db62-f918-4ff9-b891-4cec9d647ea5	info@innovativeborders.com	$2a$10$HiDJTMMuMygE1bZ51iqAjudMx.cuQ90yilN6D/I8tY8OXTToIDEra	0	1	1	2015-08-16 11:24:21.094-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5	2015-08-16 11:24:21.515-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5
e604c054-19e1-4332-b9ae-97ef0c58380f	lmuraltile@yahoo.com	$2a$10$T8pgAj8mq05Zb7Vam4p90OJHZML12/f3Xb1v8Rri9T2OZ6.ATT1J6	0	1	1	2015-08-18 22:29:08.523-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-18 22:29:08.969-04	e604c054-19e1-4332-b9ae-97ef0c58380f
86be876f-32c6-496c-953a-48ee6ad2dc10	richard@dcorzo.com	$2a$10$h8bSxU/swut1Rw1a8kTkZu0/e/DVICIis7CT7YO0fTYjdq6V0aGhW	0	1	1	2015-08-19 23:05:40.986-04	86be876f-32c6-496c-953a-48ee6ad2dc10	2015-08-19 23:05:41.496-04	86be876f-32c6-496c-953a-48ee6ad2dc10
c0697e56-11bf-4e37-a029-aac44d1af67c	jj@theconcreteprotector.com	$2a$10$nEXVLcxW0rpNHUT3TTaZNu.MBUCb/ZGK2elbgm896peDj7ePlgAwm	0	1	1	2015-08-26 11:56:20.881-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 11:56:21.417-04	c0697e56-11bf-4e37-a029-aac44d1af67c
0f1beec1-dbc9-458f-a5f6-ce714b91369a	chris.hawley@slabsurgeons.com	$2a$10$dVmJPwVg.IjsHTdaUYVuk.wzMqkfunEErN4Q3UgSOpFhe5jvhgvFW	0	1	1	2015-08-26 13:56:26.101-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a	2015-08-26 13:56:26.523-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a
3fd5a3de-cf27-460f-a3cf-8104c4527c5c	liberatoreconstruction@gmail.com	$2a$10$TktKjBMTBXUPzRFY.4Hjp.1./k9QpJBa4X41XtRhVzOiLO2K6MEEu	0	1	1	2015-08-26 18:53:39.681-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c	2015-08-26 18:53:40.097-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c
0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	manos.hullinspectir@yahoo.com	$2a$10$wmSKFmCMexdZusxOzDuYIu.qPV7mtrSy8j0p8laJqKCfT44Gjp/Ce	0	1	1	2015-08-27 05:21:00.645-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	2015-08-27 05:21:01.052-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544
a1e17f3f-cc53-48a7-a4b1-b600a36fca05	neven@theconcreteprotector.com	$2a$10$9Uos41707J/dUxAOncrLUOlIIbuFsR/kXj6EaKdNFv2gD4Tkoj96C	0	1	1	2015-08-28 08:07:50.265-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05	2015-08-28 08:07:50.735-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05
b698f42c-ef50-438c-9254-f2d0ef64fc33	cljones4u2@yahoo.com	$2a$10$Fmf6xmbNcAIVvWL7Y75xvuABCLDCgE8VUxupQUfvBy2s6zEqBIi5q	0	1	1	2015-08-28 10:57:18.632-04	b698f42c-ef50-438c-9254-f2d0ef64fc33	2015-08-28 10:57:19.089-04	b698f42c-ef50-438c-9254-f2d0ef64fc33
0f5cc00a-ab76-425f-9150-8072eae9bf75	ramiro@arsspecialtycontractors.com	$2a$10$BKTVvh2t97y9J/yY7MSMR.JGDDW1AxMtqQBMek6a2mXb/5HBHTgc2	0	1	1	2015-08-29 21:50:23.659-04	0f5cc00a-ab76-425f-9150-8072eae9bf75	2015-08-29 21:50:24.168-04	0f5cc00a-ab76-425f-9150-8072eae9bf75
89b13534-20eb-49d7-914c-d84a673f858d	modernsurfaces@yahoo.com	$2a$10$YTH0eyZexHygoHu1zAQtyOfpTzicSvSl.4fRhV1wg.w2kHFTpLAyu	0	1	1	2015-08-30 21:39:31.078-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:39:31.505-04	89b13534-20eb-49d7-914c-d84a673f858d
a5ef1333-2472-4bcb-b357-98c20ec3c93e	flawless29@gmail.com	$2a$10$KumpoE9kiAXag5RC/z8ImeHgc9V7FEHDepfsFfUAQbhvl/2spML3e	0	1	1	2015-08-31 15:15:28.416-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e	2015-08-31 15:15:28.874-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e
3f208971-2778-4ac6-b00a-52c05d0d7597	bhudon@mymts.net	$2a$10$M63WbKWRpr3Xuwwsb.7ebOEZL4xw9kc/KxTwX926Rdk/KrtGyaZM2	0	1	1	2015-09-03 08:35:01.309-04	3f208971-2778-4ac6-b00a-52c05d0d7597	2015-09-03 08:35:01.902-04	3f208971-2778-4ac6-b00a-52c05d0d7597
4b4b2595-96d5-4a70-bf64-e150de4cecf1	bob_murton26@hotmail.com	$2a$10$x52Q5LhDAYemsi4vjEOhme9t5IQEuiTQaircvNgoblX7vgSVD1rWm	0	1	1	2015-09-03 18:18:43.228-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1	2015-09-03 18:18:43.671-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1
86103f7b-c3bd-489b-a732-10374a07ed5a	csned86@hotmail.com	$2a$10$NgPrwwClgNaSSWlx6tTfze8rlTPqPiRD73EhUMSGXR3tV5XtVJR1a	0	1	1	2015-09-04 21:53:06.48-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-09-04 21:53:06.888-04	86103f7b-c3bd-489b-a732-10374a07ed5a
644eb96f-6f1f-47aa-a5dc-d5869c2963df	manuelin_alejandrez@yahoo.com	$2a$10$IRr8WuuORdj53kmpa1TFY.uBRSQ3WhJ61lEZGkim8aty1i1AxuvzG	0	1	1	2015-09-06 01:55:20.123-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df	2015-09-06 01:55:20.519-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df
7c7c1cd4-e190-4d36-a71e-58b3f939d25c	mray@sturgeonservices.com	$2a$10$JWdlHF9ygmyGB63zbKbiiuCSNREQgD3ZH8A8gVvSHzqOgp0l9TztG	0	1	1	2015-09-10 02:30:49.951-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:30:50.4-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c
b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	erikwinterland@me.com	$2a$10$4ML67s82pdztPbhIdX3ukeFYSDcUnvyOUAaPnLu0UMIH2f6dWsN.y	0	1	1	2015-09-10 15:24:51.907-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	2015-09-10 15:24:52.386-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a
58c16b16-a3f6-4d5b-ab85-5d4384e84de3	sherif789@gmail.com	$2a$10$e5DRy/Va7Bn9Lz6GTuOmDOZoexhRXLNvdWmK6wW.Gf.U5.7mlOkMm	0	1	1	2015-09-13 00:45:05.563-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	2015-09-13 00:45:06.002-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3
ffe3a005-5547-420a-a06e-1b0c8349bf51	propainterstoronto@gmail.com	$2a$10$KVfon.1VvfXFP9iTyX/XaOMn1go4goK9ViabuMXNdut17hDXJvIye	0	1	1	2015-09-13 21:31:56.166-04	ffe3a005-5547-420a-a06e-1b0c8349bf51	2015-09-13 21:31:56.617-04	ffe3a005-5547-420a-a06e-1b0c8349bf51
4f221611-83b3-4c94-95e4-9062e001b55b	bergled2@gmail.com	$2a$10$1aqVbjuIHkGns47OCpJiJO70c7104Ij.9wHHpwlu1KB4seHuTtt2W	0	1	1	2015-09-14 09:17:24.061-04	4f221611-83b3-4c94-95e4-9062e001b55b	2015-09-14 09:17:24.525-04	4f221611-83b3-4c94-95e4-9062e001b55b
7871755b-f26b-4b3b-9eca-124c725d5aa1	bhatfield35@hotmail.com	$2a$10$IWZiSALKugCruTqNGMWv6.CTYVa8uN9vUrp5w25q.3/AUxFNmpVra	0	1	1	2015-09-15 12:44:33.139-04	7871755b-f26b-4b3b-9eca-124c725d5aa1	2015-09-15 12:44:33.546-04	7871755b-f26b-4b3b-9eca-124c725d5aa1
9ec76276-7e09-41dd-aed1-bda46d79a89a	macaluu@gmail.com	$2a$10$wSMlN7T61MK78oRkM3QCjuN2.j0h3ww5vLCniA11XXlARHr2LHp4W	0	1	1	2015-09-25 09:36:01.043-04	9ec76276-7e09-41dd-aed1-bda46d79a89a	2015-09-25 09:36:01.511-04	9ec76276-7e09-41dd-aed1-bda46d79a89a
b842c097-ef8f-4d48-9e26-3ad73fe28b68	scottandjennylowery@yahoo. com	$2a$10$iaXvh8JISpN/mGsz4hKcte/EZ5D76OUlkdxoRaSGVArtmww9kce2q	0	1	1	2015-09-27 11:03:58.095-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68	2015-09-27 11:03:58.547-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68
25dc0a11-1989-4863-bcbf-b794bdb4fe4a	b@b.com	$2a$10$id3s8Z.BvPdmKefE0JQIaec.NDRoyJMSPjc5Xa4RlhmPOO97XkgXC	0	1	1	2015-09-28 11:43:20.058-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:43:47.984-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a
621af548-c387-471f-9d6d-ef4a20c81eb2	huelled@cox.net	$2a$10$fYiiQOn/THeIXE5213WIqOiGr8dhlTkvGJZMzcOfX0AYcesTBjXFK	0	1	1	2015-09-30 03:02:31.206-04	621af548-c387-471f-9d6d-ef4a20c81eb2	2015-09-30 03:02:31.784-04	621af548-c387-471f-9d6d-ef4a20c81eb2
ee2ef90f-e171-4422-b6a7-d783584c27b4	d@d.com	$2a$10$Ukfoc4nBFJoqvhoon26bnuw.uTE/U0h8h90RGtRy6fcNd7UkhCG6e	0	1	1	2015-10-09 09:27:45.208-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	2015-10-09 09:27:45.657-04	ee2ef90f-e171-4422-b6a7-d783584c27b4
51855703-9a42-4c37-8418-24da5bf57be7	shannon.redeckoco@gmail.com	$2a$10$TeELQrAZbWMwBAb8TLUpeOoAbd0ADy/o8Q.qS3CKKeSYMG4L0t1ku	0	1	1	2015-10-19 13:55:18.427-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 13:55:18.895-04	51855703-9a42-4c37-8418-24da5bf57be7
9b53f8fe-453f-4512-9016-81c3f56c16b5	t_james72@yahoo.com	$2a$10$hgpv4tFrgWG.euyEQy9aGOdRlc0VKmZUrJQ1UUPr8dhp5tXJWXKfm	0	1	1	2015-10-19 18:23:51.382-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	2015-10-19 18:23:51.79-04	9b53f8fe-453f-4512-9016-81c3f56c16b5
cca78e0c-34ac-4a21-9564-b391dbe19ec2	solarkoat@gmail.com	$2a$10$iaiWNo9dsqhbhDgjetubrOB.luaFfQt7EjdWYJ8sQG0e6aQV4R27.	0	1	1	2015-10-19 18:50:25.502-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2	2015-10-19 18:50:25.917-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2
d2311570-b0de-4b85-8af2-084bde99159d	pyenom1@aol.com	$2a$10$x/3GtWQNWGImTCzn2yAZIuujAl9Y3DPp61IBEqtL5zNKFDiys/3ru	0	1	1	2015-10-19 20:17:14.75-04	d2311570-b0de-4b85-8af2-084bde99159d	2015-10-19 20:17:15.186-04	d2311570-b0de-4b85-8af2-084bde99159d
2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	rick@capefearconcretecoatings.com	$2a$10$kBokQ.n6QXMogMDXjfHGEeM7mMdrqVg7V.KvMpgMx7ryN6tHDf5dC	0	2	1	2015-10-19 18:09:31.67-04	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	2015-12-02 10:17:40.353-05	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd
9a5f7b41-5057-4940-a321-30eb50b50554	e@e.com	$2a$10$PB7GbWMiZGAsADT7hQ/o8.yjxfSVnoktNoHjlcQvww4fs63GXPhBa	0	1	1	2015-10-19 23:21:10.262-04	9a5f7b41-5057-4940-a321-30eb50b50554	2015-10-19 23:21:10.703-04	9a5f7b41-5057-4940-a321-30eb50b50554
0455bfd0-c938-480d-a68a-9cbff8e72cc1	lexusljt@yahoo.com	$2a$10$udSPkHx/0aImL8DufchofOo9.IAF9Q6NqXm0rkqe074pqnLwslbjq	0	1	1	2015-10-20 07:55:05.918-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1	2015-10-20 07:55:06.426-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1
96b9a7e8-5273-40ab-ac79-65548e56a63a	licofloors@hotmail.com	$2a$10$N/U/Ip8vcPT9eNfpA9BIIO3dYIvUwmZ/81QZqd9av17lh0ZWzuVIe	0	1	1	2015-10-20 20:38:03.753-04	96b9a7e8-5273-40ab-ac79-65548e56a63a	2015-10-20 20:38:04.189-04	96b9a7e8-5273-40ab-ac79-65548e56a63a
ac137c0e-5239-4124-891a-0f32554a48f5	hyltons2000@yahoo.com	$2a$10$ak8nWntgHCD1RgwWov4QkOWdQI8uQlQ8y/5XAZkJFE6SXs1C/g0kC	0	1	1	2015-10-22 18:26:29.415-04	ac137c0e-5239-4124-891a-0f32554a48f5	2015-10-22 18:26:29.851-04	ac137c0e-5239-4124-891a-0f32554a48f5
c6a75811-f89a-498c-82ca-e5bc63c87087	derrickspencer_466@hotmail.com	$2a$10$AvGUEzwT/dVF0ahBuo6NGeLOlVyFx1zmw/jBsW7ZynC0O6jB3t36K	0	1	1	2015-10-23 22:45:17.788-04	c6a75811-f89a-498c-82ca-e5bc63c87087	2015-10-23 22:45:18.22-04	c6a75811-f89a-498c-82ca-e5bc63c87087
188a89cb-562b-45d2-ac34-32ac98e27a7e	thoseblankinkids@gmail.com	$2a$10$bf927io3xInsEE6AWReIMe6K1SrP6Bv6uPBMwSauqi90Zkur.V9Wy	0	1	1	2015-10-24 20:16:41.712-04	188a89cb-562b-45d2-ac34-32ac98e27a7e	2015-10-24 20:16:42.165-04	188a89cb-562b-45d2-ac34-32ac98e27a7e
fb08c1d6-72b8-4439-8714-4472d0aa057b	stallter.4@osu.edu	$2a$10$NbmOQXOwQxkQd49hOf6BEu178Czf60nqG6OfLfDsKQgsqJxRUIHH2	0	1	1	2015-10-28 10:29:19.634-04	fb08c1d6-72b8-4439-8714-4472d0aa057b	2015-10-28 10:29:20.163-04	fb08c1d6-72b8-4439-8714-4472d0aa057b
a43e9817-e631-4f88-869e-eadb767fe78d	russle4799@gmail.com	$2a$10$0K/ZXx3G9U7IEqTgfoQNh.j/FWLmtN4pURBBPzFEolw3n0x7KI4XW	0	1	1	2015-10-29 18:19:47.85-04	a43e9817-e631-4f88-869e-eadb767fe78d	2015-10-29 18:19:48.325-04	a43e9817-e631-4f88-869e-eadb767fe78d
ed651fef-794c-4b5a-952f-b830e640151a	ricardolope116@gmail.com	$2a$10$446DigXShH7XfDjZzfdGu.KE1B1AutBEoDJzH.Fttt4QdNjSSX3fC	0	1	1	2015-11-06 19:26:34.402-05	ed651fef-794c-4b5a-952f-b830e640151a	2015-11-06 19:26:34.828-05	ed651fef-794c-4b5a-952f-b830e640151a
f36bbc33-5956-4925-80db-c99850dc4a63	jeremymichaelpellicano@gmail.com	$2a$10$UII94ZvXpa5SixbAAy.Pvezk/nxTREjkgss3nOb9qW0.EMc3GZk1S	0	1	1	2015-11-01 20:52:36.863-05	f36bbc33-5956-4925-80db-c99850dc4a63	2015-11-01 20:52:37.426-05	f36bbc33-5956-4925-80db-c99850dc4a63
2e5c2eec-35bf-45b3-bcf0-cc02120dc634	rileywinter@hotmail.com	$2a$10$zZsQmQGoM7evXhdCXdFSROsyoK3rgRR2xHPqKOCwfIJe.iud0IQ7K	0	1	1	2015-11-06 21:57:26.984-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	2015-11-06 21:57:27.393-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634
e43c4619-cec8-433e-a6cb-c6f5c2bf606d	wiso.vazquez@hotmail.com	$2a$10$qA5Xgq2kWeJX4A00idGJ5eQ8tvP8y8i/zxFeZWtdGAdLXZD4/yBI.	0	4	1	2015-10-30 17:30:18.475-04	e43c4619-cec8-433e-a6cb-c6f5c2bf606d	2015-11-04 12:05:16.517-05	e43c4619-cec8-433e-a6cb-c6f5c2bf606d
b4244555-9faa-4b67-abbf-413e8823ec84	ronshaw_z@yahoo.com	$2a$10$RFa/nQ//XToRJVZp6SynxeVyGfYXEaLImQDU4YVQt.Z2kbiH5FsIe	0	1	1	2015-11-06 16:56:13.989-05	b4244555-9faa-4b67-abbf-413e8823ec84	2015-11-06 16:56:14.469-05	b4244555-9faa-4b67-abbf-413e8823ec84
d6f310e5-095e-48c7-a3c7-1a0e67927ec5	garytodd12@gmail.com	$2a$10$M8rGxZpkQCB8kNyj8/w1reRxmt/Jwr92MqhTCSOgFF16IlpBVCptC	0	1	1	2015-11-06 17:46:53.611-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5	2015-11-06 17:46:54.023-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5
66beb125-c5dc-44a0-9a24-00c319871544	meadfour@citlink.net	$2a$10$KqyOPYwpe6Ol1bEE0yMBbuHk7GtpTUMspL11TT1Eu/C5A5DiM8cHm	0	1	1	2015-11-06 17:47:15.261-05	66beb125-c5dc-44a0-9a24-00c319871544	2015-11-06 17:47:15.701-05	66beb125-c5dc-44a0-9a24-00c319871544
cdd26125-bcd1-434c-857d-6dfd5d4d9096	dnddecrative@gmail.com	$2a$10$.GYQ4X36n1xWHC2VPqDg5uqS5.VTBERndiR90ixkKt/Wqa324h8qG	0	1	1	2015-11-06 17:53:40.633-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096	2015-11-06 17:53:41.038-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096
c5ce2449-293c-45b7-a645-74bb855e94c8	boliohandymanservices@gmail.com	$2a$10$vkhrwx2Plvu8U9zMX.JBwOPJldb6Lv.fY.6SYfTifpzHljTCk9g3u	0	1	1	2015-11-06 17:56:41.467-05	c5ce2449-293c-45b7-a645-74bb855e94c8	2015-11-06 17:56:41.849-05	c5ce2449-293c-45b7-a645-74bb855e94c8
ea629c15-7048-42c6-b0f5-68058150a4b0	amish_mech@yahoo.co.in	$2a$10$7V0cRGbt2QClpy1luyZB7OXMZPSAetVHwRssEhkp7cz8xmT/dG2LC	0	1	1	2015-11-07 11:34:15.648-05	ea629c15-7048-42c6-b0f5-68058150a4b0	2015-11-07 11:34:16.078-05	ea629c15-7048-42c6-b0f5-68058150a4b0
a6c4875f-155d-47aa-b0c8-af62a6f2492a	orivera@drpaint.com	$2a$10$2d.ZjDWtCQ/.syJs4J5K5OMyqcO7ofAp8aJAub5bTFkMmTc.i23Lq	0	1	1	2015-11-08 09:15:01.851-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 09:15:02.298-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	michaelmulder22@gmail.com	$2a$10$VcHqssAdX2W22r2MDNoMz.hsTJlp3v.lDnGDQMRJ7HNMfZqGieWn2	0	1	1	2015-11-08 22:16:41.861-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:16:42.3-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
8f1445ec-0010-417d-a847-7bf92fc78931	jmurphy@floridasealing,com	$2a$10$jrod9Yr6ymoEzF1wIDOPhuVAIOhqQ3OA1jBUhCXtNceUb/hPUf6IC	0	1	1	2015-11-09 22:59:39.244-05	8f1445ec-0010-417d-a847-7bf92fc78931	2015-11-09 22:59:39.661-05	8f1445ec-0010-417d-a847-7bf92fc78931
6db77ef5-6b98-4cc7-81b7-f657a34fa6af	royceh@wetpcc.com	$2a$10$ikAgA88wzZJijJnA4R7FM.52jcG8eqjkRF0hX//p864o2WG4zKpmm	0	1	1	2015-11-13 15:35:00.152-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:35:00.658-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
b16e1efb-e20d-434e-9798-e419d3df0c33	toddjones6@bigoond.com	$2a$10$mcmFvv5Dufl3u/Nzj6W1XuKkKYPjXM3GW6pXLaenW3v5HMJnHUa7a	0	1	1	2015-11-17 06:52:03.001-05	b16e1efb-e20d-434e-9798-e419d3df0c33	2015-11-17 06:52:03.72-05	b16e1efb-e20d-434e-9798-e419d3df0c33
7e0634ad-f172-4baf-9d5c-2d2521697b8c	shanekvietkus@gmail.com	$2a$10$bZaW2SHk8zQsoywWvgcnFuXp73fQjpRPDQrR4XKG8XAOuKE3sSv4i	0	1	1	2015-11-17 19:31:44.389-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c	2015-11-17 19:31:44.876-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c
a87e2f31-a7e1-41e9-9760-ff655f43132a	shsnekvietkus@gmail.com	$2a$10$5EVU5k6zqCU/82XxKQxaHenCfe9rmV2ikAFDJ/4wZ.rbYtrV38eWW	0	1	1	2015-11-17 20:54:59.169-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:54:59.631-05	a87e2f31-a7e1-41e9-9760-ff655f43132a
76e3b5fe-cfd7-41e2-82ec-94767482ce34	fixmycrete@gmail.com	$2a$10$UqKIqjMf39CLHsUdcf0jEOqt8SN3fLxFJV4PCfWqEQqjoTABlSGF.	0	1	1	2015-11-22 19:23:11.223-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34	2015-11-22 19:23:36.091-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34
2943d175-b9f6-4e65-83a7-48f30ea66abe	stevebayley@gmail.com	$2a$10$tPp.4GVik2P4OrwfhukybubHhR7bhzfVEC7vXf0Z2pjKZ3oeHQ1BG	0	1	1	2015-11-25 20:43:40.247-05	2943d175-b9f6-4e65-83a7-48f30ea66abe	2015-11-25 20:43:40.702-05	2943d175-b9f6-4e65-83a7-48f30ea66abe
\.


--
-- Data for Name: accountrole; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY accountrole (id, accountid, role, version, status, added, addedby, changed, changedby) FROM stdin;
cd520088-1404-4168-8a8c-f5f02ac107c5	1676623f-4657-410f-87b6-db11cf461ba9	user	0	1	2014-12-16 21:50:23-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-16 21:50:48-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
31a697c9-e0b7-444a-9538-68df19607214	1676623f-4657-410f-87b6-db11cf461ba9	subscriber	0	1	2014-12-16 21:53:13-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-16 21:53:21-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
4988c1c0-eb11-4d70-9dfd-788aaf9c8dc5	1676623f-4657-410f-87b6-db11cf461ba9	concreteprotector	0	1	2014-12-17 13:15:45-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-17 13:15:52-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
8a27b900-68b3-4e29-81ce-d31eac9cd399	1676623f-4657-410f-87b6-db11cf461ba9	administrator	0	1	2014-12-16 21:52:13-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-16 21:52:21-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
bc917e8c-d36d-40d5-9bf1-041dac7c31d9	06169b04-bb68-4868-b995-98388fa33e16	user	0	1	2015-01-21 11:20:39.552-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 11:20:39.079-05	06169b04-bb68-4868-b995-98388fa33e16
b7ad2691-23bb-453e-a48b-6c8c543b41ba	7ce708d8-63c0-4faf-bb52-8a645fc1a819	user	0	1	2015-01-21 22:08:51.992-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-01-21 22:08:51.566-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819
a23e73a8-cbf6-418e-9eb2-3de3f28e0148	06169b04-bb68-4868-b995-98388fa33e16	subscriber	0	1	2014-12-16 21:53:13-05	06169b04-bb68-4868-b995-98388fa33e16	2014-12-16 21:53:21-05	06169b04-bb68-4868-b995-98388fa33e16
bf8264c3-e402-4e27-97e3-644ada52e92d	06169b04-bb68-4868-b995-98388fa33e16	concreteprotector	0	1	2014-12-17 13:15:45-05	06169b04-bb68-4868-b995-98388fa33e16	2014-12-17 13:15:52-05	06169b04-bb68-4868-b995-98388fa33e16
3059bb0c-9009-4d7e-9a4a-e4069bd3c40b	06169b04-bb68-4868-b995-98388fa33e16	administrator	0	1	2014-12-16 21:52:13-05	06169b04-bb68-4868-b995-98388fa33e16	2014-12-16 21:52:21-05	06169b04-bb68-4868-b995-98388fa33e16
26eaa716-8aee-411f-a18e-f8e009d0053d	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	user	0	1	2015-01-29 14:14:59.801-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:14:59.271-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
53ae79ae-0df6-4fcf-b615-837b32f810d4	c605da3d-19d9-4a0e-9d42-a1d48d70196a	user	0	1	2015-01-29 23:28:03.122-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-29 23:28:02.678-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
a07c37ee-5620-4d35-93e9-55f1a373c188	556f727b-33ea-479e-b87d-b32c7a7099fc	user	0	1	2015-01-30 11:43:25.631-05	556f727b-33ea-479e-b87d-b32c7a7099fc	2015-01-30 11:43:25.184-05	556f727b-33ea-479e-b87d-b32c7a7099fc
0cd442f8-9888-43b5-9b59-8123e057d1de	dbc55b9a-354a-41ce-a527-2ad709c81b5f	user	0	1	2015-02-02 22:01:49.686-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f	2015-02-02 22:01:49.175-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f
8b398ccd-58bb-4198-823f-6e4826cc95a8	377be275-bf06-4325-9879-406db5290aba	user	0	1	2015-02-02 23:43:58.64-05	377be275-bf06-4325-9879-406db5290aba	2015-02-02 23:43:58.186-05	377be275-bf06-4325-9879-406db5290aba
a1f6288a-8088-4a4a-ab7f-8b36e3bf554c	4398be50-e6ac-4662-8598-3783af2fa4f3	user	0	1	2015-02-03 09:49:36.404-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 09:49:35.781-05	4398be50-e6ac-4662-8598-3783af2fa4f3
a8716882-afdd-42d0-98a5-0d58e5f32d63	1506ba01-68a5-426b-969b-3cd4541907de	user	0	1	2015-02-03 12:41:26.2-05	1506ba01-68a5-426b-969b-3cd4541907de	2015-02-03 12:41:25.79-05	1506ba01-68a5-426b-969b-3cd4541907de
fded9e71-ef83-4a28-adef-fdcead2bd907	04e30689-c615-4fac-9106-f07b4159c62e	user	0	1	2015-02-03 17:16:28.405-05	04e30689-c615-4fac-9106-f07b4159c62e	2015-02-03 17:16:27.921-05	04e30689-c615-4fac-9106-f07b4159c62e
6fb0b7ac-de89-4c0b-a087-a2c5259431cc	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	user	0	1	2015-02-03 22:12:57.916-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	2015-02-03 22:12:57.333-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a
878a1a8f-f558-4081-87f6-fb88a7e35716	b4a956c2-4dab-4eaa-9b2a-be679af1efe4	user	0	1	2015-02-04 06:26:41.063-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4	2015-02-04 06:26:40.567-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4
2b16e955-c3f9-4efc-bced-9286a510e4c4	794d15d6-67d3-40b7-982c-17e4d81b73f9	user	0	1	2015-02-04 12:09:34.653-05	794d15d6-67d3-40b7-982c-17e4d81b73f9	2015-02-04 12:09:34.17-05	794d15d6-67d3-40b7-982c-17e4d81b73f9
b6356e35-d29e-49cf-ae22-d2f0b518eed9	c1c09c37-9dad-4c77-860e-26a64bdedba2	user	0	1	2015-02-04 13:45:23.679-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-04 13:45:23.161-05	c1c09c37-9dad-4c77-860e-26a64bdedba2
065f6ddf-c0a8-49aa-80c8-9caf71014536	61795214-a067-497f-8c4d-c307d5f658be	user	0	1	2015-02-04 13:51:42.259-05	61795214-a067-497f-8c4d-c307d5f658be	2015-02-04 13:51:41.778-05	61795214-a067-497f-8c4d-c307d5f658be
8e38e3c9-8334-4275-a299-89be2be55078	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	user	0	1	2015-02-04 13:54:25.442-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	2015-02-04 13:54:25.005-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4
226c2f25-d2ae-4b18-bb35-a028eb8b93b9	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	user	0	1	2015-02-04 22:55:25.226-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	2015-02-04 22:55:24.756-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12
20642725-6b6e-42f5-92ba-7b16602c8633	1aaaf421-b18d-49cb-b3a9-1926fe5b748b	user	0	1	2015-02-05 10:59:19.01-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b	2015-02-05 10:59:18.551-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b
4c8c4f94-0a18-411a-becb-a95132d211bb	c2901ab1-bc1f-4d59-aa31-2472bb7447bb	user	0	1	2015-02-05 11:53:49.945-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb	2015-02-05 11:53:49.515-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb
b795fbcd-fc1f-4a92-aad6-a0b139a09e5c	eb430119-b551-4141-8db9-9c87ec182c62	user	0	1	2015-02-05 12:07:40.73-05	eb430119-b551-4141-8db9-9c87ec182c62	2015-02-05 12:07:40.317-05	eb430119-b551-4141-8db9-9c87ec182c62
ac3705d4-a8a5-4eca-9ebd-83ec40c3f194	d86a76c4-4d99-4d16-b590-1df3c3122404	user	0	1	2015-02-05 12:24:30.004-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-05 12:24:29.561-05	d86a76c4-4d99-4d16-b590-1df3c3122404
2cdd4c42-acbe-4df3-8f31-f741dc30a306	d8b25099-6e8f-404f-a634-491a5987bc62	user	0	1	2015-02-05 12:58:22.883-05	d8b25099-6e8f-404f-a634-491a5987bc62	2015-02-05 12:58:22.388-05	d8b25099-6e8f-404f-a634-491a5987bc62
5dd562f1-80a0-462e-8128-0ba5b3215a94	ae0fd311-08da-40a3-95be-380fa613de0e	user	0	1	2015-02-05 13:14:46.392-05	ae0fd311-08da-40a3-95be-380fa613de0e	2015-02-05 13:14:45.918-05	ae0fd311-08da-40a3-95be-380fa613de0e
481d069b-a637-4560-9a83-3d19c2015972	59502cc0-bd28-4746-9872-8950ad1570fd	user	0	1	2015-02-05 18:53:37.223-05	59502cc0-bd28-4746-9872-8950ad1570fd	2015-02-05 18:53:36.782-05	59502cc0-bd28-4746-9872-8950ad1570fd
0d9ce7f0-9d83-4587-8747-08d5690864a3	e64f4e10-cb56-4b6f-897e-c6e25b2fb083	user	0	1	2015-02-05 21:32:55.473-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083	2015-02-05 21:32:55.041-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083
39f0829d-713d-4062-a742-694628a90061	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	user	0	1	2015-02-06 16:38:26.998-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:38:26.527-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6
3a089e76-a797-4c24-9770-f0f9553d64ed	8053c776-d7a4-4d09-bd03-cbd95cff842d	user	0	1	2015-02-06 16:45:50.357-05	8053c776-d7a4-4d09-bd03-cbd95cff842d	2015-02-06 16:45:49.931-05	8053c776-d7a4-4d09-bd03-cbd95cff842d
8ac3c97f-7463-436e-8794-6aaaedf57ce4	45c5679e-8596-4758-86cf-ca40c4ee38ee	user	0	1	2015-02-07 11:33:27.878-05	45c5679e-8596-4758-86cf-ca40c4ee38ee	2015-02-07 11:33:27.353-05	45c5679e-8596-4758-86cf-ca40c4ee38ee
998522e5-aafc-4e57-bca8-89b6e31d39eb	592d90f2-3979-4806-aa2a-9c59814b22ee	user	0	1	2015-02-07 13:36:55.583-05	592d90f2-3979-4806-aa2a-9c59814b22ee	2015-02-07 13:36:55.131-05	592d90f2-3979-4806-aa2a-9c59814b22ee
ec73eb59-c9ce-43ab-afc5-8c84ad933e2e	067b4635-5840-48fd-980d-ccddbe1b173d	user	0	1	2015-02-08 18:48:56.234-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:48:55.8-05	067b4635-5840-48fd-980d-ccddbe1b173d
e452a4c3-c92d-4f7b-a78e-ca8a625ea97a	4bd70027-faff-47f9-bcd6-f56ac2bd92f0	user	0	1	2015-02-08 21:02:05.195-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0	2015-02-08 21:02:04.71-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0
f75464d7-c705-459c-8dfe-00c9319fb682	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	user	0	1	2015-02-10 09:46:30.675-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:46:30.227-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057
f9af510e-8672-44b9-a018-e88ba0810dd9	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	user	0	1	2015-02-10 10:52:44.479-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	2015-02-10 10:52:44.043-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1
0068a831-1704-4f87-b47c-4e8abdd7fe55	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	user	0	1	2015-02-10 17:00:33.734-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-10 17:00:33.257-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
bb5c10ea-021a-488a-a17f-28ed4fa724ba	d9a3aeff-b191-4b86-ac09-dd08fb239eae	user	0	1	2015-02-11 11:27:46.806-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae	2015-02-11 11:27:46.261-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae
d4365fed-01b9-4815-a5fc-4ed90998983e	56428d0f-310c-4d39-85b5-62296d4a14ec	user	0	1	2015-02-11 15:42:27.823-05	56428d0f-310c-4d39-85b5-62296d4a14ec	2015-02-11 15:42:27.382-05	56428d0f-310c-4d39-85b5-62296d4a14ec
0e89ecec-5b58-4221-bdde-45a491a5290e	769a920c-df49-4e06-9913-4d7a6d83f073	user	0	1	2015-02-11 21:22:20.292-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-11 21:22:19.842-05	769a920c-df49-4e06-9913-4d7a6d83f073
ae23d7ba-7f77-4d93-ac4f-24feb4565269	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	user	0	1	2015-02-16 17:23:08.379-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	2015-02-16 17:23:07.912-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9
81208528-6f05-4cb8-9d3c-a633b549ff87	21ea39bb-285f-479e-8643-f9f963edd1a3	user	0	1	2015-02-16 18:07:17.599-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-16 18:07:17.123-05	21ea39bb-285f-479e-8643-f9f963edd1a3
cd5cfd37-e9b9-4256-84e9-c4d09d1f2275	be03f1e7-207c-4a6a-964f-ab6e7fb85ace	user	0	1	2015-02-17 17:48:28.028-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace	2015-02-17 17:48:27.523-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace
b3a46270-bac9-41dd-be31-3786aae67a80	0f68d399-eef2-466d-ab22-733bd2b2737e	user	0	1	2015-02-18 10:31:52.632-05	0f68d399-eef2-466d-ab22-733bd2b2737e	2015-02-18 10:31:52.129-05	0f68d399-eef2-466d-ab22-733bd2b2737e
1268eeda-02c6-474e-acad-e96afe906d68	45d94947-c576-453e-8e95-3fb0bdc538fc	user	0	1	2015-02-19 09:17:04.521-05	45d94947-c576-453e-8e95-3fb0bdc538fc	2015-02-19 09:17:04.031-05	45d94947-c576-453e-8e95-3fb0bdc538fc
80368246-fa9e-4beb-a2d7-4cace050aa8f	e81db145-8364-495e-b45e-709987d0c0f7	user	0	1	2015-02-20 06:07:30.909-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-20 06:07:30.459-05	e81db145-8364-495e-b45e-709987d0c0f7
eaf96728-7d72-470f-bfd2-99596c2ce9de	03c98a1a-8880-4d4e-9d7c-5d7440331ad0	user	0	1	2015-02-20 11:23:16.327-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0	2015-02-20 11:23:15.846-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0
0c83849d-4378-4113-8d29-d2e08668e159	ff6f636c-57d8-4627-9133-509bb40f75ac	user	0	1	2015-02-20 16:12:47.264-05	ff6f636c-57d8-4627-9133-509bb40f75ac	2015-02-20 16:12:46.782-05	ff6f636c-57d8-4627-9133-509bb40f75ac
e6e352a2-48b7-4163-a224-340515a8cb62	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	user	0	1	2015-02-20 16:43:07.005-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:43:06.531-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
2f6a44e1-5430-4912-8e96-16acd0a7a756	58254cba-f7c2-4939-9444-db0aafceea13	user	0	1	2015-02-20 19:28:04.273-05	58254cba-f7c2-4939-9444-db0aafceea13	2015-02-20 19:28:03.798-05	58254cba-f7c2-4939-9444-db0aafceea13
a6598557-d1ae-4308-8b76-dadd46b38f03	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	user	0	1	2015-02-20 20:26:21.15-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	2015-02-20 20:26:20.672-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96
906c4820-49bf-41f2-ae82-e36fc5f03840	ce456be6-d7c4-4fed-aab7-d3088f1b39b4	user	0	1	2015-02-21 13:30:03.615-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4	2015-02-21 13:30:03.023-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4
652f6bfb-6a50-4fe0-909a-7ebf614058d4	bf294499-6877-4421-8fb5-a5a5a86c4bda	user	0	1	2015-02-21 23:08:48.768-05	bf294499-6877-4421-8fb5-a5a5a86c4bda	2015-02-21 23:08:48.304-05	bf294499-6877-4421-8fb5-a5a5a86c4bda
dc32650c-30ce-4ba1-9576-324a38df17ee	3aff8907-6c52-437a-9016-ef7243c3dbbd	user	0	1	2015-02-22 01:21:13.688-05	3aff8907-6c52-437a-9016-ef7243c3dbbd	2015-02-22 01:21:13.112-05	3aff8907-6c52-437a-9016-ef7243c3dbbd
64e238ed-da55-4625-9f56-388b3f97ddc0	dc91c128-7614-4592-b94e-c19660131a55	user	0	1	2015-02-23 13:41:01.831-05	dc91c128-7614-4592-b94e-c19660131a55	2015-02-23 13:41:01.375-05	dc91c128-7614-4592-b94e-c19660131a55
ab37855b-1256-467c-89cc-9996e49a855d	c27e733b-f247-498a-a945-7521cca65c3b	user	0	1	2015-02-23 21:24:49.959-05	c27e733b-f247-498a-a945-7521cca65c3b	2015-02-23 21:24:49.423-05	c27e733b-f247-498a-a945-7521cca65c3b
87bc43f4-666c-499a-afc0-61ae87240b93	6664d1b2-7618-401f-bde9-d8f5d1c7b757	user	0	1	2015-02-24 17:11:36.003-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-24 17:11:35.556-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
3fd1b496-af19-42a9-b6ca-ee343db78e57	6c5725e7-5064-4126-a056-d36ad0efd1b7	user	0	1	2015-02-25 00:09:34.907-05	6c5725e7-5064-4126-a056-d36ad0efd1b7	2015-02-25 00:09:34.333-05	6c5725e7-5064-4126-a056-d36ad0efd1b7
3b4edeb6-dddb-47d1-8669-04d908b68f1e	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	user	0	1	2015-02-25 10:22:16.723-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	2015-02-25 10:22:16.248-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72
56c0ba31-4ebd-4c72-bd31-686e0e477cfe	03f15565-36da-4c06-a61f-ae401fc4722c	user	0	1	2015-02-25 11:41:23.389-05	03f15565-36da-4c06-a61f-ae401fc4722c	2015-02-25 11:41:22.957-05	03f15565-36da-4c06-a61f-ae401fc4722c
cc2eee52-af4b-484c-87f9-cf7cd0986441	a442335a-b15d-42e7-96bf-20de14fd1fd8	user	0	1	2015-02-26 23:57:57.145-05	a442335a-b15d-42e7-96bf-20de14fd1fd8	2015-02-26 23:57:56.695-05	a442335a-b15d-42e7-96bf-20de14fd1fd8
de4a176f-6808-44aa-a39c-79b927fadc4f	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	user	0	1	2015-03-02 18:03:42.571-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-02 18:03:42.102-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
041bc18f-f443-4854-a0da-87ac0f76e07f	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	user	0	1	2015-03-02 18:45:06.375-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	2015-03-02 18:45:05.864-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d
19467af9-eda3-4584-b47b-43d1720f1680	f975c50a-beb9-4277-ba91-6505d1b37f59	user	0	1	2015-03-04 20:33:08.675-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:33:08.203-05	f975c50a-beb9-4277-ba91-6505d1b37f59
9749385d-7278-40ab-b978-a91bade10478	f43c207e-54b3-433d-a55c-a55521f818e4	user	0	1	2015-03-07 09:11:39.997-05	f43c207e-54b3-433d-a55c-a55521f818e4	2015-03-07 09:11:39.529-05	f43c207e-54b3-433d-a55c-a55521f818e4
04f40eae-2714-4198-8b19-40cf7b99aa58	7642061f-8f03-462b-a50b-2c712fa4e952	user	0	1	2015-03-07 12:51:39.919-05	7642061f-8f03-462b-a50b-2c712fa4e952	2015-03-07 12:51:39.435-05	7642061f-8f03-462b-a50b-2c712fa4e952
2f2a9f30-490b-45c2-8bf5-98aa2fa4494c	c35a84cb-0f2f-45e2-8ef8-0165189944c7	user	0	1	2015-03-07 21:29:13.72-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-07 21:29:13.279-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7
4ef517ef-989a-4fe9-aac6-de457a5074e8	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	user	0	1	2015-03-08 22:08:12.322-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	2015-03-08 22:08:11.807-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0
f957c1b8-dd18-4feb-babc-830610fc2438	abe59033-dbbd-4bbc-92a4-93f395ba289c	user	0	1	2015-03-09 10:32:43.795-04	abe59033-dbbd-4bbc-92a4-93f395ba289c	2015-03-09 10:32:43.324-04	abe59033-dbbd-4bbc-92a4-93f395ba289c
1f7c972a-44b2-429e-9d6c-044b4004c47a	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	user	0	1	2015-03-09 22:11:55.121-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	2015-03-09 22:11:54.552-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe
116520a6-ff0c-42a1-8fc5-33193c991197	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	user	0	1	2015-03-11 21:39:38.355-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	2015-03-11 21:39:37.861-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb
3e46e154-7268-4b46-bc82-7ea6c7ff34c5	31797590-b84e-43d8-b0f1-32a1bdc37131	user	0	1	2015-03-12 16:09:38.474-04	31797590-b84e-43d8-b0f1-32a1bdc37131	2015-03-12 16:09:38.032-04	31797590-b84e-43d8-b0f1-32a1bdc37131
3322fda7-b977-49af-a006-8d72e92082e4	7878e434-6854-422a-91aa-212f8b175aa3	user	0	1	2015-03-14 20:44:16.326-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 20:44:15.912-04	7878e434-6854-422a-91aa-212f8b175aa3
392836a7-c95f-43a6-b05c-094a1384fc92	77b5b917-c79f-4954-bc1e-675e7d0fea9e	user	0	1	2015-03-17 21:55:21.944-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e	2015-03-17 21:55:21.48-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e
6e6fd50b-f001-45df-8012-71eecc9f33c3	745bde7b-294a-4716-8d8a-29e79f3bc3d0	user	0	1	2015-03-19 13:01:09.096-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0	2015-03-19 13:01:08.66-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0
cad55ee2-a796-47d2-98f3-949cee2d327a	6bdbf380-19f2-4749-adf3-c5e077387f81	user	0	1	2015-03-19 13:52:29.909-04	6bdbf380-19f2-4749-adf3-c5e077387f81	2015-03-19 13:52:29.49-04	6bdbf380-19f2-4749-adf3-c5e077387f81
7aa207f2-3f2b-4ecf-8900-d654a5f28743	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	user	0	1	2015-03-19 13:56:35.272-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 13:56:34.85-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
6662bf03-290d-4b86-ad51-80323ce1eddf	dcaae353-6d1a-4933-b1ab-243d01d6ed34	user	0	1	2015-03-19 14:00:22.836-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34	2015-03-19 14:00:22.42-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34
c01082f4-d2bc-466f-94db-c02351de9b91	503a77c4-05d0-4a6d-b282-61284bdefdf8	user	0	1	2015-03-19 17:15:25.057-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 17:15:24.629-04	503a77c4-05d0-4a6d-b282-61284bdefdf8
0a91cb5c-d8b9-4fd8-b483-4d7744ddb479	05dbb3b8-9caf-405e-ae5e-a6074822a169	user	0	1	2015-03-19 18:09:34.671-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-19 18:09:34.232-04	05dbb3b8-9caf-405e-ae5e-a6074822a169
0e4c3742-0bdf-4cd3-aa96-c23c31abed02	1c8a8a08-87c5-4fc6-adde-a8aac73bba34	user	0	1	2015-03-20 07:03:52.407-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34	2015-03-20 07:03:51.904-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34
d4c998f5-9e4c-4128-9952-0fabedc94d61	fd0457a0-2d66-4a63-857b-21f224a14a47	user	0	1	2015-03-20 11:30:19.522-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 11:30:19.085-04	fd0457a0-2d66-4a63-857b-21f224a14a47
320b30f1-977f-4c9b-99ef-6115aecb12c1	5c54b12e-42e9-4222-9d43-04de05218061	user	0	1	2015-03-20 11:37:34.647-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:37:33.73-04	5c54b12e-42e9-4222-9d43-04de05218061
b4d557dc-252d-46d1-ab20-de5e8e1d3a3d	1e6a7ced-23ad-4369-b72f-9af65493972a	user	0	1	2015-03-20 11:41:01.234-04	1e6a7ced-23ad-4369-b72f-9af65493972a	2015-03-20 11:41:00.818-04	1e6a7ced-23ad-4369-b72f-9af65493972a
f6d391c2-8847-44c7-a5c6-25ca6cd9f746	0d974cc6-045d-4ec5-a533-38ab0b8f115b	user	0	1	2015-03-20 11:45:53.779-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 11:45:53.38-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b
bff2e12e-2287-446e-8731-edd7bf4230b5	9ef858fa-13d8-4152-aff7-28daea5a0842	user	0	1	2015-03-20 11:46:26.429-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-20 11:46:25.994-04	9ef858fa-13d8-4152-aff7-28daea5a0842
8431eb3f-e6fc-41e4-84f6-416d8d100d25	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	user	0	1	2015-03-20 11:58:01.615-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 11:58:01.208-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
59599d4c-3ffb-41bf-9753-973c69ac8635	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	user	0	1	2015-03-20 11:58:41.394-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	2015-03-20 11:58:40.978-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a
d9ab148c-8a44-46e8-8add-450278ec7c8d	84525335-0f50-4354-8dd8-f9fe584df21a	user	0	1	2015-03-20 19:26:48.776-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-03-20 19:26:48.281-04	84525335-0f50-4354-8dd8-f9fe584df21a
2499276d-0b7b-471f-a6fd-54bfa424aed6	3d6c5760-1a2a-4920-b821-d5f986988941	user	0	1	2015-03-21 09:45:55.843-04	3d6c5760-1a2a-4920-b821-d5f986988941	2015-03-21 09:45:55.28-04	3d6c5760-1a2a-4920-b821-d5f986988941
46d634c1-f859-465c-971f-a360ca7b71c4	5d51d14d-0147-4816-8325-38dfe31eca50	user	0	1	2015-03-24 14:51:36.133-04	5d51d14d-0147-4816-8325-38dfe31eca50	2015-03-24 14:51:35.676-04	5d51d14d-0147-4816-8325-38dfe31eca50
c9d5e6f2-e699-45e1-9493-64dbc4f84614	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	user	0	1	2015-03-24 18:18:05.258-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	2015-03-24 18:18:04.783-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c
510b46d1-1556-4fc5-8e51-920b8d69e2f9	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	user	0	1	2015-03-25 12:16:15.069-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	2015-03-25 12:16:14.587-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b
4dd6ac3e-9390-44fc-9411-64a0a8eee412	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	user	0	1	2015-03-25 17:33:20.296-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	2015-03-25 17:33:19.844-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4
3f40403b-a31d-4344-993c-1a3ef8c65ab3	66274f2a-93f5-4977-932b-9e9df88f4eaf	user	0	1	2015-03-25 18:40:15.647-04	66274f2a-93f5-4977-932b-9e9df88f4eaf	2015-03-25 18:40:15.218-04	66274f2a-93f5-4977-932b-9e9df88f4eaf
0bd58981-8753-46d3-befe-0cb871b2e5bf	c9585e20-20ab-4d6f-8fc6-e97a098be96f	user	0	1	2015-03-27 07:16:41.061-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f	2015-03-27 07:16:40.627-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f
bf5c2e55-391b-4e4b-988a-4593e72f7d8b	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	user	0	1	2015-03-27 12:54:16.033-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	2015-03-27 12:54:15.588-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c
cd731589-7adb-4e02-9de6-35f8bfbfd194	d7bb1e62-fe40-4774-a432-03bd53510708	user	0	1	2015-03-28 20:42:16.893-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-03-28 20:42:16.312-04	d7bb1e62-fe40-4774-a432-03bd53510708
df9690bd-d51c-4ca3-929c-5e567414f2f4	dfaf0205-40d2-495c-8197-cf0e0ec838b4	user	0	1	2015-03-30 17:57:06.249-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 17:57:05.827-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
3f63afe0-6a3a-44f6-aad5-c979fc0fab24	8550e1eb-fb9a-4574-b952-0fbad9725725	user	0	1	2015-04-01 12:36:30.27-04	8550e1eb-fb9a-4574-b952-0fbad9725725	2015-04-01 12:36:29.838-04	8550e1eb-fb9a-4574-b952-0fbad9725725
5fb47b49-f3d2-4ee2-b613-b9efd60b044a	2e7be263-d520-4063-b4f0-beeb99e67619	user	0	1	2015-04-04 11:28:31.062-04	2e7be263-d520-4063-b4f0-beeb99e67619	2015-04-04 11:28:30.608-04	2e7be263-d520-4063-b4f0-beeb99e67619
f6d82d1c-49da-4464-ba2e-961cd2ec6555	78726cf5-db49-4766-a5fb-e4b230ba1db9	user	0	1	2015-04-04 14:09:35.255-04	78726cf5-db49-4766-a5fb-e4b230ba1db9	2015-04-04 14:09:34.824-04	78726cf5-db49-4766-a5fb-e4b230ba1db9
0b3b0d74-31ad-46a2-9b82-5f5e608702af	c4546d68-3577-444e-8e24-918f627d42fd	user	0	1	2015-04-10 00:29:21.383-04	c4546d68-3577-444e-8e24-918f627d42fd	2015-04-10 00:29:20.941-04	c4546d68-3577-444e-8e24-918f627d42fd
7a8e5c57-4558-4ea4-91b0-f36c78b539a1	e5402660-9cee-48ef-9782-46756e22aad0	user	0	1	2015-04-11 09:49:21.071-04	e5402660-9cee-48ef-9782-46756e22aad0	2015-04-11 09:49:20.603-04	e5402660-9cee-48ef-9782-46756e22aad0
b857d5de-49b2-4f63-a1e9-2f0281a34c0a	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	user	0	1	2015-04-14 09:17:07.367-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 09:17:06.796-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
7c78fe7d-eb88-4608-b4c0-cd1ad07c1605	d2723b90-ebcd-4856-8e02-56b9983f130b	user	0	1	2015-04-15 17:34:35.038-04	d2723b90-ebcd-4856-8e02-56b9983f130b	2015-04-15 17:34:34.596-04	d2723b90-ebcd-4856-8e02-56b9983f130b
aa8c7e40-4fb4-41d2-9a97-43b820ce0e4b	b2056c93-cb7d-470f-b9cb-f043cb5328a7	user	0	1	2015-04-17 22:49:31.803-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7	2015-04-17 22:49:31.321-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7
dc040898-5064-403c-826f-330c282f6046	cf0177ba-e1e1-4685-82fe-7432bd02fb98	user	0	1	2015-04-17 23:10:15.956-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	2015-04-17 23:10:15.5-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98
e422312a-f6d1-48f8-af75-44bbe83e6bf5	f4ff4de4-2322-447c-ae14-d1e9945c523f	user	0	1	2015-04-18 02:15:16.032-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:15:15.564-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
ac97c11f-8e46-40f5-a709-94afa6cb4c28	41072458-fade-43dc-a1d8-543db6c37a49	user	0	1	2015-04-18 03:24:15.139-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:24:14.635-04	41072458-fade-43dc-a1d8-543db6c37a49
2640daf0-d992-4e19-8b93-9c8b65243e46	1e03402a-162a-4499-9691-233112668148	user	0	1	2015-04-18 09:58:57.273-04	1e03402a-162a-4499-9691-233112668148	2015-04-18 09:58:56.786-04	1e03402a-162a-4499-9691-233112668148
f809108a-a787-4779-9fd9-a56308c2ba42	5614f192-f2bf-48d7-8912-f6ab1286bd7d	user	0	1	2015-04-18 11:21:39.61-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:21:39.134-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d
34e46b2b-55df-4302-a3a2-9f7362c07cf6	5341f975-1bfb-4991-acd2-3c1b58ac1b30	user	0	1	2015-04-18 14:14:22.692-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30	2015-04-18 14:14:22.215-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30
0589b382-99ba-47b3-8c66-d709fabb2ddb	263edbd8-24c6-488b-ad4b-76abc61b76ed	user	0	1	2015-04-19 08:20:02.282-04	263edbd8-24c6-488b-ad4b-76abc61b76ed	2015-04-19 08:20:01.752-04	263edbd8-24c6-488b-ad4b-76abc61b76ed
1501ed66-4d8a-4359-a592-d75a8b8de044	737398f9-28e7-4a98-bc58-442a6783a5fe	user	0	1	2015-04-19 10:43:51.905-04	737398f9-28e7-4a98-bc58-442a6783a5fe	2015-04-19 10:43:51.389-04	737398f9-28e7-4a98-bc58-442a6783a5fe
7429a2c1-833b-4b9d-91f8-544a1a37152c	ade5256e-c8d9-44f3-9714-262fafb8a475	user	0	1	2015-04-19 12:07:58.219-04	ade5256e-c8d9-44f3-9714-262fafb8a475	2015-04-19 12:07:57.791-04	ade5256e-c8d9-44f3-9714-262fafb8a475
30799774-6e6f-482e-95fc-317ef8e7725e	547b9e45-ff74-4626-a9b2-1df9b6001d84	user	0	1	2015-04-23 11:17:48.216-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 11:17:47.675-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
1ef48ed4-0138-417b-a909-350f77ac42d4	2c9df1e2-cb59-4f63-b854-241e044ece4d	user	0	1	2015-04-25 14:48:00.62-04	2c9df1e2-cb59-4f63-b854-241e044ece4d	2015-04-25 14:48:00.051-04	2c9df1e2-cb59-4f63-b854-241e044ece4d
c0ffb882-4366-497a-b105-f212eee001f1	b6f4370a-2301-4810-9745-5b8a2deb728d	user	0	1	2015-04-26 21:32:22.897-04	b6f4370a-2301-4810-9745-5b8a2deb728d	2015-04-26 21:32:22.468-04	b6f4370a-2301-4810-9745-5b8a2deb728d
0b77de9f-6af6-4fd8-a1b4-fe11d5e80b5c	bea77c25-d4c4-4821-b935-f4908ec9c0a4	user	0	1	2015-04-27 20:12:25.621-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4	2015-04-27 20:12:25.186-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4
7d539900-1df7-419f-987e-a478ef96b136	5a95c207-4d12-4712-a0dd-df4227795142	user	0	1	2015-04-28 06:28:46.477-04	5a95c207-4d12-4712-a0dd-df4227795142	2015-04-28 06:28:46.006-04	5a95c207-4d12-4712-a0dd-df4227795142
a5ea7849-8884-4b31-b017-b71b4d4003f6	05ffe28f-ec37-4b04-b3f7-68aeb6cda998	user	0	1	2015-04-29 09:14:30.697-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998	2015-04-29 09:14:30.192-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998
dbf42a7f-ee21-46c1-bd14-8961f89027de	4ed2745b-5397-4290-9e4b-971eea1e1359	user	0	1	2015-04-30 21:03:20.994-04	4ed2745b-5397-4290-9e4b-971eea1e1359	2015-04-30 21:03:20.49-04	4ed2745b-5397-4290-9e4b-971eea1e1359
00067f2f-2e01-4bae-81df-77185322ece7	350a236f-f780-40e9-85e3-2b9227f4d76f	user	0	1	2015-05-02 18:10:04.757-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:10:04.223-04	350a236f-f780-40e9-85e3-2b9227f4d76f
a89921b6-b356-4dd9-9856-9359f5885547	c276de4d-a087-4025-922b-73cabe491bd3	user	0	1	2015-05-04 17:08:03.344-04	c276de4d-a087-4025-922b-73cabe491bd3	2015-05-04 17:08:02.881-04	c276de4d-a087-4025-922b-73cabe491bd3
e694d9d4-3488-4a92-92f1-127791cb951c	ecaa82b2-d881-4d3a-8322-726a45e42c11	user	0	1	2015-05-05 07:51:56.859-04	ecaa82b2-d881-4d3a-8322-726a45e42c11	2015-05-05 07:51:56.388-04	ecaa82b2-d881-4d3a-8322-726a45e42c11
b5b2883e-b09f-409d-bf63-0cc1ab8d279e	c11cfe2d-a585-42e2-a570-08b850e9a894	user	0	1	2015-05-05 18:26:07.237-04	c11cfe2d-a585-42e2-a570-08b850e9a894	2015-05-05 18:26:06.702-04	c11cfe2d-a585-42e2-a570-08b850e9a894
528bc195-cc03-4a67-8f95-17854b158f6b	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	user	0	1	2015-05-08 11:17:09.093-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	2015-05-08 11:17:08.587-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429
b2a078bc-1ad3-4f2f-aab4-860c75f2a631	1c996f95-6044-4110-8a19-eb1c2c40d597	user	0	1	2015-05-08 14:40:54.542-04	1c996f95-6044-4110-8a19-eb1c2c40d597	2015-05-08 14:40:54.042-04	1c996f95-6044-4110-8a19-eb1c2c40d597
35b92c0c-b918-46de-9b5c-6b2f451f760c	346ff4ec-5d01-464f-94a6-b282484b7d8b	user	0	1	2015-05-11 11:55:04.81-04	346ff4ec-5d01-464f-94a6-b282484b7d8b	2015-05-11 11:55:04.275-04	346ff4ec-5d01-464f-94a6-b282484b7d8b
4b3fc9f9-0647-44b1-9f6d-3975ed8fb266	609ec79e-ea84-4c4a-abe1-67f4c38bbe92	user	0	1	2015-05-11 21:33:12.842-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92	2015-05-11 21:33:12.328-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92
5d5a88ab-f2f7-44ee-95e9-1f5ca02ba977	bcff8f11-ed0d-4a44-a96a-08a3c646d737	user	0	1	2015-05-11 22:58:52.455-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737	2015-05-11 22:58:52.019-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737
46d4d1fe-7774-4f9c-b388-95a0de68f000	304f78a7-8428-415f-b526-1aa3326b6244	user	0	1	2015-05-14 12:00:02.541-04	304f78a7-8428-415f-b526-1aa3326b6244	2015-05-14 12:00:02.092-04	304f78a7-8428-415f-b526-1aa3326b6244
67b82990-0023-4532-9fe7-cbc5c47b5a57	6da7d4f7-c747-4955-ab23-1b62554db9ce	user	0	1	2015-05-14 17:11:40.304-04	6da7d4f7-c747-4955-ab23-1b62554db9ce	2015-05-14 17:11:39.816-04	6da7d4f7-c747-4955-ab23-1b62554db9ce
663bfc62-5a4f-4a35-ac4d-62f4f5499ae0	884721c6-aea2-4d0d-9d9d-6fa329d1f539	user	0	1	2015-05-15 17:41:19.221-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539	2015-05-15 17:41:18.668-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539
8153059a-1391-4acf-8bfb-62d033ac128b	c53ab4cb-e0be-4c86-86eb-46773c9551e0	user	0	1	2015-05-16 14:44:40.663-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0	2015-05-16 14:44:40.193-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0
37fb84c5-fc0b-4c8f-9d6f-0d01b6a424ac	12034988-1c47-4bdd-b7ac-1751e04269ad	user	0	1	2015-05-18 21:57:43.736-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-18 21:57:43.146-04	12034988-1c47-4bdd-b7ac-1751e04269ad
d5265972-687b-4dfa-90f3-f0a592876771	7f13a571-83af-4b72-ae3f-5777badf0027	user	0	1	2015-05-21 20:33:39.804-04	7f13a571-83af-4b72-ae3f-5777badf0027	2015-05-21 20:33:39.337-04	7f13a571-83af-4b72-ae3f-5777badf0027
ab250988-bb9f-4c8b-b348-4ca8912d5bcd	2a63f4b8-4436-45bf-9439-866ac59e1911	user	0	1	2015-05-24 11:02:43.382-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-05-24 11:02:42.913-04	2a63f4b8-4436-45bf-9439-866ac59e1911
c24aff89-cdd2-45a6-9b94-5777229cbf3b	4023e17e-c332-4669-9dd5-63f796508059	user	0	1	2015-05-24 15:12:17.564-04	4023e17e-c332-4669-9dd5-63f796508059	2015-05-24 15:12:17.128-04	4023e17e-c332-4669-9dd5-63f796508059
96db3f15-65ab-4dee-bceb-ce16250f79af	464972d2-3955-40a6-abf5-5ada5cd9e4ea	user	0	1	2015-05-26 10:08:16.347-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea	2015-05-26 10:08:15.82-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea
d2ef1d78-cc2a-46ec-804c-9506feb66c2b	fb81d126-c102-4e37-a1d6-a709a5eb7d1a	user	0	1	2015-05-27 00:18:45.15-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a	2015-05-27 00:18:44.634-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a
f4df2018-2827-4c09-bd0d-58bb9c88d910	e70477ac-5ece-430d-9287-a92dd7cc190c	user	0	1	2015-05-30 10:37:05.367-04	e70477ac-5ece-430d-9287-a92dd7cc190c	2015-05-30 10:37:04.77-04	e70477ac-5ece-430d-9287-a92dd7cc190c
517c1ed9-aeaf-4e78-b3bc-75036b54d9f5	5f96f064-10c1-4278-af7c-35b9e0df8728	user	0	1	2015-06-05 11:56:04.828-04	5f96f064-10c1-4278-af7c-35b9e0df8728	2015-06-05 11:56:04.37-04	5f96f064-10c1-4278-af7c-35b9e0df8728
c720970d-69a2-474d-9d6b-2c6b2805ba99	2d259e86-2515-4439-9ad9-8c97d751bc88	user	0	1	2015-06-13 22:51:15.125-04	2d259e86-2515-4439-9ad9-8c97d751bc88	2015-06-13 22:51:14.649-04	2d259e86-2515-4439-9ad9-8c97d751bc88
e4d2e3eb-1fa9-49ee-b9bc-6b92ed1893b4	abc5acf5-6911-4a9d-b8ff-7f740a9267ba	user	0	1	2015-06-16 19:25:41.797-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba	2015-06-16 19:25:41.323-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba
3735793f-3bc7-4fab-b785-2414f2036af7	da7076fb-15b5-4d73-8595-98dc8d53170c	user	0	1	2015-06-25 08:02:51.034-04	da7076fb-15b5-4d73-8595-98dc8d53170c	2015-06-25 08:02:50.554-04	da7076fb-15b5-4d73-8595-98dc8d53170c
f4717627-397c-4155-83a7-e89228696d40	4f954bb7-744d-49ab-9990-7395720ae3ed	user	0	1	2015-06-25 08:06:17.111-04	4f954bb7-744d-49ab-9990-7395720ae3ed	2015-06-25 08:06:16.69-04	4f954bb7-744d-49ab-9990-7395720ae3ed
9f800872-ddfa-49be-99d9-3e948fe01860	55b80699-7270-4cf1-a342-2d0c63684b02	user	0	1	2015-06-25 18:36:19.129-04	55b80699-7270-4cf1-a342-2d0c63684b02	2015-06-25 18:36:18.703-04	55b80699-7270-4cf1-a342-2d0c63684b02
795e44d0-ed0c-4b1b-a6ae-75f520af262d	0a215950-e391-4575-8d45-e5c36c6cb723	user	0	1	2015-06-26 14:22:19.865-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-06-26 14:22:19.376-04	0a215950-e391-4575-8d45-e5c36c6cb723
604c476e-67d5-4a76-babe-cec0f6956f6d	f1a9a130-48b6-4843-a5e3-d8c0403b9276	user	0	1	2015-06-29 16:10:51.98-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276	2015-06-29 16:10:51.527-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276
7c8d2e3c-254e-465c-a348-9616159d547e	cc0c563b-880f-445d-8026-8265c2de2f88	user	0	1	2015-06-29 17:08:27.797-04	cc0c563b-880f-445d-8026-8265c2de2f88	2015-06-29 17:08:27.364-04	cc0c563b-880f-445d-8026-8265c2de2f88
3fdb0a9c-bc03-4829-89c3-e74cc1e7b123	85a17430-3568-44af-a520-175faaf6a9ee	user	0	1	2015-06-29 18:55:57.856-04	85a17430-3568-44af-a520-175faaf6a9ee	2015-06-29 18:55:57.429-04	85a17430-3568-44af-a520-175faaf6a9ee
25475a5c-b462-49fa-9b7f-3e13b520f90f	536d9218-deaa-44fb-b9f2-7c81447ee863	user	0	1	2015-07-01 21:42:35.015-04	536d9218-deaa-44fb-b9f2-7c81447ee863	2015-07-01 21:42:34.446-04	536d9218-deaa-44fb-b9f2-7c81447ee863
8c3321d2-812b-4aad-9729-988b2eab12c3	61709628-4bca-418f-8dc4-1ad358c785d6	user	0	1	2015-07-05 23:23:48.831-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:23:48.381-04	61709628-4bca-418f-8dc4-1ad358c785d6
f2390719-0316-40f9-b904-21161b44c40a	73bc3ee0-49d2-4ff0-a456-0c42634b1c40	user	0	1	2015-07-06 10:56:09.379-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40	2015-07-06 10:56:08.927-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40
2619f721-5acf-493f-8e02-d566c13e88e1	5414f676-63e9-4117-87bd-ec5577e932b7	user	0	1	2015-07-13 08:14:53.387-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:14:52.93-04	5414f676-63e9-4117-87bd-ec5577e932b7
11adfc16-4295-4f64-98d5-9d9670cb5a4a	6c014dcf-e073-4d33-ad87-5b626c9bd967	user	0	1	2015-07-14 10:41:30.673-04	6c014dcf-e073-4d33-ad87-5b626c9bd967	2015-07-14 10:41:30.225-04	6c014dcf-e073-4d33-ad87-5b626c9bd967
a2574381-0505-432e-9634-a63da9601367	f165e76a-6fd6-4bbc-a241-c08be8cf4212	user	0	1	2015-07-22 22:06:49.59-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:06:49.121-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
505f4430-317b-4fd1-b730-7af7e72e91bc	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	user	0	1	2015-07-24 15:59:07.465-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 15:59:06.938-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
aee028c0-10d7-47dc-bf07-f0efb3a8698c	be93b045-2bd1-43a0-94f2-29af3280a0db	user	0	1	2015-07-25 14:29:54.276-04	be93b045-2bd1-43a0-94f2-29af3280a0db	2015-07-25 14:29:53.789-04	be93b045-2bd1-43a0-94f2-29af3280a0db
0521430a-6d65-494a-a4a8-2bed614074e9	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	user	0	1	2015-07-28 11:17:34.894-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	2015-07-28 11:17:34.447-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e
109ff595-6635-42e4-9c18-d2bcdb5bd16b	4847bb7d-1587-4e1b-b93b-87a5df1257fe	user	0	1	2015-07-28 13:25:04.001-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe	2015-07-28 13:25:03.514-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe
78869744-6d26-4575-b57a-6d42dea721dc	505aa5d3-9028-4827-9cfa-e35992f4d963	user	0	1	2015-07-31 10:34:12.535-04	505aa5d3-9028-4827-9cfa-e35992f4d963	2015-07-31 10:34:12.044-04	505aa5d3-9028-4827-9cfa-e35992f4d963
71b6c56b-53c7-499b-8f7c-6dc897826050	d0b3d250-9659-4717-b583-2fd7ecbdf913	user	0	1	2015-08-02 19:08:27.241-04	d0b3d250-9659-4717-b583-2fd7ecbdf913	2015-08-02 19:08:26.514-04	d0b3d250-9659-4717-b583-2fd7ecbdf913
f27be577-c460-4729-8f36-b550e2089087	32aea253-36e7-4b71-8fb3-e46e9f757bfc	user	0	1	2015-08-03 18:52:52.113-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc	2015-08-03 18:52:51.628-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc
328086a9-387b-4b56-a3b6-134b03e036a1	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	user	0	1	2015-08-04 08:08:49.968-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	2015-08-04 08:08:49.388-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1
ec1e1c41-0fc8-4944-8d17-4eaca197e86c	8efcd5d9-df90-49c5-bae1-6420e8628e74	user	0	1	2015-08-06 10:53:26.923-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-06 10:53:26.412-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
3a53725b-1e3a-4806-80e5-c7885714e5c1	84bf0d55-d547-416a-8bce-0e5d7d7ddc96	user	0	1	2015-08-06 17:47:09.876-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96	2015-08-06 17:47:09.402-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96
0999ff23-4bdf-4ebe-b1c0-9050c0b5b183	adbb7632-8173-4c03-9211-2dbb3e5e64c4	user	0	1	2015-08-08 12:39:13.439-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4	2015-08-08 12:39:12.959-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4
f750afb8-4bd0-4f0c-afcc-50dad2364579	11ee25db-8720-4e02-aacd-f33e2e313375	user	0	1	2015-08-09 05:18:21.722-04	11ee25db-8720-4e02-aacd-f33e2e313375	2015-08-09 05:18:21.202-04	11ee25db-8720-4e02-aacd-f33e2e313375
6d0d9391-d7c3-4dde-9c2e-ad919bc2e8df	47da5910-d577-4386-89a9-e271be4a2f4f	user	0	1	2015-08-13 08:42:11.403-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:42:10.907-04	47da5910-d577-4386-89a9-e271be4a2f4f
a7efdee0-1842-45c0-88e3-2947ab275c63	470cb0b5-a9f5-4c7a-b261-329056220023	user	0	1	2015-08-13 10:42:23.861-04	470cb0b5-a9f5-4c7a-b261-329056220023	2015-08-13 10:42:23.429-04	470cb0b5-a9f5-4c7a-b261-329056220023
e927b0c7-b4bd-4cc7-8c2d-591255b58a5d	d5e8db62-f918-4ff9-b891-4cec9d647ea5	user	0	1	2015-08-16 11:24:21.096-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5	2015-08-16 11:24:20.458-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5
c5ef8ffd-1050-4d41-b779-351439098ade	e604c054-19e1-4332-b9ae-97ef0c58380f	user	0	1	2015-08-18 22:29:08.526-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-18 22:29:08.078-04	e604c054-19e1-4332-b9ae-97ef0c58380f
80d955c6-4b28-4759-a505-9b581c8be76e	86be876f-32c6-496c-953a-48ee6ad2dc10	user	0	1	2015-08-19 23:05:40.989-04	86be876f-32c6-496c-953a-48ee6ad2dc10	2015-08-19 23:05:40.474-04	86be876f-32c6-496c-953a-48ee6ad2dc10
4285f058-c56b-454b-9e6a-ea170d3acd10	c0697e56-11bf-4e37-a029-aac44d1af67c	user	0	1	2015-08-26 11:56:20.886-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 11:56:20.348-04	c0697e56-11bf-4e37-a029-aac44d1af67c
b0cb0425-25fe-47ed-b91b-b4916474e1d7	0f1beec1-dbc9-458f-a5f6-ce714b91369a	user	0	1	2015-08-26 13:56:26.104-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a	2015-08-26 13:56:25.68-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a
135db018-bf4d-4639-9887-8a8d73e343a1	3fd5a3de-cf27-460f-a3cf-8104c4527c5c	user	0	1	2015-08-26 18:53:39.684-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c	2015-08-26 18:53:39.253-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c
5ce9f485-251d-43c4-b6e3-b5ee31ba4c34	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	user	0	1	2015-08-27 05:21:00.647-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	2015-08-27 05:21:00.212-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544
fade773b-a164-45e6-9ccb-a5e1f483f79e	a1e17f3f-cc53-48a7-a4b1-b600a36fca05	user	0	1	2015-08-28 08:07:50.267-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05	2015-08-28 08:07:49.82-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05
2ae20925-b08d-4904-849c-bd1051dc5e7c	b698f42c-ef50-438c-9254-f2d0ef64fc33	user	0	1	2015-08-28 10:57:18.634-04	b698f42c-ef50-438c-9254-f2d0ef64fc33	2015-08-28 10:57:18.151-04	b698f42c-ef50-438c-9254-f2d0ef64fc33
e55643ba-1039-4bc3-ae7c-416cddcf60f6	0f5cc00a-ab76-425f-9150-8072eae9bf75	user	0	1	2015-08-29 21:50:23.662-04	0f5cc00a-ab76-425f-9150-8072eae9bf75	2015-08-29 21:50:23.169-04	0f5cc00a-ab76-425f-9150-8072eae9bf75
a5ef5478-3dda-42e5-a5ad-4aa2081e9da6	89b13534-20eb-49d7-914c-d84a673f858d	user	0	1	2015-08-30 21:39:31.082-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:39:30.638-04	89b13534-20eb-49d7-914c-d84a673f858d
eda56bcc-f395-45fc-9006-42290cade000	a5ef1333-2472-4bcb-b357-98c20ec3c93e	user	0	1	2015-08-31 15:15:28.421-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e	2015-08-31 15:15:27.957-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e
90a3666e-bbab-4530-82b3-2a088b5f2b72	3f208971-2778-4ac6-b00a-52c05d0d7597	user	0	1	2015-09-03 08:35:01.313-04	3f208971-2778-4ac6-b00a-52c05d0d7597	2015-09-03 08:35:00.704-04	3f208971-2778-4ac6-b00a-52c05d0d7597
dfbd8b26-b379-4b59-91fd-7ae214c39d4c	4b4b2595-96d5-4a70-bf64-e150de4cecf1	user	0	1	2015-09-03 18:18:43.231-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1	2015-09-03 18:18:42.712-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1
6ab0090e-7844-403a-961c-d10d807ee8a2	86103f7b-c3bd-489b-a732-10374a07ed5a	user	0	1	2015-09-04 21:53:06.482-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-09-04 21:53:06.063-04	86103f7b-c3bd-489b-a732-10374a07ed5a
5125098c-a291-43af-b3b8-dfe992835d11	644eb96f-6f1f-47aa-a5dc-d5869c2963df	user	0	1	2015-09-06 01:55:20.125-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df	2015-09-06 01:55:19.592-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df
3d44ffdf-cc82-42fa-8570-6ca8e15d1267	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	user	0	1	2015-09-10 02:30:49.955-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:30:49.444-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c
120a1bfb-d75f-458b-b7e8-5f8f937b452f	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	user	0	1	2015-09-10 15:24:51.911-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	2015-09-10 15:24:51.403-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a
f2fe7eb8-fe31-4e6a-be30-ae0b965ce7a8	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	user	0	1	2015-09-13 00:45:05.567-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	2015-09-13 00:45:05.067-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3
7d67c77b-7f8e-4044-9280-19e544ecd481	ffe3a005-5547-420a-a06e-1b0c8349bf51	user	0	1	2015-09-13 21:31:56.169-04	ffe3a005-5547-420a-a06e-1b0c8349bf51	2015-09-13 21:31:55.671-04	ffe3a005-5547-420a-a06e-1b0c8349bf51
b908d61e-daf4-43c9-95d2-2b98fc1e5f77	4f221611-83b3-4c94-95e4-9062e001b55b	user	0	1	2015-09-14 09:17:24.064-04	4f221611-83b3-4c94-95e4-9062e001b55b	2015-09-14 09:17:23.605-04	4f221611-83b3-4c94-95e4-9062e001b55b
9b47cadc-2cd4-45b5-b16e-345cba27fff4	7871755b-f26b-4b3b-9eca-124c725d5aa1	user	0	1	2015-09-15 12:44:33.143-04	7871755b-f26b-4b3b-9eca-124c725d5aa1	2015-09-15 12:44:32.677-04	7871755b-f26b-4b3b-9eca-124c725d5aa1
f7042276-9f57-49c7-928f-3f6544a2151b	9ec76276-7e09-41dd-aed1-bda46d79a89a	user	0	1	2015-09-25 09:36:01.047-04	9ec76276-7e09-41dd-aed1-bda46d79a89a	2015-09-25 09:36:00.521-04	9ec76276-7e09-41dd-aed1-bda46d79a89a
f6ba287a-d5b6-4c48-ae9a-24b2c152d039	b842c097-ef8f-4d48-9e26-3ad73fe28b68	user	0	1	2015-09-27 11:03:58.098-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68	2015-09-27 11:03:57.62-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68
afa8de64-3be8-4b8b-9a4f-aa32d08a08bb	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	user	0	1	2015-09-28 11:43:20.062-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:43:19.551-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a
3edc9edf-e94a-4e23-9afd-e84b51ea7920	621af548-c387-471f-9d6d-ef4a20c81eb2	user	0	1	2015-09-30 03:02:31.212-04	621af548-c387-471f-9d6d-ef4a20c81eb2	2015-09-30 03:02:30.719-04	621af548-c387-471f-9d6d-ef4a20c81eb2
12b2562f-1186-47e5-86d5-9297b1e377c4	ee2ef90f-e171-4422-b6a7-d783584c27b4	user	0	1	2015-10-09 09:27:45.212-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	2015-10-09 09:27:44.654-04	ee2ef90f-e171-4422-b6a7-d783584c27b4
14552295-e2fa-4600-9612-66fabde0df82	51855703-9a42-4c37-8418-24da5bf57be7	user	0	1	2015-10-19 13:55:18.434-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 13:55:17.864-04	51855703-9a42-4c37-8418-24da5bf57be7
1d5e9a8d-40d3-4cfa-b1be-bd0b69ff10ee	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	user	0	1	2015-10-19 18:09:31.672-04	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	2015-10-19 18:09:31.242-04	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd
bcb3a49c-7024-4f5b-9397-ca62cd5dc09b	9b53f8fe-453f-4512-9016-81c3f56c16b5	user	0	1	2015-10-19 18:23:51.384-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	2015-10-19 18:23:50.889-04	9b53f8fe-453f-4512-9016-81c3f56c16b5
1619dd7a-b909-4bbe-a2bf-22436eca22d3	cca78e0c-34ac-4a21-9564-b391dbe19ec2	user	0	1	2015-10-19 18:50:25.504-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2	2015-10-19 18:50:25.064-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2
0d0b8c25-85dd-44ec-bdb9-9de2868d7d7f	d2311570-b0de-4b85-8af2-084bde99159d	user	0	1	2015-10-19 20:17:14.753-04	d2311570-b0de-4b85-8af2-084bde99159d	2015-10-19 20:17:14.307-04	d2311570-b0de-4b85-8af2-084bde99159d
c9de310b-9f00-4c83-9542-10de9103c2e6	9a5f7b41-5057-4940-a321-30eb50b50554	user	0	1	2015-10-19 23:21:10.279-04	9a5f7b41-5057-4940-a321-30eb50b50554	2015-10-19 23:21:09.79-04	9a5f7b41-5057-4940-a321-30eb50b50554
b8ba77be-a4fa-4ec1-be12-a0ecc2564625	0455bfd0-c938-480d-a68a-9cbff8e72cc1	user	0	1	2015-10-20 07:55:05.92-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1	2015-10-20 07:55:05.46-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1
7e625a74-6c09-461a-901d-c90bfb14a855	96b9a7e8-5273-40ab-ac79-65548e56a63a	user	0	1	2015-10-20 20:38:03.755-04	96b9a7e8-5273-40ab-ac79-65548e56a63a	2015-10-20 20:38:03.268-04	96b9a7e8-5273-40ab-ac79-65548e56a63a
3a4e9c2a-9804-4aef-9e2a-d21a74af0ee6	ac137c0e-5239-4124-891a-0f32554a48f5	user	0	1	2015-10-22 18:26:29.419-04	ac137c0e-5239-4124-891a-0f32554a48f5	2015-10-22 18:26:28.945-04	ac137c0e-5239-4124-891a-0f32554a48f5
e328f191-a23c-42c4-9cf9-79537eef3662	c6a75811-f89a-498c-82ca-e5bc63c87087	user	0	1	2015-10-23 22:45:17.79-04	c6a75811-f89a-498c-82ca-e5bc63c87087	2015-10-23 22:45:17.35-04	c6a75811-f89a-498c-82ca-e5bc63c87087
21e0137e-a443-4106-9858-8fa1b4c4553e	188a89cb-562b-45d2-ac34-32ac98e27a7e	user	0	1	2015-10-24 20:16:41.714-04	188a89cb-562b-45d2-ac34-32ac98e27a7e	2015-10-24 20:16:41.234-04	188a89cb-562b-45d2-ac34-32ac98e27a7e
832d6b89-e823-47f4-ae37-fce52e11fe56	fb08c1d6-72b8-4439-8714-4472d0aa057b	user	0	1	2015-10-28 10:29:19.637-04	fb08c1d6-72b8-4439-8714-4472d0aa057b	2015-10-28 10:29:19.175-04	fb08c1d6-72b8-4439-8714-4472d0aa057b
1481f6c0-6921-445e-a14c-13563c8f79d4	a43e9817-e631-4f88-869e-eadb767fe78d	user	0	1	2015-10-29 18:19:47.853-04	a43e9817-e631-4f88-869e-eadb767fe78d	2015-10-29 18:19:47.379-04	a43e9817-e631-4f88-869e-eadb767fe78d
0d577b41-185f-46d7-b371-b6ed353eb843	e43c4619-cec8-433e-a6cb-c6f5c2bf606d	user	0	1	2015-10-30 17:30:18.477-04	e43c4619-cec8-433e-a6cb-c6f5c2bf606d	2015-10-30 17:30:18.066-04	e43c4619-cec8-433e-a6cb-c6f5c2bf606d
16ce68b4-4ebb-40d6-a4c3-25b08757bdd4	f36bbc33-5956-4925-80db-c99850dc4a63	user	0	1	2015-11-01 20:52:36.873-05	f36bbc33-5956-4925-80db-c99850dc4a63	2015-11-01 20:52:35.985-05	f36bbc33-5956-4925-80db-c99850dc4a63
2ab71d05-da2f-4108-bda7-2d2b8337ac4a	b4244555-9faa-4b67-abbf-413e8823ec84	user	0	1	2015-11-06 16:56:13.992-05	b4244555-9faa-4b67-abbf-413e8823ec84	2015-11-06 16:56:13.547-05	b4244555-9faa-4b67-abbf-413e8823ec84
3d8eadf3-40e8-4bb1-9736-c39abe0e9c70	d6f310e5-095e-48c7-a3c7-1a0e67927ec5	user	0	1	2015-11-06 17:46:53.614-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5	2015-11-06 17:46:53.169-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5
3da23cc7-18de-4ab1-a82b-18a9960c4ca7	66beb125-c5dc-44a0-9a24-00c319871544	user	0	1	2015-11-06 17:47:15.264-05	66beb125-c5dc-44a0-9a24-00c319871544	2015-11-06 17:47:14.81-05	66beb125-c5dc-44a0-9a24-00c319871544
deab780c-68ad-4e65-b564-6e0b29a444e1	cdd26125-bcd1-434c-857d-6dfd5d4d9096	user	0	1	2015-11-06 17:53:40.635-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096	2015-11-06 17:53:40.228-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096
d7eacd02-085c-4ed6-8c3b-38198aa84f58	c5ce2449-293c-45b7-a645-74bb855e94c8	user	0	1	2015-11-06 17:56:41.47-05	c5ce2449-293c-45b7-a645-74bb855e94c8	2015-11-06 17:56:41.077-05	c5ce2449-293c-45b7-a645-74bb855e94c8
1e4a1830-9e97-45ea-9df9-cd22ec06f675	ed651fef-794c-4b5a-952f-b830e640151a	user	0	1	2015-11-06 19:26:34.405-05	ed651fef-794c-4b5a-952f-b830e640151a	2015-11-06 19:26:33.885-05	ed651fef-794c-4b5a-952f-b830e640151a
77d64316-3bec-4116-9369-be03f3291335	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	user	0	1	2015-11-06 21:57:26.987-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	2015-11-06 21:57:26.562-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634
d17c5be7-f0d5-4d4c-b369-c5d225157f22	ea629c15-7048-42c6-b0f5-68058150a4b0	user	0	1	2015-11-07 11:34:15.651-05	ea629c15-7048-42c6-b0f5-68058150a4b0	2015-11-07 11:34:15.218-05	ea629c15-7048-42c6-b0f5-68058150a4b0
3e4b2172-f902-4554-92b2-24ecde8bf9de	a6c4875f-155d-47aa-b0c8-af62a6f2492a	user	0	1	2015-11-08 09:15:01.854-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 09:15:01.317-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
5b7d7503-4b02-4cbc-940b-6ba819a56a91	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	user	0	1	2015-11-08 22:16:41.864-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:16:41.399-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
55c6c604-c195-47db-b007-a156d0b1ce41	8f1445ec-0010-417d-a847-7bf92fc78931	user	0	1	2015-11-09 22:59:39.247-05	8f1445ec-0010-417d-a847-7bf92fc78931	2015-11-09 22:59:38.814-05	8f1445ec-0010-417d-a847-7bf92fc78931
5b4d080d-91ef-4096-b6a2-ea33fb024f62	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	user	0	1	2015-11-13 15:35:00.155-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:34:59.63-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
2c84137e-3d4b-4d84-94f6-e35b0ba9cde6	b16e1efb-e20d-434e-9798-e419d3df0c33	user	0	1	2015-11-17 06:52:03.006-05	b16e1efb-e20d-434e-9798-e419d3df0c33	2015-11-17 06:52:02.45-05	b16e1efb-e20d-434e-9798-e419d3df0c33
cf997609-7c93-4f11-9f94-919069380df4	7e0634ad-f172-4baf-9d5c-2d2521697b8c	user	0	1	2015-11-17 19:31:44.392-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c	2015-11-17 19:31:43.89-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c
d8bcb619-0a61-46bd-8733-fb1002252b35	a87e2f31-a7e1-41e9-9760-ff655f43132a	user	0	1	2015-11-17 20:54:59.172-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:54:58.705-05	a87e2f31-a7e1-41e9-9760-ff655f43132a
0ae83509-16e1-4744-9050-91d52e40b2b1	76e3b5fe-cfd7-41e2-82ec-94767482ce34	user	0	1	2015-11-22 19:23:11.226-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34	2015-11-22 19:23:10.663-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34
f3e8c388-c03c-4f23-a86e-913ce118afc8	2943d175-b9f6-4e65-83a7-48f30ea66abe	user	0	1	2015-11-25 20:43:40.249-05	2943d175-b9f6-4e65-83a7-48f30ea66abe	2015-11-25 20:43:39.701-05	2943d175-b9f6-4e65-83a7-48f30ea66abe
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY address (id, personid, address1, address2, city, state, zip, type, status, version, added, addedby, changed, changedby, "primary") FROM stdin;
d10800bb-2dd7-433e-a2de-96e1d3a9dc1d	98e1ec87-3ae8-482b-bdf2-93606a7e59f3	15970 Sidney St		Wapakoneta	PA	45895	main	1	0	2015-01-21 22:41:31.075-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 22:41:30.942-05	06169b04-bb68-4868-b995-98388fa33e16	t
ea6e2822-361f-4ef5-ab73-b285339559a7	caec90bc-237e-4ea4-ad71-8ee8915915ca	10 West Auglaize		Wapakoneta	OH	45895	main	1	0	2015-01-22 20:16:05.376-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 20:16:05.236-05	06169b04-bb68-4868-b995-98388fa33e16	t
75dd6164-fe47-4e93-a61b-ddea0cded7c9	e98fa2f8-a53d-4771-9ba9-17ccb3e17403	5 W Silver St		Wapakoneta	OH	45895	main	1	0	2015-01-29 14:17:21.418-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:21.289-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
37576e66-6f7d-4e05-9437-e667b6ace05a	c7453ad2-bbc2-4e02-9036-ddea1aeecce8	5 W Silver St		Wapakoneta	OH	45895	main	1	0	2015-01-29 14:17:30.813-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:30.67-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
7945b0d7-ceb8-477e-8937-f2b17c910c34	81c6b6b2-81a5-45cd-887d-f0ec7e585de8	5 W Silver St		Wapakoneta	OH	45895	main	1	0	2015-01-29 14:17:51.336-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:51.197-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
1406758b-7e6f-4c26-90e6-6b6db4f548ed	d8a45cb6-d8de-4b38-bb1f-7b40d96ad6ba	566 Incomplete		Lima	OH	00000	main	1	0	2015-01-29 21:42:01.432-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:42:01.292-05	06169b04-bb68-4868-b995-98388fa33e16	t
6200f349-e68e-4636-8dfc-023956125b01	fa409de1-af0e-4be7-a2a2-01c209092b3e	566 Incomplete		Lima	OH	00000	main	1	0	2015-01-29 21:42:07.704-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:42:07.554-05	06169b04-bb68-4868-b995-98388fa33e16	t
44e6ccaa-b246-4348-a6e0-d2006c0eb736	3f483df0-322e-4171-a957-7398e0692772	566 Incomplete		Lima	OH	00000	main	1	0	2015-01-29 21:42:24.958-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:42:24.832-05	06169b04-bb68-4868-b995-98388fa33e16	t
d54b252d-6c63-4c87-9332-e0aae0f106f6	7f90930d-a8d0-469b-850a-a813f2296895	5555 time		wapak	OH	00000	main	1	0	2015-01-29 21:57:37.788-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:57:37.659-05	06169b04-bb68-4868-b995-98388fa33e16	t
32ebd5c9-42d7-45da-bfae-bd1a7629b1e1	79619370-4880-466d-aa70-6f6ea2fbf85b	555 time to		goto bed	CT	00000	main	1	0	2015-01-29 23:36:45.912-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:36:45.753-05	06169b04-bb68-4868-b995-98388fa33e16	t
e2e7aab7-3cff-4de7-9b46-a762f39c4d7d	103911dd-2154-486e-9395-f1d6345b013c	555 his address		minn	OH	00000	main	1	0	2015-01-30 00:01:10.729-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:10.585-05	06169b04-bb68-4868-b995-98388fa33e16	t
d2209380-8d81-41f2-a7b1-a1abaebab28a	36fdea38-dabd-42ac-b120-e83a0ba2f3f1	555 his address		minn	OH	00000	main	1	0	2015-01-30 00:01:12.861-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:12.734-05	06169b04-bb68-4868-b995-98388fa33e16	t
b9b55b22-130c-49a7-a8ae-45aa92b344b5	7a81e0e7-35fb-418e-9259-48b97cc6ac0f	555 his address		minn	OH	00000	main	1	0	2015-01-30 00:01:19.318-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:19.185-05	06169b04-bb68-4868-b995-98388fa33e16	t
c3d30a04-e1e0-48df-a3df-3e7e9b0428d0	4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1	rrrr			OH	00000	main	1	0	2015-01-30 00:05:27.442-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:05:27.309-05	06169b04-bb68-4868-b995-98388fa33e16	t
5d724d9c-de03-4bed-b752-b64117291409	d7f7b71d-c6b3-4256-909f-196e84e9cc5a	rrrr			OH	00000	main	1	0	2015-01-30 00:05:33.431-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:05:33.312-05	06169b04-bb68-4868-b995-98388fa33e16	t
14755f7c-4f9d-4965-b277-25366452f41e	37f11480-7698-43ec-83e8-e7267c49ffc8	55555		rrrtgv	CA	00000	main	1	0	2015-01-30 00:11:41.149-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:11:40.991-05	06169b04-bb68-4868-b995-98388fa33e16	t
c03d55a5-edf0-4c77-8a84-1715cd075186	09111d56-f6c8-4921-9cfa-c165583b9cde	15970		Waoakoneta	OH	00000	main	1	0	2015-01-31 10:28:27.897-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:28:27.765-05	06169b04-bb68-4868-b995-98388fa33e16	t
cd1820a7-e938-4f8c-9d61-803cdab78b3a	2120e974-8f6c-480f-a12c-b77c8675587f	1 Main St		Hilliard	OH	43026	office	1	2	2015-01-31 13:44:27.205-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-31 13:45:30.159-05	1676623f-4657-410f-87b6-db11cf461ba9	t
a7d7ca93-7904-442a-9317-d8a451a9f45a	2120e974-8f6c-480f-a12c-b77c8675587f	1 Main St		Hilliard	OH	43026	main	1	1	2015-01-31 13:45:16.609-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-31 13:45:30.168-05	1676623f-4657-410f-87b6-db11cf461ba9	f
dae75e91-84a8-461c-aee0-ae7e79787957	c8d106b5-2b79-43f8-b918-abccaf9a2c85	15970		Wapak	OH	00000	main	1	0	2015-02-02 18:40:08.939-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:40:08.815-05	06169b04-bb68-4868-b995-98388fa33e16	t
cbd1df7e-6bb0-47e7-ac55-ce8450e119ed	cae11bfb-7e0a-41f8-b248-0ff22dd15e48	155		lo	MO	65049	main	1	0	2015-02-10 09:54:53.58-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:54:53.373-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	t
29d4820c-f770-4a51-a3d8-6128bac02086	edda48c4-c027-46cf-bf89-aed65eb5bb2b	11 Kingsley cir		fairport	NY	14450	main	1	0	2015-02-12 17:26:49.497-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-12 17:26:49.334-05	769a920c-df49-4e06-9913-4d7a6d83f073	t
7d14b7d0-06fe-4ac2-9f80-757fce83ccba	1daec6cf-4d8f-44d4-a75c-3a0f6113c163	145 Forest View Drive		Crossville	TN	38558	main	1	0	2015-02-18 18:31:24.018-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:31:23.876-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
0faddb9f-4702-4ddb-be00-9d866bf74b97	132ca982-dd98-412d-9087-a41da52e9d6a	3309 Penn Meade Way		Nashville	TN	00000	main	1	0	2015-02-18 18:37:46.53-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:37:46.377-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
4c2d5b3d-3d94-4b01-a1a2-ef93ce0d8ea1	958a7255-6c35-40de-93db-09f06e9d3a1a	Thunder Hollow		Crossville	TN	38555	main	1	0	2015-02-18 18:41:09.84-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:41:09.666-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
884725b8-8d94-4c40-89ca-7db4a3b77123	7773a57e-39c0-430c-a904-ad5b4b4390c8	3064 Delta Queen Drive		Nashville	TN	00000	main	1	0	2015-02-18 18:46:57.79-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:46:57.634-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
2cc656bd-04da-4d2f-94f7-40c82180b9db	c6f15c94-491b-4ea2-84dd-51c357229721	555 test street		test	OH	76800	main	1	0	2015-02-18 21:01:49.249-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:01:49.101-05	06169b04-bb68-4868-b995-98388fa33e16	t
bc0bc32e-fbb2-47c3-a0cb-5750bc1fde52	881c4699-55ea-4aab-8fa1-8d3b3cdf605e	1167 Springs road		Grantsville	MD	22536	main	1	0	2015-02-20 17:03:29.825-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:29.655-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	t
12add870-48b8-4606-b42e-4ec622ceb666	ffad21ff-ba19-406e-bc87-50bb6e32124b	My Aire rd		russellville	OH	45168	main	1	0	2015-02-25 09:39:00.615-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:00.468-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	t
75261532-01e1-42b8-8fb7-072e1fd66271	c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	miiii		llllll	OH	43667	main	1	0	2015-03-04 20:41:44.132-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:41:43.955-05	f975c50a-beb9-4277-ba91-6505d1b37f59	t
93b6c68c-4a55-4cee-97c2-6a23001e95a8	01108665-4678-43ea-8bea-784a90fae815	105 morgan hill road ,		Morgantown	WV	26508	main	1	0	2015-03-06 15:47:17.986-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-06 15:47:17.831-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	t
b24c5b4a-d4ff-44a1-b7d9-eddbc5330300	e9e30f4f-d854-424d-9aa0-62534609aa9b	1 Lakeview Ave.		Eastchester‎	NY	10583-5114	main	1	0	2015-03-14 21:01:09.964-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 21:01:09.821-04	7878e434-6854-422a-91aa-212f8b175aa3	t
573cc15d-6629-49f5-ba60-d68be4fd5044	57cce6c1-17ed-4fb3-bfd9-ce1cbb060b50	301 Fox Run Rd		Findlay	OH	45840	main	1	0	2015-03-20 11:46:07.274-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:46:07.126-04	5c54b12e-42e9-4222-9d43-04de05218061	t
6d7b3ba2-50bd-4783-b06b-14a686b3ba6b	1200ffbc-9d03-4ef5-89af-b6c2893d0590	17184 th 21		carey	OH	43316	main	1	0	2015-03-20 11:49:18.302-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:49:18.186-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	t
c17c07c9-85be-4d5e-ac7a-292b5fbafaeb	1039afb2-b23c-4611-a76d-b7f67cb1e839	1730 hidden hill drive		verona	WI	53593	main	1	0	2015-03-20 18:19:31.326-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:19:31.193-04	fd0457a0-2d66-4a63-857b-21f224a14a47	t
b6e2d58b-cfde-4063-b06e-55a991f7d4fe	1efc6ddf-754e-4b87-a69f-4e90cce9e442	123 elm street		anywhere	AL	00000	main	1	0	2015-03-30 18:08:18.696-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 18:08:18.547-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	t
4af996d8-d6ab-4204-8b43-bf82b2aa7f2e	544f18a9-9fbe-407d-9ce7-4c45dda874df	528 Tom Brown Rd		west Union	OH	45693	main	1	0	2015-04-09 17:58:43.512-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 17:58:43.431-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	f
42af3eb3-b9cd-40e6-a46f-200e0112c8d9	b387a65d-3816-490c-84e9-5743fbbf14a4	11023 blue feather		Houston	TX	77064	main	1	0	2015-04-18 02:24:47.592-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:24:47.453-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	t
546c85d1-e6a3-4813-97b2-99a123f24d2f	bd896255-7124-4478-97c7-606bd75f241f	New hope rd		Goldsboro	NC	00000	main	1	0	2015-04-22 10:24:56.212-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-04-22 10:24:56.073-04	d7bb1e62-fe40-4774-a432-03bd53510708	t
a150525f-2721-43f0-afbe-574b951c5f0f	c0b7bdda-a97c-4772-8490-604f9c022ca5	708 Merrie Mill Road		Keswick	VA	00000	main	1	0	2015-04-23 12:04:05.712-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 12:04:05.562-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	t
289e1c4e-ef29-4b5a-a418-18faa04687a0	c4606f0b-9e13-468f-bec6-c038d978b000	4436 East Arbor Court		West Chester	OH	45069	home	1	1	2015-05-18 16:13:48.539-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:18:04.468-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
ff303df6-28b5-4e28-a60d-9c8b9262ab91	6760db3d-f5de-488b-9341-f6945c161fe7	3716 Hamilton Mason Road		Hamilton	OH	00000	main	1	0	2015-07-02 14:25:32.166-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:32.018-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
4aef1fba-70d2-4228-92b2-3f1e88829159	01224f92-b94d-45d7-aae8-1888f7605178	7070 lamplighter		Fayetteville	NC	00000	main	1	0	2015-07-08 09:30:16.164-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-07-08 09:30:16.013-04	d7bb1e62-fe40-4774-a432-03bd53510708	t
ac58b19a-760d-46c0-91b3-fda3ebc7e062	9abd2e47-ff0e-4d5e-97f9-683c3e61bfed	203 Glenn Ave		WCH	OH	43160-1711	main	1	0	2015-07-08 09:43:13.015-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-08 09:43:12.903-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
5d1845cc-bc8c-4de2-b56a-1a9cac353021	b2225f01-b777-4f75-95a5-9e9119e0d27b	111 Massanutten Road		Keezletown	VA	00000	main	1	0	2015-07-13 08:21:31.101-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:21:30.931-04	5414f676-63e9-4117-87bd-ec5577e932b7	t
040bdc56-9b27-43e3-8934-49d117f9b046	e974d03d-7779-4c6a-b68b-95f69f1423b4	220 summit Wood Drive		McHenry	MD	21541	main	1	0	2015-08-09 18:12:57.783-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:12:57.663-04	067b4635-5840-48fd-980d-ccddbe1b173d	t
6c25a231-839f-4df3-97f1-55272a7b00e8	c4568bb9-be77-46bc-bad1-1a75fc1ea00c	Gosford			OH	00000	main	1	0	2015-08-13 08:44:14.561-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:44:14.403-04	47da5910-d577-4386-89a9-e271be4a2f4f	t
9ef8f8ea-beef-4b3b-b878-4f71dbc021e4	59977c2e-d426-4c1b-aea6-98121f5d1ae2	55 test street		test	NV	89108	main	1	0	2015-08-26 12:00:53.145-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 12:00:53.01-04	c0697e56-11bf-4e37-a029-aac44d1af67c	t
e6b279c0-878b-4c9a-95c7-665238e27da9	0e54af85-b94d-40f0-b1bc-ce950b906307	5940 dahlberg dr		raleigh	NC	00000	main	1	0	2015-09-02 08:07:47.163-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-09-02 08:07:47.029-04	d7bb1e62-fe40-4774-a432-03bd53510708	t
4941bc96-4ac0-498d-94ff-d76a5d1fa8aa	9a33068a-734b-44fd-95eb-26d7c77e76f5	224 Gary Drive		Beus	CO	00000	main	1	0	2015-10-30 11:58:34.539-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:58:34.39-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
c54fb6c6-cf83-4b61-9b35-8242535ef6e6	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	224 Gary Drive			OH	00000	main	1	0	2015-10-30 12:56:04.919-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 12:56:04.801-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
ea95ac35-c37f-4db4-a60f-d9654277785f	1b13b404-484b-423f-9ed7-28f22b1633f5	111 test street		Testing vegas	NV	55555	main	1	0	2015-10-30 20:46:22.384-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:46:22.266-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
20cac380-40c3-4d90-90bf-8374b40beb62	f240903f-3947-413e-846b-673bd14c10dd	Rrrr		Rrrr	OH	Dfff	main	1	0	2015-10-30 21:17:54.667-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:17:54.545-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
552c63c5-4cee-40a1-883a-101bc0a582ba	76b254bb-262d-48bd-9bed-3b121a10efb5	224 Gary Drive		Bryan	OH	00000	main	1	0	2015-11-02 16:01:14.947-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:01:14.864-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	f
ea3fa926-d115-457f-9553-547b3a9c646d	a8eafe63-bf81-417b-a7ff-69ac6f7a1515	18372 Saint Etienne on		San Diego	CA	92128	main	1	0	2015-11-08 22:22:31.205-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:31.08-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	t
d8f4aa41-8f3a-4efc-84be-3debbbcbd387	e0185917-0f44-4891-a330-ea0434f71080	290 spring lake Rd		Southington	CT	06489	main	1	0	2015-11-17 20:58:27.774-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:58:27.651-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	t
\.


--
-- Data for Name: addresstype; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY addresstype (addresstype) FROM stdin;
home
office
billing
main
\.


--
-- Data for Name: color; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY color (id, name, version, status, added, addedby, changed, changedby) FROM stdin;
f5d61131-8480-48e0-b730-62e6c83b3c49	blue	0	1	2014-09-05 15:57:55.988-04	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-09-05 15:57:55.689-04	18e5ac49-0e0d-47b6-a3ad-2842a6168802
92727ea5-d8a0-440c-8116-99a96cf10830	orange	0	1	2014-12-22 08:45:12.536-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-22 08:45:12.456-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
f9a3b40d-e615-4748-978c-6dd1109c4157	pink	0	1	2014-12-22 08:46:44.487-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-22 08:46:44.394-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
8f97ccaa-849d-4eba-8591-6c09048344d0	silver	1	1	2014-12-22 08:41:32.167-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-22 08:49:19.944-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
ff1f409b-f0bd-4dae-96ef-d8c53531acb4	yellow	1	1	2014-12-22 08:47:27.875-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-22 08:49:32.088-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
762e2ed6-4797-4ee9-a66e-0a3b6b62d097	gold	1	1	2014-12-22 08:42:18.837-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2014-12-22 08:49:44.509-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
bdcaae4f-30d5-4ebd-a7a2-4deefc4fbb60	red	2	1	2014-09-05 15:57:55.988-04	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2015-01-06 12:58:14.257-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
539bca0e-2e9b-47b9-9681-dd692a42c249	Clear	0	1	2015-01-21 22:58:40.572-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 22:58:40.521-05	06169b04-bb68-4868-b995-98388fa33e16
317718b3-ed23-4e10-b14f-2d30d181ed9c	Tan	0	1	2015-01-21 22:59:36.498-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 22:59:36.46-05	06169b04-bb68-4868-b995-98388fa33e16
e4906e3b-5e8a-4b46-a7a3-1c093454d06b	Light Gray	1	1	2014-09-05 15:57:55.988-04	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2015-01-21 22:59:54.202-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
d8e7b441-1223-4e20-871e-8a5f72389b7e	Dark Tan	2	1	2015-01-12 21:08:33.353-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2015-01-21 23:00:20.679-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
4d31d84b-2dd8-416d-8456-877fbb37ea95	Pearl	0	1	2015-01-22 17:08:25.374-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 17:08:25.316-05	06169b04-bb68-4868-b995-98388fa33e16
f9e2ee06-ebb0-445a-9d14-fb44cc5742b1	October Blaze	0	1	2015-01-22 20:13:49.586-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 20:13:49.543-05	06169b04-bb68-4868-b995-98388fa33e16
845886bb-a527-4383-81a0-26d0605f04e5	Scarlet	1	1	2015-01-30 10:58:14.713-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 12:04:07.739-05	06169b04-bb68-4868-b995-98388fa33e16
2c0e48b6-4092-4180-99a8-4c6fe68aaaa6	Forest	0	1	2015-01-30 12:28:05.639-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 12:28:05.584-05	06169b04-bb68-4868-b995-98388fa33e16
43b00210-057e-471b-bbe3-0db78944e7ef	Buff	0	1	2015-01-31 10:56:08.4-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:56:08.344-05	06169b04-bb68-4868-b995-98388fa33e16
5a269fd0-02bc-4dae-bb5d-4ebaa5155241	Black	1	1	2014-12-22 08:54:56.356-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2015-01-31 10:58:55.742-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802
c6ddfe98-66f4-4103-96f6-74cd557b5ba5	JQ Almond	0	1	2015-01-31 12:01:56.135-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:01:56.086-05	06169b04-bb68-4868-b995-98388fa33e16
8598a82f-ef8b-4326-902b-ab9e80789316	Medium Gray	0	1	2015-01-31 13:01:57.856-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:01:57.809-05	06169b04-bb68-4868-b995-98388fa33e16
f2c3cc6f-9040-4122-99e9-4ced12a0ca11	Bowser Bean	0	1	2015-02-02 18:34:04.141-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:34:04.082-05	06169b04-bb68-4868-b995-98388fa33e16
17da0238-3d93-4270-bc02-256f45963ee6	B-716	0	1	2015-02-05 20:08:01.323-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:08:01.275-05	06169b04-bb68-4868-b995-98388fa33e16
f0866b41-3024-4965-9a1b-34e7aeea0851	B-411	1	1	2015-02-06 13:07:45.464-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:08:03.992-05	06169b04-bb68-4868-b995-98388fa33e16
d8a62bd7-66bc-431a-8e28-eb76d0af0651	JQ Slate	0	1	2015-02-18 20:26:08.671-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:26:08.619-05	06169b04-bb68-4868-b995-98388fa33e16
c021e76c-309b-4c1e-bab9-d758ba40e324	B-325	1	1	2015-02-18 20:22:45.137-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:27:40.93-05	06169b04-bb68-4868-b995-98388fa33e16
35c549a7-8344-42a4-b9b8-5501fb5c818f	Purple	0	1	2015-02-18 20:31:31.406-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:31:31.354-05	06169b04-bb68-4868-b995-98388fa33e16
3d029a3f-177f-4113-bb37-e9310c8a4421	White	2	1	2014-12-22 08:39:57.369-05	18e5ac49-0e0d-47b6-a3ad-2842a6168802	2015-05-23 13:49:45.749-04	18e5ac49-0e0d-47b6-a3ad-2842a6168802
91ceda97-382c-41d9-8a8f-a6fc4b3ec2b2	Gray	0	1	2015-07-22 16:35:10.923-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 16:35:10.881-04	06169b04-bb68-4868-b995-98388fa33e16
34741a8f-7789-4f05-90db-06819bdbb238	New app test	0	1	2015-11-07 14:59:21.482-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-07 14:59:21.436-05	06169b04-bb68-4868-b995-98388fa33e16
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY countries (id, country) FROM stdin;
AF	Afghanistan
AX	Åland Islands
AL	Albania
DZ	Algeria
AS	American Samoa
AD	Andorra
AO	Angola
AI	Anguilla
AQ	Antarctica
AG	Antigua and Barbuda
AR	Argentina
AM	Armenia
AW	Aruba
AU	Australia
AT	Austria
AZ	Azerbaijan
BS	Bahamas
BH	Bahrain
BD	Bangladesh
BB	Barbados
BY	Belarus
BE	Belgium
BZ	Belize
BJ	Benin
BM	Bermuda
BT	Bhutan
BO	Bolivia, Plurinational State of
BQ	Bonaire, Sint Eustatius and Saba
BA	Bosnia and Herzegovina
BW	Botswana
BV	Bouvet Island
BR	Brazil
IO	British Indian Ocean Territory
BN	Brunei Darussalam
BG	Bulgaria
BF	Burkina Faso
BI	Burundi
KH	Cambodia
CM	Cameroon
CA	Canada
CV	Cape Verde
KY	Cayman Islands
CF	Central African Republic
TD	Chad
CL	Chile
CN	China
CX	Christmas Island
CC	Cocos (Keeling) Islands
CO	Colombia
KM	Comoros
CG	Congo
CD	Congo, the Democratic Republic of the
CK	Cook Islands
CR	Costa Rica
CI	Côte d'Ivoire
HR	Croatia
CU	Cuba
CW	Curaçao
CY	Cyprus
CZ	Czech Republic
DK	Denmark
DJ	Djibouti
DM	Dominica
DO	Dominican Republic
EC	Ecuador
EG	Egypt
SV	El Salvador
GQ	Equatorial Guinea
ER	Eritrea
EE	Estonia
ET	Ethiopia
FK	Falkland Islands (Malvinas)
FO	Faroe Islands
FJ	Fiji
FI	Finland
FR	France
GF	French Guiana
PF	French Polynesia
TF	French Southern Territories
GA	Gabon
GM	Gambia
GE	Georgia
DE	Germany
GH	Ghana
GI	Gibraltar
GR	Greece
GL	Greenland
GD	Grenada
GP	Guadeloupe
GU	Guam
GT	Guatemala
GG	Guernsey
GN	Guinea
GW	Guinea-Bissau
GY	Guyana
HT	Haiti
HM	Heard Island and McDonald Islands
VA	Holy See (Vatican City State)
HN	Honduras
HK	Hong Kong
HU	Hungary
IS	Iceland
IN	India
ID	Indonesia
IR	Iran, Islamic Republic of
IQ	Iraq
IE	Ireland
IM	Isle of Man
IL	Israel
IT	Italy
JM	Jamaica
JP	Japan
JE	Jersey
JO	Jordan
KZ	Kazakhstan
KE	Kenya
KI	Kiribati
KP	Korea, Democratic Peoples Republic of
KR	Korea, Republic of
KW	Kuwait
KG	Kyrgyzstan
LA	Lao Peoples Democratic Republic
LV	Latvia
LB	Lebanon
LS	Lesotho
LR	Liberia
LY	Libya
LI	Liechtenstein
LT	Lithuania
LU	Luxembourg
MO	Macao
MK	Macedonia, the former Yugoslav Republic of
MG	Madagascar
MW	Malawi
MY	Malaysia
MV	Maldives
ML	Mali
MT	Malta
MH	Marshall Islands
MQ	Martinique
MR	Mauritania
MU	Mauritius
YT	Mayotte
MX	Mexico
FM	Micronesia, Federated States of
MD	Moldova, Republic of
MC	Monaco
MN	Mongolia
ME	Montenegro
MS	Montserrat
MA	Morocco
MZ	Mozambique
MM	Myanmar
NA	Namibia
NR	Nauru
NP	Nepal
NL	Netherlands
NC	New Caledonia
NZ	New Zealand
NI	Nicaragua
NE	Niger
NG	Nigeria
NU	Niue
NF	Norfolk Island
MP	Northern Mariana Islands
NO	Norway
OM	Oman
PK	Pakistan
PW	Palau
PS	Palestinian Territory, Occupied
PA	Panama
PG	Papua New Guinea
PY	Paraguay
PE	Peru
PH	Philippines
PN	Pitcairn
PL	Poland
PT	Portugal
PR	Puerto Rico
QA	Qatar
RE	Réunion
RO	Romania
RU	Russian Federation
RW	Rwanda
BL	Saint Barthélemy
SH	Saint Helena, Ascension and Tristan da Cunha
KN	Saint Kitts and Nevis
LC	Saint Lucia
MF	Saint Martin (French part)
PM	Saint Pierre and Miquelon
VC	Saint Vincent and the Grenadines
WS	Samoa
SM	San Marino
ST	Sao Tome and Principe
SA	Saudi Arabia
SN	Senegal
RS	Serbia
SC	Seychelles
SL	Sierra Leone
SG	Singapore
SX	Sint Maarten (Dutch part)
SK	Slovakia
SI	Slovenia
SB	Solomon Islands
SO	Somalia
ZA	South Africa
GS	South Georgia and the South Sandwich Islands
SS	South Sudan
ES	Spain
LK	Sri Lanka
SD	Sudan
SR	Suriname
SJ	Svalbard and Jan Mayen
SZ	Swaziland
SE	Sweden
CH	Switzerland
SY	Syrian Arab Republic
TW	Taiwan, Province of China
TJ	Tajikistan
TZ	Tanzania, United Republic of
TH	Thailand
TL	Timor-Leste
TG	Togo
TK	Tokelau
TO	Tonga
TT	Trinidad and Tobago
TN	Tunisia
TR	Turkey
TM	Turkmenistan
TC	Turks and Caicos Islands
TV	Tuvalu
UG	Uganda
UA	Ukraine
AE	United Arab Emirates
GB	United Kingdom
US	United States
UM	United States Minor Outlying Islands
UY	Uruguay
UZ	Uzbekistan
VU	Vanuatu
VE	Venezuela, Bolivarian Republic of
VN	Viet Nam
VG	Virgin Islands, British
VI	Virgin Islands, U.S.
WF	Wallis and Futuna
EH	Western Sahara
YE	Yemen
ZM	Zambia
ZW	Zimbabwe
\.


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY ingredient (id, name, status, version, added, addedby, changed, changedby, coverage, purchaseprice) FROM stdin;
1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	Texture Coat - Tuscan Slate / Knock-Down Finish - CP Texture Mixed W/ 7 QT of "Mixed" Resin (TEXTURE BAG)	1	6	2015-01-31 13:23:36.556-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:30:14.503-05	06169b04-bb68-4868-b995-98388fa33e16	190	39.95
4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	METALLIC PIGMENT - marble coat: 1 bottle per 1 gallon of Part A Neat Coat Epoxy (BOTTLE)	1	3	2015-01-30 18:20:23.778-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:33:01.542-05	06169b04-bb68-4868-b995-98388fa33e16	90	28
8aeb8b65-3d7e-4a28-942f-60feeacadbbe	Texture Bag	1	0	2015-01-30 10:33:38.045-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 10:33:37.988-05	06169b04-bb68-4868-b995-98388fa33e16	125	16.85
400dd88c-8266-4311-9a9f-5073977ff64c	Rubber Granules - Heavy Duty Texture System (LBS)	1	2	2015-01-30 16:13:05.18-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:23:36.366-05	06169b04-bb68-4868-b995-98388fa33e16	8	2.55
ce780dbe-0148-4e67-b478-4fea4cb405fc	Misc charge	1	2	2015-01-29 22:11:26.835-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 19:57:28.143-05	06169b04-bb68-4868-b995-98388fa33e16	1	0.1
eb970c6a-8430-4422-a233-032fea8ce39c	Epoxy Neat Coat - Primer (GAL)	1	3	2015-01-29 23:53:20.694-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:42:40.187-05	06169b04-bb68-4868-b995-98388fa33e16	125	54.5
501e6867-db1a-48cf-a14d-3a53c9a5b63f	Acrylic 25 (GAL)	1	4	2015-01-31 13:33:13.016-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:46:38.332-05	06169b04-bb68-4868-b995-98388fa33e16	170	27.95
b7c99a69-ac78-474a-bbcc-1fe27a4023e9	Klindex 30# soft bond diamond	1	0	2015-02-05 19:28:38.913-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 19:28:38.852-05	06169b04-bb68-4868-b995-98388fa33e16	5000	300
b7475b4a-6613-466d-b099-8708d527b55f	Poly 85 (GAL)	1	3	2015-01-22 09:34:37.295-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:09:25.819-05	06169b04-bb68-4868-b995-98388fa33e16	200	92.4
fb198851-cd6a-40bc-97d0-630a6ed4dec2	Wood Floor Stain (32 OZ BOTTLE)	1	2	2015-01-30 10:59:08.455-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:46:58.133-05	06169b04-bb68-4868-b995-98388fa33e16	200	39.99
5aa2a6a9-fa44-42d2-9f06-9f4fd4a1738c	Drywall	1	0	2015-03-20 12:55:16.513-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-20 12:55:16.45-04	06169b04-bb68-4868-b995-98388fa33e16	29	7.5
80b748f8-b468-447b-a391-ac4c518ec626	Flexkrete .5" thick	1	0	2015-02-06 14:12:22.911-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 14:12:22.852-05	06169b04-bb68-4868-b995-98388fa33e16	20	75
adf83d9f-8e37-40bd-b649-8eb4cb72b403	Metallic Pigment 8OZ	1	2	2015-01-22 17:08:00.89-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:24:36.534-05	06169b04-bb68-4868-b995-98388fa33e16	98	28
19c9292c-80ef-4054-b0ec-01b38a353e23	Black line 03 30#	1	0	2015-02-06 15:02:54.339-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 15:02:54.283-05	06169b04-bb68-4868-b995-98388fa33e16	8000	25
afabc446-9a56-4b18-8386-141cfbb34a48	Grout Coat - CP Texture Mixed W/ 9 QT of "Mixed" Resin (TEXTURE BAG)	1	6	2015-01-30 10:54:37.714-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:04:37.13-05	06169b04-bb68-4868-b995-98388fa33e16	210	16.85
65b99a1a-a853-47f7-bdf8-104f76aaab22	Texture Coat - CP Texture Mixed W/ 7 QT of "Mixed" Resin (TEXTURE BAG)	1	10	2015-01-30 10:56:12.495-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:21:25.403-05	06169b04-bb68-4868-b995-98388fa33e16	160	16.85
567f33cf-7575-4334-b720-dfd7515d4f64	HD RESIN - Mixed w/ Texture Mix - GROUT COAT w/ 9 quarts of mixed resin (5 GALLON RESIN CONCENTRATE)	1	15	2015-01-31 17:14:18.826-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:21:40.978-05	06169b04-bb68-4868-b995-98388fa33e16	933	132.3
793eb969-b576-4126-bba3-39284f5c1429	HD RESIN - Mixed w/ Texture Mix - TEXTURE COAT w/ 7 quarts of mixed resin (5 GALLON RESIN CONCENTRATE)	1	0	2015-02-09 20:22:46.408-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:22:46.349-05	06169b04-bb68-4868-b995-98388fa33e16	914	132.3
21909320-9ec5-45ee-81db-c28dc82e3a3b	BUFF MINERAL PIGMENT - Rustic Concrete Wood Texture Color - 2 oz per bag of texture mix (32 OZ BOTTLE)	1	6	2015-01-30 12:13:39.686-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:16:02.944-05	06169b04-bb68-4868-b995-98388fa33e16	2560	26.3
5ace29a1-0b40-4ec3-9084-26b98b410a80	Permaflex Fast Set 2nd Coat (GAL)	1	6	2015-01-29 21:52:27.253-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:54:47.204-05	06169b04-bb68-4868-b995-98388fa33e16	200	111.17
b726191f-70d5-4e53-bb28-b9d225efdbcb	BLACK MINERAL PIGMENT - Grout Color  - 7 oz per bag of texture mix (32 OZ BOTTLE)	1	5	2015-01-30 12:10:43.578-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:24:46.766-05	06169b04-bb68-4868-b995-98388fa33e16	960	23.4
e868ee90-8a90-4aec-88e3-00365cf64a94	GraniSeal - over flakes (GAL)	1	7	2015-01-21 22:56:23.399-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 22:04:39.053-04	06169b04-bb68-4868-b995-98388fa33e16	200	92.4
ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	Color Flakes (LBS)	1	9	2015-01-21 22:58:18.954-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:39:35.053-04	06169b04-bb68-4868-b995-98388fa33e16	5	2.91
0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	Epoxy Base Coat - 123 system (GAL)	1	7	2015-01-30 15:51:11.298-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:33:05.395-05	06169b04-bb68-4868-b995-98388fa33e16	200	48.69
47bfb33c-9dae-4315-a57e-a904072e6d08	ACCELERATOR - extra to fast set PermaFlex (6.4 OZ)	1	1	2015-01-31 15:41:05.323-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-10 19:02:14.005-05	06169b04-bb68-4868-b995-98388fa33e16	200	14.02
e9d51055-8986-4190-a7ee-98a77dc268b0	Protectorthane - Colored (GAL)	1	3	2015-01-30 15:53:25.999-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:36:03.607-04	06169b04-bb68-4868-b995-98388fa33e16	400	71.43
fe759c88-d7ce-4340-be48-081167e21453	Epoxy Neat Coat (GAL) over flakes @ 65' per gal	1	11	2015-01-29 23:30:24.643-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:29:54.135-04	06169b04-bb68-4868-b995-98388fa33e16	65	54.5
25893b4a-38af-4d88-bb07-27f7d6011ce3	WB Protectorthane Gloss  - on top of NEAT COAT (1.5 GAL KIT)	1	9	2015-01-30 12:21:17.533-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:10:16.493-04	06169b04-bb68-4868-b995-98388fa33e16	900	171.08
7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	Protectorthane 1000 - 1st coat over flakes @150 (GAL)	1	3	2015-01-31 08:56:52.285-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:41:38.253-04	06169b04-bb68-4868-b995-98388fa33e16	150	71.29
a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	Protectorthane 1000 - 2nd coat over flakes @300 (GAL)	1	3	2015-01-31 08:57:39.866-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:41:49.503-04	06169b04-bb68-4868-b995-98388fa33e16	300	71.29
c4feb540-a64d-4df6-8d88-5702c8730c3d	Graniseal (GAL) over quartz at 100' per gal	1	4	2015-01-31 11:37:21.488-05	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:34:33.139-04	06169b04-bb68-4868-b995-98388fa33e16	100	84.13
d953dc54-1bec-443d-947e-4d2d9543323d	Quartz - Solid colors - double broadcast (LBS)	1	7	2015-01-31 09:30:41.309-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 14:44:39.71-04	06169b04-bb68-4868-b995-98388fa33e16	1	0.74
46dbe4e8-9513-48f8-b4ef-4aa8e01b320f	Quartz - Blended colors - double broadcast (LBS)	1	3	2015-01-31 09:23:47.473-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 14:43:27.616-04	06169b04-bb68-4868-b995-98388fa33e16	1	0.84
fa108c15-c199-4531-bca9-d69bd734a51d	Graniseal (GAL) over quartz at 120' per gal	1	4	2015-01-31 11:39:36.715-05	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:35:06.502-04	06169b04-bb68-4868-b995-98388fa33e16	120	84.13
8375c3b0-7da7-4c0a-8f44-15c5ed645010	PermaFlex (GAL)	1	3	2015-01-31 15:45:22.67-05	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 16:35:59.996-04	06169b04-bb68-4868-b995-98388fa33e16	200	97.15
73b6c3ea-559e-4bc0-88e7-0e20730e2455	1/4" Stencil Tape for Rustic Concrete Wood (ROLL)	1	1	2015-01-30 12:15:17.665-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:38:22.74-05	06169b04-bb68-4868-b995-98388fa33e16	65	4.1
18362ca7-9064-4bdb-a289-edf087cac828	Permaflex Fast Set 1st Coat (GAL)	1	9	2015-01-21 22:52:39.935-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:32:07.713-05	06169b04-bb68-4868-b995-98388fa33e16	200	111.17
b910c68c-0ea3-4887-ad4a-f7313bd007e3	CP Penetrating Sealer (QUART BOTTLE)	1	1	2015-01-30 18:42:36.692-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:39:57.868-05	06169b04-bb68-4868-b995-98388fa33e16	425	62.25
80881761-08a2-4d02-ae1e-287610944eeb	Epoxy Base Coat - ProtectorFlake Base Coat (GAL)	1	3	2015-01-30 12:29:51.069-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:47:23.911-05	06169b04-bb68-4868-b995-98388fa33e16	175	48.69
ddaba673-2c58-47b5-99ef-dc31fe5285d3	LRB - Liquid Rubber Base - Heavy Duty Texture System (GAL)	1	1	2015-01-30 16:11:53.821-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:53:43.109-05	06169b04-bb68-4868-b995-98388fa33e16	60	83.25
6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	Metallic Pigment - prime coat:  1 bottle per 2 gallons of Part A Neat Coat Epoxy (BOTTLE)	1	3	2015-01-30 18:26:15.594-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:54:19.049-05	06169b04-bb68-4868-b995-98388fa33e16	390	28
c064528f-0538-4130-974b-c661091ce834	BLACK MINERAL PIGMENT - Tuscan Slate TEXTURE Color (2 OZ)	1	2	2015-01-31 14:24:40.692-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:24:51.705-05	06169b04-bb68-4868-b995-98388fa33e16	190	1.46
b8fda7d1-dd5a-4ee7-909b-821537dd2a69	BUFF MINERAL PIGMENT - Tuscan Slate TEXTURE Color (2 OZ)	1	7	2015-01-31 14:15:50.747-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:25:07.999-05	06169b04-bb68-4868-b995-98388fa33e16	190	1.64
22eabfe1-2d1e-4100-ae10-3a0824ae72a5	BUFF MINERAL PIGMENT - Tuscan Slate Grout Color (4 OZ)	1	4	2015-01-31 14:12:04.352-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:25:23.763-05	06169b04-bb68-4868-b995-98388fa33e16	210	3.29
98cff144-096a-4188-b15e-32199eead724	Poly 85 (GAL) - 1 coat over Flakes at 80 sq ft per gal	1	1	2015-05-22 16:57:08.199-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-22 16:57:24.128-04	06169b04-bb68-4868-b995-98388fa33e16	80	92
389581aa-a878-4be0-af35-5c153d603516	Poly 85 (GAL) - 1 coat over Flakes at 100 sq ft per gal	1	0	2015-05-23 08:34:13.305-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:34:13.245-04	06169b04-bb68-4868-b995-98388fa33e16	100	92
a3f29743-f27d-4372-a191-998d7bb90f39	Poly 85 (GAL) - 1 coat over Flakes at 150 sq ft per gal	1	0	2015-05-23 08:34:41.98-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:34:41.934-04	06169b04-bb68-4868-b995-98388fa33e16	150	92
64403fe0-309c-4bcc-a8cf-9be043de9cba	GraniSeal (GAL) over Neat Coat at 325 sq ft per gallon	1	0	2015-05-23 12:38:23.48-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:38:23.427-04	06169b04-bb68-4868-b995-98388fa33e16	325	92.4
16f9d96b-0acc-4506-8d70-5da5ae52a5ad	WB Protectorthane Satin  - on top of NEAT COAT (1.5 GAL KIT)	1	0	2015-05-27 15:10:48.7-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:10:48.643-04	06169b04-bb68-4868-b995-98388fa33e16	900	171.08
da43dd61-05de-4428-884e-7d9ab74695d7	Protectorthane Clear 2-component.  First coat over color flakes @150 sq ft (GAL)	1	0	2015-05-29 11:24:21.412-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:24:21.34-04	06169b04-bb68-4868-b995-98388fa33e16	150	66.73
9be7576a-f9c8-43e2-b854-005096d6ee78	Protectorthane Clear 2-component.  First coat over color flakes @300 sq ft (GAL)	1	0	2015-05-29 11:25:53.9-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:25:53.833-04	06169b04-bb68-4868-b995-98388fa33e16	300	66.73
a0a4078a-3e36-4358-9774-4e3208acee82	Graniseal (GAL) over quartz at 200' per gal	1	0	2015-07-22 14:37:02.438-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:37:02.39-04	06169b04-bb68-4868-b995-98388fa33e16	200	84.13
4cf3271d-08ff-48f3-ac3f-b4ba0faf7f62	Test ingredients	1	0	2015-11-07 15:02:03.412-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-07 15:02:03.349-05	06169b04-bb68-4868-b995-98388fa33e16	10	6.5
\.


--
-- Data for Name: ingredientcolor; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY ingredientcolor (id, ingredientid, colorid, status, version, added, addedby, changed, changedby) FROM stdin;
828a2329-3728-4c0f-b1bc-4584488b34ef	18362ca7-9064-4bdb-a289-edf087cac828	317718b3-ed23-4e10-b14f-2d30d181ed9c	1	0	2015-01-31 10:58:09.747-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:58:09.669-05	06169b04-bb68-4868-b995-98388fa33e16
e95b98f3-2a84-476d-ad6d-c8bece9929f5	18362ca7-9064-4bdb-a289-edf087cac828	3d029a3f-177f-4113-bb37-e9310c8a4421	1	0	2015-01-31 10:58:09.765-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:58:09.723-05	06169b04-bb68-4868-b995-98388fa33e16
f4bd6367-27b7-4fa0-8cd6-192208aa74e3	18362ca7-9064-4bdb-a289-edf087cac828	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 11:01:44.096-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:43.983-05	06169b04-bb68-4868-b995-98388fa33e16
cc82c37b-15c4-4279-a5c6-b584eff989a0	18362ca7-9064-4bdb-a289-edf087cac828	e4906e3b-5e8a-4b46-a7a3-1c093454d06b	1	0	2015-01-31 11:01:44.118-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.04-05	06169b04-bb68-4868-b995-98388fa33e16
0fda9cf1-ad2b-4c98-9d10-74f44813dd18	afabc446-9a56-4b18-8386-141cfbb34a48	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 11:02:47.653-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:02:47.581-05	06169b04-bb68-4868-b995-98388fa33e16
d9394031-f1eb-4568-95da-4abce60fdc21	afabc446-9a56-4b18-8386-141cfbb34a48	43b00210-057e-471b-bbe3-0db78944e7ef	1	0	2015-01-31 11:02:47.696-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:02:47.628-05	06169b04-bb68-4868-b995-98388fa33e16
7125ddef-38e4-4990-b1d4-f0f0a190a91f	5ace29a1-0b40-4ec3-9084-26b98b410a80	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 11:48:09.894-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:09.842-05	06169b04-bb68-4868-b995-98388fa33e16
476f5ba5-75a0-4af3-a87a-0a3e854d2eeb	5ace29a1-0b40-4ec3-9084-26b98b410a80	e4906e3b-5e8a-4b46-a7a3-1c093454d06b	1	0	2015-01-31 11:48:09.964-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:09.925-05	06169b04-bb68-4868-b995-98388fa33e16
ae319f33-5da4-47b2-a09e-0b7ce3491c05	5ace29a1-0b40-4ec3-9084-26b98b410a80	317718b3-ed23-4e10-b14f-2d30d181ed9c	1	0	2015-01-31 11:48:10.187-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:10.141-05	06169b04-bb68-4868-b995-98388fa33e16
8e817dc0-f032-4070-9025-6cf9da961611	5ace29a1-0b40-4ec3-9084-26b98b410a80	3d029a3f-177f-4113-bb37-e9310c8a4421	1	0	2015-01-31 11:48:10.266-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:10.228-05	06169b04-bb68-4868-b995-98388fa33e16
603e43dc-09a8-4be6-9527-44554d527af5	adf83d9f-8e37-40bd-b649-8eb4cb72b403	f9e2ee06-ebb0-445a-9d14-fb44cc5742b1	1	0	2015-01-31 11:49:51.907-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:49:51.829-05	06169b04-bb68-4868-b995-98388fa33e16
2d52f018-328a-40b6-b7a0-bd235e676340	adf83d9f-8e37-40bd-b649-8eb4cb72b403	4d31d84b-2dd8-416d-8456-877fbb37ea95	1	0	2015-01-31 11:49:51.951-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:49:51.872-05	06169b04-bb68-4868-b995-98388fa33e16
ad0f7c50-9039-46dc-a764-b5f1869f683a	adf83d9f-8e37-40bd-b649-8eb4cb72b403	845886bb-a527-4383-81a0-26d0605f04e5	1	0	2015-01-31 11:49:51.999-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:49:51.915-05	06169b04-bb68-4868-b995-98388fa33e16
5f476e19-79d9-4474-98f3-588851e70f8e	80881761-08a2-4d02-ae1e-287610944eeb	d8e7b441-1223-4e20-871e-8a5f72389b7e	1	0	2015-01-31 13:01:23.074-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:01:22.981-05	06169b04-bb68-4868-b995-98388fa33e16
b741e943-c231-4838-bed1-0f5fff4231b6	80881761-08a2-4d02-ae1e-287610944eeb	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 13:01:23.086-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:01:22.951-05	06169b04-bb68-4868-b995-98388fa33e16
2afcea3f-7c56-4cce-8c1a-b9088f1240a7	80881761-08a2-4d02-ae1e-287610944eeb	8598a82f-ef8b-4326-902b-ab9e80789316	1	0	2015-01-31 13:02:25.417-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:02:25.269-05	06169b04-bb68-4868-b995-98388fa33e16
fa0600c9-5477-47bf-98fd-22d38e624766	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	43b00210-057e-471b-bbe3-0db78944e7ef	1	0	2015-01-31 14:22:15.476-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:22:15.326-05	06169b04-bb68-4868-b995-98388fa33e16
dd997faa-9a18-401c-b50d-e72292df81e7	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	43b00210-057e-471b-bbe3-0db78944e7ef	1	0	2015-01-31 14:22:29.335-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:22:29.258-05	06169b04-bb68-4868-b995-98388fa33e16
93575dc0-07c1-4103-ab29-0e9186ff2a83	c064528f-0538-4130-974b-c661091ce834	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 14:24:40.883-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:24:40.809-05	06169b04-bb68-4868-b995-98388fa33e16
1caefa78-80ad-4401-9d67-697d0f29d3b1	65b99a1a-a853-47f7-bdf8-104f76aaab22	43b00210-057e-471b-bbe3-0db78944e7ef	1	0	2015-01-31 14:25:47.133-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:25:47.086-05	06169b04-bb68-4868-b995-98388fa33e16
6f3e4185-37c8-4316-8731-4b515bc3de3c	65b99a1a-a853-47f7-bdf8-104f76aaab22	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 14:25:47.143-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:25:47.056-05	06169b04-bb68-4868-b995-98388fa33e16
90747c94-80c7-4c45-a731-9b8d3a9d4450	8375c3b0-7da7-4c0a-8f44-15c5ed645010	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-01-31 15:45:22.905-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:45:22.808-05	06169b04-bb68-4868-b995-98388fa33e16
0c1cfe1a-714d-4e4f-9feb-61ebdb2d7f90	8375c3b0-7da7-4c0a-8f44-15c5ed645010	3d029a3f-177f-4113-bb37-e9310c8a4421	1	0	2015-01-31 15:45:23.088-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:45:22.987-05	06169b04-bb68-4868-b995-98388fa33e16
b7dc923f-f097-457a-bdc5-ee4c06b883e6	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	2c0e48b6-4092-4180-99a8-4c6fe68aaaa6	1	0	2015-01-31 16:33:01.713-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:33:01.672-05	06169b04-bb68-4868-b995-98388fa33e16
602711be-e927-4fe6-a168-06971b974adf	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	845886bb-a527-4383-81a0-26d0605f04e5	1	0	2015-01-31 16:33:02.025-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:33:01.972-05	06169b04-bb68-4868-b995-98388fa33e16
b4ab1370-2c41-459f-8d37-fb4e0de0f852	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	4d31d84b-2dd8-416d-8456-877fbb37ea95	1	0	2015-01-31 16:33:02.034-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:33:01.931-05	06169b04-bb68-4868-b995-98388fa33e16
f7721641-0ace-4ea0-8e07-9d07f838fec3	ce780dbe-0148-4e67-b478-4fea4cb405fc	f9e2ee06-ebb0-445a-9d14-fb44cc5742b1	1	0	2015-01-31 19:57:28.32-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 19:57:28.264-05	06169b04-bb68-4868-b995-98388fa33e16
6cd4723a-37e4-4d13-aeba-65cd6635733f	ce780dbe-0148-4e67-b478-4fea4cb405fc	4d31d84b-2dd8-416d-8456-877fbb37ea95	1	0	2015-01-31 19:57:28.712-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 19:57:28.63-05	06169b04-bb68-4868-b995-98388fa33e16
c1123764-040f-4d25-b873-5feebff64731	ce780dbe-0148-4e67-b478-4fea4cb405fc	845886bb-a527-4383-81a0-26d0605f04e5	1	0	2015-01-31 19:57:28.741-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 19:57:28.602-05	06169b04-bb68-4868-b995-98388fa33e16
ac8ca3fc-bb53-4751-a73b-2ea06f2a6ce6	e868ee90-8a90-4aec-88e3-00365cf64a94	539bca0e-2e9b-47b9-9681-dd692a42c249	1	0	2015-02-03 18:04:51.395-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:04:51.309-05	06169b04-bb68-4868-b995-98388fa33e16
4555194f-970a-4b29-8878-869790ad1731	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c6ddfe98-66f4-4103-96f6-74cd557b5ba5	1	0	2015-02-04 18:14:57.283-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:14:57.229-05	06169b04-bb68-4868-b995-98388fa33e16
15d8c45d-670d-4626-89c5-9f187530ae9b	501e6867-db1a-48cf-a14d-3a53c9a5b63f	539bca0e-2e9b-47b9-9681-dd692a42c249	1	0	2015-02-04 18:46:38.569-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:46:38.502-05	06169b04-bb68-4868-b995-98388fa33e16
db17586c-0378-4810-be62-f521150694db	b7475b4a-6613-466d-b099-8708d527b55f	539bca0e-2e9b-47b9-9681-dd692a42c249	1	0	2015-02-05 14:21:59.07-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 14:21:59.02-05	06169b04-bb68-4868-b995-98388fa33e16
c1c97b45-1c17-4e6f-b1c8-64e957c1f81e	fe759c88-d7ce-4340-be48-081167e21453	539bca0e-2e9b-47b9-9681-dd692a42c249	1	0	2015-02-05 16:56:28.626-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 16:56:28.569-05	06169b04-bb68-4868-b995-98388fa33e16
18a0e775-a4ab-4591-b95c-9e853f96f768	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	17da0238-3d93-4270-bc02-256f45963ee6	1	0	2015-02-05 20:08:49.177-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:08:49.122-05	06169b04-bb68-4868-b995-98388fa33e16
b128b44a-e10b-45dc-b28e-e98290371b56	eb970c6a-8430-4422-a233-032fea8ce39c	539bca0e-2e9b-47b9-9681-dd692a42c249	1	0	2015-02-06 11:42:40.482-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:42:40.373-05	06169b04-bb68-4868-b995-98388fa33e16
cac8a481-f709-4a14-840b-77cdd110cea3	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-02-06 13:09:29.843-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:09:29.79-05	06169b04-bb68-4868-b995-98388fa33e16
6485770b-1370-429c-b04e-4d6d8ebba1ec	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	d8e7b441-1223-4e20-871e-8a5f72389b7e	1	0	2015-02-06 13:09:30.364-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:09:30.198-05	06169b04-bb68-4868-b995-98388fa33e16
02f85277-e631-44c6-a2ff-82274c29198b	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	8598a82f-ef8b-4326-902b-ab9e80789316	1	0	2015-02-06 13:09:30.393-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:09:30.287-05	06169b04-bb68-4868-b995-98388fa33e16
a7cf2cab-52b6-42ff-b6b0-253c2403fb8f	adf83d9f-8e37-40bd-b649-8eb4cb72b403	f2c3cc6f-9040-4122-99e9-4ced12a0ca11	1	0	2015-02-06 13:24:36.723-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:24:36.678-05	06169b04-bb68-4868-b995-98388fa33e16
bd2e0536-82ff-4b9a-af86-fb9ee9bd56f6	80b748f8-b468-447b-a391-ac4c518ec626	e4906e3b-5e8a-4b46-a7a3-1c093454d06b	1	0	2015-02-06 14:12:23.133-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 14:12:23.09-05	06169b04-bb68-4868-b995-98388fa33e16
4c5622a7-cbe4-4c66-8b9c-feed794dfb7e	e9d51055-8986-4190-a7ee-98a77dc268b0	d8e7b441-1223-4e20-871e-8a5f72389b7e	1	0	2015-02-10 18:17:22.909-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-10 18:17:22.849-05	06169b04-bb68-4868-b995-98388fa33e16
7044518a-849c-493d-b3e0-a87cf58b0e16	e9d51055-8986-4190-a7ee-98a77dc268b0	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-02-10 18:17:22.926-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-10 18:17:22.819-05	06169b04-bb68-4868-b995-98388fa33e16
bebf890d-d9c3-454c-aa10-8c85b42f2e2d	e9d51055-8986-4190-a7ee-98a77dc268b0	3d029a3f-177f-4113-bb37-e9310c8a4421	1	0	2015-02-10 18:17:23.131-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-10 18:17:23.031-05	06169b04-bb68-4868-b995-98388fa33e16
4092d1b8-7ce7-4cb0-a73c-e15e935e2504	e9d51055-8986-4190-a7ee-98a77dc268b0	8598a82f-ef8b-4326-902b-ab9e80789316	1	0	2015-02-10 18:17:23.144-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-10 18:17:22.998-05	06169b04-bb68-4868-b995-98388fa33e16
4952dba0-be81-4b06-be21-7e4eb82fd6d0	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	f0866b41-3024-4965-9a1b-34e7aeea0851	1	0	2015-02-18 20:23:40.636-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:23:40.526-05	06169b04-bb68-4868-b995-98388fa33e16
378d331a-8b4f-4207-8643-66a32ffd775c	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c021e76c-309b-4c1e-bab9-d758ba40e324	1	0	2015-02-18 20:23:40.647-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:23:40.497-05	06169b04-bb68-4868-b995-98388fa33e16
99a079c4-8de0-4c5a-92e0-dd264da0d447	8375c3b0-7da7-4c0a-8f44-15c5ed645010	91ceda97-382c-41d9-8a8f-a6fc4b3ec2b2	1	0	2015-07-22 16:36:02.622-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 16:36:02.537-04	06169b04-bb68-4868-b995-98388fa33e16
18d7f1eb-1b9f-49d4-b463-12d8fae5ea93	8375c3b0-7da7-4c0a-8f44-15c5ed645010	d8e7b441-1223-4e20-871e-8a5f72389b7e	1	0	2015-07-22 16:36:02.627-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 16:36:02.511-04	06169b04-bb68-4868-b995-98388fa33e16
4ca34a5d-837c-48b9-b3c1-72b4e8027a69	4cf3271d-08ff-48f3-ac3f-b4ba0faf7f62	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	1	0	2015-11-07 15:02:03.618-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-07 15:02:03.56-05	06169b04-bb68-4868-b995-98388fa33e16
60aeb2a2-7d71-4c3c-a23e-98edab186514	4cf3271d-08ff-48f3-ac3f-b4ba0faf7f62	d8e7b441-1223-4e20-871e-8a5f72389b7e	1	0	2015-11-07 15:02:04.09-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-07 15:02:03.984-05	06169b04-bb68-4868-b995-98388fa33e16
6a3617b0-f6ba-4075-a6d9-31ade7cc267e	4cf3271d-08ff-48f3-ac3f-b4ba0faf7f62	43b00210-057e-471b-bbe3-0db78944e7ef	1	0	2015-11-07 15:02:04.099-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-07 15:02:03.947-05	06169b04-bb68-4868-b995-98388fa33e16
\.


--
-- Data for Name: ingredientpattern; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY ingredientpattern (id, ingredientid, patternid, status, version, added, addedby, changed, changedby) FROM stdin;
b67441c0-de16-4cff-988b-e4990d86c1d5	18362ca7-9064-4bdb-a289-edf087cac828	085c7581-aec0-4c59-bca3-f2cb8dfa5c76	1	0	2015-01-31 11:01:44.346-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.273-05	06169b04-bb68-4868-b995-98388fa33e16
2362ed81-8ff5-4e66-9dc3-5095503d949b	18362ca7-9064-4bdb-a289-edf087cac828	8411780d-a4cc-4852-809d-a394610680c4	1	0	2015-01-31 11:01:44.37-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.32-05	06169b04-bb68-4868-b995-98388fa33e16
c3103847-903b-44ef-9f5b-6518d02528f5	18362ca7-9064-4bdb-a289-edf087cac828	9dfbca6c-e2ed-4ac1-a1ff-fe721f0bc935	1	0	2015-01-31 11:01:44.597-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.468-05	06169b04-bb68-4868-b995-98388fa33e16
ca3e5cdd-3244-41b4-adbb-0756c7ee5bdb	18362ca7-9064-4bdb-a289-edf087cac828	aa8fc17d-09e7-4534-a1ff-ef3928a3a998	1	0	2015-01-31 11:01:44.617-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.531-05	06169b04-bb68-4868-b995-98388fa33e16
91251e48-ec7d-4b89-971f-2b1b77f75f17	18362ca7-9064-4bdb-a289-edf087cac828	fcc0b1d8-f911-4e38-bedb-18b96cc98a00	1	0	2015-01-31 11:01:44.67-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:01:44.573-05	06169b04-bb68-4868-b995-98388fa33e16
a7779c01-4d3a-466d-b998-9148539b8a17	5ace29a1-0b40-4ec3-9084-26b98b410a80	085c7581-aec0-4c59-bca3-f2cb8dfa5c76	1	0	2015-01-31 11:48:10.426-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:10.382-05	06169b04-bb68-4868-b995-98388fa33e16
2c6cc497-24ac-4251-a37b-48a41b3d6598	5ace29a1-0b40-4ec3-9084-26b98b410a80	8411780d-a4cc-4852-809d-a394610680c4	1	0	2015-01-31 11:48:10.556-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:10.501-05	06169b04-bb68-4868-b995-98388fa33e16
63577faf-0472-45dd-a43d-a41f15942928	5ace29a1-0b40-4ec3-9084-26b98b410a80	9dfbca6c-e2ed-4ac1-a1ff-fe721f0bc935	1	0	2015-01-31 11:48:10.645-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:10.589-05	06169b04-bb68-4868-b995-98388fa33e16
e49a7e55-6736-455a-84b3-e14f0888b060	5ace29a1-0b40-4ec3-9084-26b98b410a80	aa8fc17d-09e7-4534-a1ff-ef3928a3a998	1	0	2015-01-31 11:48:11.71-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:48:11.654-05	06169b04-bb68-4868-b995-98388fa33e16
2012af54-0de6-4604-83fd-033f72dab715	18362ca7-9064-4bdb-a289-edf087cac828	cc2abaf8-7e9d-4d77-adf4-0d5dd815e40b	1	0	2015-01-31 12:02:44.585-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:02:44.492-05	06169b04-bb68-4868-b995-98388fa33e16
b922c112-d1cf-4b89-84a8-e5b72a0bce24	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	0	2015-02-04 18:14:57.802-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:14:57.74-05	06169b04-bb68-4868-b995-98388fa33e16
\.


--
-- Data for Name: lead; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY lead (id, personid, status, version, added, addedby, changed, changedby) FROM stdin;
c7453ad2-bbc2-4e02-9036-ddea1aeecce8	c7453ad2-bbc2-4e02-9036-ddea1aeecce8	1	0	2015-01-29 14:17:30.995-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:30.951-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
81c6b6b2-81a5-45cd-887d-f0ec7e585de8	81c6b6b2-81a5-45cd-887d-f0ec7e585de8	1	0	2015-01-29 14:17:51.494-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:51.447-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
cb7975bf-b0ce-4217-9853-c3a57089636a	cb7975bf-b0ce-4217-9853-c3a57089636a	0	1	2015-01-31 15:28:42.402-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:35.31-05	06169b04-bb68-4868-b995-98388fa33e16
79061ab6-25c1-489f-88d4-0aa93c64287f	79061ab6-25c1-489f-88d4-0aa93c64287f	1	0	2015-01-29 16:52:20.098-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 16:52:20.053-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
1c9d30a0-0e33-4ef6-9ee9-b72e8ffceb4d	1c9d30a0-0e33-4ef6-9ee9-b72e8ffceb4d	1	0	2015-01-29 16:54:32.822-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 16:54:32.772-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
e98fa2f8-a53d-4771-9ba9-17ccb3e17403	e98fa2f8-a53d-4771-9ba9-17ccb3e17403	1	1	2015-01-29 14:17:21.585-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 21:30:54.838-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
ed45e26f-c648-4f83-8204-6a239f3c1167	ed45e26f-c648-4f83-8204-6a239f3c1167	0	3	2015-01-22 17:10:33.677-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:47.065-05	06169b04-bb68-4868-b995-98388fa33e16
7f90930d-a8d0-469b-850a-a813f2296895	7f90930d-a8d0-469b-850a-a813f2296895	0	2	2015-01-29 21:57:37.97-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:22:31.684-05	06169b04-bb68-4868-b995-98388fa33e16
3f483df0-322e-4171-a957-7398e0692772	3f483df0-322e-4171-a957-7398e0692772	0	1	2015-01-29 21:44:32.928-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:06.666-05	06169b04-bb68-4868-b995-98388fa33e16
fa409de1-af0e-4be7-a2a2-01c209092b3e	fa409de1-af0e-4be7-a2a2-01c209092b3e	0	1	2015-01-29 21:42:11.899-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:16.947-05	06169b04-bb68-4868-b995-98388fa33e16
d8a45cb6-d8de-4b38-bb1f-7b40d96ad6ba	d8a45cb6-d8de-4b38-bb1f-7b40d96ad6ba	0	1	2015-01-29 21:42:05.148-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:34.426-05	06169b04-bb68-4868-b995-98388fa33e16
5e1dff78-1ab4-4948-95f3-8a8875837b96	5e1dff78-1ab4-4948-95f3-8a8875837b96	1	0	2015-01-30 16:03:09.127-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:09.078-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
98e1ec87-3ae8-482b-bdf2-93606a7e59f3	98e1ec87-3ae8-482b-bdf2-93606a7e59f3	0	1	2015-01-21 22:41:31.586-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:16:24.263-05	06169b04-bb68-4868-b995-98388fa33e16
7958157a-0c04-44fa-af7e-a2c74f42bbd0	7958157a-0c04-44fa-af7e-a2c74f42bbd0	0	1	2015-01-31 11:11:32.793-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:17:05.039-05	06169b04-bb68-4868-b995-98388fa33e16
94e5fddb-b14f-49a4-a6f8-9fe3303f5549	94e5fddb-b14f-49a4-a6f8-9fe3303f5549	0	1	2015-01-22 09:41:50.979-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:53:06.604-05	06169b04-bb68-4868-b995-98388fa33e16
c8d106b5-2b79-43f8-b918-abccaf9a2c85	c8d106b5-2b79-43f8-b918-abccaf9a2c85	0	1	2015-02-02 18:40:09.155-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:59.899-05	06169b04-bb68-4868-b995-98388fa33e16
caec90bc-237e-4ea4-ad71-8ee8915915ca	caec90bc-237e-4ea4-ad71-8ee8915915ca	0	1	2015-01-22 20:16:05.53-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:24:37.532-05	06169b04-bb68-4868-b995-98388fa33e16
79619370-4880-466d-aa70-6f6ea2fbf85b	79619370-4880-466d-aa70-6f6ea2fbf85b	0	1	2015-01-29 23:36:47.643-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:24:52.626-05	06169b04-bb68-4868-b995-98388fa33e16
056c5531-26a1-40ed-9f99-e9853971de7d	056c5531-26a1-40ed-9f99-e9853971de7d	0	2	2015-01-29 14:32:45.916-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:17.312-05	06169b04-bb68-4868-b995-98388fa33e16
103911dd-2154-486e-9395-f1d6345b013c	103911dd-2154-486e-9395-f1d6345b013c	0	1	2015-01-30 00:01:13.194-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:48.265-05	06169b04-bb68-4868-b995-98388fa33e16
36fdea38-dabd-42ac-b120-e83a0ba2f3f1	36fdea38-dabd-42ac-b120-e83a0ba2f3f1	0	1	2015-01-30 00:01:13.993-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:06.109-05	06169b04-bb68-4868-b995-98388fa33e16
4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1	4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1	0	1	2015-01-30 00:05:29.979-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:18.863-05	06169b04-bb68-4868-b995-98388fa33e16
7a81e0e7-35fb-418e-9259-48b97cc6ac0f	7a81e0e7-35fb-418e-9259-48b97cc6ac0f	0	1	2015-01-30 00:01:20.969-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:34.814-05	06169b04-bb68-4868-b995-98388fa33e16
d7f7b71d-c6b3-4256-909f-196e84e9cc5a	d7f7b71d-c6b3-4256-909f-196e84e9cc5a	0	1	2015-01-30 00:05:34.639-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:27:11.69-05	06169b04-bb68-4868-b995-98388fa33e16
e4cf34c5-298e-4a43-a2cb-b7b8c96bbf8c	e4cf34c5-298e-4a43-a2cb-b7b8c96bbf8c	1	1	2015-02-03 18:06:49.034-05	06169b04-bb68-4868-b995-98388fa33e16	2015-04-24 00:16:58.509-04	06169b04-bb68-4868-b995-98388fa33e16
25ba2f54-ccb3-46db-ada7-bf7b47974215	25ba2f54-ccb3-46db-ada7-bf7b47974215	1	0	2015-02-03 11:28:40.016-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:28:39.958-05	4398be50-e6ac-4662-8598-3783af2fa4f3
09111d56-f6c8-4921-9cfa-c165583b9cde	09111d56-f6c8-4921-9cfa-c165583b9cde	0	1	2015-01-31 10:28:28.123-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:23:15.342-05	06169b04-bb68-4868-b995-98388fa33e16
b4c4b6b7-8078-47ab-9b37-783e664cddf3	b4c4b6b7-8078-47ab-9b37-783e664cddf3	0	1	2015-02-03 13:26:35.895-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:19:36.062-05	06169b04-bb68-4868-b995-98388fa33e16
37f11480-7698-43ec-83e8-e7267c49ffc8	37f11480-7698-43ec-83e8-e7267c49ffc8	0	1	2015-01-30 00:11:45.949-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:20:03.964-05	06169b04-bb68-4868-b995-98388fa33e16
1b66ed39-1a15-4af9-a81d-e7869e6dc02f	1b66ed39-1a15-4af9-a81d-e7869e6dc02f	0	1	2015-01-31 12:09:58.381-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:20:30.539-05	06169b04-bb68-4868-b995-98388fa33e16
d911e5d9-f428-4f86-a596-2dd36160b9d2	d911e5d9-f428-4f86-a596-2dd36160b9d2	0	1	2015-01-31 13:06:39.342-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:03.965-05	06169b04-bb68-4868-b995-98388fa33e16
a5c50cf4-2301-4f8c-9916-faecbf53e89f	a5c50cf4-2301-4f8c-9916-faecbf53e89f	0	1	2015-01-31 14:27:35.324-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:17.228-05	06169b04-bb68-4868-b995-98388fa33e16
fde2a66e-fbdb-444c-8ae1-4bdaa20be1c6	fde2a66e-fbdb-444c-8ae1-4bdaa20be1c6	0	1	2015-02-03 13:00:19.868-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:23:31.039-05	06169b04-bb68-4868-b995-98388fa33e16
0c14cbd3-c02c-4aaf-832e-b408082f1fec	0c14cbd3-c02c-4aaf-832e-b408082f1fec	1	0	2015-02-03 15:21:33.003-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 15:21:32.949-05	06169b04-bb68-4868-b995-98388fa33e16
653bf84c-56ea-4b53-bc26-d1c63e95d102	653bf84c-56ea-4b53-bc26-d1c63e95d102	1	0	2015-02-04 15:01:58.691-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:58.642-05	06169b04-bb68-4868-b995-98388fa33e16
89f6dfc4-5361-4c4a-a91d-4ef55d27c4b3	89f6dfc4-5361-4c4a-a91d-4ef55d27c4b3	1	0	2015-02-04 16:18:32.035-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:18:31.965-05	06169b04-bb68-4868-b995-98388fa33e16
ed1fdfbb-28ef-47a0-9e71-e6e3b6c07949	ed1fdfbb-28ef-47a0-9e71-e6e3b6c07949	1	0	2015-02-04 16:45:32.818-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:45:32.782-05	06169b04-bb68-4868-b995-98388fa33e16
f2a80828-6d6e-4aa4-a855-e88c58562d34	f2a80828-6d6e-4aa4-a855-e88c58562d34	1	0	2015-02-04 17:53:48.019-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:47.954-05	06169b04-bb68-4868-b995-98388fa33e16
6d515d4c-f34c-40fa-9a2d-e9c1781be9d9	6d515d4c-f34c-40fa-9a2d-e9c1781be9d9	1	0	2015-02-04 18:17:37.752-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:17:37.713-05	06169b04-bb68-4868-b995-98388fa33e16
d3263319-26b9-4bd3-964a-ec5f11c40f98	d3263319-26b9-4bd3-964a-ec5f11c40f98	1	0	2015-02-04 18:54:02.608-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:02.569-05	06169b04-bb68-4868-b995-98388fa33e16
4bb0100d-81a0-48f0-8164-e4441925e523	4bb0100d-81a0-48f0-8164-e4441925e523	1	0	2015-02-04 19:23:47.706-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 19:23:47.67-05	06169b04-bb68-4868-b995-98388fa33e16
754659e5-22c7-4c7b-a57c-8d6e2796af1c	754659e5-22c7-4c7b-a57c-8d6e2796af1c	1	0	2015-02-05 12:58:26.406-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:58:26.351-05	06169b04-bb68-4868-b995-98388fa33e16
9585caeb-fcd2-49c2-9178-5d67898cc6c7	9585caeb-fcd2-49c2-9178-5d67898cc6c7	1	0	2015-02-05 14:25:34.208-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 14:25:34.151-05	06169b04-bb68-4868-b995-98388fa33e16
c36a7d34-ad8e-440a-ae11-55d55afc28ab	c36a7d34-ad8e-440a-ae11-55d55afc28ab	1	0	2015-02-05 15:12:52.824-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:12:52.77-05	06169b04-bb68-4868-b995-98388fa33e16
0d91397b-7630-411d-844a-ca64141beeec	0d91397b-7630-411d-844a-ca64141beeec	1	0	2015-02-05 16:58:27.249-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 16:58:27.2-05	06169b04-bb68-4868-b995-98388fa33e16
92f0f8df-85ff-4820-8225-1a52e7cb91c1	92f0f8df-85ff-4820-8225-1a52e7cb91c1	1	0	2015-02-05 20:10:47.217-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:10:47.164-05	06169b04-bb68-4868-b995-98388fa33e16
91db4bd8-32b7-4bc4-9d7f-577896582110	91db4bd8-32b7-4bc4-9d7f-577896582110	1	0	2015-02-06 11:44:05.634-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:44:05.583-05	06169b04-bb68-4868-b995-98388fa33e16
9b941d78-4e8c-4c8a-b81b-40b36965b7e6	9b941d78-4e8c-4c8a-b81b-40b36965b7e6	1	0	2015-02-06 15:05:55.936-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 15:05:55.892-05	06169b04-bb68-4868-b995-98388fa33e16
6fc1cd65-f54b-40aa-9be4-c263523aa8c5	6fc1cd65-f54b-40aa-9be4-c263523aa8c5	1	0	2015-02-06 16:43:12.413-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:43:12.302-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6
3bf8ad1d-e37e-4873-931a-a8e639dc2fbd	3bf8ad1d-e37e-4873-931a-a8e639dc2fbd	1	0	2015-02-07 08:16:00.432-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:16:00.387-05	4398be50-e6ac-4662-8598-3783af2fa4f3
7f48e359-c6f6-41db-90c8-00cdb607a589	7f48e359-c6f6-41db-90c8-00cdb607a589	1	0	2015-02-08 18:59:47.915-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:47.875-05	067b4635-5840-48fd-980d-ccddbe1b173d
02a6969f-3fba-4f71-8729-41512e87d892	02a6969f-3fba-4f71-8729-41512e87d892	1	1	2015-02-08 18:50:40.754-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:13:08.739-05	067b4635-5840-48fd-980d-ccddbe1b173d
cae11bfb-7e0a-41f8-b248-0ff22dd15e48	cae11bfb-7e0a-41f8-b248-0ff22dd15e48	0	1	2015-02-10 09:54:53.787-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 10:04:17.948-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057
2cd23a09-777a-4af9-8ff5-763e565c6ec2	2cd23a09-777a-4af9-8ff5-763e565c6ec2	1	0	2015-02-10 22:24:06.491-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-10 22:24:06.445-05	c1c09c37-9dad-4c77-860e-26a64bdedba2
1361510c-3db2-4db5-adfd-04c9665cb383	1361510c-3db2-4db5-adfd-04c9665cb383	1	0	2015-02-11 15:17:45.182-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:17:45.135-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
edda48c4-c027-46cf-bf89-aed65eb5bb2b	edda48c4-c027-46cf-bf89-aed65eb5bb2b	1	0	2015-02-12 17:26:49.692-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-12 17:26:49.563-05	769a920c-df49-4e06-9913-4d7a6d83f073
c3dc65cb-9e67-4e83-965c-74fad45d1ed6	c3dc65cb-9e67-4e83-965c-74fad45d1ed6	1	0	2015-02-12 18:05:50.673-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:50.629-05	06169b04-bb68-4868-b995-98388fa33e16
4bcba17a-414f-4861-bca0-0e83856d6fba	4bcba17a-414f-4861-bca0-0e83856d6fba	1	0	2015-02-16 14:59:17.11-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 14:59:17.069-05	d86a76c4-4d99-4d16-b590-1df3c3122404
1daec6cf-4d8f-44d4-a75c-3a0f6113c163	1daec6cf-4d8f-44d4-a75c-3a0f6113c163	1	0	2015-02-18 18:31:24.206-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:31:24.162-05	21ea39bb-285f-479e-8643-f9f963edd1a3
132ca982-dd98-412d-9087-a41da52e9d6a	132ca982-dd98-412d-9087-a41da52e9d6a	1	0	2015-02-18 18:37:46.807-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:37:46.751-05	21ea39bb-285f-479e-8643-f9f963edd1a3
958a7255-6c35-40de-93db-09f06e9d3a1a	958a7255-6c35-40de-93db-09f06e9d3a1a	1	0	2015-02-18 18:41:10.053-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:41:09.992-05	21ea39bb-285f-479e-8643-f9f963edd1a3
75cd5a72-8d8d-4f3d-868a-4389e924a640	75cd5a72-8d8d-4f3d-868a-4389e924a640	1	0	2015-02-18 18:48:49.373-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:48:49.323-05	21ea39bb-285f-479e-8643-f9f963edd1a3
2120e974-8f6c-480f-a12c-b77c8675587f	2120e974-8f6c-480f-a12c-b77c8675587f	1	2	2015-01-31 12:32:24.848-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-03-14 14:34:48.053-04	1676623f-4657-410f-87b6-db11cf461ba9
7773a57e-39c0-430c-a904-ad5b4b4390c8	7773a57e-39c0-430c-a904-ad5b4b4390c8	1	1	2015-02-18 18:46:58.01-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 19:05:28.262-05	21ea39bb-285f-479e-8643-f9f963edd1a3
c6f15c94-491b-4ea2-84dd-51c357229721	c6f15c94-491b-4ea2-84dd-51c357229721	1	0	2015-02-18 21:01:49.578-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:01:49.486-05	06169b04-bb68-4868-b995-98388fa33e16
68f19c8b-d75a-4417-8e4e-8589e272ad96	68f19c8b-d75a-4417-8e4e-8589e272ad96	1	0	2015-02-19 04:06:18-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-19 04:06:17.952-05	c1c09c37-9dad-4c77-860e-26a64bdedba2
d201bb6f-983c-4337-adc7-d28958209853	d201bb6f-983c-4337-adc7-d28958209853	1	0	2015-02-20 16:53:11.323-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:53:11.252-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
91356c6b-fee0-4a32-a546-9b033e0a2933	91356c6b-fee0-4a32-a546-9b033e0a2933	1	0	2015-02-20 16:57:00.55-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:57:00.508-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
16ad538a-ebfc-40d1-91c5-fe596581c285	16ad538a-ebfc-40d1-91c5-fe596581c285	1	0	2015-02-20 16:59:04.154-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:59:04.101-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
881c4699-55ea-4aab-8fa1-8d3b3cdf605e	881c4699-55ea-4aab-8fa1-8d3b3cdf605e	1	0	2015-02-20 17:03:29.994-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:29.953-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
0e8e8038-2471-427b-8c13-1b94647a3708	0e8e8038-2471-427b-8c13-1b94647a3708	1	0	2015-02-23 07:09:14.157-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-23 07:09:14.111-05	e81db145-8364-495e-b45e-709987d0c0f7
ffad21ff-ba19-406e-bc87-50bb6e32124b	ffad21ff-ba19-406e-bc87-50bb6e32124b	1	0	2015-02-25 09:39:01.792-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:01.738-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
26cb55ed-7c80-4c45-9a01-80316476a37e	26cb55ed-7c80-4c45-9a01-80316476a37e	1	0	2015-02-26 10:48:34.054-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	2015-02-26 10:48:34.001-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72
abea0018-ded6-434a-aec5-346b53931198	abea0018-ded6-434a-aec5-346b53931198	1	1	2015-02-26 13:54:40.117-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 13:58:38.501-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
bd00a75f-716b-4d3f-9ec5-42b5a9c4b3b7	bd00a75f-716b-4d3f-9ec5-42b5a9c4b3b7	1	0	2015-02-27 09:23:52.75-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-27 09:23:52.694-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	1	0	2015-03-04 20:41:44.309-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:41:44.241-05	f975c50a-beb9-4277-ba91-6505d1b37f59
01108665-4678-43ea-8bea-784a90fae815	01108665-4678-43ea-8bea-784a90fae815	1	1	2015-03-06 15:47:18.106-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-06 15:48:40.572-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
4416b7fd-233e-4d45-849d-3117e511ca08	4416b7fd-233e-4d45-849d-3117e511ca08	1	0	2015-03-07 21:39:38.932-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-07 21:39:38.881-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7
3bf56637-f6f2-4381-bb11-96c3418ac743	3bf56637-f6f2-4381-bb11-96c3418ac743	1	0	2015-03-07 22:03:00.433-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-07 22:03:00.377-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
e95a8fa4-8767-4313-8d75-6a855565d166	e95a8fa4-8767-4313-8d75-6a855565d166	1	0	2015-03-12 14:43:34.123-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-12 14:43:34.073-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
2a7c31f6-369e-4325-b08a-3670096bb8ef	2a7c31f6-369e-4325-b08a-3670096bb8ef	1	0	2015-03-12 15:04:45.075-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:04:45.027-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
e9e30f4f-d854-424d-9aa0-62534609aa9b	e9e30f4f-d854-424d-9aa0-62534609aa9b	1	0	2015-03-14 21:01:10.136-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 21:01:10.082-04	7878e434-6854-422a-91aa-212f8b175aa3
d53448fd-3ab2-4be8-b2bb-721e5738fafc	d53448fd-3ab2-4be8-b2bb-721e5738fafc	1	0	2015-03-18 12:00:44.059-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:00:44.025-04	7878e434-6854-422a-91aa-212f8b175aa3
1f64e6da-cbc9-4b04-be2c-e3fa74ffc5a5	1f64e6da-cbc9-4b04-be2c-e3fa74ffc5a5	1	1	2015-03-18 12:01:49.053-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:02:46.76-04	7878e434-6854-422a-91aa-212f8b175aa3
af9de559-5bc7-4b41-a0b1-430ad5303743	af9de559-5bc7-4b41-a0b1-430ad5303743	1	0	2015-05-19 00:31:49.065-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-19 00:31:49.01-04	12034988-1c47-4bdd-b7ac-1751e04269ad
ab154fbf-e7ad-4df4-b80f-b4409c666909	ab154fbf-e7ad-4df4-b80f-b4409c666909	1	0	2015-03-19 20:13:25.854-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 20:13:25.808-04	503a77c4-05d0-4a6d-b282-61284bdefdf8
710783cd-e487-4885-abc8-f299f140fe9a	710783cd-e487-4885-abc8-f299f140fe9a	1	2	2015-03-19 16:51:00.021-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-20 11:45:13.361-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
1200ffbc-9d03-4ef5-89af-b6c2893d0590	1200ffbc-9d03-4ef5-89af-b6c2893d0590	1	0	2015-03-20 11:45:47.248-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:45:47.205-04	05dbb3b8-9caf-405e-ae5e-a6074822a169
57cce6c1-17ed-4fb3-bfd9-ce1cbb060b50	57cce6c1-17ed-4fb3-bfd9-ce1cbb060b50	1	0	2015-03-20 11:46:07.45-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:46:07.409-04	5c54b12e-42e9-4222-9d43-04de05218061
a95b1ef4-e69d-45b3-bf1f-f406cf75dc4a	a95b1ef4-e69d-45b3-bf1f-f406cf75dc4a	1	0	2015-03-20 11:59:58.2-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 11:59:58.16-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
fdb4b6db-e267-49be-8aa1-7a588e9a6d3f	fdb4b6db-e267-49be-8aa1-7a588e9a6d3f	1	0	2015-03-20 12:03:51.608-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:51.555-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b
c0b7bdda-a97c-4772-8490-604f9c022ca5	c0b7bdda-a97c-4772-8490-604f9c022ca5	1	1	2015-04-23 12:04:05.893-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 12:05:17.336-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
1039afb2-b23c-4611-a76d-b7f67cb1e839	1039afb2-b23c-4611-a76d-b7f67cb1e839	1	2	2015-03-20 18:19:31.544-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:36:04.949-04	fd0457a0-2d66-4a63-857b-21f224a14a47
e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	1	0	2015-03-21 15:55:41.091-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.042-04	c27e733b-f247-498a-a945-7521cca65c3b
8968b145-675a-40be-b7bf-8e7d73ac4bb4	8968b145-675a-40be-b7bf-8e7d73ac4bb4	1	1	2015-03-22 13:50:35.732-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 13:56:29.066-04	dc91c128-7614-4592-b94e-c19660131a55
f3e83ed4-0f71-48de-8f12-b601887083bd	f3e83ed4-0f71-48de-8f12-b601887083bd	1	0	2015-03-25 12:17:39.434-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	2015-03-25 12:17:39.38-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b
8b8ac017-1718-4f70-a117-cf9d94fc1eda	8b8ac017-1718-4f70-a117-cf9d94fc1eda	1	0	2015-03-29 07:44:59.276-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.228-04	9ef858fa-13d8-4152-aff7-28daea5a0842
b4dc8e16-2412-42fd-84ed-4b8a201b09fa	b4dc8e16-2412-42fd-84ed-4b8a201b09fa	1	0	2015-03-30 10:33:09.809-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-30 10:33:09.76-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
1efc6ddf-754e-4b87-a69f-4e90cce9e442	1efc6ddf-754e-4b87-a69f-4e90cce9e442	1	0	2015-03-30 18:08:18.785-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 18:08:18.741-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
22a612d0-772d-4bc0-a0d7-06e57a927e34	22a612d0-772d-4bc0-a0d7-06e57a927e34	1	0	2015-03-31 14:23:15.79-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 14:23:15.748-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
e3f56125-83d8-4419-af08-d315aa5f0afb	e3f56125-83d8-4419-af08-d315aa5f0afb	1	1	2015-03-29 13:24:57.693-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:28:46.771-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
d4ccf570-9cbd-49af-9230-3947b1c0408d	d4ccf570-9cbd-49af-9230-3947b1c0408d	1	0	2015-04-01 13:33:00.147-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:33:00.101-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
dafd2094-adc5-45dc-b36a-61142dfd2507	dafd2094-adc5-45dc-b36a-61142dfd2507	1	0	2015-04-04 17:24:44.412-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:44.363-04	84525335-0f50-4354-8dd8-f9fe584df21a
0af9286e-2a2a-45c5-81ef-fbd0ccc71d5b	0af9286e-2a2a-45c5-81ef-fbd0ccc71d5b	1	0	2015-04-04 23:36:35.289-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-04 23:36:35.24-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
3e692a5f-6853-4fe3-a0d5-8fdc2d592d73	3e692a5f-6853-4fe3-a0d5-8fdc2d592d73	1	0	2015-04-23 17:38:05.298-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:38:05.255-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
544f18a9-9fbe-407d-9ce7-4c45dda874df	544f18a9-9fbe-407d-9ce7-4c45dda874df	1	2	2015-04-09 17:55:55.573-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 17:56:54.009-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	1	0	2015-04-14 13:15:29.37-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.32-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
19b95729-0c2f-471f-a12c-0e3e470cc6bb	19b95729-0c2f-471f-a12c-0e3e470cc6bb	1	0	2015-04-17 23:14:46.624-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	2015-04-17 23:14:46.565-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98
b387a65d-3816-490c-84e9-5743fbbf14a4	b387a65d-3816-490c-84e9-5743fbbf14a4	1	0	2015-04-18 02:24:47.765-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:24:47.712-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
a99dc045-116c-4984-8e97-c49ba828de53	a99dc045-116c-4984-8e97-c49ba828de53	1	0	2015-04-18 03:29:38.474-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:29:38.432-04	41072458-fade-43dc-a1d8-543db6c37a49
3f125e85-5e84-4d28-8d7d-db1900e52cbe	3f125e85-5e84-4d28-8d7d-db1900e52cbe	1	0	2015-04-18 05:05:18.406-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-04-18 05:05:18.309-04	9ef858fa-13d8-4152-aff7-28daea5a0842
595ad16c-cc97-44f9-973d-8a8bea4682bb	595ad16c-cc97-44f9-973d-8a8bea4682bb	1	0	2015-04-18 11:23:03.984-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:23:03.944-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d
bd896255-7124-4478-97c7-606bd75f241f	bd896255-7124-4478-97c7-606bd75f241f	1	0	2015-04-22 10:24:56.389-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-04-22 10:24:56.314-04	d7bb1e62-fe40-4774-a432-03bd53510708
cfead6e4-9ae4-4584-9f67-03f4ddc48a0e	cfead6e4-9ae4-4584-9f67-03f4ddc48a0e	1	0	2015-04-27 14:02:58.55-04	b6f4370a-2301-4810-9745-5b8a2deb728d	2015-04-27 14:02:58.489-04	b6f4370a-2301-4810-9745-5b8a2deb728d
7ae87126-063a-451a-a567-0d285ca16bd5	7ae87126-063a-451a-a567-0d285ca16bd5	1	0	2015-04-28 08:01:15.104-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:15.058-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
2d91f9e1-13db-4073-95f8-566ab180d204	2d91f9e1-13db-4073-95f8-566ab180d204	1	0	2015-05-02 18:11:41.572-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:11:41.521-04	350a236f-f780-40e9-85e3-2b9227f4d76f
c44338f5-0424-4594-92f4-404202fc9ad5	c44338f5-0424-4594-92f4-404202fc9ad5	1	0	2015-05-05 19:40:47.426-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-05-05 19:40:47.376-04	9ef858fa-13d8-4152-aff7-28daea5a0842
36e29838-9bab-4f74-942e-211fe7624107	36e29838-9bab-4f74-942e-211fe7624107	1	0	2015-05-06 10:34:20.363-04	c11cfe2d-a585-42e2-a570-08b850e9a894	2015-05-06 10:34:20.317-04	c11cfe2d-a585-42e2-a570-08b850e9a894
c4606f0b-9e13-468f-bec6-c038d978b000	c4606f0b-9e13-468f-bec6-c038d978b000	1	1	2015-03-20 09:29:18.039-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:01:01.017-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
76a7c86f-b465-4236-960d-2b847f9b5137	76a7c86f-b465-4236-960d-2b847f9b5137	1	0	2015-05-19 00:20:30.093-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.045-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
49c6ee87-ab1c-46a5-8999-09739d738503	49c6ee87-ab1c-46a5-8999-09739d738503	1	0	2015-05-20 15:17:28.629-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:17:28.585-04	06169b04-bb68-4868-b995-98388fa33e16
ed0f17a5-f767-42ee-8a5d-d73334668ad5	ed0f17a5-f767-42ee-8a5d-d73334668ad5	1	0	2015-05-21 18:16:31.375-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-05-21 18:16:31.317-04	9ef858fa-13d8-4152-aff7-28daea5a0842
731ab8d0-f175-4fc7-9ee2-06f8ca374bf8	731ab8d0-f175-4fc7-9ee2-06f8ca374bf8	1	0	2015-06-01 12:04:08.081-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:08.034-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
55abc66e-bcb2-45c9-9c53-d24f0fca5957	55abc66e-bcb2-45c9-9c53-d24f0fca5957	1	0	2015-06-03 19:43:57.483-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:57.443-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
279fc46a-5ab9-41d0-979b-2e66492125c1	279fc46a-5ab9-41d0-979b-2e66492125c1	1	0	2015-06-04 08:03:36.259-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-06-04 08:03:36.201-04	9ef858fa-13d8-4152-aff7-28daea5a0842
6ae51daf-f753-4ec4-8459-b1cd81e626ef	6ae51daf-f753-4ec4-8459-b1cd81e626ef	1	0	2015-06-20 18:33:32.799-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-06-20 18:33:32.729-04	350a236f-f780-40e9-85e3-2b9227f4d76f
0b06c16f-8148-4df7-8658-f415f6fb5fe9	0b06c16f-8148-4df7-8658-f415f6fb5fe9	1	0	2015-06-21 22:11:05.319-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-06-21 22:11:05.27-04	9ef858fa-13d8-4152-aff7-28daea5a0842
7f31c83c-1703-4477-b5b4-9cedd5b9ab9b	7f31c83c-1703-4477-b5b4-9cedd5b9ab9b	1	0	2015-06-23 10:37:43.179-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:37:43.121-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
6760db3d-f5de-488b-9341-f6945c161fe7	6760db3d-f5de-488b-9341-f6945c161fe7	1	0	2015-07-02 14:25:32.343-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:32.298-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
0550dbbd-7c9b-4339-b4fb-d2ba09203650	0550dbbd-7c9b-4339-b4fb-d2ba09203650	1	0	2015-07-05 23:29:50.959-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:50.918-04	61709628-4bca-418f-8dc4-1ad358c785d6
01224f92-b94d-45d7-aae8-1888f7605178	01224f92-b94d-45d7-aae8-1888f7605178	1	0	2015-07-08 09:30:16.63-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-07-08 09:30:16.584-04	d7bb1e62-fe40-4774-a432-03bd53510708
9abd2e47-ff0e-4d5e-97f9-683c3e61bfed	9abd2e47-ff0e-4d5e-97f9-683c3e61bfed	1	0	2015-07-08 09:43:13.18-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-08 09:43:13.143-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
b2225f01-b777-4f75-95a5-9e9119e0d27b	b2225f01-b777-4f75-95a5-9e9119e0d27b	1	0	2015-07-13 08:21:31.279-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:21:31.238-04	5414f676-63e9-4117-87bd-ec5577e932b7
87d98cd3-bf10-467a-bd9c-d91f2bebf4af	87d98cd3-bf10-467a-bd9c-d91f2bebf4af	1	0	2015-07-15 19:34:16.576-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-07-15 19:34:16.532-04	9ef858fa-13d8-4152-aff7-28daea5a0842
b88d77d6-5f80-40ce-8e02-32f4e80e4608	b88d77d6-5f80-40ce-8e02-32f4e80e4608	1	0	2015-07-17 21:33:31.975-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:31.93-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
7690a61d-caec-4041-b274-7db1067cd96b	7690a61d-caec-4041-b274-7db1067cd96b	1	0	2015-07-22 15:39:13.211-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-07-22 15:39:13.16-04	2a63f4b8-4436-45bf-9439-866ac59e1911
82b2860d-fa82-443f-96e1-91da43fab547	82b2860d-fa82-443f-96e1-91da43fab547	1	0	2015-07-22 17:02:51.833-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:02:51.796-04	06169b04-bb68-4868-b995-98388fa33e16
fdc7e547-2bd3-4d0a-9919-51d96b641e5f	fdc7e547-2bd3-4d0a-9919-51d96b641e5f	1	0	2015-07-22 22:10:04.696-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:10:04.644-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
b2c2fa8f-39cd-4ea7-9b06-ea1d88b8bec9	b2c2fa8f-39cd-4ea7-9b06-ea1d88b8bec9	1	0	2015-07-24 16:03:28.565-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:03:28.517-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
af3c6f48-78bf-497f-82d6-d2e46019f7e9	af3c6f48-78bf-497f-82d6-d2e46019f7e9	1	0	2015-07-25 14:36:37.988-04	be93b045-2bd1-43a0-94f2-29af3280a0db	2015-07-25 14:36:37.947-04	be93b045-2bd1-43a0-94f2-29af3280a0db
fe71fcd3-3c96-45ed-a95e-1f936af67b79	fe71fcd3-3c96-45ed-a95e-1f936af67b79	1	0	2015-07-29 11:06:59.588-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:06:59.543-04	0a215950-e391-4575-8d45-e5c36c6cb723
e974d03d-7779-4c6a-b68b-95f69f1423b4	e974d03d-7779-4c6a-b68b-95f69f1423b4	1	0	2015-08-09 18:12:57.902-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:12:57.854-04	067b4635-5840-48fd-980d-ccddbe1b173d
115b8d12-240b-4d68-8821-a30ddf7e2171	115b8d12-240b-4d68-8821-a30ddf7e2171	1	0	2015-08-11 13:30:05.413-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:30:05.378-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
c4568bb9-be77-46bc-bad1-1a75fc1ea00c	c4568bb9-be77-46bc-bad1-1a75fc1ea00c	1	0	2015-08-13 08:44:15.038-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:44:14.996-04	47da5910-d577-4386-89a9-e271be4a2f4f
c4723847-be20-49a1-a056-e4da739856b1	c4723847-be20-49a1-a056-e4da739856b1	1	0	2015-08-24 19:09:34.526-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-08-24 19:09:34.466-04	9ef858fa-13d8-4152-aff7-28daea5a0842
59977c2e-d426-4c1b-aea6-98121f5d1ae2	59977c2e-d426-4c1b-aea6-98121f5d1ae2	1	0	2015-08-26 12:00:53.322-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 12:00:53.272-04	c0697e56-11bf-4e37-a029-aac44d1af67c
83369076-1bb1-4793-ad96-cbb91d1b1d5c	83369076-1bb1-4793-ad96-cbb91d1b1d5c	1	0	2015-08-26 13:35:43.327-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.274-04	e604c054-19e1-4332-b9ae-97ef0c58380f
2cc106c6-c7ec-4c56-884e-2929e4d805ec	2cc106c6-c7ec-4c56-884e-2929e4d805ec	1	1	2015-08-30 21:43:44.148-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:44:19.077-04	89b13534-20eb-49d7-914c-d84a673f858d
0e54af85-b94d-40f0-b1bc-ce950b906307	0e54af85-b94d-40f0-b1bc-ce950b906307	1	0	2015-09-02 08:07:47.305-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-09-02 08:07:47.264-04	d7bb1e62-fe40-4774-a432-03bd53510708
0df4f263-d9e5-48da-927b-2dfa56c8639f	0df4f263-d9e5-48da-927b-2dfa56c8639f	1	0	2015-09-04 17:19:22.844-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:19:22.795-04	e604c054-19e1-4332-b9ae-97ef0c58380f
ec4a6dfa-cf62-4d9f-907d-46624cc39d4b	ec4a6dfa-cf62-4d9f-907d-46624cc39d4b	1	1	2015-09-04 17:23:33.198-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:24:16.266-04	e604c054-19e1-4332-b9ae-97ef0c58380f
f1c1d499-c1ec-46d6-816c-d5cb1c18dbbe	f1c1d499-c1ec-46d6-816c-d5cb1c18dbbe	1	0	2015-09-10 02:33:14.851-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:33:14.811-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c
b0c71ef5-05f9-435c-bd5b-7da5a3beeb34	b0c71ef5-05f9-435c-bd5b-7da5a3beeb34	1	0	2015-09-13 00:46:59.769-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	2015-09-13 00:46:59.721-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3
ecc4c035-a2d5-433d-93e6-107b59982e77	ecc4c035-a2d5-433d-93e6-107b59982e77	1	0	2015-09-23 13:04:31.97-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-09-23 13:04:31.902-04	86103f7b-c3bd-489b-a732-10374a07ed5a
659995f4-3889-458f-8b56-644a10fee656	659995f4-3889-458f-8b56-644a10fee656	1	0	2015-09-28 11:44:09.714-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:44:09.669-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a
5c253621-1a91-400d-bd38-d1325fe740ad	5c253621-1a91-400d-bd38-d1325fe740ad	1	0	2015-09-28 11:45:17.358-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:45:17.319-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a
fbfa7146-026c-421e-b1b2-b5f220c7028a	fbfa7146-026c-421e-b1b2-b5f220c7028a	1	0	2015-09-28 11:45:43.401-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:45:43.366-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a
e153fd13-4f5e-4040-b88d-b46eab1510da	e153fd13-4f5e-4040-b88d-b46eab1510da	1	0	2015-10-09 09:28:39.665-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	2015-10-09 09:28:39.62-04	ee2ef90f-e171-4422-b6a7-d783584c27b4
20f5f15e-ee40-401b-8ae7-d094af9ee576	20f5f15e-ee40-401b-8ae7-d094af9ee576	1	0	2015-10-19 14:44:49.886-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:44:49.835-04	51855703-9a42-4c37-8418-24da5bf57be7
feaed0f2-1271-4dff-98a3-70d7bb88d450	feaed0f2-1271-4dff-98a3-70d7bb88d450	1	0	2015-10-19 18:25:16.966-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	2015-10-19 18:25:16.926-04	9b53f8fe-453f-4512-9016-81c3f56c16b5
d72dca02-a605-400d-8037-2e3cbe18f5ce	d72dca02-a605-400d-8037-2e3cbe18f5ce	1	0	2015-10-27 13:29:23.248-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:23.195-04	86103f7b-c3bd-489b-a732-10374a07ed5a
31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	1	0	2015-10-30 11:54:46.22-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:46.17-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
e2cb3694-c779-4f8a-ad8d-916f67d6afd4	e2cb3694-c779-4f8a-ad8d-916f67d6afd4	1	0	2015-11-06 17:57:06.776-05	66beb125-c5dc-44a0-9a24-00c319871544	2015-11-06 17:57:06.741-05	66beb125-c5dc-44a0-9a24-00c319871544
9a33068a-734b-44fd-95eb-26d7c77e76f5	9a33068a-734b-44fd-95eb-26d7c77e76f5	1	2	2015-10-30 11:58:34.68-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:59:50.178-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
eee4fde3-1cf6-494b-a072-cceb26e2d8a0	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	1	1	2015-10-30 12:56:05.164-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:06:29.175-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
5414de16-d0ae-4f3c-87be-3c693bd29254	5414de16-d0ae-4f3c-87be-3c693bd29254	1	0	2015-10-30 16:40:12.167-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:12.132-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
544f0f06-d921-4540-a63a-7ee87cad8897	544f0f06-d921-4540-a63a-7ee87cad8897	1	0	2015-10-30 16:55:53.149-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:53.103-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
1b13b404-484b-423f-9ed7-28f22b1633f5	1b13b404-484b-423f-9ed7-28f22b1633f5	1	0	2015-10-30 20:46:22.583-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:46:22.543-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
cd29dd92-0d6f-4e49-b8a0-08a8b7198b8f	cd29dd92-0d6f-4e49-b8a0-08a8b7198b8f	0	1	2015-10-30 16:43:38.465-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:56:33.466-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
13c0f891-4020-4f50-99e6-91c327bf763c	13c0f891-4020-4f50-99e6-91c327bf763c	1	0	2015-10-30 21:03:24.126-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:03:24.091-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
7e68a15c-106f-4901-82c8-eaa8def7eb78	7e68a15c-106f-4901-82c8-eaa8def7eb78	0	1	2015-10-30 21:06:35.813-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:07:24.043-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
895a56bd-9dff-4b16-917e-c02690e5ca30	895a56bd-9dff-4b16-917e-c02690e5ca30	1	0	2015-10-30 21:08:32.685-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:32.651-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
80d75cc0-d9a4-4885-9d5e-7de208fdedd5	80d75cc0-d9a4-4885-9d5e-7de208fdedd5	1	0	2015-10-30 21:09:55.36-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:09:55.309-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
f240903f-3947-413e-846b-673bd14c10dd	f240903f-3947-413e-846b-673bd14c10dd	0	2	2015-10-30 21:17:54.86-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:21:57.156-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
fe5fa59f-1900-49c8-9c58-2a330a18936a	fe5fa59f-1900-49c8-9c58-2a330a18936a	1	0	2015-12-01 18:04:28.285-05	0a215950-e391-4575-8d45-e5c36c6cb723	2015-12-01 18:04:28.234-05	0a215950-e391-4575-8d45-e5c36c6cb723
ff447f13-7c1a-4554-a227-2d98bd2ea1d3	ff447f13-7c1a-4554-a227-2d98bd2ea1d3	1	2	2015-11-02 15:50:55.451-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:54:17.284-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
cc237a8f-03f8-4cb3-bb69-f50b4cadb253	cc237a8f-03f8-4cb3-bb69-f50b4cadb253	1	1	2015-11-02 15:56:37.386-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:57:03.068-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
76b254bb-262d-48bd-9bed-3b121a10efb5	76b254bb-262d-48bd-9bed-3b121a10efb5	1	0	2015-11-02 16:00:22.006-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:00:21.84-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
194377d5-26ad-4ee7-af4a-a3814dfd5d2c	194377d5-26ad-4ee7-af4a-a3814dfd5d2c	1	2	2015-11-08 19:24:32.64-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:11.282-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
a8eafe63-bf81-417b-a7ff-69ac6f7a1515	a8eafe63-bf81-417b-a7ff-69ac6f7a1515	1	0	2015-11-08 22:22:31.405-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:31.364-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
98ad9706-8d3a-480d-9cd9-b4405ea0d8da	98ad9706-8d3a-480d-9cd9-b4405ea0d8da	0	1	2015-11-08 22:18:47.93-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:59.352-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
298ec5c7-3e6d-406f-851a-3b5d2c2ed771	298ec5c7-3e6d-406f-851a-3b5d2c2ed771	1	0	2015-11-13 15:39:06.04-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:06.006-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
e0185917-0f44-4891-a330-ea0434f71080	e0185917-0f44-4891-a330-ea0434f71080	1	0	2015-11-17 20:58:27.884-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:58:27.837-05	a87e2f31-a7e1-41e9-9760-ff655f43132a
fdf6e1c6-9b63-4693-8cf1-df0fdc248305	fdf6e1c6-9b63-4693-8cf1-df0fdc248305	1	0	2015-11-19 14:50:47.728-05	342d0720-50db-402e-8f0d-ee761e61011f	2015-11-19 14:50:47.638-05	342d0720-50db-402e-8f0d-ee761e61011f
e30d3646-7022-48ea-ba2f-cc2211855dd5	e30d3646-7022-48ea-ba2f-cc2211855dd5	1	0	2015-11-24 17:12:27.255-05	0a215950-e391-4575-8d45-e5c36c6cb723	2015-11-24 17:12:27.206-05	0a215950-e391-4575-8d45-e5c36c6cb723
\.


--
-- Data for Name: leaddetail; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY leaddetail (id, leadid, email, besttimetocall, hearaboutus, howcanwehelp, status, version, added, addedby, changed, changedby) FROM stdin;
f7090f5c-8cbd-4c59-9a30-0df7a257466c	c7453ad2-bbc2-4e02-9036-ddea1aeecce8	jenn.ickes@theconcreteprotector.com	Afternoon	\N	\N	1	0	2015-01-29 14:17:31.4-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:31.23-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
55b1757b-0643-4ea5-99e5-a19b90e12477	81c6b6b2-81a5-45cd-887d-f0ec7e585de8	jenn.ickes@theconcreteprotector.com	Afternoon	\N	\N	1	0	2015-01-29 14:17:51.815-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:51.737-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
7b261d76-1f8e-4089-8674-2704217b866c	e98fa2f8-a53d-4771-9ba9-17ccb3e17403	jenn.ickes@theconcreteprotector.com	Afternoon	\N	\N	1	1	2015-01-29 14:17:21.946-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 21:30:54.856-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
b3d99978-ed43-4b83-8ede-4c11e98c83de	7f90930d-a8d0-469b-850a-a813f2296895	joe@theccop.con	Morning	church	give quote	1	1	2015-01-29 21:59:46.611-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:22:31.754-05	06169b04-bb68-4868-b995-98388fa33e16
63caac41-0067-4a1a-abb1-56a4a370cdb7	98e1ec87-3ae8-482b-bdf2-93606a7e59f3	info@theconcreteprotector.com	Evening	Brad Bates		1	1	2015-01-21 22:41:31.669-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:16:24.283-05	06169b04-bb68-4868-b995-98388fa33e16
83cab4c0-0cce-4326-9a48-065a70eda2de	056c5531-26a1-40ed-9f99-e9853971de7d	joe@tttyy.com	Morning	Joe	money	1	1	2015-01-29 14:33:48.918-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:17.396-05	06169b04-bb68-4868-b995-98388fa33e16
48ea7f56-0747-48fd-ad31-bc207a3a951f	103911dd-2154-486e-9395-f1d6345b013c		Afternoon	flyer	estimate	1	1	2015-01-30 00:01:15.491-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:48.148-05	06169b04-bb68-4868-b995-98388fa33e16
935595ce-4417-4ab1-9057-ce49af022bed	36fdea38-dabd-42ac-b120-e83a0ba2f3f1		Afternoon	flyer	estimate	1	1	2015-01-30 00:01:14.842-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:06.224-05	06169b04-bb68-4868-b995-98388fa33e16
961c07db-a744-41c8-9430-a1f99409517f	4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1		Afternoon			1	1	2015-01-30 00:05:34.158-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:18.738-05	06169b04-bb68-4868-b995-98388fa33e16
8990028b-b81d-4cf0-80c2-3cb6f86a1150	7a81e0e7-35fb-418e-9259-48b97cc6ac0f		Afternoon	flyer	estimate	1	1	2015-01-30 00:01:20.143-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:34.703-05	06169b04-bb68-4868-b995-98388fa33e16
2419335b-72ec-45ec-b0e8-8286b66b0b03	d7f7b71d-c6b3-4256-909f-196e84e9cc5a		Afternoon			1	1	2015-01-30 00:05:34.755-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:27:11.845-05	06169b04-bb68-4868-b995-98388fa33e16
754cbbfc-9014-43ef-a5a2-a7e955a38926	37f11480-7698-43ec-83e8-e7267c49ffc8		Afternoon			1	1	2015-01-30 00:11:45.306-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:20:03.974-05	06169b04-bb68-4868-b995-98388fa33e16
3f938ecb-14c9-4a80-848c-1e2903cd3f22	6fc1cd65-f54b-40aa-9be4-c263523aa8c5	2tonyscontracting@gmail.com				1	0	2015-02-06 16:43:12.408-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:43:12.326-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6
b89486bf-317d-43e8-9821-df995db55e6a	cae11bfb-7e0a-41f8-b248-0ff22dd15e48	srevep@gmail.com	Afternoon	Web	Acid seal	1	1	2015-02-10 09:54:54.082-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 10:04:17.943-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057
eeba31fe-c14b-4b6f-8127-258ea46ea7a0	edda48c4-c027-46cf-bf89-aed65eb5bb2b		Evening			1	0	2015-02-12 17:26:49.686-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-12 17:26:49.592-05	769a920c-df49-4e06-9913-4d7a6d83f073
4f42b185-2d59-4fb3-9c88-a3ebbe1c4a3d	1daec6cf-4d8f-44d4-a75c-3a0f6113c163	1sgmacleod@gmail.com		Elite Crete lead	Wanted info on floor systems for garage	1	0	2015-02-18 18:31:24.431-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:31:24.274-05	21ea39bb-285f-479e-8643-f9f963edd1a3
d25249a4-40f4-4955-ace5-d6cfd408e371	132ca982-dd98-412d-9087-a41da52e9d6a	flomo3@gmail.com		Texted me in response to my Facebook post	Gave her concrete contractors name and numbers.	1	0	2015-02-18 18:37:47.112-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:37:46.979-05	21ea39bb-285f-479e-8643-f9f963edd1a3
76d9adb7-da22-4c1b-9566-80817a8a0cae	958a7255-6c35-40de-93db-09f06e9d3a1a			Friend	Has driveway she is interested in having designed.	1	0	2015-02-18 18:41:10.252-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:41:10.135-05	21ea39bb-285f-479e-8643-f9f963edd1a3
427f909a-c458-4f84-934c-4c34f83975b0	75cd5a72-8d8d-4f3d-868a-4389e924a640			Friend of Brandon's	Garage floor	1	0	2015-02-18 18:48:49.435-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:48:49.381-05	21ea39bb-285f-479e-8643-f9f963edd1a3
309be77a-2f75-4e99-9257-af8422c38444	7773a57e-39c0-430c-a904-ad5b4b4390c8	johnletitride@yahoo.com		Facebook	600 sq ft patio	1	1	2015-02-18 18:46:58.263-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 19:05:28.347-05	21ea39bb-285f-479e-8643-f9f963edd1a3
156356ae-3736-48f0-9900-fc7330b73baa	c6f15c94-491b-4ea2-84dd-51c357229721	bill@testing.com	Evening	He said he saw your Facebook add.	Garage floor	1	0	2015-02-18 21:01:49.593-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:01:49.513-05	06169b04-bb68-4868-b995-98388fa33e16
4058b97b-48a6-4cd6-84ed-9d850bad45ff	881c4699-55ea-4aab-8fa1-8d3b3cdf605e		Morning	Facebook		1	0	2015-02-20 17:03:30.394-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.295-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
ad653606-e861-4f65-b769-a9b17e4b67d2	c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	elianapanagakos@hotmail.com	Morning	Orlando concrete contractors		1	0	2015-03-04 20:41:44.553-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:41:44.444-05	f975c50a-beb9-4277-ba91-6505d1b37f59
7efa1ba4-2c42-41aa-99f1-e08009fbba80	2120e974-8f6c-480f-a12c-b77c8675587f		Morning			1	1	2015-02-02 13:34:03.99-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-03-14 14:34:48.077-04	1676623f-4657-410f-87b6-db11cf461ba9
95d48762-8586-4887-b8f4-3d9c006ddad5	e9e30f4f-d854-424d-9aa0-62534609aa9b		Afternoon	Por medio del trabajo.. Le gusto la cualidad de mi producto..	puse undercabinets lighst	1	0	2015-03-14 21:01:10.358-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 21:01:10.205-04	7878e434-6854-422a-91aa-212f8b175aa3
fe17fa59-0d0e-4153-b884-bc83a591145e	710783cd-e487-4885-abc8-f299f140fe9a	rhankins@indianaharley.com	Afternoon		Interested in garage floor finishing	1	1	2015-03-19 19:56:18.903-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-20 11:45:13.465-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
5244e81a-2579-4398-ab6e-0342ee7aedc8	1efc6ddf-754e-4b87-a69f-4e90cce9e442			Referral		1	0	2015-03-30 18:08:18.89-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 18:08:18.825-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
92d91be0-344c-4749-9bf3-8103b53b63b2	1039afb2-b23c-4611-a76d-b7f67cb1e839	gmohar@zandersolutions.com	Morning	Internet		1	2	2015-03-20 18:19:31.928-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:36:04.948-04	fd0457a0-2d66-4a63-857b-21f224a14a47
cfa9e5ae-cdc5-47d6-856c-54021270efc8	8968b145-675a-40be-b7bf-8e7d73ac4bb4	shadrickmary@yahoo.com	Morning	Internet search	Need a new floor on showroom	1	0	2015-03-22 13:56:29.195-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 13:56:29.137-04	dc91c128-7614-4592-b94e-c19660131a55
3648ecce-380a-4473-a861-66173a1a8283	9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	ron@ctiofacadiana.com	Morning	Facebook		1	0	2015-04-14 13:15:29.675-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.6-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
97f7bf47-ea2c-4e14-a497-5c1be9f7f7b1	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	andy@theconcreteprotector.com	Morning	Online		1	1	2015-10-30 12:56:05.158-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:06:29.187-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
1e6adad1-e08d-48bd-a2c8-2fb97a3ac7e8	c0b7bdda-a97c-4772-8490-604f9c022ca5		Afternoon	RTS as alternative option	totally seal front section with Sanitred System	1	1	2015-04-23 12:04:06.675-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 12:05:17.348-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
89f30bf8-f303-4fc3-8c98-06f34103b3dc	c4606f0b-9e13-468f-bec6-c038d978b000			Concrete network	900 sq ft basement\nClean Stain and seal	1	0	2015-05-18 16:01:00.942-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:01:00.879-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
19e26757-3973-49b5-9de5-f29d643e0bd3	6760db3d-f5de-488b-9341-f6945c161fe7	jimdixon2626@yahoo.com				1	0	2015-07-02 14:25:32.72-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:32.579-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
9c46e177-4615-4f26-b01d-917a24a7154f	0550dbbd-7c9b-4339-b4fb-d2ba09203650	haverfordhomedesign@gmail.com	Morning	Google	make my patio beautifull	1	0	2015-07-05 23:29:51.164-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:51.077-04	61709628-4bca-418f-8dc4-1ad358c785d6
1d978b78-b59b-4821-86ba-a6e8a5022792	b2225f01-b777-4f75-95a5-9e9119e0d27b		Morning	Previous customer	waterproof new construction	1	0	2015-07-13 08:21:31.665-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:21:31.604-04	5414f676-63e9-4117-87bd-ec5577e932b7
408ddd27-5d7d-4929-930a-f4e94327f59c	e974d03d-7779-4c6a-b68b-95f69f1423b4	gackerman@concretecpr.com	Afternoon			1	0	2015-08-09 18:12:58.078-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:12:57.986-04	067b4635-5840-48fd-980d-ccddbe1b173d
78e794d5-37bb-449d-934f-7b1cf28ea419	59977c2e-d426-4c1b-aea6-98121f5d1ae2		Afternoon	Saw my Facebook	garage floor	1	0	2015-08-26 12:00:53.773-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 12:00:53.577-04	c0697e56-11bf-4e37-a029-aac44d1af67c
85ad89fa-362e-4c10-936d-f4fbeb01c779	ec4a6dfa-cf62-4d9f-907d-46624cc39d4b	linassipelis@gmail.com				1	0	2015-09-04 17:24:16.281-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:24:16.204-04	e604c054-19e1-4332-b9ae-97ef0c58380f
b2b7ab26-4af2-4142-855f-07b045d87312	31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	andy@theconcreteprotector.com	Morning	Internet	He	1	0	2015-10-30 11:54:46.744-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:46.657-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
357f81e2-0732-4a3b-bbe0-c880204193b0	9a33068a-734b-44fd-95eb-26d7c77e76f5	andy@theconcreteprotector.com	Morning	Online		1	2	2015-10-30 11:58:34.685-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:59:50.198-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
a0580a9f-f21d-4fe4-b5a2-d3a1e102574e	1b13b404-484b-423f-9ed7-28f22b1633f5	test@testing.com	Morning	Web	Work better	1	0	2015-10-30 20:46:23.044-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:46:22.922-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
a1aa30bc-f532-4922-bd16-54507848b88b	f240903f-3947-413e-846b-673bd14c10dd		Afternoon			1	2	2015-10-30 21:17:55.316-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:21:57.155-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
123b07dc-1a6d-4c92-bc00-046a01c9b48f	ff447f13-7c1a-4554-a227-2d98bd2ea1d3	andy@theconcreteprotector.com	Morning	Online		1	1	2015-11-02 15:53:10.29-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:54:17.297-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
8bedce5b-c83e-45a4-b9d9-c6794bc0236d	cc237a8f-03f8-4cb3-bb69-f50b4cadb253	andy@theconcreteprotector.com	Morning			1	1	2015-11-02 15:56:37.383-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:57:03.08-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
588df828-04a1-4b60-85b6-50df078940ab	76b254bb-262d-48bd-9bed-3b121a10efb5	andy@theconcreteprotector.com	Morning			1	0	2015-11-02 16:00:22-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:00:21.92-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
35d576cb-4112-4b34-9460-2add40c1b1c1	194377d5-26ad-4ee7-af4a-a3814dfd5d2c	omarandre2@gmail.com	Morning	Online		1	1	2015-11-08 19:25:39.59-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:11.289-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
4dcf6264-6dc5-49f7-a57e-f69bf18cb7e1	a8eafe63-bf81-417b-a7ff-69ac6f7a1515	summerfelix@yahoo.com	Evening			1	0	2015-11-08 22:22:31.916-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:31.86-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
971d2002-fe8b-44b4-9424-e9dbf8d20941	98ad9706-8d3a-480d-9cd9-b4405ea0d8da	summerfelix@yahoo.com				1	1	2015-11-08 22:18:48.419-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:59.371-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY note (id, fid, body, status, version, added, addedby, changed, changedby) FROM stdin;
8872e40d-dcf9-4a6a-8c04-7cc7aa6d26a5	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	Hhhf	1	0	2015-01-29 22:01:33.59-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:01:33.542-05	06169b04-bb68-4868-b995-98388fa33e16
19394665-5c1c-43be-b101-3f7e2718be7f	757af0d8-4529-45f2-bbe6-8697ef979a33	I used 20% less material than I estimated. Or I used 30% more than I estimated. I told the customer that there was no warranty for this system.	1	0	2015-01-31 10:36:18.666-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:36:18.615-05	06169b04-bb68-4868-b995-98388fa33e16
263cfca5-7b90-43e7-959c-287b9d9a3f7b	0d85205d-a32b-4f51-8345-bf92d9967d9b	Has cracks. And is wet	1	0	2015-01-31 11:11:33.974-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:33.924-05	06169b04-bb68-4868-b995-98388fa33e16
59c3044e-b4eb-4e98-86db-4b865216ab6b	b4dbd3b2-dd5e-46a5-a0ec-91c1e3e8e426	wet leaky Basement	1	0	2015-01-31 12:09:59.218-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:09:59.16-05	06169b04-bb68-4868-b995-98388fa33e16
643c4e49-f06f-4b22-9b2f-910ab8f552fa	3a00c1a0-229f-46ee-ad49-9f0f1f897882	Home owner wants to host a party by February 20th	1	0	2015-02-03 11:30:56.986-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:30:56.923-05	4398be50-e6ac-4662-8598-3783af2fa4f3
7ef13f45-4592-4da0-87d6-59b9c89b0f61	3a00c1a0-229f-46ee-ad49-9f0f1f897882	Home owner wants to host a party on February 20th  Jobe must be completed by then	1	0	2015-02-03 11:31:51.451-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:31:51.397-05	4398be50-e6ac-4662-8598-3783af2fa4f3
7715252e-b20b-4dc8-9200-7b556fd00bc6	5d007ec4-4b38-4006-916b-1fe3eea1717e	Repair area by steps	1	0	2015-02-03 13:04:50.109-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:04:50.058-05	06169b04-bb68-4868-b995-98388fa33e16
5bbeff78-a1f6-47ba-84c7-d76144e073a7	1e9e943d-ce42-4a50-8a03-4f3ba477b6d7	Just  first job	1	0	2015-02-03 13:59:12.69-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:59:12.643-05	06169b04-bb68-4868-b995-98388fa33e16
1d5cacd9-02de-4e47-ad7e-f35b31021210	f9c32ea4-a153-4c91-bba7-bb45ba748549	Leaky basement	1	0	2015-02-05 12:58:27.374-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:58:27.313-05	06169b04-bb68-4868-b995-98388fa33e16
e927be33-c9cd-4550-b4cd-209829ad54d3	0b402b5b-d1c6-4bad-99bf-a6ad0d8ca450	Graniflex	1	0	2015-02-08 18:59:48.388-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.308-05	067b4635-5840-48fd-980d-ccddbe1b173d
89dfa5db-1acb-4b33-b4ff-1f4ff170613e	3bc6577e-ed14-4c6f-b928-8fd5ae8f9364	leaky Basement	1	0	2015-02-12 18:05:50.991-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:50.939-05	06169b04-bb68-4868-b995-98388fa33e16
0cfbedbd-20b9-4657-8973-5b8f9f5b0c98	787cc315-b7ad-4197-abd2-e9b287216c25	Total $3840.00\n$500 down\nBalance of $3340 due upon completion	1	0	2015-02-18 19:07:11.29-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 19:07:11.243-05	21ea39bb-285f-479e-8643-f9f963edd1a3
8c518e46-b77b-4d28-b4b7-805d1281d34d	635de76f-82bd-4e5c-9a73-ab9091c05201	We promised bill that we would pressure wash his house while we were there.	1	0	2015-02-18 21:03:01.379-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:03:01.33-05	06169b04-bb68-4868-b995-98388fa33e16
0ad8241c-fcc5-4039-a04a-d19eb532987e	6a080c16-dd30-45c2-9867-c7591da197c0	Wants shop  floor	1	0	2015-02-20 17:03:30.832-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.776-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
1d6789f8-da72-410a-893d-fd4820c4048a	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	$1200 can be added for demon to steps	1	0	2015-03-12 23:05:36.816-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:05:36.767-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
f35509cb-892d-4218-8711-f31d839c3ba1	faa726af-f139-40ae-800e-7be149f79a5c	"Team Green" - B-331	1	0	2015-03-19 20:41:09.283-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 20:41:09.232-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
cb9d95a7-5d71-40c1-820c-8136eb42c926	bebc6e56-4ac1-450a-9251-a1e311b8af65	Joint repair	1	0	2015-03-20 11:47:18.094-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:47:18.043-04	05dbb3b8-9caf-405e-ae5e-a6074822a169
c5bf496a-7805-4781-8b86-2f8d0d107f79	d4637f1c-f967-4db7-8b91-b518c4408469	Need protection, wants hardwood concrete flooring system.	1	0	2015-03-20 12:03:52.213-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:52.15-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b
cb1ed496-beac-4e88-8193-99955bf12a35	affcd11c-4335-4504-aaf2-545b540c0e2b	He likes the captain!	1	0	2015-03-20 18:22:00.319-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:22:00.266-04	fd0457a0-2d66-4a63-857b-21f224a14a47
0089fdc6-b877-44cb-9acb-2584274897a2	affcd11c-4335-4504-aaf2-545b540c0e2b	Smile at him	1	0	2015-03-20 18:33:21.667-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:33:21.622-04	fd0457a0-2d66-4a63-857b-21f224a14a47
c0f04875-3d6d-41fa-b941-8b2cb58ab08f	78b824b2-2d01-4fe8-90ab-38a179c45bd0	Garage	1	0	2015-03-21 15:55:41.706-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.646-04	c27e733b-f247-498a-a945-7521cca65c3b
07ce2331-69b9-4ecc-8950-644588a660e2	affcd11c-4335-4504-aaf2-545b540c0e2b	Big dog.	1	0	2015-03-23 09:00:20.72-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-23 09:00:20.66-04	fd0457a0-2d66-4a63-857b-21f224a14a47
7adc0d96-7ff0-42c9-9c2c-8326170d74f5	40bb9421-6ae9-4c3d-9ac6-db6955a420d4	Repairs for dark stain recoat with texture	1	0	2015-03-26 21:13:02.875-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:13:02.816-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
1b840af9-292a-4be5-9665-5b7d286c82d4	40bb9421-6ae9-4c3d-9ac6-db6955a420d4	Repairs for dark stain.	1	0	2015-03-26 21:14:56.787-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:56.733-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
730d930b-5378-41f3-b03d-544036c75ceb	40bb9421-6ae9-4c3d-9ac6-db6955a420d4	2 days 3 man crew for tape off ,texture and stain. Project took 3 days longer for dark stain repairs.	1	0	2015-03-26 21:20:16.029-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:20:15.975-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
84cd0d06-9dfd-49e4-851d-9348ce19f4a3	0faa9ff4-6f2b-4b0c-b5a0-6f6d971cdf62	Customer wants it for $8000 less than actual and completed in 4 days. Not possible	1	0	2015-03-26 21:24:35.886-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:35.833-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
53ca9446-bf3f-42b3-843f-f2b0f3fa69ac	cef56458-c337-40df-af91-2716165a088c	WB satin urethane top coat	1	0	2015-03-31 14:26:59.6-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 14:26:59.542-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
97c8dfbe-c2b6-43e9-9e22-e4d4005e657f	54a8f2a4-3fe2-4541-a5fe-f96573f7c107	bb	1	0	2015-04-04 17:24:45.047-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.008-04	84525335-0f50-4354-8dd8-f9fe584df21a
4bc34c29-84d2-44b1-801a-527871f409a6	8ff4934d-d954-4882-819e-db632041838f	Help with this program.	1	0	2015-04-14 13:15:30.056-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.982-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
62c0f637-a847-4e02-942c-a23fc572498e	fda3f113-8612-4c17-9279-f4156f2bdbaa	Concrete repair	1	0	2015-04-28 08:01:15.858-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:15.807-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
9c721e2d-e430-4073-abce-219c375bc4ef	55e64832-e4c3-4474-a4ee-0200f5ee2656	Graniflex 3 coats with 18 in tile	1	0	2015-05-13 22:52:26.537-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:52:26.479-04	d7bb1e62-fe40-4774-a432-03bd53510708
7daae450-49f5-4b9f-b7af-c0e2ed178508	f10c7484-9daa-44aa-803e-67bd587261ab	Light prep	1	0	2015-07-05 23:29:51.542-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:51.442-04	61709628-4bca-418f-8dc4-1ad358c785d6
8ebe3992-02cc-4ebe-90b8-c139b0c38d7a	5c2c1517-8e18-40eb-b813-ef8946528654	Concrete in good shape	1	0	2015-07-22 22:12:32.579-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:32.533-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
55a64041-88d4-428f-a841-e44b3d9f1f8c	0bfa54f1-50e1-4fd7-8292-5f77ab106401	Nice	1	0	2015-07-24 16:06:47.543-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:06:47.492-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
47bbcc2c-0fd9-4295-8b60-317bb49da09f	56e3e125-2525-481f-b644-064a4ef7625b	Need to wrap 2 walls 4" to drywall\n36 feet at $5 per foot\nApron has 70 feet of cracks to fill at $3.50 per foot\nMaybe some flexcrete work on wall	1	0	2015-08-09 18:12:58.486-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:12:58.417-04	067b4635-5840-48fd-980d-ccddbe1b173d
b380b038-69f8-4fe7-b6b3-2ca652bf84c7	3513c87e-0c77-4360-9c02-679063af81c5	Metallic epoxy golden brown and coffee	1	0	2015-08-30 21:43:44.608-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.555-04	89b13534-20eb-49d7-914c-d84a673f858d
744ddc2c-2d45-41b9-807f-67b560fce8ee	5c6fb96c-22f6-40b4-83d2-80b1b908f0f6	Failure to joint 64	1	0	2015-09-10 02:35:49.471-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:35:49.425-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c
7d6d8300-d7c2-4eeb-8dfc-caffef72a3d2	b201737f-4948-4c1c-a6b6-e3320269bc56	Basement	1	0	2015-10-19 14:45:52.158-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:45:52.103-04	51855703-9a42-4c37-8418-24da5bf57be7
ab3b59f5-3990-474c-a4bd-16dcea9c1521	b201737f-4948-4c1c-a6b6-e3320269bc56	Fix all cracks chips	1	0	2015-10-19 14:46:28.617-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:28.563-04	51855703-9a42-4c37-8418-24da5bf57be7
3d558c30-184a-4f6b-ad53-86520126d24c	d5e1da07-449b-49b7-aeca-0ea35a804b6f	Test note	1	0	2015-10-30 13:04:05.487-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:04:05.45-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
8a13a100-1cbb-4d52-9bed-00ff39f28455	e4a67ac4-0de5-4d31-94c4-2abab599089a	Love it	1	0	2015-10-30 20:48:33.788-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:33.746-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
aeea0358-9d72-493b-acb2-96386891133f	331f197b-27eb-4246-b2d8-5be7a84552ab	Put no\nHow can we see this if the words do not show it	1	0	2015-11-02 15:49:21.06-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:49:21.017-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
9df58c64-f081-401c-ae69-eec7aa41210b	4b040e4d-2199-4c2e-a9a9-da684c2c9c15	Brick patterns	1	0	2015-11-08 19:29:02.353-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:29:02.308-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
69168cd1-9f1a-40b7-aa54-01de3ef41991	fe63ea97-197d-462d-a897-4e28ae421789	Hydro air coil bad, replace, place filter rack in proper place	1	0	2015-11-17 21:00:40.301-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 21:00:40.248-05	a87e2f31-a7e1-41e9-9760-ff655f43132a
\.


--
-- Data for Name: pattern; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY pattern (id, name, version, status, added, addedby, changed, changedby) FROM stdin;
085c7581-aec0-4c59-bca3-f2cb8dfa5c76	Ashlar Slate	0	1	2015-01-21 23:01:13.386-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:01:13.337-05	06169b04-bb68-4868-b995-98388fa33e16
aa8fc17d-09e7-4534-a1ff-ef3928a3a998	GrandFlagstone	1	1	2015-01-20 17:49:48.845-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-21 23:01:30.218-05	1676623f-4657-410f-87b6-db11cf461ba9
fcc0b1d8-f911-4e38-bedb-18b96cc98a00	Tile	1	1	2015-01-20 17:49:58.664-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-21 23:01:41.169-05	1676623f-4657-410f-87b6-db11cf461ba9
9dfbca6c-e2ed-4ac1-a1ff-fe721f0bc935	Border	0	1	2015-01-21 23:02:37.872-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:02:37.823-05	06169b04-bb68-4868-b995-98388fa33e16
8411780d-a4cc-4852-809d-a394610680c4	Basketweave	0	1	2015-01-30 12:28:23.102-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 12:28:23.055-05	06169b04-bb68-4868-b995-98388fa33e16
db07d3cd-0559-4237-bb57-332bc4678039	Wood	0	1	2015-01-31 11:03:11.548-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:03:11.507-05	06169b04-bb68-4868-b995-98388fa33e16
cc2abaf8-7e9d-4d77-adf4-0d5dd815e40b	NONE	0	1	2015-01-31 12:02:12.407-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:02:12.349-05	06169b04-bb68-4868-b995-98388fa33e16
909ca8a4-6833-42a3-8525-1d45ccaa120b	1/4"	0	1	2015-02-02 18:33:41.879-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:33:41.827-05	06169b04-bb68-4868-b995-98388fa33e16
679955cd-4214-4ac4-b5a9-ef2fdfbed7f6	1/8"	0	1	2015-02-06 13:08:19.912-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:08:19.867-05	06169b04-bb68-4868-b995-98388fa33e16
4aee432b-0dd5-4d27-8038-1c75effe7018	1/32"	0	1	2015-02-12 18:02:12.075-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:02:12.008-05	06169b04-bb68-4868-b995-98388fa33e16
41385e86-0f8e-41e5-bdb7-2dbccd72a252	1/16"	2	1	2015-02-18 20:22:27.268-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:27:57.34-05	06169b04-bb68-4868-b995-98388fa33e16
4300c071-8666-4834-b691-5737fb2839e0	Spots	0	1	2015-02-18 20:31:52.265-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:31:52.223-05	06169b04-bb68-4868-b995-98388fa33e16
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY person (id, firstname, lastname, status, version, added, addedby, changed, changedby, company) FROM stdin;
1676623f-4657-410f-87b6-db11cf461ba9	Brad	Bates	1	0	2015-01-20 00:58:42.113-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-20 00:58:41.154-05	1676623f-4657-410f-87b6-db11cf461ba9	
06169b04-bb68-4868-b995-98388fa33e16	Joe	Quick	1	0	2015-01-21 11:20:39.959-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 11:20:39.04-05	06169b04-bb68-4868-b995-98388fa33e16	
7ce708d8-63c0-4faf-bb52-8a645fc1a819	Joe	Quick	1	0	2015-01-21 22:08:52.408-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-01-21 22:08:51.534-05	7ce708d8-63c0-4faf-bb52-8a645fc1a819	
f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Courtney	Quick	1	0	2015-01-29 14:15:00.299-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:14:59.227-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
c7453ad2-bbc2-4e02-9036-ddea1aeecce8	Jenn	Ickes	1	0	2015-01-29 14:17:30.555-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:30.492-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	TCP
81c6b6b2-81a5-45cd-887d-f0ec7e585de8	Jenn	Ickes	1	0	2015-01-29 14:17:51.089-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:51.035-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	TCP
729f64ae-607c-4af1-9dd5-08330eff0d8a	In vegas	quick	1	0	2015-02-02 18:39:56.001-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:39:55.948-05	06169b04-bb68-4868-b995-98388fa33e16	
79061ab6-25c1-489f-88d4-0aa93c64287f	Court	quick	1	0	2015-01-29 16:52:19.89-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 16:52:19.832-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
1c9d30a0-0e33-4ef6-9ee9-b72e8ffceb4d	H	i	1	0	2015-01-29 16:54:32.645-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 16:54:32.592-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
e98fa2f8-a53d-4771-9ba9-17ccb3e17403	Jenn	Ickes	1	1	2015-01-29 14:17:21.18-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 21:30:54.78-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	TCP
7f90930d-a8d0-469b-850a-a813f2296895	Joe test	10:pm	1	2	2015-01-29 21:57:37.559-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:22:31.632-05	06169b04-bb68-4868-b995-98388fa33e16	mine
3f483df0-322e-4171-a957-7398e0692772	Joe test	jan 29	1	1	2015-01-29 21:42:09.188-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:06.65-05	06169b04-bb68-4868-b995-98388fa33e16	artistic
fa409de1-af0e-4be7-a2a2-01c209092b3e	Joe test	jan 29	1	1	2015-01-29 21:42:05.697-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:16.898-05	06169b04-bb68-4868-b995-98388fa33e16	artistic
d8a45cb6-d8de-4b38-bb1f-7b40d96ad6ba	Joe test	jan 29	1	1	2015-01-29 21:41:59.038-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:23:34.414-05	06169b04-bb68-4868-b995-98388fa33e16	artistic
c605da3d-19d9-4a0e-9d42-a1d48d70196a	Andy	Franklin	1	0	2015-01-29 23:28:03.596-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-29 23:28:02.649-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
556f727b-33ea-479e-b87d-b32c7a7099fc	Andy	Franklin	1	0	2015-01-30 11:43:26.058-05	556f727b-33ea-479e-b87d-b32c7a7099fc	2015-01-30 11:43:25.158-05	556f727b-33ea-479e-b87d-b32c7a7099fc	
5e1dff78-1ab4-4948-95f3-8a8875837b96	Devin	Franklin	1	0	2015-01-30 16:03:08.945-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:08.889-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
fde2a66e-fbdb-444c-8ae1-4bdaa20be1c6	Test		1	1	2015-02-03 13:00:19.348-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:23:31.045-05	06169b04-bb68-4868-b995-98388fa33e16	
98e1ec87-3ae8-482b-bdf2-93606a7e59f3	First Lead Test	Estimator	1	1	2015-01-21 22:41:30.724-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:16:24.202-05	06169b04-bb68-4868-b995-98388fa33e16	The Best
7958157a-0c04-44fa-af7e-a2c74f42bbd0	Joe and Brad	1-31-2015	1	2	2015-01-31 11:11:32.518-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:17:05.024-05	06169b04-bb68-4868-b995-98388fa33e16	TESTING CO
94e5fddb-b14f-49a4-a6f8-9fe3303f5549	Corey's demo	Henson	1	1	2015-01-22 09:41:50.849-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:53:06.545-05	06169b04-bb68-4868-b995-98388fa33e16	Redeck
dbc55b9a-354a-41ce-a527-2ad709c81b5f	Test	Person	1	0	2015-02-02 22:01:50.122-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f	2015-02-02 22:01:49.124-05	dbc55b9a-354a-41ce-a527-2ad709c81b5f	
377be275-bf06-4325-9879-406db5290aba	Jenn	Ickes	1	0	2015-02-02 23:43:59.047-05	377be275-bf06-4325-9879-406db5290aba	2015-02-02 23:43:58.146-05	377be275-bf06-4325-9879-406db5290aba	
0c14cbd3-c02c-4aaf-832e-b408082f1fec	Bob	test	1	0	2015-02-03 15:21:32.792-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 15:21:32.717-05	06169b04-bb68-4868-b995-98388fa33e16	
4398be50-e6ac-4662-8598-3783af2fa4f3	James	Downing	1	0	2015-02-03 09:49:37.046-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 09:49:35.71-05	4398be50-e6ac-4662-8598-3783af2fa4f3	
caec90bc-237e-4ea4-ad71-8ee8915915ca	Test with Andy And James	And Jared	1	1	2015-01-22 20:16:05.127-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:24:37.19-05	06169b04-bb68-4868-b995-98388fa33e16	Test Night with Tea
e4cf34c5-298e-4a43-a2cb-b7b8c96bbf8c	Paul	Bowser	1	4	2015-02-03 18:06:48.796-05	06169b04-bb68-4868-b995-98388fa33e16	2015-04-24 00:17:27.708-04	06169b04-bb68-4868-b995-98388fa33e16	KC Artistic
04e30689-c615-4fac-9106-f07b4159c62e	Paul	Bowser	1	0	2015-02-03 17:16:28.809-05	04e30689-c615-4fac-9106-f07b4159c62e	2015-02-03 17:16:27.887-05	04e30689-c615-4fac-9106-f07b4159c62e	
056c5531-26a1-40ed-9f99-e9853971de7d	Jan test	test	1	2	2015-01-29 14:32:45.744-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:16.796-05	06169b04-bb68-4868-b995-98388fa33e16	art
103911dd-2154-486e-9395-f1d6345b013c	Jim	Bob	1	1	2015-01-30 00:01:08.601-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:25:47.537-05	06169b04-bb68-4868-b995-98388fa33e16	Moms best
36fdea38-dabd-42ac-b120-e83a0ba2f3f1	Jim	Bob	1	1	2015-01-30 00:01:11.431-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:05.618-05	06169b04-bb68-4868-b995-98388fa33e16	Moms best
4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1	Bill	and Ted	1	1	2015-01-30 00:05:24.006-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:18.318-05	06169b04-bb68-4868-b995-98388fa33e16	Best Company
7a81e0e7-35fb-418e-9259-48b97cc6ac0f	Jim	Bob	1	1	2015-01-30 00:01:17.705-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:26:34.26-05	06169b04-bb68-4868-b995-98388fa33e16	Moms best
d7f7b71d-c6b3-4256-909f-196e84e9cc5a	Bill	and Ted	1	3	2015-01-30 00:05:32.177-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:27:11.069-05	06169b04-bb68-4868-b995-98388fa33e16	Best Company
25ba2f54-ccb3-46db-ada7-bf7b47974215	James	Downing	1	0	2015-02-03 11:28:39.811-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:28:39.743-05	4398be50-e6ac-4662-8598-3783af2fa4f3	TCP
1506ba01-68a5-426b-969b-3cd4541907de	Randy	Emerick	1	0	2015-02-03 12:41:26.6-05	1506ba01-68a5-426b-969b-3cd4541907de	2015-02-03 12:41:25.767-05	1506ba01-68a5-426b-969b-3cd4541907de	
79619370-4880-466d-aa70-6f6ea2fbf85b	Andy	Franklin	1	4	2015-01-29 23:36:44.238-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-13 07:21:07.06-05	06169b04-bb68-4868-b995-98388fa33e16	Old Buddy
37f11480-7698-43ec-83e8-e7267c49ffc8	Joe	Aftermidnight	1	1	2015-01-30 00:11:38.873-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:20:03.972-05	06169b04-bb68-4868-b995-98388fa33e16	Best company ever
1b66ed39-1a15-4af9-a81d-e7869e6dc02f	Joe Alone	1-31-2015	1	4	2015-01-31 12:09:58.109-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:20:30.543-05	06169b04-bb68-4868-b995-98388fa33e16	BEST EVER
2120e974-8f6c-480f-a12c-b77c8675587f	John	Doe	1	13	2015-01-31 12:32:24.698-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-03-14 14:34:48.08-04	1676623f-4657-410f-87b6-db11cf461ba9	Acme
d911e5d9-f428-4f86-a596-2dd36160b9d2	Test Lead	Smith	1	1	2015-01-31 13:06:39.183-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:03.961-05	06169b04-bb68-4868-b995-98388fa33e16	
a5c50cf4-2301-4f8c-9916-faecbf53e89f	TEST	TEST	1	1	2015-01-31 14:27:35.157-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:17.234-05	06169b04-bb68-4868-b995-98388fa33e16	
b4c4b6b7-8078-47ab-9b37-783e664cddf3	Roger	test	1	2	2015-02-03 13:26:35.345-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:53.88-05	06169b04-bb68-4868-b995-98388fa33e16	Trinadad
ed45e26f-c648-4f83-8204-6a239f3c1167	Test With Brad	Bates	1	6	2015-01-22 17:10:33.529-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:47.07-05	06169b04-bb68-4868-b995-98388fa33e16	Joe and Brad
c8d106b5-2b79-43f8-b918-abccaf9a2c85	In vegas	quick	1	1	2015-02-02 18:40:08.664-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:22:59.903-05	06169b04-bb68-4868-b995-98388fa33e16	
09111d56-f6c8-4921-9cfa-c165583b9cde	Jan 31	2015	1	2	2015-01-31 10:28:27.605-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 14:23:15.352-05	06169b04-bb68-4868-b995-98388fa33e16	testing leads
9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	fly	flyerson	1	0	2015-02-03 22:12:58.332-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	2015-02-03 22:12:57.297-05	9aa9e995-3ad1-4b1f-8188-86c4afa8c65a	
b4a956c2-4dab-4eaa-9b2a-be679af1efe4	Clinton	Grose	1	0	2015-02-04 06:26:41.47-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4	2015-02-04 06:26:40.533-05	b4a956c2-4dab-4eaa-9b2a-be679af1efe4	
794d15d6-67d3-40b7-982c-17e4d81b73f9	William	Sunderland	1	0	2015-02-04 12:09:35.081-05	794d15d6-67d3-40b7-982c-17e4d81b73f9	2015-02-04 12:09:34.138-05	794d15d6-67d3-40b7-982c-17e4d81b73f9	
c1c09c37-9dad-4c77-860e-26a64bdedba2	joe	ballor	1	0	2015-02-04 13:45:24.101-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-04 13:45:23.115-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	
61795214-a067-497f-8c4d-c307d5f658be	Anthony	Kerley	1	0	2015-02-04 13:51:55.053-05	61795214-a067-497f-8c4d-c307d5f658be	2015-02-04 13:51:54.578-05	61795214-a067-497f-8c4d-c307d5f658be	
ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	kip	edmonds	1	0	2015-02-04 13:54:25.863-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	2015-02-04 13:54:24.979-05	ffe5778b-1fa7-4a64-b5bd-ac8e0e1b36f4	
653bf84c-56ea-4b53-bc26-d1c63e95d102	Barry	test	1	0	2015-02-04 15:01:58.46-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:58.403-05	06169b04-bb68-4868-b995-98388fa33e16	Test
ed1fdfbb-28ef-47a0-9e71-e6e3b6c07949	James	testimg	1	0	2015-02-04 16:45:32.634-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:45:32.581-05	06169b04-bb68-4868-b995-98388fa33e16	
89f6dfc4-5361-4c4a-a91d-4ef55d27c4b3	Steve	test	1	1	2015-02-04 16:18:31.793-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:46:53.645-05	06169b04-bb68-4868-b995-98388fa33e16	
f2a80828-6d6e-4aa4-a855-e88c58562d34	Scott	test	1	0	2015-02-04 17:53:47.198-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:47.139-05	06169b04-bb68-4868-b995-98388fa33e16	
6d515d4c-f34c-40fa-9a2d-e9c1781be9d9	Tiff	tesr	1	0	2015-02-04 18:17:37.561-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:17:37.509-05	06169b04-bb68-4868-b995-98388fa33e16	Torg
d3263319-26b9-4bd3-964a-ec5f11c40f98	Fernando	test	1	0	2015-02-04 18:54:02.389-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:02.331-05	06169b04-bb68-4868-b995-98388fa33e16	test
4bb0100d-81a0-48f0-8164-e4441925e523	Matt	tesr	1	0	2015-02-04 19:23:47.481-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 19:23:47.431-05	06169b04-bb68-4868-b995-98388fa33e16	
d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	Arnulfo	Sepulveda	1	0	2015-02-04 22:55:25.769-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	2015-02-04 22:55:24.72-05	d061f9e1-a24c-4c68-9f05-9c2f8c0d1f12	
1aaaf421-b18d-49cb-b3a9-1926fe5b748b	alan	carlson	1	0	2015-02-05 10:59:19.462-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b	2015-02-05 10:59:18.516-05	1aaaf421-b18d-49cb-b3a9-1926fe5b748b	
c2901ab1-bc1f-4d59-aa31-2472bb7447bb	Bill	Bibler	1	0	2015-02-05 11:53:50.419-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb	2015-02-05 11:53:49.484-05	c2901ab1-bc1f-4d59-aa31-2472bb7447bb	
eb430119-b551-4141-8db9-9c87ec182c62	Ryan	robinson	1	0	2015-02-05 12:07:41.145-05	eb430119-b551-4141-8db9-9c87ec182c62	2015-02-05 12:07:40.296-05	eb430119-b551-4141-8db9-9c87ec182c62	
d86a76c4-4d99-4d16-b590-1df3c3122404	gordon	mckenna	1	0	2015-02-05 12:24:30.438-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-05 12:24:29.537-05	d86a76c4-4d99-4d16-b590-1df3c3122404	
d8b25099-6e8f-404f-a634-491a5987bc62	Brad	Becich	1	0	2015-02-05 12:58:23.33-05	d8b25099-6e8f-404f-a634-491a5987bc62	2015-02-05 12:58:22.358-05	d8b25099-6e8f-404f-a634-491a5987bc62	
754659e5-22c7-4c7b-a57c-8d6e2796af1c	Bent	test	1	1	2015-02-05 12:58:26.175-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:59:12.522-05	06169b04-bb68-4868-b995-98388fa33e16	Decor
ae0fd311-08da-40a3-95be-380fa613de0e	chad	weaver	1	0	2015-02-05 13:14:46.814-05	ae0fd311-08da-40a3-95be-380fa613de0e	2015-02-05 13:14:45.866-05	ae0fd311-08da-40a3-95be-380fa613de0e	
9585caeb-fcd2-49c2-9178-5d67898cc6c7	Scott	test	1	0	2015-02-05 14:25:34.003-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 14:25:33.952-05	06169b04-bb68-4868-b995-98388fa33e16	
c36a7d34-ad8e-440a-ae11-55d55afc28ab	Martin	test	1	0	2015-02-05 15:12:52.627-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:12:52.57-05	06169b04-bb68-4868-b995-98388fa33e16	
0d91397b-7630-411d-844a-ca64141beeec	Herb	test	1	0	2015-02-05 16:58:27.02-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 16:58:26.961-05	06169b04-bb68-4868-b995-98388fa33e16	factory
59502cc0-bd28-4746-9872-8950ad1570fd	Wes	Fitzpatrick	1	0	2015-02-05 18:53:37.668-05	59502cc0-bd28-4746-9872-8950ad1570fd	2015-02-05 18:53:36.756-05	59502cc0-bd28-4746-9872-8950ad1570fd	
92f0f8df-85ff-4820-8225-1a52e7cb91c1	Jason	test	1	0	2015-02-05 20:10:46.99-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:10:46.927-05	06169b04-bb68-4868-b995-98388fa33e16	
cb7975bf-b0ce-4217-9853-c3a57089636a	Drew	Franklin	1	2	2015-01-31 15:28:42.244-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:14:38.98-05	06169b04-bb68-4868-b995-98388fa33e16	
e64f4e10-cb56-4b6f-897e-c6e25b2fb083	David	Hebert	1	0	2015-02-05 21:32:55.912-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083	2015-02-05 21:32:55.018-05	e64f4e10-cb56-4b6f-897e-c6e25b2fb083	
91db4bd8-32b7-4bc4-9d7f-577896582110	bj	test	1	0	2015-02-06 11:44:05.406-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:44:05.343-05	06169b04-bb68-4868-b995-98388fa33e16	
9b941d78-4e8c-4c8a-b81b-40b36965b7e6	David	test	1	0	2015-02-06 15:05:55.708-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 15:05:55.65-05	06169b04-bb68-4868-b995-98388fa33e16	
f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	Tony	Richardson	1	0	2015-02-06 16:38:27.439-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:38:26.497-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	
6fc1cd65-f54b-40aa-9be4-c263523aa8c5	Tony	Richardson	1	1	2015-02-06 16:43:12.088-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:45:30.825-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	
8053c776-d7a4-4d09-bd03-cbd95cff842d	james	thorson	1	0	2015-02-06 16:45:50.754-05	8053c776-d7a4-4d09-bd03-cbd95cff842d	2015-02-06 16:45:49.909-05	8053c776-d7a4-4d09-bd03-cbd95cff842d	
3bf8ad1d-e37e-4873-931a-a8e639dc2fbd	joe	test	1	0	2015-02-07 08:16:00.131-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:16:00.074-05	4398be50-e6ac-4662-8598-3783af2fa4f3	
45c5679e-8596-4758-86cf-ca40c4ee38ee	Ryan	Samford	1	0	2015-02-07 11:33:28.308-05	45c5679e-8596-4758-86cf-ca40c4ee38ee	2015-02-07 11:33:27.314-05	45c5679e-8596-4758-86cf-ca40c4ee38ee	
592d90f2-3979-4806-aa2a-9c59814b22ee	Travis	Wachnuk	1	0	2015-02-07 13:36:55.98-05	592d90f2-3979-4806-aa2a-9c59814b22ee	2015-02-07 13:36:55.098-05	592d90f2-3979-4806-aa2a-9c59814b22ee	
067b4635-5840-48fd-980d-ccddbe1b173d	Brad	Yoder	1	0	2015-02-08 18:48:56.66-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:48:55.771-05	067b4635-5840-48fd-980d-ccddbe1b173d	
7f48e359-c6f6-41db-90c8-00cdb607a589	Brad	Yoder	1	2	2015-02-08 18:59:47.815-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:12:12.448-05	067b4635-5840-48fd-980d-ccddbe1b173d	
02a6969f-3fba-4f71-8729-41512e87d892	Jared	Lapp	1	1	2015-02-08 18:50:40.522-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:13:08.747-05	067b4635-5840-48fd-980d-ccddbe1b173d	
4bd70027-faff-47f9-bcd6-f56ac2bd92f0	Lance	Ferguson	1	0	2015-02-08 21:02:05.616-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0	2015-02-08 21:02:04.668-05	4bd70027-faff-47f9-bcd6-f56ac2bd92f0	
f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	Rick	LaFata	1	0	2015-02-10 09:46:31.086-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:46:30.148-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	
cae11bfb-7e0a-41f8-b248-0ff22dd15e48	steve	phillips	1	1	2015-02-10 09:54:53.24-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 10:04:17.728-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	
0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	adam	moormam	1	0	2015-02-10 10:52:44.93-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	2015-02-10 10:52:44.01-05	0acf7f2e-d19c-4902-8356-3f5f31c4dbc1	
964c0f18-ab25-41fe-b1b2-ad8db379d2cf	mike	damon	1	0	2015-02-10 17:00:34.188-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-10 17:00:33.212-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	
2cd23a09-777a-4af9-8ff5-763e565c6ec2	ray c's		1	0	2015-02-10 22:24:06.319-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-10 22:24:06.259-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	
d9a3aeff-b191-4b86-ac09-dd08fb239eae	testingtesting	testingtesting	1	0	2015-02-11 11:27:47.235-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae	2015-02-11 11:27:46.228-05	d9a3aeff-b191-4b86-ac09-dd08fb239eae	
1361510c-3db2-4db5-adfd-04c9665cb383	ggg	hhh	1	0	2015-02-11 15:17:45.074-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:17:44.999-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	xxx
56428d0f-310c-4d39-85b5-62296d4a14ec	Gavin	Albright	1	0	2015-02-11 15:42:28.235-05	56428d0f-310c-4d39-85b5-62296d4a14ec	2015-02-11 15:42:27.352-05	56428d0f-310c-4d39-85b5-62296d4a14ec	
769a920c-df49-4e06-9913-4d7a6d83f073	Don	Sexstone	1	0	2015-02-11 21:22:20.703-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-11 21:22:19.814-05	769a920c-df49-4e06-9913-4d7a6d83f073	
edda48c4-c027-46cf-bf89-aed65eb5bb2b	don	sexstone	1	0	2015-02-12 17:26:49.253-05	769a920c-df49-4e06-9913-4d7a6d83f073	2015-02-12 17:26:49.174-05	769a920c-df49-4e06-9913-4d7a6d83f073	
c3dc65cb-9e67-4e83-965c-74fad45d1ed6	Shawn	Crawford	1	1	2015-02-12 18:05:50.522-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:06:28.873-05	06169b04-bb68-4868-b995-98388fa33e16	Friend
4bcba17a-414f-4861-bca0-0e83856d6fba	ccc	osu	1	0	2015-02-16 14:59:16.845-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 14:59:16.784-05	d86a76c4-4d99-4d16-b590-1df3c3122404	
9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	Benjamin	smith	1	0	2015-02-16 17:23:08.826-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	2015-02-16 17:23:07.878-05	9a83f08e-a481-48a9-9b5a-5a3e9a7eb0b9	
21ea39bb-285f-479e-8643-f9f963edd1a3	Anthony	Kerley	1	0	2015-02-16 18:07:18.085-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-16 18:07:17.08-05	21ea39bb-285f-479e-8643-f9f963edd1a3	
be03f1e7-207c-4a6a-964f-ab6e7fb85ace	dan	ryan	1	0	2015-02-17 17:48:28.482-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace	2015-02-17 17:48:27.476-05	be03f1e7-207c-4a6a-964f-ab6e7fb85ace	
0f68d399-eef2-466d-ab22-733bd2b2737e	Dan	Donohue	1	0	2015-02-18 10:31:53.149-05	0f68d399-eef2-466d-ab22-733bd2b2737e	2015-02-18 10:31:52.084-05	0f68d399-eef2-466d-ab22-733bd2b2737e	
1daec6cf-4d8f-44d4-a75c-3a0f6113c163	Carl	MacLeod	1	0	2015-02-18 18:31:23.716-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:31:23.666-05	21ea39bb-285f-479e-8643-f9f963edd1a3	
132ca982-dd98-412d-9087-a41da52e9d6a	Florence	Morris	1	0	2015-02-18 18:37:45.749-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:37:45.676-05	21ea39bb-285f-479e-8643-f9f963edd1a3	
de11683e-a493-41f9-9898-372c604f0500	Sharon	Walker	1	0	2015-02-18 18:40:21.32-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:40:21.26-05	21ea39bb-285f-479e-8643-f9f963edd1a3	Pioneer Realty
d0db4bb3-61b1-4203-88cc-7f82e319c179	Sharon	Walker	1	0	2015-02-18 18:40:44.877-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:40:44.814-05	21ea39bb-285f-479e-8643-f9f963edd1a3	Pioneer Realty
958a7255-6c35-40de-93db-09f06e9d3a1a	Sharon	Walker	1	0	2015-02-18 18:41:09.525-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:41:09.456-05	21ea39bb-285f-479e-8643-f9f963edd1a3	Pioneer Realty
75cd5a72-8d8d-4f3d-868a-4389e924a640	Kyle	Hearndon	1	0	2015-02-18 18:48:49.172-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:48:49.11-05	21ea39bb-285f-479e-8643-f9f963edd1a3	
7773a57e-39c0-430c-a904-ad5b4b4390c8	John	Christians	1	1	2015-02-18 18:46:57.457-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 19:05:28.907-05	21ea39bb-285f-479e-8643-f9f963edd1a3	
c6f15c94-491b-4ea2-84dd-51c357229721	Bill	Tesingvido	1	1	2015-02-18 21:01:49.007-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:06:26.82-05	06169b04-bb68-4868-b995-98388fa33e16	Noname
68f19c8b-d75a-4417-8e4e-8589e272ad96	puzzlers		1	0	2015-02-19 04:06:17.725-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-02-19 04:06:17.665-05	c1c09c37-9dad-4c77-860e-26a64bdedba2	
45d94947-c576-453e-8e95-3fb0bdc538fc	mike	stidham	1	0	2015-02-19 09:17:05.037-05	45d94947-c576-453e-8e95-3fb0bdc538fc	2015-02-19 09:17:03.995-05	45d94947-c576-453e-8e95-3fb0bdc538fc	
e81db145-8364-495e-b45e-709987d0c0f7	tom	Eilerman	1	0	2015-02-20 06:07:31.347-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-20 06:07:30.43-05	e81db145-8364-495e-b45e-709987d0c0f7	
03c98a1a-8880-4d4e-9d7c-5d7440331ad0	Jesse	Gnt	1	0	2015-02-20 11:23:16.742-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0	2015-02-20 11:23:15.82-05	03c98a1a-8880-4d4e-9d7c-5d7440331ad0	
ff6f636c-57d8-4627-9133-509bb40f75ac	Sam	Green	1	0	2015-02-20 16:12:47.835-05	ff6f636c-57d8-4627-9133-509bb40f75ac	2015-02-20 16:12:46.735-05	ff6f636c-57d8-4627-9133-509bb40f75ac	
8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Jared	lapp	1	0	2015-02-20 16:43:07.411-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:43:06.504-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
d201bb6f-983c-4337-adc7-d28958209853	Mike	Gregery	1	0	2015-02-20 16:53:11.054-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:53:10.993-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
ac35e2bf-9e63-4f3d-8922-cdc12318130c	Lynn	Newman	1	0	2015-02-20 16:56:09.637-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:56:09.527-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
41f1e3ac-7c12-423f-99b8-ef95888f63c2	Lynn	Newman	1	0	2015-02-20 16:56:14.024-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:56:13.956-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
91356c6b-fee0-4a32-a546-9b033e0a2933	Lynn	Newman	1	0	2015-02-20 16:57:00.397-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:57:00.341-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
16ad538a-ebfc-40d1-91c5-fe596581c285	Doug	Buttler	1	0	2015-02-20 16:59:03.982-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 16:59:03.921-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
881c4699-55ea-4aab-8fa1-8d3b3cdf605e	Jared	lapp	1	0	2015-02-20 17:03:29.553-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:29.486-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	lapp concrete
58254cba-f7c2-4939-9444-db0aafceea13	Nick	Ferguson	1	0	2015-02-20 19:28:04.693-05	58254cba-f7c2-4939-9444-db0aafceea13	2015-02-20 19:28:03.769-05	58254cba-f7c2-4939-9444-db0aafceea13	
b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	chad	herrick	1	0	2015-02-20 20:26:21.614-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	2015-02-20 20:26:20.639-05	b1bfd7ee-9355-43fc-b9ad-0bab8ca8fb96	
ce456be6-d7c4-4fed-aab7-d3088f1b39b4	Andy	Paulson	1	0	2015-02-21 13:31:19.158-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4	2015-02-21 13:31:18.693-05	ce456be6-d7c4-4fed-aab7-d3088f1b39b4	
bf294499-6877-4421-8fb5-a5a5a86c4bda	Chad	Moore	1	0	2015-02-21 23:08:49.185-05	bf294499-6877-4421-8fb5-a5a5a86c4bda	2015-02-21 23:08:48.27-05	bf294499-6877-4421-8fb5-a5a5a86c4bda	
3aff8907-6c52-437a-9016-ef7243c3dbbd	mike	stidham	1	0	2015-02-22 01:21:14.092-05	3aff8907-6c52-437a-9016-ef7243c3dbbd	2015-02-22 01:21:13.08-05	3aff8907-6c52-437a-9016-ef7243c3dbbd	
0e8e8038-2471-427b-8c13-1b94647a3708	tom	Eilerman	1	0	2015-02-23 07:09:13.967-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-23 07:09:13.866-05	e81db145-8364-495e-b45e-709987d0c0f7	
dc91c128-7614-4592-b94e-c19660131a55	Rick	LaFata	1	0	2015-02-23 13:41:02.27-05	dc91c128-7614-4592-b94e-c19660131a55	2015-02-23 13:41:01.34-05	dc91c128-7614-4592-b94e-c19660131a55	
c27e733b-f247-498a-a945-7521cca65c3b	Corey	Henson	1	0	2015-02-23 21:24:50.412-05	c27e733b-f247-498a-a945-7521cca65c3b	2015-02-23 21:24:49.376-05	c27e733b-f247-498a-a945-7521cca65c3b	
6664d1b2-7618-401f-bde9-d8f5d1c7b757	Larry	Troyes	1	0	2015-02-24 17:12:11.477-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-24 17:12:11.018-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	
6c5725e7-5064-4126-a056-d36ad0efd1b7	joe	pasquarelli	1	0	2015-02-25 00:09:35.35-05	6c5725e7-5064-4126-a056-d36ad0efd1b7	2015-02-25 00:09:34.291-05	6c5725e7-5064-4126-a056-d36ad0efd1b7	
ffad21ff-ba19-406e-bc87-50bb6e32124b	Bret	schooling	1	0	2015-02-25 09:38:59.867-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:38:59.812-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	
fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	Ernie	Rodriguez	1	0	2015-02-25 10:22:17.172-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	2015-02-25 10:22:16.214-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	
03f15565-36da-4c06-a61f-ae401fc4722c	Remco	Langeveld	1	0	2015-02-25 11:41:23.798-05	03f15565-36da-4c06-a61f-ae401fc4722c	2015-02-25 11:41:22.921-05	03f15565-36da-4c06-a61f-ae401fc4722c	
d8cd8dd5-ab2e-4587-a724-1a74521e0afc	Mcmenamins		1	0	2015-02-25 11:46:23.781-05	03f15565-36da-4c06-a61f-ae401fc4722c	2015-02-25 11:46:23.714-05	03f15565-36da-4c06-a61f-ae401fc4722c	KSS international
c80f5541-496d-47da-98ab-3eba2395bf74	Mcmenamins		1	0	2015-02-25 11:46:32.802-05	03f15565-36da-4c06-a61f-ae401fc4722c	2015-02-25 11:46:32.748-05	03f15565-36da-4c06-a61f-ae401fc4722c	KSS international
26cb55ed-7c80-4c45-9a01-80316476a37e	kappa	sigma	1	0	2015-02-26 10:48:33.859-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	2015-02-26 10:48:33.778-05	fb1d26da-25c2-40c3-8b8a-e25d2d72dc72	
abea0018-ded6-434a-aec5-346b53931198	Marvin	keim	1	1	2015-02-26 13:54:39.868-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 13:58:37.838-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	
a442335a-b15d-42e7-96bf-20de14fd1fd8	Katherine	Lawrence	1	0	2015-02-26 23:57:57.611-05	a442335a-b15d-42e7-96bf-20de14fd1fd8	2015-02-26 23:57:56.656-05	a442335a-b15d-42e7-96bf-20de14fd1fd8	
bd00a75f-716b-4d3f-9ec5-42b5a9c4b3b7	fg h j	snl ri h	1	0	2015-02-27 09:23:52.629-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-27 09:23:52.575-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	bbb
5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Judy	foster	1	0	2015-03-02 18:03:43.006-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-02 18:03:42.072-05	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	
70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	terry	mayer	1	0	2015-03-02 18:45:06.806-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	2015-03-02 18:45:05.839-05	70a75b4c-7e36-4b6e-a1d8-00ed95808d3d	
f975c50a-beb9-4277-ba91-6505d1b37f59	Eliana	Panagakos	1	0	2015-03-04 20:33:09.157-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:33:08.175-05	f975c50a-beb9-4277-ba91-6505d1b37f59	
c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	Maria	Morera	1	0	2015-03-04 20:41:43.852-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:41:43.759-05	f975c50a-beb9-4277-ba91-6505d1b37f59	QCD
01108665-4678-43ea-8bea-784a90fae815	Nancy	Elliott	1	1	2015-03-06 15:47:17.772-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-06 15:48:40.581-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
f43c207e-54b3-433d-a55c-a55521f818e4	Boe	darras	1	0	2015-03-07 09:11:40.498-05	f43c207e-54b3-433d-a55c-a55521f818e4	2015-03-07 09:11:39.492-05	f43c207e-54b3-433d-a55c-a55521f818e4	
7642061f-8f03-462b-a50b-2c712fa4e952	Darryl	Lopez	1	0	2015-03-07 12:51:40.417-05	7642061f-8f03-462b-a50b-2c712fa4e952	2015-03-07 12:51:39.394-05	7642061f-8f03-462b-a50b-2c712fa4e952	
c35a84cb-0f2f-45e2-8ef8-0165189944c7	Brian	passwaiter	1	0	2015-03-07 21:29:14.243-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-07 21:29:13.105-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	
4416b7fd-233e-4d45-849d-3117e511ca08	Brian	passwaiter	1	0	2015-03-07 21:39:38.787-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-07 21:39:38.721-05	c35a84cb-0f2f-45e2-8ef8-0165189944c7	
3bf56637-f6f2-4381-bb11-96c3418ac743	Bitinger		1	0	2015-03-07 22:03:00.163-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-07 22:03:00.11-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	
1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	William	Sunderland	1	0	2015-03-08 22:08:12.782-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	2015-03-08 22:08:11.774-04	1158a1a6-d636-4b19-99eb-f5ac8a5af7f0	
abe59033-dbbd-4bbc-92a4-93f395ba289c	Russ	Halbert	1	0	2015-03-09 10:32:44.255-04	abe59033-dbbd-4bbc-92a4-93f395ba289c	2015-03-09 10:32:43.288-04	abe59033-dbbd-4bbc-92a4-93f395ba289c	
3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	Ossie	Apalategui	1	0	2015-03-09 22:11:55.557-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	2015-03-09 22:11:54.516-04	3c850d5a-71b5-4929-9b6a-ac0ced4f13fe	
1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	Richard	Batey	1	0	2015-03-11 21:39:38.825-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	2015-03-11 21:39:37.822-04	1ad7dfe2-96ea-4650-8ee4-3f105eda0adb	
2a7c31f6-369e-4325-b08a-3670096bb8ef	Joe	Test	1	0	2015-03-12 15:04:44.782-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:04:44.722-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
31797590-b84e-43d8-b0f1-32a1bdc37131	Daniel	Williams	1	0	2015-03-12 16:09:38.892-04	31797590-b84e-43d8-b0f1-32a1bdc37131	2015-03-12 16:09:38.006-04	31797590-b84e-43d8-b0f1-32a1bdc37131	
e95a8fa4-8767-4313-8d75-6a855565d166	Jr	raber	1	1	2015-03-12 14:43:33.845-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-13 10:53:51.603-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	raber Saddlery
7878e434-6854-422a-91aa-212f8b175aa3	Diego	ramirez	1	0	2015-03-14 20:44:16.737-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 20:44:15.889-04	7878e434-6854-422a-91aa-212f8b175aa3	
e9e30f4f-d854-424d-9aa0-62534609aa9b			1	0	2015-03-14 21:01:09.737-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 21:01:09.681-04	7878e434-6854-422a-91aa-212f8b175aa3	Cliente
77b5b917-c79f-4954-bc1e-675e7d0fea9e	fidel	hernandez	1	0	2015-03-17 21:55:22.416-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e	2015-03-17 21:55:21.444-04	77b5b917-c79f-4954-bc1e-675e7d0fea9e	
d53448fd-3ab2-4be8-b2bb-721e5738fafc	Aris.		1	0	2015-03-18 12:00:43.958-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:00:43.909-04	7878e434-6854-422a-91aa-212f8b175aa3	White Nieght Ny.
1f64e6da-cbc9-4b04-be2c-e3fa74ffc5a5	Angel		1	1	2015-03-18 12:01:48.921-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:02:46.581-04	7878e434-6854-422a-91aa-212f8b175aa3	Angel const.
745bde7b-294a-4716-8d8a-29e79f3bc3d0	Luke	Northcutt	1	0	2015-03-19 13:01:09.516-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0	2015-03-19 13:01:08.581-04	745bde7b-294a-4716-8d8a-29e79f3bc3d0	
6bdbf380-19f2-4749-adf3-c5e077387f81	Dan	thomas	1	0	2015-03-19 13:52:30.322-04	6bdbf380-19f2-4749-adf3-c5e077387f81	2015-03-19 13:52:29.465-04	6bdbf380-19f2-4749-adf3-c5e077387f81	
3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	Dylan	Passwaiter	1	0	2015-03-19 13:56:35.683-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 13:56:34.829-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	
dcaae353-6d1a-4933-b1ab-243d01d6ed34	Peter	Varganyi	1	0	2015-03-19 14:00:23.229-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34	2015-03-19 14:00:22.387-04	dcaae353-6d1a-4933-b1ab-243d01d6ed34	
503a77c4-05d0-4a6d-b282-61284bdefdf8	Garrett	Perry	1	0	2015-03-19 17:15:25.49-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 17:15:24.603-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	
05dbb3b8-9caf-405e-ae5e-a6074822a169	dakota	dunn	1	0	2015-03-19 18:09:35.133-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-19 18:09:34.2-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	
1200ffbc-9d03-4ef5-89af-b6c2893d0590	Ron	dunn	1	0	2015-03-20 11:45:47.036-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:45:46.985-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	dad
ab154fbf-e7ad-4df4-b80f-b4409c666909	Al	Daugherty	1	0	2015-03-19 20:13:25.622-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 20:13:25.569-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	h-h remodeling
1c8a8a08-87c5-4fc6-adde-a8aac73bba34	Chris	Hartley	1	0	2015-03-20 07:03:52.852-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34	2015-03-20 07:03:51.867-04	1c8a8a08-87c5-4fc6-adde-a8aac73bba34	
fd0457a0-2d66-4a63-857b-21f224a14a47	Jerin	Zander	1	0	2015-03-20 11:30:19.934-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 11:30:19.059-04	fd0457a0-2d66-4a63-857b-21f224a14a47	
5c54b12e-42e9-4222-9d43-04de05218061	David	Evans	1	0	2015-03-20 11:37:35.103-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:37:33.71-04	5c54b12e-42e9-4222-9d43-04de05218061	
1e6a7ced-23ad-4369-b72f-9af65493972a	Juanita	Whitfield	1	0	2015-03-20 11:41:01.625-04	1e6a7ced-23ad-4369-b72f-9af65493972a	2015-03-20 11:41:00.798-04	1e6a7ced-23ad-4369-b72f-9af65493972a	
710783cd-e487-4885-abc8-f299f140fe9a	Richard	Hankins	1	2	2015-03-19 16:50:59.729-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-20 11:45:13.122-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	
0d974cc6-045d-4ec5-a533-38ab0b8f115b	elonda	Whitfield	1	0	2015-03-20 11:45:54.156-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 11:45:53.359-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	
57cce6c1-17ed-4fb3-bfd9-ce1cbb060b50	Minette	Evans	1	0	2015-03-20 11:46:06.992-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:46:06.935-04	5c54b12e-42e9-4222-9d43-04de05218061	
9ef858fa-13d8-4152-aff7-28daea5a0842	yoni	rivas	1	0	2015-03-20 11:46:26.826-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-20 11:46:25.969-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
1e36b7cc-664c-4e8c-b778-39461c0cb4e6	Dave	VanDoren	1	0	2015-03-20 11:58:02.004-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 11:58:01.187-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	
f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	Peter	Varganyi	1	0	2015-03-20 11:58:41.824-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	2015-03-20 11:58:40.953-04	f1d274a7-9bd7-48c4-9c8d-4a1f5b345b7a	
a95b1ef4-e69d-45b3-bf1f-f406cf75dc4a	Dave	vd	1	0	2015-03-20 11:59:57.158-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 11:59:57.108-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	
fdb4b6db-e267-49be-8aa1-7a588e9a6d3f	Jessica	London	1	0	2015-03-20 12:03:51.329-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:51.272-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	jolly good
544f18a9-9fbe-407d-9ce7-4c45dda874df	Mike	toll	1	3	2015-04-09 17:55:55.392-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:17:00.333-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Back Woods
c4546d68-3577-444e-8e24-918f627d42fd	eliana	Panagakos	1	0	2015-04-10 00:29:21.789-04	c4546d68-3577-444e-8e24-918f627d42fd	2015-04-10 00:29:20.921-04	c4546d68-3577-444e-8e24-918f627d42fd	
e5402660-9cee-48ef-9782-46756e22aad0	Gene	Stein	1	0	2015-04-11 09:49:21.555-04	e5402660-9cee-48ef-9782-46756e22aad0	2015-04-11 09:49:20.57-04	e5402660-9cee-48ef-9782-46756e22aad0	
5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	Ron	Nezat	1	0	2015-04-14 09:17:07.803-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 09:17:06.757-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	
9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	Ron	Nezat	1	0	2015-04-14 13:15:29.193-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.142-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	CTI of Acadiana, LLC
d2723b90-ebcd-4856-8e02-56b9983f130b	Harry	valantasis	1	0	2015-04-15 17:34:35.448-04	d2723b90-ebcd-4856-8e02-56b9983f130b	2015-04-15 17:34:34.558-04	d2723b90-ebcd-4856-8e02-56b9983f130b	
b2056c93-cb7d-470f-b9cb-f043cb5328a7	houston	redmond	1	0	2015-04-17 22:49:32.298-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7	2015-04-17 22:49:31.29-04	b2056c93-cb7d-470f-b9cb-f043cb5328a7	
cf0177ba-e1e1-4685-82fe-7432bd02fb98	Buddy	hammett	1	0	2015-04-17 23:10:16.418-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	2015-04-17 23:10:15.471-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	
19b95729-0c2f-471f-a12c-0e3e470cc6bb	Jim	Allen	1	0	2015-04-17 23:14:45.293-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	2015-04-17 23:14:45.229-04	cf0177ba-e1e1-4685-82fe-7432bd02fb98	MWC
f4ff4de4-2322-447c-ae14-d1e9945c523f	sam	Battaglia	1	0	2015-04-18 02:15:16.496-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:15:15.509-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	
1039afb2-b23c-4611-a76d-b7f67cb1e839	Greg	mohar	1	11	2015-03-20 18:19:30.965-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:40:32.954-04	fd0457a0-2d66-4a63-857b-21f224a14a47	zander solutions
84525335-0f50-4354-8dd8-f9fe584df21a	Cheddie	Richardson	1	0	2015-03-20 19:28:07.495-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-03-20 19:28:07.013-04	84525335-0f50-4354-8dd8-f9fe584df21a	
3d6c5760-1a2a-4920-b821-d5f986988941	Norris	Watson	1	0	2015-03-21 09:45:56.322-04	3d6c5760-1a2a-4920-b821-d5f986988941	2015-03-21 09:45:55.25-04	3d6c5760-1a2a-4920-b821-d5f986988941	
b387a65d-3816-490c-84e9-5743fbbf14a4	sam	Battaglia	1	0	2015-04-18 02:24:47.314-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:24:47.263-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	ADV Services
e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	Bill	henson	1	2	2015-03-21 15:55:40.894-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:56:45.69-04	c27e733b-f247-498a-a945-7521cca65c3b	
41072458-fade-43dc-a1d8-543db6c37a49	Marc	Laforge	1	0	2015-04-18 03:24:15.566-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:24:14.609-04	41072458-fade-43dc-a1d8-543db6c37a49	
a99dc045-116c-4984-8e97-c49ba828de53	Jim	Mac	1	0	2015-04-18 03:29:38.383-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:29:38.325-04	41072458-fade-43dc-a1d8-543db6c37a49	cafco
3f125e85-5e84-4d28-8d7d-db1900e52cbe	Pickering		1	0	2015-04-18 05:05:18.191-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-04-18 05:05:18.105-04	9ef858fa-13d8-4152-aff7-28daea5a0842	Pickering
8968b145-675a-40be-b7bf-8e7d73ac4bb4	Larry	Shadrick	1	4	2015-03-22 13:50:35.546-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:18:04.103-04	dc91c128-7614-4592-b94e-c19660131a55	Marty's Marine
5d51d14d-0147-4816-8325-38dfe31eca50	Alessandro	Monte	1	0	2015-03-24 14:51:36.585-04	5d51d14d-0147-4816-8325-38dfe31eca50	2015-03-24 14:51:35.648-04	5d51d14d-0147-4816-8325-38dfe31eca50	
fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	gary	krogfuss	1	0	2015-03-24 18:18:05.661-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	2015-03-24 18:18:04.757-04	fa6ae4dd-1c4f-4715-ba4a-9a26ea72545c	
c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	Shankarappa	shivappa	1	0	2015-03-25 12:16:15.532-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	2015-03-25 12:16:14.55-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	
f3e83ed4-0f71-48de-8f12-b601887083bd	Shankarappa	shivappa	1	0	2015-03-25 12:17:38.888-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	2015-03-25 12:17:38.84-04	c1657cea-d460-42a7-9ab0-f0aba3cf8a0b	Tdps
fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	Salik	Group	1	0	2015-03-25 17:33:20.742-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	2015-03-25 17:33:19.739-04	fe87ef80-f979-44ef-bdff-ddc56d5dcfb4	
66274f2a-93f5-4977-932b-9e9df88f4eaf	zach	falk	1	0	2015-03-25 18:40:16.052-04	66274f2a-93f5-4977-932b-9e9df88f4eaf	2015-03-25 18:40:15.189-04	66274f2a-93f5-4977-932b-9e9df88f4eaf	
c9585e20-20ab-4d6f-8fc6-e97a098be96f	Dan	bellwood	1	0	2015-03-27 07:16:41.474-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f	2015-03-27 07:16:40.596-04	c9585e20-20ab-4d6f-8fc6-e97a098be96f	
e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	Manoj	Gaddam	1	0	2015-03-27 12:54:16.433-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	2015-03-27 12:54:15.562-04	e5cbe0ef-433c-4bd2-a576-84ea6b41aa1c	
d7bb1e62-fe40-4774-a432-03bd53510708	Brandon	lovick	1	0	2015-03-28 20:42:17.317-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-03-28 20:42:16.276-04	d7bb1e62-fe40-4774-a432-03bd53510708	
8b8ac017-1718-4f70-a117-cf9d94fc1eda	rca		1	0	2015-03-29 07:44:59.135-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.052-04	9ef858fa-13d8-4152-aff7-28daea5a0842	rca
1e03402a-162a-4499-9691-233112668148	Indunil	wanniarachchi	1	0	2015-04-18 09:58:57.804-04	1e03402a-162a-4499-9691-233112668148	2015-04-18 09:58:56.751-04	1e03402a-162a-4499-9691-233112668148	
b4dc8e16-2412-42fd-84ed-4b8a201b09fa	Rowland	LeMaster	1	0	2015-03-30 10:33:09.644-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-30 10:33:09.573-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Elks
dfaf0205-40d2-495c-8197-cf0e0ec838b4	Dan	Clune	1	0	2015-03-30 17:57:06.703-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 17:57:05.798-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	
1efc6ddf-754e-4b87-a69f-4e90cce9e442	Test 1	Testerson	1	0	2015-03-30 18:08:18.417-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-30 18:08:18.205-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	CP
22a612d0-772d-4bc0-a0d7-06e57a927e34	Peter	Gitau	1	1	2015-03-31 14:23:15.696-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:41:34.112-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	
8550e1eb-fb9a-4574-b952-0fbad9725725	Diego	Ramirez	1	0	2015-04-01 12:36:30.688-04	8550e1eb-fb9a-4574-b952-0fbad9725725	2015-04-01 12:36:29.806-04	8550e1eb-fb9a-4574-b952-0fbad9725725	
e3f56125-83d8-4419-af08-d315aa5f0afb	Rich	hankins	1	2	2015-03-29 13:24:57.57-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:28:46.785-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	
d4ccf570-9cbd-49af-9230-3947b1c0408d	Trial		1	0	2015-04-01 13:32:59.956-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:32:59.899-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	
2e7be263-d520-4063-b4f0-beeb99e67619	Rimvydas	Bruzas	1	0	2015-04-04 11:28:31.482-04	2e7be263-d520-4063-b4f0-beeb99e67619	2015-04-04 11:28:30.569-04	2e7be263-d520-4063-b4f0-beeb99e67619	
78726cf5-db49-4766-a5fb-e4b230ba1db9	Brian	Bennett	1	0	2015-04-04 14:09:35.664-04	78726cf5-db49-4766-a5fb-e4b230ba1db9	2015-04-04 14:09:34.801-04	78726cf5-db49-4766-a5fb-e4b230ba1db9	
dafd2094-adc5-45dc-b36a-61142dfd2507	Jamie	hodge	1	0	2015-04-04 17:24:44.243-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:44.198-04	84525335-0f50-4354-8dd8-f9fe584df21a	bb
0af9286e-2a2a-45c5-81ef-fbd0ccc71d5b	mark	wilder	1	0	2015-04-04 23:36:35.158-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-04 23:36:35.108-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	
5614f192-f2bf-48d7-8912-f6ab1286bd7d	Gjergj	Gojcaj	1	0	2015-04-18 11:21:40.087-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:21:39.096-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	
547b9e45-ff74-4626-a9b2-1df9b6001d84	Dennis	Olsen	1	0	2015-04-23 11:52:09.731-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 11:52:09.273-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	
595ad16c-cc97-44f9-973d-8a8bea4682bb	Rich		1	1	2015-04-18 11:23:03.871-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:23:39.951-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	
5341f975-1bfb-4991-acd2-3c1b58ac1b30	Jerry	Wernimont	1	0	2015-04-18 14:14:23.119-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30	2015-04-18 14:14:22.183-04	5341f975-1bfb-4991-acd2-3c1b58ac1b30	
263edbd8-24c6-488b-ad4b-76abc61b76ed	Craig	Gilliam	1	0	2015-04-19 08:20:02.755-04	263edbd8-24c6-488b-ad4b-76abc61b76ed	2015-04-19 08:20:01.725-04	263edbd8-24c6-488b-ad4b-76abc61b76ed	
737398f9-28e7-4a98-bc58-442a6783a5fe	Mark	sammons	1	0	2015-04-19 10:43:52.438-04	737398f9-28e7-4a98-bc58-442a6783a5fe	2015-04-19 10:43:51.346-04	737398f9-28e7-4a98-bc58-442a6783a5fe	
ade5256e-c8d9-44f3-9714-262fafb8a475	Keefe	Duhon	1	0	2015-04-19 12:07:58.662-04	ade5256e-c8d9-44f3-9714-262fafb8a475	2015-04-19 12:07:57.758-04	ade5256e-c8d9-44f3-9714-262fafb8a475	
3e692a5f-6853-4fe3-a0d5-8fdc2d592d73	garage		1	0	2015-04-23 17:38:05.02-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:38:04.953-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	
c0b7bdda-a97c-4772-8490-604f9c022ca5	Kim		1	1	2015-04-23 12:04:05.431-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-23 12:05:17.261-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	
2c9df1e2-cb59-4f63-b854-241e044ece4d	Anthony	Hrebluk	1	0	2015-04-25 14:48:01.046-04	2c9df1e2-cb59-4f63-b854-241e044ece4d	2015-04-25 14:48:00.022-04	2c9df1e2-cb59-4f63-b854-241e044ece4d	
b6f4370a-2301-4810-9745-5b8a2deb728d	Brad	Yoder	1	0	2015-04-26 21:32:23.341-04	b6f4370a-2301-4810-9745-5b8a2deb728d	2015-04-26 21:32:22.416-04	b6f4370a-2301-4810-9745-5b8a2deb728d	
cfead6e4-9ae4-4584-9f67-03f4ddc48a0e	Jim	Ryan	1	0	2015-04-27 14:02:58.18-04	b6f4370a-2301-4810-9745-5b8a2deb728d	2015-04-27 14:02:58.053-04	b6f4370a-2301-4810-9745-5b8a2deb728d	360coating
bea77c25-d4c4-4821-b935-f4908ec9c0a4	Octavio	Castaneda	1	0	2015-04-27 20:12:26.079-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4	2015-04-27 20:12:25.161-04	bea77c25-d4c4-4821-b935-f4908ec9c0a4	
5a95c207-4d12-4712-a0dd-df4227795142	bru	size	1	0	2015-04-28 06:29:58.082-04	5a95c207-4d12-4712-a0dd-df4227795142	2015-04-28 06:29:57.564-04	5a95c207-4d12-4712-a0dd-df4227795142	
7ae87126-063a-451a-a567-0d285ca16bd5	Ed	Lindberg	1	0	2015-04-28 08:01:14.928-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:14.808-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	TSSi
05ffe28f-ec37-4b04-b3f7-68aeb6cda998	Bruno	theoret	1	0	2015-04-29 09:14:31.117-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998	2015-04-29 09:14:30.157-04	05ffe28f-ec37-4b04-b3f7-68aeb6cda998	
4ed2745b-5397-4290-9e4b-971eea1e1359	Mario	Morales	1	0	2015-04-30 21:03:21.468-04	4ed2745b-5397-4290-9e4b-971eea1e1359	2015-04-30 21:03:20.456-04	4ed2745b-5397-4290-9e4b-971eea1e1359	
350a236f-f780-40e9-85e3-2b9227f4d76f	Erin	Stopczynski	1	0	2015-05-02 18:10:05.212-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:10:04.192-04	350a236f-f780-40e9-85e3-2b9227f4d76f	
2d91f9e1-13db-4073-95f8-566ab180d204	Jon	doe	1	1	2015-05-02 18:11:41.438-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:45.046-04	350a236f-f780-40e9-85e3-2b9227f4d76f	
c276de4d-a087-4025-922b-73cabe491bd3	Jeremy	Overholt	1	0	2015-05-04 17:08:03.758-04	c276de4d-a087-4025-922b-73cabe491bd3	2015-05-04 17:08:02.857-04	c276de4d-a087-4025-922b-73cabe491bd3	
ecaa82b2-d881-4d3a-8322-726a45e42c11	Christopher	Jones	1	0	2015-05-05 07:51:57.294-04	ecaa82b2-d881-4d3a-8322-726a45e42c11	2015-05-05 07:51:56.357-04	ecaa82b2-d881-4d3a-8322-726a45e42c11	
c11cfe2d-a585-42e2-a570-08b850e9a894	Eduardo	Delgadillo	1	0	2015-05-05 18:26:07.684-04	c11cfe2d-a585-42e2-a570-08b850e9a894	2015-05-05 18:26:06.663-04	c11cfe2d-a585-42e2-a570-08b850e9a894	
c44338f5-0424-4594-92f4-404202fc9ad5	kobiljonh		1	0	2015-05-05 19:40:47.202-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-05-05 19:40:47.151-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
36e29838-9bab-4f74-942e-211fe7624107	Eduardo	Delgadillo	1	0	2015-05-06 10:34:20.174-04	c11cfe2d-a585-42e2-a570-08b850e9a894	2015-05-06 10:34:20.118-04	c11cfe2d-a585-42e2-a570-08b850e9a894	Grupo csq
fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	Chris	Osborne	1	0	2015-05-08 11:17:09.548-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	2015-05-08 11:17:08.538-04	fd6b63a4-3f1b-4d9a-b6a1-e198455d5429	
1c996f95-6044-4110-8a19-eb1c2c40d597	Dameer	relford	1	0	2015-05-08 14:40:54.979-04	1c996f95-6044-4110-8a19-eb1c2c40d597	2015-05-08 14:40:54.002-04	1c996f95-6044-4110-8a19-eb1c2c40d597	
346ff4ec-5d01-464f-94a6-b282484b7d8b	Joe	Lydon	1	0	2015-05-11 11:55:05.246-04	346ff4ec-5d01-464f-94a6-b282484b7d8b	2015-05-11 11:55:04.25-04	346ff4ec-5d01-464f-94a6-b282484b7d8b	
609ec79e-ea84-4c4a-abe1-67f4c38bbe92	Jake	Mariano	1	0	2015-05-11 21:33:13.284-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92	2015-05-11 21:33:12.292-04	609ec79e-ea84-4c4a-abe1-67f4c38bbe92	
bcff8f11-ed0d-4a44-a96a-08a3c646d737	Alan	Batts	1	0	2015-05-11 22:58:52.875-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737	2015-05-11 22:58:51.992-04	bcff8f11-ed0d-4a44-a96a-08a3c646d737	
bd896255-7124-4478-97c7-606bd75f241f	Darnay	barefoot	1	1	2015-04-22 10:24:55.945-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:51:13.188-04	d7bb1e62-fe40-4774-a432-03bd53510708	
304f78a7-8428-415f-b526-1aa3326b6244	Sean	connolly	1	0	2015-05-14 12:00:02.973-04	304f78a7-8428-415f-b526-1aa3326b6244	2015-05-14 12:00:02.056-04	304f78a7-8428-415f-b526-1aa3326b6244	
6da7d4f7-c747-4955-ab23-1b62554db9ce	Dan	winter	1	0	2015-05-14 17:11:40.754-04	6da7d4f7-c747-4955-ab23-1b62554db9ce	2015-05-14 17:11:39.791-04	6da7d4f7-c747-4955-ab23-1b62554db9ce	
884721c6-aea2-4d0d-9d9d-6fa329d1f539	kyle	deckard	1	0	2015-05-15 17:41:19.669-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539	2015-05-15 17:41:18.645-04	884721c6-aea2-4d0d-9d9d-6fa329d1f539	
c53ab4cb-e0be-4c86-86eb-46773c9551e0	Aaron	banish	1	0	2015-05-16 14:44:41.135-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0	2015-05-16 14:44:40.162-04	c53ab4cb-e0be-4c86-86eb-46773c9551e0	
6760db3d-f5de-488b-9341-f6945c161fe7	Jim	Dixon	1	0	2015-07-02 14:25:31.85-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:31.789-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	
61709628-4bca-418f-8dc4-1ad358c785d6	Dan	Clune	1	0	2015-07-05 23:24:13.359-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:24:12.909-04	61709628-4bca-418f-8dc4-1ad358c785d6	
c4606f0b-9e13-468f-bec6-c038d978b000	Lisa	Rice	1	5	2015-03-20 09:29:17.81-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:11:01.386-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	
12034988-1c47-4bdd-b7ac-1751e04269ad	Jessie	layton	1	0	2015-05-18 21:57:44.187-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-18 21:57:43.111-04	12034988-1c47-4bdd-b7ac-1751e04269ad	
76a7c86f-b465-4236-960d-2b847f9b5137	Laura	chaparro	1	0	2015-05-19 00:20:29.94-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:29.875-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	
af9de559-5bc7-4b41-a0b1-430ad5303743	Janas		1	1	2015-05-19 00:31:48.837-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-19 00:33:16.778-04	12034988-1c47-4bdd-b7ac-1751e04269ad	
49c6ee87-ab1c-46a5-8999-09739d738503	Maggie	Test	1	0	2015-05-20 15:17:28.498-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:17:28.442-04	06169b04-bb68-4868-b995-98388fa33e16	
ed0f17a5-f767-42ee-8a5d-d73334668ad5	don	posty	1	0	2015-05-21 18:16:31.087-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-05-21 18:16:31.028-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
7f13a571-83af-4b72-ae3f-5777badf0027	Bernardo	Gremli	1	0	2015-05-21 20:33:40.208-04	7f13a571-83af-4b72-ae3f-5777badf0027	2015-05-21 20:33:39.297-04	7f13a571-83af-4b72-ae3f-5777badf0027	
2a63f4b8-4436-45bf-9439-866ac59e1911	Andy	Franklin	1	0	2015-05-24 11:02:43.786-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-05-24 11:02:42.886-04	2a63f4b8-4436-45bf-9439-866ac59e1911	
4023e17e-c332-4669-9dd5-63f796508059	Tim	babcock	1	0	2015-05-24 15:12:17.98-04	4023e17e-c332-4669-9dd5-63f796508059	2015-05-24 15:12:17.064-04	4023e17e-c332-4669-9dd5-63f796508059	
464972d2-3955-40a6-abf5-5ada5cd9e4ea	David	watruba	1	0	2015-05-26 10:08:16.783-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea	2015-05-26 10:08:15.784-04	464972d2-3955-40a6-abf5-5ada5cd9e4ea	
fb81d126-c102-4e37-a1d6-a709a5eb7d1a	Kaydee	jane	1	0	2015-05-27 00:18:45.645-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a	2015-05-27 00:18:44.602-04	fb81d126-c102-4e37-a1d6-a709a5eb7d1a	
e70477ac-5ece-430d-9287-a92dd7cc190c	Tony	DaPonte	1	0	2015-05-30 10:37:05.854-04	e70477ac-5ece-430d-9287-a92dd7cc190c	2015-05-30 10:37:04.744-04	e70477ac-5ece-430d-9287-a92dd7cc190c	
731ab8d0-f175-4fc7-9ee2-06f8ca374bf8	Krista	little	1	0	2015-06-01 12:04:07.898-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:07.834-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	landmark Ministries
55abc66e-bcb2-45c9-9c53-d24f0fca5957	Avery		1	0	2015-06-03 19:43:57.259-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:57.205-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	
279fc46a-5ab9-41d0-979b-2e66492125c1	Samuel	peru	1	0	2015-06-04 08:03:36.055-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-06-04 08:03:35.973-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
5f96f064-10c1-4278-af7c-35b9e0df8728	Josh	Koschmider	1	0	2015-06-05 11:56:05.25-04	5f96f064-10c1-4278-af7c-35b9e0df8728	2015-06-05 11:56:04.337-04	5f96f064-10c1-4278-af7c-35b9e0df8728	
2d259e86-2515-4439-9ad9-8c97d751bc88	valentino	alvarado	1	0	2015-06-13 22:51:15.557-04	2d259e86-2515-4439-9ad9-8c97d751bc88	2015-06-13 22:51:14.624-04	2d259e86-2515-4439-9ad9-8c97d751bc88	
abc5acf5-6911-4a9d-b8ff-7f740a9267ba	Valentino	Alvarado	1	0	2015-06-16 19:25:42.278-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba	2015-06-16 19:25:41.291-04	abc5acf5-6911-4a9d-b8ff-7f740a9267ba	
6ae51daf-f753-4ec4-8459-b1cd81e626ef	John	doe	1	0	2015-06-20 18:33:32.608-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-06-20 18:33:32.536-04	350a236f-f780-40e9-85e3-2b9227f4d76f	
0b06c16f-8148-4df7-8658-f415f6fb5fe9	Changa	Changa	1	0	2015-06-21 22:11:05.048-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-06-21 22:11:04.983-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
7f31c83c-1703-4477-b5b4-9cedd5b9ab9b	Jean and Al	peter	1	0	2015-06-23 10:37:42.986-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:37:42.923-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	
da7076fb-15b5-4d73-8595-98dc8d53170c	Steve	Salmons	1	0	2015-06-25 08:02:51.507-04	da7076fb-15b5-4d73-8595-98dc8d53170c	2015-06-25 08:02:50.518-04	da7076fb-15b5-4d73-8595-98dc8d53170c	
4f954bb7-744d-49ab-9990-7395720ae3ed	Kathy	Fowler	1	0	2015-06-25 08:06:17.504-04	4f954bb7-744d-49ab-9990-7395720ae3ed	2015-06-25 08:06:16.667-04	4f954bb7-744d-49ab-9990-7395720ae3ed	
55b80699-7270-4cf1-a342-2d0c63684b02	Troy	Nadeau	1	0	2015-06-25 18:36:19.554-04	55b80699-7270-4cf1-a342-2d0c63684b02	2015-06-25 18:36:18.677-04	55b80699-7270-4cf1-a342-2d0c63684b02	
0a215950-e391-4575-8d45-e5c36c6cb723	Brian	Cochran	1	0	2015-06-26 14:22:20.353-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-06-26 14:22:19.348-04	0a215950-e391-4575-8d45-e5c36c6cb723	
f1a9a130-48b6-4843-a5e3-d8c0403b9276	Steve	Foster	1	0	2015-06-29 16:10:52.484-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276	2015-06-29 16:10:51.501-04	f1a9a130-48b6-4843-a5e3-d8c0403b9276	
cc0c563b-880f-445d-8026-8265c2de2f88	James	sweeney	1	0	2015-06-29 17:08:28.264-04	cc0c563b-880f-445d-8026-8265c2de2f88	2015-06-29 17:08:27.34-04	cc0c563b-880f-445d-8026-8265c2de2f88	
85a17430-3568-44af-a520-175faaf6a9ee	Michael	Puac	1	0	2015-06-29 18:55:58.256-04	85a17430-3568-44af-a520-175faaf6a9ee	2015-06-29 18:55:57.406-04	85a17430-3568-44af-a520-175faaf6a9ee	
536d9218-deaa-44fb-b9f2-7c81447ee863	Douglas	check	1	0	2015-07-01 21:42:35.466-04	536d9218-deaa-44fb-b9f2-7c81447ee863	2015-07-01 21:42:34.411-04	536d9218-deaa-44fb-b9f2-7c81447ee863	
01224f92-b94d-45d7-aae8-1888f7605178	Mike	noblin	1	0	2015-07-08 09:30:15.816-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-07-08 09:30:15.765-04	d7bb1e62-fe40-4774-a432-03bd53510708	
0550dbbd-7c9b-4339-b4fb-d2ba09203650	Testy	Testerson	1	5	2015-07-05 23:29:50.869-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:35:13.999-04	61709628-4bca-418f-8dc4-1ad358c785d6	PDC
9abd2e47-ff0e-4d5e-97f9-683c3e61bfed		Smith	1	0	2015-07-08 09:43:12.789-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-08 09:43:12.745-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Willow restaurant
73bc3ee0-49d2-4ff0-a456-0c42634b1c40	Eric	Cunningham	1	0	2015-07-06 10:56:09.803-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40	2015-07-06 10:56:08.828-04	73bc3ee0-49d2-4ff0-a456-0c42634b1c40	
5414f676-63e9-4117-87bd-ec5577e932b7	Dennis	Olsen	1	0	2015-07-13 08:14:53.792-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:14:52.905-04	5414f676-63e9-4117-87bd-ec5577e932b7	
45861459-4e42-46f6-87d5-1b46e00da2b8	Rick		1	0	2015-07-13 08:20:51.505-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:20:51.453-04	5414f676-63e9-4117-87bd-ec5577e932b7	massanutten
b2225f01-b777-4f75-95a5-9e9119e0d27b	Rick		1	1	2015-07-13 08:21:30.803-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:26:12.633-04	5414f676-63e9-4117-87bd-ec5577e932b7	Peak Construction
6c014dcf-e073-4d33-ad87-5b626c9bd967	Richard	Harman	1	0	2015-07-14 10:41:31.081-04	6c014dcf-e073-4d33-ad87-5b626c9bd967	2015-07-14 10:41:30.201-04	6c014dcf-e073-4d33-ad87-5b626c9bd967	
87d98cd3-bf10-467a-bd9c-d91f2bebf4af	Tony	Trapaso	1	0	2015-07-15 19:34:16.345-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-07-15 19:34:16.291-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
b88d77d6-5f80-40ce-8e02-32f4e80e4608	Jr	yoder	1	0	2015-07-17 21:33:31.571-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:31.52-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	
7690a61d-caec-4041-b274-7db1067cd96b	Test	Guy	1	0	2015-07-22 15:39:12.025-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-07-22 15:39:11.969-04	2a63f4b8-4436-45bf-9439-866ac59e1911	
82b2860d-fa82-443f-96e1-91da43fab547	Today	Testing	1	0	2015-07-22 17:02:50.752-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:02:50.705-04	06169b04-bb68-4868-b995-98388fa33e16	
f165e76a-6fd6-4bbc-a241-c08be8cf4212	Kevin	VanElsen	1	0	2015-07-22 22:06:50.062-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:06:49.094-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	
fdc7e547-2bd3-4d0a-9919-51d96b641e5f	John	doe	1	0	2015-07-22 22:10:04.508-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:10:04.45-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	
e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	edged	gardinier	1	0	2015-07-24 15:59:08.033-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 15:59:06.883-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	
b2c2fa8f-39cd-4ea7-9b06-ea1d88b8bec9	nancy	gardinier	1	1	2015-07-24 16:03:28.346-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:15:21.422-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	edged ent
be93b045-2bd1-43a0-94f2-29af3280a0db	edward	gardinier	1	0	2015-07-25 14:29:54.768-04	be93b045-2bd1-43a0-94f2-29af3280a0db	2015-07-25 14:29:53.758-04	be93b045-2bd1-43a0-94f2-29af3280a0db	
af3c6f48-78bf-497f-82d6-d2e46019f7e9	nancy	gardinier	1	0	2015-07-25 14:36:37.783-04	be93b045-2bd1-43a0-94f2-29af3280a0db	2015-07-25 14:36:37.727-04	be93b045-2bd1-43a0-94f2-29af3280a0db	edged
12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	John	Difillippo	1	0	2015-07-28 11:17:35.339-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	2015-07-28 11:17:34.419-04	12dd6fe4-6eb8-47c9-9e79-3b9fbd85e75e	
4847bb7d-1587-4e1b-b93b-87a5df1257fe	Lucas	Brunetti	1	0	2015-07-28 13:25:04.441-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe	2015-07-28 13:25:03.465-04	4847bb7d-1587-4e1b-b93b-87a5df1257fe	
fe71fcd3-3c96-45ed-a95e-1f936af67b79	Arnie		1	0	2015-07-29 11:06:59.416-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:06:59.366-04	0a215950-e391-4575-8d45-e5c36c6cb723	Whittenberg Construction
505aa5d3-9028-4827-9cfa-e35992f4d963	Brian	Diffin	1	0	2015-07-31 10:34:12.996-04	505aa5d3-9028-4827-9cfa-e35992f4d963	2015-07-31 10:34:12.016-04	505aa5d3-9028-4827-9cfa-e35992f4d963	
d0b3d250-9659-4717-b583-2fd7ecbdf913	Jack	McElveen	1	0	2015-08-02 19:08:27.928-04	d0b3d250-9659-4717-b583-2fd7ecbdf913	2015-08-02 19:08:26.437-04	d0b3d250-9659-4717-b583-2fd7ecbdf913	
32aea253-36e7-4b71-8fb3-e46e9f757bfc	Teresa	schneider	1	0	2015-08-03 18:52:52.534-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc	2015-08-03 18:52:51.593-04	32aea253-36e7-4b71-8fb3-e46e9f757bfc	
c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	Dennis	Olsen	1	0	2015-08-04 08:08:50.451-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	2015-08-04 08:08:49.342-04	c872a7f7-6ccd-446d-8c82-b35b7e5ea7a1	
8efcd5d9-df90-49c5-bae1-6420e8628e74	Justin	Eckrote	1	0	2015-08-06 10:53:27.38-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-06 10:53:26.375-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	
84bf0d55-d547-416a-8bce-0e5d7d7ddc96	Nick	Faulkner	1	0	2015-08-06 17:47:10.351-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96	2015-08-06 17:47:09.376-04	84bf0d55-d547-416a-8bce-0e5d7d7ddc96	
adbb7632-8173-4c03-9211-2dbb3e5e64c4	Jeremy	Hull	1	0	2015-08-08 12:39:13.886-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4	2015-08-08 12:39:12.879-04	adbb7632-8173-4c03-9211-2dbb3e5e64c4	
11ee25db-8720-4e02-aacd-f33e2e313375	Melanie	Huntley	1	0	2015-08-09 05:18:22.176-04	11ee25db-8720-4e02-aacd-f33e2e313375	2015-08-09 05:18:21.176-04	11ee25db-8720-4e02-aacd-f33e2e313375	
f1c1d499-c1ec-46d6-816c-d5cb1c18dbbe	Dough	luis	1	1	2015-09-10 02:33:14.68-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:35:26.017-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	aera
b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	Erik	Winterland	1	0	2015-09-10 15:24:52.383-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	2015-09-10 15:24:51.367-04	b5d4b34a-17b2-4d69-9d47-48895b5fdc0a	
115b8d12-240b-4d68-8821-a30ddf7e2171	Andrew	Adams	1	0	2015-08-11 13:30:05.314-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:30:05.252-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	
47da5910-d577-4386-89a9-e271be4a2f4f	Test	test	1	0	2015-08-13 08:42:11.842-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:42:10.867-04	47da5910-d577-4386-89a9-e271be4a2f4f	
c4568bb9-be77-46bc-bad1-1a75fc1ea00c	Mark	benton	1	0	2015-08-13 08:44:14.082-04	47da5910-d577-4386-89a9-e271be4a2f4f	2015-08-13 08:44:14.021-04	47da5910-d577-4386-89a9-e271be4a2f4f	
470cb0b5-a9f5-4c7a-b261-329056220023	Mark	Weller	1	0	2015-08-13 10:42:24.276-04	470cb0b5-a9f5-4c7a-b261-329056220023	2015-08-13 10:42:23.403-04	470cb0b5-a9f5-4c7a-b261-329056220023	
d5e8db62-f918-4ff9-b891-4cec9d647ea5	Joe	Floyd	1	0	2015-08-16 11:24:21.513-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5	2015-08-16 11:24:20.425-04	d5e8db62-f918-4ff9-b891-4cec9d647ea5	
e604c054-19e1-4332-b9ae-97ef0c58380f	Linas	Sipelis	1	0	2015-08-18 22:29:08.967-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-18 22:29:08.04-04	e604c054-19e1-4332-b9ae-97ef0c58380f	
86be876f-32c6-496c-953a-48ee6ad2dc10	Richard	corzo	1	0	2015-08-19 23:05:41.494-04	86be876f-32c6-496c-953a-48ee6ad2dc10	2015-08-19 23:05:40.425-04	86be876f-32c6-496c-953a-48ee6ad2dc10	
e974d03d-7779-4c6a-b68b-95f69f1423b4	Greg	Ackerman	1	3	2015-08-09 18:12:57.595-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-20 12:19:47.001-04	067b4635-5840-48fd-980d-ccddbe1b173d	
c4723847-be20-49a1-a056-e4da739856b1	Serge	Hilliard	1	0	2015-08-24 19:09:34.267-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-08-24 19:09:34.195-04	9ef858fa-13d8-4152-aff7-28daea5a0842	
c0697e56-11bf-4e37-a029-aac44d1af67c	John	difillippo	1	0	2015-08-26 11:56:21.414-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 11:56:20.308-04	c0697e56-11bf-4e37-a029-aac44d1af67c	
59977c2e-d426-4c1b-aea6-98121f5d1ae2	Bill	testingvideo	1	0	2015-08-26 12:00:52.876-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 12:00:52.808-04	c0697e56-11bf-4e37-a029-aac44d1af67c	noname
83369076-1bb1-4793-ad96-cbb91d1b1d5c	Grazina		1	0	2015-08-26 13:35:43.103-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.017-04	e604c054-19e1-4332-b9ae-97ef0c58380f	
0f1beec1-dbc9-458f-a5f6-ce714b91369a	Chris	Hawley	1	0	2015-08-26 13:56:26.52-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a	2015-08-26 13:56:25.653-04	0f1beec1-dbc9-458f-a5f6-ce714b91369a	
3fd5a3de-cf27-460f-a3cf-8104c4527c5c	Harry	liberatore	1	0	2015-08-26 18:53:40.095-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c	2015-08-26 18:53:39.226-04	3fd5a3de-cf27-460f-a3cf-8104c4527c5c	
0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	Emmanouil	chrysochoidis	1	0	2015-08-27 05:21:01.05-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	2015-08-27 05:21:00.189-04	0fa4c5e3-0908-40a4-bd38-a34ca7c9a544	
a1e17f3f-cc53-48a7-a4b1-b600a36fca05	Neven	Bacich	1	0	2015-08-28 08:07:50.732-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05	2015-08-28 08:07:49.796-04	a1e17f3f-cc53-48a7-a4b1-b600a36fca05	
b698f42c-ef50-438c-9254-f2d0ef64fc33	Christopher	Jones	1	0	2015-08-28 10:57:19.087-04	b698f42c-ef50-438c-9254-f2d0ef64fc33	2015-08-28 10:57:18.118-04	b698f42c-ef50-438c-9254-f2d0ef64fc33	
0f5cc00a-ab76-425f-9150-8072eae9bf75	Ramiro	Chavez	1	0	2015-08-29 21:50:24.165-04	0f5cc00a-ab76-425f-9150-8072eae9bf75	2015-08-29 21:50:23.045-04	0f5cc00a-ab76-425f-9150-8072eae9bf75	
89b13534-20eb-49d7-914c-d84a673f858d	Evan	Hagan	1	0	2015-08-30 21:39:31.502-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:39:30.612-04	89b13534-20eb-49d7-914c-d84a673f858d	
2cc106c6-c7ec-4c56-884e-2929e4d805ec	Ann	Abbott	1	1	2015-08-30 21:43:43.505-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:44:19.05-04	89b13534-20eb-49d7-914c-d84a673f858d	
a5ef1333-2472-4bcb-b357-98c20ec3c93e	Jose	sancgez	1	0	2015-08-31 15:15:28.87-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e	2015-08-31 15:15:27.925-04	a5ef1333-2472-4bcb-b357-98c20ec3c93e	
0e54af85-b94d-40f0-b1bc-ce950b906307	Kim		1	0	2015-09-02 08:07:46.909-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-09-02 08:07:46.839-04	d7bb1e62-fe40-4774-a432-03bd53510708	
3f208971-2778-4ac6-b00a-52c05d0d7597	Brian	hudon	1	0	2015-09-03 08:35:01.898-04	3f208971-2778-4ac6-b00a-52c05d0d7597	2015-09-03 08:35:00.671-04	3f208971-2778-4ac6-b00a-52c05d0d7597	
4b4b2595-96d5-4a70-bf64-e150de4cecf1	Robyn	Murton	1	0	2015-09-03 18:18:43.668-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1	2015-09-03 18:18:42.662-04	4b4b2595-96d5-4a70-bf64-e150de4cecf1	
0df4f263-d9e5-48da-927b-2dfa56c8639f	Grazina		1	0	2015-09-04 17:19:22.672-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:19:22.613-04	e604c054-19e1-4332-b9ae-97ef0c58380f	
ec4a6dfa-cf62-4d9f-907d-46624cc39d4b	Gr		1	1	2015-09-04 17:23:33.069-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:24:16.285-04	e604c054-19e1-4332-b9ae-97ef0c58380f	
86103f7b-c3bd-489b-a732-10374a07ed5a	Chad	Snedegar	1	0	2015-09-04 21:53:06.886-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-09-04 21:53:06.036-04	86103f7b-c3bd-489b-a732-10374a07ed5a	
644eb96f-6f1f-47aa-a5dc-d5869c2963df	Manuel	Alejandrez	1	0	2015-09-06 01:55:20.517-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df	2015-09-06 01:55:19.49-04	644eb96f-6f1f-47aa-a5dc-d5869c2963df	
7c7c1cd4-e190-4d36-a71e-58b3f939d25c	Michael	ray	1	0	2015-09-10 02:30:50.398-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:30:49.408-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	
58c16b16-a3f6-4d5b-ab85-5d4384e84de3	Sherif	abdelhameed	1	0	2015-09-13 00:45:06-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	2015-09-13 00:45:05.033-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	
b0c71ef5-05f9-435c-bd5b-7da5a3beeb34	Sherif		1	0	2015-09-13 00:46:58.222-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	2015-09-13 00:46:58.148-04	58c16b16-a3f6-4d5b-ab85-5d4384e84de3	Saipem
ffe3a005-5547-420a-a06e-1b0c8349bf51	Pro Painters	Toronto	1	0	2015-09-13 21:31:56.614-04	ffe3a005-5547-420a-a06e-1b0c8349bf51	2015-09-13 21:31:55.635-04	ffe3a005-5547-420a-a06e-1b0c8349bf51	
4f221611-83b3-4c94-95e4-9062e001b55b	Gregory	Berg	1	0	2015-09-14 09:17:24.52-04	4f221611-83b3-4c94-95e4-9062e001b55b	2015-09-14 09:17:23.577-04	4f221611-83b3-4c94-95e4-9062e001b55b	
7871755b-f26b-4b3b-9eca-124c725d5aa1	Brian	Hatfield	1	0	2015-09-15 12:44:33.543-04	7871755b-f26b-4b3b-9eca-124c725d5aa1	2015-09-15 12:44:32.64-04	7871755b-f26b-4b3b-9eca-124c725d5aa1	
ecc4c035-a2d5-433d-93e6-107b59982e77	Donna		1	0	2015-09-23 13:04:31.748-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-09-23 13:04:31.666-04	86103f7b-c3bd-489b-a732-10374a07ed5a	DJ's
9ec76276-7e09-41dd-aed1-bda46d79a89a	Macarena	contador	1	0	2015-09-25 09:36:01.509-04	9ec76276-7e09-41dd-aed1-bda46d79a89a	2015-09-25 09:36:00.486-04	9ec76276-7e09-41dd-aed1-bda46d79a89a	
b842c097-ef8f-4d48-9e26-3ad73fe28b68	Scott	Lowery	1	0	2015-09-27 11:03:58.544-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68	2015-09-27 11:03:57.593-04	b842c097-ef8f-4d48-9e26-3ad73fe28b68	
25dc0a11-1989-4863-bcbf-b794bdb4fe4a	bbb	123	1	0	2015-09-28 11:43:47.982-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:43:47.441-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	
659995f4-3889-458f-8b56-644a10fee656	chc	cjcj	1	0	2015-09-28 11:44:08.607-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:44:08.557-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	
5c253621-1a91-400d-bd38-d1325fe740ad	hchx	chc	1	0	2015-09-28 11:45:13.317-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:45:13.256-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	
fbfa7146-026c-421e-b1b2-b5f220c7028a	dgkdks	xvmxm	1	0	2015-09-28 11:45:42.811-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	2015-09-28 11:45:42.752-04	25dc0a11-1989-4863-bcbf-b794bdb4fe4a	
621af548-c387-471f-9d6d-ef4a20c81eb2	Frank	stella	1	0	2015-09-30 03:02:31.78-04	621af548-c387-471f-9d6d-ef4a20c81eb2	2015-09-30 03:02:30.683-04	621af548-c387-471f-9d6d-ef4a20c81eb2	
ee2ef90f-e171-4422-b6a7-d783584c27b4	d123	d123	1	0	2015-10-09 09:27:45.65-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	2015-10-09 09:27:44.62-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	
e153fd13-4f5e-4040-b88d-b46eab1510da	trjrtj	rthrfth	1	0	2015-10-09 09:28:25.82-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	2015-10-09 09:28:25.74-04	ee2ef90f-e171-4422-b6a7-d783584c27b4	rthrth
51855703-9a42-4c37-8418-24da5bf57be7	Shannon	Fannin	1	0	2015-10-19 13:55:18.89-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 13:55:17.824-04	51855703-9a42-4c37-8418-24da5bf57be7	
20f5f15e-ee40-401b-8ae7-d094af9ee576	Brownfield	Kruyer	1	1	2015-10-19 14:44:49.717-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:49.191-04	51855703-9a42-4c37-8418-24da5bf57be7	
2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	Rick	Gordon	1	0	2015-10-19 18:09:32.081-04	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	2015-10-19 18:09:31.213-04	2e737de5-fa01-4ac8-b7b8-d40f7b20b8cd	
9b53f8fe-453f-4512-9016-81c3f56c16b5	Tanner	Jobgen	1	0	2015-10-19 18:23:51.789-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	2015-10-19 18:23:50.862-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	
feaed0f2-1271-4dff-98a3-70d7bb88d450	Donna	Fostet	1	0	2015-10-19 18:25:16.79-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	2015-10-19 18:25:16.745-04	9b53f8fe-453f-4512-9016-81c3f56c16b5	
cca78e0c-34ac-4a21-9564-b391dbe19ec2	Jack	Lait	1	0	2015-10-19 18:50:25.915-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2	2015-10-19 18:50:25.017-04	cca78e0c-34ac-4a21-9564-b391dbe19ec2	
d2311570-b0de-4b85-8af2-084bde99159d	Alonzo	Pringle	1	0	2015-10-19 20:17:15.184-04	d2311570-b0de-4b85-8af2-084bde99159d	2015-10-19 20:17:14.276-04	d2311570-b0de-4b85-8af2-084bde99159d	
9a5f7b41-5057-4940-a321-30eb50b50554	eee	eeee	1	0	2015-10-19 23:21:10.7-04	9a5f7b41-5057-4940-a321-30eb50b50554	2015-10-19 23:21:09.766-04	9a5f7b41-5057-4940-a321-30eb50b50554	
0455bfd0-c938-480d-a68a-9cbff8e72cc1	Larry	Trujillo	1	0	2015-10-20 07:55:06.424-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1	2015-10-20 07:55:05.428-04	0455bfd0-c938-480d-a68a-9cbff8e72cc1	
96b9a7e8-5273-40ab-ac79-65548e56a63a	Luis	Saravali	1	0	2015-10-20 20:38:04.186-04	96b9a7e8-5273-40ab-ac79-65548e56a63a	2015-10-20 20:38:03.241-04	96b9a7e8-5273-40ab-ac79-65548e56a63a	
ac137c0e-5239-4124-891a-0f32554a48f5	Scott	Hylton	1	0	2015-10-22 18:26:29.848-04	ac137c0e-5239-4124-891a-0f32554a48f5	2015-10-22 18:26:28.893-04	ac137c0e-5239-4124-891a-0f32554a48f5	
c6a75811-f89a-498c-82ca-e5bc63c87087	Derrick	Spencer	1	0	2015-10-23 22:45:18.218-04	c6a75811-f89a-498c-82ca-e5bc63c87087	2015-10-23 22:45:17.32-04	c6a75811-f89a-498c-82ca-e5bc63c87087	
188a89cb-562b-45d2-ac34-32ac98e27a7e	Blake	Harris	1	0	2015-10-24 20:16:42.163-04	188a89cb-562b-45d2-ac34-32ac98e27a7e	2015-10-24 20:16:41.199-04	188a89cb-562b-45d2-ac34-32ac98e27a7e	
d72dca02-a605-400d-8037-2e3cbe18f5ce	Josh	Cummins	1	0	2015-10-27 13:29:23.042-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:22.961-04	86103f7b-c3bd-489b-a732-10374a07ed5a	Dan cummins Chevy
fb08c1d6-72b8-4439-8714-4472d0aa057b	Brian	Stallter	1	0	2015-10-28 10:29:20.16-04	fb08c1d6-72b8-4439-8714-4472d0aa057b	2015-10-28 10:29:19.144-04	fb08c1d6-72b8-4439-8714-4472d0aa057b	
a43e9817-e631-4f88-869e-eadb767fe78d	Sandy	Russell	1	0	2015-10-29 18:19:48.321-04	a43e9817-e631-4f88-869e-eadb767fe78d	2015-10-29 18:19:47.351-04	a43e9817-e631-4f88-869e-eadb767fe78d	
31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	October	Test	1	0	2015-10-30 11:54:45.696-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:45.642-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	SupremeCrete
76b254bb-262d-48bd-9bed-3b121a10efb5	Tom	Franklin	1	3	2015-11-02 16:00:21.689-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 19:44:19.149-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
9a33068a-734b-44fd-95eb-26d7c77e76f5	Sam	Sam	1	2	2015-10-30 11:58:34.3-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:59:50.197-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Me
eee4fde3-1cf6-494b-a072-cceb26e2d8a0	Jim	Bob	1	1	2015-10-30 12:56:04.72-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:06:29.195-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
5414de16-d0ae-4f3c-87be-3c693bd29254	Courtney	Quick	1	0	2015-10-30 16:40:11.971-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:11.927-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
544f0f06-d921-4540-a63a-7ee87cad8897	Test 2	Today	1	0	2015-10-30 16:55:52.895-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:52.841-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	
e43c4619-cec8-433e-a6cb-c6f5c2bf606d	Elswee	Vazquez	1	0	2015-10-30 17:30:18.863-04	e43c4619-cec8-433e-a6cb-c6f5c2bf606d	2015-10-30 17:30:18.045-04	e43c4619-cec8-433e-a6cb-c6f5c2bf606d	
1b13b404-484b-423f-9ed7-28f22b1633f5	Joe test	10-30-15	1	0	2015-10-30 20:46:22.086-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:46:22.027-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Tcp
ff447f13-7c1a-4554-a227-2d98bd2ea1d3	Monday	Test	1	3	2015-11-02 15:50:55.319-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 19:45:55.393-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Concrete Guys
cd29dd92-0d6f-4e49-b8a0-08a8b7198b8f	Test	Today on old app	1	2	2015-10-30 16:43:38.287-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:56:33.122-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	
13c0f891-4020-4f50-99e6-91c327bf763c	Joe test 2	Court iPad	1	0	2015-10-30 21:03:23.94-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:03:23.891-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
7e68a15c-106f-4901-82c8-eaa8def7eb78	Test to compare	Old to new app	1	1	2015-10-30 21:06:35.612-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:07:23.65-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	Old app
895a56bd-9dff-4b16-917e-c02690e5ca30	Test 2 new	Vs old app	1	0	2015-10-30 21:08:32.492-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:32.449-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	
80d75cc0-d9a4-4885-9d5e-7de208fdedd5	Testing again	New app	1	1	2015-10-30 21:09:55.156-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:58.377-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
88f9cff5-b6f0-4f7b-9a7b-20453e9df8cf	Oh	Testp	1	0	2015-10-30 21:17:21.82-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:17:21.778-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
917c5cae-b93a-4e1d-a56c-abb981143f2b	Oh	Testp	1	0	2015-10-30 21:17:39.129-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:17:39.085-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
b4244555-9faa-4b67-abbf-413e8823ec84	Ron	Shaw	1	0	2015-11-06 16:56:14.467-05	b4244555-9faa-4b67-abbf-413e8823ec84	2015-11-06 16:56:13.523-05	b4244555-9faa-4b67-abbf-413e8823ec84	
f240903f-3947-413e-846b-673bd14c10dd	Oh	Testp	1	2	2015-10-30 21:17:54.403-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:21:56.766-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	
f36bbc33-5956-4925-80db-c99850dc4a63	Jeremy	Pellicano	1	0	2015-11-01 20:52:37.422-05	f36bbc33-5956-4925-80db-c99850dc4a63	2015-11-01 20:52:35.841-05	f36bbc33-5956-4925-80db-c99850dc4a63	
d6f310e5-095e-48c7-a3c7-1a0e67927ec5	Todd	Sandberg	1	0	2015-11-06 17:46:54.021-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5	2015-11-06 17:46:53.146-05	d6f310e5-095e-48c7-a3c7-1a0e67927ec5	
194377d5-26ad-4ee7-af4a-a3814dfd5d2c	John	Doe	1	2	2015-11-08 19:24:32.49-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:11.295-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	
cc237a8f-03f8-4cb3-bb69-f50b4cadb253	Afternoon	Guy	1	1	2015-11-02 15:56:37.113-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:57:03.074-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	
66beb125-c5dc-44a0-9a24-00c319871544	Pat	mead	1	0	2015-11-06 17:47:15.699-05	66beb125-c5dc-44a0-9a24-00c319871544	2015-11-06 17:47:14.772-05	66beb125-c5dc-44a0-9a24-00c319871544	
09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	Michael	Mulder	1	0	2015-11-08 22:16:42.298-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:16:41.366-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	
cdd26125-bcd1-434c-857d-6dfd5d4d9096	Shannon	Damron	1	0	2015-11-06 17:53:41.036-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096	2015-11-06 17:53:40.207-05	cdd26125-bcd1-434c-857d-6dfd5d4d9096	
c5ce2449-293c-45b7-a645-74bb855e94c8	Fernando	Bolio	1	0	2015-11-06 17:56:41.847-05	c5ce2449-293c-45b7-a645-74bb855e94c8	2015-11-06 17:56:41.056-05	c5ce2449-293c-45b7-a645-74bb855e94c8	
e2cb3694-c779-4f8a-ad8d-916f67d6afd4	Julie	Marsland	1	0	2015-11-06 17:57:06.586-05	66beb125-c5dc-44a0-9a24-00c319871544	2015-11-06 17:57:06.54-05	66beb125-c5dc-44a0-9a24-00c319871544	
ed651fef-794c-4b5a-952f-b830e640151a	Ricardo	Lopez	1	0	2015-11-06 19:26:34.825-05	ed651fef-794c-4b5a-952f-b830e640151a	2015-11-06 19:26:33.849-05	ed651fef-794c-4b5a-952f-b830e640151a	
2e5c2eec-35bf-45b3-bcf0-cc02120dc634	Riley	Winter	1	0	2015-11-06 21:57:27.39-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	2015-11-06 21:57:26.536-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	
5eae3a46-78bf-4d09-9f22-be981399b102	Riley	Test	1	0	2015-11-06 22:44:07.763-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	2015-11-06 22:44:07.701-05	2e5c2eec-35bf-45b3-bcf0-cc02120dc634	R-star
ea629c15-7048-42c6-b0f5-68058150a4b0	Amish	Patel	1	0	2015-11-07 11:34:16.076-05	ea629c15-7048-42c6-b0f5-68058150a4b0	2015-11-07 11:34:15.191-05	ea629c15-7048-42c6-b0f5-68058150a4b0	
a6c4875f-155d-47aa-b0c8-af62a6f2492a	Omar	Rivera	1	0	2015-11-08 09:15:02.293-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 09:15:01.264-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	
98ad9706-8d3a-480d-9cd9-b4405ea0d8da	Summer	MULDER	1	1	2015-11-08 22:18:47.738-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:59.374-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	
a8eafe63-bf81-417b-a7ff-69ac6f7a1515	Summer	Felix	1	0	2015-11-08 22:22:30.89-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:30.843-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	
8f1445ec-0010-417d-a847-7bf92fc78931	Jim	Murphy	1	0	2015-11-09 22:59:39.659-05	8f1445ec-0010-417d-a847-7bf92fc78931	2015-11-09 22:59:38.79-05	8f1445ec-0010-417d-a847-7bf92fc78931	
6db77ef5-6b98-4cc7-81b7-f657a34fa6af	Royce	Hilgartner	1	0	2015-11-13 15:35:00.656-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:34:59.593-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	
b16e1efb-e20d-434e-9798-e419d3df0c33	Todd	Jones	1	0	2015-11-17 06:52:03.717-05	b16e1efb-e20d-434e-9798-e419d3df0c33	2015-11-17 06:52:02.393-05	b16e1efb-e20d-434e-9798-e419d3df0c33	
298ec5c7-3e6d-406f-851a-3b5d2c2ed771	Test	Test	1	2	2015-11-13 15:39:05.855-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 19:24:20.852-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	
7e0634ad-f172-4baf-9d5c-2d2521697b8c	Shane	Kvietkus	1	0	2015-11-17 19:31:44.872-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c	2015-11-17 19:31:43.845-05	7e0634ad-f172-4baf-9d5c-2d2521697b8c	
a87e2f31-a7e1-41e9-9760-ff655f43132a	Shane	Kvietkus	1	0	2015-11-17 20:54:59.629-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:54:58.675-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	
e0185917-0f44-4891-a330-ea0434f71080	Rich	Kvietkus	1	0	2015-11-17 20:58:27.6-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:58:27.513-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	
fdf6e1c6-9b63-4693-8cf1-df0fdc248305	dhrh	drhdrh	1	0	2015-11-19 14:50:47.105-05	342d0720-50db-402e-8f0d-ee761e61011f	2015-11-19 14:50:47.012-05	342d0720-50db-402e-8f0d-ee761e61011f	drhdrh
76e3b5fe-cfd7-41e2-82ec-94767482ce34	Alonzo	Pringle	1	0	2015-11-22 19:23:36.084-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34	2015-11-22 19:23:35.533-05	76e3b5fe-cfd7-41e2-82ec-94767482ce34	
e30d3646-7022-48ea-ba2f-cc2211855dd5			1	0	2015-11-24 17:12:27.038-05	0a215950-e391-4575-8d45-e5c36c6cb723	2015-11-24 17:12:26.966-05	0a215950-e391-4575-8d45-e5c36c6cb723	Churchill McGee.
2943d175-b9f6-4e65-83a7-48f30ea66abe	Steve	Bayley	1	0	2015-11-25 20:43:40.7-05	2943d175-b9f6-4e65-83a7-48f30ea66abe	2015-11-25 20:43:39.651-05	2943d175-b9f6-4e65-83a7-48f30ea66abe	
fe5fa59f-1900-49c8-9c58-2a330a18936a	Chad		1	0	2015-12-01 18:04:28.105-05	0a215950-e391-4575-8d45-e5c36c6cb723	2015-12-01 18:04:28.008-05	0a215950-e391-4575-8d45-e5c36c6cb723	
\.


--
-- Data for Name: phone; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY phone (id, personid, number, type, status, version, added, addedby, changed, changedby, "primary") FROM stdin;
872930e0-61cb-44c3-843e-acc1de1681b6	98e1ec87-3ae8-482b-bdf2-93606a7e59f3	419-234-0170	cell	1	0	2015-01-21 22:41:31.439-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 22:41:31.321-05	06169b04-bb68-4868-b995-98388fa33e16	t
78da1b10-e2a8-4d4a-a0b3-3292feaf1737	e98fa2f8-a53d-4771-9ba9-17ccb3e17403	4192342424	cell	1	0	2015-01-29 14:17:21.939-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:21.84-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
d290321c-c5ff-4eb1-99ad-f38dbae74c86	c7453ad2-bbc2-4e02-9036-ddea1aeecce8	4192342424	cell	1	0	2015-01-29 14:17:31.398-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:31.274-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
c638386e-b739-4bc2-b0a0-6f213ed43ed4	81c6b6b2-81a5-45cd-887d-f0ec7e585de8	4192342424	cell	1	0	2015-01-29 14:17:51.81-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:51.683-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
7c020871-e35c-43f4-9cae-ae2861924861	1c9d30a0-0e33-4ef6-9ee9-b72e8ffceb4d	5555555555	cell	1	0	2015-01-29 16:54:33.233-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 16:54:33.143-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
565f9647-4ee1-4661-ba06-0e5154cfcdd2	7f90930d-a8d0-469b-850a-a813f2296895	419-234-0170	home	1	1	2015-01-29 21:58:03.382-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:58:10.483-05	06169b04-bb68-4868-b995-98388fa33e16	t
e87de629-bca4-4eb1-a218-9cb9dfe2d3ba	103911dd-2154-486e-9395-f1d6345b013c	555 i9990000	cell	1	0	2015-01-30 00:01:13.285-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:13.197-05	06169b04-bb68-4868-b995-98388fa33e16	t
61de455a-5e40-4814-b157-cb26e8ab882f	36fdea38-dabd-42ac-b120-e83a0ba2f3f1	555 i9990000	cell	1	0	2015-01-30 00:01:14.326-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:14.239-05	06169b04-bb68-4868-b995-98388fa33e16	t
665d72af-7162-4dba-a3c9-feb2c9c26c7b	7a81e0e7-35fb-418e-9259-48b97cc6ac0f	555 i9990000	cell	1	0	2015-01-30 00:01:21.044-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:01:20.971-05	06169b04-bb68-4868-b995-98388fa33e16	t
7d54617e-bb3f-420e-815f-d727d00d94c3	4fb358e5-d62f-4bbe-ace3-9b95e2fa49c1	55666555	cell	1	0	2015-01-30 00:05:34.545-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:05:34.472-05	06169b04-bb68-4868-b995-98388fa33e16	t
c3e1d646-c0c0-43dc-a605-a219c2cbba88	d7f7b71d-c6b3-4256-909f-196e84e9cc5a	55666555	cell	1	0	2015-01-30 00:05:34.76-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:05:34.648-05	06169b04-bb68-4868-b995-98388fa33e16	t
c8e42906-ef94-4f14-869a-cca053d3c5ad	37f11480-7698-43ec-83e8-e7267c49ffc8	55556666uiiu	cell	1	0	2015-01-30 00:11:45.8-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:11:45.681-05	06169b04-bb68-4868-b995-98388fa33e16	t
7879c3bd-87e9-43a2-bea0-217bcf87ca3e	2120e974-8f6c-480f-a12c-b77c8675587f	800 555 1212	cell	1	1	2015-01-31 13:45:59.85-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:34:56.156-05	1676623f-4657-410f-87b6-db11cf461ba9	t
dfa9d908-c7a6-449b-b237-d984d6bb13e9	cae11bfb-7e0a-41f8-b248-0ff22dd15e48	5732162000	cell	1	0	2015-02-10 09:54:54.078-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:54:53.904-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	t
22f75cb9-4331-4c3f-9403-b140cc7f2436	1daec6cf-4d8f-44d4-a75c-3a0f6113c163	1-203-464-1242	cell	1	0	2015-02-18 18:31:24.419-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:31:24.308-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
2fb31da7-9cae-49a8-b51e-a9821689726f	132ca982-dd98-412d-9087-a41da52e9d6a	1-301-788-6234	cell	1	0	2015-02-18 18:37:47.13-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:37:47.041-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
38dd4cdd-8619-43dc-b1a8-1c1df3fcaf56	958a7255-6c35-40de-93db-09f06e9d3a1a	1-931-484-8431	cell	1	0	2015-02-18 18:41:10.259-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:41:10.056-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
ec810cc3-782e-438b-8258-834da3eb3741	7773a57e-39c0-430c-a904-ad5b4b4390c8	1-615-731-0718	cell	1	0	2015-02-18 18:46:58.266-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 18:46:58.113-05	21ea39bb-285f-479e-8643-f9f963edd1a3	t
e07f2183-5f67-4193-bf79-e91901d8d2f8	c6f15c94-491b-4ea2-84dd-51c357229721	555-555-5555	cell	1	0	2015-02-18 21:01:49.456-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:01:49.345-05	06169b04-bb68-4868-b995-98388fa33e16	t
1fe1a796-d84b-4cae-959a-7c741aeaa50c	881c4699-55ea-4aab-8fa1-8d3b3cdf605e	3013383232	cell	1	0	2015-02-20 17:03:30.396-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.225-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	t
5a07210b-d704-4609-af14-498f5c782ab3	0e8e8038-2471-427b-8c13-1b94647a3708	937-564-0408	cell	1	0	2015-02-23 07:11:06.647-05	e81db145-8364-495e-b45e-709987d0c0f7	2015-02-23 07:11:06.552-05	e81db145-8364-495e-b45e-709987d0c0f7	t
72803025-c854-4bdd-bd4e-fbcf187173cb	c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	4074567655	cell	1	0	2015-03-04 20:41:44.559-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:41:44.34-05	f975c50a-beb9-4277-ba91-6505d1b37f59	t
b3f62f01-df15-41a5-ac2b-f72fd7e3dde1	01108665-4678-43ea-8bea-784a90fae815	(304) 216-1608	cell	1	0	2015-03-06 15:48:14.311-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-06 15:48:14.213-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	t
9992f38f-23ca-4ae7-8dab-8cee27622205	e9e30f4f-d854-424d-9aa0-62534609aa9b	(914) 260-6504	cell	1	0	2015-03-14 21:01:10.369-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-14 21:01:10.246-04	7878e434-6854-422a-91aa-212f8b175aa3	t
babae883-ecd6-4a5c-876c-18c5cd0b610f	d53448fd-3ab2-4be8-b2bb-721e5738fafc	(347) 595-3211	cell	1	1	2015-03-18 12:01:15.051-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:01:31.693-04	7878e434-6854-422a-91aa-212f8b175aa3	t
47b40917-eb4f-405b-bb78-4753ed17ff53	1f64e6da-cbc9-4b04-be2c-e3fa74ffc5a5	(914) 830-0566	cell	1	0	2015-03-18 12:02:22.449-04	7878e434-6854-422a-91aa-212f8b175aa3	2015-03-18 12:02:22.35-04	7878e434-6854-422a-91aa-212f8b175aa3	t
bad5df9e-7e0e-4f95-beca-bbf4cfe36396	710783cd-e487-4885-abc8-f299f140fe9a	(812) 327-6659	cell	1	0	2015-03-20 11:46:23.197-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-20 11:46:23.106-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	t
d3afa9d8-0f19-412c-b03e-d32b47f29132	9abd2e47-ff0e-4d5e-97f9-683c3e61bfed	740-572-0185	office	1	2	2015-07-08 09:46:32.565-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-08 09:47:42.753-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	f
a64c080f-fae4-4ced-8675-7ff260ef4bc7	1200ffbc-9d03-4ef5-89af-b6c2893d0590	4197221207	cell	1	0	2015-03-20 11:48:15.671-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:48:15.578-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	t
efaf798f-fca8-4059-a66a-91ee2923a11e	710783cd-e487-4885-abc8-f299f140fe9a	(812) 327-6659	cell	1	2	2015-03-20 11:46:23.637-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-20 11:48:31.532-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	f
970e0ddb-d215-4912-9d1b-c9728ef931a9	1039afb2-b23c-4611-a76d-b7f67cb1e839	608-209-1672	cell	1	0	2015-03-20 18:19:31.925-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:19:31.825-04	fd0457a0-2d66-4a63-857b-21f224a14a47	t
fd0f4947-e064-4714-99b1-26434250f467	e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	4193038366	cell	1	0	2015-03-21 15:55:41.439-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.319-04	c27e733b-f247-498a-a945-7521cca65c3b	t
1990d8d0-b4f1-438f-8210-13fb2af9b187	8968b145-675a-40be-b7bf-8e7d73ac4bb4	573-346-0023	home	1	0	2015-03-22 14:19:39.116-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:19:39.058-04	dc91c128-7614-4592-b94e-c19660131a55	f
64727da5-1625-4f6f-b3f2-eaae30da6772	544f18a9-9fbe-407d-9ce7-4c45dda874df	937-544-7313	office	1	0	2015-04-09 17:58:52.189-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 17:58:52.054-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	t
9b836810-fe55-4c66-b667-5014dc2d934c	9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	337-284-0231	cell	1	0	2015-04-14 13:15:29.682-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.545-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	t
130a1c1a-6526-4603-90dd-7a65ad6399e6	c4606f0b-9e13-468f-bec6-c038d978b000	513-604-0261	cell	1	0	2015-05-18 16:14:33.724-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:14:33.632-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
56d0c3bd-7876-4b27-af20-0a1040dc0768	6760db3d-f5de-488b-9341-f6945c161fe7	513-325-8650	cell	1	0	2015-07-02 14:25:32.728-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:32.614-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
009b3a03-bdd1-4125-9a89-00f0a03c7abd	0550dbbd-7c9b-4339-b4fb-d2ba09203650	555-1212	cell	1	0	2015-07-05 23:29:51.177-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:51.004-04	61709628-4bca-418f-8dc4-1ad358c785d6	t
7479ba19-8a37-41cb-9d6c-2a2c39c75a53	e974d03d-7779-4c6a-b68b-95f69f1423b4	443-821-8114	cell	1	0	2015-08-09 18:12:58.075-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:12:57.928-04	067b4635-5840-48fd-980d-ccddbe1b173d	t
49eef364-935c-49dd-b6ee-ddffc41832f7	59977c2e-d426-4c1b-aea6-98121f5d1ae2	5555555555	cell	1	0	2015-08-26 12:00:53.767-04	c0697e56-11bf-4e37-a029-aac44d1af67c	2015-08-26 12:00:53.644-04	c0697e56-11bf-4e37-a029-aac44d1af67c	t
3616fd38-a0e4-4e32-82f6-28f2bbf55415	9abd2e47-ff0e-4d5e-97f9-683c3e61bfed	740-335-1468	cell	1	2	2015-07-08 09:46:57.55-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-08 09:47:33.732-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	t
43c397b3-13a0-4f9c-bcfd-60a468ac1594	98ad9706-8d3a-480d-9cd9-b4405ea0d8da	7606888986	cell	1	0	2015-11-08 22:18:48.413-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:18:48.285-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	t
c116f7d7-dfdc-4615-8d14-ecb0de331eaa	31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	555-555-5555	cell	1	0	2015-10-30 11:54:46.741-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:46.595-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
ba81d861-3f7f-4d72-9f4e-9c737f02fef1	9a33068a-734b-44fd-95eb-26d7c77e76f5	123-222-2222	home	1	0	2015-10-30 12:52:25.998-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 12:52:25.913-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
d8c13c4e-d1c8-49ff-83ae-2287424f9d4b	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	123-456-7899	cell	1	0	2015-10-30 12:56:05.142-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 12:56:05.027-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
077e1dd5-cdce-495c-a1f1-a5e657a16904	1b13b404-484b-423f-9ed7-28f22b1633f5	5555555555	cell	1	0	2015-10-30 20:46:23.031-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:46:22.953-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	t
84721062-157b-4ff0-aa94-455d0329f123	cc237a8f-03f8-4cb3-bb69-f50b4cadb253	555-555-5555	cell	1	0	2015-11-02 15:56:37.367-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:56:37.268-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
e85c302b-e9f2-4a80-9f41-6b0963d9db2c	76b254bb-262d-48bd-9bed-3b121a10efb5	555-555-5555	cell	1	0	2015-11-02 16:00:21.99-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:00:21.861-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	t
bde9df30-ffb7-45e9-9707-fea960b6791f	a8eafe63-bf81-417b-a7ff-69ac6f7a1515	7606888986	cell	1	0	2015-11-08 22:22:31.844-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	2015-11-08 22:22:31.757-05	09d70b1b-7f7d-4acb-a422-5679cfe1c9ae	t
d2be9b1c-1abc-49c9-a816-bb3dde3e3091	e0185917-0f44-4891-a330-ea0434f71080	8603023885	cell	1	0	2015-11-17 20:58:28.195-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 20:58:27.958-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	t
\.


--
-- Data for Name: phonetype; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY phonetype (phonetype) FROM stdin;
cell
office
home
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY project (id, leadid, install, status, version, added, addedby, changed, changedby, completed, addressid, removed, designconsult, projectstatus) FROM stdin;
d5e27cbe-cc84-4a4a-a1f7-450abe2350f8	e98fa2f8-a53d-4771-9ba9-17ccb3e17403	\N	1	0	2015-01-29 14:17:22.19-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:22.109-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	\N	75dd6164-fe47-4e93-a61b-ddea0cded7c9	\N	\N	estimate
13abed9c-dce7-4893-8871-2bec92532bfc	c7453ad2-bbc2-4e02-9036-ddea1aeecce8	\N	1	0	2015-01-29 14:17:31.613-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-01-29 14:17:31.53-05	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	\N	37576e66-6f7d-4e05-9437-e667b6ace05a	\N	\N	estimate
49990e16-f440-4280-b296-6f524b15f56b	98e1ec87-3ae8-482b-bdf2-93606a7e59f3	\N	1	0	2015-01-21 23:16:40.821-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:16:40.755-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
b52a96ac-974f-4fc9-95d9-02b4ddc41c69	94e5fddb-b14f-49a4-a6f8-9fe3303f5549	\N	1	2	2015-01-22 09:43:51.315-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:44:43.573-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
ebb9e853-75f3-4c69-832f-f8661cc8763e	0c14cbd3-c02c-4aaf-832e-b408082f1fec	\N	1	0	2015-02-03 15:21:33.286-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 15:21:33.19-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
15cab06a-e032-4550-aa47-1255878527b7	e4cf34c5-298e-4a43-a2cb-b7b8c96bbf8c	\N	1	1	2015-02-03 18:10:29.37-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:41.084-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	7f90930d-a8d0-469b-850a-a813f2296895	\N	1	3	2015-01-29 22:01:33.442-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:10:25.568-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
3235462a-bc01-44bc-925c-0d95d1c692cf	37f11480-7698-43ec-83e8-e7267c49ffc8	\N	1	1	2015-01-30 00:13:12.656-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:46.504-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
a5ca01f6-593c-49e8-9cba-fd0f55d8b2fd	5e1dff78-1ab4-4948-95f3-8a8875837b96	\N	1	0	2015-01-30 16:03:09.34-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:09.251-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
aafd3f6e-4e05-4330-a153-8ddb61de1d87	7a81e0e7-35fb-418e-9259-48b97cc6ac0f	\N	1	0	2015-01-31 00:49:15.589-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:15.52-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
c19eb191-596a-4ac6-a9ec-8411b404d36a	653bf84c-56ea-4b53-bc26-d1c63e95d102	\N	1	0	2015-02-04 15:01:58.927-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:58.842-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
757af0d8-4529-45f2-bbe6-8697ef979a33	09111d56-f6c8-4921-9cfa-c165583b9cde	2015-02-06 00:00:00-05	1	2	2015-01-31 10:31:15.827-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:36:18.438-05	06169b04-bb68-4868-b995-98388fa33e16	\N	c03d55a5-edf0-4c77-8a84-1715cd075186	\N	2015-01-31 00:00:00-05	current
0d85205d-a32b-4f51-8345-bf92d9967d9b	7958157a-0c04-44fa-af7e-a2c74f42bbd0	\N	1	1	2015-01-31 11:11:33.229-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:14:35.093-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
6ff5e4c9-7948-40a3-8567-c334e3d0158e	c1e0c7f3-e2c6-4ec3-ac85-9c98080712aa	\N	1	0	2015-03-04 20:44:06.508-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.434-05	f975c50a-beb9-4277-ba91-6505d1b37f59	\N	\N	\N	\N	estimate
60a5d606-455e-4bde-a24f-d304942ca5e4	89f6dfc4-5361-4c4a-a91d-4ef55d27c4b3	\N	1	1	2015-02-04 16:18:32.29-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:46:53.356-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
6a67611d-c144-481c-b345-f78e683565c9	d7f7b71d-c6b3-4256-909f-196e84e9cc5a	2015-01-31 00:00:00-05	1	2	2015-01-31 11:53:48.371-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:55:27.614-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	complete
08d1b957-c8ef-4d72-be46-c179e23e3877	f2a80828-6d6e-4aa4-a855-e88c58562d34	\N	1	0	2015-02-04 17:53:48.385-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:48.292-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
639fde4e-f590-4bc9-b116-bb44f85fa0b0	ed45e26f-c648-4f83-8204-6a239f3c1167	\N	1	3	2015-01-22 17:20:48.133-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:01:20.903-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
d0ec2c83-61a6-4363-9027-7bde50ffe38f	d3263319-26b9-4bd3-964a-ec5f11c40f98	\N	1	0	2015-02-04 18:54:02.839-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:02.77-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
9c7c6147-6a2b-491e-9fd8-d723f47badf6	4bb0100d-81a0-48f0-8164-e4441925e523	\N	1	0	2015-02-04 19:26:03.347-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 19:26:03.261-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
b4dbd3b2-dd5e-46a5-a0ec-91c1e3e8e426	1b66ed39-1a15-4af9-a81d-e7869e6dc02f	\N	1	3	2015-01-31 12:09:58.676-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:11:48.092-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
b64b84d2-a298-498e-8289-a4bdf7f9c893	d911e5d9-f428-4f86-a596-2dd36160b9d2	\N	1	0	2015-01-31 13:06:39.543-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.459-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
f9c32ea4-a153-4c91-bba7-bb45ba748549	754659e5-22c7-4c7b-a57c-8d6e2796af1c	\N	1	1	2015-02-05 12:58:26.649-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:59:12.219-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
8968c843-f490-4705-a613-530f5b8c948d	0d91397b-7630-411d-844a-ca64141beeec	\N	1	0	2015-02-05 17:02:09.5-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:09.412-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
5d007ec4-4b38-4006-916b-1fe3eea1717e	cb7975bf-b0ce-4217-9853-c3a57089636a	\N	1	1	2015-01-31 16:18:43.15-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 20:14:38.725-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
390bedaf-8843-43fc-b71d-a6158ded00c0	91db4bd8-32b7-4bc4-9d7f-577896582110	\N	1	0	2015-02-06 11:46:43.9-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:43.816-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
f3bef381-c5a7-4fa7-a967-b332cffce668	b4c4b6b7-8078-47ab-9b37-783e664cddf3	\N	1	1	2015-02-03 14:18:17.915-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:53.601-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
838d9451-0468-4772-b879-88e8ca28136f	2120e974-8f6c-480f-a12c-b77c8675587f	2015-02-18 19:00:00-05	1	8	2015-01-31 12:32:25.014-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 15:59:00.585-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-03-09 20:00:00-04	a7d7ca93-7904-442a-9317-d8a451a9f45a	\N	\N	current
f2d9ef67-042e-4de3-955a-455d61bdf443	c8d106b5-2b79-43f8-b918-abccaf9a2c85	\N	1	0	2015-02-02 18:46:54.965-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:54.894-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
3a00c1a0-229f-46ee-ad49-9f0f1f897882	25ba2f54-ccb3-46db-ada7-bf7b47974215	\N	1	0	2015-02-03 11:29:40.966-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:40.896-05	4398be50-e6ac-4662-8598-3783af2fa4f3	\N	\N	\N	\N	estimate
1e9e943d-ce42-4a50-8a03-4f3ba477b6d7	cb7975bf-b0ce-4217-9853-c3a57089636a	\N	1	0	2015-02-03 13:59:12.375-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:59:12.286-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
b2f37456-04cb-4466-8de1-d67c9a9f473c	6fc1cd65-f54b-40aa-9be4-c263523aa8c5	\N	1	1	2015-02-06 16:43:12.635-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:45:30.833-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	\N	\N	\N	\N	current
36cf270f-f8d9-4323-a713-aaf3ffd7b39f	3bf8ad1d-e37e-4873-931a-a8e639dc2fbd	\N	1	0	2015-02-07 08:17:26.709-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:26.634-05	4398be50-e6ac-4662-8598-3783af2fa4f3	\N	\N	\N	\N	estimate
7205aa8a-582e-45ae-aa05-7c9993a075d1	7f48e359-c6f6-41db-90c8-00cdb607a589	\N	1	0	2015-02-08 19:01:23.23-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.161-05	067b4635-5840-48fd-980d-ccddbe1b173d	\N	\N	\N	\N	estimate
11055e23-401c-4f7c-aa45-7292b8148cf9	79619370-4880-466d-aa70-6f6ea2fbf85b	\N	0	4	2015-01-29 23:38:39.275-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-13 07:21:07.31-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	complete
0b402b5b-d1c6-4bad-99bf-a6ad0d8ca450	7f48e359-c6f6-41db-90c8-00cdb607a589	\N	1	2	2015-02-08 18:59:48.074-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:12:12.432-05	067b4635-5840-48fd-980d-ccddbe1b173d	\N	\N	\N	\N	estimate
45266755-dc37-43a7-a1ab-9b5e4068a1ca	02a6969f-3fba-4f71-8729-41512e87d892	\N	1	0	2015-02-08 19:18:28.206-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:18:28.132-05	067b4635-5840-48fd-980d-ccddbe1b173d	\N	\N	\N	\N	estimate
52e6af45-9855-4d50-9015-ad9ff377e529	cae11bfb-7e0a-41f8-b248-0ff22dd15e48	\N	1	0	2015-02-10 09:54:54.357-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:54:54.273-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	\N	cbd1df7e-6bb0-47e7-ac55-ce8450e119ed	\N	\N	estimate
4f1d11d1-427a-4748-b4b9-b9d6ffb78f05	1361510c-3db2-4db5-adfd-04c9665cb383	\N	1	0	2015-02-11 15:19:31.676-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:19:31.596-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	\N	\N	\N	\N	estimate
3bc6577e-ed14-4c6f-b928-8fd5ae8f9364	c3dc65cb-9e67-4e83-965c-74fad45d1ed6	\N	1	1	2015-02-12 18:05:50.832-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:06:28.961-05	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	current
82248348-c8a4-4fe4-9432-789b021a2608	4bcba17a-414f-4861-bca0-0e83856d6fba	\N	1	0	2015-02-16 15:01:00.545-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:00.465-05	d86a76c4-4d99-4d16-b590-1df3c3122404	\N	\N	\N	\N	estimate
787cc315-b7ad-4197-abd2-e9b287216c25	7773a57e-39c0-430c-a904-ad5b4b4390c8	\N	1	0	2015-02-18 19:07:11.096-05	21ea39bb-285f-479e-8643-f9f963edd1a3	2015-02-18 19:07:11.032-05	21ea39bb-285f-479e-8643-f9f963edd1a3	\N	\N	\N	\N	estimate
635de76f-82bd-4e5c-9a73-ab9091c05201	c6f15c94-491b-4ea2-84dd-51c357229721	\N	1	1	2015-02-18 21:01:49.782-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:06:26.916-05	06169b04-bb68-4868-b995-98388fa33e16	\N	2cc656bd-04da-4d2f-94f7-40c82180b9db	\N	\N	current
6a080c16-dd30-45c2-9867-c7591da197c0	881c4699-55ea-4aab-8fa1-8d3b3cdf605e	\N	1	0	2015-02-20 17:03:30.597-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.514-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	\N	bc0bc32e-fbb2-47c3-a0cb-5750bc1fde52	\N	\N	estimate
721dc95b-67aa-4d0f-9be4-65ddd80930f5	ffad21ff-ba19-406e-bc87-50bb6e32124b	\N	1	0	2015-02-25 09:39:04.127-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:04.024-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	\N	12add870-48b8-4606-b42e-4ec622ceb666	\N	\N	estimate
adb37989-1da5-4853-8b66-3a30a7673873	abea0018-ded6-434a-aec5-346b53931198	\N	1	0	2015-02-26 14:00:09.977-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:09.906-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	\N	\N	\N	\N	estimate
9fe9deb4-79f7-4e15-aa14-2cc6df02b425	2120e974-8f6c-480f-a12c-b77c8675587f	\N	1	3	2015-02-02 13:36:03.824-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-03-09 22:54:22.114-04	1676623f-4657-410f-87b6-db11cf461ba9	\N	\N	\N	\N	estimate
a012d9bc-ac59-4125-82da-b7baa75752c3	2a7c31f6-369e-4325-b08a-3670096bb8ef	\N	1	0	2015-03-12 15:06:39.396-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:39.315-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
e93ea0ea-8ee7-4b4f-bb3c-e5cc03ef296a	2a7c31f6-369e-4325-b08a-3670096bb8ef	\N	1	0	2015-03-12 15:10:59.781-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:10:59.71-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	01108665-4678-43ea-8bea-784a90fae815	\N	1	0	2015-03-12 22:36:09.391-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:36:09.313-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	\N	\N	\N	\N	estimate
b0fb51c9-8e59-4296-8461-93560e5944b8	e95a8fa4-8767-4313-8d75-6a855565d166	\N	1	1	2015-03-13 10:52:15.998-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-13 10:53:51.682-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	current
fceea6d6-90c7-45bb-85bc-771b60ad45c7	4416b7fd-233e-4d45-849d-3117e511ca08	\N	1	0	2015-03-17 18:03:03.7-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:03:03.58-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
1293026e-34df-4e68-a483-e2a4ed217a7d	4416b7fd-233e-4d45-849d-3117e511ca08	\N	1	0	2015-03-19 13:25:30.215-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:30.12-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
faa726af-f139-40ae-800e-7be149f79a5c	710783cd-e487-4885-abc8-f299f140fe9a	\N	1	0	2015-03-19 19:57:27.093-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 19:57:27.025-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	\N	\N	\N	\N	estimate
a517dd7e-1dca-412b-bb43-af391c11f73a	ab154fbf-e7ad-4df4-b80f-b4409c666909	\N	1	0	2015-03-19 20:13:26.54-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-03-19 20:13:26.45-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	\N	\N	\N	\N	estimate
bebc6e56-4ac1-450a-9251-a1e311b8af65	1200ffbc-9d03-4ef5-89af-b6c2893d0590	\N	1	0	2015-03-20 11:47:01.355-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:47:01.286-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	\N	\N	\N	\N	estimate
9f52eaba-c4e6-45f1-bfd4-3f188f067dc8	57cce6c1-17ed-4fb3-bfd9-ce1cbb060b50	\N	1	0	2015-03-20 11:49:05.065-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:04.927-04	5c54b12e-42e9-4222-9d43-04de05218061	\N	\N	\N	\N	estimate
15cb1ea2-64a6-4c94-9e29-6d536a753e79	a95b1ef4-e69d-45b3-bf1f-f406cf75dc4a	\N	1	0	2015-03-20 12:01:19.158-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:01:19.088-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	\N	\N	\N	\N	estimate
d4637f1c-f967-4db7-8b91-b518c4408469	fdb4b6db-e267-49be-8aa1-7a588e9a6d3f	\N	1	0	2015-03-20 12:03:51.912-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:51.829-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	\N	\N	\N	\N	estimate
1d0e88f4-0c53-4eb8-bc7b-237f6951c269	c4606f0b-9e13-468f-bec6-c038d978b000	\N	1	1	2015-03-20 11:40:54.061-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:01:16.626-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
5c2c1517-8e18-40eb-b813-ef8946528654	fdc7e547-2bd3-4d0a-9919-51d96b641e5f	\N	1	0	2015-07-22 22:12:26.563-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:26.5-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	\N	\N	\N	\N	estimate
f10c7484-9daa-44aa-803e-67bd587261ab	0550dbbd-7c9b-4339-b4fb-d2ba09203650	\N	1	5	2015-07-05 23:29:51.297-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:35:13.995-04	61709628-4bca-418f-8dc4-1ad358c785d6	\N	\N	\N	\N	estimate
3edc5ea1-bacf-45f0-b8a3-1c200bc31826	c4606f0b-9e13-468f-bec6-c038d978b000	\N	1	3	2015-05-18 16:06:28.672-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:11:01.582-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	2015-05-22 00:00:00-04	estimate
f8425b10-4769-4f8f-80e8-75c37d471f91	76a7c86f-b465-4236-960d-2b847f9b5137	\N	1	0	2015-05-19 00:20:30.267-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.187-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
57f9257b-09e3-4027-98bb-321310b3a940	af9de559-5bc7-4b41-a0b1-430ad5303743	\N	1	0	2015-05-19 00:33:16.782-04	12034988-1c47-4bdd-b7ac-1751e04269ad	2015-05-19 00:33:16.686-04	12034988-1c47-4bdd-b7ac-1751e04269ad	\N	\N	\N	\N	estimate
212b66f9-bf37-4c60-9fed-6417388c407e	49c6ee87-ab1c-46a5-8999-09739d738503	\N	1	0	2015-05-20 15:18:38.128-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:18:38.064-04	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
affcd11c-4335-4504-aaf2-545b540c0e2b	1039afb2-b23c-4611-a76d-b7f67cb1e839	2015-03-23 20:00:00-04	1	9	2015-03-20 18:21:32.072-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:40:32.952-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-25 20:00:00-04	c17c07c9-85be-4d5e-ac7a-292b5fbafaeb	\N	2015-03-13 20:00:00-04	current
a3244036-3bdf-451d-ac40-3fc4df2be258	e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	\N	1	0	2015-03-21 15:56:12.986-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:56:12.888-04	c27e733b-f247-498a-a945-7521cca65c3b	\N	\N	\N	\N	complete
78b824b2-2d01-4fe8-90ab-38a179c45bd0	e6c6658c-2bd6-4aa6-878b-c85714bf5e2c	\N	1	1	2015-03-21 15:55:41.409-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:56:46.261-04	c27e733b-f247-498a-a945-7521cca65c3b	\N	\N	\N	\N	estimate
f73e6008-f3f7-47be-8a2a-66d3e9d746a9	49c6ee87-ab1c-46a5-8999-09739d738503	\N	1	0	2015-05-27 17:26:44.373-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.299-04	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
fe2ef0d5-b010-4b45-8c56-7a4d4aeb4652	731ab8d0-f175-4fc7-9ee2-06f8ca374bf8	\N	1	0	2015-06-01 12:04:53.422-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:53.354-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
3735a089-c998-4874-903c-3d2c2509c951	8968b145-675a-40be-b7bf-8e7d73ac4bb4	\N	1	3	2015-03-22 14:00:40.507-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:18:04.118-04	dc91c128-7614-4592-b94e-c19660131a55	\N	\N	\N	2015-02-25 19:00:00-05	current
40bb9421-6ae9-4c3d-9ac6-db6955a420d4	2cd23a09-777a-4af9-8ff5-763e565c6ec2	\N	1	0	2015-03-26 21:13:02.567-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:13:02.479-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	\N	\N	\N	\N	estimate
0faa9ff4-6f2b-4b0c-b5a0-6f6d971cdf62	68f19c8b-d75a-4417-8e4e-8589e272ad96	\N	1	0	2015-03-26 21:24:35.583-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:35.48-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	\N	\N	\N	\N	estimate
7b93ff1b-2312-4d5d-8db3-bc9e107f420d	8b8ac017-1718-4f70-a117-cf9d94fc1eda	\N	1	0	2015-03-29 07:44:59.45-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.358-04	9ef858fa-13d8-4152-aff7-28daea5a0842	\N	\N	\N	\N	estimate
fe9c9d38-df67-4ee8-91da-b4e285923c2f	e3f56125-83d8-4419-af08-d315aa5f0afb	\N	1	0	2015-03-29 13:24:57.85-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:24:57.777-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
5ee6462a-7e80-469b-ad4d-107bfc519502	e3f56125-83d8-4419-af08-d315aa5f0afb	\N	1	1	2015-03-29 21:09:10.619-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:17:50.82-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
cef56458-c337-40df-af91-2716165a088c	22a612d0-772d-4bc0-a0d7-06e57a927e34	\N	1	1	2015-03-31 14:26:47.534-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:41:34.022-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	\N	\N	\N	\N	current
661fc820-6eb9-4dc1-8908-d0b916fc401b	d4ccf570-9cbd-49af-9230-3947b1c0408d	\N	1	0	2015-04-01 13:39:01.552-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:39:01.481-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	\N	\N	\N	\N	estimate
54a8f2a4-3fe2-4541-a5fe-f96573f7c107	dafd2094-adc5-45dc-b36a-61142dfd2507	\N	1	0	2015-04-04 17:24:44.614-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:44.528-04	84525335-0f50-4354-8dd8-f9fe584df21a	\N	\N	\N	\N	estimate
7ceca3f2-4e0a-4d19-9633-8b650ae205aa	dafd2094-adc5-45dc-b36a-61142dfd2507	\N	1	0	2015-04-04 17:25:54.133-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.062-04	84525335-0f50-4354-8dd8-f9fe584df21a	\N	\N	\N	\N	estimate
adcf9448-69de-4655-b7fe-f088eb0d8d1c	544f18a9-9fbe-407d-9ce7-4c45dda874df	\N	1	1	2015-04-09 18:02:13.614-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:17:00.093-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	\N	\N	\N	\N	estimate
8ff4934d-d954-4882-819e-db632041838f	9ffdd1db-74a9-4b3d-a54f-e43e5efe3cc8	\N	1	0	2015-04-14 13:15:29.845-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.776-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	\N	\N	\N	\N	estimate
b03ab54a-6492-4f4c-9fac-f21f313728d1	b387a65d-3816-490c-84e9-5743fbbf14a4	\N	1	0	2015-04-18 02:30:35.457-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.386-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	\N	\N	\N	\N	estimate
9b967bd2-1a34-4e70-aa4b-eee62cd8241d	a99dc045-116c-4984-8e97-c49ba828de53	\N	1	0	2015-04-18 03:29:38.609-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:29:38.531-04	41072458-fade-43dc-a1d8-543db6c37a49	\N	\N	\N	\N	estimate
25d76c22-132d-428d-8d02-203711adeeb4	595ad16c-cc97-44f9-973d-8a8bea4682bb	\N	1	0	2015-04-18 11:23:39.937-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	2015-04-18 11:23:39.831-04	5614f192-f2bf-48d7-8912-f6ab1286bd7d	\N	\N	\N	\N	current
5b379c22-e672-4877-8427-dc056918a8f2	3e692a5f-6853-4fe3-a0d5-8fdc2d592d73	\N	1	0	2015-04-23 17:43:39.212-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:39.144-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	\N	\N	\N	\N	estimate
f2668d48-7adc-4979-8264-de05fc58863a	e4cf34c5-298e-4a43-a2cb-b7b8c96bbf8c	\N	1	2	2015-02-03 18:26:06.767-05	06169b04-bb68-4868-b995-98388fa33e16	2015-04-24 00:17:27.712-04	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
fda3f113-8612-4c17-9279-f4156f2bdbaa	7ae87126-063a-451a-a567-0d285ca16bd5	\N	1	0	2015-04-28 08:01:15.315-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:15.236-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	\N	\N	\N	\N	estimate
161aea66-486a-4ce9-8d52-b445feef3aeb	2d91f9e1-13db-4073-95f8-566ab180d204	\N	1	1	2015-05-02 18:13:29.201-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:45.051-04	350a236f-f780-40e9-85e3-2b9227f4d76f	\N	\N	\N	\N	current
55e64832-e4c3-4474-a4ee-0200f5ee2656	bd896255-7124-4478-97c7-606bd75f241f	\N	1	0	2015-05-13 22:51:12.806-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:51:12.713-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-08 00:00:00-04	\N	\N	\N	complete
09bd5351-6c08-47c7-ae5e-53c7ad004ff7	55abc66e-bcb2-45c9-9c53-d24f0fca5957	\N	1	0	2015-06-03 19:43:57.673-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:57.604-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
85687330-3806-4773-ae87-e87520e45e56	55abc66e-bcb2-45c9-9c53-d24f0fca5957	\N	1	0	2015-06-03 19:44:38.829-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:38.768-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
a2f2a554-476f-4e8b-af30-218e8c268c19	7f31c83c-1703-4477-b5b4-9cedd5b9ab9b	\N	1	0	2015-06-23 10:37:43.409-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:37:43.321-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
7cfed386-2ab8-48bc-93f0-20d82e849362	7f31c83c-1703-4477-b5b4-9cedd5b9ab9b	\N	1	0	2015-06-23 10:38:30.235-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:38:30.162-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
a460494c-c363-4806-99f5-044407448914	6760db3d-f5de-488b-9341-f6945c161fe7	\N	1	0	2015-07-02 14:25:32.928-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:32.857-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	ff303df6-28b5-4e28-a60d-9c8b9262ab91	\N	\N	estimate
749db2ac-63c1-4790-93b6-f593d3f83e99	6760db3d-f5de-488b-9341-f6945c161fe7	\N	1	0	2015-07-02 14:27:26.649-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:26.559-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	\N	\N	\N	\N	estimate
540aa1c3-599c-48b8-afda-6a4384578779	b2225f01-b777-4f75-95a5-9e9119e0d27b	\N	1	1	2015-07-13 08:22:56.811-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:26:12.383-04	5414f676-63e9-4117-87bd-ec5577e932b7	\N	5d1845cc-bc8c-4de2-b56a-1a9cac353021	\N	2015-07-13 00:00:00-04	estimate
96a9a47c-11a2-4abd-89c4-f54168ffe0eb	b88d77d6-5f80-40ce-8e02-32f4e80e4608	\N	1	0	2015-07-17 21:33:32.287-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:32.225-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	\N	\N	\N	\N	estimate
eac3d34d-6cac-4c78-81ba-28392c70890b	82b2860d-fa82-443f-96e1-91da43fab547	\N	1	0	2015-07-22 17:05:27.06-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:26.969-04	06169b04-bb68-4868-b995-98388fa33e16	\N	\N	\N	\N	estimate
0bfa54f1-50e1-4fd7-8292-5f77ab106401	b2c2fa8f-39cd-4ea7-9b06-ea1d88b8bec9	\N	1	1	2015-07-24 16:05:04.552-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:15:21.428-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	\N	\N	\N	\N	estimate
0a8c2f29-a999-4101-9c1d-3b00f5beca08	fe71fcd3-3c96-45ed-a95e-1f936af67b79	\N	1	0	2015-07-29 11:06:59.753-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:06:59.684-04	0a215950-e391-4575-8d45-e5c36c6cb723	\N	\N	\N	\N	estimate
55837cd5-41d0-4899-bfc4-4f11822bc4ba	115b8d12-240b-4d68-8821-a30ddf7e2171	\N	1	0	2015-08-11 13:31:27.494-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:31:27.426-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	\N	\N	\N	\N	estimate
a96d14d6-2936-4bcd-a18c-4a7f2523d184	83369076-1bb1-4793-ad96-cbb91d1b1d5c	\N	1	0	2015-08-26 13:35:43.531-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.451-04	e604c054-19e1-4332-b9ae-97ef0c58380f	\N	\N	\N	\N	estimate
56e3e125-2525-481f-b644-064a4ef7625b	e974d03d-7779-4c6a-b68b-95f69f1423b4	\N	1	3	2015-08-09 18:12:58.239-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-20 12:19:47.006-04	067b4635-5840-48fd-980d-ccddbe1b173d	\N	040bdc56-9b27-43e3-8934-49d117f9b046	\N	\N	complete
3513c87e-0c77-4360-9c02-679063af81c5	2cc106c6-c7ec-4c56-884e-2929e4d805ec	\N	1	0	2015-08-30 21:43:44.385-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.308-04	89b13534-20eb-49d7-914c-d84a673f858d	\N	\N	\N	\N	estimate
a97a07c7-7e71-476f-85cd-7aeed235ce49	7690a61d-caec-4041-b274-7db1067cd96b	\N	1	0	2015-08-31 13:06:58.129-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.064-04	2a63f4b8-4436-45bf-9439-866ac59e1911	\N	\N	\N	\N	estimate
cf12b987-b8eb-4ef7-94f9-c880f725070f	ec4a6dfa-cf62-4d9f-907d-46624cc39d4b	\N	1	0	2015-09-04 17:23:33.367-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.3-04	e604c054-19e1-4332-b9ae-97ef0c58380f	\N	\N	\N	\N	estimate
5c6fb96c-22f6-40b4-83d2-80b1b908f0f6	f1c1d499-c1ec-46d6-816c-d5cb1c18dbbe	\N	1	1	2015-09-10 02:33:15.045-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:35:25.77-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	\N	\N	\N	\N	current
b201737f-4948-4c1c-a6b6-e3320269bc56	20f5f15e-ee40-401b-8ae7-d094af9ee576	\N	1	1	2015-10-19 14:45:51.997-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:49.038-04	51855703-9a42-4c37-8418-24da5bf57be7	\N	\N	\N	\N	estimate
b6bb084a-762c-4936-95be-3c13cb03325c	ecc4c035-a2d5-433d-93e6-107b59982e77	\N	1	0	2015-10-22 18:57:09.642-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:09.56-04	86103f7b-c3bd-489b-a732-10374a07ed5a	\N	\N	\N	\N	estimate
c3d28643-dfbb-4887-9b75-0c5733d8b8ff	d72dca02-a605-400d-8037-2e3cbe18f5ce	\N	1	0	2015-10-27 13:29:23.592-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:23.472-04	86103f7b-c3bd-489b-a732-10374a07ed5a	\N	\N	\N	\N	estimate
3d0859e4-a3f4-47f4-81cb-207f9a651cb6	31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	\N	1	0	2015-10-30 11:54:47.23-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:47.162-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
d9733104-e703-4993-b36f-fd7c39b253cf	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	\N	1	0	2015-10-30 13:01:40.335-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.251-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
d5e1da07-449b-49b7-aeca-0ea35a804b6f	eee4fde3-1cf6-494b-a072-cceb26e2d8a0	\N	1	0	2015-10-30 13:03:09.331-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:03:09.266-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
9a2af3d1-5f4e-40c2-8ed9-4f2b342d65f9	5414de16-d0ae-4f3c-87be-3c693bd29254	\N	1	0	2015-10-30 16:40:12.407-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:12.349-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	\N	\N	\N	\N	estimate
02182d99-7cbb-415b-9b3b-659f558c8c2b	544f0f06-d921-4540-a63a-7ee87cad8897	\N	1	0	2015-10-30 16:55:53.41-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:53.34-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	\N	\N	\N	\N	estimate
e4a67ac4-0de5-4d31-94c4-2abab599089a	1b13b404-484b-423f-9ed7-28f22b1633f5	\N	1	0	2015-10-30 20:48:29.794-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:29.719-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	\N	\N	\N	\N	estimate
2d6fd993-f98c-4e9b-8ce9-350272a5b325	cd29dd92-0d6f-4e49-b8a0-08a8b7198b8f	\N	1	1	2015-10-30 20:54:47.742-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:55:56.806-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	\N	\N	\N	\N	estimate
8d541171-6a68-492a-917f-76e213f10a22	895a56bd-9dff-4b16-917e-c02690e5ca30	\N	1	0	2015-10-30 21:08:33.234-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:33.168-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	\N	\N	\N	\N	estimate
f56b4115-719d-4f2e-a53c-26c7e26f85cf	80d75cc0-d9a4-4885-9d5e-7de208fdedd5	\N	1	1	2015-10-30 21:09:55.586-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:58.063-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	\N	\N	\N	\N	current
28b530ea-aff4-4b6d-9296-9d63342f7c75	2a7c31f6-369e-4325-b08a-3670096bb8ef	\N	1	0	2015-11-02 15:41:38.391-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.295-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
331f197b-27eb-4246-b2d8-5be7a84552ab	31b4fe97-5d7d-45a5-b07c-2caf020f3ca1	\N	1	0	2015-11-02 15:45:54.156-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.081-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	estimate
70ebf7bf-d639-4964-8671-589fa4e220a0	76b254bb-262d-48bd-9bed-3b121a10efb5	\N	0	3	2015-11-02 16:02:02.4-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 19:44:19.153-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	complete
09cf6f53-9bc9-47cb-a9cd-dbca3cfb9d2a	ff447f13-7c1a-4554-a227-2d98bd2ea1d3	\N	1	1	2015-11-02 15:52:05.28-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 19:45:55.399-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	\N	\N	\N	\N	current
4b040e4d-2199-4c2e-a9a9-da684c2c9c15	194377d5-26ad-4ee7-af4a-a3814dfd5d2c	\N	1	0	2015-11-08 19:26:15.728-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:26:15.667-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	\N	\N	\N	\N	estimate
3f0ffe68-9049-4abd-aab4-8e4d1eff0f84	298ec5c7-3e6d-406f-851a-3b5d2c2ed771	\N	1	2	2015-11-13 15:39:06.25-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 19:24:20.86-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	\N	\N	\N	\N	current
fe63ea97-197d-462d-a897-4e28ae421789	e0185917-0f44-4891-a330-ea0434f71080	\N	1	0	2015-11-17 21:00:40.189-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	2015-11-17 21:00:40.114-05	a87e2f31-a7e1-41e9-9760-ff655f43132a	\N	\N	\N	\N	estimate
\.


--
-- Data for Name: projectdetail; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY projectdetail (id, projectid, systemid, area, status, version, added, addedby, changed, changedby, name, systemsneeded, arealength, areawidth, removed, saleprice) FROM stdin;
a746f882-7db4-4c72-859b-99aff76e32f7	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	e3175371-8815-455f-9cc6-f67fe1676c49	576	1	1	2015-01-29 22:02:44.346-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:09:25.822-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	6.5
ad5cf86f-48c8-4d2d-8fd9-e16ac752eac4	3a00c1a0-229f-46ee-ad49-9f0f1f897882	22caba65-e2d2-4527-a9a4-28d506b6e8df	360	1	0	2015-02-03 11:29:41.192-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:41.113-05	4398be50-e6ac-4662-8598-3783af2fa4f3	patio	\N	18	20	\N	6.75
1ec083c0-eb98-4570-8e4c-dfbc66f83dd3	b64b84d2-a298-498e-8289-a4bdf7f9c893	ef9e68f6-8298-4ad2-857e-0babba80ee19	896	1	0	2015-01-31 13:06:39.746-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.665-05	06169b04-bb68-4868-b995-98388fa33e16	garage floor	\N	32	28	\N	4.75
b7d6b366-415b-49ec-93ee-8883df61c23e	aafd3f6e-4e05-4330-a153-8ddb61de1d87	84465f99-18df-4fe3-9330-801764344c18	800	1	3	2015-01-31 00:49:16.414-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 21:42:28.167-05	06169b04-bb68-4868-b995-98388fa33e16	Kitchen	\N	20	40	\N	9
cfe6a19e-20ee-4703-932d-926b2ac59107	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	85895bef-b806-4051-a5f3-34892c56dd4c	1	1	7	2015-01-29 22:10:25.763-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:25:28.762-05	06169b04-bb68-4868-b995-98388fa33e16	Repair for garage	\N	1	1	\N	3
572d45b1-1c94-4469-8421-319f70b8bd3e	11055e23-401c-4f7c-aa45-7292b8148cf9	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	576	1	0	2015-01-29 23:38:41.09-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:38:41.005-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	6.5
0791b31f-9fef-47c4-aca5-6685ddb0840f	11055e23-401c-4f7c-aa45-7292b8148cf9	85895bef-b806-4051-a5f3-34892c56dd4c	10	1	0	2015-01-29 23:39:41.407-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:39:41.337-05	06169b04-bb68-4868-b995-98388fa33e16	repair	\N	1	10	\N	3
0c8f6021-74ea-4353-85fa-f13f8efa56e1	3235462a-bc01-44bc-925c-0d95d1c692cf	cb2eb7fa-3870-4e96-9269-46811508d803	576	1	1	2015-01-30 00:13:14.902-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:13:55.2-05	06169b04-bb68-4868-b995-98388fa33e16	Basement	\N	24	24	\N	7
f2db87bc-cb07-4c56-86b2-20782a15104e	3235462a-bc01-44bc-925c-0d95d1c692cf	85895bef-b806-4051-a5f3-34892c56dd4c	10	1	0	2015-01-30 00:14:48.795-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:48.698-05	06169b04-bb68-4868-b995-98388fa33e16	repair for basement	\N	1	10	\N	6
41104ffd-aa54-4aeb-a522-9750c9b3ba12	a5ca01f6-593c-49e8-9cba-fd0f55d8b2fd	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	555	1	0	2015-01-30 16:03:09.541-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:09.459-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Basement Floor	\N	15	37	\N	2.5
487abb23-fdfb-410f-9a13-72d941a6a95e	757af0d8-4529-45f2-bbe6-8697ef979a33	84465f99-18df-4fe3-9330-801764344c18	600	1	0	2015-01-31 10:31:16.071-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:15.97-05	06169b04-bb68-4868-b995-98388fa33e16	Patio	\N	20	30	\N	8
88520d3f-c1b1-493e-b7a6-2c6e54f5dc7c	0d85205d-a32b-4f51-8345-bf92d9967d9b	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	400	1	0	2015-01-31 11:11:33.694-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:33.602-05	06169b04-bb68-4868-b995-98388fa33e16	Garge	\N	20	20	\N	6.5
72abc66a-1639-4324-bc2a-a8369ed3a793	6a67611d-c144-481c-b345-f78e683565c9	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	400	1	1	2015-01-31 11:54:48.602-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:54:50.052-05	06169b04-bb68-4868-b995-98388fa33e16	garage	\N	20	20	\N	4.5
9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	639fde4e-f590-4bc9-b116-bb44f85fa0b0	9004c757-e34f-4f69-aeb6-c68254569c97	625	1	0	2015-01-31 11:58:32.948-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:32.851-05	06169b04-bb68-4868-b995-98388fa33e16	basement	\N	25	25	\N	6.5
ec5649a3-c036-467d-bd2d-5e28a74b83aa	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	0b1d2077-bf8b-42d3-b991-d9f09bbff327	1125	1	0	2015-01-31 17:33:40.547-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 17:33:40.456-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	25	45	\N	6.5
19f59ca9-5b57-4479-95ce-8a849984f843	5d007ec4-4b38-4006-916b-1fe3eea1717e	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	1800	1	1	2015-02-03 13:03:10.064-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:30:21.211-05	06169b04-bb68-4868-b995-98388fa33e16	Pool	\N	30	60	\N	7.25
a17dad94-2fff-4e2f-99a9-828f74954a25	639fde4e-f590-4bc9-b116-bb44f85fa0b0	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	576	1	3	2015-01-22 17:20:48.324-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:01:14.102-05	06169b04-bb68-4868-b995-98388fa33e16	garage	\N	24	24	\N	2.5
8a6cb4be-59ae-4fc5-afd7-490b6163172e	b4dbd3b2-dd5e-46a5-a0ec-91c1e3e8e426	d07b40b5-95bb-4c8d-a9ce-f57aa248f329	576	1	0	2015-01-31 12:09:58.983-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:09:58.902-05	06169b04-bb68-4868-b995-98388fa33e16	Basement	\N	24	24	\N	6.5
c6e52124-ead2-4df1-bd3f-857525ed4b38	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	22caba65-e2d2-4527-a9a4-28d506b6e8df	100	1	4	2015-01-31 20:06:05.043-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:06:48.377-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	10	10	\N	6.75
c1545ddc-a592-41a6-a281-4932eb83ab33	49990e16-f440-4280-b296-6f524b15f56b	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	576	1	2	2015-01-21 23:16:41.061-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:12:38.154-05	06169b04-bb68-4868-b995-98388fa33e16	garage	\N	24	24	\N	5
503c4aee-8cf3-4502-8cea-ff079a344456	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13	cb2eb7fa-3870-4e96-9269-46811508d803	400	1	0	2015-01-31 12:13:15.46-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:13:15.375-05	06169b04-bb68-4868-b995-98388fa33e16	pizza barn	\N	20	20	\N	7
14674887-db2a-43ef-b8bd-790019cb8994	ebb9e853-75f3-4c69-832f-f8661cc8763e	85895bef-b806-4051-a5f3-34892c56dd4c	89	1	1	2015-02-03 15:21:33.965-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:23:52.872-05	06169b04-bb68-4868-b995-98388fa33e16	repair	\N	1	89	\N	2
317d5df2-69f1-42ef-b01a-86190f0e26e9	ebb9e853-75f3-4c69-832f-f8661cc8763e	ef9e68f6-8298-4ad2-857e-0babba80ee19	300	1	2	2015-02-03 15:21:33.521-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:26:50.628-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	30	10	\N	5
e6dbf64a-654d-45d2-aa5e-92f2e22a809a	838d9451-0468-4772-b879-88e8ca28136f	e501ee32-36f2-45ea-acc1-5740b9953d18	2400	1	9	2015-01-31 14:20:58.325-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:37.219-05	1676623f-4657-410f-87b6-db11cf461ba9	Driveway	\N	40	60	\N	0.5
d9d04899-3f3d-4e1f-8ce0-632c1320a3ae	b52a96ac-974f-4fc9-95d9-02b4ddc41c69	22caba65-e2d2-4527-a9a4-28d506b6e8df	576	1	5	2015-01-22 09:43:51.51-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 21:37:46.04-05	06169b04-bb68-4868-b995-98388fa33e16	garage	\N	24	24	\N	8
05222b7c-583b-49ef-88aa-a62c50e50502	838d9451-0468-4772-b879-88e8ca28136f	22caba65-e2d2-4527-a9a4-28d506b6e8df	2500	1	13	2015-01-31 12:32:25.213-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:47.024-05	1676623f-4657-410f-87b6-db11cf461ba9	Basement	\N	50	50	\N	6.75
d0bc2a3d-f29e-4c58-aad7-a4f5490a7723	b52a96ac-974f-4fc9-95d9-02b4ddc41c69	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	450	1	2	2015-01-22 09:44:43.749-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 21:41:29.276-05	06169b04-bb68-4868-b995-98388fa33e16	basment	\N	15	30	\N	8
57049c5d-0f18-4787-99d0-9edea2d8fb5b	9fe9deb4-79f7-4e15-aa14-2cc6df02b425	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	1500	1	0	2015-02-02 13:36:04.08-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:36:04.001-05	1676623f-4657-410f-87b6-db11cf461ba9	pool	\N	30	50	\N	6.5
8a69db9e-1eb9-4057-8b91-0a77f055e871	15cab06a-e032-4550-aa47-1255878527b7	22caba65-e2d2-4527-a9a4-28d506b6e8df	1200	1	0	2015-02-03 18:10:29.594-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:29.521-05	06169b04-bb68-4868-b995-98388fa33e16	Basement	\N	60	20	\N	9
eb0a14dc-48a1-4ce8-b06c-68eb44d32032	f2d9ef67-042e-4de3-955a-455d61bdf443	9004c757-e34f-4f69-aeb6-c68254569c97	2320	1	0	2015-02-02 18:46:55.214-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:55.137-05	06169b04-bb68-4868-b995-98388fa33e16	Test for bug	\N	29	80	\N	7
99a76f23-761b-4b02-96dd-03589218b200	5d007ec4-4b38-4006-916b-1fe3eea1717e	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	1000	1	11	2015-01-31 16:18:43.356-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 23:51:47.004-05	06169b04-bb68-4868-b995-98388fa33e16	Family Room	\N	20	50	\N	2.5
b713eaa5-1287-403e-8ffd-37a4337ae940	f2668d48-7adc-4979-8264-de05fc58863a	22caba65-e2d2-4527-a9a4-28d506b6e8df	1500	1	0	2015-02-03 18:26:07.014-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:26:06.942-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	30	50	\N	6.75
616bf2d4-a2c7-40aa-b906-1f52e429a29a	5d007ec4-4b38-4006-916b-1fe3eea1717e	85895bef-b806-4051-a5f3-34892c56dd4c	90	1	0	2015-02-03 00:21:37.943-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 00:21:37.841-05	06169b04-bb68-4868-b995-98388fa33e16	Repair	\N	1	90	\N	3
a2186005-fca9-47ea-90b2-0f67d9b80cba	c19eb191-596a-4ac6-a9ec-8411b404d36a	84465f99-18df-4fe3-9330-801764344c18	576	1	0	2015-02-04 15:01:59.216-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.122-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	7
9725dd02-2d64-44c4-835f-860097536f3a	60a5d606-455e-4bde-a24f-d304942ca5e4	ef9e68f6-8298-4ad2-857e-0babba80ee19	576	1	1	2015-02-04 16:18:32.555-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:20:52.642-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	7
c89c198e-72c0-4ecb-9903-72748195d35c	08d1b957-c8ef-4d72-be46-c179e23e3877	84465f99-18df-4fe3-9330-801764344c18	2800	1	0	2015-02-04 17:53:48.735-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:48.645-05	06169b04-bb68-4868-b995-98388fa33e16	Basement	\N	40	70	\N	8
84e894b3-9466-4499-9d55-c624b7098051	d0ec2c83-61a6-4363-9027-7bde50ffe38f	84465f99-18df-4fe3-9330-801764344c18	576	1	0	2015-02-04 18:54:03.085-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.017-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	9
9a1ba24a-3182-472f-ab05-069779282fac	9c7c6147-6a2b-491e-9fd8-d723f47badf6	0b1d2077-bf8b-42d3-b991-d9f09bbff327	1904	1	0	2015-02-04 20:22:26.744-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 20:22:26.653-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	34	56	\N	7
24382365-77bd-40d9-aecd-319a594b52d8	f9c32ea4-a153-4c91-bba7-bb45ba748549	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	1120	1	0	2015-02-05 12:58:27.022-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:58:26.913-05	06169b04-bb68-4868-b995-98388fa33e16	basement	\N	40	28	\N	2.5
b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	9c7c6147-6a2b-491e-9fd8-d723f47badf6	9004c757-e34f-4f69-aeb6-c68254569c97	720	1	1	2015-02-04 19:26:03.846-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:39.547-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	30	\N	7
ef312753-3ca8-4898-96c9-8fc5b8b0343c	8968c843-f490-4705-a613-530f5b8c948d	84465f99-18df-4fe3-9330-801764344c18	576	1	0	2015-02-05 17:02:09.741-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:09.651-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	8
9a1f2393-6e4b-4606-b1e1-59249aaedd52	390bedaf-8843-43fc-b71d-a6158ded00c0	84465f99-18df-4fe3-9330-801764344c18	625	1	0	2015-02-06 11:46:44.179-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.103-05	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	25	25	\N	8
37c31973-7a50-4c99-b447-60a19494415e	f3bef381-c5a7-4fa7-a967-b332cffce668	85895bef-b806-4051-a5f3-34892c56dd4c	900	1	0	2015-02-06 13:13:19.731-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:13:19.652-05	06169b04-bb68-4868-b995-98388fa33e16	Basement cracks	\N	1	900	\N	2.5
d6df39dd-5ff8-47dd-ac20-0fc0b244c072	f3bef381-c5a7-4fa7-a967-b332cffce668	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	54000	1	1	2015-02-03 14:18:18.353-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:28.198-05	06169b04-bb68-4868-b995-98388fa33e16	Warehouse	\N	60	900	\N	6.5
e97fc815-7289-4377-a907-13dd195c0123	b2f37456-04cb-4466-8de1-d67c9a9f473c	e501ee32-36f2-45ea-acc1-5740b9953d18	1488	1	0	2015-02-06 16:43:12.905-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:43:12.792-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	drive	\N	62	24	\N	0.5
4ca49e39-fc86-46aa-8afa-55a03ffa74bb	36cf270f-f8d9-4323-a713-aaf3ffd7b39f	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	703	1	0	2015-02-07 08:17:26.944-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:26.855-05	4398be50-e6ac-4662-8598-3783af2fa4f3	garage	\N	19	37	\N	6.5
78b73e6e-b451-4aae-adce-b0c1cce82fce	0b402b5b-d1c6-4bad-99bf-a6ad0d8ca450	22caba65-e2d2-4527-a9a4-28d506b6e8df	900	1	0	2015-02-08 18:59:48.382-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.247-05	067b4635-5840-48fd-980d-ccddbe1b173d	Garage	\N	30	30	\N	6.75
3bc26959-2344-4ed6-91ab-41e05d37b757	7205aa8a-582e-45ae-aa05-7c9993a075d1	22caba65-e2d2-4527-a9a4-28d506b6e8df	400	1	0	2015-02-08 19:01:23.362-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.287-05	067b4635-5840-48fd-980d-ccddbe1b173d	Garage	\N	20	20	\N	6.75
5e329cbd-fd48-4999-bd48-c0fa8c1872c5	fceea6d6-90c7-45bb-85bc-771b60ad45c7	ef9e68f6-8298-4ad2-857e-0babba80ee19	625	1	1	2015-03-17 18:12:44.67-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:15:19.426-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Garage	\N	25	25	\N	4.75
c84624de-dba0-4c86-9bf5-c3b65b999bd6	0b402b5b-d1c6-4bad-99bf-a6ad0d8ca450	22caba65-e2d2-4527-a9a4-28d506b6e8df	0	1	2	2015-02-08 18:59:48.236-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:09:59.919-05	067b4635-5840-48fd-980d-ccddbe1b173d	Pool Deck	\N	0	0	\N	0
bf3b0ddb-111a-4037-a1aa-04a94ca191f1	45266755-dc37-43a7-a1ab-9b5e4068a1ca	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	80	1	1	2015-02-08 19:20:12.496-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:21:18.537-05	067b4635-5840-48fd-980d-ccddbe1b173d	Sidewalk	\N	4	20	\N	6.5
26cb8f1a-5605-4add-aa7a-2447f17aa2f4	45266755-dc37-43a7-a1ab-9b5e4068a1ca	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	450	1	1	2015-02-08 19:20:57.621-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:28:24.652-05	067b4635-5840-48fd-980d-ccddbe1b173d	Driveway	\N	30	15	\N	6.5
8346b7c6-0d71-48bd-b57a-3836b7777a95	1e9e943d-ce42-4a50-8a03-4f3ba477b6d7	84465f99-18df-4fe3-9330-801764344c18	600	1	0	2015-02-09 21:47:06.913-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:06.826-05	06169b04-bb68-4868-b995-98388fa33e16	Interior Floor	\N	20	30	\N	8
50eea67f-b185-4ff4-ae87-ffa8d4234ed3	52e6af45-9855-4d50-9015-ad9ff377e529	85895bef-b806-4051-a5f3-34892c56dd4c	1755	1	0	2015-02-10 09:54:54.578-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:54:54.489-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	main floor	\N	39	45	\N	3
02961aeb-45a6-49b4-86fb-1ee30c2b3b20	4f1d11d1-427a-4748-b4b9-b9d6ffb78f05	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	1000	1	0	2015-02-11 15:19:31.807-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:19:31.732-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	corridor 1	\N	50	20	\N	2.5
57174052-013a-4109-ae8b-e66c168be5cf	3bc6577e-ed14-4c6f-b928-8fd5ae8f9364	84465f99-18df-4fe3-9330-801764344c18	800	1	0	2015-02-12 18:05:51.134-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.05-05	06169b04-bb68-4868-b995-98388fa33e16	Basement	\N	20	40	\N	9
6d715357-db77-4963-b4b4-f84ca429efa9	82248348-c8a4-4fe4-9432-789b021a2608	187db143-bd8f-4251-bca6-47393c460f58	875	1	0	2015-02-16 15:01:01.261-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.165-05	d86a76c4-4d99-4d16-b590-1df3c3122404	deck	\N	25	35	\N	5.5
c80a7587-8dca-44e0-9e72-f98090a0e3d5	635de76f-82bd-4e5c-9a73-ab9091c05201	84465f99-18df-4fe3-9330-801764344c18	1200	1	1	2015-02-18 21:01:50.037-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:55.499-05	06169b04-bb68-4868-b995-98388fa33e16	Man Cave Garage	\N	40	30	\N	7
2bbdea0b-9fe3-478c-9292-afbe6e34d13a	6a080c16-dd30-45c2-9867-c7591da197c0	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	0	1	0	2015-02-20 17:03:30.838-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.726-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Shop	\N	0	0	\N	6.5
cd1cc25e-ac63-4178-995e-a4a5afa85f2e	721dc95b-67aa-4d0f-9be4-65ddd80930f5	22caba65-e2d2-4527-a9a4-28d506b6e8df	500	1	0	2015-02-25 09:39:05.572-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:05.485-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Garage floor	\N	20	25	\N	6.75
67f4a2f0-4a38-4b96-b8c0-a284d31a60f1	721dc95b-67aa-4d0f-9be4-65ddd80930f5	ef9e68f6-8298-4ad2-857e-0babba80ee19	625	1	0	2015-02-25 11:54:22.957-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 11:54:22.864-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Garage floor	\N	25	25	\N	4.75
8f6a1d04-7c77-453e-ac46-3d35a713d52e	adb37989-1da5-4853-8b66-3a30a7673873	22caba65-e2d2-4527-a9a4-28d506b6e8df	330	1	0	2015-02-26 14:00:10.53-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:10.441-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Milk house	\N	30	11	\N	6.75
2727d7a4-c892-4350-9e0a-5785e6909819	6ff5e4c9-7948-40a3-8567-c334e3d0158e	22caba65-e2d2-4527-a9a4-28d506b6e8df	400	1	0	2015-03-04 20:44:06.697-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.612-05	f975c50a-beb9-4277-ba91-6505d1b37f59	garage	\N	20	20	\N	6.75
d4472f92-2ebd-4758-bd04-ff72e2ad68a7	a012d9bc-ac59-4125-82da-b7baa75752c3	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	600	1	0	2015-03-12 15:06:39.691-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:39.601-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Patio	\N	30	20	\N	6.5
a93b21c3-33ce-439a-a150-91709a70363a	e93ea0ea-8ee7-4b4f-bb3c-e5cc03ef296a	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	30000	1	0	2015-03-12 15:11:00.02-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:10:59.94-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Warehouse	\N	100	300	\N	2.5
20f0a9e4-1777-49f0-a30f-0983631b328f	1293026e-34df-4e68-a483-e2a4ed217a7d	92765abf-abd1-4998-ba3a-728610789763	480	1	0	2015-03-19 13:25:30.593-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:30.51-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2 car	\N	24	20	\N	5.75
9d60481f-4078-49e7-b490-32b71ec02256	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	238	1	0	2015-03-12 22:39:45.721-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:39:45.65-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Pool Deck L	\N	14	17	\N	6.5
92b0f627-9198-4bad-9fbe-40be5247af8c	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	580	1	0	2015-03-12 22:41:20.701-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:41:20.615-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Pool Deck F&B	\N	58	10	\N	6.5
1158fb0c-d304-4d0e-9eb8-d2d0559376dd	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	176	1	0	2015-03-12 23:02:21.222-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:21.154-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Steps	\N	16	11	\N	8.5
3788d343-ae72-4834-9a12-49418fd55a5f	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	136	1	2	2015-03-12 22:36:09.523-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:46.977-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Pool Deck R	\N	17	8	\N	8
75b149fb-af5e-4019-bbcd-382a91293b23	5ca41e2e-e14e-4e93-80c7-c9d97f8b3cd7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	225	1	0	2015-03-12 23:04:34.672-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:04:34.588-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	Back Pad	\N	9	25	\N	8
746c6c6b-5efc-46e3-bb5f-7a62f51d6961	fceea6d6-90c7-45bb-85bc-771b60ad45c7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	1300	1	1	2015-03-17 18:05:42.131-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:06:18.116-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Pool	\N	52	25	\N	5.5
7dcb53b7-bab3-44e0-9f41-a27bd919bcee	bebc6e56-4ac1-450a-9251-a1e311b8af65	e501ee32-36f2-45ea-acc1-5740b9953d18	600	1	0	2015-03-20 11:47:01.657-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:47:01.58-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	basement	\N	30	20	\N	0.5
56b9e86d-73bd-4e82-b74c-6302d3ad5d4b	9f52eaba-c4e6-45f1-bfd4-3f188f067dc8	22caba65-e2d2-4527-a9a4-28d506b6e8df	756	1	0	2015-03-20 11:49:05.281-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:05.213-04	5c54b12e-42e9-4222-9d43-04de05218061	Garage	\N	27	28	\N	4.5
2bb4ef18-e396-47bd-bd78-8a9ba2aa6d5b	faa726af-f139-40ae-800e-7be149f79a5c	92765abf-abd1-4998-ba3a-728610789763	720	1	6	2015-03-19 19:57:27.399-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 22:12:25.071-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	New Garage Floor	\N	24	30	\N	5.75
48075e71-86cf-413c-9182-9bd5eff9c1c0	1d0e88f4-0c53-4eb8-bc7b-237f6951c269	84465f99-18df-4fe3-9330-801764344c18	3312	1	0	2015-03-20 11:40:54.605-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:54.469-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Living room	\N	72	46	\N	8
45d5772e-75a9-4daa-8b49-73565adf8f78	15cb1ea2-64a6-4c94-9e29-6d536a753e79	22caba65-e2d2-4527-a9a4-28d506b6e8df	800	1	3	2015-03-20 12:01:19.866-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:03:46.411-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	pool deck	\N	40	20	\N	6.75
28660133-3f80-40b0-ac0b-27b7b00957c4	d4637f1c-f967-4db7-8b91-b518c4408469	e501ee32-36f2-45ea-acc1-5740b9953d18	0	1	0	2015-03-20 12:03:52.219-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:52.083-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	southern	\N	200	65	\N	0.5
9255de86-f7cd-4304-ba76-a31dea3f195f	b0fb51c9-8e59-4296-8461-93560e5944b8	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	3348	1	1	2015-03-13 10:52:16.191-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 13:03:15.712-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Sales	\N	72	46.5	\N	2.5
81a76138-3382-40ad-8219-0d83de83089a	78b824b2-2d01-4fe8-90ab-38a179c45bd0	92765abf-abd1-4998-ba3a-728610789763	625	1	0	2015-03-21 15:55:41.721-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.583-04	c27e733b-f247-498a-a945-7521cca65c3b	detach	\N	25	25	\N	5.75
8d41e89e-67c8-498e-b9c7-185a382fe9b8	affcd11c-4335-4504-aaf2-545b540c0e2b	22caba65-e2d2-4527-a9a4-28d506b6e8df	720	1	2	2015-03-20 18:21:32.286-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:38:22.243-04	fd0457a0-2d66-4a63-857b-21f224a14a47	Garage	\N	24	30	\N	6.5
a3bb1651-ae21-4eb3-91be-ed6839f2bb6e	a517dd7e-1dca-412b-bb43-af391c11f73a	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	6800	1	5	2015-03-19 20:13:26.773-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-04-03 17:39:46.613-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	Garage	\N	85	80	\N	2.5
5a17a5c5-0b80-4baf-af41-d6ba1c4df17c	3735a089-c998-4874-903c-3d2c2509c951	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	1512	1	1	2015-03-22 14:00:40.796-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:07:33.28-04	dc91c128-7614-4592-b94e-c19660131a55	showroom floor	\N	28	54	\N	5
adf0bd70-4d9f-4c0f-a4e6-6a05bb22d3d6	1e9e943d-ce42-4a50-8a03-4f3ba477b6d7	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	576	1	0	2015-03-25 20:24:23.382-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-25 20:24:23.305-04	06169b04-bb68-4868-b995-98388fa33e16	Garage	\N	24	24	\N	7
48d90bdc-0e75-4f62-8031-8e163ca39ae5	40bb9421-6ae9-4c3d-9ac6-db6955a420d4	84465f99-18df-4fe3-9330-801764344c18	1225	1	0	2015-03-26 21:14:51.171-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.094-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	lodge	\N	35	35	\N	6
e570250b-496b-4367-94d8-bcf4ae73fad0	0faa9ff4-6f2b-4b0c-b5a0-6f6d971cdf62	84465f99-18df-4fe3-9330-801764344c18	2025	1	0	2015-03-26 21:24:37.889-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:37.783-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	bar	\N	45	45	\N	8
94cd9abe-c922-4e4b-b4c0-5260f3680e3c	7b93ff1b-2312-4d5d-8db3-bc9e107f420d	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	9000	1	0	2015-03-29 07:44:59.665-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.558-04	9ef858fa-13d8-4152-aff7-28daea5a0842	rca	\N	100	90	\N	2.5
3d85d290-cef4-4b65-a7d3-3a6d6341dd78	fda3f113-8612-4c17-9279-f4156f2bdbaa	85895bef-b806-4051-a5f3-34892c56dd4c	50	1	0	2015-04-28 08:01:15.841-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:15.738-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	left loading dock and sidewalk	\N	1	50	\N	3
42efff15-c066-45b5-a8bf-ae1eb85fb502	fda3f113-8612-4c17-9279-f4156f2bdbaa	e501ee32-36f2-45ea-acc1-5740b9953d18	8465	1	1	2015-04-28 08:01:15.537-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:24:24.836-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	loading docks and sidewalks	\N	1	8465	\N	0.5
374343e5-7456-4784-a437-5bd0c8e8034d	fe9c9d38-df67-4ee8-91da-b4e285923c2f	ef9e68f6-8298-4ad2-857e-0babba80ee19	720	1	1	2015-03-29 13:26:13.581-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:35:13.262-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Garage 2	\N	24	30	\N	3.5
d95c107b-58e6-4410-9e0a-4d9749daec39	161aea66-486a-4ce9-8d52-b445feef3aeb	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	576	1	1	2015-05-02 18:13:29.408-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:33.549-04	350a236f-f780-40e9-85e3-2b9227f4d76f	Garage	\N	24	24	\N	6.5
e530d9d4-bc1a-4836-8bf6-64818c40612e	5ee6462a-7e80-469b-ad4d-107bfc519502	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	720	1	1	2015-03-29 21:09:10.795-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:14:36.99-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	New garage	\N	24	30	\N	1.9
9071fbf1-d7bb-4ab4-99df-08e5428d4507	5ee6462a-7e80-469b-ad4d-107bfc519502	ef9e68f6-8298-4ad2-857e-0babba80ee19	720	1	1	2015-03-29 21:10:06.001-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:16:01.475-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	New garage 2	\N	24	30	\N	3.5
9e3014ad-98b2-48e4-9308-cf65a4c8785b	55e64832-e4c3-4474-a4ee-0200f5ee2656	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	575	1	0	2015-05-13 22:53:26.198-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:53:26.096-04	d7bb1e62-fe40-4774-a432-03bd53510708	Garage	\N	25	23	\N	6.5
80d181fa-ec02-45f2-ba28-3b634ad4caa0	cef56458-c337-40df-af91-2716165a088c	84465f99-18df-4fe3-9330-801764344c18	400	1	1	2015-03-31 14:26:47.641-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:50.936-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	Basement	\N	20	20	\N	8
cdaaa7f6-fb68-4d93-b2fb-d60aba62529e	3edc5ea1-bacf-45f0-b8a3-1c200bc31826	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	900	1	0	2015-05-18 16:06:28.865-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:06:28.789-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Basement	\N	30	30	\N	2.5
5eaeac28-83dc-41cb-b268-efdb97accb76	661fc820-6eb9-4dc1-8908-d0b916fc401b	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	720	1	0	2015-04-01 13:39:01.733-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:39:01.639-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Garage	\N	24	30	\N	2
24b3d24e-9f68-41f5-9fa2-724bfb8366f1	f8425b10-4769-4f8f-80e8-75c37d471f91	187db143-bd8f-4251-bca6-47393c460f58	72	1	0	2015-05-19 00:20:30.453-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.365-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	From porch	\N	12	6	\N	5.5
3b443545-ecbf-4877-afba-2b4d55311259	fe9c9d38-df67-4ee8-91da-b4e285923c2f	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	720	1	2	2015-03-29 13:24:58.018-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:49:45.376-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Garage	\N	24	30	\N	2
c5bf7722-45c4-41ff-95a0-367886ef8834	fe9c9d38-df67-4ee8-91da-b4e285923c2f	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	384	1	8	2015-03-29 13:30:01.036-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 14:23:34.235-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	Walkway	\N	24	16	\N	6.75
4d40ee93-9177-4e88-9962-850559ba06eb	b52a96ac-974f-4fc9-95d9-02b4ddc41c69	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	312	1	0	2015-04-03 12:57:54.948-04	06169b04-bb68-4868-b995-98388fa33e16	2015-04-03 12:57:54.852-04	06169b04-bb68-4868-b995-98388fa33e16	Walk	\N	78	4	\N	9
c7cb5b68-0429-4882-8999-8a5d144698c5	212b66f9-bf37-4c60-9fed-6417388c407e	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	1000	1	1	2015-05-20 15:18:38.281-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:19:05.751-04	06169b04-bb68-4868-b995-98388fa33e16	warehouse	\N	20	50	\N	2.5
e031f3ba-0d12-4573-b713-b514323e0e32	a517dd7e-1dca-412b-bb43-af391c11f73a	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	2805	1	2	2015-04-03 17:34:20.159-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-04-03 17:38:21.671-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	Garage	\N	55	51	\N	0
83b048fc-233b-4c03-b80c-64fa2205b518	54a8f2a4-3fe2-4541-a5fe-f96573f7c107	84465f99-18df-4fe3-9330-801764344c18	400	1	0	2015-04-04 17:24:44.824-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:44.734-04	84525335-0f50-4354-8dd8-f9fe584df21a	long bay	\N	10	40	\N	8
aae962f5-78ac-41e8-8781-580c4461d3fc	7ceca3f2-4e0a-4d19-9633-8b650ae205aa	92765abf-abd1-4998-ba3a-728610789763	900	1	0	2015-04-04 17:25:54.31-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.243-04	84525335-0f50-4354-8dd8-f9fe584df21a	Rey hill	\N	30	30	\N	5.75
394cc482-a9ec-4254-84d4-344ca42f5d23	adcf9448-69de-4655-b7fe-f088eb0d8d1c	84465f99-18df-4fe3-9330-801764344c18	768	1	1	2015-04-09 18:02:13.813-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:37.938-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Shop	\N	32	24	\N	4.25
689afa76-eb3e-4044-97b9-f52f6d3238a3	8ff4934d-d954-4882-819e-db632041838f	187db143-bd8f-4251-bca6-47393c460f58	288	1	0	2015-04-14 13:15:30.037-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:29.931-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	back patio	\N	24	12	\N	5.5
ceed51c9-8266-4407-b7b1-a5f6bcd77720	b03ab54a-6492-4f4c-9fac-f21f313728d1	84465f99-18df-4fe3-9330-801764344c18	400	1	0	2015-04-18 02:30:35.63-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.56-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	living room	\N	20	20	\N	7
efe58d23-5903-4846-a7c4-c824bcd83622	9b967bd2-1a34-4e70-aa4b-eee62cd8241d	e501ee32-36f2-45ea-acc1-5740b9953d18	0	1	0	2015-04-18 03:29:38.735-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:29:38.66-04	41072458-fade-43dc-a1d8-543db6c37a49	Dinning room	\N	65	140	\N	0.5
55958483-d103-4913-9c50-7a447d505634	5b379c22-e672-4877-8427-dc056918a8f2	9004c757-e34f-4f69-aeb6-c68254569c97	576	1	0	2015-04-23 17:43:39.671-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:39.594-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	garage	\N	24	24	\N	7
436997cd-959f-4478-98e3-1b7f292b1264	212b66f9-bf37-4c60-9fed-6417388c407e	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	600	1	1	2015-05-23 13:48:42.315-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:51:37.786-04	06169b04-bb68-4868-b995-98388fa33e16	Family Room	\N	30	20	\N	7
25ce786f-6218-4b28-874c-a127fa6a50ce	f73e6008-f3f7-47be-8a2a-66d3e9d746a9	2bb379df-16d7-47c5-bd98-aacf19491605	195	1	0	2015-05-27 17:26:44.563-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.494-04	06169b04-bb68-4868-b995-98388fa33e16	Family Room	\N	15	13	\N	7
0b1c3c57-303f-4ff9-9026-ba8229d78a31	fe2ef0d5-b010-4b45-8c56-7a4d4aeb4652	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	5320	1	0	2015-06-01 12:04:53.617-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:53.552-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Main	\N	95	56	\N	2.5
97d49349-ebd2-4f6c-8f6a-b39f47dd8f90	fe2ef0d5-b010-4b45-8c56-7a4d4aeb4652	0b1d2077-bf8b-42d3-b991-d9f09bbff327	5320	1	0	2015-06-01 12:05:51.885-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:05:51.813-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Main	\N	95	56	\N	6.5
c851b5b3-b994-4782-9de2-ecd5b0fd6422	fe2ef0d5-b010-4b45-8c56-7a4d4aeb4652	ef9e68f6-8298-4ad2-857e-0babba80ee19	225	1	0	2015-06-01 12:06:48.126-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:06:48.05-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Hall 1	\N	15	15	\N	4.75
f6620af1-dade-4947-b1c7-1ac1f57697c6	fe2ef0d5-b010-4b45-8c56-7a4d4aeb4652	ef9e68f6-8298-4ad2-857e-0babba80ee19	225	1	0	2015-06-01 12:07:08.709-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:07:08.613-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Hall 2	\N	15	15	\N	4.75
b16213cc-b812-45f5-be49-2f8f32bd8cea	09bd5351-6c08-47c7-ae5e-53c7ad004ff7	187db143-bd8f-4251-bca6-47393c460f58	144	1	0	2015-06-03 19:43:57.882-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:57.801-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Porch	\N	12	12	\N	5.5
d3b7dbd6-1b43-4e66-855d-548bc20f225a	85687330-3806-4773-ae87-e87520e45e56	187db143-bd8f-4251-bca6-47393c460f58	65	1	0	2015-06-03 19:44:39.019-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:38.954-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Porch2	\N	5	13	\N	5.5
c77a6dda-6284-4049-a939-3698e45c302f	85687330-3806-4773-ae87-e87520e45e56	187db143-bd8f-4251-bca6-47393c460f58	156	1	1	2015-06-03 19:51:58.689-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:03.657-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Back porch	\N	12	13	\N	5.5
e1a629b4-a1e7-4c49-b7e6-5641f86d9628	a2f2a554-476f-4e8b-af30-218e8c268c19	e501ee32-36f2-45ea-acc1-5740b9953d18	784	1	0	2015-06-23 10:37:43.631-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:37:43.52-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Back porch	\N	28	28	\N	0.5
f71fd9ae-7da6-446f-8deb-151c4be8122b	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	345	1	0	2015-06-23 10:38:30.434-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:38:30.361-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Back porck2	\N	23	15	\N	0.5
370d6908-29a7-4ec7-8567-890598892732	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	675	1	0	2015-06-23 10:39:00.646-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:39:00.582-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Bo 3	\N	27	25	\N	0.5
618fccd8-782f-4648-a440-38ac99e48ee0	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	104	1	0	2015-06-23 10:39:59.403-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:39:59.309-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Bp4	\N	26	4	\N	0.5
fad81990-e24d-4f2a-bd67-92f9ce06f000	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	784	1	0	2015-06-23 10:43:04.796-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:43:04.731-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Bp1	\N	28	28	\N	0.5
c334e3ad-fc0f-4ff4-9474-5a64783f05b9	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	93	1	0	2015-06-23 10:43:41.085-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:43:41.012-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Step	\N	31	3	\N	0.5
354554d2-7af4-40f6-94cd-84becefa2ff0	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	280	1	0	2015-06-23 10:44:15.076-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:44:14.993-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Bp patio	\N	20	14	\N	0.5
7ac76506-299e-44b2-bdbb-25232251bf48	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	300	1	0	2015-06-23 10:44:54.717-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:44:54.639-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Front p	\N	60	5	\N	0.5
29e22cd7-89ae-46fc-84e5-830ff3032294	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	352	1	0	2015-06-23 10:45:15.531-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:15.452-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Fp2	\N	22	16	\N	0.5
56beb55c-b2ce-4819-a052-223fdf19939c	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	216	1	0	2015-06-23 10:45:37.482-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:37.386-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	fp2	\N	18	12	\N	0.5
5fc7a35b-94d0-4998-b774-c5d9a9b280f0	7cfed386-2ab8-48bc-93f0-20d82e849362	e501ee32-36f2-45ea-acc1-5740b9953d18	96	1	0	2015-06-23 10:45:56.415-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:56.345-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Fp3	\N	8	12	\N	0.5
3923b349-b023-444b-9d63-48cc7b2dcc01	7cfed386-2ab8-48bc-93f0-20d82e849362	ef9e68f6-8298-4ad2-857e-0babba80ee19	24	1	0	2015-06-23 11:01:49.668-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:01:49.583-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Gf1	\N	16	1.5	\N	4.75
69cab3b4-a3d1-4f27-aff9-6beafabcfa29	7cfed386-2ab8-48bc-93f0-20d82e849362	ef9e68f6-8298-4ad2-857e-0babba80ee19	126	1	0	2015-06-23 11:03:22.368-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:03:22.301-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Gf2	\N	28	4.5	\N	4.75
ae3f1353-8162-479f-afbe-f6b19877610d	a460494c-c363-4806-99f5-044407448914	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	55	1	0	2015-07-02 14:25:33.32-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.15-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Sidewalk	\N	5	11	\N	6.5
1332d396-5616-473f-baed-44b1e3ad0951	a460494c-c363-4806-99f5-044407448914	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	1656	1	0	2015-07-02 14:25:33.335-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.086-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Main drive	\N	46	36	\N	6.5
87585b95-7ff3-416c-ad9c-9c50410a869b	a460494c-c363-4806-99f5-044407448914	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	66	1	0	2015-07-02 14:25:33.34-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.208-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Porch	\N	6	11	\N	6.5
535394ad-a692-485d-8b3d-1d867c2663e7	749db2ac-63c1-4790-93b6-f593d3f83e99	187db143-bd8f-4251-bca6-47393c460f58	1656	1	0	2015-07-02 14:27:26.869-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:26.792-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Main driveway	\N	46	36	\N	5.5
4331f9e6-932d-41a4-a469-5f5fb9d31adb	749db2ac-63c1-4790-93b6-f593d3f83e99	187db143-bd8f-4251-bca6-47393c460f58	55	1	0	2015-07-02 14:29:17.996-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:17.919-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Sidewalk	\N	5	11	\N	5.5
1f58cc27-4415-4a62-9a6a-936229a50424	749db2ac-63c1-4790-93b6-f593d3f83e99	187db143-bd8f-4251-bca6-47393c460f58	66	1	0	2015-07-02 14:29:52.317-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.25-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	Porch	\N	6	11	\N	5.5
487c50d3-383e-4a78-adaf-0c87c21439b6	f10c7484-9daa-44aa-803e-67bd587261ab	85895bef-b806-4051-a5f3-34892c56dd4c	6	1	0	2015-07-05 23:29:51.523-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:51.395-04	61709628-4bca-418f-8dc4-1ad358c785d6	Court yard patio	\N	6	1	\N	3
8e4960c8-ff32-4b6b-890c-09990423d20d	f10c7484-9daa-44aa-803e-67bd587261ab	f0d86fcc-dd1f-4947-851c-e88f21041f61	400	1	1	2015-07-05 23:29:51.547-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.035-04	61709628-4bca-418f-8dc4-1ad358c785d6	court yard patio	\N	20	20	\N	7
af2a2754-055f-4fe6-a1a1-68840838f4b7	56e3e125-2525-481f-b644-064a4ef7625b	85895bef-b806-4051-a5f3-34892c56dd4c	50.3999999999999986	1	9	2015-08-09 18:21:26.036-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:14:27.337-04	067b4635-5840-48fd-980d-ccddbe1b173d	Wrap 2 walls	\N	36	1.39999999999999991	\N	3.5
6e79c5ea-54c4-465b-9926-9534c06d883b	55837cd5-41d0-4899-bfc4-4f11822bc4ba	84465f99-18df-4fe3-9330-801764344c18	390	1	0	2015-08-11 13:32:15.854-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:15.782-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	Wood floor	\N	30	13	\N	8
338ca186-8dc1-499f-ab81-f2605ddecd13	540aa1c3-599c-48b8-afda-6a4384578779	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	384	1	1	2015-07-13 08:33:04.609-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:33:09.282-04	5414f676-63e9-4117-87bd-ec5577e932b7	A-Frame option 2	\N	16	24	\N	6.5
cbc9f776-1a76-4da1-a4de-f069d7410ca7	a96d14d6-2936-4bcd-a18c-4a7f2523d184	ef9e68f6-8298-4ad2-857e-0babba80ee19	437	1	0	2015-08-26 13:35:43.772-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.675-04	e604c054-19e1-4332-b9ae-97ef0c58380f	Garage floor	\N	23	19	\N	4.75
9025a2dc-5d54-4882-957f-0c688e9dd44b	540aa1c3-599c-48b8-afda-6a4384578779	f0d86fcc-dd1f-4947-851c-e88f21041f61	0	1	4	2015-07-13 08:22:57.024-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:05.809-04	5414f676-63e9-4117-87bd-ec5577e932b7	A-Frame	\N	0	0	\N	7.5
23b5e6e4-8fde-46d7-baba-f047d5f386b0	96a9a47c-11a2-4abd-89c4-f54168ffe0eb	f0d86fcc-dd1f-4947-851c-e88f21041f61	0	1	0	2015-07-17 21:33:32.698-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:32.62-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	Shop	\N	60	36	\N	7
f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	eac3d34d-6cac-4c78-81ba-28392c70890b	3191a382-5125-4e2f-ba54-7088262d7e61	600	1	0	2015-07-22 17:05:28.231-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:28.149-04	06169b04-bb68-4868-b995-98388fa33e16	Pool Deck	\N	20	30	\N	8
22b32160-eb5f-4108-8a10-c3a8b61e4689	5c2c1517-8e18-40eb-b813-ef8946528654	ef9e68f6-8298-4ad2-857e-0babba80ee19	1160	1	0	2015-07-22 22:12:26.715-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:26.635-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	Garage	\N	29	40	\N	4.75
9276b5f0-61c2-41e7-9128-17081fa106dc	3513c87e-0c77-4360-9c02-679063af81c5	9004c757-e34f-4f69-aeb6-c68254569c97	640	1	0	2015-08-30 21:43:44.613-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.508-04	89b13534-20eb-49d7-914c-d84a673f858d	St Matthews	\N	10	64	\N	7
68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	0bfa54f1-50e1-4fd7-8292-5f77ab106401	9004c757-e34f-4f69-aeb6-c68254569c97	300	1	1	2015-07-24 16:06:13.678-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.159-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	hallways	\N	50	6	\N	6
d75e85e3-67ca-4c50-998d-727df9a7d9d8	0bfa54f1-50e1-4fd7-8292-5f77ab106401	9004c757-e34f-4f69-aeb6-c68254569c97	120	1	2	2015-07-24 16:05:04.788-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.062-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	house	\N	5	24	\N	12
0f148dae-1d35-4740-b564-6317e74f0bb1	0a8c2f29-a999-4101-9c1d-3b00f5beca08	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	1300	1	0	2015-07-29 11:06:59.941-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:06:59.867-04	0a215950-e391-4575-8d45-e5c36c6cb723	Penguins habitat	\N	130	10	\N	6.5
739f3012-e061-4de0-ac62-a7631ceeabb8	a97a07c7-7e71-476f-85cd-7aeed235ce49	9004c757-e34f-4f69-aeb6-c68254569c97	12000	1	0	2015-08-31 13:06:58.306-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.237-04	2a63f4b8-4436-45bf-9439-866ac59e1911	Las Vegas Jail	\N	6000	2	\N	7
d1b8fefd-8f90-4386-b45a-c46c45e1f6fa	cf12b987-b8eb-4ef7-94f9-c880f725070f	ef9e68f6-8298-4ad2-857e-0babba80ee19	483	1	0	2015-09-04 17:23:33.569-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.5-04	e604c054-19e1-4332-b9ae-97ef0c58380f	garage floor	\N	23	21	\N	5
9e617f38-e335-494d-8665-ee1f362c061f	56e3e125-2525-481f-b644-064a4ef7625b	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	160	1	1	2015-08-09 18:12:58.498-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:18:59.227-04	067b4635-5840-48fd-980d-ccddbe1b173d	Garage Apron	\N	16	10	\N	9.5
931b4ca7-30fb-4499-b2de-483974ea5a48	b6bb084a-762c-4936-95be-3c13cb03325c	9004c757-e34f-4f69-aeb6-c68254569c97	2250	1	0	2015-10-22 18:57:10.179-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:10.086-04	86103f7b-c3bd-489b-a732-10374a07ed5a	Floor	\N	50	45	\N	7
7eea4c3b-2670-4597-9d63-6e42e8c44f7a	5c6fb96c-22f6-40b4-83d2-80b1b908f0f6	85895bef-b806-4051-a5f3-34892c56dd4c	7440000	1	2	2015-09-10 02:33:15.255-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:34:18.791-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	Belridge  for chevron	\N	14880	500	\N	3
4e590213-fc10-492e-970d-cd83de4a8c70	c3d28643-dfbb-4887-9b75-0c5733d8b8ff	ce5baf3c-608b-4300-a95e-503c70fd5b34	1733.75	1	0	2015-10-27 13:29:23.852-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:23.728-04	86103f7b-c3bd-489b-a732-10374a07ed5a	Service Drive	\N	47.5	36.5	\N	7.5
125358af-ae36-4370-a098-4e99122857b7	56e3e125-2525-481f-b644-064a4ef7625b	85895bef-b806-4051-a5f3-34892c56dd4c	70	1	0	2015-08-09 18:30:34.175-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:30:34.097-04	067b4635-5840-48fd-980d-ccddbe1b173d	Cracks in apron	\N	70	1	\N	3.5
eaaebdf8-fe9c-4d17-a55e-05c92296f29e	56e3e125-2525-481f-b644-064a4ef7625b	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	315	1	4	2015-08-09 18:12:58.495-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:11:36.5-04	067b4635-5840-48fd-980d-ccddbe1b173d	Garage	\N	21	15	\N	9.5
7c342b84-b254-44ce-ac26-2442ad4a8064	b201737f-4948-4c1c-a6b6-e3320269bc56	187db143-bd8f-4251-bca6-47393c460f58	0	1	0	2015-10-19 14:46:02.049-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:01.94-04	51855703-9a42-4c37-8418-24da5bf57be7	Basement	\N	0	0	\N	5.5
b02d723a-5f11-43f4-bd69-6c945138cdad	c3d28643-dfbb-4887-9b75-0c5733d8b8ff	ce5baf3c-608b-4300-a95e-503c70fd5b34	1198.5	1	0	2015-10-27 13:29:24.23-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.101-04	86103f7b-c3bd-489b-a732-10374a07ed5a	Front area	\N	70.5	17	\N	7.5
42a3ae0b-5923-45eb-be87-af70ed324c31	c3d28643-dfbb-4887-9b75-0c5733d8b8ff	ce5baf3c-608b-4300-a95e-503c70fd5b34	1558	1	0	2015-10-27 13:29:24.234-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.021-04	86103f7b-c3bd-489b-a732-10374a07ed5a	Picture area	\N	41	38	\N	6.5
1dd3b843-915e-4ea3-9b08-e076c5366530	3d0859e4-a3f4-47f4-81cb-207f9a651cb6	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	200	1	0	2015-10-30 11:54:47.428-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:47.338-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Pool Deck	\N	20	10	\N	6.5
297ada62-218d-448c-a67f-c5e2cdeeec0e	d9733104-e703-4993-b36f-fd7c39b253cf	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	600	1	0	2015-10-30 13:01:40.494-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.418-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Driveway	\N	60	10	\N	7.25
ca5bcda3-6d0d-4c85-96a9-9eca67220d80	d5e1da07-449b-49b7-aeca-0ea35a804b6f	e501ee32-36f2-45ea-acc1-5740b9953d18	500	1	0	2015-10-30 13:03:09.479-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:03:09.416-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Patio	\N	20	25	\N	0.65
8448dd7c-bf73-4761-b39a-e75f90ae64e9	d5e1da07-449b-49b7-aeca-0ea35a804b6f	187db143-bd8f-4251-bca6-47393c460f58	500	1	2	2015-10-30 13:07:49.112-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.586-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Patio	\N	20	25	\N	5.5
9b9e103c-566e-4982-8932-e681a3d01ef4	9a2af3d1-5f4e-40c2-8ed9-4f2b342d65f9	f0d86fcc-dd1f-4947-851c-e88f21041f61	0	1	0	2015-10-30 16:40:12.674-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:12.589-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Garage	\N	10	50	\N	7
191d6674-9359-4a92-8f21-39a96e000a79	02182d99-7cbb-415b-9b3b-659f558c8c2b	84465f99-18df-4fe3-9330-801764344c18	900	1	0	2015-10-30 16:55:53.658-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:53.583-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	Garage	\N	90	10	\N	8
f2321118-db87-4e60-9fb1-3ce4004d1844	e4a67ac4-0de5-4d31-94c4-2abab599089a	f0d86fcc-dd1f-4947-851c-e88f21041f61	1200	1	0	2015-10-30 20:48:30.048-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:29.96-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Garage	\N	30	40	\N	7
b5910bb5-9c2b-4252-ad35-5c7943c086a4	2d6fd993-f98c-4e9b-8ce9-350272a5b325	0b1d2077-bf8b-42d3-b991-d9f09bbff327	870	1	0	2015-10-30 20:54:47.987-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:54:47.923-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	Garage	\N	30	29	\N	6.5
4eb3242d-1270-4d21-877c-62be97c26dda	8d541171-6a68-492a-917f-76e213f10a22	9004c757-e34f-4f69-aeb6-c68254569c97	1180	1	0	2015-10-30 21:08:33.473-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:33.407-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	Garage	\N	20	59	\N	7
b6b2d9d3-d8e6-4a4f-b38b-d9b809a69352	f56b4115-719d-4f2e-a53c-26c7e26f85cf	e501ee32-36f2-45ea-acc1-5740b9953d18	1500	1	0	2015-10-30 21:09:55.84-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:09:55.762-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Garage	\N	30	50	\N	0.5
4c51a851-6f8d-4685-89fc-d33d8491671d	f56b4115-719d-4f2e-a53c-26c7e26f85cf	f0d86fcc-dd1f-4947-851c-e88f21041f61	12	1	0	2015-10-30 21:11:25.052-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:24.98-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	Added later	\N	3	4	\N	7
f5ac4a48-1174-48c9-af28-8790340ff039	28b530ea-aff4-4b6d-9296-9d63342f7c75	ef9e68f6-8298-4ad2-857e-0babba80ee19	576	1	0	2015-11-02 15:41:38.596-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.498-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Garage Floor	\N	24	24	\N	6.5
61c50311-9c03-46a7-85be-6dbb30661206	331f197b-27eb-4246-b2d8-5be7a84552ab	ef9e68f6-8298-4ad2-857e-0babba80ee19	576	1	0	2015-11-02 15:45:54.321-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.242-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Garage Floor	\N	24	24	\N	4.75
f951ca00-f625-46ea-9828-8e94b6e95e73	09cf6f53-9bc9-47cb-a9cd-dbca3cfb9d2a	e501ee32-36f2-45ea-acc1-5740b9953d18	1596	1	0	2015-11-02 15:52:05.425-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:52:05.362-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Patio	\N	38	42	\N	0.5
a2b3570b-8557-4790-bcbe-a51dd56aafcd	70ebf7bf-d639-4964-8671-589fa4e220a0	e501ee32-36f2-45ea-acc1-5740b9953d18	1500	1	0	2015-11-02 16:02:02.54-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:02:02.477-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	Patio	\N	30	50	\N	0.5
73ed0813-4b6f-4a7c-b59b-3671052c4dc2	4b040e4d-2199-4c2e-a9a9-da684c2c9c15	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	700	1	2	2015-11-08 19:26:15.929-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:47.781-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	Driveway	\N	20	35	\N	6.5
663d9af6-d780-4d12-ac0e-57d2459f2fae	3f0ffe68-9049-4abd-aab4-8e4d1eff0f84	92765abf-abd1-4998-ba3a-728610789763	900	1	0	2015-11-13 15:39:06.473-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:06.399-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	Garage	\N	36	25	\N	7
\.


--
-- Data for Name: projectdetailstyle; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY projectdetailstyle (id, ingredientid, projectdetailid, colorid, patternid, status, version, added, addedby, changed, changedby) FROM stdin;
a3279d70-2bc2-47f4-99ce-d2eac9c5b6bb	e868ee90-8a90-4aec-88e3-00365cf64a94	c1545ddc-a592-41a6-a281-4932eb83ab33	\N	\N	1	0	2015-01-21 23:16:41.284-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:16:41.209-05	06169b04-bb68-4868-b995-98388fa33e16
942e825e-39e2-404d-8157-c2cdc6cdadd2	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c1545ddc-a592-41a6-a281-4932eb83ab33	\N	\N	1	0	2015-01-21 23:16:41.561-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:16:41.476-05	06169b04-bb68-4868-b995-98388fa33e16
f58e9edb-b59c-4e4d-a1a6-d9dcc93e1121	18362ca7-9064-4bdb-a289-edf087cac828	c1545ddc-a592-41a6-a281-4932eb83ab33	\N	\N	1	0	2015-01-21 23:16:41.567-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-21 23:16:41.41-05	06169b04-bb68-4868-b995-98388fa33e16
db3b7968-f738-48b1-a15b-c19920f3e780	18362ca7-9064-4bdb-a289-edf087cac828	d9d04899-3f3d-4e1f-8ce0-632c1320a3ae	\N	\N	1	0	2015-01-22 09:43:51.704-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:43:51.61-05	06169b04-bb68-4868-b995-98388fa33e16
7ea94497-8ced-4d4f-9385-a6438b590e82	b7475b4a-6613-466d-b099-8708d527b55f	d9d04899-3f3d-4e1f-8ce0-632c1320a3ae	\N	\N	1	0	2015-01-22 09:43:51.845-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:43:51.764-05	06169b04-bb68-4868-b995-98388fa33e16
5744dc98-08cc-472e-9555-281d402f3f37	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d9d04899-3f3d-4e1f-8ce0-632c1320a3ae	\N	\N	1	0	2015-01-22 09:43:51.929-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:43:51.855-05	06169b04-bb68-4868-b995-98388fa33e16
167742c0-bf4b-4c2c-84c4-950df928f272	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d0bc2a3d-f29e-4c58-aad7-a4f5490a7723	\N	\N	1	0	2015-01-22 09:44:43.96-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:44:43.855-05	06169b04-bb68-4868-b995-98388fa33e16
f670bb14-d90b-49f6-9fc7-f6af3443ed2d	e868ee90-8a90-4aec-88e3-00365cf64a94	d0bc2a3d-f29e-4c58-aad7-a4f5490a7723	\N	\N	1	0	2015-01-22 09:44:44.156-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:44:44.081-05	06169b04-bb68-4868-b995-98388fa33e16
e215d383-a405-4765-b600-4eaa239a1049	18362ca7-9064-4bdb-a289-edf087cac828	d0bc2a3d-f29e-4c58-aad7-a4f5490a7723	\N	\N	1	0	2015-01-22 09:44:44.169-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:44:44.022-05	06169b04-bb68-4868-b995-98388fa33e16
2b5e21af-88d6-419c-9b7b-02b717a70e4a	e868ee90-8a90-4aec-88e3-00365cf64a94	57049c5d-0f18-4787-99d0-9edea2d8fb5b	\N	\N	1	0	2015-02-02 13:36:04.383-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:36:04.249-05	1676623f-4657-410f-87b6-db11cf461ba9
45c275be-be1f-4604-900a-ce27b84c6c38	eb970c6a-8430-4422-a233-032fea8ce39c	eb0a14dc-48a1-4ce8-b06c-68eb44d32032	\N	\N	1	0	2015-02-02 18:46:55.483-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:55.414-05	06169b04-bb68-4868-b995-98388fa33e16
ff202f10-9133-49a4-9649-cdbb1cf75adb	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	eb0a14dc-48a1-4ce8-b06c-68eb44d32032	\N	\N	1	0	2015-02-02 18:46:56.175-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:56.1-05	06169b04-bb68-4868-b995-98388fa33e16
0dfd6ded-2718-470a-891e-69ca1fd0644f	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	a746f882-7db4-4c72-859b-99aff76e32f7	\N	\N	1	1	2015-01-29 22:02:44.58-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:09:26.023-05	06169b04-bb68-4868-b995-98388fa33e16
26954e24-2718-4813-bc50-2081565ae2b1	e868ee90-8a90-4aec-88e3-00365cf64a94	a746f882-7db4-4c72-859b-99aff76e32f7	\N	\N	1	1	2015-01-29 22:02:44.876-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:09:26.258-05	06169b04-bb68-4868-b995-98388fa33e16
a33e6c5f-b6af-4c01-95b9-fdeabbdc9ee6	18362ca7-9064-4bdb-a289-edf087cac828	a746f882-7db4-4c72-859b-99aff76e32f7	\N	\N	1	1	2015-01-29 22:02:44.884-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:09:26.268-05	06169b04-bb68-4868-b995-98388fa33e16
1be163b5-4814-4a96-8f88-1a7fd8a37901	5ace29a1-0b40-4ec3-9084-26b98b410a80	a746f882-7db4-4c72-859b-99aff76e32f7	\N	\N	1	1	2015-01-29 22:02:44.881-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:09:26.29-05	06169b04-bb68-4868-b995-98388fa33e16
9ac7004b-a11a-497c-ade4-04f4d4f33b0c	afabc446-9a56-4b18-8386-141cfbb34a48	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.646-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.234-05	06169b04-bb68-4868-b995-98388fa33e16
cfc2416d-24b4-421e-9924-31141f5e3bb7	fb198851-cd6a-40bc-97d0-630a6ed4dec2	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.655-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.29-05	06169b04-bb68-4868-b995-98388fa33e16
f710ee2c-1e6a-4936-a06f-3decbcde31bd	ce780dbe-0148-4e67-b478-4fea4cb405fc	cfe6a19e-20ee-4703-932d-926b2ac59107	\N	\N	1	3	2015-01-29 22:13:53.872-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:25:28.978-05	06169b04-bb68-4868-b995-98388fa33e16
33093bf4-eb51-4825-adf2-b7c25f0fc167	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	572d45b1-1c94-4469-8421-319f70b8bd3e	\N	\N	1	0	2015-01-29 23:38:42.546-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:38:42.496-05	06169b04-bb68-4868-b995-98388fa33e16
b03c0a9a-71c0-4040-8928-f519ff36bc04	e868ee90-8a90-4aec-88e3-00365cf64a94	572d45b1-1c94-4469-8421-319f70b8bd3e	\N	\N	1	0	2015-01-29 23:38:42.668-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:38:42.588-05	06169b04-bb68-4868-b995-98388fa33e16
bde9e0f2-e144-46ab-9467-15460385f156	18362ca7-9064-4bdb-a289-edf087cac828	572d45b1-1c94-4469-8421-319f70b8bd3e	\N	\N	1	0	2015-01-29 23:38:42.687-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:38:42.632-05	06169b04-bb68-4868-b995-98388fa33e16
6d1e36d5-4fbd-4e5f-85ae-dd557d0540c0	5ace29a1-0b40-4ec3-9084-26b98b410a80	572d45b1-1c94-4469-8421-319f70b8bd3e	\N	\N	1	0	2015-01-29 23:38:43.379-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:38:43.319-05	06169b04-bb68-4868-b995-98388fa33e16
ad053513-e81e-4221-b654-3387efb9818f	ce780dbe-0148-4e67-b478-4fea4cb405fc	0791b31f-9fef-47c4-aca5-6685ddb0840f	\N	\N	1	0	2015-01-29 23:39:42.188-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:39:42.12-05	06169b04-bb68-4868-b995-98388fa33e16
aa4d9a8c-ea7b-4b63-be26-219214a41c4b	adf83d9f-8e37-40bd-b649-8eb4cb72b403	0c8f6021-74ea-4353-85fa-f13f8efa56e1	\N	\N	1	1	2015-01-30 00:13:23.748-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:01.624-05	06169b04-bb68-4868-b995-98388fa33e16
ed5e3c5c-9fc7-45c4-9d69-958840acc2ac	fe759c88-d7ce-4340-be48-081167e21453	0c8f6021-74ea-4353-85fa-f13f8efa56e1	\N	\N	1	1	2015-01-30 00:13:24.35-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:01.858-05	06169b04-bb68-4868-b995-98388fa33e16
3bb65586-e38e-4d24-b269-b05b9c0a07c9	eb970c6a-8430-4422-a233-032fea8ce39c	0c8f6021-74ea-4353-85fa-f13f8efa56e1	\N	\N	1	1	2015-01-30 00:13:17.086-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:02.529-05	06169b04-bb68-4868-b995-98388fa33e16
595820c5-5a79-4b73-b51f-20a0d78b2568	e868ee90-8a90-4aec-88e3-00365cf64a94	0c8f6021-74ea-4353-85fa-f13f8efa56e1	\N	\N	1	1	2015-01-30 00:13:21.605-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:02.829-05	06169b04-bb68-4868-b995-98388fa33e16
ba4b4e9b-46a9-4608-aef8-1390665c4782	ce780dbe-0148-4e67-b478-4fea4cb405fc	f2db87bc-cb07-4c56-86b2-20782a15104e	\N	\N	1	0	2015-01-30 00:14:50.109-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 00:14:50.01-05	06169b04-bb68-4868-b995-98388fa33e16
3c8474bf-cbec-4a67-9bd9-bdec32880fc9	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	41104ffd-aa54-4aeb-a522-9750c9b3ba12	\N	\N	1	0	2015-01-30 16:03:09.781-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:09.704-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
40956653-5c82-4cc6-9327-f32bdf065ad8	e9d51055-8986-4190-a7ee-98a77dc268b0	41104ffd-aa54-4aeb-a522-9750c9b3ba12	\N	\N	1	0	2015-01-30 16:03:09.787-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-01-30 16:03:09.666-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
b387652f-8f9c-41ee-8dd7-b034001b4521	afabc446-9a56-4b18-8386-141cfbb34a48	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:16.789-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:16.73-05	06169b04-bb68-4868-b995-98388fa33e16
c1a62bb6-ed8f-40a7-91ee-fa4a29c68bad	fe759c88-d7ce-4340-be48-081167e21453	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:17.165-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.101-05	06169b04-bb68-4868-b995-98388fa33e16
029a4f16-08d9-45ff-b452-dee34d382d05	25893b4a-38af-4d88-bb07-27f7d6011ce3	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:17.447-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.379-05	06169b04-bb68-4868-b995-98388fa33e16
791bba95-1037-4cc8-9ed1-618ab8820a6d	fb198851-cd6a-40bc-97d0-630a6ed4dec2	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:17.669-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.615-05	06169b04-bb68-4868-b995-98388fa33e16
9b7d3b74-7d3a-4ba5-9f14-81d604fefffe	65b99a1a-a853-47f7-bdf8-104f76aaab22	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:17.934-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.792-05	06169b04-bb68-4868-b995-98388fa33e16
185f97c1-ee87-400f-a8b2-9095155f9fd8	21909320-9ec5-45ee-81db-c28dc82e3a3b	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:17.941-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.834-05	06169b04-bb68-4868-b995-98388fa33e16
e4ff7331-c244-4f27-91bf-d0db68ff9680	73b6c3ea-559e-4bc0-88e7-0e20730e2455	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:18.007-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.89-05	06169b04-bb68-4868-b995-98388fa33e16
1f0f482f-89ed-411f-87f2-4533c396cfaa	b726191f-70d5-4e53-bb28-b9d225efdbcb	b7d6b366-415b-49ec-93ee-8883df61c23e	\N	\N	1	0	2015-01-31 00:49:18.034-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 00:49:17.957-05	06169b04-bb68-4868-b995-98388fa33e16
389f9a08-1003-412b-ac53-89abfaa696d7	65b99a1a-a853-47f7-bdf8-104f76aaab22	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.685-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.466-05	06169b04-bb68-4868-b995-98388fa33e16
31118765-2756-4de7-807c-d3b6ced410d9	73b6c3ea-559e-4bc0-88e7-0e20730e2455	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.683-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.502-05	06169b04-bb68-4868-b995-98388fa33e16
6212cce3-297e-4a57-af19-6bc28cefa856	21909320-9ec5-45ee-81db-c28dc82e3a3b	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.697-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.582-05	06169b04-bb68-4868-b995-98388fa33e16
570a81ec-6bf9-4e87-ac4a-4e516423b820	b726191f-70d5-4e53-bb28-b9d225efdbcb	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.703-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.542-05	06169b04-bb68-4868-b995-98388fa33e16
ba9c859e-88c4-4819-bc2b-6b3139396326	fe759c88-d7ce-4340-be48-081167e21453	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.873-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.753-05	06169b04-bb68-4868-b995-98388fa33e16
31a14d0e-60cd-4ffa-8d57-fcf76f52448a	25893b4a-38af-4d88-bb07-27f7d6011ce3	487abb23-fdfb-410f-9a13-72d941a6a95e	\N	\N	1	0	2015-01-31 10:31:16.878-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 10:31:16.795-05	06169b04-bb68-4868-b995-98388fa33e16
1c3784ef-c821-47a7-9efa-7c89762dc418	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	88520d3f-c1b1-493e-b7a6-2c6e54f5dc7c	\N	\N	1	0	2015-01-31 11:11:34.516-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:34.425-05	06169b04-bb68-4868-b995-98388fa33e16
0eaaa6b8-b741-4d6d-883b-2974196a6cb2	e868ee90-8a90-4aec-88e3-00365cf64a94	88520d3f-c1b1-493e-b7a6-2c6e54f5dc7c	\N	\N	1	0	2015-01-31 11:11:34.534-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:34.481-05	06169b04-bb68-4868-b995-98388fa33e16
30ae50d1-48a2-47e9-96e9-518df6e5568e	18362ca7-9064-4bdb-a289-edf087cac828	88520d3f-c1b1-493e-b7a6-2c6e54f5dc7c	\N	\N	1	0	2015-01-31 11:11:35.006-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:34.905-05	06169b04-bb68-4868-b995-98388fa33e16
f5920229-1585-453e-8f70-74e544433d03	5ace29a1-0b40-4ec3-9084-26b98b410a80	88520d3f-c1b1-493e-b7a6-2c6e54f5dc7c	\N	\N	1	0	2015-01-31 11:11:35.024-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:11:34.959-05	06169b04-bb68-4868-b995-98388fa33e16
746abb46-0f3f-4e8c-8e2d-cd279098ce40	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	72abc66a-1639-4324-bc2a-a8369ed3a793	\N	\N	1	0	2015-01-31 11:54:48.947-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:54:48.864-05	06169b04-bb68-4868-b995-98388fa33e16
9585ffcc-eed9-4b75-9ea9-4ddafdc6d09c	e868ee90-8a90-4aec-88e3-00365cf64a94	72abc66a-1639-4324-bc2a-a8369ed3a793	\N	\N	1	0	2015-01-31 11:54:48.992-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:54:48.907-05	06169b04-bb68-4868-b995-98388fa33e16
8be15873-6073-43b3-802d-9512ca3229dd	18362ca7-9064-4bdb-a289-edf087cac828	72abc66a-1639-4324-bc2a-a8369ed3a793	\N	\N	1	0	2015-01-31 11:54:49.007-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:54:48.953-05	06169b04-bb68-4868-b995-98388fa33e16
b72b2901-5662-44c4-befa-60c6cc56ef7c	5ace29a1-0b40-4ec3-9084-26b98b410a80	72abc66a-1639-4324-bc2a-a8369ed3a793	\N	\N	1	0	2015-01-31 11:54:49.066-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:54:49.011-05	06169b04-bb68-4868-b995-98388fa33e16
9f12c2d0-b817-4ebd-ad0d-f00025315dea	8375c3b0-7da7-4c0a-8f44-15c5ed645010	57049c5d-0f18-4787-99d0-9edea2d8fb5b	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	\N	1	0	2015-02-02 13:36:04.411-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:36:04.317-05	1676623f-4657-410f-87b6-db11cf461ba9
407c4c72-819c-4bd2-9aeb-f095f3e528d3	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	eb0a14dc-48a1-4ce8-b06c-68eb44d32032	\N	\N	1	0	2015-02-02 18:46:56.013-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:55.898-05	06169b04-bb68-4868-b995-98388fa33e16
1620d411-8b08-4b24-910b-73903f016578	eb970c6a-8430-4422-a233-032fea8ce39c	9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	\N	\N	1	0	2015-01-31 11:58:33.443-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:33.191-05	06169b04-bb68-4868-b995-98388fa33e16
e340fcf6-c672-4ded-9057-f76928a98d50	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	\N	\N	1	0	2015-01-31 11:58:33.449-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:33.281-05	06169b04-bb68-4868-b995-98388fa33e16
6e81b78f-d276-48d6-8ac1-72f83bf4e4e3	fe759c88-d7ce-4340-be48-081167e21453	9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	\N	\N	1	0	2015-01-31 11:58:33.453-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:33.241-05	06169b04-bb68-4868-b995-98388fa33e16
259be912-b3f5-443f-afcd-eaeda031e715	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	\N	\N	1	0	2015-01-31 11:58:33.462-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:33.326-05	06169b04-bb68-4868-b995-98388fa33e16
b6d3aa5a-e08f-46df-98f2-df601b81b3a3	25893b4a-38af-4d88-bb07-27f7d6011ce3	9f61ddac-0b33-4857-9496-6c7eb3a7a2b9	\N	\N	1	0	2015-01-31 11:58:33.483-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:33.378-05	06169b04-bb68-4868-b995-98388fa33e16
5f5c3053-84cc-424d-99ba-7cc2dfb1e8db	b7475b4a-6613-466d-b099-8708d527b55f	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:58:50.207-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:50.082-05	06169b04-bb68-4868-b995-98388fa33e16
0b284f73-c706-4e5e-b50e-6305de13d71c	5ace29a1-0b40-4ec3-9084-26b98b410a80	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:58:50.369-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:50.23-05	06169b04-bb68-4868-b995-98388fa33e16
78a038ce-674f-4444-90d3-41bec04e89c2	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:58:52.778-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:52.653-05	06169b04-bb68-4868-b995-98388fa33e16
a41b07e3-9ccf-4f01-a262-f2e2cfe3ad14	18362ca7-9064-4bdb-a289-edf087cac828	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:58:52.86-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:58:52.697-05	06169b04-bb68-4868-b995-98388fa33e16
fc1599d2-5dbe-4f44-8bb0-248c7fa80697	afabc446-9a56-4b18-8386-141cfbb34a48	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.061-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:03.915-05	06169b04-bb68-4868-b995-98388fa33e16
ae6f36b4-3645-44c8-a5c2-22af6c601388	fb198851-cd6a-40bc-97d0-630a6ed4dec2	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.066-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:03.958-05	06169b04-bb68-4868-b995-98388fa33e16
7e1cf0eb-f994-4451-8e9e-d3ffd29911a7	65b99a1a-a853-47f7-bdf8-104f76aaab22	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.118-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.013-05	06169b04-bb68-4868-b995-98388fa33e16
0978be7f-370e-4c31-ba50-6989294e7ed5	73b6c3ea-559e-4bc0-88e7-0e20730e2455	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.174-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.078-05	06169b04-bb68-4868-b995-98388fa33e16
e8e61cc9-1656-4ce2-b884-b3007c822d04	b726191f-70d5-4e53-bb28-b9d225efdbcb	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.235-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.132-05	06169b04-bb68-4868-b995-98388fa33e16
5dd4d4ad-ad56-4b4d-8c4c-80475196ca25	21909320-9ec5-45ee-81db-c28dc82e3a3b	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.248-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.184-05	06169b04-bb68-4868-b995-98388fa33e16
23f8a94e-74c0-4c51-99b3-4b6cc2dff152	fe759c88-d7ce-4340-be48-081167e21453	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.402-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.252-05	06169b04-bb68-4868-b995-98388fa33e16
bd8b624c-a43a-4a31-a353-3461499d086e	25893b4a-38af-4d88-bb07-27f7d6011ce3	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:04.404-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:04.302-05	06169b04-bb68-4868-b995-98388fa33e16
94c530fe-b43e-4cf3-ae03-94683d917492	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:21.193-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:20.954-05	06169b04-bb68-4868-b995-98388fa33e16
ea87e4ed-e870-4a39-9fd3-bce5cd175a03	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:21.207-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:20.998-05	06169b04-bb68-4868-b995-98388fa33e16
96a63921-f139-4795-9231-9c20d1af2cab	80881761-08a2-4d02-ae1e-287610944eeb	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 11:59:21.254-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:59:21.043-05	06169b04-bb68-4868-b995-98388fa33e16
7eac32a9-6867-4cf2-b50a-58af06517ee9	e9d51055-8986-4190-a7ee-98a77dc268b0	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 12:00:28.062-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:00:27.878-05	06169b04-bb68-4868-b995-98388fa33e16
f3cdba5e-7aba-4993-82c8-b4d21d766143	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	a17dad94-2fff-4e2f-99a9-828f74954a25	\N	\N	1	0	2015-01-31 12:00:28.112-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:00:27.925-05	06169b04-bb68-4868-b995-98388fa33e16
bcabe1fa-ab29-4efd-a943-47d412c2ca17	ce780dbe-0148-4e67-b478-4fea4cb405fc	616bf2d4-a2c7-40aa-b906-1f52e429a29a	\N	\N	1	0	2015-02-03 00:21:38.255-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 00:21:38.186-05	06169b04-bb68-4868-b995-98388fa33e16
1b680b2e-c351-455e-a9fb-3808e5d861e3	fe759c88-d7ce-4340-be48-081167e21453	8a6cb4be-59ae-4fc5-afd7-490b6163172e	\N	\N	1	0	2015-01-31 12:09:59.572-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:09:59.453-05	06169b04-bb68-4868-b995-98388fa33e16
bee891d8-2c93-4a25-a258-cccedd345a75	e868ee90-8a90-4aec-88e3-00365cf64a94	8a6cb4be-59ae-4fc5-afd7-490b6163172e	\N	\N	1	0	2015-01-31 12:09:59.586-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:09:59.509-05	06169b04-bb68-4868-b995-98388fa33e16
b01b79c2-0f4a-4491-baa7-79f1364bea40	adf83d9f-8e37-40bd-b649-8eb4cb72b403	8a6cb4be-59ae-4fc5-afd7-490b6163172e	\N	\N	1	0	2015-01-31 12:09:59.811-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:09:59.725-05	06169b04-bb68-4868-b995-98388fa33e16
6d562bcd-35d9-43f3-bed7-36f3e6107493	eb970c6a-8430-4422-a233-032fea8ce39c	503c4aee-8cf3-4502-8cea-ff079a344456	\N	\N	1	0	2015-01-31 12:13:15.816-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:13:15.707-05	06169b04-bb68-4868-b995-98388fa33e16
7e980a31-b8db-40fd-896c-1cf3ae6d21fd	fe759c88-d7ce-4340-be48-081167e21453	503c4aee-8cf3-4502-8cea-ff079a344456	\N	\N	1	0	2015-01-31 12:13:15.832-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:13:15.769-05	06169b04-bb68-4868-b995-98388fa33e16
ba7bc432-356e-41b7-a2ed-0f5cb739b4a4	adf83d9f-8e37-40bd-b649-8eb4cb72b403	503c4aee-8cf3-4502-8cea-ff079a344456	\N	\N	1	0	2015-01-31 12:13:15.948-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:13:15.887-05	06169b04-bb68-4868-b995-98388fa33e16
24202805-b0db-4de2-a059-2880739ac95a	e868ee90-8a90-4aec-88e3-00365cf64a94	503c4aee-8cf3-4502-8cea-ff079a344456	\N	\N	1	0	2015-01-31 12:13:15.953-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:13:15.839-05	06169b04-bb68-4868-b995-98388fa33e16
8cd4dbce-2dcd-4324-9bef-6073c2a3e880	18362ca7-9064-4bdb-a289-edf087cac828	ad5cf86f-48c8-4d2d-8fd9-e16ac752eac4	\N	\N	1	0	2015-02-03 11:29:41.62-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:41.457-05	4398be50-e6ac-4662-8598-3783af2fa4f3
a34ab9ef-5f4d-4273-9196-c99cb8ec57df	e868ee90-8a90-4aec-88e3-00365cf64a94	19f59ca9-5b57-4479-95ce-8a849984f843	\N	\N	1	1	2015-02-03 13:03:12.579-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:30:21.595-05	06169b04-bb68-4868-b995-98388fa33e16
35e5d7b5-10b4-453d-9c5b-3a519acab9fb	b7475b4a-6613-466d-b099-8708d527b55f	8a69db9e-1eb9-4057-8b91-0a77f055e871	\N	\N	1	0	2015-02-03 18:10:29.815-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:29.761-05	06169b04-bb68-4868-b995-98388fa33e16
54388d05-8068-4021-ba44-7d9431b9d87d	80881761-08a2-4d02-ae1e-287610944eeb	317d5df2-69f1-42ef-b01a-86190f0e26e9	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	\N	1	2	2015-02-03 15:21:34.727-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:26:51.304-05	06169b04-bb68-4868-b995-98388fa33e16
1c3091bc-ce5a-4c6a-b0e5-67d9c366c666	18362ca7-9064-4bdb-a289-edf087cac828	8a69db9e-1eb9-4057-8b91-0a77f055e871	3d029a3f-177f-4113-bb37-e9310c8a4421	\N	1	0	2015-02-03 18:10:30.357-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:30.265-05	06169b04-bb68-4868-b995-98388fa33e16
8b0d4419-2e3a-488f-9c68-7850e82c819b	ddaba673-2c58-47b5-99ef-dc31fe5285d3	ec5649a3-c036-467d-bd2d-5e28a74b83aa	\N	\N	1	0	2015-01-31 17:33:40.732-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 17:33:40.668-05	06169b04-bb68-4868-b995-98388fa33e16
793a7fb0-07a1-47fd-b500-92ef392b6e95	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	1ec083c0-eb98-4570-8e4c-dfbc66f83dd3	\N	\N	1	0	2015-01-31 13:06:40.084-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.928-05	06169b04-bb68-4868-b995-98388fa33e16
8537db06-02b2-4309-bd66-a17f8907d6b3	80881761-08a2-4d02-ae1e-287610944eeb	1ec083c0-eb98-4570-8e4c-dfbc66f83dd3	\N	\N	1	0	2015-01-31 13:06:40.091-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.993-05	06169b04-bb68-4868-b995-98388fa33e16
eb4a570d-df26-4946-9fa7-581f73b2ee6d	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	1ec083c0-eb98-4570-8e4c-dfbc66f83dd3	\N	\N	1	0	2015-01-31 13:06:40.096-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.961-05	06169b04-bb68-4868-b995-98388fa33e16
a2b8afa6-61c7-477d-96da-6808ef2547d1	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	1ec083c0-eb98-4570-8e4c-dfbc66f83dd3	\N	\N	1	0	2015-01-31 13:06:40.094-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:06:39.882-05	06169b04-bb68-4868-b995-98388fa33e16
6ba04da2-25b2-47e4-90d7-0bb8a8722177	18362ca7-9064-4bdb-a289-edf087cac828	ec5649a3-c036-467d-bd2d-5e28a74b83aa	\N	8411780d-a4cc-4852-809d-a394610680c4	1	0	2015-01-31 17:33:41.115-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 17:33:41.025-05	06169b04-bb68-4868-b995-98388fa33e16
feca7f6b-29a4-41e6-9397-e78a8b79363d	b7475b4a-6613-466d-b099-8708d527b55f	c6e52124-ead2-4df1-bd3f-857525ed4b38	\N	\N	1	0	2015-01-31 20:06:05.394-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:06:05.331-05	06169b04-bb68-4868-b995-98388fa33e16
b087c01c-861b-4dc1-8c6e-41dfe714d81a	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c6e52124-ead2-4df1-bd3f-857525ed4b38	\N	\N	1	0	2015-01-31 20:06:05.949-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:06:05.87-05	06169b04-bb68-4868-b995-98388fa33e16
b7814cd0-1622-4f69-8c08-3a449bc290d3	18362ca7-9064-4bdb-a289-edf087cac828	c6e52124-ead2-4df1-bd3f-857525ed4b38	\N	\N	1	0	2015-01-31 20:06:06.023-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:06:05.96-05	06169b04-bb68-4868-b995-98388fa33e16
7fad8a23-96d9-41ec-a4c0-081fc2a337ad	5ace29a1-0b40-4ec3-9084-26b98b410a80	c6e52124-ead2-4df1-bd3f-857525ed4b38	\N	\N	1	0	2015-01-31 20:06:06.154-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 20:06:06.094-05	06169b04-bb68-4868-b995-98388fa33e16
b068c330-470b-45b3-876f-d71596be7631	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	b713eaa5-1287-403e-8ffd-37a4337ae940	\N	\N	1	0	2015-02-03 18:26:07.755-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:26:07.664-05	06169b04-bb68-4868-b995-98388fa33e16
86913865-049e-4724-bb61-3d8ebcfac524	fe759c88-d7ce-4340-be48-081167e21453	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:01:59.737-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.642-05	06169b04-bb68-4868-b995-98388fa33e16
42a4cd7c-932a-439d-8e27-f40dc2fcd9d9	5ace29a1-0b40-4ec3-9084-26b98b410a80	ec5649a3-c036-467d-bd2d-5e28a74b83aa	\N	\N	1	0	2015-01-31 17:33:41.123-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 17:33:40.949-05	06169b04-bb68-4868-b995-98388fa33e16
cee9cd21-de0b-4cc2-97dd-bfb92fe021db	400dd88c-8266-4311-9a9f-5073977ff64c	ec5649a3-c036-467d-bd2d-5e28a74b83aa	\N	\N	1	0	2015-01-31 17:33:41.125-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 17:33:40.99-05	06169b04-bb68-4868-b995-98388fa33e16
2d4fe944-8164-4297-b851-bf871eeb2660	21909320-9ec5-45ee-81db-c28dc82e3a3b	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.114-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.943-05	06169b04-bb68-4868-b995-98388fa33e16
b93da99f-40f7-4afd-ab70-f5c70259e531	47bfb33c-9dae-4315-a57e-a904072e6d08	d6df39dd-5ff8-47dd-ac20-0fc0b244c072	\N	\N	1	1	2015-02-03 14:18:21.141-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:28.946-05	06169b04-bb68-4868-b995-98388fa33e16
1546e431-dfec-49a9-a51a-a87471795485	47bfb33c-9dae-4315-a57e-a904072e6d08	57049c5d-0f18-4787-99d0-9edea2d8fb5b	\N	\N	1	0	2015-02-02 13:36:04.419-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:36:04.283-05	1676623f-4657-410f-87b6-db11cf461ba9
fbd81e72-8fcc-4754-8d11-692b9f9d1fe5	25893b4a-38af-4d88-bb07-27f7d6011ce3	eb0a14dc-48a1-4ce8-b06c-68eb44d32032	\N	\N	1	0	2015-02-02 18:46:56.018-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:55.941-05	06169b04-bb68-4868-b995-98388fa33e16
0f549ae9-ccb8-4f38-96bb-7ed05e68c42f	e9d51055-8986-4190-a7ee-98a77dc268b0	99a76f23-761b-4b02-96dd-03589218b200	\N	\N	1	0	2015-02-02 23:51:47.306-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 23:51:47.24-05	06169b04-bb68-4868-b995-98388fa33e16
0b437074-4c1b-47ae-bd97-3c687962fadd	b7475b4a-6613-466d-b099-8708d527b55f	ad5cf86f-48c8-4d2d-8fd9-e16ac752eac4	\N	\N	1	0	2015-02-03 11:29:41.607-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:41.353-05	4398be50-e6ac-4662-8598-3783af2fa4f3
48e5782f-e8e6-4a68-8aae-55586696a4c4	5ace29a1-0b40-4ec3-9084-26b98b410a80	ad5cf86f-48c8-4d2d-8fd9-e16ac752eac4	\N	\N	1	0	2015-02-03 11:29:41.623-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:41.499-05	4398be50-e6ac-4662-8598-3783af2fa4f3
d012d7f7-a5c3-425e-bea1-9dc5f126a301	8375c3b0-7da7-4c0a-8f44-15c5ed645010	19f59ca9-5b57-4479-95ce-8a849984f843	\N	\N	1	1	2015-02-03 13:03:12.586-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:30:21.596-05	06169b04-bb68-4868-b995-98388fa33e16
54b45482-9af0-4cc9-ae2c-a3fc177b31d8	73b6c3ea-559e-4bc0-88e7-0e20730e2455	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.545-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.33-05	06169b04-bb68-4868-b995-98388fa33e16
ee333015-1595-445c-b7bf-44cb8e4d5776	ce780dbe-0148-4e67-b478-4fea4cb405fc	14674887-db2a-43ef-b8bd-790019cb8994	\N	\N	1	1	2015-02-03 15:21:34.735-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:23:53.105-05	06169b04-bb68-4868-b995-98388fa33e16
22440622-3233-4e8b-8bea-c4247e6f1b89	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	317d5df2-69f1-42ef-b01a-86190f0e26e9	\N	\N	1	2	2015-02-03 15:21:34.317-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:26:51.308-05	06169b04-bb68-4868-b995-98388fa33e16
f7db4351-9697-4556-9b48-ac3afb28c4d1	5ace29a1-0b40-4ec3-9084-26b98b410a80	8a69db9e-1eb9-4057-8b91-0a77f055e871	317718b3-ed23-4e10-b14f-2d30d181ed9c	8411780d-a4cc-4852-809d-a394610680c4	1	0	2015-02-03 18:10:30.35-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:30.236-05	06169b04-bb68-4868-b995-98388fa33e16
8b12cc70-0178-444f-ad7f-00dd5bc5bd60	b7475b4a-6613-466d-b099-8708d527b55f	b713eaa5-1287-403e-8ffd-37a4337ae940	\N	\N	1	0	2015-02-03 18:26:07.253-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:26:07.179-05	06169b04-bb68-4868-b995-98388fa33e16
2a412c0e-16dc-427b-bd51-f54db764e1ac	5ace29a1-0b40-4ec3-9084-26b98b410a80	b713eaa5-1287-403e-8ffd-37a4337ae940	\N	\N	1	0	2015-02-03 18:26:07.766-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:26:07.583-05	06169b04-bb68-4868-b995-98388fa33e16
83788dce-6a4a-47cb-b529-9aaf119ffd9e	b7475b4a-6613-466d-b099-8708d527b55f	05222b7c-583b-49ef-88aa-a62c50e50502	\N	\N	1	0	2015-02-01 15:38:47.928-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:47.771-05	1676623f-4657-410f-87b6-db11cf461ba9
579abdd2-f984-490b-97cd-a2ac71d9e94b	18362ca7-9064-4bdb-a289-edf087cac828	05222b7c-583b-49ef-88aa-a62c50e50502	\N	\N	1	0	2015-02-01 15:38:47.944-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:47.835-05	1676623f-4657-410f-87b6-db11cf461ba9
f92be904-ce24-4f35-8c11-7e18efec7472	fb198851-cd6a-40bc-97d0-630a6ed4dec2	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.073-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.882-05	06169b04-bb68-4868-b995-98388fa33e16
822de4b4-27a7-42d6-b9c4-17b586dc3661	25893b4a-38af-4d88-bb07-27f7d6011ce3	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.116-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:02:00.003-05	06169b04-bb68-4868-b995-98388fa33e16
b9ec74f7-d93b-444b-b03d-2ad0b214ca04	73b6c3ea-559e-4bc0-88e7-0e20730e2455	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.124-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.844-05	06169b04-bb68-4868-b995-98388fa33e16
fe08d919-6aa3-40e5-81b3-440a235e4e4d	80881761-08a2-4d02-ae1e-287610944eeb	9725dd02-2d64-44c4-835f-860097536f3a	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	1	2015-02-04 16:18:33.312-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:20:53.4-05	06169b04-bb68-4868-b995-98388fa33e16
34cb9882-8046-4626-a05d-f08b1922a6b5	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	9725dd02-2d64-44c4-835f-860097536f3a	\N	\N	1	1	2015-02-04 16:18:33.32-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:20:53.407-05	06169b04-bb68-4868-b995-98388fa33e16
819f1d64-6478-4a16-89b2-150b74cc3e24	fe759c88-d7ce-4340-be48-081167e21453	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:49.415-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:49.338-05	06169b04-bb68-4868-b995-98388fa33e16
15f4d52c-c07a-4c59-96fe-e1e96a922270	21909320-9ec5-45ee-81db-c28dc82e3a3b	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:50.606-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:50.485-05	06169b04-bb68-4868-b995-98388fa33e16
ebb32b2b-d12f-4eb0-9136-b2734c563cf6	73b6c3ea-559e-4bc0-88e7-0e20730e2455	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:50.804-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:50.742-05	06169b04-bb68-4868-b995-98388fa33e16
322bc783-0cdd-4713-8a82-53cfd70444b5	fb198851-cd6a-40bc-97d0-630a6ed4dec2	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:51.718-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:51.608-05	06169b04-bb68-4868-b995-98388fa33e16
635c4a95-1f5d-4fae-ba31-852feb5d9074	fe759c88-d7ce-4340-be48-081167e21453	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.514-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.449-05	06169b04-bb68-4868-b995-98388fa33e16
ded3c5a8-c267-472c-bb01-8eda951eb0dd	73b6c3ea-559e-4bc0-88e7-0e20730e2455	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.946-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.772-05	06169b04-bb68-4868-b995-98388fa33e16
6588c16b-1b54-418c-9ea0-d2cdc07bf512	65b99a1a-a853-47f7-bdf8-104f76aaab22	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.973-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.731-05	06169b04-bb68-4868-b995-98388fa33e16
208100f0-90ff-4c5b-b212-e89811b7ddd5	b726191f-70d5-4e53-bb28-b9d225efdbcb	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.979-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.858-05	06169b04-bb68-4868-b995-98388fa33e16
98be5a9e-bb2f-41b9-9c8b-6018830d3228	400dd88c-8266-4311-9a9f-5073977ff64c	9a1ba24a-3182-472f-ab05-069779282fac	\N	\N	1	0	2015-02-04 20:22:27.501-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 20:22:27.329-05	06169b04-bb68-4868-b995-98388fa33e16
cf63468c-3029-41c1-9701-f49efa65d390	5ace29a1-0b40-4ec3-9084-26b98b410a80	9a1ba24a-3182-472f-ab05-069779282fac	\N	\N	1	0	2015-02-04 20:22:27.511-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 20:22:27.397-05	06169b04-bb68-4868-b995-98388fa33e16
86b29ef2-5b88-42b9-8702-189ae4b51b1e	e9d51055-8986-4190-a7ee-98a77dc268b0	24382365-77bd-40d9-aecd-319a594b52d8	\N	\N	1	0	2015-02-05 12:58:27.684-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:58:27.566-05	06169b04-bb68-4868-b995-98388fa33e16
5b40a23b-53f3-4097-9821-72e25a7636ff	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	\N	\N	1	0	2015-02-05 15:15:40.764-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:40.591-05	06169b04-bb68-4868-b995-98388fa33e16
ee45e908-47ad-4ac9-91e9-065738fe56c5	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	\N	\N	1	0	2015-02-05 15:15:40.776-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:40.625-05	06169b04-bb68-4868-b995-98388fa33e16
ebf4e244-52f6-4bdf-9629-00f22a4d3cd7	afabc446-9a56-4b18-8386-141cfbb34a48	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.017-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:09.931-05	06169b04-bb68-4868-b995-98388fa33e16
ebdb1841-cdea-4f8b-a39a-948db4c814db	b726191f-70d5-4e53-bb28-b9d225efdbcb	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.618-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.496-05	06169b04-bb68-4868-b995-98388fa33e16
2a6fdd43-9cfe-4c41-b1ac-08701f108600	fb198851-cd6a-40bc-97d0-630a6ed4dec2	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.605-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.405-05	06169b04-bb68-4868-b995-98388fa33e16
78cf0317-dbc2-44d6-812c-f5e7faf4dcd5	fb198851-cd6a-40bc-97d0-630a6ed4dec2	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.708-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.476-05	06169b04-bb68-4868-b995-98388fa33e16
6117326e-dee2-42f3-8d26-72149a5794ee	73b6c3ea-559e-4bc0-88e7-0e20730e2455	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.712-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.556-05	06169b04-bb68-4868-b995-98388fa33e16
38d0dd3a-48f4-49a5-bca6-83aa29477957	b726191f-70d5-4e53-bb28-b9d225efdbcb	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.731-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.587-05	06169b04-bb68-4868-b995-98388fa33e16
afa9ad5b-4f65-4d9a-84b9-15c7fe639cfa	fe759c88-d7ce-4340-be48-081167e21453	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.979-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.867-05	06169b04-bb68-4868-b995-98388fa33e16
a8b6cfdb-5aa3-4e89-bf3e-c9fa6224c91f	ce780dbe-0148-4e67-b478-4fea4cb405fc	37c31973-7a50-4c99-b447-60a19494415e	\N	\N	1	0	2015-02-06 13:13:19.949-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:13:19.877-05	06169b04-bb68-4868-b995-98388fa33e16
8b2e3abf-202b-4bd4-a18a-aa3651b21cf4	8375c3b0-7da7-4c0a-8f44-15c5ed645010	d6df39dd-5ff8-47dd-ac20-0fc0b244c072	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	\N	1	1	2015-02-03 14:18:20.977-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:28.935-05	06169b04-bb68-4868-b995-98388fa33e16
0c210c7e-9d02-4d89-a419-f8b83d11adf5	b910c68c-0ea3-4887-ad4a-f7313bd007e3	e97fc815-7289-4377-a907-13dd195c0123	\N	\N	1	0	2015-02-06 16:43:13.12-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6	2015-02-06 16:43:13.05-05	f7cd512f-819c-451b-89c8-d0c1d4a6e7c6
c99277cb-ca4f-4534-8d88-361ed77e49ec	47bfb33c-9dae-4315-a57e-a904072e6d08	4ca49e39-fc86-46aa-8afa-55a03ffa74bb	\N	\N	1	0	2015-02-07 08:17:27.379-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:27.227-05	4398be50-e6ac-4662-8598-3783af2fa4f3
3603f338-b3f8-43ac-9557-fa9ad941e6ac	8375c3b0-7da7-4c0a-8f44-15c5ed645010	4ca49e39-fc86-46aa-8afa-55a03ffa74bb	\N	\N	1	0	2015-02-07 08:17:27.383-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:27.273-05	4398be50-e6ac-4662-8598-3783af2fa4f3
6036b30e-7e8b-4383-a921-53fde7c8cca1	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	78b73e6e-b451-4aae-adce-b0c1cce82fce	\N	\N	1	0	2015-02-08 18:59:48.842-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.733-05	067b4635-5840-48fd-980d-ccddbe1b173d
98ca15ef-ac9d-43b5-945d-8bd200f957b4	5ace29a1-0b40-4ec3-9084-26b98b410a80	78b73e6e-b451-4aae-adce-b0c1cce82fce	\N	\N	1	0	2015-02-08 18:59:48.971-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.895-05	067b4635-5840-48fd-980d-ccddbe1b173d
d511905a-d1be-44ed-bce5-a25c1ae40d69	18362ca7-9064-4bdb-a289-edf087cac828	3bc26959-2344-4ed6-91ab-41e05d37b757	\N	\N	1	0	2015-02-08 19:01:23.639-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.535-05	067b4635-5840-48fd-980d-ccddbe1b173d
f8133a23-08c8-4b6f-8bd6-fcffd95fb8b2	b7475b4a-6613-466d-b099-8708d527b55f	3bc26959-2344-4ed6-91ab-41e05d37b757	\N	\N	1	0	2015-02-08 19:01:23.653-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.476-05	067b4635-5840-48fd-980d-ccddbe1b173d
9c2ac1d0-7e5e-4144-911d-4b4c3b88f2d5	e868ee90-8a90-4aec-88e3-00365cf64a94	bf3b0ddb-111a-4037-a1aa-04a94ca191f1	\N	\N	1	1	2015-02-08 19:20:12.98-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:21:18.81-05	067b4635-5840-48fd-980d-ccddbe1b173d
1f052072-9016-478b-8ee8-e09d789ae309	47bfb33c-9dae-4315-a57e-a904072e6d08	bf3b0ddb-111a-4037-a1aa-04a94ca191f1	\N	\N	1	1	2015-02-08 19:20:12.96-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:21:18.84-05	067b4635-5840-48fd-980d-ccddbe1b173d
501abc14-c8e1-4cfe-ba0d-bd1f986ea6d0	47bfb33c-9dae-4315-a57e-a904072e6d08	26cb8f1a-5605-4add-aa7a-2447f17aa2f4	\N	\N	1	1	2015-02-08 19:20:57.901-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:28:24.943-05	067b4635-5840-48fd-980d-ccddbe1b173d
1f3195bd-4684-42bc-a084-bcf33e700d64	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	26cb8f1a-5605-4add-aa7a-2447f17aa2f4	\N	\N	1	1	2015-02-08 19:20:57.909-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:28:24.948-05	067b4635-5840-48fd-980d-ccddbe1b173d
b24a4005-7909-45df-9e00-24cc8024d9eb	65b99a1a-a853-47f7-bdf8-104f76aaab22	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.322-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.146-05	06169b04-bb68-4868-b995-98388fa33e16
3101b352-ffcd-4a38-83ee-19f19479a363	afabc446-9a56-4b18-8386-141cfbb34a48	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.332-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.187-05	06169b04-bb68-4868-b995-98388fa33e16
1f5428b1-04c7-4a8a-be6b-e6e423ef9692	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	57049c5d-0f18-4787-99d0-9edea2d8fb5b	\N	\N	1	0	2015-02-02 13:36:04.421-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:36:04.192-05	1676623f-4657-410f-87b6-db11cf461ba9
243f1b7a-ccd2-4870-a4bd-6cdded24d5f1	fe759c88-d7ce-4340-be48-081167e21453	eb0a14dc-48a1-4ce8-b06c-68eb44d32032	\N	\N	1	0	2015-02-02 18:46:56.098-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 18:46:56.045-05	06169b04-bb68-4868-b995-98388fa33e16
0f48d946-4cb1-4f7b-ac04-6b8acfa892a4	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	99a76f23-761b-4b02-96dd-03589218b200	\N	\N	1	0	2015-02-02 23:51:47.38-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-02 23:51:47.335-05	06169b04-bb68-4868-b995-98388fa33e16
78adcfe6-c49d-4213-997b-d6934b383431	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	ad5cf86f-48c8-4d2d-8fd9-e16ac752eac4	\N	\N	1	0	2015-02-03 11:29:41.618-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-03 11:29:41.421-05	4398be50-e6ac-4662-8598-3783af2fa4f3
1fac8a56-0b86-40ea-8127-18fa51878681	47bfb33c-9dae-4315-a57e-a904072e6d08	19f59ca9-5b57-4479-95ce-8a849984f843	\N	\N	1	1	2015-02-03 13:03:12.588-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:30:21.572-05	06169b04-bb68-4868-b995-98388fa33e16
6fc6ccb4-e4b8-476f-99a1-2878e70983dd	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	19f59ca9-5b57-4479-95ce-8a849984f843	\N	\N	1	1	2015-02-03 13:03:10.401-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 13:30:21.599-05	06169b04-bb68-4868-b995-98388fa33e16
728cc562-9a54-4ad9-a462-5558a3e642fc	fe759c88-d7ce-4340-be48-081167e21453	b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	\N	\N	1	0	2015-02-05 15:15:40.779-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:40.553-05	06169b04-bb68-4868-b995-98388fa33e16
6a9c4257-e196-4537-9fee-1e6453e4db10	25893b4a-38af-4d88-bb07-27f7d6011ce3	b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	\N	\N	1	0	2015-02-05 15:15:40.773-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:40.656-05	06169b04-bb68-4868-b995-98388fa33e16
aa11b80f-bc32-4b58-8721-dc1ff2fa1c35	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	317d5df2-69f1-42ef-b01a-86190f0e26e9	\N	\N	1	2	2015-02-03 15:21:34.331-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:26:50.863-05	06169b04-bb68-4868-b995-98388fa33e16
f1374800-b3bd-467d-9302-a2a3e8980d38	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	317d5df2-69f1-42ef-b01a-86190f0e26e9	\N	\N	1	2	2015-02-03 15:21:34.742-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 17:26:51.376-05	06169b04-bb68-4868-b995-98388fa33e16
4e6ecad8-d827-40ec-91d5-3f804dfdfcc0	b910c68c-0ea3-4887-ad4a-f7313bd007e3	e6dbf64a-654d-45d2-aa5e-92f2e22a809a	\N	\N	1	0	2015-02-01 15:38:37.401-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:37.334-05	1676623f-4657-410f-87b6-db11cf461ba9
90ad0220-cb89-4204-b7cd-502ad56fa2ce	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	05222b7c-583b-49ef-88aa-a62c50e50502	\N	\N	1	0	2015-02-01 15:38:47.936-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:47.808-05	1676623f-4657-410f-87b6-db11cf461ba9
0a730a0b-8e01-47e6-bda8-024d00b6fdd3	5ace29a1-0b40-4ec3-9084-26b98b410a80	05222b7c-583b-49ef-88aa-a62c50e50502	\N	\N	1	0	2015-02-01 15:38:47.946-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-01 15:38:47.862-05	1676623f-4657-410f-87b6-db11cf461ba9
17487954-174d-474d-b41b-fc9ed013986f	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	8a69db9e-1eb9-4057-8b91-0a77f055e871	\N	\N	1	0	2015-02-03 18:10:30.354-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:10:30.202-05	06169b04-bb68-4868-b995-98388fa33e16
691163dd-e12c-4880-8fca-3ecd07b01f6c	18362ca7-9064-4bdb-a289-edf087cac828	b713eaa5-1287-403e-8ffd-37a4337ae940	\N	\N	1	0	2015-02-03 18:26:07.742-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-03 18:26:07.63-05	06169b04-bb68-4868-b995-98388fa33e16
4133bd72-4ad7-423f-b852-61355b608b4a	afabc446-9a56-4b18-8386-141cfbb34a48	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:01:59.467-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.402-05	06169b04-bb68-4868-b995-98388fa33e16
43bdde96-e70c-4e33-9cc9-f62592e4952d	65b99a1a-a853-47f7-bdf8-104f76aaab22	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.109-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.973-05	06169b04-bb68-4868-b995-98388fa33e16
c8e76909-af16-41f9-acdc-a88c6621f6e4	b726191f-70d5-4e53-bb28-b9d225efdbcb	a2186005-fca9-47ea-90b2-0f67d9b80cba	\N	\N	1	0	2015-02-04 15:02:00.121-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 15:01:59.912-05	06169b04-bb68-4868-b995-98388fa33e16
b209c660-a1ad-448c-814c-e288c0ae1d27	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9725dd02-2d64-44c4-835f-860097536f3a	\N	\N	1	1	2015-02-04 16:18:32.799-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:20:52.905-05	06169b04-bb68-4868-b995-98388fa33e16
3c38f88c-c851-43a0-9bce-9521db11f44a	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	9725dd02-2d64-44c4-835f-860097536f3a	\N	\N	1	1	2015-02-04 16:18:33.317-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 16:20:53.405-05	06169b04-bb68-4868-b995-98388fa33e16
3f33e4a0-9d6f-42fa-9c60-526e0c03a837	afabc446-9a56-4b18-8386-141cfbb34a48	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:49.082-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:49.011-05	06169b04-bb68-4868-b995-98388fa33e16
12719c80-d61f-4979-a812-2acc2c65612e	25893b4a-38af-4d88-bb07-27f7d6011ce3	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:50.428-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:50.363-05	06169b04-bb68-4868-b995-98388fa33e16
be3469c8-6b70-44f1-9871-7367e88c46e5	b726191f-70d5-4e53-bb28-b9d225efdbcb	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:50.611-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:50.525-05	06169b04-bb68-4868-b995-98388fa33e16
796dc04a-aaa5-4308-95f4-62cf903e552e	65b99a1a-a853-47f7-bdf8-104f76aaab22	c89c198e-72c0-4ecb-9903-72748195d35c	\N	\N	1	0	2015-02-04 17:53:51.708-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 17:53:51.642-05	06169b04-bb68-4868-b995-98388fa33e16
bebfe065-f04a-40e3-b40c-41601ae0faa8	afabc446-9a56-4b18-8386-141cfbb34a48	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.314-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.25-05	06169b04-bb68-4868-b995-98388fa33e16
9b4b37d4-af55-4af5-ad7f-d64324280ee3	25893b4a-38af-4d88-bb07-27f7d6011ce3	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.719-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.65-05	06169b04-bb68-4868-b995-98388fa33e16
554067f3-524c-45dd-922d-fbf82fd631e3	fb198851-cd6a-40bc-97d0-630a6ed4dec2	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.967-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.801-05	06169b04-bb68-4868-b995-98388fa33e16
3a47034a-6847-4c2d-bbcd-826e2f4282dd	21909320-9ec5-45ee-81db-c28dc82e3a3b	84e894b3-9466-4499-9d55-c624b7098051	\N	\N	1	0	2015-02-04 18:54:03.975-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 18:54:03.829-05	06169b04-bb68-4868-b995-98388fa33e16
f458caa8-1fc9-4d9c-bfc3-4545f160c8d0	ddaba673-2c58-47b5-99ef-dc31fe5285d3	9a1ba24a-3182-472f-ab05-069779282fac	\N	\N	1	0	2015-02-04 20:22:27.006-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 20:22:26.931-05	06169b04-bb68-4868-b995-98388fa33e16
1965745b-2f3b-4021-b4cb-d8f5ebc1aaa5	18362ca7-9064-4bdb-a289-edf087cac828	9a1ba24a-3182-472f-ab05-069779282fac	\N	\N	1	0	2015-02-04 20:22:27.508-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-04 20:22:27.367-05	06169b04-bb68-4868-b995-98388fa33e16
f7478704-04ff-44d7-97e5-7c833ba42fe0	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	24382365-77bd-40d9-aecd-319a594b52d8	\N	\N	1	0	2015-02-05 12:58:27.677-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 12:58:27.602-05	06169b04-bb68-4868-b995-98388fa33e16
989b4238-6d93-4f77-a03b-f7c56f495ed9	eb970c6a-8430-4422-a233-032fea8ce39c	b22ad2d0-38c8-49e5-9ce3-ba28ae71c3b5	\N	\N	1	0	2015-02-05 15:15:40.439-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 15:15:40.377-05	06169b04-bb68-4868-b995-98388fa33e16
fa664d62-9e57-4a49-bf6d-aa0704bf99da	fe759c88-d7ce-4340-be48-081167e21453	ef312753-3ca8-4898-96c9-8fc5b8b0343c	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	0	2015-02-05 17:02:10.233-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.172-05	06169b04-bb68-4868-b995-98388fa33e16
ed2592c9-67cb-4f7d-bed6-b79a779ebedf	25893b4a-38af-4d88-bb07-27f7d6011ce3	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.61-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.432-05	06169b04-bb68-4868-b995-98388fa33e16
fe186b48-448b-4b56-bdac-2b963aeecd35	21909320-9ec5-45ee-81db-c28dc82e3a3b	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.614-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.377-05	06169b04-bb68-4868-b995-98388fa33e16
a3bb4ad2-249b-4335-9c4b-e68e9abe78dd	65b99a1a-a853-47f7-bdf8-104f76aaab22	ef312753-3ca8-4898-96c9-8fc5b8b0343c	\N	\N	1	0	2015-02-05 17:02:10.616-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 17:02:10.466-05	06169b04-bb68-4868-b995-98388fa33e16
c9f3e7b6-53ab-4d79-9b76-bcf8f8dbc07d	65b99a1a-a853-47f7-bdf8-104f76aaab22	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.71-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.526-05	06169b04-bb68-4868-b995-98388fa33e16
cf95f1f0-0bca-477a-aa7e-da37f31f717a	21909320-9ec5-45ee-81db-c28dc82e3a3b	9a1f2393-6e4b-4606-b1e1-59249aaedd52	43b00210-057e-471b-bbe3-0db78944e7ef	\N	1	0	2015-02-06 11:46:44.726-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.617-05	06169b04-bb68-4868-b995-98388fa33e16
4a7ef525-afac-48f6-b993-8c5096cb95f2	afabc446-9a56-4b18-8386-141cfbb34a48	9a1f2393-6e4b-4606-b1e1-59249aaedd52	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	\N	1	0	2015-02-06 11:46:44.737-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.428-05	06169b04-bb68-4868-b995-98388fa33e16
8c0b7dda-ee98-4112-96e8-dd0a70ddebf0	25893b4a-38af-4d88-bb07-27f7d6011ce3	9a1f2393-6e4b-4606-b1e1-59249aaedd52	\N	\N	1	0	2015-02-06 11:46:44.986-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 11:46:44.905-05	06169b04-bb68-4868-b995-98388fa33e16
d7b08fe7-c897-4f5b-a488-f9beeef27452	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d6df39dd-5ff8-47dd-ac20-0fc0b244c072	17da0238-3d93-4270-bc02-256f45963ee6	\N	1	1	2015-02-03 14:18:19.786-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:28.429-05	06169b04-bb68-4868-b995-98388fa33e16
3d30ad0d-8e3b-4cbc-8254-36a779f155fe	e868ee90-8a90-4aec-88e3-00365cf64a94	d6df39dd-5ff8-47dd-ac20-0fc0b244c072	\N	\N	1	1	2015-02-03 14:18:20.982-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 13:14:28.948-05	06169b04-bb68-4868-b995-98388fa33e16
d039e1a3-0c5e-46e7-bd7b-775c9285ea7b	e868ee90-8a90-4aec-88e3-00365cf64a94	4ca49e39-fc86-46aa-8afa-55a03ffa74bb	\N	\N	1	0	2015-02-07 08:17:27.362-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:27.183-05	4398be50-e6ac-4662-8598-3783af2fa4f3
89d355be-33ab-4ab9-a4bb-c21971861d6b	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	4ca49e39-fc86-46aa-8afa-55a03ffa74bb	\N	\N	1	0	2015-02-07 08:17:27.391-05	4398be50-e6ac-4662-8598-3783af2fa4f3	2015-02-07 08:17:27.131-05	4398be50-e6ac-4662-8598-3783af2fa4f3
b34c0daf-3dd6-44ca-bd62-b46a1f6e6a7c	b7475b4a-6613-466d-b099-8708d527b55f	78b73e6e-b451-4aae-adce-b0c1cce82fce	\N	\N	1	0	2015-02-08 18:59:48.839-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.695-05	067b4635-5840-48fd-980d-ccddbe1b173d
af318b83-f5c5-4a2f-9389-dd8ee7ba19e8	18362ca7-9064-4bdb-a289-edf087cac828	78b73e6e-b451-4aae-adce-b0c1cce82fce	\N	\N	1	0	2015-02-08 18:59:48.966-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 18:59:48.858-05	067b4635-5840-48fd-980d-ccddbe1b173d
ed349051-467b-463a-8555-d05f71a751bc	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	3bc26959-2344-4ed6-91ab-41e05d37b757	\N	\N	1	0	2015-02-08 19:01:23.633-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.509-05	067b4635-5840-48fd-980d-ccddbe1b173d
32a87266-df70-44f3-98da-f41da92961cc	5ace29a1-0b40-4ec3-9084-26b98b410a80	3bc26959-2344-4ed6-91ab-41e05d37b757	\N	\N	1	0	2015-02-08 19:01:23.644-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:01:23.562-05	067b4635-5840-48fd-980d-ccddbe1b173d
ea15982d-1df4-469b-81fc-2b565dd0917e	8375c3b0-7da7-4c0a-8f44-15c5ed645010	bf3b0ddb-111a-4037-a1aa-04a94ca191f1	\N	\N	1	1	2015-02-08 19:20:12.971-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:21:18.835-05	067b4635-5840-48fd-980d-ccddbe1b173d
54040899-8fd4-41c9-8ca9-bdf813685c05	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	bf3b0ddb-111a-4037-a1aa-04a94ca191f1	\N	\N	1	1	2015-02-08 19:20:12.671-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:21:18.843-05	067b4635-5840-48fd-980d-ccddbe1b173d
0a2c3464-500b-4f7b-9c44-2e5ab868f7bd	e868ee90-8a90-4aec-88e3-00365cf64a94	26cb8f1a-5605-4add-aa7a-2447f17aa2f4	\N	\N	1	1	2015-02-08 19:20:57.884-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:28:24.923-05	067b4635-5840-48fd-980d-ccddbe1b173d
6eec4faf-b5df-4816-82f2-a26435e9ff34	8375c3b0-7da7-4c0a-8f44-15c5ed645010	26cb8f1a-5605-4add-aa7a-2447f17aa2f4	\N	\N	1	1	2015-02-08 19:20:57.903-05	067b4635-5840-48fd-980d-ccddbe1b173d	2015-02-08 19:28:24.945-05	067b4635-5840-48fd-980d-ccddbe1b173d
f1fb6f46-2937-4f6e-bb35-1060ebbcf7a2	567f33cf-7575-4334-b720-dfd7515d4f64	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.296-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.101-05	06169b04-bb68-4868-b995-98388fa33e16
01c0137c-fed4-4adc-a344-6b798d2c9cf9	793eb969-b576-4126-bba3-39284f5c1429	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.331-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.237-05	06169b04-bb68-4868-b995-98388fa33e16
436c32e0-030d-462b-b31f-f312428321c9	b726191f-70d5-4e53-bb28-b9d225efdbcb	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.571-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.353-05	06169b04-bb68-4868-b995-98388fa33e16
1942c23e-e433-48df-b249-9c0b96e3dfb2	21909320-9ec5-45ee-81db-c28dc82e3a3b	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.601-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.406-05	06169b04-bb68-4868-b995-98388fa33e16
5496e1dd-62c8-423a-bfa4-50f551e1e7d2	25893b4a-38af-4d88-bb07-27f7d6011ce3	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.615-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.51-05	06169b04-bb68-4868-b995-98388fa33e16
1862fb93-39bc-4ad2-ab82-cb74908cc6f9	fe759c88-d7ce-4340-be48-081167e21453	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.617-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.442-05	06169b04-bb68-4868-b995-98388fa33e16
04d5c0dc-efad-4494-a252-56df9bf8db77	fb198851-cd6a-40bc-97d0-630a6ed4dec2	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.619-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.475-05	06169b04-bb68-4868-b995-98388fa33e16
900babab-9050-4be2-8a19-d8484ca1cfaa	73b6c3ea-559e-4bc0-88e7-0e20730e2455	8346b7c6-0d71-48bd-b57a-3836b7777a95	\N	\N	1	0	2015-02-09 21:47:07.74-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:47:07.674-05	06169b04-bb68-4868-b995-98388fa33e16
0e8545f9-b53a-4709-8b2f-94f2fb9ae726	ce780dbe-0148-4e67-b478-4fea4cb405fc	50eea67f-b185-4ff4-ae87-ffa8d4234ed3	\N	\N	1	0	2015-02-10 09:54:54.841-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057	2015-02-10 09:54:54.759-05	f9a4abf1-df7c-4dd4-927c-5df2f8ff5057
d829ee8c-967c-4b55-bbf5-5dc060a774d0	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	02961aeb-45a6-49b4-86fb-1ee30c2b3b20	\N	\N	1	0	2015-02-11 15:19:31.959-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:19:31.899-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
1f96ae33-831d-45df-aadf-ac0c2053bc30	e9d51055-8986-4190-a7ee-98a77dc268b0	02961aeb-45a6-49b4-86fb-1ee30c2b3b20	\N	\N	1	0	2015-02-11 15:19:31.964-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf	2015-02-11 15:19:31.862-05	964c0f18-ab25-41fe-b1b2-ad8db379d2cf
727619f7-4eed-4eb7-8340-855cfe92e0d8	567f33cf-7575-4334-b720-dfd7515d4f64	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.393-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.229-05	06169b04-bb68-4868-b995-98388fa33e16
64321406-ef3d-4bf8-8ed7-62134890d32a	65b99a1a-a853-47f7-bdf8-104f76aaab22	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.578-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.278-05	06169b04-bb68-4868-b995-98388fa33e16
e014d43d-adbb-4abe-8a42-7e23defb3464	25893b4a-38af-4d88-bb07-27f7d6011ce3	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.617-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.395-05	06169b04-bb68-4868-b995-98388fa33e16
69b7008d-d6eb-48af-bc02-47b57167d6a6	fb198851-cd6a-40bc-97d0-630a6ed4dec2	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.63-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.442-05	06169b04-bb68-4868-b995-98388fa33e16
9b7e806d-21e0-4439-b4c4-782568625d9c	73b6c3ea-559e-4bc0-88e7-0e20730e2455	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.688-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.479-05	06169b04-bb68-4868-b995-98388fa33e16
a8a788a6-50d7-4947-bd12-3225a03a3ffe	21909320-9ec5-45ee-81db-c28dc82e3a3b	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.685-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.514-05	06169b04-bb68-4868-b995-98388fa33e16
220a0bd7-384c-4c42-af08-ae4be08e5168	afabc446-9a56-4b18-8386-141cfbb34a48	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.886-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.735-05	06169b04-bb68-4868-b995-98388fa33e16
3044cc22-9f55-4de5-8898-79cb6f3ec23f	fe759c88-d7ce-4340-be48-081167e21453	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.888-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.644-05	06169b04-bb68-4868-b995-98388fa33e16
5bc7e888-89b1-432f-a651-8f2007f968a1	b726191f-70d5-4e53-bb28-b9d225efdbcb	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.89-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.697-05	06169b04-bb68-4868-b995-98388fa33e16
888e66c2-68f0-4c35-8f6b-2ff47534293d	793eb969-b576-4126-bba3-39284f5c1429	57174052-013a-4109-ae8b-e66c168be5cf	\N	\N	1	0	2015-02-12 18:05:51.91-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-12 18:05:51.816-05	06169b04-bb68-4868-b995-98388fa33e16
ec666323-683f-4ae4-b77b-0552d3113c2f	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	6d715357-db77-4963-b4b4-f84ca429efa9	\N	\N	1	0	2015-02-16 15:01:01.788-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.59-05	d86a76c4-4d99-4d16-b590-1df3c3122404
50cd813d-4ea5-40b7-9b58-28d79e5c8f17	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	6d715357-db77-4963-b4b4-f84ca429efa9	\N	\N	1	0	2015-02-16 15:01:01.823-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.668-05	d86a76c4-4d99-4d16-b590-1df3c3122404
6523bfc9-9460-4ddc-abb0-a956b8402a59	afabc446-9a56-4b18-8386-141cfbb34a48	6d715357-db77-4963-b4b4-f84ca429efa9	\N	\N	1	0	2015-02-16 15:01:01.829-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.542-05	d86a76c4-4d99-4d16-b590-1df3c3122404
c90ea9b4-caf8-4180-8b57-e8e40026cafa	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	6d715357-db77-4963-b4b4-f84ca429efa9	\N	\N	1	0	2015-02-16 15:01:01.838-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.71-05	d86a76c4-4d99-4d16-b590-1df3c3122404
6f69c48e-9538-4f72-9680-5e56a5c5c7b1	501e6867-db1a-48cf-a14d-3a53c9a5b63f	6d715357-db77-4963-b4b4-f84ca429efa9	\N	\N	1	0	2015-02-16 15:01:01.836-05	d86a76c4-4d99-4d16-b590-1df3c3122404	2015-02-16 15:01:01.628-05	d86a76c4-4d99-4d16-b590-1df3c3122404
4cce63e1-f27e-43a2-8701-81b4fb57cc91	b726191f-70d5-4e53-bb28-b9d225efdbcb	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.606-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:55.675-05	06169b04-bb68-4868-b995-98388fa33e16
5d11415b-e016-4d78-86cf-46011da50131	793eb969-b576-4126-bba3-39284f5c1429	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.608-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.026-05	06169b04-bb68-4868-b995-98388fa33e16
9e3acb2c-5d27-4251-aa1e-1e8ce3f72795	73b6c3ea-559e-4bc0-88e7-0e20730e2455	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.597-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.034-05	06169b04-bb68-4868-b995-98388fa33e16
ff59d35b-a1d2-44a0-b382-e4ec073a8447	65b99a1a-a853-47f7-bdf8-104f76aaab22	c80a7587-8dca-44e0-9e72-f98090a0e3d5	43b00210-057e-471b-bbe3-0db78944e7ef	\N	1	1	2015-02-18 21:01:50.61-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.068-05	06169b04-bb68-4868-b995-98388fa33e16
7b0bf886-e79c-4257-add9-537d37160ecb	25893b4a-38af-4d88-bb07-27f7d6011ce3	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.743-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.07-05	06169b04-bb68-4868-b995-98388fa33e16
9946f0e0-9709-497e-8246-dff9150fbb01	21909320-9ec5-45ee-81db-c28dc82e3a3b	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.601-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.071-05	06169b04-bb68-4868-b995-98388fa33e16
040f9019-459a-4539-ba66-c61b5bebfc14	fb198851-cd6a-40bc-97d0-630a6ed4dec2	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.593-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.061-05	06169b04-bb68-4868-b995-98388fa33e16
bfd05702-6533-45a2-b991-ed9953d48b08	567f33cf-7575-4334-b720-dfd7515d4f64	c80a7587-8dca-44e0-9e72-f98090a0e3d5	\N	\N	1	1	2015-02-18 21:01:50.306-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.276-05	06169b04-bb68-4868-b995-98388fa33e16
1babfb39-9a6f-46ef-ba3e-707a3207360c	fe759c88-d7ce-4340-be48-081167e21453	c80a7587-8dca-44e0-9e72-f98090a0e3d5	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	1	2015-02-18 21:01:50.301-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.283-05	06169b04-bb68-4868-b995-98388fa33e16
631897f4-2ca0-4965-8208-a9c9125fd06e	afabc446-9a56-4b18-8386-141cfbb34a48	c80a7587-8dca-44e0-9e72-f98090a0e3d5	5a269fd0-02bc-4dae-bb5d-4ebaa5155241	\N	1	1	2015-02-18 21:01:50.289-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 21:05:56.284-05	06169b04-bb68-4868-b995-98388fa33e16
0a715b7b-853f-44ca-8525-8b347c7bbb7e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	2bbdea0b-9fe3-478c-9292-afbe6e34d13a	\N	\N	1	0	2015-02-20 17:03:31.171-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:30.974-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
f7cb3a53-ef18-439c-8730-2014afff6b64	47bfb33c-9dae-4315-a57e-a904072e6d08	2bbdea0b-9fe3-478c-9292-afbe6e34d13a	\N	\N	1	0	2015-02-20 17:03:31.173-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:31.049-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
3a030ffe-a740-4364-abda-b052907228dd	e868ee90-8a90-4aec-88e3-00365cf64a94	2bbdea0b-9fe3-478c-9292-afbe6e34d13a	\N	\N	1	0	2015-02-20 17:03:31.167-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:31.014-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
69cc9c90-1ae6-4170-846b-61d931b5a35c	8375c3b0-7da7-4c0a-8f44-15c5ed645010	2bbdea0b-9fe3-478c-9292-afbe6e34d13a	\N	\N	1	0	2015-02-20 17:03:31.378-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-02-20 17:03:31.314-05	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
1e5198ef-0c05-488a-a2c7-b160daca98b2	b7475b4a-6613-466d-b099-8708d527b55f	cd1cc25e-ac63-4178-995e-a4a5afa85f2e	\N	\N	1	0	2015-02-25 09:39:07.136-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:07.065-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
918ba620-0c05-44c5-b298-1c44cf31bc1e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	cd1cc25e-ac63-4178-995e-a4a5afa85f2e	\N	\N	1	0	2015-02-25 09:39:13.638-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:13.53-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
cb0fb2a6-908e-43a4-ad4a-7f28e00c99a1	5ace29a1-0b40-4ec3-9084-26b98b410a80	cd1cc25e-ac63-4178-995e-a4a5afa85f2e	\N	\N	1	0	2015-02-25 09:39:13.636-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:13.561-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
79ab939a-5f07-4c54-b116-43caf6eaf824	18362ca7-9064-4bdb-a289-edf087cac828	cd1cc25e-ac63-4178-995e-a4a5afa85f2e	\N	\N	1	0	2015-02-25 09:39:18.284-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 09:39:18.221-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
1ebe3d01-0a31-4359-b38c-32e1ef4a3079	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	67f4a2f0-4a38-4b96-b8c0-a284d31a60f1	\N	\N	1	0	2015-02-25 11:54:23.156-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 11:54:23.098-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
5f65fd95-44d6-411c-87a3-b161fda03654	80881761-08a2-4d02-ae1e-287610944eeb	67f4a2f0-4a38-4b96-b8c0-a284d31a60f1	\N	\N	1	0	2015-02-25 11:54:23.505-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 11:54:23.41-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
e0f391e7-96fd-42cf-a363-c3c30dd374f7	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	67f4a2f0-4a38-4b96-b8c0-a284d31a60f1	\N	\N	1	0	2015-02-25 11:54:23.518-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 11:54:23.44-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
33ed7aa6-1fe2-406d-85f4-9a97e7d1ef5a	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	67f4a2f0-4a38-4b96-b8c0-a284d31a60f1	\N	\N	1	0	2015-02-25 11:54:23.513-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-25 11:54:23.379-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
74b00860-834e-4d77-9fab-7c1c41e699c1	b7475b4a-6613-466d-b099-8708d527b55f	8f6a1d04-7c77-453e-ac46-3d35a713d52e	\N	\N	1	0	2015-02-26 14:00:11.031-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:10.97-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
b2a99856-3c3c-4618-b0f8-24f1eac7bd12	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	8f6a1d04-7c77-453e-ac46-3d35a713d52e	\N	\N	1	0	2015-02-26 14:00:12.085-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:12.014-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
9c35cba4-e9a3-4ee8-a94c-f851ed134ea2	18362ca7-9064-4bdb-a289-edf087cac828	8f6a1d04-7c77-453e-ac46-3d35a713d52e	\N	\N	1	0	2015-02-26 14:00:14.586-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:14.529-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
c79b0801-6d23-422c-ba0b-c45a54156bc8	5ace29a1-0b40-4ec3-9084-26b98b410a80	8f6a1d04-7c77-453e-ac46-3d35a713d52e	\N	\N	1	0	2015-02-26 14:00:14.853-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:00:14.795-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757
fc84db09-92b8-47dd-8003-ec3e38c7dd2f	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	2727d7a4-c892-4350-9e0a-5785e6909819	\N	\N	1	0	2015-03-04 20:44:07.031-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.842-05	f975c50a-beb9-4277-ba91-6505d1b37f59
9614ba54-452a-4a8d-84d6-1df97cdf81d6	18362ca7-9064-4bdb-a289-edf087cac828	2727d7a4-c892-4350-9e0a-5785e6909819	\N	\N	1	0	2015-03-04 20:44:07.046-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.958-05	f975c50a-beb9-4277-ba91-6505d1b37f59
eb9c50be-b37d-4af9-bb0e-0ae99b411951	b7475b4a-6613-466d-b099-8708d527b55f	2727d7a4-c892-4350-9e0a-5785e6909819	\N	\N	1	0	2015-03-04 20:44:07.049-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.794-05	f975c50a-beb9-4277-ba91-6505d1b37f59
de7f3714-3a7a-40d3-9f12-157edeabb852	5ace29a1-0b40-4ec3-9084-26b98b410a80	2727d7a4-c892-4350-9e0a-5785e6909819	\N	\N	1	0	2015-03-04 20:44:07.054-05	f975c50a-beb9-4277-ba91-6505d1b37f59	2015-03-04 20:44:06.931-05	f975c50a-beb9-4277-ba91-6505d1b37f59
c170b3ee-899a-4443-803a-d1af127dbd63	e868ee90-8a90-4aec-88e3-00365cf64a94	d4472f92-2ebd-4758-bd04-ff72e2ad68a7	\N	\N	1	0	2015-03-12 15:06:40.193-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:40.033-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
9c443c48-dfb1-40ea-856f-9bd3a397ddd5	8375c3b0-7da7-4c0a-8f44-15c5ed645010	d4472f92-2ebd-4758-bd04-ff72e2ad68a7	\N	\N	1	0	2015-03-12 15:06:40.229-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:40.107-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
c6a5acb1-22ff-4aae-805a-05a32b14f2ba	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d4472f92-2ebd-4758-bd04-ff72e2ad68a7	\N	\N	1	0	2015-03-12 15:06:40.232-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:39.986-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
4e15f302-8be3-4310-96fc-cb0e873be3b6	47bfb33c-9dae-4315-a57e-a904072e6d08	d4472f92-2ebd-4758-bd04-ff72e2ad68a7	\N	\N	1	0	2015-03-12 15:06:40.224-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:06:40.069-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
842215f2-d960-4259-8888-d717aad09933	e9d51055-8986-4190-a7ee-98a77dc268b0	a93b21c3-33ce-439a-a150-91709a70363a	\N	\N	1	0	2015-03-12 15:11:00.302-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:11:00.205-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
c85eb785-a331-4035-b81d-d0f7127c1d44	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	a93b21c3-33ce-439a-a150-91709a70363a	\N	\N	1	0	2015-03-12 15:11:00.304-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-03-12 15:11:00.237-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
8898bf3d-d23d-45d5-ad91-5c59543eda3d	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	5e329cbd-fd48-4999-bd48-c0fa8c1872c5	\N	\N	1	0	2015-03-17 18:15:20.104-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:15:19.979-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
73468916-54b8-4752-b142-510d141ea3c3	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	5e329cbd-fd48-4999-bd48-c0fa8c1872c5	\N	\N	1	0	2015-03-17 18:15:20.111-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:15:20.007-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
7057f263-369a-462e-b9d1-f34a846de3d3	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	5e329cbd-fd48-4999-bd48-c0fa8c1872c5	\N	\N	1	0	2015-03-17 18:15:20.117-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:15:20.036-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
d8f5a57a-e7da-4435-ad43-c5c4170fc003	80881761-08a2-4d02-ae1e-287610944eeb	5e329cbd-fd48-4999-bd48-c0fa8c1872c5	\N	\N	1	0	2015-03-17 18:15:20.178-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:15:20.132-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
ae063ed5-2ea3-4e29-9719-c4b621417263	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9d60481f-4078-49e7-b490-32b71ec02256	\N	\N	1	0	2015-03-12 22:39:45.817-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:39:45.769-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
fef92986-8b57-49aa-bab8-794691b1c426	e868ee90-8a90-4aec-88e3-00365cf64a94	9d60481f-4078-49e7-b490-32b71ec02256	\N	\N	1	0	2015-03-12 22:39:45.989-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:39:45.873-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
c7f0517f-c955-40f0-8487-1e062ec73422	47bfb33c-9dae-4315-a57e-a904072e6d08	9d60481f-4078-49e7-b490-32b71ec02256	\N	\N	1	0	2015-03-12 22:39:46.006-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:39:45.913-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
2bde0a1c-febf-4399-819c-02e337edb66d	8375c3b0-7da7-4c0a-8f44-15c5ed645010	9d60481f-4078-49e7-b490-32b71ec02256	\N	\N	1	0	2015-03-12 22:39:46.008-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:39:45.941-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
95f83e1e-99f5-40c6-a0f3-a43a506df5b5	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	92b0f627-9198-4bad-9fbe-40be5247af8c	\N	\N	1	0	2015-03-12 22:41:20.85-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:41:20.791-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
89f31212-1550-4be8-bef1-74935bce7584	8375c3b0-7da7-4c0a-8f44-15c5ed645010	92b0f627-9198-4bad-9fbe-40be5247af8c	\N	\N	1	0	2015-03-12 22:41:21.056-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:41:20.958-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
b2b79ddb-e865-4fa7-93eb-489bade4ffff	e868ee90-8a90-4aec-88e3-00365cf64a94	92b0f627-9198-4bad-9fbe-40be5247af8c	\N	\N	1	0	2015-03-12 22:41:21.06-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:41:20.926-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
866f7864-43ae-4fc1-be4c-28fefb61594c	47bfb33c-9dae-4315-a57e-a904072e6d08	92b0f627-9198-4bad-9fbe-40be5247af8c	\N	\N	1	0	2015-03-12 22:41:21.062-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 22:41:20.985-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
84f9e770-f2df-4220-a862-763d4747db12	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	1158fb0c-d304-4d0e-9eb8-d2d0559376dd	\N	\N	1	0	2015-03-12 23:02:21.349-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:21.295-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
d505b4c0-606e-4b62-aa88-d3c817d0139f	8375c3b0-7da7-4c0a-8f44-15c5ed645010	1158fb0c-d304-4d0e-9eb8-d2d0559376dd	\N	\N	1	0	2015-03-12 23:02:21.571-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:21.468-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
87163543-7276-47e7-85ed-c837d2e02670	47bfb33c-9dae-4315-a57e-a904072e6d08	1158fb0c-d304-4d0e-9eb8-d2d0559376dd	\N	\N	1	0	2015-03-12 23:02:21.578-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:21.495-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
00c2cf5a-c047-4eae-9537-b8f14b98cf5c	e868ee90-8a90-4aec-88e3-00365cf64a94	1158fb0c-d304-4d0e-9eb8-d2d0559376dd	\N	\N	1	0	2015-03-12 23:02:21.58-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:21.436-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
8ffa68be-0c1c-445e-8fc6-297bf9fb1a55	e868ee90-8a90-4aec-88e3-00365cf64a94	3788d343-ae72-4834-9a12-49418fd55a5f	\N	\N	1	2	2015-03-12 22:36:09.908-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:47.214-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
b662c1de-ab9c-47d9-ac8d-f98bf8854bb1	47bfb33c-9dae-4315-a57e-a904072e6d08	3788d343-ae72-4834-9a12-49418fd55a5f	\N	\N	1	2	2015-03-12 22:36:09.913-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:47.217-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
5207c457-9ae1-4768-8b6c-3f9deb757e75	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	3788d343-ae72-4834-9a12-49418fd55a5f	\N	\N	1	2	2015-03-12 22:36:09.668-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:47.209-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
c0f4e892-af28-41e7-88fd-edf809c05910	8375c3b0-7da7-4c0a-8f44-15c5ed645010	3788d343-ae72-4834-9a12-49418fd55a5f	\N	\N	1	2	2015-03-12 22:36:09.894-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:02:47.219-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
821bafc2-9f44-4931-b0ec-82530b71e3bb	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	75b149fb-af5e-4019-bbcd-382a91293b23	\N	\N	1	0	2015-03-12 23:04:34.846-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:04:34.789-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
bdc376bb-2b82-4ab8-8e82-ace8f7f8a0e5	e868ee90-8a90-4aec-88e3-00365cf64a94	75b149fb-af5e-4019-bbcd-382a91293b23	\N	\N	1	0	2015-03-12 23:04:35.01-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:04:34.891-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
e44a0855-4388-4949-9421-56e4d12c5024	8375c3b0-7da7-4c0a-8f44-15c5ed645010	75b149fb-af5e-4019-bbcd-382a91293b23	\N	\N	1	0	2015-03-12 23:04:35.014-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:04:34.949-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
ac16219b-aeac-4ec6-9cc8-9c56258f1ac5	47bfb33c-9dae-4315-a57e-a904072e6d08	75b149fb-af5e-4019-bbcd-382a91293b23	\N	\N	1	0	2015-03-12 23:04:35.016-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c	2015-03-12 23:04:34.922-04	8d13a8ee-d89c-483e-ae4b-6923185d5c0c
c34878a5-6489-4746-b5de-828717345c59	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	746c6c6b-5efc-46e3-bb5f-7a62f51d6961	f0866b41-3024-4965-9a1b-34e7aeea0851	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	1	2015-03-17 18:05:42.313-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:06:18.282-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
f00ef3fc-2fef-467b-823f-a1f2be3e12b1	47bfb33c-9dae-4315-a57e-a904072e6d08	746c6c6b-5efc-46e3-bb5f-7a62f51d6961	\N	\N	1	1	2015-03-17 18:05:42.61-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:06:18.554-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
b5eaed59-71b1-4997-bf5b-cc39555125e0	e868ee90-8a90-4aec-88e3-00365cf64a94	746c6c6b-5efc-46e3-bb5f-7a62f51d6961	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	1	2015-03-17 18:05:42.618-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:06:18.57-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
c8ab2e15-6d18-4eb2-a7ed-26f13a655561	8375c3b0-7da7-4c0a-8f44-15c5ed645010	746c6c6b-5efc-46e3-bb5f-7a62f51d6961	e4906e3b-5e8a-4b46-a7a3-1c093454d06b	\N	1	1	2015-03-17 18:05:42.601-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-17 18:06:18.573-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
6c764f4f-9299-4407-a3a7-320cd6061b97	80881761-08a2-4d02-ae1e-287610944eeb	20f0a9e4-1777-49f0-a30f-0983631b328f	d8e7b441-1223-4e20-871e-8a5f72389b7e	\N	1	0	2015-03-19 13:25:30.982-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:30.91-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
df2a7f57-4975-4ea3-a0c3-b2582f66a922	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	20f0a9e4-1777-49f0-a30f-0983631b328f	f0866b41-3024-4965-9a1b-34e7aeea0851	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	0	2015-03-19 13:25:31.393-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:31.242-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
0a5bc831-be30-445e-8951-b5ed7042c7c8	fe759c88-d7ce-4340-be48-081167e21453	20f0a9e4-1777-49f0-a30f-0983631b328f	\N	\N	1	0	2015-03-19 13:25:31.403-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:31.291-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
b0092791-aa9e-40b2-8b5d-e15d29e9c626	25893b4a-38af-4d88-bb07-27f7d6011ce3	20f0a9e4-1777-49f0-a30f-0983631b328f	\N	\N	1	0	2015-03-19 13:25:31.413-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-19 13:25:31.329-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
39eb9b16-89e0-4f8f-a12c-3ebcf2f6b29e	80881761-08a2-4d02-ae1e-287610944eeb	2bb4ef18-e396-47bd-bd78-8a9ba2aa6d5b	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	5	2015-03-19 20:40:26.359-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 22:12:25.234-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
b1c2a40e-87e4-4e94-9875-2d98a763bfc1	567f33cf-7575-4334-b720-dfd7515d4f64	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:54.866-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:54.793-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c74adec8-ece6-4e8b-af69-0d777032f020	fe759c88-d7ce-4340-be48-081167e21453	2bb4ef18-e396-47bd-bd78-8a9ba2aa6d5b	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	5	2015-03-19 20:40:26.344-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 22:12:25.526-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
600f491a-d46a-483d-a019-2f5ee3feeab3	25893b4a-38af-4d88-bb07-27f7d6011ce3	2bb4ef18-e396-47bd-bd78-8a9ba2aa6d5b	\N	\N	1	5	2015-03-19 20:40:26.362-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 22:12:25.559-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
7c73a77b-e088-48ea-9f49-c937edba594d	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	2bb4ef18-e396-47bd-bd78-8a9ba2aa6d5b	f0866b41-3024-4965-9a1b-34e7aeea0851	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	5	2015-03-19 20:40:26.069-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c	2015-03-19 22:12:25.562-04	3d68b07e-10b0-4bca-9d31-8ff15c8ef89c
f85e708a-041a-4ce4-ab29-b3ed90fbc3a6	73b6c3ea-559e-4bc0-88e7-0e20730e2455	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.135-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.003-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
f5cb1376-b5eb-4ed0-8ab0-89e3360f967a	b726191f-70d5-4e53-bb28-b9d225efdbcb	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.162-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.084-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
9aaa831c-6c0f-4286-a317-9b69a8cebb45	21909320-9ec5-45ee-81db-c28dc82e3a3b	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.543-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.224-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
be846e26-2553-4e3b-8e35-867aa5115a91	793eb969-b576-4126-bba3-39284f5c1429	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.561-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.166-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c3e81548-f7e4-4af1-9c1c-353a0bd9d2f8	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	9255de86-f7cd-4304-ba76-a31dea3f195f	d8e7b441-1223-4e20-871e-8a5f72389b7e	\N	1	1	2015-03-13 10:52:16.648-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 13:03:17.941-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
8cfc2738-cb81-4978-aace-d66acbf6895d	65b99a1a-a853-47f7-bdf8-104f76aaab22	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.564-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.263-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
57597481-1079-436d-903e-83e1c0548bf0	fe759c88-d7ce-4340-be48-081167e21453	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.568-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.348-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
b31db44d-8885-40ba-bd1d-fa68f2311870	afabc446-9a56-4b18-8386-141cfbb34a48	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.567-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.303-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c21da4ea-7a80-4b73-a20f-60be6b1dc8d3	fb198851-cd6a-40bc-97d0-630a6ed4dec2	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.695-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.644-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c7611d5f-e64c-40fb-9805-9be7b9b627b6	25893b4a-38af-4d88-bb07-27f7d6011ce3	48075e71-86cf-413c-9182-9bd5eff9c1c0	\N	\N	1	0	2015-03-20 11:40:55.762-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 11:40:55.71-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
ac714495-bbe1-4217-9205-8ee7437a3dfa	b910c68c-0ea3-4887-ad4a-f7313bd007e3	7dcb53b7-bab3-44e0-9f41-a27bd919bcee	\N	\N	1	0	2015-03-20 11:47:01.898-04	05dbb3b8-9caf-405e-ae5e-a6074822a169	2015-03-20 11:47:01.839-04	05dbb3b8-9caf-405e-ae5e-a6074822a169
092562a6-4b4e-400d-9ca9-749c6617dc68	b7475b4a-6613-466d-b099-8708d527b55f	56b9e86d-73bd-4e82-b74c-6302d3ad5d4b	\N	\N	1	0	2015-03-20 11:49:05.472-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:05.419-04	5c54b12e-42e9-4222-9d43-04de05218061
4eb2b482-edb4-4633-afc5-7dd5f1ce6284	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	56b9e86d-73bd-4e82-b74c-6302d3ad5d4b	\N	\N	1	0	2015-03-20 11:49:05.845-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:05.759-04	5c54b12e-42e9-4222-9d43-04de05218061
da7cb379-5730-474d-8226-fb6c4b5a8a52	18362ca7-9064-4bdb-a289-edf087cac828	56b9e86d-73bd-4e82-b74c-6302d3ad5d4b	\N	\N	1	0	2015-03-20 11:49:05.863-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:05.726-04	5c54b12e-42e9-4222-9d43-04de05218061
0ef472b9-45a6-478d-b90b-9eecb8ce6fe7	5ace29a1-0b40-4ec3-9084-26b98b410a80	56b9e86d-73bd-4e82-b74c-6302d3ad5d4b	\N	\N	1	0	2015-03-20 11:49:05.866-04	5c54b12e-42e9-4222-9d43-04de05218061	2015-03-20 11:49:05.788-04	5c54b12e-42e9-4222-9d43-04de05218061
ad68adcd-9200-48bf-a25f-605e93d1beda	567f33cf-7575-4334-b720-dfd7515d4f64	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:51.523-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.464-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
28bb2f97-70d4-44ea-a927-96369845dc5a	65b99a1a-a853-47f7-bdf8-104f76aaab22	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:51.803-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.667-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
cd47dffc-8283-439d-addc-ab312fef22b8	793eb969-b576-4126-bba3-39284f5c1429	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:51.892-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.76-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
c2542122-7afd-4a14-b4ea-d696c240abad	afabc446-9a56-4b18-8386-141cfbb34a48	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:51.929-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.728-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
13f69fc4-9192-4488-ba4b-0eee03946f10	b7475b4a-6613-466d-b099-8708d527b55f	45d5772e-75a9-4daa-8b49-73565adf8f78	\N	\N	1	1	2015-03-20 12:01:20.566-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:03:47.465-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
08bb3dbd-76da-469e-a7e3-3b1ec69cc203	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	45d5772e-75a9-4daa-8b49-73565adf8f78	\N	\N	1	1	2015-03-20 12:01:22.16-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:03:47.946-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
2bbfbb56-f601-40cd-8811-4d79fd15e3a9	5ace29a1-0b40-4ec3-9084-26b98b410a80	45d5772e-75a9-4daa-8b49-73565adf8f78	\N	\N	1	1	2015-03-20 12:01:22.015-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:03:50.145-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
c088bd0a-5155-4a34-b7ff-d07c0a4ce528	b910c68c-0ea3-4887-ad4a-f7313bd007e3	28660133-3f80-40b0-ac0b-27b7b00957c4	\N	\N	1	0	2015-03-20 12:03:52.667-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b	2015-03-20 12:03:52.603-04	0d974cc6-045d-4ec5-a533-38ab0b8f115b
b0ceed7c-0d7f-488e-ad60-6ed2c6f48928	18362ca7-9064-4bdb-a289-edf087cac828	45d5772e-75a9-4daa-8b49-73565adf8f78	\N	\N	1	1	2015-03-20 12:01:22.228-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6	2015-03-20 12:03:53.811-04	1e36b7cc-664c-4e8c-b778-39461c0cb4e6
9b20f281-b55a-4748-bc7a-775e2c66cb6a	e9d51055-8986-4190-a7ee-98a77dc268b0	9255de86-f7cd-4304-ba76-a31dea3f195f	d8e7b441-1223-4e20-871e-8a5f72389b7e	\N	1	1	2015-03-13 10:52:16.418-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-03-20 13:03:15.907-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
f806f5bf-2aee-467e-9cdb-499815bfb14e	b726191f-70d5-4e53-bb28-b9d225efdbcb	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.019-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.807-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
84dba1f9-4474-4c9a-9ec7-fd9f648119e6	73b6c3ea-559e-4bc0-88e7-0e20730e2455	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.08-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.897-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
efdab7fd-184d-49f6-be36-fd66eb8ac0a6	21909320-9ec5-45ee-81db-c28dc82e3a3b	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.084-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.858-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
6ad27264-6143-45b1-a005-2df19762d754	fe759c88-d7ce-4340-be48-081167e21453	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.094-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.936-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
d7eff575-d7c5-4780-a0f8-9305c5067c9a	b7475b4a-6613-466d-b099-8708d527b55f	8d41e89e-67c8-498e-b9c7-185a382fe9b8	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	2	2015-03-20 18:21:32.49-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:38:22.466-04	fd0457a0-2d66-4a63-857b-21f224a14a47
f1cb3278-b2e4-421b-bef3-1eecef19b9c9	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	8d41e89e-67c8-498e-b9c7-185a382fe9b8	c6ddfe98-66f4-4103-96f6-74cd557b5ba5	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	2	2015-03-20 18:21:32.843-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:38:26.42-04	fd0457a0-2d66-4a63-857b-21f224a14a47
a04573c8-608e-4821-a68c-8ba680047d90	18362ca7-9064-4bdb-a289-edf087cac828	8d41e89e-67c8-498e-b9c7-185a382fe9b8	317718b3-ed23-4e10-b14f-2d30d181ed9c	cc2abaf8-7e9d-4d77-adf4-0d5dd815e40b	1	2	2015-03-20 18:21:32.848-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:38:26.418-04	fd0457a0-2d66-4a63-857b-21f224a14a47
23d98552-951e-4590-8be9-1cea03b1fee0	5ace29a1-0b40-4ec3-9084-26b98b410a80	8d41e89e-67c8-498e-b9c7-185a382fe9b8	317718b3-ed23-4e10-b14f-2d30d181ed9c	\N	1	2	2015-03-20 18:21:32.851-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:38:27.403-04	fd0457a0-2d66-4a63-857b-21f224a14a47
874f23ce-e664-4a41-b22f-e31c87d8ef9f	80881761-08a2-4d02-ae1e-287610944eeb	81a76138-3382-40ad-8219-0d83de83089a	\N	\N	1	0	2015-03-21 15:55:42.03-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.892-04	c27e733b-f247-498a-a945-7521cca65c3b
fe597a94-52c3-407d-9af7-275d58dc0071	fe759c88-d7ce-4340-be48-081167e21453	81a76138-3382-40ad-8219-0d83de83089a	\N	\N	1	0	2015-03-21 15:55:42.036-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:41.936-04	c27e733b-f247-498a-a945-7521cca65c3b
abe2b536-e356-4af1-b892-2dd3bbb8e3e4	25893b4a-38af-4d88-bb07-27f7d6011ce3	81a76138-3382-40ad-8219-0d83de83089a	\N	\N	1	0	2015-03-21 15:55:42.386-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:42.308-04	c27e733b-f247-498a-a945-7521cca65c3b
01c46a6b-164e-4e94-9755-528ce19230ce	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	81a76138-3382-40ad-8219-0d83de83089a	\N	\N	1	0	2015-03-21 15:55:42.396-04	c27e733b-f247-498a-a945-7521cca65c3b	2015-03-21 15:55:42.242-04	c27e733b-f247-498a-a945-7521cca65c3b
03056d09-7be5-49ac-bb1a-3d05b245651d	e9d51055-8986-4190-a7ee-98a77dc268b0	5a17a5c5-0b80-4baf-af41-d6ba1c4df17c	\N	\N	1	1	2015-03-22 14:00:41.026-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:07:33.55-04	dc91c128-7614-4592-b94e-c19660131a55
f2c4ba27-920e-4dab-bb08-404b2b27beeb	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	5a17a5c5-0b80-4baf-af41-d6ba1c4df17c	\N	\N	1	1	2015-03-22 14:00:41.021-04	dc91c128-7614-4592-b94e-c19660131a55	2015-03-22 14:07:33.758-04	dc91c128-7614-4592-b94e-c19660131a55
cfc1390f-295e-4b16-a51c-dba54b107e8c	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	adf0bd70-4d9f-4c0f-a4e6-6a05bb22d3d6	\N	\N	1	0	2015-03-25 20:24:23.612-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-25 20:24:23.556-04	06169b04-bb68-4868-b995-98388fa33e16
fd728e95-dafb-4c31-bb75-8f6c852d360a	47bfb33c-9dae-4315-a57e-a904072e6d08	adf0bd70-4d9f-4c0f-a4e6-6a05bb22d3d6	\N	\N	1	0	2015-03-25 20:24:23.958-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-25 20:24:23.867-04	06169b04-bb68-4868-b995-98388fa33e16
337e07d4-8565-4101-bdba-4088e3c4f73f	e868ee90-8a90-4aec-88e3-00365cf64a94	adf0bd70-4d9f-4c0f-a4e6-6a05bb22d3d6	\N	\N	1	0	2015-03-25 20:24:23.972-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-25 20:24:23.916-04	06169b04-bb68-4868-b995-98388fa33e16
1b586c55-67e8-441d-b273-9520410d5def	8375c3b0-7da7-4c0a-8f44-15c5ed645010	adf0bd70-4d9f-4c0f-a4e6-6a05bb22d3d6	\N	\N	1	0	2015-03-25 20:24:24.049-04	06169b04-bb68-4868-b995-98388fa33e16	2015-03-25 20:24:23.975-04	06169b04-bb68-4868-b995-98388fa33e16
8689e244-ff6d-4a48-ab1b-a18195eefc94	fb198851-cd6a-40bc-97d0-630a6ed4dec2	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.105-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:51.988-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
b6c0973d-d499-4fd4-b53c-6c888e2aadad	25893b4a-38af-4d88-bb07-27f7d6011ce3	48d90bdc-0e75-4f62-8031-8e163ca39ae5	\N	\N	1	0	2015-03-26 21:14:52.115-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:14:52.029-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
d7d23114-06f4-49a5-9701-923fc77f3769	567f33cf-7575-4334-b720-dfd7515d4f64	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.257-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.193-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
33e29e26-fade-4ea0-a314-c14023b065b5	65b99a1a-a853-47f7-bdf8-104f76aaab22	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.685-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.444-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
a9f37491-6692-45a3-ae51-3ae98e62add0	afabc446-9a56-4b18-8386-141cfbb34a48	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.818-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.496-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
df6a4f03-f76b-4212-8cbc-1ca7c83475be	793eb969-b576-4126-bba3-39284f5c1429	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.855-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.536-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
0dbcdcd7-0ebe-4cc1-ad21-22d2361d5fd0	21909320-9ec5-45ee-81db-c28dc82e3a3b	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.879-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.614-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
54c83e28-3a88-4717-97a8-fe90939a950c	b726191f-70d5-4e53-bb28-b9d225efdbcb	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.875-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.571-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
989a4d03-d2f8-45ff-b169-5790666f83f8	73b6c3ea-559e-4bc0-88e7-0e20730e2455	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.882-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.649-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
2baa4405-df3f-41d9-8fe6-1226c948c006	fe759c88-d7ce-4340-be48-081167e21453	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.893-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.69-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
8c04046c-2d42-4b93-86f7-49dfb072dbc5	25893b4a-38af-4d88-bb07-27f7d6011ce3	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.906-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.764-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
88186263-d600-4817-9cc5-dd0fc339f28f	fb198851-cd6a-40bc-97d0-630a6ed4dec2	e570250b-496b-4367-94d8-bcf4ae73fad0	\N	\N	1	0	2015-03-26 21:24:38.907-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-03-26 21:24:38.731-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
12c1aefe-417d-444c-b878-5a95e0af7122	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	94cd9abe-c922-4e4b-b4c0-5260f3680e3c	\N	\N	1	0	2015-03-29 07:44:59.954-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.834-04	9ef858fa-13d8-4152-aff7-28daea5a0842
0c75a3ed-f685-42d6-a19c-332d00c15475	e9d51055-8986-4190-a7ee-98a77dc268b0	94cd9abe-c922-4e4b-b4c0-5260f3680e3c	\N	\N	1	0	2015-03-29 07:44:59.948-04	9ef858fa-13d8-4152-aff7-28daea5a0842	2015-03-29 07:44:59.791-04	9ef858fa-13d8-4152-aff7-28daea5a0842
13d1f931-a67f-4e3d-ac0c-d645b3709495	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	374343e5-7456-4784-a437-5bd0c8e8034d	\N	\N	1	1	2015-03-29 13:26:13.734-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:35:13.422-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
e24e53c6-9f77-4816-90d0-4c4eff70a8d2	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	3b443545-ecbf-4877-afba-2b4d55311259	\N	\N	1	2	2015-03-29 13:24:58.313-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:49:45.695-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
8437f703-db6d-4721-be82-988c802d6f56	afabc446-9a56-4b18-8386-141cfbb34a48	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.114-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.57-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
d6e7a0d1-9872-428e-9f83-b3f9765c70c1	21909320-9ec5-45ee-81db-c28dc82e3a3b	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.112-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.588-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
43322564-a3c1-43e3-8f1c-ca49a2b97cdd	b726191f-70d5-4e53-bb28-b9d225efdbcb	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.117-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.592-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
9e30109e-6dcf-4dcb-b1ab-26570d2a4376	65b99a1a-a853-47f7-bdf8-104f76aaab22	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.108-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.595-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
12574888-5bdc-49b6-a58a-67a6fba926c2	793eb969-b576-4126-bba3-39284f5c1429	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.115-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.593-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
c6922717-57e6-4a62-a0d8-362d351d6901	fe759c88-d7ce-4340-be48-081167e21453	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.145-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.631-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
1ed382e2-be3a-4632-856f-2b984a1e18ca	25893b4a-38af-4d88-bb07-27f7d6011ce3	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.27-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.758-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
9384cf35-0496-4f7e-8776-16981986fcbc	fb198851-cd6a-40bc-97d0-630a6ed4dec2	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:48.263-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.762-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
07077a46-f26c-443f-873f-b1cd0844b3ed	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	374343e5-7456-4784-a437-5bd0c8e8034d	\N	\N	1	1	2015-03-29 13:26:13.981-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:35:13.683-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
f3c57b94-15d3-497a-92cb-2f75742136c3	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	374343e5-7456-4784-a437-5bd0c8e8034d	\N	\N	1	1	2015-03-29 13:26:13.99-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:35:13.693-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
53935b35-511f-49f2-947b-98e71ea70f96	80881761-08a2-4d02-ae1e-287610944eeb	374343e5-7456-4784-a437-5bd0c8e8034d	\N	\N	1	1	2015-03-29 13:26:13.997-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 13:35:13.694-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
f9c3b92f-6af0-4b36-ac85-1f3e5011d243	8375c3b0-7da7-4c0a-8f44-15c5ed645010	c5bf7722-45c4-41ff-95a0-367886ef8834	\N	\N	1	8	2015-03-29 13:30:01.472-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 14:23:34.629-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
08c10599-dd33-44cc-b956-9517f1f6fe45	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	4d40ee93-9177-4e88-9962-850559ba06eb	\N	\N	1	0	2015-04-03 12:57:55.143-04	06169b04-bb68-4868-b995-98388fa33e16	2015-04-03 12:57:55.052-04	06169b04-bb68-4868-b995-98388fa33e16
422ddacf-b3d4-4a09-8173-6393a5cd4ad0	47bfb33c-9dae-4315-a57e-a904072e6d08	4d40ee93-9177-4e88-9962-850559ba06eb	\N	\N	1	0	2015-04-03 12:57:55.368-04	06169b04-bb68-4868-b995-98388fa33e16	2015-04-03 12:57:55.277-04	06169b04-bb68-4868-b995-98388fa33e16
d923e910-96d0-4bcc-bec1-73c8988cddc2	e868ee90-8a90-4aec-88e3-00365cf64a94	4d40ee93-9177-4e88-9962-850559ba06eb	\N	\N	1	0	2015-04-03 12:57:55.373-04	06169b04-bb68-4868-b995-98388fa33e16	2015-04-03 12:57:55.201-04	06169b04-bb68-4868-b995-98388fa33e16
403c863e-943f-49e0-b135-685776f96366	e9d51055-8986-4190-a7ee-98a77dc268b0	e530d9d4-bc1a-4836-8bf6-64818c40612e	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	1	2015-03-29 21:09:10.975-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:14:37.131-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
b7fc85ce-57aa-4a90-8994-fdd6adc381d3	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	e530d9d4-bc1a-4836-8bf6-64818c40612e	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	1	2015-03-29 21:09:11.1-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:14:37.301-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
8134fa17-0847-4ca6-a63f-ea7067fd520e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9071fbf1-d7bb-4ab4-99df-08e5428d4507	\N	\N	1	1	2015-03-29 21:10:06.157-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:16:01.623-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
8064e5eb-005e-4a31-b1c6-5e34ba679ce5	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	9071fbf1-d7bb-4ab4-99df-08e5428d4507	\N	\N	1	1	2015-03-29 21:10:06.434-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:16:01.9-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
216af16d-b499-425c-8cea-a0ad60e44cc3	80881761-08a2-4d02-ae1e-287610944eeb	9071fbf1-d7bb-4ab4-99df-08e5428d4507	\N	\N	1	1	2015-03-29 21:10:06.436-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:16:01.907-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
10ef1cf2-2d2c-4aa7-9b2d-da9e4db5fc90	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	9071fbf1-d7bb-4ab4-99df-08e5428d4507	\N	\N	1	1	2015-03-29 21:10:06.426-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-03-29 21:16:01.913-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
54ebca86-8e4c-4e1c-a3a6-5af06432d0f6	8375c3b0-7da7-4c0a-8f44-15c5ed645010	4d40ee93-9177-4e88-9962-850559ba06eb	\N	\N	1	0	2015-04-03 12:57:55.375-04	06169b04-bb68-4868-b995-98388fa33e16	2015-04-03 12:57:55.24-04	06169b04-bb68-4868-b995-98388fa33e16
a2293f66-dfa0-4699-a74b-8958d9811bd5	567f33cf-7575-4334-b720-dfd7515d4f64	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:47.745-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.116-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
d432c7c9-1322-4720-b7c6-2aa1220e6c9f	73b6c3ea-559e-4bc0-88e7-0e20730e2455	80d181fa-ec02-45f2-ba28-3b634ad4caa0	\N	\N	1	1	2015-03-31 14:26:47.855-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4	2015-03-31 15:40:51.479-04	dfaf0205-40d2-495c-8197-cf0e0ec838b4
ec4ef8ba-79e8-42d2-807a-298549034111	e9d51055-8986-4190-a7ee-98a77dc268b0	5eaeac28-83dc-41cb-b268-efdb97accb76	\N	\N	1	0	2015-04-01 13:39:01.884-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:39:01.82-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
e1472584-29d9-43f6-83e6-822eac2fc398	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	5eaeac28-83dc-41cb-b268-efdb97accb76	\N	\N	1	0	2015-04-01 13:39:02.026-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:39:01.974-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
2b2993e0-e9f4-4298-8a1a-8fc4b27a8334	e9d51055-8986-4190-a7ee-98a77dc268b0	3b443545-ecbf-4877-afba-2b4d55311259	\N	\N	1	2	2015-03-29 13:24:58.166-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 13:49:45.546-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
21900c1e-afda-4f2d-9473-0ec190aefb54	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c5bf7722-45c4-41ff-95a0-367886ef8834	\N	\N	1	8	2015-03-29 13:30:01.198-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 14:23:34.386-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
4181fd44-bc49-4c5d-913e-28386ba1a1d8	47bfb33c-9dae-4315-a57e-a904072e6d08	c5bf7722-45c4-41ff-95a0-367886ef8834	\N	\N	1	8	2015-03-29 13:30:01.466-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 14:23:34.617-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
f6fdf7a3-1536-4a71-ab85-10d6a5e1d25c	e868ee90-8a90-4aec-88e3-00365cf64a94	c5bf7722-45c4-41ff-95a0-367886ef8834	\N	\N	1	8	2015-03-29 13:30:01.461-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-04-01 14:23:34.624-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
2d2b2946-8d73-4bbf-b04d-2854c4050cbb	e9d51055-8986-4190-a7ee-98a77dc268b0	a3bb1651-ae21-4eb3-91be-ed6839f2bb6e	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	4	2015-04-03 17:36:57.36-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-04-03 17:39:46.736-04	503a77c4-05d0-4a6d-b282-61284bdefdf8
096dca71-f10b-42d0-8fbb-5c5a7ec8f6d2	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	a3bb1651-ae21-4eb3-91be-ed6839f2bb6e	8598a82f-ef8b-4326-902b-ab9e80789316	\N	1	4	2015-04-03 17:36:57.364-04	503a77c4-05d0-4a6d-b282-61284bdefdf8	2015-04-03 17:39:47.253-04	503a77c4-05d0-4a6d-b282-61284bdefdf8
830495d6-6d5e-4923-8f79-c23beb80827c	567f33cf-7575-4334-b720-dfd7515d4f64	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.3-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.198-04	84525335-0f50-4354-8dd8-f9fe584df21a
f5942a7d-3671-40ae-927f-9e3373c66426	65b99a1a-a853-47f7-bdf8-104f76aaab22	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.306-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.23-04	84525335-0f50-4354-8dd8-f9fe584df21a
da624883-60f1-48a2-bddc-9b4a1449ad6a	73b6c3ea-559e-4bc0-88e7-0e20730e2455	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.514-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.41-04	84525335-0f50-4354-8dd8-f9fe584df21a
2289c09a-2b08-4e39-a4b2-9ba439486e92	fe759c88-d7ce-4340-be48-081167e21453	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.518-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.443-04	84525335-0f50-4354-8dd8-f9fe584df21a
00c0b832-c948-40ff-8016-84c7cf3dc09e	21909320-9ec5-45ee-81db-c28dc82e3a3b	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.823-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.632-04	84525335-0f50-4354-8dd8-f9fe584df21a
51bb4d73-98d5-4910-a860-274d70afc7ad	fb198851-cd6a-40bc-97d0-630a6ed4dec2	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.828-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.663-04	84525335-0f50-4354-8dd8-f9fe584df21a
4342a5eb-04f1-45e9-b948-7aaf3c93cb08	afabc446-9a56-4b18-8386-141cfbb34a48	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.826-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.535-04	84525335-0f50-4354-8dd8-f9fe584df21a
84b918d4-e53e-4a11-b9e0-76b61bc5b8d2	b726191f-70d5-4e53-bb28-b9d225efdbcb	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.811-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.598-04	84525335-0f50-4354-8dd8-f9fe584df21a
5a4c1744-c33b-4b85-8126-c5cc79468b45	793eb969-b576-4126-bba3-39284f5c1429	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.818-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.568-04	84525335-0f50-4354-8dd8-f9fe584df21a
5c068b0f-34bb-4763-8470-b44f58ff20e9	25893b4a-38af-4d88-bb07-27f7d6011ce3	83b048fc-233b-4c03-b80c-64fa2205b518	\N	\N	1	0	2015-04-04 17:24:45.831-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:24:45.693-04	84525335-0f50-4354-8dd8-f9fe584df21a
4a697ee0-a2e9-4022-8b77-972b34632e39	fe759c88-d7ce-4340-be48-081167e21453	aae962f5-78ac-41e8-8781-580c4461d3fc	\N	\N	1	0	2015-04-04 17:25:54.53-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.451-04	84525335-0f50-4354-8dd8-f9fe584df21a
db9154d4-4d09-47a2-a7aa-188d0ce0614e	80881761-08a2-4d02-ae1e-287610944eeb	aae962f5-78ac-41e8-8781-580c4461d3fc	\N	\N	1	0	2015-04-04 17:25:54.548-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.422-04	84525335-0f50-4354-8dd8-f9fe584df21a
610f1043-a432-499d-bffa-c0d49c388fdd	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	aae962f5-78ac-41e8-8781-580c4461d3fc	\N	\N	1	0	2015-04-04 17:25:54.55-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.481-04	84525335-0f50-4354-8dd8-f9fe584df21a
f3fb910a-b91c-44ed-b2b9-cefa503eb50b	25893b4a-38af-4d88-bb07-27f7d6011ce3	aae962f5-78ac-41e8-8781-580c4461d3fc	\N	\N	1	0	2015-04-04 17:25:54.772-04	84525335-0f50-4354-8dd8-f9fe584df21a	2015-04-04 17:25:54.714-04	84525335-0f50-4354-8dd8-f9fe584df21a
c2ed65ac-ffac-40d1-a73e-c9b5bb451225	567f33cf-7575-4334-b720-dfd7515d4f64	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.107-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.187-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
a0a7e8df-3483-4385-88ca-9bea0bb6d970	73b6c3ea-559e-4bc0-88e7-0e20730e2455	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.345-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.364-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
c8dd67c2-81b9-4f34-8423-120e63298e79	afabc446-9a56-4b18-8386-141cfbb34a48	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.603-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.794-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
e6ecff1e-e0f9-4416-8eba-f685be0e48a6	65b99a1a-a853-47f7-bdf8-104f76aaab22	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.112-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.801-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
610aed76-6d76-466f-8470-1b534c277bc7	793eb969-b576-4126-bba3-39284f5c1429	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.601-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.807-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
e0f3a07e-f553-40e0-8f89-aea06932211e	21909320-9ec5-45ee-81db-c28dc82e3a3b	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.6-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.81-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
7621c14c-d994-4996-a1af-cfed25a3bcb8	b726191f-70d5-4e53-bb28-b9d225efdbcb	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.598-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.813-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
b244d1f8-984f-4dd9-8d54-8b41612cbf29	fe759c88-d7ce-4340-be48-081167e21453	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.34-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:38.814-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
7ec1548c-81d0-4431-8f82-63f791b54014	fb198851-cd6a-40bc-97d0-630a6ed4dec2	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.596-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:39.07-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
a985f92b-28fb-4f12-9986-c1993a0a9e2a	25893b4a-38af-4d88-bb07-27f7d6011ce3	394cc482-a9ec-4254-84d4-344ca42f5d23	\N	\N	1	1	2015-04-09 18:02:14.633-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-04-09 21:16:39.067-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
3932adfc-35c5-4e05-92cf-80b752917abe	afabc446-9a56-4b18-8386-141cfbb34a48	689afa76-eb3e-4044-97b9-f52f6d3238a3	\N	\N	1	0	2015-04-14 13:15:30.34-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:30.204-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
934c0026-fe34-467e-ba2b-d82109b73cf6	501e6867-db1a-48cf-a14d-3a53c9a5b63f	689afa76-eb3e-4044-97b9-f52f6d3238a3	\N	\N	1	0	2015-04-14 13:15:30.346-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:30.266-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
22438fa3-d156-404b-b2b5-039ce132f0c2	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	689afa76-eb3e-4044-97b9-f52f6d3238a3	\N	\N	1	0	2015-04-14 13:15:30.358-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:30.236-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
810a634b-d392-4a21-ac36-fecc79634e0e	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	689afa76-eb3e-4044-97b9-f52f6d3238a3	\N	\N	1	0	2015-04-14 13:15:30.486-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:30.432-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
c453db59-c0ee-4092-809c-8125935e0c1a	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	689afa76-eb3e-4044-97b9-f52f6d3238a3	\N	\N	1	0	2015-04-14 13:15:30.554-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39	2015-04-14 13:15:30.503-04	5f3be4e3-90aa-4963-9cc2-ed7f734c6c39
fb1febdf-cb9a-4019-9c2b-873a4efa5e16	65b99a1a-a853-47f7-bdf8-104f76aaab22	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.03-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.817-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
97a29054-216d-4a32-81ae-5ed31ee20a41	afabc446-9a56-4b18-8386-141cfbb34a48	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.031-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.859-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
eae36484-ed23-4897-860c-d024aff90762	567f33cf-7575-4334-b720-dfd7515d4f64	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.023-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.782-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
7f1cd1e8-a45f-43f1-a6b6-550a09800ea3	793eb969-b576-4126-bba3-39284f5c1429	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.053-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.886-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
d39e948c-dfc0-43eb-b580-1ddefb741c15	b726191f-70d5-4e53-bb28-b9d225efdbcb	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.069-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.914-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
7d2b1a4f-2784-4430-96a8-b6d91e622969	21909320-9ec5-45ee-81db-c28dc82e3a3b	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.073-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:35.941-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
97ffb9a9-5983-4ab5-bab7-3a05222b8543	fe759c88-d7ce-4340-be48-081167e21453	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.472-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:36.313-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
3d300840-8eb9-49e2-8efa-2aedeacc2502	fb198851-cd6a-40bc-97d0-630a6ed4dec2	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.502-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:36.34-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
02cd5043-35a1-47bf-ad9a-2cfc7fcb7695	25893b4a-38af-4d88-bb07-27f7d6011ce3	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.488-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:36.368-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
3653c58f-e15b-48df-9f0a-95e6a5aee047	73b6c3ea-559e-4bc0-88e7-0e20730e2455	ceed51c9-8266-4407-b7b1-a5f6bcd77720	\N	\N	1	0	2015-04-18 02:30:36.5-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:30:36.28-04	f4ff4de4-2322-447c-ae14-d1e9945c523f
9d201a6b-e42c-40c4-a97b-9bc332289d14	b910c68c-0ea3-4887-ad4a-f7313bd007e3	efe58d23-5903-4846-a7c4-c824bcd83622	\N	\N	1	0	2015-04-18 03:29:38.838-04	41072458-fade-43dc-a1d8-543db6c37a49	2015-04-18 03:29:38.785-04	41072458-fade-43dc-a1d8-543db6c37a49
b187ce11-b88f-4d2a-a99a-aaa78946124b	eb970c6a-8430-4422-a233-032fea8ce39c	55958483-d103-4913-9c50-7a447d505634	\N	\N	1	0	2015-04-23 17:43:40.042-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:39.974-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
b973f10b-a40f-4875-a64f-72c503f8cc75	fe759c88-d7ce-4340-be48-081167e21453	55958483-d103-4913-9c50-7a447d505634	\N	\N	1	0	2015-04-23 17:43:40.402-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:40.333-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
f386b063-529a-4882-8237-16f185f1ffcb	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	55958483-d103-4913-9c50-7a447d505634	\N	\N	1	0	2015-04-23 17:43:40.516-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:40.454-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
70b064c7-4e6f-48ea-9fce-f7a63536a8d3	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	55958483-d103-4913-9c50-7a447d505634	\N	\N	1	0	2015-04-23 17:43:40.684-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:40.623-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
91356303-dfb2-431d-880f-cc6509c26d95	25893b4a-38af-4d88-bb07-27f7d6011ce3	55958483-d103-4913-9c50-7a447d505634	\N	\N	1	0	2015-04-23 17:43:40.816-04	c1c09c37-9dad-4c77-860e-26a64bdedba2	2015-04-23 17:43:40.754-04	c1c09c37-9dad-4c77-860e-26a64bdedba2
1972cd42-d057-4700-a18c-88e9ec6da78c	ce780dbe-0148-4e67-b478-4fea4cb405fc	3d85d290-cef4-4b65-a7d3-3a6d6341dd78	\N	\N	1	0	2015-04-28 08:01:16.13-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:01:16.054-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
9aca96fd-59e9-4c2b-8b37-010c96298df7	b910c68c-0ea3-4887-ad4a-f7313bd007e3	42efff15-c066-45b5-a8bf-ae1eb85fb502	\N	\N	1	1	2015-04-28 08:01:16.14-04	547b9e45-ff74-4626-a9b2-1df9b6001d84	2015-04-28 08:24:25.048-04	547b9e45-ff74-4626-a9b2-1df9b6001d84
4ee46ca7-6415-4f8f-be9a-35230db68626	e868ee90-8a90-4aec-88e3-00365cf64a94	d95c107b-58e6-4410-9e0a-4d9749daec39	\N	\N	1	1	2015-05-02 18:13:29.651-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:33.798-04	350a236f-f780-40e9-85e3-2b9227f4d76f
9576beba-e97d-46ec-90db-3c19fc304340	47bfb33c-9dae-4315-a57e-a904072e6d08	d95c107b-58e6-4410-9e0a-4d9749daec39	\N	\N	1	1	2015-05-02 18:13:29.68-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:33.818-04	350a236f-f780-40e9-85e3-2b9227f4d76f
07d44114-7ffe-42d0-97e5-9104648620af	8375c3b0-7da7-4c0a-8f44-15c5ed645010	d95c107b-58e6-4410-9e0a-4d9749daec39	\N	\N	1	1	2015-05-02 18:13:29.79-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:33.825-04	350a236f-f780-40e9-85e3-2b9227f4d76f
7d1a9714-09a5-4684-b1bb-8e5ad71e87d2	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d95c107b-58e6-4410-9e0a-4d9749daec39	\N	\N	1	1	2015-05-02 18:13:29.676-04	350a236f-f780-40e9-85e3-2b9227f4d76f	2015-05-02 18:14:33.823-04	350a236f-f780-40e9-85e3-2b9227f4d76f
9985bf16-d34f-4a2b-8e94-d7566b31f01e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9e3014ad-98b2-48e4-9308-cf65a4c8785b	\N	\N	1	0	2015-05-13 22:53:26.489-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:53:26.407-04	d7bb1e62-fe40-4774-a432-03bd53510708
ea81410b-00f8-4dac-a3a5-a81032a5b32f	47bfb33c-9dae-4315-a57e-a904072e6d08	9e3014ad-98b2-48e4-9308-cf65a4c8785b	\N	\N	1	0	2015-05-13 22:53:26.886-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:53:26.763-04	d7bb1e62-fe40-4774-a432-03bd53510708
b31af086-805c-45c1-9e2b-8a755676fb6b	8375c3b0-7da7-4c0a-8f44-15c5ed645010	9e3014ad-98b2-48e4-9308-cf65a4c8785b	\N	\N	1	0	2015-05-13 22:53:26.927-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:53:26.816-04	d7bb1e62-fe40-4774-a432-03bd53510708
a2875401-7323-4992-ae06-481b5db1a859	e868ee90-8a90-4aec-88e3-00365cf64a94	9e3014ad-98b2-48e4-9308-cf65a4c8785b	\N	\N	1	0	2015-05-13 22:53:26.956-04	d7bb1e62-fe40-4774-a432-03bd53510708	2015-05-13 22:53:26.893-04	d7bb1e62-fe40-4774-a432-03bd53510708
c8c8dad3-22ae-4eaf-a610-a9cb5c286fc8	e9d51055-8986-4190-a7ee-98a77dc268b0	cdaaa7f6-fb68-4d93-b2fb-d60aba62529e	\N	\N	1	0	2015-05-18 16:06:29.076-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:06:29.009-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4056104a-342a-405e-a1db-4f1c4c1fdc0a	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	cdaaa7f6-fb68-4d93-b2fb-d60aba62529e	\N	\N	1	0	2015-05-18 16:06:29.35-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-05-18 16:06:29.297-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
270b1451-4e05-4303-977f-365721d0f613	afabc446-9a56-4b18-8386-141cfbb34a48	24b3d24e-9f68-41f5-9fa2-724bfb8366f1	\N	\N	1	0	2015-05-19 00:20:30.65-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.56-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
dec42386-008d-4a83-8ec4-dfbd13d11504	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	24b3d24e-9f68-41f5-9fa2-724bfb8366f1	\N	\N	1	0	2015-05-19 00:20:30.978-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.807-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
63dfe593-57fd-4b31-bd0e-863f2ed03902	501e6867-db1a-48cf-a14d-3a53c9a5b63f	24b3d24e-9f68-41f5-9fa2-724bfb8366f1	\N	\N	1	0	2015-05-19 00:20:31.002-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.84-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
0a4b52b8-895c-4e3f-852e-d462f4a03b16	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	24b3d24e-9f68-41f5-9fa2-724bfb8366f1	\N	\N	1	0	2015-05-19 00:20:31-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.878-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
fbcb3519-e6eb-486c-a6d4-50c6e8c2c123	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	24b3d24e-9f68-41f5-9fa2-724bfb8366f1	\N	\N	1	0	2015-05-19 00:20:31.003-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7	2015-05-19 00:20:30.767-04	c35a84cb-0f2f-45e2-8ef8-0165189944c7
e9a135fd-e198-4cd3-b983-5e36ea246d7b	e9d51055-8986-4190-a7ee-98a77dc268b0	c7cb5b68-0429-4882-8999-8a5d144698c5	\N	\N	1	1	2015-05-20 15:18:38.472-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:19:05.976-04	06169b04-bb68-4868-b995-98388fa33e16
2d2acbc2-96dd-4d01-85a2-ca0172d1697e	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	c7cb5b68-0429-4882-8999-8a5d144698c5	\N	\N	1	1	2015-05-20 15:18:38.462-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 15:19:05.98-04	06169b04-bb68-4868-b995-98388fa33e16
6aa68cf5-4ec2-4237-83cb-828f96308427	47bfb33c-9dae-4315-a57e-a904072e6d08	436997cd-959f-4478-98e3-1b7f292b1264	\N	\N	1	0	2015-05-23 13:48:42.671-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:48:42.509-04	06169b04-bb68-4868-b995-98388fa33e16
77c0452e-6c44-4a92-a974-10781e98d86b	fe759c88-d7ce-4340-be48-081167e21453	436997cd-959f-4478-98e3-1b7f292b1264	\N	\N	1	0	2015-05-23 13:48:42.665-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:48:42.541-04	06169b04-bb68-4868-b995-98388fa33e16
1dc62fd0-9a83-4813-b7c1-548b310a4f1f	8375c3b0-7da7-4c0a-8f44-15c5ed645010	436997cd-959f-4478-98e3-1b7f292b1264	\N	\N	1	0	2015-05-23 13:48:42.695-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:48:42.58-04	06169b04-bb68-4868-b995-98388fa33e16
26628714-14b6-489f-abc9-1566f3b18a5b	25893b4a-38af-4d88-bb07-27f7d6011ce3	436997cd-959f-4478-98e3-1b7f292b1264	\N	\N	1	0	2015-05-23 13:48:42.703-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:48:42.621-04	06169b04-bb68-4868-b995-98388fa33e16
8a228643-5b64-4126-a990-2a462df8ac06	47bfb33c-9dae-4315-a57e-a904072e6d08	25ce786f-6218-4b28-874c-a127fa6a50ce	\N	\N	1	0	2015-05-27 17:26:44.919-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.719-04	06169b04-bb68-4868-b995-98388fa33e16
336cfbbf-d0f8-40a7-bfa6-ac72e3ff0304	16f9d96b-0acc-4506-8d70-5da5ae52a5ad	25ce786f-6218-4b28-874c-a127fa6a50ce	\N	\N	1	0	2015-05-27 17:26:44.948-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.752-04	06169b04-bb68-4868-b995-98388fa33e16
c8dd9344-2cff-44a5-b31d-b3334d1c0182	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	25ce786f-6218-4b28-874c-a127fa6a50ce	\N	\N	1	0	2015-05-27 17:26:44.955-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.784-04	06169b04-bb68-4868-b995-98388fa33e16
c8e8200c-4e76-461f-bf7c-e04f6d5b0c8c	fe759c88-d7ce-4340-be48-081167e21453	25ce786f-6218-4b28-874c-a127fa6a50ce	\N	\N	1	0	2015-05-27 17:26:44.959-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.826-04	06169b04-bb68-4868-b995-98388fa33e16
ffa78020-e47e-418e-882a-719e1c9f0ac0	8375c3b0-7da7-4c0a-8f44-15c5ed645010	25ce786f-6218-4b28-874c-a127fa6a50ce	\N	\N	1	0	2015-05-27 17:26:44.961-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 17:26:44.684-04	06169b04-bb68-4868-b995-98388fa33e16
1cc1e60c-b814-4fdd-b2e4-d57c664caa39	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9	0b1c3c57-303f-4ff9-9026-ba8229d78a31	\N	\N	1	0	2015-06-01 12:04:53.86-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:53.782-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c026026b-ec53-40eb-a801-678f25b9ce2b	e9d51055-8986-4190-a7ee-98a77dc268b0	0b1c3c57-303f-4ff9-9026-ba8229d78a31	\N	\N	1	0	2015-06-01 12:04:53.865-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:04:53.752-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
d1680d20-e5e7-4ad8-b3c3-41a860ed1307	ddaba673-2c58-47b5-99ef-dc31fe5285d3	97d49349-ebd2-4f6c-8f6a-b39f47dd8f90	\N	\N	1	0	2015-06-01 12:05:52.071-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:05:52.015-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4e0e6d3c-4d18-4534-9b97-9cc5bd8ea207	400dd88c-8266-4311-9a9f-5073977ff64c	97d49349-ebd2-4f6c-8f6a-b39f47dd8f90	\N	\N	1	0	2015-06-01 12:05:52.422-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:05:52.327-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
fae86b9e-f4da-43b8-a6ed-24460a0e5071	5ace29a1-0b40-4ec3-9084-26b98b410a80	97d49349-ebd2-4f6c-8f6a-b39f47dd8f90	\N	\N	1	0	2015-06-01 12:05:52.438-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:05:52.354-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
cc4e6795-e7e3-48fa-9832-77771860adf1	18362ca7-9064-4bdb-a289-edf087cac828	97d49349-ebd2-4f6c-8f6a-b39f47dd8f90	\N	\N	1	0	2015-06-01 12:05:52.456-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:05:52.296-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
95d50e8d-3142-45e6-baca-30ea7bb55a33	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	c851b5b3-b994-4782-9de2-ecd5b0fd6422	\N	\N	1	0	2015-06-01 12:06:48.314-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:06:48.252-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7f593b2e-e644-48ec-86dd-fc5888b60eeb	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	c851b5b3-b994-4782-9de2-ecd5b0fd6422	\N	\N	1	0	2015-06-01 12:06:48.705-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:06:48.597-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
fa6a71d1-dc67-4f69-94d5-23e564f8d7d2	80881761-08a2-4d02-ae1e-287610944eeb	c851b5b3-b994-4782-9de2-ecd5b0fd6422	\N	\N	1	0	2015-06-01 12:06:48.712-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:06:48.569-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7363d3d9-7d6c-4fa5-93cf-88e464ac2d88	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	c851b5b3-b994-4782-9de2-ecd5b0fd6422	\N	\N	1	0	2015-06-01 12:06:48.717-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:06:48.652-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
bbe3a307-12ff-426c-a436-3396f27019fa	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	f6620af1-dade-4947-b1c7-1ac1f57697c6	\N	\N	1	0	2015-06-01 12:07:09.061-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:07:08.824-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
d1974e27-2ad9-4530-b82b-7345ead69962	80881761-08a2-4d02-ae1e-287610944eeb	f6620af1-dade-4947-b1c7-1ac1f57697c6	\N	\N	1	0	2015-06-01 12:07:09.062-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:07:08.933-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
2f7620c3-e3c4-451f-86b3-7bd2f7de20cd	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	f6620af1-dade-4947-b1c7-1ac1f57697c6	\N	\N	1	0	2015-06-01 12:07:09.051-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:07:08.858-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
d2acd62b-b437-477c-b696-67f6e1478a8c	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	f6620af1-dade-4947-b1c7-1ac1f57697c6	\N	\N	1	0	2015-06-01 12:07:09.059-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-01 12:07:08.9-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
6c488c01-efe9-4189-bc2f-7a4f03c634aa	afabc446-9a56-4b18-8386-141cfbb34a48	b16213cc-b812-45f5-be49-2f8f32bd8cea	\N	\N	1	0	2015-06-03 19:43:58.261-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:58.162-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
b9d061e2-ebf9-458e-ac5e-02fdacd7d89d	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	b16213cc-b812-45f5-be49-2f8f32bd8cea	\N	\N	1	0	2015-06-03 19:43:58.684-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:58.485-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
f6e1065a-60af-4a19-bd49-ec4c3ee97ef5	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	b16213cc-b812-45f5-be49-2f8f32bd8cea	\N	\N	1	0	2015-06-03 19:43:58.706-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:58.571-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
320fcadc-f74c-4daf-a109-ca10cdec3f3a	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	b16213cc-b812-45f5-be49-2f8f32bd8cea	\N	\N	1	0	2015-06-03 19:43:58.708-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:58.525-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
3bbc7f28-777b-4bc3-8875-16e7e21c796d	501e6867-db1a-48cf-a14d-3a53c9a5b63f	b16213cc-b812-45f5-be49-2f8f32bd8cea	\N	\N	1	0	2015-06-03 19:43:58.714-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:43:58.608-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
dae0fdcc-93b2-4ad2-a12d-719b5f1b940f	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	d3b7dbd6-1b43-4e66-855d-548bc20f225a	\N	\N	1	0	2015-06-03 19:44:39.283-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:39.184-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
a10bf96b-7aa4-4275-995c-0b3a6e43f7ae	501e6867-db1a-48cf-a14d-3a53c9a5b63f	d3b7dbd6-1b43-4e66-855d-548bc20f225a	\N	\N	1	0	2015-06-03 19:44:39.293-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:39.211-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c87026a1-3d97-43eb-8933-ab049bac628b	afabc446-9a56-4b18-8386-141cfbb34a48	d3b7dbd6-1b43-4e66-855d-548bc20f225a	\N	\N	1	0	2015-06-03 19:44:39.298-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:39.154-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
fac60755-909b-4893-bf51-929c57e92a33	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	d3b7dbd6-1b43-4e66-855d-548bc20f225a	\N	\N	1	0	2015-06-03 19:44:39.535-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:39.476-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4242189c-ceed-445e-9ece-6a6bff36cecf	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	d3b7dbd6-1b43-4e66-855d-548bc20f225a	\N	\N	1	0	2015-06-03 19:44:39.54-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:44:39.438-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
060b5ebb-03e5-4a38-8dc8-1ea8ea6ea95f	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	c77a6dda-6284-4049-a939-3698e45c302f	\N	\N	1	1	2015-06-03 19:52:00.076-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:03.994-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
ae4b85e0-7ebe-4646-9e6c-42721d22c484	501e6867-db1a-48cf-a14d-3a53c9a5b63f	c77a6dda-6284-4049-a939-3698e45c302f	\N	\N	1	1	2015-06-03 19:52:00.105-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:04.031-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
e2cd80ab-1b3c-4ce6-82c3-3907ba3df0cb	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	c77a6dda-6284-4049-a939-3698e45c302f	\N	\N	1	1	2015-06-03 19:52:00.137-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:04.037-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
caf13e0d-4b4c-4802-8edf-a19eade3547e	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	c77a6dda-6284-4049-a939-3698e45c302f	\N	\N	1	1	2015-06-03 19:52:00.107-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:04.025-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
29ad7996-e1e0-471b-b72d-fcb5f5809dad	afabc446-9a56-4b18-8386-141cfbb34a48	c77a6dda-6284-4049-a939-3698e45c302f	\N	\N	1	1	2015-06-03 19:51:58.889-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-03 19:52:04.039-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
0e555cb1-f3ce-47e0-80a5-848863ccfb08	b910c68c-0ea3-4887-ad4a-f7313bd007e3	e1a629b4-a1e7-4c49-b7e6-5641f86d9628	\N	\N	1	0	2015-06-23 10:37:43.833-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:37:43.761-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7511695c-5ec5-4f9e-a75d-75237a8ad802	b910c68c-0ea3-4887-ad4a-f7313bd007e3	f71fd9ae-7da6-446f-8deb-151c4be8122b	\N	\N	1	0	2015-06-23 10:38:30.62-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:38:30.562-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
d04bacf0-0b4f-4d49-a12a-efd894265ad6	b910c68c-0ea3-4887-ad4a-f7313bd007e3	370d6908-29a7-4ec7-8567-890598892732	\N	\N	1	0	2015-06-23 10:39:00.791-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:39:00.741-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
9d165488-5383-49ec-8d59-2976f566cd02	b910c68c-0ea3-4887-ad4a-f7313bd007e3	618fccd8-782f-4648-a440-38ac99e48ee0	\N	\N	1	0	2015-06-23 10:39:59.605-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:39:59.552-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
6e392700-dca6-433e-9698-3bd5b2e5609d	b910c68c-0ea3-4887-ad4a-f7313bd007e3	fad81990-e24d-4f2a-bd67-92f9ce06f000	\N	\N	1	0	2015-06-23 10:43:04.983-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:43:04.932-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
40f1196f-1896-4ff2-ba0f-a8c70f4caa21	b910c68c-0ea3-4887-ad4a-f7313bd007e3	c334e3ad-fc0f-4ff4-9474-5a64783f05b9	\N	\N	1	0	2015-06-23 10:43:41.283-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:43:41.214-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
e7513e78-e2da-41a1-bfb8-be0610cc8825	b910c68c-0ea3-4887-ad4a-f7313bd007e3	354554d2-7af4-40f6-94cd-84becefa2ff0	\N	\N	1	0	2015-06-23 10:44:15.256-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:44:15.194-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
9ab24897-6680-4ef7-a1e6-ba643796a036	b910c68c-0ea3-4887-ad4a-f7313bd007e3	7ac76506-299e-44b2-bdbb-25232251bf48	\N	\N	1	0	2015-06-23 10:44:54.908-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:44:54.843-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
1f75a49f-fc52-4c3c-ad0b-ad76b9b6b79f	b910c68c-0ea3-4887-ad4a-f7313bd007e3	29e22cd7-89ae-46fc-84e5-830ff3032294	\N	\N	1	0	2015-06-23 10:45:15.712-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:15.652-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
6e3c97a6-f142-44b1-afa6-76a3fed56c61	b910c68c-0ea3-4887-ad4a-f7313bd007e3	56beb55c-b2ce-4819-a052-223fdf19939c	\N	\N	1	0	2015-06-23 10:45:37.716-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:37.665-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
506ab733-3819-4b51-8b78-1b59d7de2105	b910c68c-0ea3-4887-ad4a-f7313bd007e3	5fc7a35b-94d0-4998-b774-c5d9a9b280f0	\N	\N	1	0	2015-06-23 10:45:56.601-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 10:45:56.547-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4bd8cf45-1154-4044-ad58-aefb619eebf1	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	3923b349-b023-444b-9d63-48cc7b2dcc01	\N	\N	1	0	2015-06-23 11:01:49.874-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:01:49.822-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
099f7ae3-5e92-481d-aa1e-fdb7cbd19822	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	3923b349-b023-444b-9d63-48cc7b2dcc01	\N	\N	1	0	2015-06-23 11:01:50.289-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:01:50.179-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
11fa57f0-0617-4a5f-9156-5c138470e6e8	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	3923b349-b023-444b-9d63-48cc7b2dcc01	\N	\N	1	0	2015-06-23 11:01:50.297-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:01:50.144-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
474de876-4210-4a35-9e3e-f2ee54961356	80881761-08a2-4d02-ae1e-287610944eeb	3923b349-b023-444b-9d63-48cc7b2dcc01	\N	\N	1	0	2015-06-23 11:01:50.303-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:01:50.217-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
150de84e-067b-4182-a5c9-6726c7dd0790	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	69cab3b4-a3d1-4f27-aff9-6beafabcfa29	\N	\N	1	0	2015-06-23 11:03:22.556-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:03:22.499-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
f941bd68-0a72-4e7c-8513-c13cfc35c3c6	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	69cab3b4-a3d1-4f27-aff9-6beafabcfa29	\N	\N	1	0	2015-06-23 11:03:22.899-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:03:22.846-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4bd0554f-9465-4f2a-b45f-70cb87210ead	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	69cab3b4-a3d1-4f27-aff9-6beafabcfa29	\N	\N	1	0	2015-06-23 11:03:22.943-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:03:22.818-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
386ef0b6-f289-4db8-a3ba-ed15ac8ac1f5	80881761-08a2-4d02-ae1e-287610944eeb	69cab3b4-a3d1-4f27-aff9-6beafabcfa29	\N	\N	1	0	2015-06-23 11:03:22.959-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-06-23 11:03:22.909-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
e47c7f51-71ef-4a88-a6af-fba1688c7914	e868ee90-8a90-4aec-88e3-00365cf64a94	1332d396-5616-473f-baed-44b1e3ad0951	\N	\N	1	0	2015-07-02 14:25:33.882-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.74-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
ad31f112-29ff-470a-96d3-917bb5129df5	47bfb33c-9dae-4315-a57e-a904072e6d08	1332d396-5616-473f-baed-44b1e3ad0951	\N	\N	1	0	2015-07-02 14:25:33.893-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.779-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
d8b17862-cddb-4a3b-b393-7f23991f141c	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	1332d396-5616-473f-baed-44b1e3ad0951	\N	\N	1	0	2015-07-02 14:25:33.895-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:33.698-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
1e1f3993-ae60-4f01-a0e1-fa18a98cd785	8375c3b0-7da7-4c0a-8f44-15c5ed645010	ae3f1353-8162-479f-afbe-f6b19877610d	\N	\N	1	0	2015-07-02 14:25:34.343-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.067-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4fc0ac4f-c0df-4e82-876a-2383c8fe51b0	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	87585b95-7ff3-416c-ad9c-9c50410a869b	\N	\N	1	0	2015-07-02 14:25:34.36-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.104-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
bd97bab4-ef2f-4b21-854a-4400b19f25ed	8375c3b0-7da7-4c0a-8f44-15c5ed645010	1332d396-5616-473f-baed-44b1e3ad0951	\N	\N	1	0	2015-07-02 14:25:34.358-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.14-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
c6684f17-bcac-411b-ab1c-6ed61fb184e5	e868ee90-8a90-4aec-88e3-00365cf64a94	ae3f1353-8162-479f-afbe-f6b19877610d	\N	\N	1	0	2015-07-02 14:25:34.362-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.224-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
bc1d2076-4bb0-4474-bd17-e1b412149f37	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	ae3f1353-8162-479f-afbe-f6b19877610d	\N	\N	1	0	2015-07-02 14:25:34.353-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.188-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
f8935cc7-e5f1-4b1c-8a36-1740ceac9a71	47bfb33c-9dae-4315-a57e-a904072e6d08	ae3f1353-8162-479f-afbe-f6b19877610d	\N	\N	1	0	2015-07-02 14:25:34.365-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.018-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
10552a00-1364-4cbe-bbb3-46779bc2f06c	8375c3b0-7da7-4c0a-8f44-15c5ed645010	87585b95-7ff3-416c-ad9c-9c50410a869b	\N	\N	1	0	2015-07-02 14:25:34.816-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.698-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
1aa70fe2-5733-48f9-bdd4-bcc9c9da47e4	47bfb33c-9dae-4315-a57e-a904072e6d08	87585b95-7ff3-416c-ad9c-9c50410a869b	\N	\N	1	0	2015-07-02 14:25:34.824-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.732-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
5fb63e8c-85d3-4358-ad38-8e63d2e35f88	e868ee90-8a90-4aec-88e3-00365cf64a94	87585b95-7ff3-416c-ad9c-9c50410a869b	\N	\N	1	0	2015-07-02 14:25:34.826-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:25:34.66-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
b8c30f64-4821-4beb-9530-9a355732314d	afabc446-9a56-4b18-8386-141cfbb34a48	535394ad-a692-485d-8b3d-1d867c2663e7	\N	\N	1	0	2015-07-02 14:27:27.095-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:26.993-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
4fe2e812-d281-44b6-8b5e-9bb37eda05a0	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	535394ad-a692-485d-8b3d-1d867c2663e7	\N	\N	1	0	2015-07-02 14:27:27.543-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:27.396-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
58493ff4-f6ca-4e94-ba90-fa736d706a25	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	535394ad-a692-485d-8b3d-1d867c2663e7	\N	\N	1	0	2015-07-02 14:27:27.549-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:27.36-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7c1f5f05-2fd0-4799-8965-077c2036fdbc	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	535394ad-a692-485d-8b3d-1d867c2663e7	\N	\N	1	0	2015-07-02 14:27:27.551-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:27.46-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
5b7be74b-9383-4678-9575-c0cff0037171	501e6867-db1a-48cf-a14d-3a53c9a5b63f	535394ad-a692-485d-8b3d-1d867c2663e7	\N	\N	1	0	2015-07-02 14:27:27.553-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:27:27.428-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
94eff6b2-6352-4cc2-80c1-f1956e6e0cab	afabc446-9a56-4b18-8386-141cfbb34a48	4331f9e6-932d-41a4-a469-5f5fb9d31adb	\N	\N	1	0	2015-07-02 14:29:18.237-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:18.158-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
3028a53f-ac89-47cd-ac56-0701c1370523	501e6867-db1a-48cf-a14d-3a53c9a5b63f	4331f9e6-932d-41a4-a469-5f5fb9d31adb	\N	\N	1	0	2015-07-02 14:29:18.676-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:18.524-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
ec8422e9-235a-4554-a2eb-5318b09f0ad7	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	4331f9e6-932d-41a4-a469-5f5fb9d31adb	\N	\N	1	0	2015-07-02 14:29:18.701-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:18.603-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
ce7a462b-40ca-4f5c-ac55-e8364817210a	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	4331f9e6-932d-41a4-a469-5f5fb9d31adb	\N	\N	1	0	2015-07-02 14:29:18.706-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:18.567-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
45a63a5f-9bc3-4964-9e08-f456cbd877fd	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	4331f9e6-932d-41a4-a469-5f5fb9d31adb	\N	\N	1	0	2015-07-02 14:29:18.708-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:18.482-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
eefc6371-2940-4d90-b003-705ce1b21670	afabc446-9a56-4b18-8386-141cfbb34a48	1f58cc27-4415-4a62-9a6a-936229a50424	\N	\N	1	0	2015-07-02 14:29:52.5-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.45-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7fabc4e8-ff0f-4af9-a0d8-8e3f741ace86	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	1f58cc27-4415-4a62-9a6a-936229a50424	\N	\N	1	0	2015-07-02 14:29:52.899-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.772-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
1b5514ef-3ae9-449f-b1d4-a0ff291001a8	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	1f58cc27-4415-4a62-9a6a-936229a50424	\N	\N	1	0	2015-07-02 14:29:52.918-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.83-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
7f13a4f1-033e-4c29-ae72-0932685e0903	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	1f58cc27-4415-4a62-9a6a-936229a50424	\N	\N	1	0	2015-07-02 14:29:52.922-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.8-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
9dc8cb24-0cca-4dae-8823-1a12b232835a	501e6867-db1a-48cf-a14d-3a53c9a5b63f	1f58cc27-4415-4a62-9a6a-936229a50424	\N	\N	1	0	2015-07-02 14:29:52.924-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597	2015-07-02 14:29:52.731-04	5295bd7f-cd19-46d1-b6d5-3b9ce8a94597
cc8bacaf-88ed-42f3-afb3-fb8e840e21ff	ce780dbe-0148-4e67-b478-4fea4cb405fc	487c50d3-383e-4a78-adaf-0c87c21439b6	\N	\N	1	0	2015-07-05 23:29:51.986-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:29:51.855-04	61709628-4bca-418f-8dc4-1ad358c785d6
9cade801-fb3e-483e-a266-7f5939b64c1d	47bfb33c-9dae-4315-a57e-a904072e6d08	8e4960c8-ff32-4b6b-890c-09990423d20d	\N	\N	1	1	2015-07-05 23:29:51.931-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.142-04	61709628-4bca-418f-8dc4-1ad358c785d6
6a075fff-2aad-422e-b716-af63bee22c45	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	8e4960c8-ff32-4b6b-890c-09990423d20d	c6ddfe98-66f4-4103-96f6-74cd557b5ba5	\N	1	1	2015-07-05 23:29:51.912-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.372-04	61709628-4bca-418f-8dc4-1ad358c785d6
be2c7845-bbd5-49f0-a5fb-87596f1eb7bf	389581aa-a878-4be0-af35-5c153d603516	8e4960c8-ff32-4b6b-890c-09990423d20d	\N	\N	1	1	2015-07-05 23:29:51.929-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.376-04	61709628-4bca-418f-8dc4-1ad358c785d6
d522c814-c334-47aa-952f-dfa55554783e	8375c3b0-7da7-4c0a-8f44-15c5ed645010	8e4960c8-ff32-4b6b-890c-09990423d20d	\N	\N	1	1	2015-07-05 23:29:51.964-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.379-04	61709628-4bca-418f-8dc4-1ad358c785d6
d8813604-5f39-40f1-81b9-2a1afad92b68	a3f29743-f27d-4372-a191-998d7bb90f39	8e4960c8-ff32-4b6b-890c-09990423d20d	\N	\N	1	1	2015-07-05 23:29:51.973-04	61709628-4bca-418f-8dc4-1ad358c785d6	2015-07-05 23:32:46.38-04	61709628-4bca-418f-8dc4-1ad358c785d6
45f70ac5-bf0e-4161-84db-6871aad99440	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9025a2dc-5d54-4882-957f-0c688e9dd44b	\N	\N	1	4	2015-07-13 08:22:57.673-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:06.134-04	5414f676-63e9-4117-87bd-ec5577e932b7
3f367a0a-9f2a-4b98-9ff6-5ff511a7b33f	389581aa-a878-4be0-af35-5c153d603516	9025a2dc-5d54-4882-957f-0c688e9dd44b	\N	\N	1	4	2015-07-13 08:22:57.656-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:06.165-04	5414f676-63e9-4117-87bd-ec5577e932b7
90cb0136-30b0-4ecd-8476-60e387ff0923	47bfb33c-9dae-4315-a57e-a904072e6d08	9025a2dc-5d54-4882-957f-0c688e9dd44b	\N	\N	1	4	2015-07-13 08:22:57.25-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:06.161-04	5414f676-63e9-4117-87bd-ec5577e932b7
bc6eaebe-3920-4fb2-b229-8f03bed261fe	47bfb33c-9dae-4315-a57e-a904072e6d08	23b5e6e4-8fde-46d7-baba-f047d5f386b0	\N	\N	1	0	2015-07-17 21:33:32.99-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:32.929-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
813466fa-f2ee-4911-9487-17d5e4c96575	a3f29743-f27d-4372-a191-998d7bb90f39	9025a2dc-5d54-4882-957f-0c688e9dd44b	\N	\N	1	4	2015-07-13 08:22:57.678-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:06.166-04	5414f676-63e9-4117-87bd-ec5577e932b7
bd7d4738-e344-4f60-bdc0-0d98161810af	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	338ca186-8dc1-499f-ab81-f2605ddecd13	\N	\N	1	0	2015-07-13 08:33:04.803-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:33:04.748-04	5414f676-63e9-4117-87bd-ec5577e932b7
206190ec-4cdc-41c9-9036-1f7da0a0e78e	47bfb33c-9dae-4315-a57e-a904072e6d08	338ca186-8dc1-499f-ab81-f2605ddecd13	\N	\N	1	0	2015-07-13 08:33:05.197-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:33:05.096-04	5414f676-63e9-4117-87bd-ec5577e932b7
6eec835c-852b-4a50-ab6e-15ba3eb3c8df	8375c3b0-7da7-4c0a-8f44-15c5ed645010	338ca186-8dc1-499f-ab81-f2605ddecd13	3d029a3f-177f-4113-bb37-e9310c8a4421	\N	1	0	2015-07-13 08:33:05.216-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:33:05.132-04	5414f676-63e9-4117-87bd-ec5577e932b7
f2e63eb0-ab95-4071-9be9-3e9b667cfadf	e868ee90-8a90-4aec-88e3-00365cf64a94	338ca186-8dc1-499f-ab81-f2605ddecd13	\N	\N	1	0	2015-07-13 08:33:05.212-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:33:05.06-04	5414f676-63e9-4117-87bd-ec5577e932b7
fc5a90f3-11e3-4139-8ce5-e6d6f49fcabc	a3f29743-f27d-4372-a191-998d7bb90f39	23b5e6e4-8fde-46d7-baba-f047d5f386b0	\N	\N	1	0	2015-07-17 21:33:33.522-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:33.371-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
359a1465-ac93-42d3-8968-1247645f1fdb	8375c3b0-7da7-4c0a-8f44-15c5ed645010	23b5e6e4-8fde-46d7-baba-f047d5f386b0	\N	\N	1	0	2015-07-17 21:33:33.537-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:33.339-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
1e70dda9-546e-40a9-b23f-2acd73863c67	389581aa-a878-4be0-af35-5c153d603516	23b5e6e4-8fde-46d7-baba-f047d5f386b0	\N	\N	1	0	2015-07-17 21:33:33.542-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:33.405-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
9c762944-df17-443d-8559-5d75f802751a	8375c3b0-7da7-4c0a-8f44-15c5ed645010	9025a2dc-5d54-4882-957f-0c688e9dd44b	3d029a3f-177f-4113-bb37-e9310c8a4421	\N	1	4	2015-07-13 08:22:57.68-04	5414f676-63e9-4117-87bd-ec5577e932b7	2015-07-13 08:45:06.171-04	5414f676-63e9-4117-87bd-ec5577e932b7
1939cfe4-33ab-4ed7-a0c8-e875cdd9cca7	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	23b5e6e4-8fde-46d7-baba-f047d5f386b0	\N	\N	1	0	2015-07-17 21:33:33.544-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-07-17 21:33:33.439-04	6664d1b2-7618-401f-bde9-d8f5d1c7b757
2d33293b-e363-4346-b904-50d879129432	47bfb33c-9dae-4315-a57e-a904072e6d08	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.715-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.462-04	06169b04-bb68-4868-b995-98388fa33e16
be127af5-5a5a-4627-bcb9-e62fed2ae4a1	8375c3b0-7da7-4c0a-8f44-15c5ed645010	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.734-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.495-04	06169b04-bb68-4868-b995-98388fa33e16
f1f7e70e-2a7e-448a-bd46-d261d6d043b8	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.766-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.531-04	06169b04-bb68-4868-b995-98388fa33e16
ebd371a8-3111-424e-b00c-584ca2631655	fa108c15-c199-4531-bca9-d69bd734a51d	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.77-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.568-04	06169b04-bb68-4868-b995-98388fa33e16
5f456e0f-a640-4875-926f-4e413451cfa0	c4feb540-a64d-4df6-8d88-5702c8730c3d	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.772-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.606-04	06169b04-bb68-4868-b995-98388fa33e16
a22b3d23-2c17-46c7-a919-3ac663637cd3	a0a4078a-3e36-4358-9774-4e3208acee82	f5a40fe7-fa72-4e9d-b1c9-dea5a9525df3	\N	\N	1	0	2015-07-22 17:05:29.776-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 17:05:29.652-04	06169b04-bb68-4868-b995-98388fa33e16
325c142e-7a16-4de3-8014-762922a33cb5	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	22b32160-eb5f-4108-8a10-c3a8b61e4689	\N	\N	1	0	2015-07-22 22:12:26.842-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:26.786-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
18cca1a5-e4c2-4802-8b7e-dd51a45857b7	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	22b32160-eb5f-4108-8a10-c3a8b61e4689	\N	\N	1	0	2015-07-22 22:12:27.099-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:26.989-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
c51dddbd-03dc-4f1f-a022-a7a121d71a9d	80881761-08a2-4d02-ae1e-287610944eeb	22b32160-eb5f-4108-8a10-c3a8b61e4689	\N	\N	1	0	2015-07-22 22:12:27.107-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:26.943-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
c086f21d-c176-4262-b788-1a0180a83c51	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	22b32160-eb5f-4108-8a10-c3a8b61e4689	\N	\N	1	0	2015-07-22 22:12:27.109-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212	2015-07-22 22:12:27.025-04	f165e76a-6fd6-4bbc-a241-c08be8cf4212
18dc552d-0f2b-4af1-8f55-7fddb14537d3	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9e617f38-e335-494d-8665-ee1f362c061f	\N	909ca8a4-6833-42a3-8525-1d45ccaa120b	1	1	2015-08-09 18:12:58.915-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:18:59.566-04	067b4635-5840-48fd-980d-ccddbe1b173d
a52c8502-aa9f-499b-a9b5-9a84a2866058	47bfb33c-9dae-4315-a57e-a904072e6d08	9e617f38-e335-494d-8665-ee1f362c061f	\N	\N	1	1	2015-08-09 18:12:59.063-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:18:59.582-04	067b4635-5840-48fd-980d-ccddbe1b173d
dbb64996-c5fb-4a3a-9956-0cb0b850e3b0	8375c3b0-7da7-4c0a-8f44-15c5ed645010	9e617f38-e335-494d-8665-ee1f362c061f	91ceda97-382c-41d9-8a8f-a6fc4b3ec2b2	\N	1	1	2015-08-09 18:12:59.067-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:18:59.58-04	067b4635-5840-48fd-980d-ccddbe1b173d
d239ff25-a646-42ee-83a7-410cfb3396b8	e868ee90-8a90-4aec-88e3-00365cf64a94	9e617f38-e335-494d-8665-ee1f362c061f	539bca0e-2e9b-47b9-9681-dd692a42c249	\N	1	1	2015-08-09 18:12:58.918-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:18:59.578-04	067b4635-5840-48fd-980d-ccddbe1b173d
6213f81d-a615-4928-854c-53ef43ca0c70	fe759c88-d7ce-4340-be48-081167e21453	68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	\N	\N	1	1	2015-07-24 16:06:14.052-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.54-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
5d10863c-ef0b-4c97-82de-ab0ecd4fe34f	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	\N	\N	1	1	2015-07-24 16:06:14.057-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.567-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
2596dd7d-6915-47b3-9ed0-d55e22d7b7f3	25893b4a-38af-4d88-bb07-27f7d6011ce3	68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	\N	\N	1	1	2015-07-24 16:06:14.072-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.565-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
a9b113d0-e81d-4c89-a0a8-cf5059849994	eb970c6a-8430-4422-a233-032fea8ce39c	68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	\N	\N	1	1	2015-07-24 16:06:14.075-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.569-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
40804604-780f-4efb-ab04-94d1f706e1a1	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	68033c62-6ba9-48cc-8f6e-2e6b5e5edd4b	\N	\N	1	1	2015-07-24 16:06:14.07-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:17:34.562-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
cb7f1067-223a-4583-ae9b-2be59dfd052d	fe759c88-d7ce-4340-be48-081167e21453	d75e85e3-67ca-4c50-998d-727df9a7d9d8	\N	\N	1	2	2015-07-24 16:05:05.181-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.391-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
5bad0923-146d-4d78-98c3-8be27aa6bc24	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	d75e85e3-67ca-4c50-998d-727df9a7d9d8	\N	\N	1	2	2015-07-24 16:05:05.201-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.411-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
f86e75b1-3ebf-4e92-a133-709f5050ab16	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	d75e85e3-67ca-4c50-998d-727df9a7d9d8	\N	\N	1	2	2015-07-24 16:05:05.205-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.415-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
1756a7bf-7241-4c91-adcc-80c786e98d4a	25893b4a-38af-4d88-bb07-27f7d6011ce3	d75e85e3-67ca-4c50-998d-727df9a7d9d8	\N	\N	1	2	2015-07-24 16:05:05.213-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.414-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
279b1b81-ab27-4316-b484-6133f4a9fd64	eb970c6a-8430-4422-a233-032fea8ce39c	d75e85e3-67ca-4c50-998d-727df9a7d9d8	\N	\N	1	2	2015-07-24 16:05:05.226-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640	2015-07-24 16:18:57.417-04	e6a7bafd-4d36-4b2c-8bf4-f58f7f25b640
068ab217-b844-48f0-9f75-bf62af28e142	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	0f148dae-1d35-4740-b564-6317e74f0bb1	\N	\N	1	0	2015-07-29 11:07:00.128-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:07:00.063-04	0a215950-e391-4575-8d45-e5c36c6cb723
04ecaf6e-9553-46ff-805d-2f364c4a70a2	e868ee90-8a90-4aec-88e3-00365cf64a94	0f148dae-1d35-4740-b564-6317e74f0bb1	\N	\N	1	0	2015-07-29 11:07:00.479-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:07:00.371-04	0a215950-e391-4575-8d45-e5c36c6cb723
c6edca9c-1f90-43d4-a38a-9aac275e3890	8375c3b0-7da7-4c0a-8f44-15c5ed645010	0f148dae-1d35-4740-b564-6317e74f0bb1	\N	\N	1	0	2015-07-29 11:07:00.486-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:07:00.399-04	0a215950-e391-4575-8d45-e5c36c6cb723
84c5b232-b280-4325-9334-af9e89ca9b6f	47bfb33c-9dae-4315-a57e-a904072e6d08	0f148dae-1d35-4740-b564-6317e74f0bb1	\N	\N	1	0	2015-07-29 11:07:00.488-04	0a215950-e391-4575-8d45-e5c36c6cb723	2015-07-29 11:07:00.321-04	0a215950-e391-4575-8d45-e5c36c6cb723
2d35b5ef-bafc-4bed-a34a-67a4f7f89a7a	ce780dbe-0148-4e67-b478-4fea4cb405fc	af2a2754-055f-4fe6-a1a1-68840838f4b7	\N	\N	1	9	2015-08-09 18:21:26.223-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:14:31.723-04	067b4635-5840-48fd-980d-ccddbe1b173d
f7fbfc0a-88aa-4cfc-9b53-41ccdfbedc98	65b99a1a-a853-47f7-bdf8-104f76aaab22	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.152-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:15.985-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
1c229000-f1f0-4eef-9636-87a9f096cb99	b726191f-70d5-4e53-bb28-b9d225efdbcb	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.192-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.093-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
64bf8513-24c9-4e74-8623-6048385b7a3a	afabc446-9a56-4b18-8386-141cfbb34a48	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.228-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.066-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
d5b0def5-ee5e-45a8-b8d7-48e8f91d49ff	793eb969-b576-4126-bba3-39284f5c1429	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.199-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.013-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
ad940e33-f87f-4299-a188-6c5b2d500b5f	21909320-9ec5-45ee-81db-c28dc82e3a3b	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.197-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.039-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
b6834627-f78d-4b32-a72c-8fba1faea8c3	567f33cf-7575-4334-b720-dfd7515d4f64	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.231-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:15.949-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
dc891335-af63-4d99-8b20-8c263ec16e7c	73b6c3ea-559e-4bc0-88e7-0e20730e2455	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.272-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.2-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
298a870e-fcef-4250-9774-2fef9a8c8606	fb198851-cd6a-40bc-97d0-630a6ed4dec2	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.465-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.35-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
c1b07afd-45d6-4b46-8d0d-d88cd9cd09a4	25893b4a-38af-4d88-bb07-27f7d6011ce3	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.476-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.383-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
96fa2b1a-b397-46c4-92ed-a135409e5a7d	fe759c88-d7ce-4340-be48-081167e21453	6e79c5ea-54c4-465b-9926-9534c06d883b	\N	\N	1	0	2015-08-11 13:32:16.473-04	8efcd5d9-df90-49c5-bae1-6420e8628e74	2015-08-11 13:32:16.299-04	8efcd5d9-df90-49c5-bae1-6420e8628e74
7f6b5141-2043-4ac9-a960-b86463638077	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	cbc9f776-1a76-4da1-a4de-f069d7410ca7	\N	\N	1	0	2015-08-26 13:35:44.165-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.993-04	e604c054-19e1-4332-b9ae-97ef0c58380f
07c60c6e-24e9-4fc4-aaa3-e71cbd0fb71d	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	cbc9f776-1a76-4da1-a4de-f069d7410ca7	\N	\N	1	0	2015-08-26 13:35:44.183-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:44.032-04	e604c054-19e1-4332-b9ae-97ef0c58380f
e0f26f43-c865-4e3b-957f-1a60e1db7f5e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	cbc9f776-1a76-4da1-a4de-f069d7410ca7	\N	\N	1	0	2015-08-26 13:35:44.185-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:43.949-04	e604c054-19e1-4332-b9ae-97ef0c58380f
aa442fb2-b576-4e2d-93cb-71fba7d940fb	80881761-08a2-4d02-ae1e-287610944eeb	cbc9f776-1a76-4da1-a4de-f069d7410ca7	\N	\N	1	0	2015-08-26 13:35:44.189-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-08-26 13:35:44.068-04	e604c054-19e1-4332-b9ae-97ef0c58380f
ceb02bfc-a8a6-4937-a43e-98306173c947	eb970c6a-8430-4422-a233-032fea8ce39c	739f3012-e061-4de0-ac62-a7631ceeabb8	\N	\N	1	0	2015-08-31 13:06:58.596-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.417-04	2a63f4b8-4436-45bf-9439-866ac59e1911
1f5c3f10-bd4d-4229-a242-1035f2616da8	ce780dbe-0148-4e67-b478-4fea4cb405fc	125358af-ae36-4370-a098-4e99122857b7	\N	\N	1	0	2015-08-09 18:30:34.337-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:30:34.275-04	067b4635-5840-48fd-980d-ccddbe1b173d
63acc67b-67f5-47b6-8930-9cd110bca7f3	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	eaaebdf8-fe9c-4d17-a55e-05c92296f29e	\N	\N	1	4	2015-08-09 18:12:58.864-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:11:37.695-04	067b4635-5840-48fd-980d-ccddbe1b173d
1b6a0e12-291f-4b27-8637-0cfae435d9bc	e868ee90-8a90-4aec-88e3-00365cf64a94	eaaebdf8-fe9c-4d17-a55e-05c92296f29e	\N	\N	1	4	2015-08-09 18:12:58.883-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:11:37.832-04	067b4635-5840-48fd-980d-ccddbe1b173d
db73c4e7-aff4-4560-bc71-dd926ef33ad9	8375c3b0-7da7-4c0a-8f44-15c5ed645010	eaaebdf8-fe9c-4d17-a55e-05c92296f29e	\N	\N	1	4	2015-08-09 18:12:58.912-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:11:38.447-04	067b4635-5840-48fd-980d-ccddbe1b173d
141eba29-cffc-41a0-9eb1-2febaa228392	47bfb33c-9dae-4315-a57e-a904072e6d08	eaaebdf8-fe9c-4d17-a55e-05c92296f29e	\N	\N	1	4	2015-08-09 18:12:58.894-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 19:11:38.568-04	067b4635-5840-48fd-980d-ccddbe1b173d
2e83b89b-bea8-4aa9-93bb-2d76d57cd490	fe759c88-d7ce-4340-be48-081167e21453	9276b5f0-61c2-41e7-9128-17081fa106dc	\N	\N	1	0	2015-08-30 21:43:44.913-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.779-04	89b13534-20eb-49d7-914c-d84a673f858d
4ae1955c-22c1-4d66-b9a9-d4add3990db7	eb970c6a-8430-4422-a233-032fea8ce39c	9276b5f0-61c2-41e7-9128-17081fa106dc	\N	\N	1	0	2015-08-30 21:43:44.91-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.735-04	89b13534-20eb-49d7-914c-d84a673f858d
500e882f-5a6d-4ef9-8cae-154bc1969dce	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	9276b5f0-61c2-41e7-9128-17081fa106dc	\N	\N	1	0	2015-08-30 21:43:44.939-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.823-04	89b13534-20eb-49d7-914c-d84a673f858d
4f4e51b9-832c-492f-a71d-d4290f95cc8e	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	9276b5f0-61c2-41e7-9128-17081fa106dc	\N	\N	1	0	2015-08-30 21:43:44.952-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:44.867-04	89b13534-20eb-49d7-914c-d84a673f858d
c2f27d7e-cb32-4a3b-bf45-8f8658e67bdc	25893b4a-38af-4d88-bb07-27f7d6011ce3	9276b5f0-61c2-41e7-9128-17081fa106dc	\N	\N	1	0	2015-08-30 21:43:45.387-04	89b13534-20eb-49d7-914c-d84a673f858d	2015-08-30 21:43:45.32-04	89b13534-20eb-49d7-914c-d84a673f858d
396addad-9186-48ad-a57d-62ed2102ef6c	fe759c88-d7ce-4340-be48-081167e21453	739f3012-e061-4de0-ac62-a7631ceeabb8	\N	\N	1	0	2015-08-31 13:06:58.635-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.45-04	2a63f4b8-4436-45bf-9439-866ac59e1911
5923bd2a-96b6-4e2e-85c3-be9bb2de860c	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	739f3012-e061-4de0-ac62-a7631ceeabb8	\N	\N	1	0	2015-08-31 13:06:58.641-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.511-04	2a63f4b8-4436-45bf-9439-866ac59e1911
57c1aade-000e-41b6-813e-eed0435d81ec	25893b4a-38af-4d88-bb07-27f7d6011ce3	739f3012-e061-4de0-ac62-a7631ceeabb8	\N	\N	1	0	2015-08-31 13:06:58.639-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.54-04	2a63f4b8-4436-45bf-9439-866ac59e1911
45f65f4a-9a37-490c-95f9-c1f149455c76	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	739f3012-e061-4de0-ac62-a7631ceeabb8	\N	\N	1	0	2015-08-31 13:06:58.643-04	2a63f4b8-4436-45bf-9439-866ac59e1911	2015-08-31 13:06:58.481-04	2a63f4b8-4436-45bf-9439-866ac59e1911
bcdc4860-b9a5-4721-9619-e6d282c78afc	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	d1b8fefd-8f90-4386-b45a-c46c45e1f6fa	\N	\N	1	0	2015-09-04 17:23:33.853-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.695-04	e604c054-19e1-4332-b9ae-97ef0c58380f
1ab50de2-8415-40f7-8d39-e623d2009a08	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	d1b8fefd-8f90-4386-b45a-c46c45e1f6fa	\N	\N	1	0	2015-09-04 17:23:33.885-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.783-04	e604c054-19e1-4332-b9ae-97ef0c58380f
a9de8b08-fcab-4f19-827f-926561dfa4c7	80881761-08a2-4d02-ae1e-287610944eeb	d1b8fefd-8f90-4386-b45a-c46c45e1f6fa	\N	\N	1	0	2015-09-04 17:23:33.896-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.81-04	e604c054-19e1-4332-b9ae-97ef0c58380f
2ddc0dd8-5ad8-40b7-8fec-e62ebdc2f90f	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	d1b8fefd-8f90-4386-b45a-c46c45e1f6fa	\N	\N	1	0	2015-09-04 17:23:33.894-04	e604c054-19e1-4332-b9ae-97ef0c58380f	2015-09-04 17:23:33.739-04	e604c054-19e1-4332-b9ae-97ef0c58380f
b92db1ee-e2ef-4984-bd1d-26c147435236	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	8448dd7c-bf73-4761-b39a-e75f90ae64e9	\N	\N	1	2	2015-10-30 13:07:49.49-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.92-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
8e91778b-0246-455a-ad68-f65ae70810d8	ce780dbe-0148-4e67-b478-4fea4cb405fc	7eea4c3b-2670-4597-9d63-6e42e8c44f7a	\N	\N	1	2	2015-09-10 02:33:15.445-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:34:19-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c
345cc8b7-6995-4e37-88d4-38a8d065b8d4	afabc446-9a56-4b18-8386-141cfbb34a48	7c342b84-b254-44ce-ac26-2442ad4a8064	\N	\N	1	0	2015-10-19 14:46:02.191-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:02.135-04	51855703-9a42-4c37-8418-24da5bf57be7
d53d558d-2230-4148-ad64-8e33aa3c0382	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70	7c342b84-b254-44ce-ac26-2442ad4a8064	\N	\N	1	0	2015-10-19 14:46:02.467-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:02.298-04	51855703-9a42-4c37-8418-24da5bf57be7
1719d734-ca81-45c9-9bce-97e564e61afe	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	7c342b84-b254-44ce-ac26-2442ad4a8064	\N	\N	1	0	2015-10-19 14:46:02.503-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:02.339-04	51855703-9a42-4c37-8418-24da5bf57be7
13ab0a04-a738-4b5f-80cd-fbfff5f43fae	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	7c342b84-b254-44ce-ac26-2442ad4a8064	\N	\N	1	0	2015-10-19 14:46:02.504-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:02.37-04	51855703-9a42-4c37-8418-24da5bf57be7
061857c9-a484-4b05-86fd-3b402e8eb686	501e6867-db1a-48cf-a14d-3a53c9a5b63f	7c342b84-b254-44ce-ac26-2442ad4a8064	\N	\N	1	0	2015-10-19 14:46:02.495-04	51855703-9a42-4c37-8418-24da5bf57be7	2015-10-19 14:46:02.414-04	51855703-9a42-4c37-8418-24da5bf57be7
db189a81-f343-4b37-a5e4-0bbc415893dc	eb970c6a-8430-4422-a233-032fea8ce39c	931b4ca7-30fb-4499-b2de-483974ea5a48	\N	\N	1	0	2015-10-22 18:57:10.645-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:10.556-04	86103f7b-c3bd-489b-a732-10374a07ed5a
33572265-df3b-4a70-8293-9354581c5921	fe759c88-d7ce-4340-be48-081167e21453	931b4ca7-30fb-4499-b2de-483974ea5a48	\N	\N	1	0	2015-10-22 18:57:12.295-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:12.187-04	86103f7b-c3bd-489b-a732-10374a07ed5a
0a72bf83-03fb-460c-a908-8aa8cf8663e1	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	931b4ca7-30fb-4499-b2de-483974ea5a48	\N	\N	1	0	2015-10-22 18:57:12.438-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:12.386-04	86103f7b-c3bd-489b-a732-10374a07ed5a
897d8635-f3fa-47cc-b0ec-25438b9928b3	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	931b4ca7-30fb-4499-b2de-483974ea5a48	\N	\N	1	0	2015-10-22 18:57:12.563-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:12.491-04	86103f7b-c3bd-489b-a732-10374a07ed5a
3850436f-91f9-4242-b959-996e8e85b2ac	25893b4a-38af-4d88-bb07-27f7d6011ce3	931b4ca7-30fb-4499-b2de-483974ea5a48	\N	\N	1	0	2015-10-22 18:57:12.682-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-22 18:57:12.619-04	86103f7b-c3bd-489b-a732-10374a07ed5a
b419172a-a656-4bcb-96b8-776e66867d8d	5ace29a1-0b40-4ec3-9084-26b98b410a80	4e590213-fc10-492e-970d-cd83de4a8c70	\N	\N	1	0	2015-10-27 13:29:24.709-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.529-04	86103f7b-c3bd-489b-a732-10374a07ed5a
108c9045-61fe-43eb-97ac-16661f1d34b8	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f	4e590213-fc10-492e-970d-cd83de4a8c70	\N	\N	1	0	2015-10-27 13:29:24.715-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.578-04	86103f7b-c3bd-489b-a732-10374a07ed5a
1c1934b8-ccff-4fba-9638-4ccdddb7dc57	18362ca7-9064-4bdb-a289-edf087cac828	4e590213-fc10-492e-970d-cd83de4a8c70	\N	\N	1	0	2015-10-27 13:29:24.719-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.409-04	86103f7b-c3bd-489b-a732-10374a07ed5a
9682d89d-d7bc-430c-be89-5af78eaddae0	18362ca7-9064-4bdb-a289-edf087cac828	b02d723a-5f11-43f4-bd69-6c945138cdad	\N	\N	1	0	2015-10-27 13:29:25.052-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.808-04	86103f7b-c3bd-489b-a732-10374a07ed5a
0c41fa8c-9f07-4b85-8e10-6038e4eca539	fa108c15-c199-4531-bca9-d69bd734a51d	4e590213-fc10-492e-970d-cd83de4a8c70	\N	\N	1	0	2015-10-27 13:29:25.057-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.857-04	86103f7b-c3bd-489b-a732-10374a07ed5a
c6c0d46b-c5d6-4995-8bd3-977b10897c69	c4feb540-a64d-4df6-8d88-5702c8730c3d	4e590213-fc10-492e-970d-cd83de4a8c70	\N	\N	1	0	2015-10-27 13:29:25.061-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:24.731-04	86103f7b-c3bd-489b-a732-10374a07ed5a
748f115a-2a6c-4719-a64e-055e80c60a4d	fa108c15-c199-4531-bca9-d69bd734a51d	b02d723a-5f11-43f4-bd69-6c945138cdad	\N	\N	1	0	2015-10-27 13:29:25.38-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.155-04	86103f7b-c3bd-489b-a732-10374a07ed5a
8ee5c837-974f-476d-9332-6070d69c3407	5ace29a1-0b40-4ec3-9084-26b98b410a80	b02d723a-5f11-43f4-bd69-6c945138cdad	\N	\N	1	0	2015-10-27 13:29:25.396-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.09-04	86103f7b-c3bd-489b-a732-10374a07ed5a
9841fd82-995f-45fa-9c4e-92870faa6496	18362ca7-9064-4bdb-a289-edf087cac828	42a3ae0b-5923-45eb-be87-af70ed324c31	\N	\N	1	0	2015-10-27 13:29:25.401-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.233-04	86103f7b-c3bd-489b-a732-10374a07ed5a
5d18384c-b80a-4f43-9157-e56f45a687bb	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f	b02d723a-5f11-43f4-bd69-6c945138cdad	\N	\N	1	0	2015-10-27 13:29:25.402-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.12-04	86103f7b-c3bd-489b-a732-10374a07ed5a
7bb2b60c-378c-403c-97fb-7536e279ac85	c4feb540-a64d-4df6-8d88-5702c8730c3d	b02d723a-5f11-43f4-bd69-6c945138cdad	\N	\N	1	0	2015-10-27 13:29:25.405-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.201-04	86103f7b-c3bd-489b-a732-10374a07ed5a
a3dcb15d-9486-4015-aaef-4d6b0a2026db	5ace29a1-0b40-4ec3-9084-26b98b410a80	42a3ae0b-5923-45eb-be87-af70ed324c31	\N	\N	1	0	2015-10-27 13:29:25.408-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.27-04	86103f7b-c3bd-489b-a732-10374a07ed5a
12e2d446-d683-4463-8d32-0113d917b260	c4feb540-a64d-4df6-8d88-5702c8730c3d	42a3ae0b-5923-45eb-be87-af70ed324c31	\N	\N	1	0	2015-10-27 13:29:25.748-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.668-04	86103f7b-c3bd-489b-a732-10374a07ed5a
a7734d51-62a5-451c-af36-8f94b77c9445	fa108c15-c199-4531-bca9-d69bd734a51d	42a3ae0b-5923-45eb-be87-af70ed324c31	\N	\N	1	0	2015-10-27 13:29:25.742-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.633-04	86103f7b-c3bd-489b-a732-10374a07ed5a
12970d15-4c6d-4df7-becd-72b4700a8e21	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f	42a3ae0b-5923-45eb-be87-af70ed324c31	\N	\N	1	0	2015-10-27 13:29:25.762-04	86103f7b-c3bd-489b-a732-10374a07ed5a	2015-10-27 13:29:25.574-04	86103f7b-c3bd-489b-a732-10374a07ed5a
075e8f9e-fd05-469f-a99d-f5504084b380	e868ee90-8a90-4aec-88e3-00365cf64a94	1dd3b843-915e-4ea3-9b08-e076c5366530	\N	\N	1	0	2015-10-30 11:54:47.712-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:47.585-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
3a1f329b-8f0e-45e1-9e5e-8f6a1349378b	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	1dd3b843-915e-4ea3-9b08-e076c5366530	\N	\N	1	0	2015-10-30 11:54:47.72-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:47.545-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
6e3bcd5e-b8ca-4ed4-b3cf-a9a7f7316c0f	47bfb33c-9dae-4315-a57e-a904072e6d08	1dd3b843-915e-4ea3-9b08-e076c5366530	\N	\N	1	0	2015-10-30 11:54:47.723-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:47.621-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
0ab11b7f-6097-43e7-be3a-436cb834a3d6	8375c3b0-7da7-4c0a-8f44-15c5ed645010	1dd3b843-915e-4ea3-9b08-e076c5366530	\N	\N	1	0	2015-10-30 11:54:48.179-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 11:54:48.116-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
f8581a74-789f-4adc-9c22-6c4d0bb02f18	e868ee90-8a90-4aec-88e3-00365cf64a94	297ada62-218d-448c-a67f-c5e2cdeeec0e	\N	\N	1	0	2015-10-30 13:01:40.779-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.625-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
3dc0f295-6e30-4a63-80fd-2d75e0a6adce	47bfb33c-9dae-4315-a57e-a904072e6d08	297ada62-218d-448c-a67f-c5e2cdeeec0e	\N	\N	1	0	2015-10-30 13:01:40.79-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.66-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
877866b1-9b61-4ee2-8584-5548dcbbbbdc	8375c3b0-7da7-4c0a-8f44-15c5ed645010	297ada62-218d-448c-a67f-c5e2cdeeec0e	\N	\N	1	0	2015-10-30 13:01:40.808-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.705-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
eb7c4da0-5113-4618-b0c2-75d34aedf76d	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	297ada62-218d-448c-a67f-c5e2cdeeec0e	\N	\N	1	0	2015-10-30 13:01:40.81-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:01:40.582-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
b547baa0-8e38-40a8-8bde-6716791d05c0	b910c68c-0ea3-4887-ad4a-f7313bd007e3	ca5bcda3-6d0d-4c85-96a9-9eca67220d80	\N	\N	1	0	2015-10-30 13:03:09.62-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:03:09.564-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
bd51da7e-944b-408f-b5c9-a6b7137e6095	567f33cf-7575-4334-b720-dfd7515d4f64	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:53.888-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:53.83-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
8ae372f4-a92b-42be-92d4-00d483289a81	73b6c3ea-559e-4bc0-88e7-0e20730e2455	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.103-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.03-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
c0519722-d6b3-4a82-89ac-e759c86f54fa	afabc446-9a56-4b18-8386-141cfbb34a48	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.5-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.31-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
05d81a62-aefa-4c07-85e3-c5b6278e790c	793eb969-b576-4126-bba3-39284f5c1429	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.546-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.272-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
9a9e4cde-38ac-46fe-8a60-18028c519b07	65b99a1a-a853-47f7-bdf8-104f76aaab22	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.549-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.342-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
a59fbe6b-68f4-4578-b658-0da16aa81c0d	afabc446-9a56-4b18-8386-141cfbb34a48	8448dd7c-bf73-4761-b39a-e75f90ae64e9	\N	\N	1	2	2015-10-30 13:07:49.52-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.952-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
1005020c-8439-4a29-bfd9-e1f408ba8f34	501e6867-db1a-48cf-a14d-3a53c9a5b63f	8448dd7c-bf73-4761-b39a-e75f90ae64e9	\N	\N	1	2	2015-10-30 13:07:49.521-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.955-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
40481890-4baf-44e7-9f22-9883ff61b28f	b8fda7d1-dd5a-4ee7-909b-821537dd2a69	8448dd7c-bf73-4761-b39a-e75f90ae64e9	\N	\N	1	2	2015-10-30 13:07:49.512-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.953-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
1e359f57-ca68-4110-91b8-4e36bb7449bd	22eabfe1-2d1e-4100-ae10-3a0824ae72a5	8448dd7c-bf73-4761-b39a-e75f90ae64e9	\N	\N	1	2	2015-10-30 13:07:49.518-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-10-30 13:08:35.946-04	c605da3d-19d9-4a0e-9d42-a1d48d70196a
a17ec426-f0b2-4a29-b8cf-e237c3558445	47bfb33c-9dae-4315-a57e-a904072e6d08	9b9e103c-566e-4982-8932-e681a3d01ef4	\N	\N	1	0	2015-10-30 16:40:12.912-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:12.862-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
0bbee25b-f267-4260-9091-28ecb3aee617	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	9b9e103c-566e-4982-8932-e681a3d01ef4	\N	\N	1	0	2015-10-30 16:40:13.421-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:13.265-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
6d85b355-41ac-4ce4-ad41-e24e46d76d14	a3f29743-f27d-4372-a191-998d7bb90f39	9b9e103c-566e-4982-8932-e681a3d01ef4	\N	\N	1	0	2015-10-30 16:40:13.426-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:13.302-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
528ab426-c25a-438a-b34b-b551b853d8b5	389581aa-a878-4be0-af35-5c153d603516	9b9e103c-566e-4982-8932-e681a3d01ef4	\N	\N	1	0	2015-10-30 16:40:13.445-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:13.347-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
115db8e8-67f3-48f5-bfb9-dd7b56fc5956	8375c3b0-7da7-4c0a-8f44-15c5ed645010	9b9e103c-566e-4982-8932-e681a3d01ef4	\N	\N	1	0	2015-10-30 16:40:13.446-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 16:40:13.38-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
c744071b-852f-4db3-bed0-5c7c8b107b5f	fe759c88-d7ce-4340-be48-081167e21453	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.547-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.373-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
3fdea26a-d826-49da-b6ab-a1401eaa70eb	b726191f-70d5-4e53-bb28-b9d225efdbcb	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.551-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.436-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
2d42ae8c-cafd-4de3-9479-5f790e4c5c6d	21909320-9ec5-45ee-81db-c28dc82e3a3b	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.541-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.405-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
410ef243-33ba-4106-8f3b-9b7a305210ec	fb198851-cd6a-40bc-97d0-630a6ed4dec2	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.764-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.665-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
0197e0fc-ab49-49ae-913c-2825e19a9003	25893b4a-38af-4d88-bb07-27f7d6011ce3	191d6674-9359-4a92-8f21-39a96e000a79	\N	\N	1	0	2015-10-30 16:55:54.77-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 16:55:54.7-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
12c5e336-d31f-4797-9b88-bed2d575e731	47bfb33c-9dae-4315-a57e-a904072e6d08	f2321118-db87-4e60-9fb1-3ce4004d1844	\N	\N	1	0	2015-10-30 20:48:30.284-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:30.223-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
dd904cdb-85a3-4389-aa8f-407478f4f123	8375c3b0-7da7-4c0a-8f44-15c5ed645010	f2321118-db87-4e60-9fb1-3ce4004d1844	\N	\N	1	0	2015-10-30 20:48:30.8-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:30.691-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
c6cda92a-cfe3-4601-ace7-8569bf1922fe	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	f2321118-db87-4e60-9fb1-3ce4004d1844	\N	\N	1	0	2015-10-30 20:48:30.818-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:30.72-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
b8d515bd-feb6-4eb0-ae7a-313a3d5afec8	389581aa-a878-4be0-af35-5c153d603516	f2321118-db87-4e60-9fb1-3ce4004d1844	\N	\N	1	0	2015-10-30 20:48:30.822-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:30.747-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
4d8633bc-d34a-4d9a-99e4-a40e76c8eaeb	a3f29743-f27d-4372-a191-998d7bb90f39	f2321118-db87-4e60-9fb1-3ce4004d1844	\N	\N	1	0	2015-10-30 20:48:30.824-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 20:48:30.597-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
c096c601-cb23-4aae-a7d7-62118a81f00c	ddaba673-2c58-47b5-99ef-dc31fe5285d3	b5910bb5-9c2b-4252-ad35-5c7943c086a4	\N	\N	1	0	2015-10-30 20:54:48.248-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:54:48.201-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
bd70781c-a7e8-4b77-b200-3362718bb953	18362ca7-9064-4bdb-a289-edf087cac828	b5910bb5-9c2b-4252-ad35-5c7943c086a4	\N	\N	1	0	2015-10-30 20:54:48.837-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:54:48.785-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
348ace95-cda9-4743-963a-fb718e219a58	400dd88c-8266-4311-9a9f-5073977ff64c	b5910bb5-9c2b-4252-ad35-5c7943c086a4	\N	\N	1	0	2015-10-30 20:54:48.847-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:54:48.752-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
74ae99cb-7b93-470e-9b0f-8ae31fe87eaf	5ace29a1-0b40-4ec3-9084-26b98b410a80	b5910bb5-9c2b-4252-ad35-5c7943c086a4	\N	\N	1	0	2015-10-30 20:54:48.958-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:54:48.901-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
8c85c309-b699-4961-87ae-21f51f6e1140	eb970c6a-8430-4422-a233-032fea8ce39c	4eb3242d-1270-4d21-877c-62be97c26dda	\N	\N	1	0	2015-10-30 21:08:33.7-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:33.65-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
56207fa4-9576-4b3b-9a85-66f7039d7534	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e	4eb3242d-1270-4d21-877c-62be97c26dda	\N	\N	1	0	2015-10-30 21:08:34.175-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:34.006-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
4019422d-b78f-4776-9c9c-ab2bf428d22b	25893b4a-38af-4d88-bb07-27f7d6011ce3	4eb3242d-1270-4d21-877c-62be97c26dda	\N	\N	1	0	2015-10-30 21:08:34.178-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:34.04-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
b8fc4540-3072-4e81-b077-f36ed9b175c4	fe759c88-d7ce-4340-be48-081167e21453	4eb3242d-1270-4d21-877c-62be97c26dda	\N	\N	1	0	2015-10-30 21:08:34.193-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:34.128-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
5b3a057d-c2cd-489e-9749-0b2700939375	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d	4eb3242d-1270-4d21-877c-62be97c26dda	\N	\N	1	0	2015-10-30 21:08:34.198-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 21:08:34.089-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819
09b16c04-e3b3-4f39-8493-da41a9380116	b910c68c-0ea3-4887-ad4a-f7313bd007e3	b6b2d9d3-d8e6-4a4f-b38b-d9b809a69352	\N	\N	1	0	2015-10-30 21:09:56.044-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:09:55.988-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
8ee7f55f-01a9-407c-b937-5aff360a0c8b	47bfb33c-9dae-4315-a57e-a904072e6d08	4c51a851-6f8d-4685-89fc-d33d8491671d	\N	\N	1	0	2015-10-30 21:11:25.283-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:25.224-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
18a64ed0-1f8e-4aef-83fc-580fb2494481	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	4c51a851-6f8d-4685-89fc-d33d8491671d	\N	\N	1	0	2015-10-30 21:11:25.892-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:25.691-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
ca444a62-9161-4aa8-a15f-2afad2a53e50	389581aa-a878-4be0-af35-5c153d603516	4c51a851-6f8d-4685-89fc-d33d8491671d	\N	\N	1	0	2015-10-30 21:11:25.913-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:25.811-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
f1eaac4f-6cbb-4af6-9f9b-8c200bd2e85b	a3f29743-f27d-4372-a191-998d7bb90f39	4c51a851-6f8d-4685-89fc-d33d8491671d	\N	\N	1	0	2015-10-30 21:11:25.92-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:25.634-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
5944c096-f99d-41cd-89e5-d3247384e6ed	8375c3b0-7da7-4c0a-8f44-15c5ed645010	4c51a851-6f8d-4685-89fc-d33d8491671d	\N	\N	1	0	2015-10-30 21:11:25.918-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb	2015-10-30 21:11:25.757-04	f4e881fd-aac0-4792-a3a9-5489bb8fd0eb
e0970f4d-3ace-479a-b60b-7631a1631497	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	f5ac4a48-1174-48c9-af28-8790340ff039	\N	\N	1	0	2015-11-02 15:41:38.79-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.722-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
60e515ff-7708-4a13-bea1-35b3434201ea	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	f5ac4a48-1174-48c9-af28-8790340ff039	\N	\N	1	0	2015-11-02 15:41:39.047-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.884-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
c2d4af57-0ded-41db-a57a-15e596c2967c	80881761-08a2-4d02-ae1e-287610944eeb	f5ac4a48-1174-48c9-af28-8790340ff039	\N	\N	1	0	2015-11-02 15:41:39.066-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.923-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
b41a79c6-4e5e-454e-9d49-b2ca585c18ab	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	f5ac4a48-1174-48c9-af28-8790340ff039	\N	\N	1	0	2015-11-02 15:41:39.064-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:41:38.819-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
60b7b23a-06af-4029-8d6c-234bb66e2ec3	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7	61c50311-9c03-46a7-85be-6dbb30661206	\N	\N	1	0	2015-11-02 15:45:54.603-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.467-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
eba1778e-0ba0-428e-bf8b-c4cdb9ff7e1a	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d	61c50311-9c03-46a7-85be-6dbb30661206	\N	\N	1	0	2015-11-02 15:45:54.613-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.501-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
9b1dd370-d424-48c4-a72b-eaab94d8aa43	80881761-08a2-4d02-ae1e-287610944eeb	61c50311-9c03-46a7-85be-6dbb30661206	\N	\N	1	0	2015-11-02 15:45:54.654-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.535-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
a672a1ba-9727-4884-b511-f67fe1d5be65	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	61c50311-9c03-46a7-85be-6dbb30661206	\N	\N	1	0	2015-11-02 15:45:54.658-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:45:54.425-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
3e1f991c-53d4-40df-9fdf-ba6008b29dcf	b910c68c-0ea3-4887-ad4a-f7313bd007e3	f951ca00-f625-46ea-9828-8e94b6e95e73	\N	\N	1	0	2015-11-02 15:52:05.56-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 15:52:05.513-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
d1a7239b-e244-4cc9-825b-562d07d9119f	b910c68c-0ea3-4887-ad4a-f7313bd007e3	a2b3570b-8557-4790-bcbe-a51dd56aafcd	\N	\N	1	0	2015-11-02 16:02:02.674-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a	2015-11-02 16:02:02.622-05	c605da3d-19d9-4a0e-9d42-a1d48d70196a
eba9868b-6471-4238-b845-d1db950e485b	e868ee90-8a90-4aec-88e3-00365cf64a94	73ed0813-4b6f-4a7c-b59b-3671052c4dc2	\N	\N	1	2	2015-11-08 19:26:16.245-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:48.1-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
41853b1c-88a6-4b2d-8d3d-231b60dcef21	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	73ed0813-4b6f-4a7c-b59b-3671052c4dc2	\N	\N	1	2	2015-11-08 19:26:16.273-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:48.126-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
8b3b687d-42f7-4a34-82cf-7ab50c622599	8375c3b0-7da7-4c0a-8f44-15c5ed645010	73ed0813-4b6f-4a7c-b59b-3671052c4dc2	\N	\N	1	2	2015-11-08 19:26:16.271-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:48.124-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
7b0e49c7-ace8-4b8c-8523-22a64d30a5c0	47bfb33c-9dae-4315-a57e-a904072e6d08	73ed0813-4b6f-4a7c-b59b-3671052c4dc2	\N	\N	1	2	2015-11-08 19:26:16.254-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a	2015-11-08 19:28:48.122-05	a6c4875f-155d-47aa-b0c8-af62a6f2492a
c8014f15-62c1-4c7c-b3b2-3dbf01b4fd74	80881761-08a2-4d02-ae1e-287610944eeb	663d9af6-d780-4d12-ac0e-57d2459f2fae	\N	\N	1	0	2015-11-13 15:39:06.704-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:06.643-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
6bf7828e-0574-4305-9ef1-9f0475835528	25893b4a-38af-4d88-bb07-27f7d6011ce3	663d9af6-d780-4d12-ac0e-57d2459f2fae	\N	\N	1	0	2015-11-13 15:39:07.177-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:07.071-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
15fb3100-90cd-4f02-be95-fbd36f1c170c	fe759c88-d7ce-4340-be48-081167e21453	663d9af6-d780-4d12-ac0e-57d2459f2fae	\N	\N	1	0	2015-11-13 15:39:07.186-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:07.101-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
7c46a0c0-2197-433e-80fc-6654a6012299	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1	663d9af6-d780-4d12-ac0e-57d2459f2fae	\N	\N	1	0	2015-11-13 15:39:07.189-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af	2015-11-13 15:39:07.041-05	6db77ef5-6b98-4cc7-81b7-f657a34fa6af
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY states (id, countryid, state) FROM stdin;
AL	US	Alabama
AK	US	Alaska
AZ	US	Arizona
AR	US	Arkansas
CA	US	California
CO	US	Colorado
CT	US	Connecticut
DE	US	Delaware
DC	US	District Of Columbia
FL	US	Florida
GA	US	Georgia
HI	US	Hawaii
ID	US	Idaho
IL	US	Illinois
IN	US	Indiana
IA	US	Iowa
KS	US	Kansas
KY	US	Kentucky
LA	US	Louisiana
ME	US	Maine
MD	US	Maryland
MA	US	Massachusetts
MI	US	Michigan
MN	US	Minnesota
MS	US	Mississippi
MO	US	Missouri
MT	US	Montana
NE	US	Nebraska
NV	US	Nevada
NH	US	New Hampshire
NJ	US	New Jersey
NM	US	New Mexico
NY	US	New York
NC	US	North Carolina
ND	US	North Dakota
OH	US	Ohio
OK	US	Oklahoma
OR	US	Oregon
PA	US	Pennsylvania
RI	US	Rhode Island
SC	US	South Carolina
SD	US	South Dakota
TN	US	Tennessee
TX	US	Texas
UT	US	Utah
VT	US	Vermont
VA	US	Virginia
WA	US	Washington
WV	US	West Virginia
WI	US	Wisconsin
WY	US	Wyoming
AB	CA	Alberta
BC	CA	British Columbia
MB	CA	Manitoba
NB	CA	New Brunswick
NL	CA	Newfoundland and Labrador
NS	CA	Nova Scotia
ON	CA	Ontario
PE	CA	Prince Edward Island
QC	CA	Quebec
SK	CA	Saskatchewan
NT	CA	Northwest Territories
NU	CA	Nunavut
YT	CA	Yukon
DIF	MX	Distrito Federal
AGS	MX	Aguascalientes
BCN	MX	Baja California
BCS	MX	Baja California Sur
CAM	MX	Campeche
CHP	MX	Chiapas
CHI	MX	Chihuahua
COA	MX	Coahuila
COL	MX	Colima
DUR	MX	Durango
GTO	MX	Guanajuato
GRO	MX	Guerrero
HGO	MX	Hidalgo
JAL	MX	Jalisco
MEX	MX	Mexico
MIC	MX	Michoacan
MOR	MX	Morelos
NAY	MX	Nayarit
NLE	MX	Nuevo Leon
OAX	MX	Oaxaca
PUE	MX	Puebla
QRO	MX	Queretaro
ROO	MX	Quintana Roo
SLP	MX	San Luis Potosi
SIN	MX	Sinaloa
SON	MX	Sonora
TAB	MX	Tabasco
TAM	MX	Tamaulipas
TLX	MX	Tlaxcala
VER	MX	Veracruz
YUC	MX	Yucatan
ZAC	MX	Zacatecas
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY storage (id, fid, filename, contenttype, type, hash, status, version, added, addedby, changed, changedby, container, size) FROM stdin;
4fa27849-72bf-4f14-9101-18771da22b58	94ccdf19-616a-4f6b-b0e5-34e5b2fcec13		application/octet-stream	areaimage	bb0cdd6d2af09f2699169306f06e560b	1	0	2015-01-29 22:03:04.935-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:02:22.617-05	06169b04-bb68-4868-b995-98388fa33e16		904100
1ba34f7c-1f86-42da-9f6a-5313ab2e9370	838d9451-0468-4772-b879-88e8ca28136f		application/octet-stream	areaimage	191240f5c29e357ec041080135de5e6c	1	0	2015-01-31 14:40:54.67-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-31 14:40:52.921-05	1676623f-4657-410f-87b6-db11cf461ba9		774444
5cd11369-8d00-41b5-ba37-dde6b35fae96	838d9451-0468-4772-b879-88e8ca28136f		application/octet-stream	areaimage	4d550e0ec724d2c1fa92741f9dff2990	1	0	2015-01-31 14:41:10.162-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-01-31 14:41:08.881-05	1676623f-4657-410f-87b6-db11cf461ba9		823752
dc3e59cd-af84-45f1-bcbf-f6c68f5e9638	9fe9deb4-79f7-4e15-aa14-2cc6df02b425		application/octet-stream	areaimage	429cfeb293aecc14ff68ed074945a7cd	1	0	2015-02-02 13:39:22.202-05	1676623f-4657-410f-87b6-db11cf461ba9	2015-02-02 13:39:21.055-05	1676623f-4657-410f-87b6-db11cf461ba9		67244
ee54f028-4029-418e-a99b-2ae2168b5878	adb37989-1da5-4853-8b66-3a30a7673873		application/octet-stream	areaimage	acd021c49fc1fbb1be3470041e08c3a2	1	0	2015-02-26 14:03:01.567-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:03:00.341-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757		874784
58bbf74d-73c1-4b28-a529-a7e27ea57124	adb37989-1da5-4853-8b66-3a30a7673873		application/octet-stream	areaimage	7ab82d1f187439700cf898c35a74bff8	1	0	2015-02-26 14:03:01.732-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:03:00.473-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757		1536996
cef5388b-786b-4f70-92f2-66956736804f	adb37989-1da5-4853-8b66-3a30a7673873		application/octet-stream	areaimage	954ecc3379eabb7db5b78b8e276d9e4f	1	0	2015-02-26 14:03:04.326-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757	2015-02-26 14:03:03.026-05	6664d1b2-7618-401f-bde9-d8f5d1c7b757		823032
c2ecc4e8-bf52-4e95-a565-8181b56db770	affcd11c-4335-4504-aaf2-545b540c0e2b		application/octet-stream	areaimage	a551b00ebe85e9a3a5073f327cb5f35e	1	0	2015-03-20 18:22:37.963-04	fd0457a0-2d66-4a63-857b-21f224a14a47	2015-03-20 18:22:36.62-04	fd0457a0-2d66-4a63-857b-21f224a14a47		751556
0c56d49a-3fa2-4c3b-8608-dbd15604d47f	b03ab54a-6492-4f4c-9fac-f21f313728d1		application/octet-stream	areaimage	7134b394441f098682286d246d3292bf	1	0	2015-04-18 02:31:21.356-04	f4ff4de4-2322-447c-ae14-d1e9945c523f	2015-04-18 02:31:20.019-04	f4ff4de4-2322-447c-ae14-d1e9945c523f		30180
efc5bd79-8018-4018-8d58-ca455b03fe8b	56e3e125-2525-481f-b644-064a4ef7625b		application/octet-stream	areaimage	5a3b56b3495f7395a73894fac0a2469c	1	0	2015-08-09 18:15:42.789-04	067b4635-5840-48fd-980d-ccddbe1b173d	2015-08-09 18:15:39.493-04	067b4635-5840-48fd-980d-ccddbe1b173d		41524
27c259b1-bc50-4526-a14a-191ec8a16467	5c6fb96c-22f6-40b4-83d2-80b1b908f0f6		application/octet-stream	areaimage	6dfc4a2827fbb7f24a4ea652b7fe6941	1	0	2015-09-10 02:33:59.105-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c	2015-09-10 02:33:57.912-04	7c7c1cd4-e190-4d36-a71e-58b3f939d25c		619300
957d7b08-feb6-4e00-9f59-82060b897273	2d6fd993-f98c-4e9b-8ce9-350272a5b325		application/octet-stream	areaimage	68f20fcff57b22ce87f93258ad9202ee	1	0	2015-10-30 20:55:03.323-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819	2015-10-30 20:55:01.383-04	7ce708d8-63c0-4faf-bb52-8a645fc1a819		723416
\.


--
-- Data for Name: system; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY system (id, name, version, added, addedby, changed, changedby, status, share, saleprice) FROM stdin;
f0d86fcc-dd1f-4947-851c-e88f21041f61	Graniflex 1.2  Fast-Set  (Flakes w/ 2 Coats Poly 85)	1	2015-05-23 08:36:58.301-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-24 11:10:23.956-04	06169b04-bb68-4868-b995-98388fa33e16	1	t	7
ca359313-25d4-4e54-9f55-8a27949980ff	Polished concrete to 800#	0	2015-02-05 19:29:40.235-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 19:29:40.179-05	06169b04-bb68-4868-b995-98388fa33e16	1	f	3.25
71336c6c-2a01-4962-b3bf-9417ed5ad275	Polishing 400#	0	2015-02-06 15:04:00.992-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 15:04:00.937-05	06169b04-bb68-4868-b995-98388fa33e16	1	f	2
85895bef-b806-4051-a5f3-34892c56dd4c	Misc Repair	0	2015-01-29 22:12:52.725-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:12:52.673-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	3
9d2b54f7-8681-4405-9098-a9bf3a80ec5e	Graniflex 1.1  Fast-Set  (Flakes w/ 1 Coat Poly 85)	5	2015-05-22 16:40:27.025-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:45:06.165-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	6.5
cb2eb7fa-3870-4e96-9269-46811508d803	Metallic Epoxy System	4	2015-01-29 23:54:45.648-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:47:16.037-05	06169b04-bb68-4868-b995-98388fa33e16	0	t	7
84465f99-18df-4fe3-9330-801764344c18	RUSTIC CONCRETE WOOD - Interior   (custom-crafted concrete wood)	26	2015-01-30 11:00:46.254-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-18 20:50:59.901-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	8
9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	123 SYSTEM   (solid color, chemical-resistant, low-cost industrial flooring)	3	2015-01-30 15:57:36.354-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-20 16:46:45.52-04	06169b04-bb68-4868-b995-98388fa33e16	1	t	2.5
e3175371-8815-455f-9cc6-f67fe1676c49	xx	10	2015-01-22 17:32:47.591-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 13:43:57.716-04	06169b04-bb68-4868-b995-98388fa33e16	0	t	6.5
ef9e68f6-8298-4ad2-857e-0babba80ee19	PROTECTOR COLOR FLAKE  (w / 2 coats of Protectorthane 1000)	3	2015-01-31 09:03:14.388-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:05:09.362-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	4.75
0b1d2077-bf8b-42d3-b991-d9f09bbff327	HEAVY DUTY TEXTURE   (slip-resistant waterproof flooring)	4	2015-01-30 16:28:56.44-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:12:42.574-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	6.5
2bb379df-16d7-47c5-bd98-aacf19491605	Graniflex 1.5  Fast-Set  (Flakes w/ 1  Neat Coat Epoxy @65', 1 coat WB Protectorthane SATIN)	6	2015-05-27 15:01:39.954-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:13:41.597-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	7
07b7400f-fa10-45dd-9475-12787c0bdd56	Graniflex 1.3  Fast-Set  (Flakes w/ 1 Neat Coat Epoxy @65', 1 coat Graniseal)	5	2015-05-23 12:18:42.734-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:14:29.129-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	7
7761ec88-47d8-44b3-8ea4-2eebff7d0f09	Graniflex 1.4  Fast-Set  (Flakes w/ 1 Neat Coat Epoxy @65', 1 coat WB Protectorthane GLOSS)	5	2015-05-23 13:09:57.694-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:14:57.786-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	7
e501ee32-36f2-45ea-acc1-5740b9953d18	CLEAN & SEAL   (w/ CP Pentrating Sealer)	7	2015-01-30 18:43:32.787-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-24 10:15:32.57-04	06169b04-bb68-4868-b995-98388fa33e16	1	t	0.5
63875ae2-d57d-489b-88f0-01cea90a438b	xx2	8	2015-01-31 09:15:18.796-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 13:44:55.776-04	06169b04-bb68-4868-b995-98388fa33e16	0	t	6.5
22caba65-e2d2-4527-a9a4-28d506b6e8df	xx3	4	2015-01-22 09:36:25.869-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 13:45:41.887-04	06169b04-bb68-4868-b995-98388fa33e16	0	t	6.75
579291a4-6b9d-4e2d-95ef-5898c4f66f0d	Graniflex 1.6  Fast-Set  (Flakes w/ 2 coats Protectorthane CLEAR)	3	2015-05-29 11:29:09.299-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:38:33.386-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	6
d07b40b5-95bb-4c8d-a9ce-f57aa248f329	Metallic Marble Stain	2	2015-01-29 23:31:49.351-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:12:24.976-05	06169b04-bb68-4868-b995-98388fa33e16	0	t	6.5
10167bed-9c3f-4f31-bd4f-7e356728d0b5	Graniflex 1.7  Fast-Set  (Flakes w/ 2 coats Protectorthane 1000)	3	2015-05-29 11:39:58.403-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 13:47:07.881-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	6
f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	Graniflex 1.0  Fast-Set  (Flakes w/ 2 Coats GRANISEAL)  THE ORIGINAL	17	2015-01-21 23:07:15.84-05	06169b04-bb68-4868-b995-98388fa33e16	2015-05-30 13:50:42.864-04	06169b04-bb68-4868-b995-98388fa33e16	1	t	6.5
9004c757-e34f-4f69-aeb6-c68254569c97	METALLIC MARBLE   (vibrant 3-D epoxy system)	5	2015-01-30 18:12:18.405-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:16:00.065-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	7
ce5baf3c-608b-4300-a95e-503c70fd5b34	GRANIFLEX (Quartz BLENDED colors - Double Broadcast w/ GraniSeal)	8	2015-01-31 09:20:05.788-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:41:28.398-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	6.75
b18fa4d6-1254-4adf-9688-0a7ab2badeba	GRANIFLEX (Quartz SOLID color - Double Broadcast  w/ GraniSeal)	6	2015-01-31 09:29:17.847-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:42:29.419-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	6.75
3191a382-5125-4e2f-ba54-7088262d7e61	Graniflex 1.8  Fast-Set  (Quartz, double broadcast with Graniseal)	3	2015-05-30 14:52:04.802-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 15:42:00.352-04	06169b04-bb68-4868-b995-98388fa33e16	1	f	8
ef1dddd5-08bd-4c24-b985-b5f543f90108	Test new app	0	2015-11-04 23:36:47.122-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-04 23:36:47.053-05	06169b04-bb68-4868-b995-98388fa33e16	1	f	1
681f721e-b6aa-4da3-9df6-161471bc06e4	GRANIFLEX  (Interior Quartz -Blended Colors - Double Broadcast w/ Neat Coat then WB Protectorthane)	0	2015-01-31 12:55:22.469-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:22.409-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	6.75
92765abf-abd1-4998-ba3a-728610789763	PROTECTOR COLOR FLAKE  (Interior w / Neat Coat & WB Protectorthane)	0	2015-01-31 13:09:06.83-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:09:06.776-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	5.75
187db143-bd8f-4251-bca6-47393c460f58	TUSCAN SLATE - Exterior	7	2015-01-31 13:14:35.724-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:27:26.428-05	06169b04-bb68-4868-b995-98388fa33e16	1	t	5.5
\.


--
-- Data for Name: systemdetail; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY systemdetail (id, systemid, ingredientid, extra, version, added, addedby, changed, changedby, status, factor, price) FROM stdin;
fdfc4c96-7db0-428f-bbc1-ead84d9b17cc	22caba65-e2d2-4527-a9a4-28d506b6e8df	b7475b4a-6613-466d-b099-8708d527b55f		0	2015-01-22 09:36:26.078-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:36:26.009-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ae2624dc-e5e7-46c0-99e6-013a9cf9277d	22caba65-e2d2-4527-a9a4-28d506b6e8df	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-01-22 09:36:26.301-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 09:36:26.195-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
6e967beb-4794-4c57-ba55-d31f495b45c4	e3175371-8815-455f-9cc6-f67fe1676c49	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-01-22 17:32:47.837-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 17:32:47.766-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
d09b1053-125a-464f-9261-ff264b47823c	e3175371-8815-455f-9cc6-f67fe1676c49	e868ee90-8a90-4aec-88e3-00365cf64a94		0	2015-01-22 17:32:48.155-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 17:32:47.958-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
62929992-b900-42a7-b42e-0e4c31d60f37	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		1	2015-01-21 23:07:16.494-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 20:13:05.436-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	6.5
59d30b92-7c59-4445-86be-611396ad0d64	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	e868ee90-8a90-4aec-88e3-00365cf64a94		1	2015-01-21 23:07:16.183-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-22 20:13:05.441-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
c2785c75-bd24-48d2-98ad-1c966c86604d	e501ee32-36f2-45ea-acc1-5740b9953d18	b910c68c-0ea3-4887-ad4a-f7313bd007e3		0	2015-01-30 18:44:11.858-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 18:44:11.691-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
3b618a3b-5970-4434-b47f-14e50eaabc06	9004c757-e34f-4f69-aeb6-c68254569c97	eb970c6a-8430-4422-a233-032fea8ce39c	Mix with half load of pigment	1	2015-01-30 18:12:18.659-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 16:16:00.267-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
ab48f00c-1f20-4474-8f29-a887204ce445	e3175371-8815-455f-9cc6-f67fe1676c49	18362ca7-9064-4bdb-a289-edf087cac828		1	2015-01-22 17:32:48.149-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:55:32.767-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
8992eb6d-07d4-4cf5-a21d-99680dffe3f7	e3175371-8815-455f-9cc6-f67fe1676c49	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-29 21:55:33.094-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:55:32.959-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a72644b5-2cb2-46ab-8eb2-ef9d40cca441	22caba65-e2d2-4527-a9a4-28d506b6e8df	18362ca7-9064-4bdb-a289-edf087cac828		1	2015-01-22 09:36:26.306-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:56:20.821-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
ed20c18b-319e-48e7-a08c-cccb1ce18305	22caba65-e2d2-4527-a9a4-28d506b6e8df	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-29 21:56:21.051-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 21:56:20.929-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
9b2b414b-04a2-40d1-8cf8-63be9c44432f	85895bef-b806-4051-a5f3-34892c56dd4c	ce780dbe-0148-4e67-b478-4fea4cb405fc		0	2015-01-29 22:12:53.103-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 22:12:53.04-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
d7f75bc6-7d75-4c5b-84df-d0e9df51d9ee	d07b40b5-95bb-4c8d-a9ce-f57aa248f329	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-29 23:31:49.636-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:31:49.567-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
3b2e68cb-0546-4fac-a122-b6de229b89ac	d07b40b5-95bb-4c8d-a9ce-f57aa248f329	e868ee90-8a90-4aec-88e3-00365cf64a94		0	2015-01-29 23:31:49.708-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:31:49.646-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
fef9e7ee-8a48-4300-aba5-8f22b40de78b	d07b40b5-95bb-4c8d-a9ce-f57aa248f329	adf83d9f-8e37-40bd-b649-8eb4cb72b403		0	2015-01-29 23:31:49.924-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:31:49.763-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
1e6eb736-210c-488b-9b8f-169bdfff7c60	cb2eb7fa-3870-4e96-9269-46811508d803	eb970c6a-8430-4422-a233-032fea8ce39c	Mix with half load of pigment	0	2015-01-29 23:54:45.993-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:54:45.872-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
188b66dc-fc81-4324-b83a-a1a8cb5e1440	cb2eb7fa-3870-4e96-9269-46811508d803	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-29 23:54:46.011-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:54:45.934-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
622ebc3b-fa74-4ea2-a87c-542659452d94	cb2eb7fa-3870-4e96-9269-46811508d803	e868ee90-8a90-4aec-88e3-00365cf64a94		0	2015-01-29 23:54:46.2-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:54:46.084-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
d9314750-5ec7-477a-a149-76c671a1223d	cb2eb7fa-3870-4e96-9269-46811508d803	adf83d9f-8e37-40bd-b649-8eb4cb72b403		0	2015-01-29 23:54:46.304-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-29 23:54:46.15-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
0ded7a35-d210-46f3-8027-f4bf8c43b2f5	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	e9d51055-8986-4190-a7ee-98a77dc268b0		0	2015-01-30 15:57:36.706-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 15:57:36.61-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
2e44106f-0f1a-45f8-b72a-4782c2039fb5	9c84bca3-1e1d-4c50-a813-e1cf947a3b3a	0edb0bc9-dd7a-45ab-b6b0-71318f0f59e9		0	2015-01-30 15:57:36.712-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 15:57:36.553-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
da89f781-33f1-4f13-94c7-f3767577b52a	0b1d2077-bf8b-42d3-b991-d9f09bbff327	ddaba673-2c58-47b5-99ef-dc31fe5285d3		0	2015-01-30 17:51:38.722-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 17:51:38.647-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
8a7b67f8-4b60-46a2-8d98-efaf5be065ed	0b1d2077-bf8b-42d3-b991-d9f09bbff327	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-30 17:51:39.037-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 17:51:38.833-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
12a192dd-a67e-4cb4-b22c-16efcdba37f4	0b1d2077-bf8b-42d3-b991-d9f09bbff327	18362ca7-9064-4bdb-a289-edf087cac828		0	2015-01-30 17:51:39.043-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 17:51:38.783-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
4ec719e3-c064-45d7-b93a-48dcdc1499df	0b1d2077-bf8b-42d3-b991-d9f09bbff327	400dd88c-8266-4311-9a9f-5073977ff64c		0	2015-01-30 17:51:39.059-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 17:51:38.89-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
942ea14e-d2f7-4baa-a85f-466d59494844	9004c757-e34f-4f69-aeb6-c68254569c97	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-30 18:12:18.905-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 18:12:18.719-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
e60fdea4-9c69-46fb-b3d9-4c3e72981dfb	9004c757-e34f-4f69-aeb6-c68254569c97	6e8b10cd-aede-4f6f-85c4-4b875bc7f20e		0	2015-01-30 18:28:01.185-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 18:28:01.109-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
1070bab2-6204-4a5f-8f47-4864fa15f6e9	9004c757-e34f-4f69-aeb6-c68254569c97	4bf146b6-9a1a-455b-b8e4-2b2508e5a32d		0	2015-01-30 18:28:01.179-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 18:28:01.076-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
de1ce797-0bac-44d3-a6b4-057f480f7cba	9004c757-e34f-4f69-aeb6-c68254569c97	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-01-30 18:28:01.345-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-30 18:28:01.215-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
123f976d-4d5a-4625-b7e9-b96df46cca88	ef9e68f6-8298-4ad2-857e-0babba80ee19	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-01-31 09:03:14.714-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:03:14.654-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a690b03f-15d2-432f-9b28-ce387af5b9a9	ef9e68f6-8298-4ad2-857e-0babba80ee19	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7		0	2015-01-31 09:03:15.104-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:03:14.987-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
e85733b7-da82-4c86-81fd-d04904977293	ef9e68f6-8298-4ad2-857e-0babba80ee19	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d		0	2015-01-31 09:03:15.119-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:03:15.063-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
258b48b4-d4ef-4613-98c8-44981347b772	ef9e68f6-8298-4ad2-857e-0babba80ee19	80881761-08a2-4d02-ae1e-287610944eeb		0	2015-01-31 09:03:15.387-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:03:15.313-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
fe713616-cedf-4042-8074-83210bca5220	63875ae2-d57d-489b-88f0-01cea90a438b	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-31 09:15:19.341-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:15:19.223-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
45b6e233-41a8-4f7d-86f1-16d36b2cb454	63875ae2-d57d-489b-88f0-01cea90a438b	18362ca7-9064-4bdb-a289-edf087cac828		0	2015-01-31 09:15:19.338-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:15:19.257-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
206f9fd4-9f6b-480f-80f7-a76fea13aaf8	63875ae2-d57d-489b-88f0-01cea90a438b	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-01-31 09:15:19.354-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:15:19.172-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
681c4d62-7eca-49d8-b4bd-e225f35c6f39	63875ae2-d57d-489b-88f0-01cea90a438b	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-01-31 09:15:19.711-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:15:19.481-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
7df3b4df-ac4a-471f-a6e9-0407909dfc73	63875ae2-d57d-489b-88f0-01cea90a438b	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-31 09:15:19.716-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:15:19.438-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
0c974a72-4cf9-4c9e-a0d5-6cd6e7acb5da	ce5baf3c-608b-4300-a95e-503c70fd5b34	18362ca7-9064-4bdb-a289-edf087cac828		0	2015-01-31 09:20:06.244-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:20:06.133-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
23bd569e-0e20-42b0-bba8-165848821b24	ce5baf3c-608b-4300-a95e-503c70fd5b34	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-31 09:20:06.258-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:20:06.165-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
be632c3d-d352-4e25-8fe0-fc999f53fec6	b18fa4d6-1254-4adf-9688-0a7ab2badeba	18362ca7-9064-4bdb-a289-edf087cac828		0	2015-01-31 09:29:18.186-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:29:18.059-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
f9d3e524-552c-408e-b0f6-58e4f2ec3dc6	b18fa4d6-1254-4adf-9688-0a7ab2badeba	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-31 09:29:18.201-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 09:29:18.095-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
e51bf959-b582-46bb-8868-44be0fc725ae	b18fa4d6-1254-4adf-9688-0a7ab2badeba	fa108c15-c199-4531-bca9-d69bd734a51d		0	2015-01-31 11:40:09.465-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:40:09.385-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
b869c41e-9b66-4f10-aac9-a0af903e1705	b18fa4d6-1254-4adf-9688-0a7ab2badeba	d953dc54-1bec-443d-947e-4d2d9543323d		1	2015-01-31 09:31:06.021-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:42:58.216-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
bfa3d178-9ce3-4948-9ab7-99f535f0d60d	ce5baf3c-608b-4300-a95e-503c70fd5b34	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f		1	2015-01-31 09:24:14.724-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 11:43:21.374-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
5afc18dd-2532-4008-92a7-02923ac90f75	ce5baf3c-608b-4300-a95e-503c70fd5b34	fa108c15-c199-4531-bca9-d69bd734a51d		0	2015-01-31 12:38:20.496-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:38:20.431-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
c3650f19-dbac-45a2-94f3-a8f41053fda6	ce5baf3c-608b-4300-a95e-503c70fd5b34	c4feb540-a64d-4df6-8d88-5702c8730c3d		1	2015-01-31 12:38:20.491-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:41:28.726-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
065a2d3c-7853-4da4-b4b7-15a79e5b451d	b18fa4d6-1254-4adf-9688-0a7ab2badeba	c4feb540-a64d-4df6-8d88-5702c8730c3d		1	2015-01-31 11:40:09.46-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:42:29.685-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
547171a0-8cb8-49ab-9a31-356ad03d8f2e	681f721e-b6aa-4da3-9df6-161471bc06e4	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-31 12:55:22.766-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:22.69-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
d7e9cab9-df93-46ee-a05a-34b7969cc3e6	681f721e-b6aa-4da3-9df6-161471bc06e4	5ace29a1-0b40-4ec3-9084-26b98b410a80		0	2015-01-31 12:55:23.157-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:22.881-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a95a7569-7f05-4b82-b0ac-d0d324a15344	681f721e-b6aa-4da3-9df6-161471bc06e4	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f		0	2015-01-31 12:55:23.163-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:22.933-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
c31fffe4-97d8-41c9-9a97-0a0549f61cff	681f721e-b6aa-4da3-9df6-161471bc06e4	18362ca7-9064-4bdb-a289-edf087cac828		0	2015-01-31 12:55:23.166-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:22.832-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
1abb7724-78c1-4b55-a95f-9dd95955e721	681f721e-b6aa-4da3-9df6-161471bc06e4	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-01-31 12:55:23.186-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 12:55:23.074-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
7a126298-dc0c-42ad-b7fc-45cdaa9c9772	92765abf-abd1-4998-ba3a-728610789763	80881761-08a2-4d02-ae1e-287610944eeb		0	2015-01-31 13:09:07.27-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:09:07.046-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
14ee0d7c-9a3a-4a08-a8c3-a8c8766c6453	92765abf-abd1-4998-ba3a-728610789763	fe759c88-d7ce-4340-be48-081167e21453		0	2015-01-31 13:09:07.281-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:09:07.082-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
7c66a1e0-748d-49ee-9886-fba70960bd88	92765abf-abd1-4998-ba3a-728610789763	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-01-31 13:09:07.294-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:09:07.011-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
ef64a3c1-9fa3-48d4-a685-4470fdbc1f79	92765abf-abd1-4998-ba3a-728610789763	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-01-31 13:09:07.297-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:09:07.112-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a4ef4f0d-dfe3-425e-9741-b038ebd04253	187db143-bd8f-4251-bca6-47393c460f58	afabc446-9a56-4b18-8386-141cfbb34a48		0	2015-01-31 13:16:30.176-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:16:30.041-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a82fa473-5d53-4a9f-9588-022418326a65	187db143-bd8f-4251-bca6-47393c460f58	1f2aeb2d-b73a-4e83-acc0-b3bc05a65f70		0	2015-01-31 13:28:05.134-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:28:04.961-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
6240f354-9ff4-4d0c-a20d-e3337041af12	187db143-bd8f-4251-bca6-47393c460f58	501e6867-db1a-48cf-a14d-3a53c9a5b63f		0	2015-01-31 13:33:38.39-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 13:33:38.227-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
3311fc33-75ef-47db-bf3c-edd29197c55f	187db143-bd8f-4251-bca6-47393c460f58	b8fda7d1-dd5a-4ee7-909b-821537dd2a69		0	2015-01-31 14:16:35.694-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:16:35.594-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
c46097f3-dedc-4ad1-be91-df6c511bf519	187db143-bd8f-4251-bca6-47393c460f58	22eabfe1-2d1e-4100-ae10-3a0824ae72a5		0	2015-01-31 14:16:35.7-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 14:16:35.626-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
574f5569-1ce4-4a0a-a358-1ec5d3ce8b21	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-01-31 15:47:11.789-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:47:11.681-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ecd02256-2ab2-4561-ba44-21d4d6c6fbbe	f3008e2f-5577-4bd2-80a6-c456ebf1ee4e	8375c3b0-7da7-4c0a-8f44-15c5ed645010		1	2015-01-31 15:47:12.005-05	06169b04-bb68-4868-b995-98388fa33e16	2015-01-31 15:48:13.98-05	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
9c2aad39-d59a-4d6d-9bf1-b2dab617a0e7	84465f99-18df-4fe3-9330-801764344c18	567f33cf-7575-4334-b720-dfd7515d4f64		0	2015-02-09 20:13:07.308-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:13:07.041-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
246bf872-e9db-4bb6-b647-6bf8e5649158	84465f99-18df-4fe3-9330-801764344c18	65b99a1a-a853-47f7-bdf8-104f76aaab22		0	2015-02-09 20:13:07.321-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:13:07.078-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
72dfeaf1-16fe-4bff-9d8c-3d74dfc10f39	84465f99-18df-4fe3-9330-801764344c18	afabc446-9a56-4b18-8386-141cfbb34a48		0	2015-02-09 20:13:07.328-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:13:06.995-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
0fc0c5c5-8011-43cd-88ed-5179db7e1c6e	ca359313-25d4-4e54-9f55-8a27949980ff	b7c99a69-ac78-474a-bbcc-1fe27a4023e9		0	2015-02-05 19:29:40.532-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-05 19:29:40.453-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
82c17534-d196-41b0-ad10-7432d4336981	71336c6c-2a01-4962-b3bf-9417ed5ad275	19c9292c-80ef-4054-b0ec-01b38a353e23		0	2015-02-06 15:04:01.284-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-06 15:04:01.218-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
6d5ef2da-6945-4e56-95fd-8a591e4337b2	84465f99-18df-4fe3-9330-801764344c18	793eb969-b576-4126-bba3-39284f5c1429		0	2015-02-09 20:23:17.486-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 20:23:17.324-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a11e6715-2283-4647-ae82-7ea3e2e00455	84465f99-18df-4fe3-9330-801764344c18	b726191f-70d5-4e53-bb28-b9d225efdbcb		0	2015-02-09 21:26:17.401-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:26:17.334-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
82eb5f29-4808-489f-ada2-2fad55a1a630	84465f99-18df-4fe3-9330-801764344c18	21909320-9ec5-45ee-81db-c28dc82e3a3b		0	2015-02-09 21:26:17.756-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:26:17.667-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
403098b2-67aa-447f-b72f-4219ba7fdc09	84465f99-18df-4fe3-9330-801764344c18	73b6c3ea-559e-4bc0-88e7-0e20730e2455		0	2015-02-09 21:26:17.83-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:26:17.766-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
2d974a8a-0a2a-4b35-a133-e941b442706d	84465f99-18df-4fe3-9330-801764344c18	fe759c88-d7ce-4340-be48-081167e21453		0	2015-02-09 21:29:43.698-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:29:43.555-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
f31291bc-ec43-40e3-bc66-d3cc61f75a35	84465f99-18df-4fe3-9330-801764344c18	fb198851-cd6a-40bc-97d0-630a6ed4dec2	Typically we'll do 4 parts Amber mixed w/ 1 part Bark Brown	1	2015-02-09 21:27:31.414-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:29:43.709-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
72dac497-66c7-4584-9bdb-47944e4d9dae	84465f99-18df-4fe3-9330-801764344c18	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-02-09 21:42:56.159-05	06169b04-bb68-4868-b995-98388fa33e16	2015-02-09 21:42:55.987-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
d1b8adbb-2ef6-4a55-9f81-3f5c61e84692	9d2b54f7-8681-4405-9098-a9bf3a80ec5e	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-22 16:46:57.511-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-22 16:46:57.407-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
85bb3b55-9ffe-42f1-a4e4-6d3cf1688df8	9d2b54f7-8681-4405-9098-a9bf3a80ec5e	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-22 16:46:57.526-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-22 16:46:57.365-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
26ead753-f536-4c70-b8fa-40946d22d067	9d2b54f7-8681-4405-9098-a9bf3a80ec5e	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-22 16:46:57.745-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-22 16:46:57.607-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ceea3f63-6073-4d7a-85aa-305ba2411378	9d2b54f7-8681-4405-9098-a9bf3a80ec5e	98cff144-096a-4188-b15e-32199eead724		0	2015-05-22 16:57:54.749-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-22 16:57:54.686-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
cc73f728-d186-44e0-b1b8-1aa9cb121f43	f0d86fcc-dd1f-4947-851c-e88f21041f61	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-23 08:36:58.64-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:36:58.534-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
f0d484b4-b62d-4517-904f-0874d9fb24ae	f0d86fcc-dd1f-4947-851c-e88f21041f61	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-23 08:36:58.647-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:36:58.574-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
060b4baf-1680-4ea8-9893-06da3ed3f5f0	f0d86fcc-dd1f-4947-851c-e88f21041f61	389581aa-a878-4be0-af35-5c153d603516		0	2015-05-23 08:36:58.927-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:36:58.754-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
67d56b44-3013-481f-9157-1b071bbd30ba	f0d86fcc-dd1f-4947-851c-e88f21041f61	a3f29743-f27d-4372-a191-998d7bb90f39		0	2015-05-23 08:36:58.942-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:36:58.784-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
468f3d27-48a4-4847-9a72-66c096a38484	f0d86fcc-dd1f-4947-851c-e88f21041f61	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-23 08:36:58.947-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 08:36:58.721-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
60e51b62-4c99-4b69-9061-d9036f36efb5	07b7400f-fa10-45dd-9475-12787c0bdd56	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-23 12:18:43.03-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:18:42.965-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
a63b03ca-40e7-43e4-b427-a08fc756e06d	07b7400f-fa10-45dd-9475-12787c0bdd56	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-23 12:31:09.529-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:31:09.41-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
c856bad4-5506-4b19-abbd-12042a6184dd	07b7400f-fa10-45dd-9475-12787c0bdd56	fe759c88-d7ce-4340-be48-081167e21453		0	2015-05-23 12:31:53.529-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:31:53.391-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
ecd8d23e-7438-4c37-bd99-df4a920667e3	07b7400f-fa10-45dd-9475-12787c0bdd56	64403fe0-309c-4bcc-a8cf-9be043de9cba		0	2015-05-23 12:38:50.388-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:38:50.326-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
3f0b1f6e-afc0-4ae0-aeaa-34449b2b1bd7	07b7400f-fa10-45dd-9475-12787c0bdd56	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-23 12:39:20.221-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 12:39:20.079-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
bbc1376e-6aed-48f3-822d-6549658689ca	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-23 13:09:58.069-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:09:57.94-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
05ff722a-22f7-4680-b368-856db9481182	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	fe759c88-d7ce-4340-be48-081167e21453		0	2015-05-23 13:09:58.082-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:09:57.982-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
0b797692-ba9e-4c01-b7da-57da73c80a52	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-23 13:09:58.368-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:09:58.16-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
f784ca5b-c82b-4f65-afdb-8d2cee056c66	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	25893b4a-38af-4d88-bb07-27f7d6011ce3		0	2015-05-23 13:44:28.134-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:44:27.981-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
a6e5bae3-6457-42c2-9b11-7f0c855bf266	7761ec88-47d8-44b3-8ea4-2eebff7d0f09	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-23 13:51:02.505-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-23 13:51:02.379-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
5e5bda45-0c20-423f-9cf4-32fc04145be2	2bb379df-16d7-47c5-bd98-aacf19491605	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-27 15:01:40.278-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:01:40.189-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ec293788-3af4-43bd-8a87-0790441d4974	2bb379df-16d7-47c5-bd98-aacf19491605	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-27 15:01:40.323-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:01:40.125-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ac705f9b-d784-4fcf-b2b3-70e731f9b81d	2bb379df-16d7-47c5-bd98-aacf19491605	16f9d96b-0acc-4506-8d70-5da5ae52a5ad		0	2015-05-27 15:11:48.684-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:11:48.54-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
bf520a25-73a5-41e5-be56-9cf4286dbaae	2bb379df-16d7-47c5-bd98-aacf19491605	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-27 15:11:48.69-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:11:48.504-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
e5307053-e0a5-4291-8fc8-8bdf39d07c1a	2bb379df-16d7-47c5-bd98-aacf19491605	fe759c88-d7ce-4340-be48-081167e21453		0	2015-05-27 15:12:29.952-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-27 15:12:29.786-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
3c881e1b-710c-4a65-9813-a1b52b48c509	579291a4-6b9d-4e2d-95ef-5898c4f66f0d	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-29 11:29:09.708-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:29:09.559-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
0a81107f-0134-4da2-bf64-9705071ec11a	579291a4-6b9d-4e2d-95ef-5898c4f66f0d	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-29 11:29:09.721-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:29:09.521-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
533a0657-e63a-477a-b131-f680ad9ca1a7	579291a4-6b9d-4e2d-95ef-5898c4f66f0d	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-29 11:30:02.613-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:30:02.469-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
2e022689-0c54-4d6e-819e-33b3f803cae5	579291a4-6b9d-4e2d-95ef-5898c4f66f0d	da43dd61-05de-4428-884e-7d9ab74695d7		0	2015-05-29 11:30:31.072-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:30:31.002-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
c29aae27-0da2-4467-bb82-a961378e1dab	579291a4-6b9d-4e2d-95ef-5898c4f66f0d	9be7576a-f9c8-43e2-b854-005096d6ee78		0	2015-05-29 11:30:31.208-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:30:31.077-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
d2fc55dd-e096-422b-bd70-98fd7bac3cea	10167bed-9c3f-4f31-bd4f-7e356728d0b5	ba5eb3b9-fc3d-4d11-b13d-7bdaaae456d1		0	2015-05-29 11:40:49.55-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:40:49.463-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
6f94f43b-a3c3-4168-9681-c5a8e274e132	10167bed-9c3f-4f31-bd4f-7e356728d0b5	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-05-29 11:40:49.558-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:40:49.418-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
eadd6aeb-ec9a-4b56-ba07-3ef90921a812	10167bed-9c3f-4f31-bd4f-7e356728d0b5	a77ed9c7-a3b4-443d-b2ea-f22a67946e2d		0	2015-05-29 11:40:49.866-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:40:49.67-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
b79f70b6-1c81-4c75-954e-691dbd0bd840	10167bed-9c3f-4f31-bd4f-7e356728d0b5	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-05-29 11:40:49.868-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:40:49.631-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
ae2b9388-818c-4621-a76d-ff8aa794befe	10167bed-9c3f-4f31-bd4f-7e356728d0b5	7eb74607-dba0-4cd8-af75-7ee95ed9d7b7		0	2015-05-29 11:40:50.002-04	06169b04-bb68-4868-b995-98388fa33e16	2015-05-29 11:40:49.941-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
1bfecb9f-4445-4446-8730-3181f1493848	3191a382-5125-4e2f-ba54-7088262d7e61	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-07-17 19:23:50.178-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-17 19:23:50.102-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
a5321db1-4858-47d3-9992-17c84236b641	3191a382-5125-4e2f-ba54-7088262d7e61	8375c3b0-7da7-4c0a-8f44-15c5ed645010		0	2015-07-17 19:23:50.858-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-17 19:23:50.784-04	06169b04-bb68-4868-b995-98388fa33e16	1	2	1
234bb600-8dab-4b23-91fb-04f319e9f7af	3191a382-5125-4e2f-ba54-7088262d7e61	46dbe4e8-9513-48f8-b4ef-4aa8e01b320f		0	2015-07-17 19:23:51.372-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-17 19:23:51.294-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
36677ab1-0a5a-467e-8750-63032a2ab70a	3191a382-5125-4e2f-ba54-7088262d7e61	fa108c15-c199-4531-bca9-d69bd734a51d		0	2015-07-22 14:39:05.247-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:39:05.174-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
0bac7bc9-4ddc-4716-bc30-ca842d71e171	3191a382-5125-4e2f-ba54-7088262d7e61	c4feb540-a64d-4df6-8d88-5702c8730c3d		0	2015-07-22 14:39:05.242-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:39:05.136-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
2bca8c25-1a40-4064-8054-9622dd14cf65	3191a382-5125-4e2f-ba54-7088262d7e61	a0a4078a-3e36-4358-9774-4e3208acee82		0	2015-07-22 14:39:07.068-04	06169b04-bb68-4868-b995-98388fa33e16	2015-07-22 14:39:06.974-04	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
67f747b9-b542-4ff9-b253-e1b8bd3d780a	ef1dddd5-08bd-4c24-b985-b5f543f90108	47bfb33c-9dae-4315-a57e-a904072e6d08		0	2015-11-04 23:36:47.411-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-04 23:36:47.346-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
70606e40-9735-48cd-b005-f8422b99af03	ef1dddd5-08bd-4c24-b985-b5f543f90108	501e6867-db1a-48cf-a14d-3a53c9a5b63f		0	2015-11-04 23:36:47.867-05	06169b04-bb68-4868-b995-98388fa33e16	2015-11-04 23:36:47.743-05	06169b04-bb68-4868-b995-98388fa33e16	1	1	1
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY team (id, name, version, status, added, addedby, changed, changedby) FROM stdin;
\.


--
-- Data for Name: teamdetail; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY teamdetail (id, teamid, personid, version, status, added, addedby, changed, changedby) FROM stdin;
\.


--
-- Data for Name: teamlead; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY teamlead (id, teamid, personid, status, version, added, addedby, changed, changedby) FROM stdin;
\.


--
-- Data for Name: teamsystem; Type: TABLE DATA; Schema: public; Owner: dbreader
--

COPY teamsystem (id, teamid, systemid, status, version, added, addedby, changed, changedby) FROM stdin;
\.


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: accountrole_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY accountrole
    ADD CONSTRAINT accountrole_pkey PRIMARY KEY (id);


--
-- Name: address_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: addresstype_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY addresstype
    ADD CONSTRAINT addresstype_pkey PRIMARY KEY (addresstype);


--
-- Name: color_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY color
    ADD CONSTRAINT color_pkey PRIMARY KEY (id);


--
-- Name: ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);


--
-- Name: ingredientcolor_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY ingredientcolor
    ADD CONSTRAINT ingredientcolor_pkey PRIMARY KEY (id);


--
-- Name: ingredientpattern_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY ingredientpattern
    ADD CONSTRAINT ingredientpattern_pkey PRIMARY KEY (id);


--
-- Name: lead_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY lead
    ADD CONSTRAINT lead_pkey PRIMARY KEY (id);


--
-- Name: leaddetail_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY leaddetail
    ADD CONSTRAINT leaddetail_pkey PRIMARY KEY (id);


--
-- Name: note_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id);


--
-- Name: pattern_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY pattern
    ADD CONSTRAINT pattern_pkey PRIMARY KEY (id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: phone_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY phone
    ADD CONSTRAINT phone_pkey PRIMARY KEY (id);


--
-- Name: phonetype_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY phonetype
    ADD CONSTRAINT phonetype_pkey PRIMARY KEY (phonetype);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: projectdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY projectdetail
    ADD CONSTRAINT projectdetail_pkey PRIMARY KEY (id);


--
-- Name: projectdetailstyle_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY projectdetailstyle
    ADD CONSTRAINT projectdetailstyle_pkey PRIMARY KEY (id);


--
-- Name: storage_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (id);


--
-- Name: system_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY system
    ADD CONSTRAINT system_pkey PRIMARY KEY (id);


--
-- Name: systemdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY systemdetail
    ADD CONSTRAINT systemdetail_pkey PRIMARY KEY (id);


--
-- Name: team_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: teamdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY teamdetail
    ADD CONSTRAINT teamdetail_pkey PRIMARY KEY (id);


--
-- Name: teamlead_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY teamlead
    ADD CONSTRAINT teamlead_pkey PRIMARY KEY (id);


--
-- Name: teamsystem_pkey; Type: CONSTRAINT; Schema: public; Owner: dbreader; Tablespace: 
--

ALTER TABLE ONLY teamsystem
    ADD CONSTRAINT teamsystem_pkey PRIMARY KEY (id);


--
-- Name: ix_account_username; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_account_username ON account USING btree (lower((username)::text));


--
-- Name: ix_accountrole_accountid_role; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_accountrole_accountid_role ON accountrole USING btree (accountid, role);


--
-- Name: ix_address_personid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE INDEX ix_address_personid ON address USING btree (personid);


--
-- Name: ix_addresstype_fks; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_addresstype_fks ON addresstype USING btree (addresstype);


--
-- Name: ix_color_name; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_color_name ON color USING btree (lower((name)::text));


--
-- Name: ix_countries_fks; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_countries_fks ON countries USING btree (id);


--
-- Name: ix_ingredient_name; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_ingredient_name ON ingredient USING btree (lower((name)::text));


--
-- Name: ix_ingredientcolor_uniq; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_ingredientcolor_uniq ON ingredientcolor USING btree (ingredientid, colorid);


--
-- Name: ix_ingredientpattern_uniq; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_ingredientpattern_uniq ON ingredientpattern USING btree (ingredientid, patternid);


--
-- Name: ix_lead_personid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_lead_personid ON lead USING btree (personid);


--
-- Name: ix_leaddetail_leadid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_leaddetail_leadid ON leaddetail USING btree (leadid);


--
-- Name: ix_note_fid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE INDEX ix_note_fid ON note USING btree (fid);


--
-- Name: ix_pattern_name; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_pattern_name ON pattern USING btree (lower((name)::text));


--
-- Name: ix_phone_personid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE INDEX ix_phone_personid ON phone USING btree (personid);


--
-- Name: ix_phonetype_fks; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_phonetype_fks ON phonetype USING btree (phonetype);


--
-- Name: ix_project_leadid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE INDEX ix_project_leadid ON project USING btree (leadid);


--
-- Name: ix_projectdetailstyle_uniq; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_projectdetailstyle_uniq ON projectdetailstyle USING btree (ingredientid, projectdetailid);


--
-- Name: ix_projectimage_fid; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE INDEX ix_projectimage_fid ON storage USING btree (fid, type);


--
-- Name: ix_states_fks; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_states_fks ON states USING btree (countryid, id);


--
-- Name: ix_system_name; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_system_name ON system USING btree (lower((name)::text));


--
-- Name: ix_systemdetail_system_ingredient; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_systemdetail_system_ingredient ON systemdetail USING btree (systemid, ingredientid);


--
-- Name: ix_teamdetail_people; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_teamdetail_people ON teamdetail USING btree (teamid, personid);


--
-- Name: ix_teamlead_uniq; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_teamlead_uniq ON teamlead USING btree (teamid, personid);


--
-- Name: ix_teamsystem_uniq; Type: INDEX; Schema: public; Owner: dbreader; Tablespace: 
--

CREATE UNIQUE INDEX ix_teamsystem_uniq ON teamsystem USING btree (teamid, systemid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

