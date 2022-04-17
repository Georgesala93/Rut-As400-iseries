         PGM
             DCL        VAR(&XUSER) TYPE(*CHAR) LEN(10)
             RTVJOBA    USER(&XUSER)
             CALL       PGM(RUTPFAIFS) PARM(&XUSER)
         ENDPGM