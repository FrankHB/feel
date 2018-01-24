// Define a grammar called Hello
grammar Grammar;

program : statement+;

//stats : (statement ';')* ; // match zero or more ';'-terminatedstatements

//exprList : expr (',' expr)* ;

statement : define              
	  | expression
	  | NEWLINE
     ;

define:
ID Define INT Terminate
;
		  

//print:
//'print' '[' expr ']' ';';

expression : 
	mulDiv ((Add|Sub) mulDiv)* 
;

mulDiv: 
	atom ((Mul|Div) atom)* 
;

atom: '(' expression ')'
	  | INT
	  | ID
;

Terminate : ';';

Define : '=>';
Redefine: '<=';

Import : '<:';
Export : ':>';

Self : '^';

ArrowRight : '->';
ArrowLeft : '<-';

JudgeSub : '~?';
Judge : '?';

LoopSub : '~@';
Loop : '@';

ExcptionSub : '~!';
Excption : '!';

FunctionSub : '~$';
Function : '$';

PackageSub : '~#';
Package : '#';

ProtocolSub : '~|';
Protocol : '|';

Wave : '~';

ID   : [a-zA-Z]+; // ��ʶ�����ɶ����ĸ���
INT : '0'..'9' + ;  // ����
//Number  : [0-9]+('.'([0-9]+)?)?
//        | [0-9]+; // ����
NEWLINE:'\r' ? '\n' ; 

Mul  : '*';
Div  : '/';
Add  : '+';
Sub  : '-';

Comment : '/*' .*? '*/' -> skip;
CommentLine : '//' .*? '\r'? '\n' -> skip;

WS : ' ' -> skip;

//WS   : [ \t\r\n]+ -> skip; // �հף� �����->skip��ʾantlr4�ڷ������Ե��ı�ʱ�������������Ĵʷ���������
