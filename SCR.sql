/*------------------------------------------------------------------------------
Create Author: Artem Gavrilov M.
Discription: Table №1.
------------------------------------------------------------------------------*/
create sequence vrsz_coordinc start with 1 increment by 1;
CREATE TABLE  vrsz_coord
  (
    inc integer not null default nextval('vrsz_coordinc') primary key,
    lat    real,
    long   real,
    datetime   timestamp,
    ide_inf   integer,
    skor   real,
    ta   real,
    hw   real,
    irain   real
  );
/******************************************************************************/
--create sequence vrsz_measinc start with 1 increment by 1;
CREATE TABLE  vrsz_meas
  (
    --inc integer not null default nextval('vrsz_measinc'),
    vrsz_coord integer references vrsz_coord(inc),
    nn    integer,
    hgor   real,
    zvuk   real
  );
/*------------------------------------------------------------------------------
Discription: Table №2.
------------------------------------------------------------------------------*/
create sequence rmd_coordinc start with 1 increment by 1;
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
Discription: Table №3.
------------------------------------------------------------------------------*/
create sequence pgmd_coordinc start with 1 increment by 1;
CREATE TABLE pgmd_coord
  (
    inc integer NOT NULL DEFAULT nextval('pgmd_coordinc'::regclass) primary key,
    lat real,
    "long" real,
    datetime timestamp without time zone,
    ide_inf integer,
    grnd integer references grnd(name),
    refl integer references refl(refl),
    ng integer
  );
/******************************************************************************/
--create sequence grndinc start with 1 increment by 1;
CREATE TABLE grnd
  (
    --inc integer NOT NULL DEFAULT nextval('grndinc'::regclass),
    name character varying(50) primary key
  );
/******************************************************************************/
--create sequence reflinc start with 1 increment by 1;
CREATE TABLE refl
  (
    --inc integer NOT NULL DEFAULT nextval('reflinc'::regclass),
    refl real ARRAY[10]
  );
/******************************************************************************/
--create sequence pgmd_measinc start with 1 increment by 1;
CREATE TABLE pgmd_meas
  (
    --inc integer NOT NULL DEFAULT nextval('pgmd_measinc'::regclass),
    pgmd_coord integer references pgmd_coord(inc),
    hsl real,
    zvuk real,
    alf real,
    ro real
  );
/*------------------------------------------------------------------------------
Discription: Table №4.
------------------------------------------------------------------------------*/
create sequence prgs_coordinc start with 1 increment by 1;
CREATE TABLE  prgs_coord
     (
       inc integer not null default nextval('prgs_coordinc') primary key,
       lat1    real,
       long1   real,
       lat2    real,
       long2   real,
       datetime   timestamp,
       skor   real,
       ta   real,
       hw   real,
       irain   real,
       prgs_meas integer
     );
/******************************************************************************/
--create sequence prgs_measinc start with 1 increment by 1;
CREATE TABLE  prgs_meas
     (
       --inc integer not null default nextval('prgs_measinc'),
       prgs_coord integer references prgs_coord(inc),
       datetime timestamp,
       dist   real,
       hlzl    real,
       hpr   real,
       klost   real
     );
/*------------------------------------------------------------------------------
Discription: Table №5.
------------------------------------------------------------------------------*/
create sequence chan_coordinc start with 1 increment by 1;
CREATE TABLE  chan_coord
  (
    inc integer not null default nextval('chan_coordinc') primary key,
    lat    real,
    long   real,
    hgor   real,
    datetimebeg   timestamp,
    datetimeend   timestamp,
    skor   real,
    ta   real,
    hw   real,
    irain   real,
    iship   real,
    chan_meas integer
  );
/******************************************************************************/
--create sequence chan_measinc start with 1 increment by 1;
CREATE TABLE  chan_meas
  (
    --inc integer not null default nextval('chan_measinc'),
    chan_coord integer references chan_coord(inc),
    nn    integer,
    hgor   real,
    frec   real,
    pnois   real
  );
/*------------------------------------------------------------------------------
Discription: Table №6.
------------------------------------------------------------------------------*/
create sequence pm_coordinc start with 1 increment by 1;
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
Discription: Table №7.
------------------------------------------------------------------------------*/
create sequence ht_coordinc start with 1 increment by 1;
CREATE TABLE  ht_coord
  (
    inc integer not null default nextval('ht_coordinc') primary key,
    lat    real,
    long   real,
    datetimebeg   timestamp,
    datetimeend   timestamp,
    skor   real,
    ta   real,
    hw   real,
    irain   real,
    ht_meas integer
  );
  /****************************************************************************/
--create sequence ht_measinc start with 1 increment by 1;
CREATE TABLE  ht_meas
    (
      --inc integer not null default nextval('ht_measinc'),
      ht_coord integer references ht_coord(inc),
      nn    integer,
      hgor   real,
      vstream   real,
      kstream   real
    );
/******************************************************************************/
