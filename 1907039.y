%{
	#include <bits/stdc++.h>
    
    int yylex();
    int yywrap();
    int yyerror(char *s);
%}
%token ID WHOLENUMBER FRACTIONNUMBER OPERATION
%%
%union
{
    char *varName;
    char *varType;
    int intVal;
    float floatVal;
    char *stringVal;
};
start : 
    | start input
    ;
input : OPERATION { 
        printf("\n %s Variable, %s declared, value %d \n",yylval.varType,yylval.varName,yylval.intVal); 
    }
    ;
%%

int main(){
	FILE* yyin=fopen("input3.txt","r");
	yyparse();
	fclose(yyin);
	return 0;
}

int yyerror(char *s) {
     printf("%s\n",s); 
     return 0;
}