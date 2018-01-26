// Define a grammar called Hello
grammar Grammar;

program : statement+;

//stats : (statement ';')* ; // match zero or more ';'-terminatedstatements

//exprList : expr (',' expr)* ;

statement :
 exportStatement
| importStatement
| packageStatement
| functionMainStatement
| functionStatement
| invariableStatement
| judgeWithElseStatement
| judgeStatement
| loopStatement
| printStatement
;		  

printStatement:'print' '(' Text ')' Terminate;

expression : 
	mulDiv ((Add|Sub) mulDiv)* 
;

mulDiv: 
	atom ((Mul|Div) atom)* 
;

atom: '(' expression ')'
	  | Number
	  | ID
;

// ���������ռ�
exportStatement:
Export ID BlockLeft (statement)* BlockRight Terminate
;
// ���������ռ�
importStatement:
Import BlockLeft (nameSpaceStatement)* BlockRight Terminate
;
// �����
packageStatement:
ID Define Package BlockLeft (statement)* BlockRight Terminate
;
// ������
functionMainStatement:
Main Define Function BlockLeft (statement)* BlockRight Terminate
;
// ����
functionStatement:
ID Define Function parameterClause Wave basicType BlockLeft (statement)* BlockRight Terminate
;

parameterClause : '(' parameterList ')'  ;
parameterList : basicType? (',' basicType)* ;
// ���岻����
invariableStatement:
ID Define dataStatement Terminate
;
// ��else���ж�
judgeWithElseStatement:
judgeBaseStatement JudgeSub BlockLeft (statement)* BlockRight Terminate
;
// �ж�
judgeStatement:
judgeBaseStatement Terminate
;
// �жϻ���
judgeBaseStatement:
Judge bool BlockLeft (statement)* BlockRight
;
// ѭ��
loopStatement:
Loop Number '..' Number BlockLeft (statement)* BlockRight Terminate
;
// �����ռ�
nameSpaceStatement:
ID Terminate
;

blockStatement:
BlockLeft (statement)* BlockRight
;

assign: ID '=' expression
;

// ��������
dataStatement:
t=Number
| t=Text
| t=True
| t=False
;
// ����������
basicType:
t=TypeNumber
| t=TypeText
| t=TypeBool
;
// boolֵ
bool:t=True|t=False;

Terminate : ';';

BlockLeft : '{';
BlockRight : '}';

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

TypeNumber: 'number';
TypeText: 'text';
TypeBool: 'bool';
True: 'true';
False: 'false';

Main: 'Main';


Number :DIGIT+ ('.' DIGIT+)?; // ����
fragment DIGIT : [0-9] ;             // ��������
Text: '"' (~[\\\r\n])*? '"'; //�ı�
ID   : [a-zA-Z]+; // ��ʶ�����ɶ����ĸ���

Mul  : '*';
Div  : '/';
Add  : '+';
Sub  : '-';

Comment : '/*' .*? '*/' -> skip; // �ṹע��
CommentLine : '//' .*? '\r'? '\n' -> skip; // ��ע��

//WS : ' ' -> skip;

WS   : [ \t\r\n]+ -> skip; // �հף� �����->skip��ʾantlr4�ڷ������Ե��ı�ʱ�������������Ĵʷ���������
