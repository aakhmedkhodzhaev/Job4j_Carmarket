create table engine (
  id serial primary key
);

CREATE TABLE j_user
(
    id integer NOT NULL,
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    email character varying(32) COLLATE pg_catalog."default",
    password character varying(64) COLLATE pg_catalog."default" NOT NULL,
    create_date date,
    update_date date,
    CONSTRAINT j_user_pkey PRIMARY KEY (id),
    CONSTRAINT j_user_email_key UNIQUE (email)
);

create table driver (
  id serial primary key
);

create table car (
  id serial primary key,
  engine_id int not null unique references engine(id)
);

create table history_owner (
   id serial primary key,
   driver_id int not null references driver(id),
   car_id int not null references car(id)
);

CREATE TABLE j_city (
id integer NOT NULL,
name character varying(32) COLLATE pg_catalog."default" NOT NULL,
CONSTRAINT j_city_pkey PRIMARY KEY (id));

CREATE TABLE j_brand (
id integer NOT NULL,
name character varying(32) COLLATE pg_catalog."default" NOT NULL,
CONSTRAINT j_model_pkey PRIMARY KEY (id));

CREATE TABLE j_model (
id integer NOT NULL,
brand_id integer NOT NULL,
name character varying(32) COLLATE pg_catalog."default" NOT NULL,
CONSTRAINT j_model_pkey PRIMARY KEY (id),
CONSTRAINT j_model_brand_fkey FOREIGN KEY (brand_id)
References j_brand(id)
);