grammar GerbilScript;

start : stat+ ;

stat : declarationStat ';'
     | functionDeclaration
     | expr ';'
     | ';'
     | block
     | returnStatement
     | breakStatement
     | yieldStatement
     | controlBlock
     | classDefinition
     ;

block : '{' stat* '}' ;

declarationStat : ('var' | type) multiAssignment 
                | ('var' | type) ID
                ;

functionDeclaration 
  : 'function' ID '(' parameters? ')' returnType?  '{' stat* '}' ;

anonymousFunctionDeclaration
  : 'function' '(' parameters? ')' returnType? '{' stat* '}' ;

returnType : ':' type;

type : reference ;

returnStatement : 'return' expr ';' ;

breakStatement : 'break' ';' ;

yieldStatement : 'yield' expr? ';' ;

classDefinition
  : 'class' ID ('extends' reference)? '{' classMember* '}' ;

classMember
  : visibility? declarationStat ';'
  | visibility? methodDeclaration
  | visibility ? accessorDeclaration
  ;

methodDeclaration : type? ID '(' parameters? ')' block ;

// Don't mark 'get' and 'set' as keywords, because we
// don't want to prevent them from being identifiers.
accessorDeclaration : type? ID '{' (ID (block|';'))+ '}' ;

visibility : 'public' | 'private' ;

controlBlock
  : ifStatement
  | whileLoop
  | forLoop
  | forInLoop
  | doWhileLoop
  | switchStatement
  | tryCatchStatement
  | withStatement
  ;

ifStatement : 'if' '(' expr ')' stat;
whileLoop : 'while' '(' expr ')' stat;
forLoop : 'for' '(' (declarationStat | multiAssignment)? ';' expr? ';' expr? ')' stat;
forInLoop : 'for' '(' ID 'in' expr ')' stat;
doWhileLoop : 'do' block 'while' '(' expr ')' ';' ;
switchStatement : 'switch' '(' expr ')' '{' switchCase* '}';
withStatement : 'with' '(' expr ('as' ID)? ')' stat;

switchCase : 'case' expr ':' stat* 
           | 'default' ':' stat* 
           ;

tryCatchStatement
  : 'try' block (catchClause | finallyClause)
  | 'try' block catchClause finallyClause
  ;

catchClause 
  : 'catch' '(' ID ')' block
  | 'catch' block
  ;

finallyClause : 'finally' block ;

multiAssignment : assignmentStat (',' assignmentStat)* ;

assignmentStat
  : reference '=' expr
  | reference '*=' expr
  | reference '/=' expr
  | reference '+=' expr
  | reference '-=' expr
  | reference '~=' expr
  | reference '^=' expr
  | reference '**=' expr
  | reference '++'
  | reference '--'
  ;

expr : '(' expr ')'
     | expr dereference+
     | '-' expr
     | '!' expr
     | '~' expr
     | expr ('**' | '.**') expr
     | expr ('^' | '.^') expr
     | expr ('*' | '.*') expr
     | expr ('/' | './') expr
     | expr ('+' | '.+') expr
     | expr ('-' | '.-') expr
     | expr ('%' | '.%') expr
     | expr '?' expr ':' expr
     | expr '>>' expr
     | expr '<<' expr
     | expr 'instanceof' expr
     | expr '&&' expr
     | expr '||' expr
     | expr '&' expr
     | expr '|' expr
     | expr ('===' | '!==') expr
     | expr ('==' | '!=') expr
     | expr ('<' | '<=') expr
     | expr ('>' | '>=') expr
     | jsonArray
     | jsonDictionary
     | literal 
     | ID
     | anonymousFunctionDeclaration
     | assignmentStat
     ;

jsonArray : '[' expr? ','? ']'
          | '[' expr (',' expr)* ','? ']'
          ;

jsonDictionary : '{' jsonKVPair? ','? '}'
               | '{' jsonKVPair (',' jsonKVPair)* ','? '}'
               ;

jsonKVPair : (literal | ID) ':' expr ;

reference : ID dereference* ;

dereference
  : '.' ID       # MemberDereference
  | '[' arguments ']' # ArrayDereference
  | '[' slices ']' # ArraySlice
  | '(' arguments? ')' # MethodCall
  ;

arguments : expr (',' expr)* ;
slices : slice (',' slice)* ;
slice : expr ':' expr? 
      | ':' expr
      | ':'
      | expr
      ;

parameters : type? ID defaultValue? (',' type? ID defaultValue? )* ;

defaultValue : '=' expr ;

literal : STRING | number | 'undefined' | 'null' ;
number : BIN_INT | OCT_INT | TER_INT | PLAIN_NUMBER | COLOR_INT ;


STRING : DQ (ESC | ~'"')*? DQ
       | SQ (ESC | ~'\'')*? SQ
       ;
fragment ESC : BS DQ | BS SQ | BS BS | BS [tnbar] ;
fragment DQ : '"';
fragment SQ : '\'';
fragment BS : '\\' ;

ID : [$_a-zA-Z] [$_a-zA-Z0-9]* ;

PLAIN_NUMBER : FLOAT | INT | HEX_INT;

fragment INT : '0' | [1-9] [0-9]* ;
fragment FLOAT : [0-9]+ '.' [0-9]*
               | '.' [0-9]+
               ;
fragment HEX_INT : '0x' [0-9A-Fa-f]+ ;

// Number formats not in vanilla JS
BIN_INT : '0b' [0-1]+ ;
TER_INT : '0t' [0-2]+ ;
OCT_INT : '0o' [0-7]+ ;
COLOR_INT : '#' [0-9A-Fa-f]+ ;

WS : [ \t\r\n] -> skip ;
LINE_COMMENT : '//' ~[\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;

