-- Table: public.sacramentos

-- DROP TABLE IF EXISTS public.sacramentos;

CREATE TABLE IF NOT EXISTS public.sacramentos
(
    id integer NOT NULL DEFAULT nextval('sacramentos_id_seq'::regclass),
    sacramento text COLLATE pg_catalog."default" NOT NULL,
    fecha date NOT NULL,
    celebrante text COLLATE pg_catalog."default" NOT NULL,
    certifica text COLLATE pg_catalog."default" NOT NULL,
    padrino text COLLATE pg_catalog."default",
    madrina text COLLATE pg_catalog."default",
    testigo_novio text COLLATE pg_catalog."default",
    testigo_novia text COLLATE pg_catalog."default",
    padre text COLLATE pg_catalog."default",
    madre text COLLATE pg_catalog."default",
    nombres_novia text COLLATE pg_catalog."default",
    apellidos_novia text COLLATE pg_catalog."default",
    cedula_novia integer,
    CONSTRAINT sacramentos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_creyentes FOREIGN KEY (id)
        REFERENCES public.creyentes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_libros FOREIGN KEY (id)
        REFERENCES public.libros (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_parroquias FOREIGN KEY (id)
        REFERENCES public.parroquias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_registros_civiles FOREIGN KEY (id)
        REFERENCES public.registros_civiles (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sacramentos
    OWNER to postgres;

-- Table: public.libros

-- DROP TABLE IF EXISTS public.libros;

CREATE TABLE IF NOT EXISTS public.libros
(
    id integer NOT NULL DEFAULT nextval('libros_id_seq'::regclass),
    tomo integer NOT NULL,
    pagina integer NOT NULL,
    numero integer NOT NULL,
    CONSTRAINT libros_pkey PRIMARY KEY (id),
    CONSTRAINT tomo_pagina_numero_unico UNIQUE (tomo, pagina, numero)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.libros
    OWNER to postgres;

-- Table: public.parroquias

-- DROP TABLE IF EXISTS public.parroquias;

CREATE TABLE IF NOT EXISTS public.parroquias
(
    id integer NOT NULL DEFAULT nextval('parroquias_id_seq'::regclass),
    parroquia text COLLATE pg_catalog."default" NOT NULL,
    sector text COLLATE pg_catalog."default" NOT NULL,
    parroco text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT parroquias_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.parroquias
    OWNER to postgres;

-- Table: public.creyentes

-- DROP TABLE IF EXISTS public.creyentes;

CREATE TABLE IF NOT EXISTS public.creyentes
(
    id integer NOT NULL DEFAULT nextval('creyentes_id_seq'::regclass),
    nombres text COLLATE pg_catalog."default" NOT NULL,
    apellidos text COLLATE pg_catalog."default" NOT NULL,
    lugar_nacimiento text COLLATE pg_catalog."default",
    fecha_nacimiento date,
    cedula integer,
    CONSTRAINT creyentes_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.creyentes
    OWNER to postgres;

-- Table: public.registros_civiles

-- DROP TABLE IF EXISTS public.registros_civiles;

CREATE TABLE IF NOT EXISTS public.registros_civiles
(
    id integer NOT NULL DEFAULT nextval('registros_civiles_id_seq'::regclass),
    provincia_rc text COLLATE pg_catalog."default",
    canton_rc text COLLATE pg_catalog."default",
    parroquia_rc text COLLATE pg_catalog."default",
    anio_rc integer,
    tomo_rc integer,
    pagina_rc integer,
    acta_rc integer,
    fecha_rc date,
    CONSTRAINT registros_civiles_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.registros_civiles
    OWNER to postgres;
