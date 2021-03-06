."
Work with vocablary  DSSP/c" CR
 
[организация подсловарей:
                         31              0
                        ┌─────────────────┐ 
 31           0         │      WD1        │<-- NB (*) 
 │   . . .    │         ├─────────────────┤ 
 ├────────────┤         │      D1         │ 
 │     0      │         ├─────────────────┤ 
 ├────────────┤         │      YD1        │ 
 │    BA      │────┐    ├────────┬────────┤ 
 ├────────────┤    └───>│    DSSP-next    │a (в текущем 
 │    имя     │         ├────────┼────────┤   кодовом сегменте) 
 ├            ┤       ┌─│ адр.шкалы п/с   │a + nextlen 
 │ подсловаря │       │ └────────┴────────┘ 
 ├────────────┤       │ 
 │    NB   (*)│       │          ┌────────┐ 
 ├────────────┤       └─────────>│        │ 
 │            │ <-- NV           └────────┘ 
                                  15     0 
 
 ] 
 
[-----------------------------------------------------------] 
: VOCBODYLEN NOPLEN ; 
: ,VOCBODY [] ,NOP [] ; 
[-----------------------------------------------------------] 
 
B16 
[Указатель на начало словаря констант] 
[::] FIX LONG VAR V1      '' V1 __ ''V1 
[::] : V1MIN [] NB 30 + [V1MIN] ; 
 
[Указатель на начало словаря ] 
FIX LONG VAR NV     '' NV __ ''NV 
 
 
[::] : UNDEF [] '' BYOPEN ''NOP '' UNDEFS DSRCH [] ; 
: UNDEFS [AZ] AVOC  C @UBIT  E2 1A [C-bit] @BI NOT &  IF+ NEZW [AZ] ; 
: NEZW [AZ]  NEZNAYU  AVOC OUTW [AZ] ; 
: BYOPEN [*,*,*,A3] 
     AZ-S [*,*,*,A3,a ШК] @L BR- NOP IS0 [*,*,*,AZ/0] ; 
 
[::] :  ?$ [] SCON EON ESCR SCOFF '' ?$ZS SSRCH 7 ! UCOLOR SCOFF [] ; 
: SSRCH ''NOP '' IS0 DSRCH [] ;

[!!!DF!!!]
: ?$ZS [AZ] CR AZ-S [A scale] @L 3 @BN E2D 80 & [BR-] [см. FIND]
       C BR+ 02 0C ! UCOLOR AVOC OUTW SP BR+ ."open " ."close" 
       CR ."  Locate-" ?$FILE [AZ] ;

[получение адреса шкалы подсловаря по AVOC] 
:: : AZ-S [] AVOCBA VOCBODYLEN + @L [A sc] ; 


[ !!!DF!!!! ]
:: : ?$FILE [] AVOCBA [NEXTLEN] 4 + [Ъд┴.L-╨┌.┬ Ъд┴.╔кЪл╠]
     4+ C @L E2 4+ @L [a,l] SP SP TOS [AZ] ;

[::] : PROGRAM FORGET <WRD GROW ; 
[::] : SFORGET WRD FIND NOT [ОПРЕДЕЛЕН ЛИ ТАКОЙ ЗАГОЛОВОК П/С]
       [AZ,1/0] C2 C @UBIT E2 [AZ,1/0,1/0,AZ]
       @SNAME #$ -  &0 &0 [ПЕРВЫЙ СИМВОЛ - '$'?]  BR0 FORGET0 D SQVOC [] ;
[::] : FORGET WRD FIND NOT  [ОПРЕДЕЛЕН ЛИ ТАКОЙ ЗАГОЛОВОК П/С]
       [AZ,1/0] C2 C @UBIT E2 [AZ,1/0,1/0,AZ]
       @SNAME #$ -  &0 &0 [ПЕРВЫЙ СИМВОЛ - '$'?]  BR0 CLE1 D  SQVOC [] ;
: CLE1 [AZ] ." 
delete voc.     " '' IVC SSRCH [AZ] FORGET0 [] ; 
:: : FORGET0 [AZ] C 4+ [AZ,AZ+4=a NBold] @L 
       [AZ,NBold] C @L ! WD1  C 4+ @L ! D1  C 8 + @L ! YD1 
       [AZ,NB] ! NB 
       [AZ] IS0 4-IS0 ! NV [] 
       PROCLIST [восстановительные действия по системному списку] 
       ''NOP '' CLTAB C2 DSRCH [восстановление неопределенностей] 
       FORGV1 [] ; 
: CLTAB [AT] C 4- @L [AT,Aупотребления] @L [AT,BA] 
       NB 4- >  AVOC 1A @BI [Cbit] &  IF+ CLEVOS [AT] ; 
: CLEVOS [AT] AVOC  1A [Cbit] !BI0 
       [AT] C DLTAB  [AT,AT,KS] DO CLEV1 D [AT] ; 
: CLEV1 [AT,AS] 4- C @L INBD BR0 CLEV2 CLEV3 [AT,AS-4] ; 
: CLEV3 [AS] C @L '' ZAGL  <!TL [AS] ; [ВОССТ. НЕОПРЕДЕЛЕННОСТЬ] 
[удаление элем. из табл., если не нужно восст. неопределенность] 
: CLEV2 [AT,AS] E2 C @L 4+ [AS,AT,-DL+4] C2 !TL 
       [AS,AT] 4- E2 
       [AT-4,AS] C 4+ NV 4- C3 - C3 !SB 
       [AT-4,AS] 4 !- NV [AT-4,AS] ; 
: IVC [AZ,*,*,*,*] AVOC CR OUTW  5 CT AVOC = IF+ FSRCH [...] ; 
 
[организация подсловарей: 
 
                         31              0 
                        ┌─────────────────┐ 
 31           0         │      WD1        │<-- NB (*) 
 │   . . .    │         ├─────────────────┤ 
 ├────────────┤         │      D1         │ 
 │     0      │         ├─────────────────┤ 
 ├────────────┤         │      YD1        │ 
 │    BA      │────┐    ├────────┬────────┤ 
 ├────────────┤    └───>│    DSSP-next    │a (в текущем 
 │    имя     │         ├────────┼────────┤   кодовом сегменте) 
 ├            ┤       ┌─│ адр.шкалы п/с   │a + nextlen 
 │ подсловаря │       │ └────────┴────────┘ 
 ├────────────┤       │ 
 │    NB   (*)│       │          ┌────────┐ 
 ├────────────┤       └─────────>│        │ 
 │            │ <-- NV           └────────┘ 
                                  15     0 
 
 ] 

[!!!DF!!!]
[::] : GROW [] NB WD1 ,L D1 ,L YD1 ,L 
      WRD FIND [NB,AZ,BA] BR0 NDIC YDIC  [NB,BA] 
      0 ,NV [конец нового подсловаря] 
      0 ,NV [конец заголовка нового подсловаря] 
      0 ,NV [т.к. процедура HDN заводит новый заголовок под нулем] 
      1 HDN [NB,BA,AZ] 'BA !TL 
      [NB] NV 4- !TL ,FN  [] ; 

DEFINE? R4L %IF
: 0,L [] 0 ,L [] ;
: ,FN [] YD1 ,L
  ' AOVS @L '' R4L = BR0 0,L ,FN1 [] ;
: ,FN1 [] FFPRS CHLD [a,l] C2 C2 YD1 !SB [a,l] C ,L !+ YD1 D [] ;
%FI
DEFINE? R4L NOT %IF
: ,FN [] YD1 ,L 0 ,L [] ;
%FI


[!!!DF!!!]




: NDIC [A0] D NB ,VOCBODY 4 FIX MUSE C ,L -1 E2 !TL [BA] ; 
: YDIC [AZ] C@UB  BR+ NDIC2 BA [BA] ; 
: NDIC2 [AZ] NB ! AT FIXTB [AZ] NDIC [BA] ; 
 
[!!!!!!!!!!!!!!!!!!!!!!!] 
[Проверить и убрать все маски] 
[!!!!!!!!!!!!!!!!!!!!!!!] 
 
LONG VAR ATPS [адрес тела п/с] 
: USE [] GTP ! ATPS  USE0 [] ;                 PBIT USE 
 : USE0 [] '' U1 '' NOP  '' NOP  DSRCH [] ; 
 : U1 [] AVOCBA ATPS = IF+ U11 [] ; 
 : U11 [] AZ-S [As] C@L [80000000 &0]  3 @BN 80 &0 3 !BN <!TL FSRCH [] ; 
 
: SHUT [] GTP ! ATPS  '' U3 '' NOP  '' NOP  DSRCH [] ;   PBIT SHUT 
 : U3 [] AVOCBA ATPS = IF+ U31 [] ; 
 : U31 [] AZ-S [As] C@L [7FFFFFFF &] 3 @BN 7F & 3 !BN <!TL FSRCH [] ; 
 
[::] : ONLY [] '' ONLYZS SSRCH [] GTP ! ATPS USE0 [] ;   PBIT ONLY 
: ONLYZS [] AZ-S  [As] C@L [SHR]  3 @BN 7F & 3 !BN <!TL [] ; 
 
[::] : CANCEL [] '' CANZS SSRCH [] ; 
: CANZS [A3] AZ-S [A3,As] C@L [SHL 1 &0] 3 @BN 80 &0 3 !BN <!TL [A3] ; 
 
: @DBIT [A] [3+] 1E @BI [Dbit/0] ;
[::] : CLEAR [] GTP ! ATPS  '' CLZS ''NOP '' CLZW  DSRCH [] ;  PBIT CLEAR 
: CLZS [AZS] AVOCBA ATPS = IF0 IS0 [AZS'] ; 
: CLZW [AZ] AVOC @DBIT IF+ CLZW1 [AZ] ; 
: CLZW1 [AZ next] AVOC 4+ NV 4- 
          [AZ n,AZ+4,NV-4] AVOC - C3 4+ [AZ n,AZ+4,DL,'BA] !SB 
          [AZ n] C AVOC - ADDNV [AZ next] ; 
 
B16 
[ОПИСАНИЕ СИСТЕМНОГО СПИСКА SYSLIST] 
 
[Системный список располагается в области тел процедур. 
 Его начало в переменной SYSLIST. 
 Его структура 
 ┌─────────┐             /│\  - направление увеличения NB 
 │ SYSLIST │              │ 
 └────┬────┘              │ 
      │                   │ 
 A    │              A+4                         A+8 
┌─────V─────────────┬───────────────────────────┬───────────────────┐ 
│ адрес предыдущего │ адрес процедуры обработки │ дополн. информация│ 
└─────┬─────────────┴───────────────────────────┴───────────────────┘ 
      │ 
┌─────V─────────────┬───────────────────────────┬───────────────────┐ 
│ адрес предыдущего │ адрес процедуры обработки │ дополн. информация│ 
└─────┬─────────────┴───────────────────────────┴───────────────────┘ 
   ....... 
      │ 
┌─────V─────────────┬───────────────────────────┬───────────────────┐ 
│     0             │ адрес процедуры обработки │ дополн. информация│ 
└───────────────────┴───────────────────────────┴───────────────────┘ 
└─────────заголовок эл-та списка ───────────────┘ 
 
На вход процедуры обработки подается адрес дополнительной информации. 
Должна его потреблять и больше ничего не трогать и ничего не оставлять. 
 
] 
 
FIX LONG VAR SYSLIST  0 ! SYSLIST 
 
[ADDLIST - добавление заголовка нового элемента к списку SYSLIST] 
[::] : ADDLIST [''proc] NB SYSLIST ,L ! SYSLIST ,L [] ; 
 
[PROCLIST - обработка списка SYSLIST до первого эл-та ниже 
            текущего значения NB и сброс SYSLIST на этот эл-т. 
            Данная процедура вызывается при FORGET] 
     : PROCLIST [] SYSLIST RP PROCLI0 ! SYSLIST [] ; 
     : PROCLI0 [A] C EX0 [A]  C NB > EX0 [A] 
               C@L E2 [Aпред,Aтек] 
               8 + C 4- @L [A',Aдопинф,''proc] EXEC [] ; 
 
[NUSE-S - запоминание информации длины l с адреса A и ее восстановление 
        при удалении словаря, где был сделан NUSE-S] 
[::] : NUSE-S [A,L] 
    '' NUSEVOST ADDLIST C2 ,L C ,L E2 C2 NB !SB [L] !+ NB [] ; 
    [структура доп инф для NUSE-S: 
┌────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬──  ──┬────┬────┐ 
│  адрес сохр инф   │       длина       │   и н ф о р м а ц и я    │ 
└────┴────┴────┴────┴────┴────┴────┴────┴────┴────┴──  ──┴────┴────┘ 
    ] 
[NUSE - запоминание слова по адресу A и его восстановление 
        при удалении словаря, где был сделан NUSE] 
[::] : NUSE [A] 4 NUSE-S [] ; 
 
: NUSEVOST [Aдопинф] C@L E2 4+ C@L E2 4+ E3 !SB [] ;
