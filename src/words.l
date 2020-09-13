%{
	#include <stdio.h>
	#include <stdlib.h>
%}

/* Types and Stuff */
%%
^[-+]?[0-9]+	 	{printf("'%s' = Integer\n", yytext);}
^[-+]?[0-9]*[.][0-9]+	{printf("'%s' = Float\n", yytext);}
([a-zA-Z0-9])* 	 	{printf("'%s' = String\n", yytext);}
"// exit"	 	{return 0;}
.	 		{printf("'%s' = Other\n", yytext);}
%%

int yywrap(void) {}

int main(int argc, char* argv[]) {
    FILE *fh;

    if (argc == 2 && (fh = fopen(argv[1], "r")))
        yyin = fh;
	printf("Welcome! (use '// exit' or Control-C to exit program)\n-------------\n");
    yylex();
    return 0;
}
