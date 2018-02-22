-- How to loop in DB2

CREATE OR REPLACE PROCEDURE LOOP_PEPITO()
    LANGUAGE SQL
    BEGIN
      DECLARE my_counter INTEGER DEFAULT 0;
      my_loop:
      LOOP
        IF my_counter = 10 THEN
           LEAVE my_loop;
        END IF;

        -- You can add your code here

        SET my_counter = my_counter + 1;
      END LOOP my_loop;
   END;

CALL LOOP_PEPITO();
DROP PROCEDURE LOOP_PEPITO;