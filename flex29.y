%{
  #include <stdio.h>
  #include <string.h>
  #include<math.h>
  int sym[26], dec[26], index=0;
  char vari[100][100];
  char vari2[100][100];
  int forswitch;
%}

%union
{
    int intValue;
    float floatValue;
    char str[100];
};

%start startpoint
%token ADD MINUS ASSIGN MUL DIV MOD END PRINT IF ELSE ELSEIF FOR INC DEC COPYSTRING CONCAT LENGTHSTRING COMMENT EQ
%token LIBRARY MAIN
%token TB TBE SB SBE FB FBE
%token GT GTE LT LTE
%token INTEGER 
%token FLOAT 
%token LONGFLOAT CHAR STRING
%token<floatValue> FloatNUMBER
%token<str>  VARIABLE
%token<intValue> NUMBER
%type<intValue> exp
%type<intValue> state
%type<intValue> state2
%type<intValue> term
%type<intValue> factor
%type<intValue> condition
%type<intValue> statement
%type<intValue> incdec
%type<intValue> rel
%type<str> loop
%left ADD MINUS
%left MUL DIV MOD

%%

startpoint:  
 | startpoint assignment 
 | startpoint declaration
 | startpoint print
 | startpoint condition
 | startpoint loop
 | startpoint copystr
 | startpoint concat
 | startpoint lenstr
 | startpoint comment
 | startpoint headers
 ;

headers: 
  MAIN FB FBE {printf("main function begins\n");}
 |LIBRARY LT VARIABLE GT {printf("Library included\n");} 
comment: COMMENT {printf("comment\n");}

lenstr: LENGTHSTRING FB VARIABLE FBE END {
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $3)==0){
      printf("%d\n", strlen(vari2[i]));
      break;
    }
  }
}

copystr: COPYSTRING FB VARIABLE ',' VARIABLE FBE END {
  char temp[100][100];
  int j;
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $5)==0){
      //printf("%s\n", vari2[i]);
      strcpy(temp[i], vari2[i]);
      //temp[i]=vari2[i];
      //printf("%s\n", temp[i]);
      j=i;
      break;
    }
  }
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $3)==0){
      //printf("%d", i);
      strcpy(vari2[i], temp[j]);
      //printf("%s\n", vari2[i]);
      break;
    }

  }
}
;

concat: CONCAT FB VARIABLE ',' VARIABLE FBE END {
  char temp[100][100];
  int j;
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $5)==0){
      //printf("%s\n", vari2[i]);
      strcpy(temp[i], vari2[i]);
      //printf("temp: %s\n", temp[i]);
      j=i;
      break;
    }
  }
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $3)==0){
      //printf("%d", i);
      strcat(vari2[i], temp[j]);
      //printf("%s\n", vari2[i]);
      break;
    }

  }
}

loop: 
  FOR FB VARIABLE ASSIGN NUMBER END VARIABLE rel factor END VARIABLE incdec FBE SB '*' VARIABLE '*' SBE {
     int x=$5, length = $9;

     if($8 == 1) {
        if($12 == 1){
          for( ;x<length;x++){
          //printf("for loop");
          printf("%s\n", $16);
        }
      }
     } 
     else if($8 == 2){
        if($12 == 1){
        for( ;x<=length;x++){
          printf("%s\n", $16);
        }
       }
     }
     else if($8 == 3){
       if($12 == 2){
        for( ;x>length;x--){
          printf("%s\n", $16);
        }
       }
     }
     else {
      if($12 == 2){
        for( ;x>=length;x--){
          printf("%s\n", $16);
        }
       }
     }

  }

rel: LT {$$=1;}
    |LTE {$$=2;}
    |GT {$$=3;}
    |GTE {$$=4;}

incdec: INC {$$=1;}
       |DEC {$$=2;}

condition:
   IF FB state FBE SB statement SBE {
    if($3 == 1) {
      printf("if is true %d", $6);
    }
   }
   | IF FB state FBE SB statement SBE ELSE SB statement SBE {
    if($3 == 1) {
      printf("if: %d\n", $6);
    }
    else {
      printf("else: %d\n", $10);
    }
   }
   | IF FB state FBE SB statement SBE ELSEIF FB state2 FBE SB statement SBE ELSE SB statement SBE {
     if($3 == 1) {
      printf("if: %d\n", $6);
    }
    else if ($10 == 2) {
      printf("elseif: %d\n", $13);
    }
    else {
      printf("else: %d\n", $17);
    }
   }
   ;

statement: factor ADD factor {$$ = $1 + $3;}
| factor MINUS factor {$$ = $1 - $3;}
;


state: 
  factor GT factor {
    if($1 > $3){
      $$ = 1;
      printf("greater\n");
    }
    else { $$=0; }
  } 
  |factor GTE factor {
    if($1 >= $3){
      $$ = 1;
      printf("greater equal\n");
    }
    else { $$=0; }
  } 
  |factor LT factor {
    if($1 < $3){
      $$ = 1;
      printf("less than\n");
    }
    else { $$=0; }
  } 
  |factor LTE factor {
    if($1 <= $3){
      $$ = 1;
      printf("less than equal\n");
    }
    else { $$=0; }
  } 
  ;

state2: 
  factor GT factor {
    if($1 > $3){
      $$ = 2;
      printf("else if greater\n");
    }
    else { $$=0; }
  } 
  |factor GTE factor {
    if($1 >= $3){
      $$ = 2;
      printf("greater equal\n");
    }
    else { $$=0; }
  } 
  |factor LT factor {
    if($1 < $3){
      $$ = 2;
      printf("less than\n");
    }
    else { $$=0; }
  } 
  |factor LTE factor {
    if($1 <= $3){
      $$ = 2;
      printf("less than equal\n");
    }
    else { $$=0; }
  } 
  ;

print:
 PRINT FB  VARIABLE   FBE END {
   //printf("g");
   for(int i=0; i<index; i++){
    if(strcmp(vari[i], $3)==0){
      printf("%d\n", sym[i]);
      break;
    }

  }
   
   //int x= $2;
   //printf("%d\n", sym[x]); 
}
|PRINT FB '*' VARIABLE '*' FBE END {
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $4)==0){
      //printf("%d", i);
      printf("%s\n", vari2[i]);
      break;
    }

  }
}


assignment: 
 exp {printf("%d\n", $1);}
 |VARIABLE ASSIGN exp  { 
  //int x= $1[0]-'a';
  //sym[x] = $3;
  
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $1)==0){
      sym[i] = $3;
      //printf("%d\n", i);
      break;
    }
  } }
  | VARIABLE ASSIGN '*' VARIABLE '*' {
    for(int i=0; i<index; i++){
      if(strcmp(vari[i], $1)==0){
        strcpy(vari2[i], $4);
        //printf("%d", i);
        //printf("%s", vari2[i]);
      }
    }
  }
 ;

declaration:
         TYPE ID1 END	{ 
					printf("\nValid Declaration\n");
				}

TYPE : INTEGER	{printf("\nIts integer\n"); }

     | FLOAT	{printf("\nits float\n"); }

     | CHAR	{ printf("\nits character\n"); }

     | LONGFLOAT { printf("\nits double\n"); }

     | STRING {printf("\nits string\n");}
     ;

ID1  : ID1 ',' VARIABLE { printf("\n1\n"); 
  dec[index++] = $3;
  strcpy(vari[index-1], $3); 
  printf("%c", vari[index-1][0]);
  //strcpy(vari[index], $3);
  //int x = $3;
  //sym[x] = 3;
  }

     | VARIABLE		{ printf("\n2\n");
  dec[index++] = $1;
  strcpy(vari[index-1], $1); 
  printf("%c", vari[index-1][0]);}  
     ;					       
		


exp:
        exp ADD term				{ $$ = $1 + $3; printf("%d\n", $$);}
        | exp MINUS term         { $$ = $1 - $3; printf("%d\n", $$);}
        | term						{ $$ = $1; }
        ;
term:
		term MUL factor					{ $$ = $1 * $3; printf("%d\n", $$);}
		|term DIV factor				{ $$ = $1 / $3; printf("%d\n", $$);}
    |term MOD factor {$$ = $1 % $3; printf("%d\n", $$);}
		|factor							{ $$ = $1; }
		;
factor:
		NUMBER							{$$ = $1; }
    |FloatNUMBER {printf("%f", yylval.floatValue);}
		|'(' exp ')'				{$$ = $2; }
    | VARIABLE { //int x = $1[0]-'a';
  //$$ = sym[x]; 
  for(int i=0; i<index; i++){
    if(strcmp(vari[i], $1)==0){
      $$ = sym[i]; 
      //printf("%d\n", sym[i]);
      break;
    }
  }
  }
