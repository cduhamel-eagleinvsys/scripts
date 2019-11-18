Set heading off;
set feedback off;
set echo off;
Set lines 999;

Spool run_invalid.sql

select
   'ALTER ' || decode(OBJECT_TYPE, 'PACKAGE BODY', 'PACKAGE', object_type) || ' ' ||
   OWNER || '.' || decode(OBJECT_NAME, 'ESTAR_ENGINE', '', object_name) || ' COMPILE;'
from
   all_objects
where
   status = 'INVALID'
and
   object_type in ('PACKAGE','FUNCTION','PROCEDURE','PACKAGE BODY')
;

spool off;

set heading on;
set feedback on;
set echo on;

@run_invalid.sql
