/*------------------------------------------------------------------------------
 Create Author: Artem Gavrilov M.
 Version: 3.0
 Discription: Table №1.
 -------------------------------------------------------------------------------*/
CREATE DATABASE ggfi_beta;
 /*******************************************************************************/
CREATE sequence vrsz_coordinc start with 1 increment by 1;
CREATE TABLE vrsz_coord
(
  inc integer NOT NULL DEFAULT nextval('vrsz_coordinc'::regclass),
  lat real,
  "long" real,
  datetime timestamp without time zone,
  ide_inf integer,
  nn integer,
  skor real,
  ta real,
  hw real,
  irain real,
  CONSTRAINT vrsz_coord_pkey PRIMARY KEY (inc)
);
/******************************************************************************/
CREATE TABLE vrsz_meas
(
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
CREATE sequence rmd_coordinc start with 1 increment by 1;
CREATE TABLE rmd
  (
    inc integer NOT NULL DEFAULT nextval('rmd_coordinc'::regclass),
    lat real,
    "long" real,
    datetime timestamp without time zone,
    ide_inf integer,
    depth real
  );
/*------------------------------------------------------------------------------
-Discription: Table №3.
------------------------------------------------------------------------------*/
CREATE sequence grndinc start with 1 increment by 1;
CREATE TABLE grnd
  (
    inc integer NOT NULL DEFAULT nextval('grndinc'::regclass) primary key,
    name character varying(50)
  );
/******************************************************************************/
CREATE sequence reflinc start with 1 increment by 1;
CREATE TABLE refl
  (
    inc integer NOT NULL DEFAULT nextval('reflinc'::regclass) primary key,
    refl real ARRAY[10]
  );
/******************************************************************************/
create sequence pgmd_coordinc start with 1 increment by 1;
CREATE TABLE pgmd_coord
(
  inc integer NOT NULL DEFAULT nextval('pgmd_coordinc'::regclass),
  lat real,
  "long" real,
  datetime timestamp without time zone,
  ide_inf integer,
  grnd integer,
  refl integer,
  ng integer,
  CONSTRAINT pgmd_coord_pkey PRIMARY KEY (inc),
  CONSTRAINT pgmd_coord_grnd_fkey FOREIGN KEY (grnd)
      REFERENCES grnd (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pgmd_coord_refl_fkey FOREIGN KEY (refl)
      REFERENCES refl (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
/******************************************************************************/
CREATE TABLE pgmd_meas
(
  pgmd_coord integer,
  hsl real,
  zvuk real,
  alf real,
  ro real,
  CONSTRAINT pgmd_meas_pgmd_coord_fkey FOREIGN KEY (pgmd_coord)
      REFERENCES pgmd_coord (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
/*------------------------------------------------------------------------------
-Discription: Table №4.
------------------------------------------------------------------------------*/
CREATE sequence prgs_coordinc start with 1 increment by 1;
CREATE TABLE prgs_coord
(
  inc integer NOT NULL DEFAULT nextval('prgs_coordinc'::regclass),
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
CREATE TABLE prgs_meas
(
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
CREATE sequence chan_coordinc start with 1 increment by 1;
CREATE TABLE chan_coord
(
  inc integer NOT NULL DEFAULT nextval('chan_coordinc'::regclass),
  lat real,
  "long" real,
  hgor real,
  datetimebeg timestamp without time zone,
  datetimeend timestamp without time zone,
  nn integer,
  skor real,
  ta real,
  hw real,
  irain real,
  iship real,
  CONSTRAINT chan_coord_pkey PRIMARY KEY (inc)
);
/******************************************************************************/
CREATE TABLE chan_meas
(
  chan_coord integer,
  frec real,
  pnois real,
  CONSTRAINT chan_meas_chan_coord_fkey FOREIGN KEY (chan_coord)
      REFERENCES chan_coord (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
/*------------------------------------------------------------------------------
-Discription: Table №6.
------------------------------------------------------------------------------*/
CREATE sequence pm_coordinc start with 1 increment by 1;
CREATE TABLE  pm_coord
  (
    inc integer not null default nextval('pm_coordinc') primary key,
    lat    real,
    long   real,
    datetime   timestamp,
    ns   real,
    nw   real,
    nr   real,
    pmet   real
);
/*------------------------------------------------------------------------------
-Discription: Table №7.
------------------------------------------------------------------------------*/
CREATE sequence ht_coordinc start with 1 increment by 1;
CREATE TABLE ht_coord
(
  inc integer NOT NULL DEFAULT nextval('ht_coordinc'::regclass),
  lat real,
  "long" real,
  datetimebeg timestamp without time zone,
  datetimeend timestamp without time zone,
  nn integer,
  skor real,
  ta real,
  hw real,
  irain real,
  CONSTRAINT ht_coord_pkey PRIMARY KEY (inc)
);
/******************************************************************************/
CREATE TABLE ht_meas
(
  ht_coord integer,
  hgor real,
  vstream real,
  kstream real,
  CONSTRAINT ht_meas_ht_coord_fkey FOREIGN KEY (ht_coord)
      REFERENCES ht_coord (inc) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);
