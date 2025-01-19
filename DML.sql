-- INSERT DATA

-- Module 1: Supply Chain Coordination
--INSERT DATA INTO COMPANY
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('EcoBuild Solutions','Sustainable Build','123 Green Street, Kuala Lumpur','Farhan','Ahmad','Mr','6012-345 6789','info@ecobuild.com',50000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('GreenTech Materials','Building Materials','456 Nature Ave, GeorgeTown','Amina','Rahman','Ms','6012-345 6790','contact@greentech.com',10100);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('SolidCore Industries','Concrete Products','789  Taman Riang, Johor Bahru','John','Lim','Dr','6012-345 6791','sales@solidcore.com',80000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('Recycled Structures','Recycled Materials','321 Blvd Road, Shah Alam','Maria','Tan','Ms','6012-345 6792','recycle@structures.com',75000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('Bamboo Creations','Eco-friendly Build','654 Industrial Park, Bayan Lepas','Ismail','Zulkifli','Mr','6012-345 6793','bamboo@creations.com',88000);

--INSER DATA INTO SHIPPING_DESTINATION
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Sunway Construction Site','123 Jalan Tropicana, Petaling Jaya, Selangor','C0001',50000);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Ecohill Development Site','45 Jalan Semenyih, Semenyih, Selangor','C0002',10300);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('The Light City Project','789 Persiaran Bayan Indah, Bayan Lepas, Penang','C0003',80000);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Permas Heights Development','12 Jalan Permas Jaya, Johor Bahru, Johor','C0004',40100);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('East Coast Highway Extension','345 Jalan Kuantan-Kemaman, Kuantan, Pahan','C0005',11900);

--INSERT DATA INTO ORDERS
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (DEFAULT, 'Farhan','Ahmad','6012-345 6789','DLV','Z000001','D00001');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-02', 'YYYY-MM-DD'),'Amina','Rahman','6012-345 6790','CPL','Z000002','D00002');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-03', 'YYYY-MM-DD'),'John','Lim','6012-345 6791','CPL','Z000003','D00003');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-04', 'YYYY-MM-DD'),'Jane','Doe','6012-345 6792','PND','Z000004','D00004');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-05', 'YYYY-MM-DD'),'Ismail','Zulkifli','6012-345 6793','RTR','Z000005','D00005');

--INSERT DATA INTO PRODUCT
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Concrete Mix','High-strength ready-mix concrete','Cubic Meter',250);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Clay Bricks','Durable clay bricks for walls and structures','Piece',0.85);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Steel Bars','Reinforced steel bars for structural support','Kilogram',6.5);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Fly Ash Bricks','Eco-friendly bricks made from fly ash','Piece',1);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Roofing Tiles','Sustainable clay roofing tiles','Piece',4.2);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Thermal Insulation','High-performance thermal insulation material','Roll',120);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Precast Concrete Beam','Precast concrete beams for construction projects','Unit',150);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Structural Steel Plate','Steel plates for building frameworks','Kilogram',5.75);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Cement Bag','50kg bags of high-grade cement','Bag',25);
INSERT INTO PRODUCT (PROD_NAME, PROD_DESC, PROD_UOM, PROD_UNIT_PRICE) VALUES ('Bamboo Panels','Eco-friendly bamboo panels for flooring','Square Meter',30);


-- Module 2: Inventory and Storage Management
--INSERT DATA INTO CITY
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('50000', 'Kuala Lumpur', 'Wilayah Persekutuan Kuala Lumpur');
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('40100', 'Shah Alam', 'Selangor');
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('80000', 'Johor Bahru', 'Johor');
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('11900', 'Bayan Lepas', 'Penang');
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('10300', 'George Town', 'Penang');
INSERT INTO CITY (POSTCODE, CITY_NAME, CITY_STATE) VALUES ('93300', 'Kuching', 'Sarawak');

--INSERT DATA INTO WAREHOUSE
INSERT INTO WAREHOUSE (WHS_NAME, WHS_ADDR, WHS_PHONE, WHS_OPEN, WHS_CLOSE, POSTCODE) VALUES ('Central Concrete Depot','No. 1, Jalan Sultan Ismail, Kuala Lumpur', '6012-128 5321', TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'), 50000);
INSERT INTO WAREHOUSE (WHS_NAME, WHS_ADDR, WHS_PHONE, WHS_OPEN, WHS_CLOSE, POSTCODE) VALUES ('Eco Brick Supplies','No. 23, Taman Ungku Tun Aminah, Johor Bahru', '6011-118 5121', TO_TIMESTAMP('08:30', 'HH24:MI'), TO_TIMESTAMP('16:30', 'HH24:MI'), 80000);
INSERT INTO WAREHOUSE (WHS_NAME, WHS_ADDR, WHS_PHONE, WHS_OPEN, WHS_CLOSE, POSTCODE) VALUES ('Steel Framework Hub','No. 45, Lebuh Farquhar, George Town', '6014-448 0221', TO_TIMESTAMP('09:00', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'), 10300);
INSERT INTO WAREHOUSE (WHS_NAME, WHS_ADDR, WHS_PHONE, WHS_OPEN, WHS_CLOSE, POSTCODE) VALUES ('Insulation Solutions','Jalan Kuantan-Gambang, Kuantan', '6011-789 0511', TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('16:30', 'HH24:MI'), 10300);
INSERT INTO WAREHOUSE (WHS_NAME, WHS_ADDR, WHS_PHONE, WHS_OPEN, WHS_CLOSE, POSTCODE) VALUES ('Sustainable Roofing Depot','Bayan Lepas Industrial Park, 11900 Bayan Lepas', '6012-578 1234', TO_TIMESTAMP('07:30', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'), 11900);

--INSERT DATA INTO SECTION
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Ready-Mix Concrete',1,TO_DATE('2025-09-01', 'YYYY-MM-DD'),'W0001');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Precast Concrete',2,TO_DATE('2025-09-02', 'YYYY-MM-DD'),'W0001');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Clay Bricks',1,TO_DATE('2025-09-03', 'YYYY-MM-DD'),'W0002');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Fly Ash Bricks',2,TO_DATE('2025-09-04', 'YYYY-MM-DD'),'W0002');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Structural Steel',1,TO_DATE('2025-09-05', 'YYYY-MM-DD'),'W0003');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Reinforced Steel Bars',2,TO_DATE('2025-09-06', 'YYYY-MM-DD'),'W0003');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Thermal Insulation',1,TO_DATE('2025-09-07', 'YYYY-MM-DD'),'W0004');
INSERT INTO SECTION (SECT_NAME, SECT_FLOOR, SECT_DATE_CHECK, WHS_ID) VALUES ('Roofing Tiles',2,TO_DATE('2025-09-08', 'YYYY-MM-DD'),'W0005');

--INSERT DATA INTO EMPLOYEE
INSERT INTO EMPLOYEE (EMP_PW, EMP_TIN, EMP_IC, EMP_FNAME, EMP_LNAME, EMP_ROLE, EMP_TITLE, EMP_BDATE, EMP_PHONE, EMP_EMAIL, WHS_ID) VALUES ('Pw12345@','IG50012345078','900101-07-1234','Ahmad','Ali','Manager','Mr', TO_DATE('1990-01-01', 'YYYY-MM-DD'),'6012-345 6789','ahmad@gmail.com','W0001');
INSERT INTO EMPLOYEE (EMP_PW, EMP_TIN, EMP_IC, EMP_FNAME, EMP_LNAME, EMP_ROLE, EMP_TITLE, EMP_BDATE, EMP_PHONE, EMP_EMAIL, WHS_ID) VALUES ('Sec4567!','IG50098765630','920202-02-2345','Siti','Zainab','Supervisor','Ms', TO_DATE('1992-02-02', 'YYYY-MM-DD'),'6019-876 5432','siti@gmail.com','W0002');
INSERT INTO EMPLOYEE (EMP_PW, EMP_TIN, EMP_IC, EMP_FNAME, EMP_LNAME, EMP_ROLE, EMP_TITLE, EMP_BDATE, EMP_PHONE, EMP_EMAIL, WHS_ID) VALUES ('1qazZAQ!','IG50045678290','910303-07-3456','Lim','Wei','Staff','Mr', TO_DATE('1991-03-03', 'YYYY-MM-DD'),'6014-567 8901','lim@gmail.com','W0003');
INSERT INTO EMPLOYEE (EMP_PW, EMP_TIN, EMP_IC, EMP_FNAME, EMP_LNAME, EMP_ROLE, EMP_TITLE, EMP_BDATE, EMP_PHONE, EMP_EMAIL, WHS_ID) VALUES ('2wsxXSW@','IG50011223740','890404-02-4567','Kumar','Nathan','Staff','Mr', TO_DATE('1989-04-04', 'YYYY-MM-DD'),'6012-233 4455','kumar@gmail.com','W0004');
INSERT INTO EMPLOYEE (EMP_PW, EMP_TIN, EMP_IC, EMP_FNAME, EMP_LNAME, EMP_ROLE, EMP_TITLE, EMP_BDATE, EMP_PHONE, EMP_EMAIL, WHS_ID) VALUES ('3edcCDE#','IG50033445560','870505-06-5678','Nurul','Hidayah','Staff','Ms', TO_DATE('1987-05-05', 'YYYY-MM-DD'),'6019-988 7766','nurul@gmail.com','W0005');


-- Module 3: Aftersales
--INSERT DATA INTO RETURNED_HISTORY
INSERT INTO RETURNED_HISTORY (RET_STAT, ORD_ID, RET_ID) VALUES ('APV','E000001','RI00001');
INSERT INTO RETURNED_HISTORY (RET_STAT, ORD_ID, RET_ID) VALUES ('APV','E000002','RI00002');
INSERT INTO RETURNED_HISTORY (RET_STAT, ORD_ID, RET_ID) VALUES ('APV','E000001','RI00003');
INSERT INTO RETURNED_HISTORY (RET_STAT, ORD_ID, RET_ID) VALUES ('REJ','E000001','RI00004');
INSERT INTO RETURNED_HISTORY (RET_STAT, ORD_ID, RET_ID) VALUES ('APV','E000005','RI00005');

--INSERT DATA INTO RECYCLE_TRANSACTION
INSERT INTO RECYCLE_TRANSACTION (RTRANS_AMOUNT, RTRANS_PAY_METHOD, RTRANS_DATE, RORD_ID) VALUES (500,'EWALLET', TO_DATE('2025-01-16', 'YYYY-MM-DD'),'RO00001');
INSERT INTO RECYCLE_TRANSACTION (RTRANS_AMOUNT, RTRANS_PAY_METHOD, RTRANS_DATE, RORD_ID) VALUES (300,'CARD', TO_DATE('2025-01-18', 'YYYY-MM-DD'),'RO00002');
INSERT INTO RECYCLE_TRANSACTION (RTRANS_AMOUNT, RTRANS_PAY_METHOD, RTRANS_DATE, RORD_ID) VALUES (1000,'CARD', TO_DATE('2025-01-20', 'YYYY-MM-DD'),'RO00003');
INSERT INTO RECYCLE_TRANSACTION (RTRANS_AMOUNT, RTRANS_PAY_METHOD, RTRANS_DATE, RORD_ID) VALUES (700,'CASH', TO_DATE('2025-01-22', 'YYYY-MM-DD'),'RO00004');
INSERT INTO RECYCLE_TRANSACTION (RTRANS_AMOUNT, RTRANS_PAY_METHOD, RTRANS_DATE, RORD_ID) VALUES (400,'CASH', TO_DATE('2025-01-24', 'YYYY-MM-DD'),'RO00005');

--INSERT DATA INTO RECYCLE_ORDER
INSERT INTO RECYCLE_ORDER (RORD_DEALING_DATE, RORD_DELIVERY_DATE, RORD_STATE, COM_ID) VALUES (TO_DATE('2025-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'PRC', 'C0001');
INSERT INTO RECYCLE_ORDER (RORD_DEALING_DATE, RORD_DELIVERY_DATE, RORD_STATE, COM_ID) VALUES (TO_DATE('2025-01-18', 'YYYY-MM-DD'), TO_DATE('2025-01-22', 'YYYY-MM-DD'), 'PND', 'C0002');
INSERT INTO RECYCLE_ORDER (RORD_DEALING_DATE, RORD_DELIVERY_DATE, RORD_STATE, COM_ID) VALUES (TO_DATE('2025-01-20', 'YYYY-MM-DD'), TO_DATE('2025-01-25', 'YYYY-MM-DD'), 'CPL', 'C0003');
INSERT INTO RECYCLE_ORDER (RORD_DEALING_DATE, RORD_DELIVERY_DATE, RORD_STATE, COM_ID) VALUES (TO_DATE('2025-01-22', 'YYYY-MM-DD'), TO_DATE('2025-01-28', 'YYYY-MM-DD'), 'PRC', 'C0004');
INSERT INTO RECYCLE_ORDER (RORD_DEALING_DATE, RORD_DELIVERY_DATE, RORD_STATE, COM_ID) VALUES (TO_DATE('2025-01-25', 'YYYY-MM-DD'), TO_DATE('2025-01-30', 'YYYY-MM-DD'), 'PND', 'C0005');

--INSERT DATA INTO RECYCLED_ITEM
INSERT INTO RECYCLED_ITEM (RITEM_CONDITION, RITEM_QC_DATE, RITEM_QTY, RORD_ID, PROD_ID) VALUES (1, TO_DATE('2025-01-16', 'YYYY-MM-DD'), 100, 'RO00001', 'P00001');
INSERT INTO RECYCLED_ITEM (RITEM_CONDITION, RITEM_QC_DATE, RITEM_QTY, RORD_ID, PROD_ID) VALUES (1, TO_DATE('2025-01-18', 'YYYY-MM-DD'), 50, 'RO00002', 'P00002');
INSERT INTO RECYCLED_ITEM (RITEM_CONDITION, RITEM_QC_DATE, RITEM_QTY, RORD_ID, PROD_ID) VALUES (1, TO_DATE('2025-01-20', 'YYYY-MM-DD'), 200, 'RO00003', 'P00003');
INSERT INTO RECYCLED_ITEM (RITEM_CONDITION, RITEM_QC_DATE, RITEM_QTY, RORD_ID, PROD_ID) VALUES (0, TO_DATE('2025-01-22', 'YYYY-MM-DD'), 150, 'RO00004', 'P00004');
INSERT INTO RECYCLED_ITEM (RITEM_CONDITION, RITEM_QC_DATE, RITEM_QTY, RORD_ID, PROD_ID) VALUES (1, TO_DATE('2025-01-24', 'YYYY-MM-DD'), 80, 'RO00005', 'P00005');


-- Module 4: Sustainable Material Collection
--INSERT DATA INTO LOGISTIC_PROVIDER
INSERT INTO LOGISTIC_PROVIDER (LOG_PIC_FNAME, LOG_PIC_LNAME, LOG_PIC_TITLE, LOG_PHONE, LOG_EMAIL, LOG_OPEN, LOG_CLOSE) VALUES ('Ahmad','Hassan','Mr','6012-345 6789','nippon@logistics.com', TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'));
INSERT INTO LOGISTIC_PROVIDER (LOG_PIC_FNAME, LOG_PIC_LNAME, LOG_PIC_TITLE, LOG_PHONE, LOG_EMAIL, LOG_OPEN, LOG_CLOSE) VALUES ('Siti','Zainab','Ms','6019-875 4321','alfro.cargo@logistics.com', TO_TIMESTAMP('08:30', 'HH24:MI'), TO_TIMESTAMP('16:30', 'HH24:MI'));
INSERT INTO LOGISTIC_PROVIDER (LOG_PIC_FNAME, LOG_PIC_LNAME, LOG_PIC_TITLE, LOG_PHONE, LOG_EMAIL, LOG_OPEN, LOG_CLOSE) VALUES ('Raj','Kumar','Mr','6017-643 2109','gts.logistic@logistics.com', TO_TIMESTAMP('09:00', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'));
INSERT INTO LOGISTIC_PROVIDER (LOG_PIC_FNAME, LOG_PIC_LNAME, LOG_PIC_TITLE, LOG_PHONE, LOG_EMAIL, LOG_OPEN, LOG_CLOSE) VALUES ('Farah','Karim','Mrs','6018-234 5678','maskargo@logistics.com', TO_TIMESTAMP('08:00', 'HH24:MI'), TO_TIMESTAMP('16:30', 'HH24:MI'));
INSERT INTO LOGISTIC_PROVIDER (LOG_PIC_FNAME, LOG_PIC_LNAME, LOG_PIC_TITLE, LOG_PHONE, LOG_EMAIL, LOG_OPEN, LOG_CLOSE) VALUES ('John','Tan','Mr','6012-678 2345','quanterm@logistics.com', TO_TIMESTAMP('07:30', 'HH24:MI'), TO_TIMESTAMP('18:00', 'HH24:MI'));

--INSERT DATA INTO DRIVER
INSERT INTO DRIVER (DRIVER_LISENCE_NO, DRIVER_FNAME, DRIVER_LNAME, DRIVER_TITLE, DRIVER_BDATE, DRIVER_PHONE, DRIVER_AVAILABILITY, LOG_ID) VALUES ('A12345678','Amir','Johari','Mr', TO_DATE('1990-06-15', 'YYYY-MM-DD'),'6013-567 9187',1,'L001');
INSERT INTO DRIVER (DRIVER_LISENCE_NO, DRIVER_FNAME, DRIVER_LNAME, DRIVER_TITLE, DRIVER_BDATE, DRIVER_PHONE, DRIVER_AVAILABILITY, LOG_ID) VALUES ('B23456789','Ravi','Kumar','Mr', TO_DATE('1985-04-20', 'YYYY-MM-DD'),'6012-567 9025',1,'L002');
INSERT INTO DRIVER (DRIVER_LISENCE_NO, DRIVER_FNAME, DRIVER_LNAME, DRIVER_TITLE, DRIVER_BDATE, DRIVER_PHONE, DRIVER_AVAILABILITY, LOG_ID) VALUES ('C34567890','Ali','Muhammad','Mr', TO_DATE('1988-02-18', 'YYYY-MM-DD'),'6016-789 2345',0,'L003');
INSERT INTO DRIVER (DRIVER_LISENCE_NO, DRIVER_FNAME, DRIVER_LNAME, DRIVER_TITLE, DRIVER_BDATE, DRIVER_PHONE, DRIVER_AVAILABILITY, LOG_ID) VALUES ('D45678901','Mei','Ling','Ms', TO_DATE('1992-11-12', 'YYYY-MM-DD'),'6019-778 6785',1,'L004');
INSERT INTO DRIVER (DRIVER_LISENCE_NO, DRIVER_FNAME, DRIVER_LNAME, DRIVER_TITLE, DRIVER_BDATE, DRIVER_PHONE, DRIVER_AVAILABILITY, LOG_ID) VALUES ('E56789012','Wong','Tze','Mr', TO_DATE('1993-09-25', 'YYYY-MM-DD'),'6012-098 6576',1,'L005');

--INSERT DATA INTO PAYMENT
INSERT INTO PAYMENT (PAY_DATE, PAY_METHOD, INV_ID) VALUES (TO_DATE('2025-01-20', 'YYYY-MM-DD'),'EWALLET','B000000001');
INSERT INTO PAYMENT (PAY_DATE, PAY_METHOD, INV_ID) VALUES (TO_DATE('2025-01-22', 'YYYY-MM-DD'),'CARD','B000000002');
INSERT INTO PAYMENT (PAY_DATE, PAY_METHOD, INV_ID) VALUES (TO_DATE('2025-01-25', 'YYYY-MM-DD'),'CARD','B000000003');
INSERT INTO PAYMENT (PAY_DATE, PAY_METHOD, INV_ID) VALUES (TO_DATE('2025-01-28', 'YYYY-MM-DD'),'CARD','B000000004');
INSERT INTO PAYMENT (PAY_DATE, PAY_METHOD, INV_ID) VALUES (TO_DATE('2025-01-30', 'YYYY-MM-DD'),'CASH','B000000005');

--INSERT DATA INTO INVOICE
INSERT INTO INVOICE (INV_DATE, INV_DESC, INV_REMARK, INV_AMOUNT, INV_PAY_TERM, ORD_ID) VALUES (TO_DATE('2025-01-15', 'YYYY-MM-DD'),'Delivery charge for Order O0000001','Final payment for delivery',150,30,'A0000001');
INSERT INTO INVOICE (INV_DATE, INV_DESC, INV_REMARK, INV_AMOUNT, INV_PAY_TERM, ORD_ID) VALUES (TO_DATE('2025-01-16', 'YYYY-MM-DD'),'Delivery charge for Order O0000002','Partial payment received',120,14,'A0000002');
INSERT INTO INVOICE (INV_DATE, INV_DESC, INV_REMARK, INV_AMOUNT, INV_PAY_TERM, ORD_ID) VALUES (TO_DATE('2025-01-17', 'YYYY-MM-DD'),'Delivery charge for Order O0000003','Full payment due',200,30,'A0000003');
INSERT INTO INVOICE (INV_DATE, INV_DESC, INV_REMARK, INV_AMOUNT, INV_PAY_TERM, ORD_ID) VALUES (TO_DATE('2025-01-18', 'YYYY-MM-DD'),'Delivery charge for Order O0000004','Payment after 30 days',250,30,'A0000004');
INSERT INTO INVOICE (INV_DATE, INV_DESC, INV_REMARK, INV_AMOUNT, INV_PAY_TERM, ORD_ID) VALUES (TO_DATE('2025-01-19', 'YYYY-MM-DD'),'Delivery charge for Order O0000005','Payment after 30 days',180,14,'A0000005');

--INSERT DATA INTO FEEDBACKS
INSERT INTO FEEDBACKS (FDB_RATE, FDB_DESC, FDB_DATE, ORD_ID) VALUES (5,'Excellent service, quick delivery!', TO_DATE('2025-01-21', 'YYYY-MM-DD'),'A0000001');
INSERT INTO FEEDBACKS (FDB_RATE, FDB_DESC, FDB_DATE, ORD_ID) VALUES (4,'On-time delivery but packaging could be better.', TO_DATE('2025-01-23', 'YYYY-MM-DD'),'A0000002');
INSERT INTO FEEDBACKS (FDB_RATE, FDB_DESC, FDB_DATE, ORD_ID) VALUES (3,'Delivery was late, but overall okay.', TO_DATE('2025-01-24', 'YYYY-MM-DD'),'A0000003');
INSERT INTO FEEDBACKS (FDB_RATE, FDB_DESC, FDB_DATE, ORD_ID) VALUES (4,'Good service but driver was late.', TO_DATE('2025-01-26', 'YYYY-MM-DD'),'A0000004');
INSERT INTO FEEDBACKS (FDB_RATE, FDB_DESC, FDB_DATE, ORD_ID) VALUES (5,'Perfect delivery, very professional.', TO_DATE('2025-01-28', 'YYYY-MM-DD'),'A0000005');
