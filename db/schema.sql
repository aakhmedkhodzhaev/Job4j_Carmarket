create table engine (
  id serial primary key
);

CREATE TABLE j_user
(
    id integer NOT NULL,
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    email character varying(32) COLLATE pg_catalog."default",
    password character varying(64) COLLATE pg_catalog."default" NOT NULL,
    created_date date,
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

create table j_car(
	id integer primary key,
	brand_id integer NOT NULL,
	model_id integer NOT NULL,
  name character varying(32) COLLATE pg_catalog."default" NOT NULL,
  price character varying(20) COLLATE pg_catalog."default" NOT NULL,
  years date,
	date_of_issue date,
  created_by integer,
	created_date date,
  update_by integer,
	update_date date,
CONSTRAINT j_brand_fkey FOREIGN KEY (brand_id)
	References j_brand(id),
CONSTRAINT j_model_id_fkey FOREIGN KEY (model_id)
	References j_model(id)
);

create table j_market(
	id integer primary key,
	user_id integer NOT NULL,
	car_id integer NOT NULL,
  name character varying(32) COLLATE pg_catalog."default" NOT NULL,
  description character varying(500) COLLATE pg_catalog."default" NOT NULL,
  city_id integer NOT NULL,
	photo_name character varying(32),
  created_by integer,
	created_date date,
  update_date date,
CONSTRAINT j_user_fkey FOREIGN KEY (user_id)
	References j_user(id),
CONSTRAINT j_car_fkey FOREIGN KEY (car_id)
	References j_car(id),
CONSTRAINT j_city_fkey FOREIGN KEY (city_id)
	References j_city(id)
);