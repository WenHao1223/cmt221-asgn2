-- CREATE DROP TABLES AND SEQUENCES PROCEDURE

CREATE OR REPLACE PROCEDURE PRC_DROP_TABLES_AND_SEQ AS
BEGIN
    -- DROP EXISTING TABLES
    FOR table_name IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'COMPANY', 'SHIPPING_DESTINATION', 'ORDERS', 'ORDER_PRODUCT', 'PRODUCT',
            'WAREHOUSE', 'SECTION', 'EMPLOYEE', 'CITY', 'PRODUCT_INVENTORY',
            'RETURNED_HISTORY', 'RECYCLE_TRANSACTION', 'RECYCLE_ORDER', 'RECYCLED_ITEM',
            'LOGISTIC_PROVIDER', 'DRIVER', 'PAYMENT', 'INVOICE', 'FEEDBACKS'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || table_name.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;

    -- DROP EXISTING SEQUENCES
    FOR seq_name IN (
        SELECT sequence_name FROM user_sequences
        WHERE sequence_name IN (
            'COMPANY_SEQ', 'SHIPPING_DESTINATION_SEQ', 'ORDERS_SEQ', 'PRODUCT_SEQ',
            'WAREHOUSE_SEQ', 'SECTION_SEQ', 'EMPLOYEE_SEQ',
            'RETURNED_HISTORY_SEQ', 'RECYCLE_TRANSACTION_SEQ', 'RECYCLE_ORDER_SEQ', 'RECYCLED_ITEM_SEQ',
            'LOGISTIC_PROVIDER_SEQ', 'DRIVER_SEQ', 'PAYMENT_SEQ', 'INVOICE_SEQ', 'FEEDBACKS_SEQ'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq_name.sequence_name;
    END LOOP;
END;
/

-- EXECUTE DROP TABLES AND SEQUENCES PROCEDURE
BEGIN
    PRC_DROP_TABLES_AND_SEQ;
END;
/

------------------------------------------------------------

-- CREATE SEQUENCES

-- Module 1: Supply Chain Coordination
-- COMPANY_SEQ (4), SHIPPING_DESTINATION_SEQ (6), ORDERS_SEQ (7), PRODUCT_SEQ (6)
CREATE SEQUENCE COMPANY_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999 NOCACHE NOCYCLE;
CREATE SEQUENCE SHIPPING_DESTINATION_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCACHE NOCYCLE;
CREATE SEQUENCE ORDERS_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999999 NOCACHE NOCYCLE;
CREATE SEQUENCE PRODUCT_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCACHE NOCYCLE;

-- Module 2: Inventory and Storage Management
-- WAREHOUSE_SEQ (4), SECTION_SEQ (5), EMPLOYEE_SEQ (6)
CREATE SEQUENCE WAREHOUSE_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999 NOCACHE NOCYCLE;
CREATE SEQUENCE SECTION_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE EMPLOYEE_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999 NOCACHE NOCYCLE;

-- Module 3: Sustainable Material Collection
-- RETURNED_HISTORY_SEQ (5), RECYCLE_TRANSACTION_SEQ (5), RECYCLE_ORDER_SEQ (5), RECYCLED_ITEM_SEQ (7)
CREATE SEQUENCE RETURNED_HISTORY_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE RECYCLE_TRANSACTION_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE RECYCLE_ORDER_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE RECYCLED_ITEM_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999999 NOCACHE NOCYCLE;

-- Module 4: Aftersales
-- LOGISTIC_PROVIDER_SEQ (3), DRIVER_SEQ (5), PAYMENT_SEQ (9), INVOICE_SEQ (9), FEEDBACKS_SEQ (9)
CREATE SEQUENCE LOGISTIC_PROVIDER_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999 NOCACHE NOCYCLE;
CREATE SEQUENCE DRIVER_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 99999 NOCACHE NOCYCLE;
CREATE SEQUENCE PAYMENT_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE INVOICE_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE FEEDBACKS_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 999999999 NOCACHE NOCYCLE;

------------------------------------------------------------

-- CREATE TABLES

-- Module 1: Supply Chain Coordination
-- COMPANY
-- COMPANY_SEQ (4)
CREATE TABLE COMPANY (
    COM_ID CHAR(6) DEFAULT (
        'C' || TO_CHAR(COMPANY_SEQ.NEXTVAL, 'FM0000')
    ) NOT NULL,
    COM_NAME VARCHAR2(20) NOT NULL,
    COM_CATEGORY VARCHAR2(20) NOT NULL,
    COM_ADDR VARCHAR2(100) NOT NULL,
    COM_PIC_FNAME VARCHAR2(20) NOT NULL,
    COM_PIC_LNAME VARCHAR2(20) NOT NULL,
    COM_PIC_TITLE VARCHAR2(20) NOT NULL,
    COM_PHONE VARCHAR2(15) NOT NULL,
    COM_EMAIL VARCHAR2(30) NOT NULL,
    COM_IMG BLOB,
    POSTCODE NUMBER(5) NOT NULL,
    -- FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE)

    CONSTRAINT COMPANY_PK PRIMARY KEY (COM_ID),
    CONSTRAINT COM_PIC_NAME_CHK CHECK (
        REGEXP_LIKE(COM_PIC_FNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
        AND REGEXP_LIKE(COM_PIC_LNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
    ),
    CONSTRAINT COM_PIC_TITLE_CHK CHECK (
        COM_PIC_TITLE IN ('Mr', 'Ms', 'Mrs', 'Dr', 'Prof')
    ),
    CONSTRAINT COM_PHONE_CHK CHECK (
        REGEXP_LIKE(COM_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT COM_EMAIL_CHK CHECK (
        REGEXP_LIKE(COM_EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
    )
);

--INSERT DATA INTO COMPANY
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('EcoBuild Solutions','Sustainable Build','123 Green Street, Kuala Lumpur','Farhan','Ahmad','Mr','6012-345 6789','info@ecobuild.com',50000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('GreenTech Materials','Building Materials','456 Nature Ave, GeorgeTown','Amina','Rahman','Ms','6012-345 6790','contact@greentech.com',10100);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('SolidCore Industries','Concrete Products','789  Taman Riang, Johor Bahru','John','Lim','Dr','6012-345 6791','sales@solidcore.com',80000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('Recycled Structures','Recycled Materials','321 Blvd Road, Shah Alam','Maria','Tan','Ms','6012-345 6792','recycle@structures.com',75000);
INSERT INTO COMPANY (COM_NAME, COM_CATEGORY, COM_ADDR, COM_PIC_FNAME, COM_PIC_LNAME, COM_PIC_TITLE, COM_PHONE, COM_EMAIL, POSTCODE) VALUES ('Bamboo Creations','Eco-friendly Build','654 Industrial Park, Bayan Lepas','Ismail','Zulkifli','Mr','6012-345 6793','bamboo@creations.com',88000);


-- SHIPPING_DESTINATION
-- SHIPPING_DESTINATION_SEQ (6)
CREATE TABLE SHIPPING_DESTINATION (
    SHIPD_ID CHAR(8) DEFAULT (
        'Z' || TO_CHAR(SHIPPING_DESTINATION_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    SHIPD_NAME VARCHAR2(30) NOT NULL,
    SHIPD_ADDR VARCHAR2(100) NOT NULL,
    COM_ID CHAR(6) NOT NULL,
    POSTCODE NUMBER(5) NOT NULL,
    -- FOREIGN KEY (COM_ID) REFERENCES COMPANY(COM_ID),
    -- FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE)

    CONSTRAINT SHIPPING_DESTINATION_PK PRIMARY KEY (SHIPD_ID)
);

--INSER DATA INTO SHIPPING_DESTINATION
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Sunway Construction Site','123 Jalan Tropicana, Petaling Jaya, Selangor','C0001',50000);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Ecohill Development Site','45 Jalan Semenyih, Semenyih, Selangor','C0002',10300);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('The Light City Project','789 Persiaran Bayan Indah, Bayan Lepas, Penang','C0003',80000);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('Permas Heights Development','12 Jalan Permas Jaya, Johor Bahru, Johor','C0004',40100);
INSERT INTO SHIPPING_DESTINATION (SHIPD_NAME, SHIPD_ADDR, COM_ID, POSTCODE) VALUES ('East Coast Highway Extension','345 Jalan Kuantan-Kemaman, Kuantan, Pahan','C0005',11900);

-- ORDERS
-- ORDERS_SEQ (7)
CREATE TABLE ORDERS (
    ORD_ID CHAR(9) DEFAULT (
        'A' || TO_CHAR(ORDERS_SEQ.NEXTVAL, 'FM0000000')
    ) NOT NULL,
    ORD_DEALING_DATE DATE DEFAULT SYSDATE NOT NULL,
    ORD_RECIPENT_FNAME VARCHAR2(20) NOT NULL,
    ORD_RECIPENT_LNAME VARCHAR2(20) NOT NULL,
    ORD_RECIPENT_PHONE VARCHAR2(15) NOT NULL,
    ORD_STATUS CHAR(3) NOT NULL,
    SHIPD_ID CHAR(8) NOT NULL,
    DRIVER_ID CHAR(6) NOT NULL,
    -- FOREIGN KEY (SHIPD_ID) REFERENCES SHIPPING_DESTINATION(SHIPD_ID),
    -- FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER(DRIVER_ID),

    CONSTRAINT ORDERS_PK PRIMARY KEY (ORD_ID),
    CONSTRAINT ORD_RECIPENT_NAME_CHK CHECK (
        REGEXP_LIKE(ORD_RECIPENT_FNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
        AND REGEXP_LIKE(ORD_RECIPENT_LNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
    ),
    CONSTRAINT ORD_RECIPENT_PHONE_CHK CHECK (
        REGEXP_LIKE(ORD_RECIPENT_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT ORD_STATUS_CHK CHECK (
        ORD_STATUS IN ('PND', 'PRC', 'DLV', 'RTR', 'CPL') -- Pending, Processing, Delivering, Return, Complete
    )
);

--INSERT DATA INTO ORDERS
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-01', 'YYYY-MM-DD'),'Farhan','Ahmad','6012-345 6789','DLV','Z000001','D00001');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-02', 'YYYY-MM-DD'),'Amina','Rahman','6012-345 6790','CPL','Z000002','D00002');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-03', 'YYYY-MM-DD'),'John','Lim','6012-345 6791','CPL','Z000003','D00003');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-04', 'YYYY-MM-DD'),'Jane','Doe','6012-345 6792','PND','Z000004','D00004');
INSERT INTO ORDERS (ORD_DEALING_DATE, ORD_RECIPENT_FNAME, ORD_RECIPENT_LNAME, ORD_RECIPENT_PHONE, ORD_STATUS, SHIPD_ID, DRIVER_ID) VALUES (TO_DATE('2025-09-05', 'YYYY-MM-DD'),'Ismail','Zulkifli','6012-345 6793','RTR','Z000005','D00005');

-- -- ORDER_PRODUCT
-- -- ORDERS_SEQ (7), PRODUCT_SEQ (6)
-- CREATE TABLE ORDER_PRODUCT (
--     ORD_ID CHAR(8) NOT NULL,
--     PROD_ID CHAR(6) NOT NULL,
--     QTY INTEGER NOT NULL,

--     CONSTRAINT ORDER_PRODUCT_PK PRIMARY KEY (ORD_ID, PROD_ID),
--     CONSTRAINT ORDER_PRODUCT_QTY_CHK CHECK (
--         QTY >= 0
--     )
--     -- FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID),
--     -- FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID)
-- );

-- --INSERT DATA INTO ORDER_PRODUCT
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000001','P00001',20);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000001','P00003',50);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000002','P00002',100);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000002','P00004',200);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000003','P00005',75);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000003','P00006',150);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000004','P00007',30);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000004','P00008',80);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000005','P00009',200);
-- INSRET INTO ORDER_PRODUCT (ORD_ID, PROD_ID, QTY) VALUES ('A0000005','P00010',100);


-- PRODUCT
-- PRODUCT_SEQ (6)
CREATE TABLE PRODUCT (
    PROD_ID CHAR(8) DEFAULT (
        'P' || TO_CHAR(PRODUCT_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    PROD_NAME VARCHAR2(50) NOT NULL,
    PROD_DESC VARCHAR2(300),
    PROD_UOM VARCHAR2(20) NOT NULL,
    PROD_UNIT_PRICE NUMBER(10, 2) NOT NULL,
    PROD_IMG BLOB,

    CONSTRAINT PRODUCT_PK PRIMARY KEY (PROD_ID),
    CONSTRAINT PROD_UNIT_PRICE_CHK CHECK (
        PROD_UNIT_PRICE >= 0
    )
);

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
-- WAREHOUSE
-- WAREHOUSE_SEQ (4)
CREATE TABLE WAREHOUSE (
    WHS_ID CHAR(6) DEFAULT (
        'W' || TO_CHAR(WAREHOUSE_SEQ.NEXTVAL, 'FM0000')
    ) NOT NULL,
    WHS_NAME VARCHAR2(50) NOT NULL,
    WHS_ADDR VARCHAR2(100) NOT NULL,
    WHS_PHONE VARCHAR2(15) NOT NULL,
    WHS_OPEN TIMESTAMP NOT NULL,
    WHS_CLOSE TIMESTAMP NOT NULL,
    WHS_IMG BLOB,
    POSTCODE NUMBER(5) NOT NULL,
    -- FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE)

    CONSTRAINT WAREHOUSE_PK PRIMARY KEY (WHS_ID),
    CONSTRAINT WHS_PHONE_CHK CHECK (
        REGEXP_LIKE(WHS_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT WHS_OPEN_CLOSE_CHK CHECK (
        WHS_OPEN < WHS_CLOSE
    )
);

-- SECTION
-- SECTION_SEQ (5)
CREATE TABLE SECTION (
    SECT_ID CHAR(7) DEFAULT (
        'S' || TO_CHAR(SECTION_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    SECT_NAME VARCHAR2(50) NOT NULL,
    SECT_FLOOR NUMBER(2) NOT NULL,
    SECT_DATE_CHECK DATE DEFAULT SYSDATE NOT NULL,
    WHS_ID CHAR(5) NOT NULL,
    -- FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE(WHS_ID)

    CONSTRAINT SECTION_PK PRIMARY KEY (SECT_ID),
    CONSTRAINT SECT_FLOOR_CHK CHECK (
        SECT_FLOOR > 0
    )
);

-- EMPLOYEE
-- EMPLOYEE_SEQ (6)
CREATE TABLE EMPLOYEE (
    EMP_ID CHAR(8) DEFAULT (
        'E' || TO_CHAR(EMPLOYEE_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    EMP_PW VARCHAR2(12) NOT NULL,
    EMP_TIN VARCHAR(13) UNIQUE NOT NULL,
    EMP_IC CHAR(14) UNIQUE NOT NULL,
    EMP_FNAME VARCHAR2(20) NOT NULL,
    EMP_LNAME VARCHAR2(20) NOT NULL,
    EMP_ROLE VARCHAR2(20) NOT NULL,
    EMP_TITLE VARCHAR2(10) NOT NULL,
    EMP_BDATE DATE NOT NULL,
    EMP_PHONE VARCHAR2(13) NOT NULL,
    EMP_EMAIL VARCHAR2(30) NOT NULL,
    WHS_ID CHAR(5) NOT NULL,
    -- FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE(WHS_ID)

    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMP_ID),
    CONSTRAINT EMP_PW_CHK CHECK (
        LENGTH(EMP_PW) >= 8
        AND LENGTH(EMP_PW) <= 12
        AND REGEXP_LIKE(EMP_PW, '^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$') -- At least 1 lowercase, 1 uppercase, 1 special character
    ),
    CONSTRAINT EMP_TIN_CHK CHECK (
        REGEXP_LIKE(EMP_TIN, 'IG\d{9,11}$')
    ),
    CONSTRAINT EMP_IC_CHK CHECK (
        REGEXP_LIKE(EMP_IC, '^\d{12}$')
    ),
    CONSTRAINT EMP_ROLE_CHK CHECK (
        EMP_ROLE IN ('Manager', 'Supervisor', 'Staff')
    ),
    CONSTRAINT EMP_TITLE_CHK CHECK (
        EMP_TITLE IN ('Mr', 'Ms', 'Mrs', 'Dr', 'Prof')
    ),
    CONSTRAINT EMP_BDATE_CHK CHECK (
        EMP_BDATE < SYSDATE
    ),
    CONSTRAINT EMP_PHONE_CHK CHECK (
        REGEXP_LIKE(EMP_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT EMP_EMAIL_CHK CHECK (
        REGEXP_LIKE(EMP_EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
    )
);

CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_BDATE
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF :NEW.EMP_BDATE > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'EMP_BDATE cannot be in the future');
    END IF;
END;

-- CITY
-- CITY_SEQ (5)
CREATE TABLE CITY (
    POSTCODE CHAR(5) PRIMARY KEY,
    CITY_NAME VARCHAR2(20) NOT NULL,
    CITY_STATE VARCHAR2(20) NOT NULL

    CONSTRAINT CITY_POSTCODE_CHK CHECK (
        REGEXP_LIKE(POSTCODE, '^\d{5}$')
    )
    CONSTRAINT CITY_STATE_CHK CHECK (
        CITY_STATE IN (
            'Johor', 'Kedah', 'Kelantan', 'Kuala Lumpur', 'Labuan', 'Melaka', 'Negeri Sembilan',
            'Pahang', 'Penang', 'Perak', 'Perlis', 'Putrajaya', 'Sabah', 'Sarawak', 'Selangor',
            'Terengganu'
        )
    )
);

-- PRODUCT_INVENTORY
-- PRODUCT_SEQ (6), SECTION_SEQ (5)
CREATE TABLE PRODUCT_INVENTORY (
    PROD_ID CHAR(8) NOT NULL,
    SECT_ID CHAR(7) NOT NULL,
    QTY INTEGER NOT NULL,

    CONSTRAINT PRODUCT_INVENTORY_PK PRIMARY KEY (PROD_ID, SECT_ID),
    CONSTRAINT PRODUCT_INVENTORY_QTY_CHK CHECK (
        QTY >= 0
    )
    -- FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID),
    -- FOREIGN KEY (SECT_ID) REFERENCES SECTION(SECT_ID)
);

-- Module 3: Sustainable Material Collection
-- RETURNED_HISTORY
-- RETURNED_HISTORY_SEQ (5)
CREATE TABLE RETURNED_HISTORY (
    RET_ID CHAR(8) DEFAULT (
        'RH' || TO_CHAR(RETURNED_HISTORY_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RET_DATE DATE DEFAULT SYSDATE NOT NULL,
    RET_REASON VARCHAR2(300),
    ORD_ID CHAR(9) NOT NULL,
    -- FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID)

    CONSTRAINT RETURNED_HISTORY_PK PRIMARY KEY (RET_ID)
);

-- RECYCLE_TRANSACTION
-- RECYCLE_TRANSACTION_SEQ (5)
CREATE TABLE RECYCLE_TRANSACTION (
    RTRANS_ID CHAR(8) DEFAULT (
        'RT' || TO_CHAR(RECYCLE_TRANSACTION_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RTRANS_AMOUNT NUMBER(10, 2) NOT NULL,
    RTRANS_PAY_METHOD VARCHAR(7) NOT NULL,
    RTRANS_DATE DATE DEFAULT SYSDATE NOT NULL,
    RORD_ID CHAR(8) NOT NULL,
    -- FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER(RORD_ID)
    
    CONSTRAINT RECYCLE_TRANSACTION_PK PRIMARY KEY (RTRANS_ID),
    CONSTRAINT RTRANS_AMOUNT_CHK CHECK (
        RTRANS_AMOUNT >= 0
    ),
    CONSTRAINT RTRANS_PAY_METHOD_CHK CHECK (
        RTRANS_PAY_METHOD IN ('CASH', 'CARD', 'EWALLET')
    )
);

CREATE OR REPLACE TRIGGER TRG_RECYCLE_TRANSACTION_DATE
BEFORE INSERT OR UPDATE ON RECYCLE_TRANSACTION
FOR EACH ROW
BEGIN
    IF :NEW.RTRANS_DATE < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'RTRANS_DATE cannot be in the past');
    END IF;
END;
/

-- RECYCLE_ORDER
-- RECYCLE_ORDER_SEQ (5)
CREATE TABLE RECYCLE_ORDER (
    RORD_ID CHAR(8) DEFAULT (
        'RO' || TO_CHAR(RECYCLE_ORDER_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RORD_DEALING_DATE DATE DEFAULT SYSDATE NOT NULL,
    RORD_DELIVERY_DATE DATE NOT NULL,
    RORD_STATE CHAR(3) NOT NULL,
    COM_ID CHAR(6) NOT NULL,
    -- FOREIGN KEY (COM_ID) REFERENCES COMPANY(COM_ID)

    CONSTRAINT RECYCLE_ORDER_PK PRIMARY KEY (RORD_ID),
    CONSTRAINT RORD_STATE_CHK CHECK (
        RORD_STATE IN ('PND', 'PRC', 'DLV', 'RTR', 'CPL') -- Pending, Processing, Delivering, Return, Complete
    ),
    CONSTRAINT RORD_DELIVERY_DATE_CHK CHECK (
        RORD_DELIVERY_DATE > RORD_DEALING_DATE
    )
);

-- RECYCLED_ITEM
-- RECYCLED_ITEM_SEQ (7)
CREATE TABLE RECYCLED_ITEM (
    RITEM_ID CHAR(8) DEFAULT (
        'RI' || TO_CHAR(RECYCLED_ITEM_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RITEM_CONDITION NUMBER(1) NOT NULL,
    RITEM_QC_DATE DATE DEFAULT SYSDATE NOT NULL,
    RITEM_QTY NUMBER(10, 2) NOT NULL,
    RORD_ID CHAR(8) NOT NULL,
    PROD_ID CHAR(8) NOT NULL,
    -- FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER(RORD_ID),
    -- FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID)

    CONSTRAINT RECYCLED_ITEM_PK PRIMARY KEY (RITEM_ID),
    CONSTRAINT RITEM_CONDITION_CHK CHECK (
        RITEM_CONDITION IN (0, 1) -- 0: Bad, 1: Good
    ),
    CONSTRAINT RITEM_QTY_CHK CHECK (
        RITEM_QTY >= 0
    )
);

-- Module 4: Aftersales
-- LOGISTIC_PROVIDER
-- LOGISTIC_PROVIDER_SEQ (3)
CREATE TABLE LOGISTIC_PROVIDER (
    LOG_ID CHAR(5) DEFAULT (
        'L' || TO_CHAR(LOGISTIC_PROVIDER_SEQ.NEXTVAL, 'FM000')
    ) NOT NULL,
    LOG_PIC_FNAME VARCHAR2(20) NOT NULL,
    LOG_PIC_LNAME VARCHAR2(20) NOT NULL,
    LOG_PIC_TITLE VARCHAR2(10) NOT NULL,
    LOG_PHONE VARCHAR2(15) NOT NULL,
    LOG_EMAIL VARCHAR2(30) NOT NULL,
    LOG_OPEN TIMESTAMP NOT NULL,
    LOG_CLOSE TIMESTAMP NOT NULL,

    CONSTRAINT LOGISTIC_PROVIDER_PK PRIMARY KEY (LOG_ID),
    CONSTRAINT LOG_PIC_NAME_CHK CHECK (
        REGEXP_LIKE(LOG_PIC_FNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
        AND REGEXP_LIKE(LOG_PIC_LNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
    ),
    CONSTRAINT LOG_PIC_TITLE_CHK CHECK (
        LOG_PIC_TITLE IN ('Mr', 'Ms', 'Mrs', 'Dr', 'Prof')
    ),
    CONSTRAINT LOG_PHONE_CHK CHECK (
        REGEXP_LIKE(LOG_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT LOG_EMAIL_CHK CHECK (
        REGEXP_LIKE(LOG_EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
    ),
    CONSTRAINT LOG_OPEN_CLOSE_CHK CHECK (
        LOG_OPEN < LOG_CLOSE
    )
);

-- DRIVER
-- DRIVER_SEQ (5)
CREATE TABLE DRIVER (
    DRIVER_ID CHAR(7) DEFAULT (
        'D' || TO_CHAR(DRIVER_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    DRIVER_FNAME VARCHAR2(20) NOT NULL,
    DRIVER_LNAME VARCHAR2(20) NOT NULL,
    DRIVER_TITLE VARCHAR2(10) NOT NULL,
    DRIVER_BDATE DATE NOT NULL,
    DRIVER_PHONE VARCHAR2(15) NOT NULL,
    DRIVER_AVAILABILITY NUMBER(1) NOT NULL,
    LOG_ID CHAR(5) NOT NULL,
    -- FOREIGN KEY (LOG_ID) REFERENCES LOGISTIC_PROVIDER(LOG_ID)

    CONSTRAINT DRIVER_PK PRIMARY KEY (DRIVER_ID),
    CONSTRAINT DRIVER_NAME_CHK CHECK (
        REGEXP_LIKE(DRIVER_FNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
        AND REGEXP_LIKE(DRIVER_LNAME, '^[a-zA-Z]+((['',. \/\-][a-zA-Z ])?[a-zA-Z]*)*$')
    ),
    CONSTRAINT DRIVER_TITLE_CHK CHECK (
        DRIVER_TITLE IN ('Mr', 'Ms', 'Mrs', 'Dr', 'Prof')
    ),
    CONSTRAINT DRIVER_PHONE_CHK CHECK (
        REGEXP_LIKE(DRIVER_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT DRIVER_AVAILABILITY_CHK CHECK (
        DRIVER_AVAILABILITY IN (0, 1) -- 0: Not Available, 1: Available
    )
);

CREATE OR REPLACE TRIGGER TRG_DRIVER_BDATE
BEFORE INSERT OR UPDATE ON DRIVER
FOR EACH ROW
BEGIN
    IF :NEW.DRIVER_BDATE > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'DRIVER_BDATE cannot be in the future');
    END IF;
    IF MONTHS_BETWEEN(SYSDATE, :NEW.DRIVER_BDATE) < 252 THEN
        RAISE_APPLICATION_ERROR(-20001, 'DRIVER_BDATE must be at least 21 years old');
    END IF;
END;
/

-- PAYMENT
-- PAYMENT_SEQ (9)
CREATE TABLE PAYMENT (
    PAY_ID CHAR(11) DEFAULT (
        'P' || TO_CHAR(PAYMENT_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    PAY_DATE DATE DEFAULT SYSDATE NOT NULL,
    PAY_METHOD VARCHAR2(7) NOT NULL,
    INV_ID CHAR(8) NOT NULL,
    -- FOREIGN KEY (INV_ID) REFERENCES INVOICE(INV_ID)

    CONSTRAINT PAYMENT_PK PRIMARY KEY (PAY_ID),
    CONSTRAINT PAY_METHOD_CHK CHECK (
        PAY_METHOD IN ('CASH', 'CARD', 'EWALLET')
    )
);

-- INVOICE
-- INVOICE_SEQ (9)
CREATE TABLE INVOICE (
    INV_ID CHAR(11) DEFAULT (
        'B' || TO_CHAR(INVOICE_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    INV_DATE DATE DEFAULT SYSDATE NOT NULL,
    INV_DESC VARCHAR2(300) NOT NULL,
    INV_REMARK VARCHAR2(300),
    INV_AMOUNT NUMBER(10, 2) NOT NULL,
    INV_PAY_TERM NUMBER(3) NOT NULL,
    ORD_ID CHAR(9) NOT NULL,
    -- FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID)

    CONSTRAINT INVOICE_PK PRIMARY KEY (INV_ID),
    CONSTRAINT INV_AMOUNT_CHK CHECK (
        INV_AMOUNT >= 0
    ),
    CONSTRAINT INV_PAY_TERM_CHK CHECK (
        INV_PAY_TERM IN (7, 14, 30, 90, 180)
    )
);

-- FEEDBACKS
-- FEEDBACKS_SEQ (9)
CREATE TABLE FEEDBACKS (
    FDB_ID CHAR(11) DEFAULT (
        'F' || TO_CHAR(FEEDBACKS_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    FDB_RATE NUMBER(1) NOT NULL,
    FDB_DESC VARCHAR2(300),
    FDB_DATE DATE DEFAULT SYSDATE NOT NULL,
    ORD_ID CHAR(9) NOT NULL,
    -- FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID)

    CONSTRAINT FEEDBACKS_PK PRIMARY KEY (FDB_ID),
    CONSTRAINT FDB_RATE_CHK CHECK (
        FDB_RATE >= 1
        AND FDB_RATE <= 5
    )
);

------------------------------------------------------------

-- INSERT DATA

-- Module 1: Supply Chain Coordination


-- Module 2: Inventory and Storage Management


-- Module 3: Aftersales


-- Module 4: Sustainable Material Collection
