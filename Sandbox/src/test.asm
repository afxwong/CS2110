.orig x3000

 ;int i = 0;
 ;while (str[i] != '\0') {
  ;   if (str[i] == '9') {
  ;       str[i] = '0';
  ;   } else if (str[i] < '9') {
  ;       str[i] = str[i] + 1;
  ;   }
  ;   i++;
 ;}

AND R0, R0, 0 ;R0 = i = 0
LD R1, STRING ;R1 = addr of str[0]

WHILE1 ADD R2, R1, R0 ;R2 = addr of str[i]
LDR R6, R2, 0 ;R6 = value of str[i]
BRz ENDW1 ;continue if str[i] not null

IF1
LD R3, NINE ;R3 = ascii of 9
NOT R3, R3
ADD R3, R3, 1
ADD R3, R6, R3 ;R3 = value of str[i] - ascii of 9
BRn ELSEIF
BRp INC
LD R3, ZERO ;R3 = ascii of 9
STR	R3,	R2,	0 ;str[i] = '0'
BR INC

ELSEIF
ADD R6, R6, 1 ; str[i] + 1
STR R6, R2, 0 ;str[i] = str[i] + 1

INC
ADD R0, R0, #1 ;i++
BR WHILE1
ENDW1
HALT

ZERO .fill #48
NINE .fill #57
STRING .fill #6000

.end

.orig x6000
.stringz "0123456789Test"
.end