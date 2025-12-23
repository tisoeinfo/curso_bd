-- 1. ASSOCIATIVE ARRAY (Index-by Table)
DECLARE
    TYPE c_frutas IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    v_frutas c_frutas;
BEGIN
    v_frutas(1) := 'Manzana';
    v_frutas(2) := 'Banana';
    v_frutas(3) := 'Uva';

    FOR i IN 1 .. v_frutas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_frutas(i));
    END LOOP;
END;

-- 2. NESTED TABLE
DECLARE
    TYPE t_frutas IS TABLE OF VARCHAR2(50);
    v_frutas t_frutas := t_frutas();
BEGIN
    v_frutas.EXTEND;
    v_frutas(1) := 'Manzana';

    v_frutas.EXTEND;
    v_frutas(2) := 'Banana';

    v_frutas.EXTEND;
    v_frutas(3) := 'Uva';

    FOR i IN 1 .. v_frutas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_frutas(i));
    END LOOP;
END;
/

-- 3 VARRAY (Variable Array)
DECLARE
    TYPE t_frutas IS VARRAY(3) OF VARCHAR2(50);
    v_frutas t_frutas := t_frutas('Manzana', 'Banana', 'Uva');
BEGIN
    FOR i IN 1 .. v_frutas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_frutas(i));
    END LOOP;
END;
