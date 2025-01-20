-- DROP TABLE
DROP TABLE COMPANY CASCADE CONSTRAINTS;
DROP TABLE SHIPPING_DESTINATION CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE ORDER_PRODUCT CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE WAREHOUSE CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE PRODUCT_INVENTORY CASCADE CONSTRAINTS;
DROP TABLE CITY CASCADE CONSTRAINTS;
DROP TABLE RETURNED_HISTORY CASCADE CONSTRAINTS;
DROP TABLE RECYCLE_TRANSACTION CASCADE CONSTRAINTS;
DROP TABLE RECYCLE_ORDER CASCADE CONSTRAINTS;
DROP TABLE RECYCLED_ITEM CASCADE CONSTRAINTS;
DROP TABLE LOGISTIC_PROVIDER CASCADE CONSTRAINTS;
DROP TABLE DRIVER CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE INVOICE CASCADE CONSTRAINTS;
DROP TABLE FEEDBACKS CASCADE CONSTRAINTS;

-- DROP SEQUENCE
DROP SEQUENCE COMPANY_SEQ;
DROP SEQUENCE SHIPPING_DESTINATION_SEQ;
DROP SEQUENCE ORDERS_SEQ;
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE WAREHOUSE_SEQ;
DROP SEQUENCE SECTION_SEQ;
DROP SEQUENCE EMPLOYEE_SEQ;
DROP SEQUENCE RETURNED_HISTORY_SEQ;
DROP SEQUENCE RECYCLE_TRANSACTION_SEQ;
DROP SEQUENCE RECYCLE_ORDER_SEQ;
DROP SEQUENCE RECYCLED_ITEM_SEQ;
DROP SEQUENCE LOGISTIC_PROVIDER_SEQ;
DROP SEQUENCE DRIVER_SEQ;
DROP SEQUENCE PAYMENT_SEQ;
DROP SEQUENCE INVOICE_SEQ;
DROP SEQUENCE FEEDBACKS_SEQ;

------------------------------------------------------------

-- CREATE SEQUENCE
CREATE SEQUENCE COMPANY_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SHIPPING_DESTINATION_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE ORDERS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE PRODUCT_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE WAREHOUSE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SECTION_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE EMPLOYEE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE RETURNED_HISTORY_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE RECYCLE_TRANSACTION_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE RECYCLE_ORDER_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE RECYCLED_ITEM_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE LOGISTIC_PROVIDER_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE DRIVER_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE PAYMENT_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE INVOICE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE FEEDBACKS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE;

-- CREATE TABLE
-- CITY
CREATE TABLE CITY (
    POSTCODE VARCHAR2(5) PRIMARY KEY,
    CITY_NAME VARCHAR2(50) NOT NULL,
    CITY_STATE VARCHAR2(50) NOT NULL,

    CONSTRAINT CITY_POSTCODE_CHK CHECK (
        REGEXP_LIKE(POSTCODE, '^\d{5}$')
    ),
    CONSTRAINT CITY_STATE_CHK CHECK (
        CITY_STATE IN (
            'Johor', 'Kedah', 'Kelantan', 'Melaka', 'Negeri Sembilan',
            'Pahang', 'Penang', 'Perak', 'Perlis', 'Sabah', 'Sarawak', 
            'Selangor', 'Terengganu', 'Wilayah Persekutuan Kuala Lumpur',
            'Wilayah Persekutuan Labuan', 'Wilayah Persekutuan Putrajaya'
        )
    )
);

-- WAREHOUSE
CREATE TABLE WAREHOUSE (
    WHS_ID VARCHAR2(10) DEFAULT (
        'W' || TO_CHAR(WAREHOUSE_SEQ.NEXTVAL, 'FM0000')
    ) NOT NULL,
    WHS_NAME VARCHAR2(50) NOT NULL,
    WHS_ADDR VARCHAR2(100) NOT NULL,
    WHS_PHONE VARCHAR2(15) NOT NULL,
    WHS_OPEN CHAR(5) NOT NULL,
    WHS_CLOSE CHAR(5) NOT NULL,
    WHS_IMG BLOB,
    POSTCODE VARCHAR2(5) NOT NULL,

    CONSTRAINT WAREHOUSE_PK PRIMARY KEY (WHS_ID),
    CONSTRAINT WAREHOUSE_FK1 FOREIGN KEY (POSTCODE) REFERENCES CITY (POSTCODE),
    
    CONSTRAINT WHS_PHONE_CHK CHECK (
        REGEXP_LIKE(WHS_PHONE, '^\+?(\d{1,4})?[-. ]?(\d{3,4})?[-. ]?(\d{4})$')
    ),
    CONSTRAINT WHS_OPEN_CHK CHECK (
        REGEXP_LIKE(WHS_OPEN, '^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$')
    ),
    CONSTRAINT WHS_CLOSE_CHK CHECK (
        REGEXP_LIKE(WHS_CLOSE, '^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$')
    ),
    CONSTRAINT WHS_OPEN_CLOSE_CHK CHECK (
        WHS_OPEN < WHS_CLOSE
    )
);

-- SECTION
CREATE TABLE SECTION (
    SECT_ID VARCHAR2(10) DEFAULT (
        'S' || TO_CHAR(SECTION_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    SECT_NAME VARCHAR2(50) NOT NULL,
    SECT_FLOOR NUMBER(2) NOT NULL,
    SECT_DATE_CHECK DATE DEFAULT SYSDATE NOT NULL,
    WHS_ID VARCHAR2(10) NOT NULL,
    
    CONSTRAINT SECTION_PK PRIMARY KEY (SECT_ID),
    CONSTRAINT SECTION_FK1 FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE (WHS_ID)
);

-- EMPLOYEE
CREATE TABLE EMPLOYEE (
    EMP_ID VARCHAR2(10) DEFAULT (
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
    WHS_ID VARCHAR2(10) NOT NULL,

    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMP_ID),
    CONSTRAINT EMPLOYEE_FK1 FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE (WHS_ID)
);

-- COMPANY
CREATE TABLE COMPANY (
    COM_ID VARCHAR2(10) DEFAULT (
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
    POSTCODE VARCHAR2(5) NOT NULL,

    CONSTRAINT COMPANY_PK PRIMARY KEY (COM_ID),
    CONSTRAINT COMPANY_FK1 FOREIGN KEY (POSTCODE) REFERENCES CITY (POSTCODE)
);

-- SHIPPING_DESTINATION
CREATE TABLE SHIPPING_DESTINATION (
    SHIPD_ID VARCHAR2(10) DEFAULT (
        'Z' || TO_CHAR(SHIPPING_DESTINATION_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    SHIPD_NAME VARCHAR2(30) NOT NULL,
    SHIPD_ADDR VARCHAR2(100) NOT NULL,
    COM_ID VARCHAR2(10) NOT NULL,
    POSTCODE VARCHAR2(5) NOT NULL,

    CONSTRAINT SHIPPING_DESTINATION_PK PRIMARY KEY (SHIPD_ID),
    CONSTRAINT SHIPPING_DESTINATION_FK1 FOREIGN KEY (COM_ID) REFERENCES COMPANY (COM_ID),
    CONSTRAINT SHIPPING_DESTINATION_FK2 FOREIGN KEY (POSTCODE) REFERENCES CITY (POSTCODE)
);

-- LOGISTIC_PROVIDER
CREATE TABLE LOGISTIC_PROVIDER (
    LOG_ID VARCHAR2(10) DEFAULT (
        'L' || TO_CHAR(LOGISTIC_PROVIDER_SEQ.NEXTVAL, 'FM000')
    ) NOT NULL,
    LOG_NAME VARCHAR2(50) NOT NULL,
    LOG_PIC_FNAME VARCHAR2(20) NOT NULL,
    LOG_PIC_LNAME VARCHAR2(20) NOT NULL,
    LOG_PIC_TITLE VARCHAR2(10) NOT NULL,
    LOG_PHONE VARCHAR2(15) NOT NULL,
    LOG_EMAIL VARCHAR2(30) NOT NULL,
    LOG_OPEN CHAR(5) NOT NULL,
    LOG_CLOSE CHAR(5) NOT NULL,
    LOG_STATUS CHAR(1) DEFAULT('Y') NOT NULL,

    CONSTRAINT LOGISTIC_PROVIDER_PK PRIMARY KEY (LOG_ID)
);

-- DRIVER
CREATE TABLE DRIVER (
    DRIVER_ID VARCHAR2(10) DEFAULT (
        'D' || TO_CHAR(DRIVER_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    DRIVER_LISENCE_NO CHAR(15) UNIQUE NOT NULL,
    DRIVER_FNAME VARCHAR2(20) NOT NULL,
    DRIVER_LNAME VARCHAR2(20) NOT NULL,
    DRIVER_TITLE VARCHAR2(10) NOT NULL,
    DRIVER_BDATE DATE NOT NULL,
    DRIVER_PHONE VARCHAR2(15) NOT NULL,
    DRIVER_AVAILABILITY NUMBER(1) NOT NULL,
    LOG_ID VARCHAR2(10) NOT NULL,

    CONSTRAINT DRIVER_PK PRIMARY KEY (DRIVER_ID),
    CONSTRAINT DRIVER_FK1 FOREIGN KEY (LOG_ID) REFERENCES LOGISTIC_PROVIDER (LOG_ID)
);

-- ORDERS
CREATE TABLE ORDERS (
    ORD_ID VARCHAR2(10) DEFAULT (
        'A' || TO_CHAR(ORDERS_SEQ.NEXTVAL, 'FM0000000')
    ) NOT NULL,
    ORD_DEALING_DATE DATE DEFAULT SYSDATE NOT NULL,
    ORD_RECIPENT_FNAME VARCHAR2(20) NOT NULL,
    ORD_RECIPENT_LNAME VARCHAR2(20) NOT NULL,
    ORD_RECIPENT_PHONE VARCHAR2(15) NOT NULL,
    ORD_STATUS CHAR(3) NOT NULL,
    SHIPD_ID VARCHAR2(10) NOT NULL,
    DRIVER_ID VARCHAR2(10),

    CONSTRAINT ORDERS_PK PRIMARY KEY (ORD_ID),
    CONSTRAINT ORDERS_FK1 FOREIGN KEY (SHIPD_ID) REFERENCES SHIPPING_DESTINATION (SHIPD_ID),
    CONSTRAINT ORDERS_FK2 FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER (DRIVER_ID)
);

-- PRODUCT
CREATE TABLE PRODUCT (
    PROD_ID VARCHAR2(10) DEFAULT (
        'P' || TO_CHAR(PRODUCT_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    PROD_NAME VARCHAR2(50) NOT NULL,
    PROD_DESC VARCHAR2(100) NOT NULL,
    PROD_UOM VARCHAR2(20) NOT NULL,
    PROD_UNIT_PRICE NUMBER(10, 2) NOT NULL,
    PROD_IMG BLOB,

    CONSTRAINT PRODUCT_PK PRIMARY KEY (PROD_ID)
);


-- ORDER_PRODUCT
CREATE TABLE ORDER_PRODUCT (
    ORD_ID VARCHAR2(10) NOT NULL,
    PROD_ID VARCHAR2(10) NOT NULL,
    QTY NUMBER(3) NOT NULL,

    CONSTRAINT ORDER_PRODUCT_PK PRIMARY KEY (ORD_ID, PROD_ID),
    CONSTRAINT ORDER_PRODUCT_FK1 FOREIGN KEY (ORD_ID) REFERENCES ORDERS (ORD_ID),
    CONSTRAINT ORDER_PRODUCT_FK2 FOREIGN KEY (PROD_ID) REFERENCES PRODUCT (PROD_ID)
);

-- PRODUCT_INVENTORY
CREATE TABLE PRODUCT_INVENTORY (
    PROD_ID VARCHAR2(10) NOT NULL,
    SECT_ID VARCHAR2(10) NOT NULL,
    QTY NUMBER(3) NOT NULL,

    CONSTRAINT PRODUCT_INVENTORY_PK PRIMARY KEY (PROD_ID, SECT_ID),
    CONSTRAINT PRODUCT_INVENTORY_FK1 FOREIGN KEY (PROD_ID) REFERENCES PRODUCT (PROD_ID),
    CONSTRAINT PRODUCT_INVENTORY_FK2 FOREIGN KEY (SECT_ID) REFERENCES SECTION (SECT_ID)
);

-- INVOICE
CREATE TABLE INVOICE (
    INV_ID VARCHAR2(11) DEFAULT (
        'B' || TO_CHAR(INVOICE_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    INV_DATE DATE DEFAULT SYSDATE NOT NULL,
    INV_DESC VARCHAR2(300) NOT NULL,
    INV_REMARK VARCHAR2(300),
    INV_AMOUNT NUMBER(10, 2) NOT NULL,
    INV_PAY_TERM NUMBER(3) NOT NULL,
    ORD_ID VARCHAR2(10) NOT NULL,

    CONSTRAINT INVOICE_PK PRIMARY KEY (INV_ID),
    CONSTRAINT INVOICE_FK1 FOREIGN KEY (ORD_ID) REFERENCES ORDERS (ORD_ID)
);

-- FEEDBACKS
CREATE TABLE FEEDBACKS (
    FDB_ID VARCHAR2(10) DEFAULT (
        'F' || TO_CHAR(FEEDBACKS_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    FDB_RATE NUMBER(1) NOT NULL,
    FDB_DESC VARCHAR2(300),
    FDB_DATE DATE DEFAULT SYSDATE NOT NULL,
    ORD_ID VARCHAR2(10) NOT NULL,

    CONSTRAINT FEEDBACKS_PK PRIMARY KEY (FDB_ID),
    CONSTRAINT FEEDBACKS_FK1 FOREIGN KEY (ORD_ID) REFERENCES ORDERS (ORD_ID)
);

-- PAYMENT
CREATE TABLE PAYMENT (
    PAY_ID VARCHAR2(11) DEFAULT (
        'P' || TO_CHAR(PAYMENT_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    PAY_DATE DATE DEFAULT SYSDATE NOT NULL,
    PAY_METHOD VARCHAR2(7) NOT NULL,
    INV_ID VARCHAR2(11) NOT NULL,

    CONSTRAINT PAYMENT_PK PRIMARY KEY (PAY_ID),
    CONSTRAINT PAYMENT_FK1 FOREIGN KEY (INV_ID) REFERENCES INVOICE (INV_ID)
);

-- RECYCLE_ORDER
CREATE TABLE RECYCLE_ORDER (
    RORD_ID VARCHAR2(10) DEFAULT (
        'RO' || TO_CHAR(RECYCLE_ORDER_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RORD_DEALING_DATE DATE DEFAULT SYSDATE NOT NULL,
    RORD_DELIVERY_DATE DATE NOT NULL,
    RORD_STATE CHAR(3) NOT NULL,
    COM_ID VARCHAR2(10) NOT NULL,

    CONSTRAINT RECYCLE_ORDER_PK PRIMARY KEY (RORD_ID),
    CONSTRAINT RECYCLE_ORDER_FK1 FOREIGN KEY (COM_ID) REFERENCES COMPANY (COM_ID)
);

-- RECYCLE_TRANSACTION
CREATE TABLE RECYCLE_TRANSACTION (
    RTRANS_ID VARCHAR2(10) DEFAULT (
        'RT' || TO_CHAR(RECYCLE_TRANSACTION_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RTRANS_AMOUNT NUMBER(10, 2) NOT NULL,
    RTRANS_PAY_METHOD VARCHAR(7) NOT NULL,
    RTRANS_DATE DATE DEFAULT SYSDATE NOT NULL,
    RORD_ID VARCHAR2(10) NOT NULL,
    
    CONSTRAINT RECYCLE_TRANSACTION_PK PRIMARY KEY (RTRANS_ID),
    CONSTRAINT RECYCLE_TRANSACTION_FK1 FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER (RORD_ID)
);

-- RECYCLED_ITEM
CREATE TABLE RECYCLED_ITEM (
    RITEM_ID VARCHAR2(10) DEFAULT (
        'RI' || TO_CHAR(RECYCLED_ITEM_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RITEM_CONDITION NUMBER(1) NOT NULL,
    RITEM_QC_DATE DATE DEFAULT SYSDATE NOT NULL,
    RITEM_QTY NUMBER(10, 2) NOT NULL,
    RORD_ID VARCHAR2(10) NOT NULL,
    PROD_ID VARCHAR2(10) NOT NULL,
    
    CONSTRAINT RECYCLED_ITEM_PK PRIMARY KEY (RITEM_ID),
    CONSTRAINT RECYCLED_ITEM_FK1 FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER (RORD_ID),
    CONSTRAINT RECYCLED_ITEM_FK2 FOREIGN KEY (PROD_ID) REFERENCES PRODUCT (PROD_ID)
);

-- RETURNED_HISTORY
CREATE TABLE RETURNED_HISTORY (
    RHIS_ID VARCHAR2(10) DEFAULT (
        'RH' || TO_CHAR(RETURNED_HISTORY_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RET_STAT VARCHAR2(300),
    EMP_ID VARCHAR2(10) NOT NULL,
    RITEM_ID VARCHAR2(10) NOT NULL,
    
    CONSTRAINT RETURNED_HISTORY_PK PRIMARY KEY (RHIS_ID),
    CONSTRAINT RETURNED_HISTORY_FK1 FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID),
    CONSTRAINT RETURNED_HISTORY_FK2 FOREIGN KEY (RITEM_ID) REFERENCES RECYCLED_ITEM (RITEM_ID)
);

------------------------------------------------------------

--CREATE TRIGGER

CREATE OR REPLACE TRIGGER TRG_EMPLOYEE_BDATE
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF :NEW.EMP_BDATE > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'EMP_BDATE cannot be in the future');
    END IF;
END;
/

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