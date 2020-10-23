CREATE TABLE "car" (
  "serial_number" VARCHAR(100) NOT NULL,
  "color" VARCHAR(100),
  "make" VARCHAR(100),
  "model" VARCHAR(100),
  "year_" INTEGER,
  "new_" BOOLEAN,
  PRIMARY KEY ("serial_number")
);
CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  PRIMARY KEY ("salesperson_id")
);
CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "hourly_rate" NUMERIC(8,2),
  PRIMARY KEY ("mechanic_id")
);
CREATE TABLE "part" (
  "part_id" SERIAL,
  "purchase_cost" NUMERIC(8,2),
  "retail_cost" NUMERIC(8,2),
  "name_" VARCHAR(100),
  PRIMARY KEY ("part_id")
);
CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "serial_number" VARCHAR(100) NOT NULL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  "phone" BIGINT,
  "billing_info" VARCHAR(100),
  PRIMARY KEY ("customer_id"),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);
CREATE TABLE "service_ticket" (
  "service_ticket_id" SERIAL,
  "serial_number" VARCHAR(100) NOT NULL,
  "is_fullfilled" BOOLEAN,
  "date_received" DATE,
  "date_returned" DATE,
  PRIMARY KEY ("service_ticket_id"),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);
CREATE TABLE "part_inventory" (
  "upc" SERIAL,
  "part_id" INTEGER NOT NULL,
  PRIMARY KEY ("upc"),
  FOREIGN KEY(part_id) REFERENCES part(part_id)
);
CREATE TABLE "service_task" (
  "service_task_id" SERIAL,
  "service_ticket_id" INTEGER NOT NULL,
  "service_name" VARCHAR(100),
  "service_task_cost" VARCHAR(100),
  "mechanic_id" INTEGER NOT NULL,
  "upc" INTEGER NOT NULL,
  PRIMARY KEY ("service_task_id"),
  FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id),
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
  FOREIGN KEY(upc) REFERENCES part_inventory(upc)
);
CREATE TABLE "sales_invoice" (
  "invoice_id" SERIAL,
  "cost_" NUMERIC(10,2),
  "salesperson_id" INTEGER NOT NULL,
  "serial_number" VARCHAR(100) NOT NULL,
  "date_" DATE,
  PRIMARY KEY ("invoice_id"),
  FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
  FOREIGN KEY(serial_number) REFERENCES car(serial_number)
);