     DEXECMD           PR                  EXTPGM('EXECMD')
     D    Command                   500A
     D    Status                      1S 0

     DEXECMD           PI
     D    Command                   500A
     D    Status                      1S 0

     DCMD              PR                  EXTPGM('QCMDEXC')
     D    Strcmd                    500A
     D    Longitud                   15P 5

     D    Longcad      s             15P 5
      /Free
          Longcad  =  %len(Command);
          callp(e) CMD(Command:Longcad) ;
          if (%error) ;
              Status = 9;
          else;
              Status = 0;
          endif;
       *Inlr =*On;
      /End-free