CREATE TABLE "car" (
  "car_id" SERIAL,
  "color" VARCHAR(100),
  "make" VARCHAR(100),
  "model" VARCHAR(100),
  "year" INTEGER,
  "serial_number" VARCHAR(100),
  "new" BOOLEAN,
  PRIMARY KEY ("car_id")
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
  "name" VARCHAR(100),
  PRIMARY KEY ("part_id")
);
CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "car_id" INTEGER NOT NULL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  "phone" INTEGER,
  "billing_info" VARCHAR(100),
  PRIMARY KEY ("customer_id"),
  FOREIGN KEY(car_id) REFERENCES car(car_id)
);
CREATE TABLE "service_ticket" (
  "service_ticket_id" SERIAL,
  "car_id" INTEGER NOT NULL,
  "is_fullfilled" BOOLEAN,
  "date_received" DATE,
  "date_returned" DATE,
  PRIMARY KEY ("service_ticket_id"),
  FOREIGN KEY(car_id) REFERENCES car(car_id)
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
  "cost" VARCHAR(100),
  "mechanic_id" INTEGER NOT NULL,
  "upc" INTEGER NOT NULL,
  PRIMARY KEY ("service_task_id"),
  FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(service_ticket_id),
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
  FOREIGN KEY(upc) REFERENCES part_inventory(upc)
);
CREATE TABLE "sales_invoice" (
  "invoice_id" SERIAL,
  "cost" NUMERIC(10,2),
  "salesperson_id" INTEGER NOT NULL,
  "car_id" INTEGER NOT NULL,
  "date" DATE,
  PRIMARY KEY ("invoice_id"),
  FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id)
);

CREATE OR REPLACE PROCEDURE cust_info(
	firstName VARCHAR(100),
	lastName VARCHAR(100),
	location VARCHAR(150),
	telephone INTEGER,
	payment VARCHAR(100)
)
language plpgsql
as $$
BEGIN
	-- Adding late fee to customer payment amount
	UPDATE payment
	SET amount = amount + lateFeeAmount
	WHERE customer_id = customer;
	-- Commit the above statement inside a transaction
	COMMIT;
END;
$$

INSERT INTO customer(first_name,last_name,address,phone,billing_info)
VALUES(firstName,lastName, , address, telephone, payment);