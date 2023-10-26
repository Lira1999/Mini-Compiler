%{
#include "flex29.tab.h"
#include <stdio.h>
#include <string.h>
%}

variable [a-z]+[A-Z]*[0-9]*|[a-z]*[A-Z]+[0-9]*|[A-Z]+[a-z]*[0-9]*
number [0-9]+

%%

[/][*] {
	printf("%s", yytext);
	char c = input();
	while(c!='*'){
		printf("%c", c);
		c=input();
		if(c=='*')
		{
			printf("%c", c);
		}
	}
	c=input();
	if(c=='/'){
		printf("%c", c);
	}
}

"int actual" return MAIN;
includeLibrary return LIBRARY;

"add" return ADD;
"minus" return MINUS;
"X" return MUL;
"div" return DIV;
[_] return MOD;

"Int" {
 return INTEGER;
}
"Float" return FLOAT;
"LongFloat" return LONGFLOAT;
"Char" return CHAR;
"String" return STRING;

gt return GT;
lt return LT;
gte return GTE;
lte return LTE;
eq return EQ;

"inc" return INC;
"dec" return DEC;
"copyString" return COPYSTRING;
concatString return CONCAT;
measure return LENGTHSTRING;

{number}*[.]{number}+ {
  yylval.floatValue = atof(yytext);
  return FloatNUMBER;
}
{number} {
  yylval.intValue = atoi(yytext);
  return NUMBER;
}
[a-zA-Z0-9]+ {
  strcpy(yylval.str, yytext);
  return VARIABLE;
}
# return IF;
## return ELSEIF;
!# return ELSE;
[%][.]{3}[%] return FOR;
[+]{3} return TB;
[|]{3} return TBE;
[+]{2} return SB;
[|]{2} return SBE;
[+] return FB;
[|] return FBE;
[-][>] return ASSIGN;
"..." return END;
"@@" return PRINT;
[,]	return(*yytext);
[*] return(*yytext);	
[:] return(*yytext);	
[\n]
[.]

%%

int yywrap()
{
  return 1;
}

int main()
{
  yyin = freopen("input1.txt", "r", stdin);
  yyout = freopen("output1.txt", "w", stdout);
	yyparse();
	return 0;
}

void yyerror (char const *s)
{
  
	fprintf (stderr, "%s\n", s);
}