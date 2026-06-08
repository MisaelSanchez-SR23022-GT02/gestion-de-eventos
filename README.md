# gestion de eventos

## Guía de Ejecución: Población de Datos Simulados

### Ubicación de los Archivos
Todos los scripts se encuentran en el repositorio del proyecto bajo el siguiente directorio:
`scripts-iniciales`

---

### Orden de Ejecución Obligatorio
Debido a las restricciones de llaves foráneas (`FOREIGN KEY`) y dependencias lógicas en la base de datos, los scripts **deben correrse de forma estrictamente secuencial**. Si se altera el orden, el motor de Oracle lanzará errores de datos no encontrados o violaciones de integridad.

Siga este orden exacto para copiar y pegar el contenido en su mesa de trabajo:

1. **`Script_DDL_inicial.sql`** * Crea la estructura base de la base de datos. Define todas las tablas, tipos de datos, así como las restricciones de integridad mediante llaves primarias (`PRIMARY KEY`) y foráneas (`FOREIGN KEY`). Su ejecución es un prerrequisito obligatorio antes de poblar el sistema*

1. **`Datos_maestros.sql`** *Mete la información base del negocio: 10 categorías de eventos, 10 empleados y 15 salones con capacidades y precios por hora.*
   
2. **`Insertar_clientes.sql`** *Genera 50 clientes simulados. Cuenta con manejo de excepciones para evitar correos o DUIs duplicados.*
   
3. **`Inserar_asistentes.sql`** *Crea la bolsa global de 200 asistentes generales que luego serán repartidos en las celebraciones.*
   
4. **`Insertar_eventos.sql`** *Crea 50 eventos uniendo aleatoriamente los clientes, empleados, categorías y salones previos.*
   
5. **`Insertar_control_asistencia.sql`** *Reparte de forma aleatoria y única a los asistentes dentro de los eventos según la capacidad real de cada salón.*
   
6. **`Insertar_registro_pago.sql`** *Calcula la duración en horas y costos de cada evento para registrar un abono aleatorio de entre el 30% y el 100%.*

---

### Paso a paso para la ejecución en la mesa de trabajo

Para cada uno de los 7 archivos listados anteriormente, debes seguir este procedimiento dentro de Oracle SQL Developer:

1. **Crea una nueva hoja de trabajo:** Abre una nueva Hoja de Trabajo SQL (*SQL Worksheet*) que esté conectada directamente a la instancia de tu base de datos.
2. **Abre el script original:** Abre el archivo `.sql` correspondiente desde el directorio del repositorio o utilizando tu editor de texto preferido.
3. **Copia el contenido:** Selecciona y copia el texto completo del archivo. Asegúrate de incluir todo el bloque, desde las primeras instrucciones (`CREATE`, `INSERT` o `DECLARE`) hasta la barra inclinada `/` que se encuentra al final.
4. **Pega el código:** Ve a la hoja de trabajo vacía que creaste en el primer paso y pega todo el bloque de código que acabas de copiar.
5. **Ejecuta como script (Paso crucial):** * **No** utilices el botón clásico de "Ejecutar Sentencia", porque el gestor intentará procesar el código línea por línea de forma aislada y el bloque fallará de inmediato.
   * **Sí** presionas la tecla **`F5`** o haces clic en el botón llamado **"Ejecutar como Script"**. Puedes identificar este botón en la barra de herramientas de SQL Developer porque tiene el icono de un play verde con una hoja en blanco justo detrás.

La barra inclinada `/` que va al final del texto sirve para avisarle a Oracle que debe compilar, empaquetar y procesar todo ese bloque PL/SQL en conjunto y en una sola transacción. Al terminar de ejecutar el último script de la lista, todas las estructuras estarán creadas y los datos se habrán guardado y confirmado mediante un `COMMIT` de manera exitosa.
