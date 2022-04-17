       IDENTIFICATION DIVISION.
       PROGRAM-ID. CASCOBOL.
       AUTHOR. JORGE SALAMANCA.
       DATE-WRITTEN. 17/03/2021.
      *----------------------------------------------------------------
      * Aplicacion:                                                   |
      * Funcion   :                                                   |
      * Archivos Entrada/Salida:                                      |
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
      *----------------------------------------------------------------
      *               Declaracion de Archivos                         |
      *----------------------------------------------------------------
       FILE-CONTROL.
      *
           SELECT NOMARCHIVO
                  ASSIGN               TO DATABASE-NOMARCHIVO
                  ORGANIZATION         IS INDEXED
                  ACCESS MODE          IS DYNAMIC
                  RECORD KEY           IS EXTERNALLY-DESCRIBED-KEY
                                          WITH DUPLICATES.
      *
       DATA DIVISION.
      *
      *----------------------------------------------------------------
      *          Declaración de Definiciones de Archivo               |
      *----------------------------------------------------------------
       FILE SECTION.
      *
       FD  NOMARCHIVO
           LABEL RECORDS               ARE STANDARD.
       01  NOMARCHIVO-REC.
           COPY DD-ALL-FORMATS         OF NOMARCHIVO.
      *
      *----------------------------------------------------------------
      *            Declaracion de Variables de Trabajo                |
      *----------------------------------------------------------------
       WORKING-STORAGE SECTION.
      *
       01 W-ALFA                          PIC  X(100)    VALUE SPACES.
       01 W-NUMER                         PIC  9(017)    VALUE ZEROES.
       01 W-DECIMAL                       PIC  9(015)V99 VALUE ZEROES.
      *
      *----------------------------------------------------------------
       LINKAGE SECTION.
      *----------------------------------------------------------------
      *
      *----------------------------------------------------------------
       PROCEDURE DIVISION.
      *----------------------------------------------------------------
      *
      *----------------------------------------------------------------
       INICIAR-PROGRAMA.
      *----------------------------------------------------------------
           PERFORM INICIALIZAR
           PERFORM PROCESAR
           PERFORM FINALIZAR.
      *----------------------------------------------------------------
       FINALIZAR-PROGRAMA.
      *----------------------------------------------------------------
           GOBACK.
      *
      *----------------------------------------------------------------
      * Procedimiento : Inicializar.                                  |
      * Descripción   : En este procedimiento se inicializan las      |
      *                 variables de control y se abren los archivos  |
      *                 utilizados.                                   |
      *----------------------------------------------------------------
       INICIALIZAR.
      *----------------------------------------------------------------
           OPEN INPUT NOMARCHIVO
           OPEN I-O   NOMARCHIVO
           .
      *----------------------------------------------------------------
      * Procedimiento : PROCESAR.                                     |
      * Descripción   : Se inicia la logica del PGM                   |
      *----------------------------------------------------------------
       PROCESAR.
      *----------------------------------------------------------------
		   PERFORM RECORRER-ARCHIVO
           CONTINUE
           .
      *----------------------------------------------------------------
      * Procedimiento : Recorrer Archivo.                             |
      * Descripción   : Se realiza  un star al archivo y despues un   |
      *                 read next con perfor until                    |
      *----------------------------------------------------------------
       RECORRER-ARCHIVO.
      *----------------------------------------------------------------
           PERFORM START-ARCHIVO
           PERFORM READ-NEXT-ARCHIVO  UNTIL ( SI-FIN-ARCHIVO )
           .
      *----------------------------------------------------------------
      * Procedimiento : START-ARCHIVO                                 |
      * Descripción   : Para realizar un star a un archivo indexado   |
      *                 se le debe de pasar la llave y del que es     |
      *                 sequencias no se le pasa nada                 |
      *----------------------------------------------------------------
       START-ARCHIVO.
      *----------------------------------------------------------------
           MOVE 1234556             TO XXXXXX OF ARCHIVO
           START ARCHIVO       KEY NOT < EXTERNALLY-DESCRIBED-KEY
              INVALID KEY
                MOVE 1              TO W-FIN-ARCHIVO
              NOT INVALID KEY
                MOVE 0              TO W-FIN-ARCHIVO
           END-START.
      *----------------------------------------------------------------
      * Procedimiento : READ-NEXT-ARCHIVO.                            |
      * Descripción   : Se inicia a leer los registros uno a uno      |
      *----------------------------------------------------------------
       READ-NEXT-ARCHIVO.
      *----------------------------------------------------------------
           READ ARCHIVO    NEXT  AT END
                MOVE 1             TO W-FIN-ARCHIVO
           END-READ
      * Realiza filtros, procesa el registro leido, etc
           IF ( NO-FIN-ARCHIVO )
              MOVE X TO A
           END-IF
           .
      *----------------------------------------------------------------
       WRITE-ARCHIVO.
      *----------------------------------------------------------------
           WRITE ARCHIVO-REC
            INVALID KEY
               DISPLAY "ERROR AL CREAR"
            NOT INVALID KEY
               DISPLAY "CREACION SATISFACTORIA"
           END-WRITE.
      *----------------------------------------------------------------
       REWRITE-ARCHIVO.
      *----------------------------------------------------------------
           REWRITE ARCHIVO-REC
            INVALID KEY
               DISPLAY "ERROR AL ACTUALIZAR"
            NOT INVALID KEY
               DISPLAY "ACTUALIZACION SATISFACTORIA"
           END-REWRITE.
      *----------------------------------------------------------------
       READ-ARCHIVO.
      *----------------------------------------------------------------
           MOVE 1                        TO W-EXISTE-ARCHIVO
           MOVE W-NUMINT                 TO NUMINT OF ARCHIVO
           READ  ARCHIVO
            INVALID KEY
               MOVE 0                    TO W-EXISTE-ARCHIVO
           END-READ.
      *----------------------------------------------------------------
       DELETE-ARCHIVO.
      *----------------------------------------------------------------
           DELETE  ARCHIVO
            INVALID KEY
               DISPLAY "CLIENTE NO EXISTE EN LA BD"
            NOT INVALID KEY
               DISPLAY "CLIENTE NELIMINADO EXITOSAMENTE"
           END-DELETE.
      *----------------------------------------------------------------
      * Procedimiento : Finalizar.                                    |
      * Descripción   : Se cierran los archivos utilizados.           |
      *----------------------------------------------------------------
       FINALIZAR.
      *----------------------------------------------------------------
           CLOSE NOMARCHIVO
           .
