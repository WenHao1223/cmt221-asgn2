-- -- create function to filter city based on the state
CREATE OR REPLACE FUNCTION FN_FILTER_CITY (
    p_state IN CITY.CITY_STATE%TYPE
) RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT * FROM CITY WHERE CITY_STATE = p_state;
    RETURN v_cursor;
END;
/

-- store to table for testing BY EXECUTING THE FUNCTION
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := FN_FILTER_CITY('Penang');
    DBMS_SQL.RETURN_RESULT(v_cursor);
END;
-- /