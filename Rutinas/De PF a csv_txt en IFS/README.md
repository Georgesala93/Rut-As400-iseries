# De PF a csv_txt en IFS
Esta Rutina funsiona para que apartir de una sentencia sql se genere un archivo .CSV o .TXT, cada programa realizado para esta funsionalidad cumple con una actividad en especifica el cual se pueden mejorar de acuerdo a las necesidades de cada uno.

## Archivos Fisicos de Fuentes (SRCPF)
- **SRCCBL:** Contiene los fuentes de programas COBOL (CBL, SQLCBL, CBLLE, SQLCBLLE).
- **SRCRPG:** Contiene los fuentes de programas RPG (RPG, RPGLE, etc.).
- **SRCCLP:** Contiene los fuentes de programas CLP.
- **SRCDDS:** Contiene los fuentes de los Archivos fisicos(PF), Archivos Logicos(LF) y Tablas(TABLE).
- **SRCSDA:** Contiene los fuentes de Pantallas.

## Programas de la Rutina
- **RUTPFAIFSP :** Este pgm esta echo en leguaje CL el cual recupera el nombre del usuario y realiza el llamado al pgm cobol enviandole como parametro el usuario en ejecucion.
- **RUTPFAIFS  :** Este pgm esta echo en COBOL recibe como parametro el usuario en ejecucion para armar la ruta del ifs donde dejara el archivo a generar de acuerdo a la consulta SQL que ingrese por pantalla.
- **EXECMD     :** Este pgm esta echo en RPG cumple con la funcionalidad de ejecutar comandos CL, este pgm es llamado desde RUTPFAIFS ya que le envia a ejecutar el comando CPYTOIMPF de acuerdo a las necesidades de cada uno.

Para su funcionamiento es trasladar el codigo y compilarlo en su as400-iseries.