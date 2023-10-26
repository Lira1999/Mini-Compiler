
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ADD = 258,
     MINUS = 259,
     ASSIGN = 260,
     MUL = 261,
     DIV = 262,
     MOD = 263,
     END = 264,
     PRINT = 265,
     IF = 266,
     ELSE = 267,
     ELSEIF = 268,
     FOR = 269,
     INC = 270,
     DEC = 271,
     COPYSTRING = 272,
     CONCAT = 273,
     LENGTHSTRING = 274,
     COMMENT = 275,
     EQ = 276,
     LIBRARY = 277,
     MAIN = 278,
     TB = 279,
     TBE = 280,
     SB = 281,
     SBE = 282,
     FB = 283,
     FBE = 284,
     GT = 285,
     GTE = 286,
     LT = 287,
     LTE = 288,
     INTEGER = 289,
     FLOAT = 290,
     LONGFLOAT = 291,
     CHAR = 292,
     STRING = 293,
     FloatNUMBER = 294,
     VARIABLE = 295,
     NUMBER = 296
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 12 "flex29.y"

    int intValue;
    float floatValue;
    char str[100];



/* Line 1676 of yacc.c  */
#line 101 "flex29.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


