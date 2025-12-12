/* -----------------------------------------------------------
   RESUMEN: CONFIGURACIÓN DEL PERÍODO DE RETENCIÓN (Oracle)

   ¿Qué es el período de retención?
   --------------------------------
   - Oracle genera constantemente archivos de auditoría y logs 
     del sistema (*.aud, alert log, trace, listener, etc.).
   - Para evitar que estos archivos llenen el disco, Oracle usa 
     un "período de retención", que define cuántos días se 
     conservan antes de ser eliminados automáticamente.
   - Por defecto, los logs de auditoría se retienen por 90 días.
     El máximo configurable es 365 días.

   ¿Quién realiza la limpieza automática?
   ---------------------------------------
   - Un script interno del sistema:
         /var/opt/oracle/cleandb/cleandblogs.pl
   - Este script se ejecuta semanalmente mediante crontab 
     (tarea programada del sistema operativo Linux).

   ¿Dónde se configura la retención?
   ---------------------------------
   - En el archivo:
         /var/opt/oracle/cleandb/cleandblogs.cfg
   - Allí se definen los días de retención por tipo de log:
         AuditRetentionDB=14     --> Auditoría
         AlertRetention=14       --> Alert log
         TraceRetention=7        --> Archivos trace
         LogDirRetention=14      --> Otros logs

   REQUISITOS PARA PODER PROBAR O CONFIGURAR ESTO
   -----------------------------------------------
   Para modificar o verificar estos parámetros, se necesita:
   1. Tener acceso a Oracle Cloud Infrastructure (OCI).
   2. Crear un servicio Oracle Database Cloud Service (DBCS).
   3. Acceso SSH al servidor Linux donde está instalada la BD.
   4. Contar con permisos del usuario "oracle" dentro del servidor.
   5. Conocer rutas del sistema operativo y comandos básicos de Linux.

   IMPORTANTE:
   - Este tema pertenece a instalaciones de Oracle en la nube 
     (DPCS/DBCS) o entornos empresariales.
   - NO se puede probar en Oracle Express, Oracle local,
     SQL Developer ni máquinas Windows comunes.

   OBJETIVO:
   - El objetivo es entender cómo Oracle administra y depura 
     automáticamente los archivos de auditoría para evitar 
     problemas de almacenamiento y mantener la base estable.
------------------------------------------------------------- */
