/* MacaoScript v1.0
	Written by Angel Carias.
	Licensed under GNU General Public License v3.
	2020.
*/
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <stdbool.h>
	int charnum = 1;
	int lineno = 1;
	bool interpreter = false;
%}

/* Types and Special Commands
	Note: Operators go first to avoid conflict with negative/positive integers
		  and "+" and "-" signs.
*/
%%
"+"|"-"|"/"|"*"	 {printf("char %d at line %d |'%s' = Operator\n", charnum, lineno, yytext); charnum++;}
[+-]?[0-9]+*	 {printf("char %d at line %d |'%s' = Integer\n", charnum, lineno, yytext); charnum++;}
[+-]?([0-9]*[.])?[0-9]+	 {printf("char %d at line %d |'%s' = Float\n", charnum, lineno, yytext); charnum++;}
([a-zA-Z0-9])* 	 {printf("char %d at line %d |'%s' = String\n", charnum, lineno, yytext); charnum++;}
"// exit"		{if (interpreter) {return 0;}}
.	 {printf("char %d at line %d |'%s' = Other\n", charnum, lineno, yytext); charnum++;}
\n	 {lineno++;}

%%

int yywrap(void) {}

void setupInterpret() {
	interpreter = true;
	printf("MacaoScript v0.01a\n");
	printf("(Press '// exit' or Control-C to exit program)\n");
	printf("--------------------------------------------------\n");
	return ;
}

int main(int argc, char* argv[]) {
    // Declare a variable of type FILE
	FILE *fh;
	
	// Check if argc (amount of arguments) is 2
	if (argc == 2) {
		// If True, check if the condition can apply
		// Access file specified in argument 2; in read mode
		if (fh = fopen(argv[1], "r")) {
			// If True, make Lex use the contents of such file as input.
			yyin = fh;
		} else {
			// If False, make Macao throw an error and continue.
			printf("macao.FileNotFoundError: Could not find %s. Defaulting to interpreter.\n", argv[1]);
			setupInterpret();
		}
	} else {
		// If nothing above applies, make it run an interpreter.
		setupInterpret();
	}
    yylex();
	printf("Characters: %d | Lines: %d", charnum, lineno);
    return 0;
}