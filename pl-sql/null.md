# NULL in PL/SQL

The **NULL** value in **PL/SQL** is delicate, especially when we want to **compare** variables.

The next code snippet will show `DIFFERENT` in the standard output:

```sql
DECLARE
    var1 VARCHAR2(2) := NULL;
    var2 VARCHAR2(2) := NULL;
BEGIN
    IF var1 = var2 THEN
        dbms_output.put_line('IDENTICAL');
    ELSE
        dbms_output.put_line('DIFFERENT');
    END IF;
END;
```

You can see an example using another comparison operator. You will see `IDENTICAL` for the next case:

```sql
DECLARE
    var1 VARCHAR2(2) := 'OK';
    var2 VARCHAR2(2) := NULL;
BEGIN
    IF var1 <> var2 THEN
        dbms_output.put_line('DIFFERENT');
    ELSE
        dbms_output.put_line('IDENTICAL');
    END IF;
END;
```

We could show you more samples, but with the previous ones, you are already realise something is wrong. What happens?
**In PL/SQL any comparison containing one NULL value at least will return `false`**

To secure a comparison with `null` values, we usually use the `NVL` function:

```sql
DECLARE
    var1 VARCHAR2(2) := 'OK';
    var2 VARCHAR2(2) := NULL;
BEGIN
    IF nvl(var1,'###') <> nvl(var2,'###') THEN
        dbms_output.put_line('DIFFERENT');
    ELSE
        dbms_output.put_line('IDENTICAL');
    END IF;
END;
```

We have something more to say... In *PL/SQL*, assigning **empty string** or `NULL` is actually the same.
This fact is not often happening in others programming languages such as Java where a *empty string* is a real value.

The following snippet will show `DIFFERENT` again, for the the reason explained above because is evaluated as `NULL`.

```sql
DECLARE
    var1 VARCHAR2(2) := '';
BEGIN
    IF var1 = '' THEN
        dbms_output.put_line('IDENTICAL');
    ELSE
        dbms_output.put_line('DIFFERENT');
    END IF;
END;
```
Also it's very useful make use of the operators `IS NULL` or `IS NOT NULL`:

```sql
DECLARE
    var1 VARCHAR2(2) := NULL;
    var2 VARCHAR2(2) := '';
    var3 VARCHAR2(2) := 'OK';
BEGIN
    IF var1 = var2 THEN
        dbms_output.put_line('Wrong comparision.');
    ELSIF var1 <> var2 THEN
        dbms_output.put_line('Wrong comparision.');
    ELSIF nvl(var1,'NULO') = var3 THEN
        dbms_output.put_line('IDENTICAL');
    ELSIF var1 IS NOT NULL AND var2 IS NOT NULL THEN
        dbms_output.put_line('FALSE');
    ELSE
        dbms_output.put_line('Be careful with the NULL values, ' || var3 || '?');
    END IF;
END;
```