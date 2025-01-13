--COMPANY TABLE
CREATE TABLE COMPANY(
    COM_ID CHAR(5) PRIMARY KEY,
    COM_NAME VARCHAR2(20),
    COM_CATEGORY VARCHAR2(20),
    COM_ADDR VARCHAR2(100),
    COM_PIC_FNAME VARCHAR2(20),
    COM_PIC_LNAME VARCHAR2(20),
    COM_PIC_TITLE VARCHAR2(20),
    COM_PHONE VARCHAR2(13),
    COM_EMAIL VARCHAR2(20),
    POSTCODE NUMBER(5)
);

ALTER TABLE COMPANY 
ADD CONSTRAINT FK_POSTCODE
FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE);

CREATE TABLE SHIPPING_DESTINATION(
    SHIPD_ID CHAR(8) PRIMARY KEY,
    SHIPD_NAME VARCHAR2(30),
    SHIPD_ADDR VARCHAR2(100),
    COM_ID CHAR(5),
    POSTCODE NUMBER(5),
    FOREIGN KEY (COM_ID) REFERENCES COMPANY(COM_ID)
);

--SHIPPING DESTINATION TABLE
ALTER TABLE SHIPPING_DESTINATION 
ADD CONSTRAINT FK_SHIPD_POSTCODE
FOREIGN KEY (POSTCODE) REFERENCES CITY(POSTCODE);

--ORDERS TABLE
CREATE TABLE ORDERS (
    ORD_ID CHAR(11) PRIMARY KEY,
    ORD_DEALING_DATE DATE,
    ORD_RECIPENT_FNAME VARCHAR2(20),
    ORD_RECIPENT_LNAME VARCHAR2(20),
    ORD_RECIPENT_PHONE VARCHAR2(13),
    ORD_STATUS CHAR(3),
    SHIPD_ID CHAR(8),
    DRIVER_ID CHAR(6),
    FOREIGN KEY (SHIPD_ID) REFERENCES SHIPPING_DESTINATION(SHIPD_ID)
);

ALTER TABLE ORDERS
ADD CONSTRAINT FK_DRIVER_ID
FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER(DRIVER_ID);

--BRIDGE ENTITY
CREATE TABLE ORDER_PRODUCT(
    ORD_ID CHAR(11),
    PROD_ID CHAR(6),
    QTY INTEGER
);

ALTER TABLE ORDER_PRODUCT
ADD CONSTRAINT CK_OP_ORD_PROD
PRIMARY KEY(ORD_ID, PROD_ID);   -- COMPOSITE KEY

ALTER TABLE ORDER_PRODUCT
ADD CONSTRAINT FK_OP_ORD_ID
FOREIGN KEY (ORD_ID) REFERENCES COMPANY;    --FK

ALTER TABLE ORDER_PRODUCT
ADD CONSTRAINT FK_OP_PROD_ID
FOREIGN KEY (PROD_ID) REFERENCES PRODUCT; 

--PRODUCT TABLE
CREATE TABLE PRODUCT(
    PROD_ID CHAR(6) PRIMARY KEY,
    PROD_NAME VARCHAR2(20),
    PROD_DESC VARCHAR2(100),
    PROD_UOM VARCHAR2(8),
    PROD_UNIT_PRICE NUMBER(8,2)
);