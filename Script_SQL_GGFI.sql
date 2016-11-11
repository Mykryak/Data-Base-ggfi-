/*------------------------------------------------------------------------------
 Create Author: Artem Gavrilov M.
 Version: 3.2.6
 Discription: SQL-запросы для создания таблиц БД ГГФИ
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
Discription: Создание базы данных.
p.s. Выполнить отдельно!!!
------------------------------------------------------------------------------*/
CREATE DATABASE ggfi_beta
 WITH OWNET = postgres
  ENCODING = 'KOI8R'
  TABLESPACE = pg_default
  LC_COLLATE = 'ru_RU.KOI8-R'
  LC_CTYPE = 'ru_RU.KOI8-R'
  CONNECTION LIMIT = -1;
/******************************************************************************/
CREATE TABLE ide_inf (
  inc serial NOT NULL,
  name character varying(255),
  CONSTRAINT ide_inf_pkey PRIMARY KEY (inc )
);
/*------------------------------------------------------------------------------
 Discription: Table №1.
------------------------------------------------------------------------------*/
CREATE TABLE vrsz_coord (
  inc serial NOT NULL,
  lat real,
  "long" real,
  datetime timestamp without time zone,
  ide_inf integer,
  nn integer,
  skor real,
  ta real,
  hw real,
  irain real,
  CONSTRAINT vrsz_coord_pkey PRIMARY KEY (inc),
  CONSTRAINT vrsz_coord_ide_inf_fkey FOREIGN KEY (ide_inf)
      REFERENCES ide_inf (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
  );
/******************************************************************************/
CREATE TABLE vrsz_meas (
  vrsz_coord integer,
  hgor real,
  zvuk real,
  CONSTRAINT vrsz_meas_vrsz_coord_fkey FOREIGN KEY (vrsz_coord)
      REFERENCES vrsz_coord (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
    );
/*------------------------------------------------------------------------------
-Discription: Table №2.
------------------------------------------------------------------------------*/
CREATE TABLE rmd (
    inc serial NOT NULL,
    lat real,
    "long" real,
    datetime timestamp without time zone,
    ide_inf integer,
    depth real,
    CONSTRAINT rmd_ide_inf_fkey FOREIGN KEY (ide_inf)
        REFERENCES ide_inf (inc) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE NO ACTION
  );
/*------------------------------------------------------------------------------
-Discription: Table №3.
------------------------------------------------------------------------------*/
CREATE TABLE pgmd_coord (
  inc       serial NOT NULL,
  lat       real,
  long      real,
  datetime  timestamp WITHOUT TIME ZONE,
  ide_inf   integer,
  grnd      integer,
  refl      integer,
  ng        integer,
  CONSTRAINT pgmd_coord_pkey
    PRIMARY KEY (inc),
  CONSTRAINT pgmd_coord_ide_inf_fkey FOREIGN KEY (ide_inf)
    REFERENCES ide_inf (inc) MATCH SIMPLE,
  CONSTRAINT pgmd_coord_grnd_fkey FOREIGN KEY (grnd)
      REFERENCES grnd(inc_grnd) MATCH SIMPLE
  );
/******************************************************************************/
CREATE TABLE grnd (
  inc_grnd  serial NOT NULL,
  name   varchar(50) NOT NULL,
  CONSTRAINT grnd1_pkey
    PRIMARY KEY (inc_grnd)
  );
/******************************************************************************/
CREATE TABLE grnd_p (
  inc      serial NOT NULL,
  "name"   varchar(150),
  inc_grnd  integer NOT NULL DEFAULT 0,
  CONSTRAINT grnd_pkey
    PRIMARY KEY (inc),
  CONSTRAINT foreign_key01
    FOREIGN KEY (inc_grnd)
    REFERENCES grnd(inc_grnd)
  );
/******************************************************************************/
CREATE TABLE refl (
  inc    serial NOT NULL,
  angle  real NOT NULL DEFAULT 0,
  refl   real NOT NULL DEFAULT 0,
  inc_i  integer NOT NULL DEFAULT 0,
  CONSTRAINT refl_pkey
    PRIMARY KEY (inc),
  CONSTRAINT foreign_key01
    FOREIGN KEY (inc_i)
    REFERENCES pgmd_coord(inc)
  );
/******************************************************************************/
CREATE TABLE pgmd_meas (
  pgmd_meas_id  serial NOT NULL,
  pgmd_coord    integer,
  hsl           real,
  zvuk          real,
  alf           real,
  ro            real,
  inc_p         integer,
  CONSTRAINT pgmd_meas_pkey
    PRIMARY KEY (pgmd_meas_id),
  CONSTRAINT foreign_key01
    FOREIGN KEY (inc_p)
    REFERENCES grnd_p(inc)
    ON UPDATE CASCADE,
  CONSTRAINT pgmd_meas_pgmd_coord_fkey
    FOREIGN KEY (pgmd_coord)
    REFERENCES pgmd_coord(inc)
  );
/*------------------------------------------------------------------------------
-Discription: Table №4.
------------------------------------------------------------------------------*/
CREATE TABLE prgs_coord (
  inc serial NOT NULL,
  lat1 real,
  long1 real,
  lat2 real,
  long2 real,
  datetime timestamp without time zone,
  skor real,
  ta real,
  hw real,
  irain real,
  CONSTRAINT prgs_coord_pkey PRIMARY KEY (inc)
);
/******************************************************************************/
CREATE TABLE prgs_meas (
  prgs_coord integer,
  dist real,
  hlzl real,
  hpr real,
  klost real,
  CONSTRAINT prgs_meas_prgs_coord_fkey FOREIGN KEY (prgs_coord)
      REFERENCES prgs_coord (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
/*------------------------------------------------------------------------------
-Discription: Table №5.
------------------------------------------------------------------------------*/
CREATE TABLE chan_coord (
  inc          serial NOT NULL,
  lat          real NOT NULL,
  long         real NOT NULL,
  datetimebeg  timestamp WITHOUT TIME ZONE NOT NULL,
  datetimeend  timestamp WITHOUT TIME ZONE NOT NULL,
  nn           integer,
  skor         real,
  ta           real,
  hw           real,
  hw2          real,
  irain        real,
  iship        real,
  CONSTRAINT chan_coord_pkey
    PRIMARY KEY (inc)
  );
/******************************************************************************/
CREATE TABLE chan_meas (
  chan_coord_id  serial NOT NULL,
  chan_coord     integer NOT NULL,
  hgor           real,
  nn             integer,
  frec           real,
  pnois          real,
  CONSTRAINT chan_meas_pkey1
    PRIMARY KEY (chan_coord_id),
  CONSTRAINT foreign_key01
    FOREIGN KEY (chan_coord)
    REFERENCES chan_coord(inc)
  );
  CREATE UNIQUE INDEX chan_meas_index01
  ON chan_meas
  (chan_coord, hgor, frec);
/*------------------------------------------------------------------------------
-Discription: Table №6.
------------------------------------------------------------------------------*/
CREATE TABLE pm_coord (
  inc       serial NOT NULL,
  lat       real,
  long      real,
  datetime  date,
  CONSTRAINT pm_coord_pkey
    PRIMARY KEY (inc)
);
/******************************************************************************/
CREATE TABLE pm_coord_nr (
  inc_nr  serial NOT NULL,
  diap    varchar(30) NOT NULL,
  CONSTRAINT pm_coord_nr_pkey
    PRIMARY KEY (inc_nr)
);
/******************************************************************************/
CREATE TABLE pm_coord_nw (
  inc_nw  serial NOT NULL,
  diap    varchar(30) NOT NULL,
  CONSTRAINT pm_coord_nw_pkey
    PRIMARY KEY (inc_nw)
);
/******************************************************************************/
CREATE TABLE pm_coord_ns (
  inc_ns  serial NOT NULL,
  diap    varchar(30) NOT NULL,
  CONSTRAINT pm_coord_ns_pkey
    PRIMARY KEY (inc_ns)
);
CREATE TABLE pm_coord_pmet (
  inc_pmet  serial NOT NULL,
  inc       integer NOT NULL,
  inc_ns    integer,
  inc_nw    integer,
  inc_nr    integer NOT NULL,
  pmet      real,
  CONSTRAINT pm_coord_pmet_pkey PRIMARY KEY (inc_pmet),
  CONSTRAINT foreign_key01 FOREIGN KEY (inc)
    REFERENCES pm_coord(inc),
  CONSTRAINT foreign_key02 FOREIGN KEY (inc_ns)
    REFERENCES pm_coord_ns(inc_ns),
  CONSTRAINT foreign_key03 FOREIGN KEY (inc_nw)
    REFERENCES pm_coord_nw(inc_nw),
  CONSTRAINT foreign_key04 FOREIGN KEY (inc_nr)
    REFERENCES pm_coord_nr(inc_nr)
);
/*------------------------------------------------------------------------------
-Discription: Table №7.
------------------------------------------------------------------------------*/
CREATE TABLE ht_coord (
  inc          serial NOT NULL,
  lat          real,
  long         real,
  datetimebeg  timestamp WITHOUT TIME ZONE,
  datetimeend  timestamp WITHOUT TIME ZONE,
  nn           integer,
  skor         real,
  ta           real,
  hw           real,
  irain        real,
  ide_inf      integer,
  CONSTRAINT ht_coord_pkey
    PRIMARY KEY (inc),
  CONSTRAINT ht_coord_ide_inf_fkey FOREIGN KEY (ide_inf)
    REFERENCES ide_inf (inc) MATCH SIMPLE
    ON UPDATE NO ACTION ON DELETE NO ACTION
  );
/******************************************************************************/
CREATE TABLE ht_meas (
  ht_meas_id  serial NOT NULL,
  ht_coord    integer,
  nn          integer,
  hgor        real,
  vstream     real,
  kstream     real,
  CONSTRAINT ht_meas_pkey1
    PRIMARY KEY (ht_meas_id),
  CONSTRAINT foreign_key01
    FOREIGN KEY (ht_coord)
    REFERENCES ht_coord(inc)
  );
CREATE UNIQUE INDEX ht_meas_index01
  ON ht_meas
  (hgor, ht_coord);
/******************************************************************************/
