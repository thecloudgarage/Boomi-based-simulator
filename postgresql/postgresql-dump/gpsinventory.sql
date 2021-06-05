-- Adminer 4.8.1 PostgreSQL 9.5.25 dump

DROP TABLE IF EXISTS "gpsinventory";
DROP SEQUENCE IF EXISTS gpsinventory_id_seq;
CREATE SEQUENCE gpsinventory_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 6 CACHE 1;

CREATE TABLE "public"."gpsinventory" (
    "id" integer DEFAULT nextval('gpsinventory_id_seq') NOT NULL,
    "gpsterminalid" text,
    "customerId" text,
    "customerName" text,
    "lat" double precision,
    "long" double precision,
    "timestamp" timestamptz,
    CONSTRAINT "gpsinventory_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE INDEX "gpsinventory_customerId" ON "public"."gpsinventory" USING btree ("customerId");

CREATE INDEX "gpsinventory_gpsterminalid" ON "public"."gpsinventory" USING btree ("gpsterminalid");

INSERT INTO "gpsinventory" ("id", "gpsterminalid", "customerId", "customerName", "lat", "long", "timestamp") VALUES
(1,	'gps-001-0001',	'1',	'abc001 private limited',	NULL,	NULL,	NULL),
(2,	'gps-002-0001',	'2',	'abc002 private limited',	NULL,	NULL,	NULL),
(3,	'gps-003-0001',	'3',	'abc003 private limited',	NULL,	NULL,	NULL),
(4,	'gps-004-0001',	'4',	'abc004 private limited',	NULL,	NULL,	NULL),
(5,	'gps-005-0001',	'5',	'abc005 private limited',	NULL,	NULL,	NULL),
(6,	'gps-006-0001',	'6',	'abc006 private limited',	NULL,	NULL,	NULL);

-- 2021-06-05 12:55:55.061217+00
