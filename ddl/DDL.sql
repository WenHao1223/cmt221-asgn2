-- CREATE DROP TABLES AND SEQUENCES PROCEDURE

CREATE OR REPLACE PROCEDURE PRC_DROP_TABLES_AND_SEQ AS
BEGIN
    -- DROP EXISTING TABLES
    FOR table_name IN (
        SELECT table_name FROM user_tables
        WHERE table_name IN (
            'COMPANY', 'SHIPPING_DESTINATION', 'ORDERS', 'ORDER_PRODUCT', 'PRODUCT',
            'WAREHOUSE', 'SECTION', 'EMPLOYEE', 'PRODUCT_INVENTORY', 'CITY',
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
CREATE TABLE CITY (
    POSTCODE CHAR(5) PRIMARY KEY,
    CITY_NAME VARCHAR2(35) NOT NULL,
    CITY_STATE VARCHAR2(35) NOT NULL,

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
    POSTCODE CHAR(5) NOT NULL,
    FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE) ON DELETE CASCADE,

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
    WHS_ID CHAR(6) NOT NULL,
    FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE(WHS_ID) ON DELETE CASCADE,

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
    WHS_ID CHAR(6) NOT NULL,
    FOREIGN KEY (WHS_ID) REFERENCES WAREHOUSE(WHS_ID) ON DELETE CASCADE,

    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMP_ID),
    CONSTRAINT EMP_PW_CHK CHECK (
        LENGTH(EMP_PW) >= 8
        AND LENGTH(EMP_PW) <= 12
        AND REGEXP_LIKE(EMP_PW, '[A-Z]')
        AND REGEXP_LIKE(EMP_PW, '[a-z]')
        AND REGEXP_LIKE(EMP_PW, '\d')
        AND REGEXP_LIKE(EMP_PW, '[!@#$%^&*]')
    ),
    CONSTRAINT EMP_TIN_CHK CHECK (
        REGEXP_LIKE(EMP_TIN, 'IG\d{9,11}$')
    ),
    CONSTRAINT EMP_IC_CHK CHECK (
        REGEXP_LIKE(EMP_IC, '^(\d{6}-\d{2}-\d{4})$') -- IC format: YYMMDD-NN-NNNN
        OR REGEXP_LIKE(EMP_IC, '^([A-Z0-9]{6,20})$') -- Passport format: A1234567
    ),
    CONSTRAINT EMP_ROLE_CHK CHECK (
        EMP_ROLE IN ('Manager', 'Inspector', 'Staff')
    ),
    CONSTRAINT EMP_TITLE_CHK CHECK (
        EMP_TITLE IN ('Mr', 'Ms', 'Mrs', 'Dr', 'Prof')
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
/

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
    POSTCODE CHAR(5) NOT NULL,
    FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE) ON DELETE CASCADE,

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

-- SHIPPING_DESTINATION
-- SHIPPING_DESTINATION_SEQ (6)
CREATE TABLE SHIPPING_DESTINATION (
    SHIPD_ID CHAR(8) DEFAULT (
        'Z' || TO_CHAR(SHIPPING_DESTINATION_SEQ.NEXTVAL, 'FM000000')
    ) NOT NULL,
    SHIPD_NAME VARCHAR2(30) NOT NULL,
    SHIPD_ADDR VARCHAR2(100) NOT NULL,
    COM_ID CHAR(6) NOT NULL,
    POSTCODE CHAR(5) NOT NULL,
    FOREIGN KEY (COM_ID) REFERENCES COMPANY(COM_ID) ON DELETE CASCADE,
    FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE) ON DELETE CASCADE,

    CONSTRAINT SHIPPING_DESTINATION_PK PRIMARY KEY (SHIPD_ID)
);

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
    DRIVER_LISENCE_NO CHAR(15) UNIQUE NOT NULL,
    DRIVER_FNAME VARCHAR2(20) NOT NULL,
    DRIVER_LNAME VARCHAR2(20) NOT NULL,
    DRIVER_TITLE VARCHAR2(10) NOT NULL,
    DRIVER_BDATE DATE NOT NULL,
    DRIVER_PHONE VARCHAR2(15) NOT NULL,
    DRIVER_AVAILABILITY NUMBER(1) NOT NULL,
    LOG_ID CHAR(5) NOT NULL,
    FOREIGN KEY (LOG_ID) REFERENCES LOGISTIC_PROVIDER(LOG_ID) ON DELETE CASCADE,

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
    DRIVER_ID CHAR(7),
    FOREIGN KEY (SHIPD_ID) REFERENCES SHIPPING_DESTINATION(SHIPD_ID) ON DELETE CASCADE,
    FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER(DRIVER_ID),

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

-- ORDER_PRODUCT
-- ORDERS_SEQ (7), PRODUCT_SEQ (6)
CREATE TABLE ORDER_PRODUCT (
    ORD_ID CHAR(9) NOT NULL,
    PROD_ID CHAR(8) NOT NULL,
    QTY INTEGER NOT NULL,
    FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID) ON DELETE CASCADE,
    FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID) ON DELETE CASCADE,

    CONSTRAINT ORDER_PRODUCT_PK PRIMARY KEY (ORD_ID, PROD_ID),
    CONSTRAINT ORDER_PRODUCT_QTY_CHK CHECK (
        QTY >= 0
    )
);

-- PRODUCT_INVENTORY
-- PRODUCT_SEQ (6), SECTION_SEQ (5)
CREATE TABLE PRODUCT_INVENTORY (
    PROD_ID CHAR(8) NOT NULL,
    SECT_ID CHAR(7) NOT NULL,
    QTY INTEGER NOT NULL,
    FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID) ON DELETE CASCADE,
    FOREIGN KEY (SECT_ID) REFERENCES SECTION(SECT_ID) ON DELETE CASCADE,

    CONSTRAINT PRODUCT_INVENTORY_PK PRIMARY KEY (PROD_ID, SECT_ID),
    CONSTRAINT PRODUCT_INVENTORY_QTY_CHK CHECK (
        QTY >= 0
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
    FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID) ON DELETE CASCADE,

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
    FOREIGN KEY (ORD_ID) REFERENCES ORDERS(ORD_ID) ON DELETE CASCADE,

    CONSTRAINT FEEDBACKS_PK PRIMARY KEY (FDB_ID),
    CONSTRAINT FDB_RATE_CHK CHECK (
        FDB_RATE >= 1
        AND FDB_RATE <= 5
    )
);

-- PAYMENT
-- PAYMENT_SEQ (9)
CREATE TABLE PAYMENT (
    PAY_ID CHAR(11) DEFAULT (
        'P' || TO_CHAR(PAYMENT_SEQ.NEXTVAL, 'FM000000000')
    ) NOT NULL,
    PAY_DATE DATE DEFAULT SYSDATE NOT NULL,
    PAY_METHOD VARCHAR2(7) NOT NULL,
    INV_ID CHAR(11) NOT NULL,
    FOREIGN KEY (INV_ID) REFERENCES INVOICE(INV_ID) ON DELETE CASCADE,

    CONSTRAINT PAYMENT_PK PRIMARY KEY (PAY_ID),
    CONSTRAINT PAY_METHOD_CHK CHECK (
        PAY_METHOD IN ('CASH', 'CARD', 'EWALLET')
    )
);

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
    FOREIGN KEY (COM_ID) REFERENCES COMPANY(COM_ID) ON DELETE CASCADE,

    CONSTRAINT RECYCLE_ORDER_PK PRIMARY KEY (RORD_ID),
    CONSTRAINT RORD_STATE_CHK CHECK (
        RORD_STATE IN ('PND', 'PRC', 'CPL') -- Pending, Processing, Complete
    ),
    CONSTRAINT RORD_DELIVERY_DATE_CHK CHECK (
        RORD_DELIVERY_DATE > RORD_DEALING_DATE
    )
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
    FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER(RORD_ID) ON DELETE CASCADE,
    
    CONSTRAINT RECYCLE_TRANSACTION_PK PRIMARY KEY (RTRANS_ID),
    CONSTRAINT RTRANS_AMOUNT_CHK CHECK (
        RTRANS_AMOUNT >= 0
    ),
    CONSTRAINT RTRANS_PAY_METHOD_CHK CHECK (
        RTRANS_PAY_METHOD IN ('CASH', 'CARD', 'EWALLET')
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
    FOREIGN KEY (RORD_ID) REFERENCES RECYCLE_ORDER(RORD_ID) ON DELETE CASCADE,
    FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID) ON DELETE CASCADE,

    CONSTRAINT RECYCLED_ITEM_PK PRIMARY KEY (RITEM_ID),
    CONSTRAINT RITEM_CONDITION_CHK CHECK (
        RITEM_CONDITION IN (0, 1) -- 0: Bad, 1: Good
    ),
    CONSTRAINT RITEM_QTY_CHK CHECK (
        RITEM_QTY >= 0
    )
);

-- RETURNED_HISTORY
-- RETURNED_HISTORY_SEQ (5)
CREATE TABLE RETURNED_HISTORY (
    RHIS_ID CHAR(8) DEFAULT (
        'RH' || TO_CHAR(RETURNED_HISTORY_SEQ.NEXTVAL, 'FM00000')
    ) NOT NULL,
    RET_DATE DATE DEFAULT SYSDATE NOT NULL,
    RET_STAT CHAR(3) NOT NULL,
    EMP_ID CHAR(8) NOT NULL,
    RITEM_ID CHAR(8) NOT NULL,
    FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE(EMP_ID) ON DELETE CASCADE,
    FOREIGN KEY (RITEM_ID) REFERENCES RECYCLED_ITEM(RITEM_ID) ON DELETE CASCADE,

    CONSTRAINT RETURNED_HISTORY_PK PRIMARY KEY (RHIS_ID),
    CONSTRAINT RET_STAT_CHK CHECK (
        -- APPROVE (APV), REJECT (REJ)
        RET_STAT IN ('APV', 'REJ')
    )
);
