lexer grammar CommandLexer;

@lexer::members {
    boolean ignoreWhitespace = true;
}

ANY : .*? ;

QUOTE : '"' ;

WS : [ \t\r\n]+ { if(ignoreWhitespace) skip(); } ;

COMMA : ',' ;

SEMI : ';' ;

EQ : '=' ;

EQEQ : EQ EQ;

NEQ : '!=';

NLT : '!<';

NGT : '!>';

LT : '<' ;

GT : '>' ;

LTEQ : '<=' ;

GTEQ : '>=' ;

LPAREN : '(';

RPAREN : ')';

LSQBRACKET : '[';

RSQBRACKET : ']';

DOT : '.' ;

COLON : ':' ;

YANG_SEPARATOR : '$$' ;

GET_CMD : 'get' ENFORCE_WS ;

ACTION_CMD : 'action' ENFORCE_WS ;

CREATE_CMD : 'create' ENFORCE_WS ;

SET_CMD : 'set' ENFORCE_WS ;

DELETE_CMD : 'delete' ENFORCE_WS ;

DESCRIBE_CMD : 'describe' ENFORCE_WS ;

IMPORT_CMD : 'import' ENFORCE_WS ;

EXPORT_CMD : 'export' ENFORCE_WS -> mode(Export_mode) ;

VERSION_CMD : 'version' ;

STAR : '*' ;

NULL_VALUE : '<null>' ;


PERSISTED_ATTRIBUTES : '<p>' ;

PM_ATTRIBUTES : '<pm>' ;

CM_ATTRIBUTES : '<cm>' ;

HY : '-' | '\u2010' | '\u2011' | '\u2012' | '\u2013' | '\u2014';

STAR_WS : STAR ENFORCE_WS ;

PERSISTED_ATTRIBUTES_WS : PERSISTED_ATTRIBUTES ENFORCE_WS ;

PM_ATTRIBUTES_WS : PM_ATTRIBUTES ENFORCE_WS ;

CM_ATTRIBUTES_WS : CM_ATTRIBUTES ENFORCE_WS ;

BASIC_ID  : [a-zA-Z0-9_]([a-zA-Z0-9_] | HY)*;

NAMESPACE : HY ('ns' | HY? 'namespace') ;

VERSION :  HY ('v' | HY? 'version') ;

NETYPE : HY ('ne' | HY? 'netype' | HY? 'neType') ;

TABLE_OUTPUT : HY ('t' | HY? 'table') ;

LIST_OUTPUT : HY ('l' | HY? 'list') ;

ALL : HY HY? 'ALL' ;

LOWERCASE_ALL : HY HY? 'all';

COUNT : HY ('cn' | HY? 'count') ;

IMPORT_FILE_PREFIX : 'file' COLON;

CONFIGURATION : HY ('c' | HY? 'config') ;

FILE_TYPE_EQUALS : HY ('f' | HY? 'filetype') EQ;

JOB_STATUS : HY ('s' | HY? 'status') ;

JOB_ID_EQUALS : HY ('j' | HY? 'job') EQ;

JOB_DETAIL : HY ('d' | HY? 'detail') ;

JOB_NAME_EQUALS : HY ('jn' | HY? 'jobname') EQ;

NO_COPY : HY ('nc' | HY? 'nocopy') ;

ERROR : HY ('e' | HY? 'error') EQ;

INVALID_OPTION :  HY (HY? BASIC_ID) ;

FDN_ID : [a-zA-Z0-9 ?.!@$%^&*()/|_':-] ;

/**
 *  Ensure below definitions stays in this order as Antlr matching will use the first match from the Lexer
 */

FDN_IN_QUOTES : FDN_IN_SINGLE_QUOTES | FDN_IN_DOUBLE_QUOTES ;

FDN_IN_SINGLE_QUOTES : '\'' BASIC_ID EQ FDN_ID+ (COMMA BASIC_ID EQ FDN_ID+ )* '\'';

FDN_IN_DOUBLE_QUOTES : '"' BASIC_ID EQ FDN_ID+ (COMMA BASIC_ID EQ FDN_ID+ )* '"';

/**
 *  Ensure below definitions stays in this order as Antlr matching will use the first match from the Lexer
 */

STRING_IN_QUOTES : STRING_IN_SINGLE_QUOTES | STRING_IN_DOUBLE_QUOTES ;

STRING_IN_DOUBLE_QUOTES : '"' ANY '"' ;

STRING_IN_SINGLE_QUOTES : '\'' ANY '\'' ;

mode Export_mode;

    Export_ANY : ANY -> type(ANY) ;

    Export_QUOTE : QUOTE -> type(QUOTE) ;

    Export_WS : WS { if(ignoreWhitespace) skip(); else setType(WS); };

    Export_EQ : EQ -> type(EQ);

    Export_HY : HY -> type(HY);

    Export_SEMI : SEMI -> type(SEMI);

    Export_STAR : STAR -> type(STAR);

    Export_COMMA : COMMA -> type(COMMA);

    Export_DOT : DOT -> type(DOT) ;

    Export_STAR_WS : STAR_WS -> type(STAR_WS);

    Export_BASIC_ID : BASIC_ID -> type(BASIC_ID);

    Export_ALL : HY HY? 'ALL' -> type(ALL);

    FILE_TYPE_SPACE : HY ('ft' | HY 'filetype') ENFORCE_WS;

    NETWORK_ELEMENTS :  HY ('n' | HY 'ne') ENFORCE_WS;

    SOURCE_OPTION :  HY ('s' | HY 'source') ENFORCE_WS;

    FILTERNAME : HY ('fn' | HY 'filtername') ENFORCE_WS ;

    FILTERNAMESPACE : HY ('fns' | HY 'filternamespace') ENFORCE_WS ;

    FILTERVERSION :  HY ('fv' | HY 'filterversion') ENFORCE_WS ;

    JOB_DOWNLOAD : HY ('dl' | HY 'download') ;

    LIST_FILTERS : HY ('lf' | HY 'listfilters') ;

    REMOVE : HY ('rm' | HY 'remove') ;

    FILE_COMPRESSION : HY ('fc' | HY? 'filecompression') ;

    ENUM_TRANSLATE : HY ('et' | HY 'enumtranslate') ;

    JOB_ID_SPACE : HY ('j' | HY 'job') ENFORCE_WS;

    JOB_NAME_SPACE : HY ('jn' | HY? 'jobname') ENFORCE_WS;

    Export_JOB_STATUS : HY ('st' | HY 'status') -> type(JOB_STATUS);

    Export_JOB_DETAIL : HY ('v' | HY 'verbose') -> type(JOB_DETAIL);

    Export_INVALID_OPTION : INVALID_OPTION -> type(INVALID_OPTION);

    Export_FDN_ID : FDN_ID -> type(FDN_ID);

    Export_FDN_IN_QUOTES : FDN_IN_QUOTES -> type(FDN_IN_QUOTES);

    Export_STRING_IN_QUOTES : STRING_IN_QUOTES -> type(STRING_IN_QUOTES);

fragment ENFORCE_WS : { ignoreWhitespace = false; } WS { ignoreWhitespace = true; } ;
