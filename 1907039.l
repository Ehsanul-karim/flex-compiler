%{
	#include <bits/stdc++.h>
	#include"1907039.tab.h"
	using namespace std;
	int varcnt = 0;
	int stmntcnt = 0;
	int headercnt = 0;
	int singlecommentcnt = 0;
	int multicommentcnt = 0;
	int printstmntcnt = 0;
	char s[10000];

	// a b c d e message, f, sum, i, multiline, names, index 
	
	int ifcnt = 0;
	int forcnt = 0;
	int keycnt = 0;
	map<string,int>m;
	vector<string> keyword_v = {"PURNO","VOGNO","SOBDO","SHARI","JOTOKHON","GHURO","JODI","NAHOLE","JODINA","DEKHAW","LIKHO"};
	vector<string> operator_v = {"JOG","BIYOG","GUNN","BHAGG","BHAGGSHES","SUCHOK","POROMMAN","HOCCHECHOTO","HOCCHEBORO","SOMAN","CHOTObaSOMAN","BORObaSOMAN","SOMANNOY","BARBEI","KOMBEI"};

	void keywordInitializer(){
		for(int i=0; i<keyword_v.size(); i++){
			m[keyword_v[i]]++;
		}
	}


	int findVariable(const char* name) {
			if (m[name]) {
				return -1;
			}
		return 1;
	}
	void addString(string str){
		string t = "";
		for(int i=str.size()-1;i>=0;i--){
			if(str[i]==' '){
				break;
			}
			t+=str[i];
		}
		reverse(t.begin(),t.end());
					if(m[t])
					{
						cout<<t<<" Declared Twice\n";
					}
					else
					{
						varcnt++;
						//cout<<"New String found Identifier "<<t<<endl;
						m[t]++;	
					}
	}

	void subtractName(string str)
	{
		string t ="";
			for(int i=0;i<str.size();i++){
				if(str[i]=='='){
					break;
				}
				t+=str[i];
			}
		size_t helloPos = t.find("PURNO");
		if (helloPos != string::npos) {
        helloPos +=5;
			while (helloPos < t.length() && isspace(t[helloPos])) {
            	helloPos++;
        	}
		}
		string afterHello = t.substr(helloPos);
		stringstream ss(afterHello);
        string word;
		ss >> word;
					if(m[word])
					{
						cout<<word<<" Declared Twice\n";
					}
					else
					{
						varcnt++;
						//cout<<"New integer or float Identifier "<<word<<endl;
						m[word]++;	
					}
	}

	void idSpliter(char* str){
		char *ptr; 
		ptr = strtok(str, " ,=;\"");
		    while (ptr != NULL)  
    		{  
				if( string(ptr) != "PURNO" && string(ptr) != "VOGNO") 
				{
					if(isdigit(ptr[0]))
					{
						ptr = strtok (NULL, " ,=;\""); 
						continue;
					}

					if(findVariable(ptr)==1)
					{
						varcnt++;
						//cout<<"New integer or float Identifier "<<ptr<<endl;
						m[ptr]++;
					}
					else
					{
						cout<<ptr<<" Declared Twice\n";
					}
				}
				ptr = strtok (NULL, " ,=;\""); 
    		}
	}
	void findArray(string str)
	{
		string t ="";
			for(int i=0;i<str.size();i++){
				if(str[i]=='='){
					break;
				}
				t+=str[i];
			}
		size_t helloPos = t.find(" ");
		if (helloPos != string::npos) {
        helloPos +=1;
			while (helloPos < t.length() && isspace(t[helloPos])) {
            	helloPos++;
        	}
		}
		string afterHello = t.substr(helloPos);
		stringstream ss(afterHello);
        string word;
		ss >> word;
		if(m[word])
					{
						cout<<word<<" Declared Twice\n";
					}
					else
					{
						varcnt++;
						//cout<<"New Array found"<<word<<endl;
						m[word]++;	
					}
	}

	void printALL()
	{
		cout<<"-----------------------------TOTAL--------------------------------\n";
		cout<<"Total Variable "<<varcnt<<"\n";
		cout<<"Total Stament "<<stmntcnt<<"\n";
		cout<<"Total keyword "<<keycnt<<"\n";
		cout<<"Total header "<<headercnt<<"\n";
		cout<<"Total Single_Line_Comment "<<singlecommentcnt<<"\n";
		cout<<"Total Multi_Line_Comment "<<multicommentcnt<<"\n";
		cout<<"Number of print Statement "<<printstmntcnt<<"\n";

	}

%}

ID [a-zA-Z][a-zA-Z0-9]*[_]?[a-zA-Z0-9]*
WHOLENUMBER [+-]?[0-9]+
FRACTIONNUMBER [+-]?[0-9]+[.][0-9]+
STRINGLITERAL \"[^\"]*\"
header	"AMDANI"[ ]+[^\n]+[.h][ ]*[\n]
OPERATOR  "JOG"|"BIYOG"|"GUNN"|"BHAGG"|"BHAGGSHES"|"SUCHOK"|"POROMMAN"|"HOCCHECHOTO"|"HOCCHEBORO"|"SOMAN"|"CHOTObaSOMAN"|"BORObaSOMAN"|"SOMANNOY"|"BARBEI"|"KOMBEI"|"="|"!"|"&&"|"||"|"&"|"|"
KEYWORD "PURNO"|"VOGNO"|"SOBDO"|"SHARI"|"JOTOKHON"|"GHURO"|"JODI"|"NAHOLE"|"JODINA"|"DEKHAW"|"LIKHO"|"SOMANNOY"|"NOTE"
NUMBERKEYWORD "PURNO"|"VOGNO"
UNARYOPERATOR "BARBEI"|"KOMBEI"
VALUES {WHOLENUMBER}|{FRACTIONNUMBER}
MKEYWORD "SOBDO"
LKEYWORD {NUMBERKEYWORD}|{MKEYWORD}
IFORIFELSE "JODI"|"JODINA"
IDOFINDEX {ID}[ ]*\[[ ]*{ID}[ ]*\]
IDORNUMBER {ID}|{VALUES}|{STRINGLITERAL}|{IDOFINDEX}
NEWVALUES {VALUES}|{STRINGLITERAL}
UNARYOPERATION {ID}[ ]*{UNARYOPERATOR}|{UNARYOPERATOR}[ ]*{ID}
CONDITIONITIS "("?[ ]*{IDORNUMBER}[ ]+{OPERATOR}[ ]+{IDORNUMBER}[ ]*")"?
INITIAZITION   ({NUMBERKEYWORD}[ ]+)?{ID}[ ]*=[ ]*{VALUES}([ ]*,{ID}[ ]*=[ ]*{VALUES})*
OPERATION ({ID}[ ]*=[ ]*{IDORNUMBER}([ ]*{OPERATOR}[ ]*{IDORNUMBER}[ ]*)*)|{UNARYOPERATION}


%%
"STARTMAIN"	    {printf("Start Main Function Started\n");}
"ENDMAIN"		{printf("END Main Function Started\n");}
{header}	{printf("Derivatives\n"); headercnt++;}
{NUMBERKEYWORD}[ ]+{ID}([ ]*=[ ]*{VALUES})?([ ]*,[ ]*{ID}([ ]*=[ ]*{VALUES})?)* { 
				idSpliter(yytext);
				keycnt++;
 			}
"SHARI::"{LKEYWORD}[ ]+{ID} {
		findArray(yytext);
		keycnt++;
		keycnt++;
}
{NUMBERKEYWORD}[ ]+{ID}[ ]*=[ ]*{IDORNUMBER}[ ]*{OPERATOR}[ ]*{IDORNUMBER} {
	subtractName(yytext);
	keycnt++;
}
{MKEYWORD}[ ]+{ID} {
		addString(yytext);
		keycnt++;
}
{IFORIFELSE}[ ]*{CONDITIONITIS}[ ]* {
	//cout<<"A Conditiona block"<<endl;
	keycnt++;
	stmntcnt++;
}
"NAHOLE"[ ]* {
	//cout<<"A Conditiona block"<<endl;
	keycnt++;
}
"JOTOKHON"[ ]+{CONDITIONITIS}; {
	//cout<<"While Loop Block\n";
	keycnt++;
}
"DEKHAW"[ ]+{STRINGLITERAL}([ ]*JOG[ ]+{IDORNUMBER}([ ]*JOG[ ]+{STRINGLITERAL})?)* { 
	//cout<<"Printf Statement"<<endl;
	keycnt++;
	printstmntcnt++;
	}
"LIKHO"[ ]*{ID}([ ]*,[ ]*{ID})* {
	stmntcnt++;
	keycnt++;
}
"GHURO"[ ]+{INITIAZITION}[ ]*;{CONDITIONITIS}[ ]*;[ ]*{OPERATION};	{
	//cout<<"For Loop Block\n";
	stmntcnt++;
	keycnt++;
	}
"{"
"}"
{OPERATION} 
{KEYWORD} {keycnt++;}
{OPERATOR} 

"{"[ ]*{NEWVALUES}([ ]*,[ ]*{NEWVALUES}[ ]*)*"}" {
		//cout<<"Array elements are"<<yytext<<endl;
	}
\"[^\"]*\"    {
    		//printf ("Single Literal %s\n",yytext);
		}
[<]{WHOLENUMBER}[>] {
	//cout<<"Array Size is "<<yytext<<endl;
	}

[ \t\n]+        
"NOTE"(.)*"\n"   { 
	//printf("SINGLE_LINE_COMMENT: %s\n",yytext); 
	singlecommentcnt++; 
	}
"NOTE"[*](.*|\n)*[*]"NOTE" { 
	//printf("MULTI_LINE_COMMENT: %s\n",yytext); 
	multicommentcnt++; 
	}
[ ]*";"[ ]*	{stmntcnt++;}
.              { 
		printf("INVALID_CHARACTER: %s\n", yytext); 
	}

%%

int yywrap(){
	return 1;
}