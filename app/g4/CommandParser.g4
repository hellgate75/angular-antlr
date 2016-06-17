parser grammar CommandParser;

options { tokenVocab=CommandLexer; }

// Labels (the bits at the end of rules with '#') should end with the suffix 'Subrule'.
// e.g
// # networkElementScopeSubrule
// # networkElementNameEqualsSubrule

command :
    (createCommand | getCommand | setCommand | deleteCommand | actionCommand | describeCommand | importCommand | exportCommand | versionCommand) EOF
;

/**
 *  C R E A T E - C O M M A N D
 */

createCommand :
    CREATE_CMD (createCommandScope COMMA)? createObjectSpecification createCommandOptions*
;

createCommandScope :
    fdn
;

createObjectSpecification :
    typeToCreate EQ name attributeSettersList?
;

typeToCreate :
    type  |
    type (YANG_SEPARATOR type)+
;


createCommandOptions :
	nameSpaceAndVersionRule | configuration | outputFormat | invalidOption
;

/**
 *  G E T - C O M M A N D
 */

getCommand :
    GET_CMD (getByFdn | getByQuery )
;

getByFdn :
    fdnList validOptionsForGetByFdn*
;

getByQuery :
    scopeList cmObjectSpecificationList cmOutputSpecifications? validOptionsForGetByQuery*
;

validOptionsForGetByFdn :
     configuration | outputFormat | invalidOption
;

validOptionsForGetByQuery :
     namespace | version | neType | configuration | outputFormat | countFlag | invalidOption
;

/**
 *  S E T - C O M M A N D
 */

setCommand :
   SET_CMD (setByFdn | setByQuery)
;

setByFdn :
    fdnList attributeSettersList validOptionsForSetByFdn*
;

setByQuery :
    scopeList cmObjectSpecificationList attributeSettersList validOptionsForSetByQuery*
;

validOptionsForSetByFdn :
     configuration | outputFormat | invalidOption
;

validOptionsForSetByQuery :
    namespace | version | neType | configuration | outputFormat | invalidOption
;

/**
 *  D E L E T E - C O M M A N D
 */

deleteCommand :
   DELETE_CMD (deleteByQuery | deleteByFdn)
;

deleteByFdn :
    fdnList validOptionsForDeleteByFdn*
;

deleteByQuery :
    scopeList (deleteObjectSpecification | (cmObjectSpecificationList typeForDeletion)) validOptionsForDeleteByQuery*
;

validOptionsForDeleteByQuery :
	allFlag | configuration | mandatoryNameSpaceAndOptionalVersionRule | outputFormat | invalidOption
;

validOptionsForDeleteByFdn :
    allFlag | configuration | outputFormat | invalidOption
;

deleteObjectSpecification :
    type (DOT attributeSpecification)?
;

typeForDeletion :
    BASIC_ID
;

/**
 *  A C T I O N - C O M M A N D
 */

actionCommand :
    ACTION_CMD (actionByFdn | actionByQuery)
;

actionByFdn :
    fdnList actionSpecification validOptionsForActionByFdn*
;

actionByQuery :
    scopeList actionObjectSpecification actionSpecification validOptionsForActionByQuery*
;

actionObjectSpecification :
    type (DOT attributeSpecification)?
;

actionSpecification :
    BASIC_ID
    |
    BASIC_ID (DOT attributeSetter)
    |
    BASIC_ID (DOT LPAREN attributeSettersList RPAREN)
    |
    BASIC_ID DOT actionSpecificationMissingClosingParentheses
    |
    BASIC_ID DOT actionSpecificationTooManyParentheses
;

actionSpecificationMissingClosingParentheses:
    LPAREN attributeSettersList
;

actionSpecificationTooManyParentheses:
    LPAREN LPAREN+ attributeSettersList RPAREN+ RPAREN
    |
    LPAREN attributeSettersList RPAREN+ RPAREN
    |
    LPAREN LPAREN+ attributeSettersList RPAREN
;

validOptionsForActionByQuery :
    namespace | version | neType | outputFormat | invalidOption
;

validOptionsForActionByFdn :
    outputFormat | invalidOption
;

 /**
 *  D E S C R I B E - C O M M A N D
 */

describeCommand :
    DESCRIBE_CMD (describeMo | describeNeType)
;

describeMo :
    describeObjectSpecification  (SEMI describeObjectSpecification)*  validOptionsForDescribeCommand*
;

describeNeType :
    describeAllNeTypes | NETYPE BASIC_ID | NETYPE EQ BASIC_ID | getAllNeTypesForDescribe
;

describeAllNeTypes :
    NETYPE ALL | NETYPE LOWERCASE_ALL
;

getAllNeTypesForDescribe :
    NETYPE
;

describeObjectSpecification :
    wildcardType (DOT describeAttributeSpecification)?
;

wildcardType :
    type
    |
    type (STAR | STAR_WS)
    |
    STAR type
    |
    STAR type (STAR | STAR_WS)

;

describeAttributeSpecification :
    allAttributes
    |
    attributeName
    |
    ( LPAREN attributeName (COMMA attributeName )*  RPAREN )
    |
    attributeNameListMissingClosingParentheses
    |
    attributeNameListTooManyParentheses
;

attributeNameListMissingClosingParentheses :
    LPAREN attributeName (COMMA attributeName )*
;

attributeNameListTooManyParentheses :
    LPAREN LPAREN+ attributeName (COMMA attributeName )*  RPAREN+ RPAREN
    |
    LPAREN attributeName (COMMA attributeName )*  RPAREN+ RPAREN
    |
    LPAREN LPAREN+ attributeName (COMMA attributeName )*  RPAREN
;

validOptionsForDescribeCommand :
    (namespace | version | allModelVersionsFlag | neType | outputFormat | invalidOption)
;

/**
 *  E X P O R T - C O M M A N D
 */

exportCommand :
    EXPORT_CMD (runExport | getJobStatus | downloadExport | listFilters | removeJob)
;

runExport :
    runExportOptions* networkElements runExportOptions*
;

networkElements :
    NETWORK_ELEMENTS scopeList
;

runExportOptions :
    fileType | sourceConfigOption | filterTuple | jobName | fileCompression | enumTranslate | invalidOption
;

filterTuple :
    filterNamespace? filterName filterVersion?
;

sourceConfigOption :
    SOURCE_OPTION BASIC_ID
;

downloadExport:
   downloadExportOptions*
;

downloadExportOptions :
    jobDownload | jobIdentifier | invalidOption
;

jobDownload :
    JOB_DOWNLOAD
;

listFilters :
    LIST_FILTERS
;

removeJob:
    (REMOVE jobIdentifier) | (jobIdentifier REMOVE)
;

filterNamespace :
    FILTERNAMESPACE BASIC_ID
;
filterName :
    FILTERNAME BASIC_ID
;

filterVersion :
    FILTERVERSION versionValue
;

fileCompression :
    FILE_COMPRESSION BASIC_ID
;

enumTranslate :
    ENUM_TRANSLATE BASIC_ID
;

/**
 *  I M P O R T - C O M M A N D
 */

importCommand :
    IMPORT_CMD (runImport | getJobStatus)
;

runImport :
    IMPORT_FILE_PREFIX fileName validOptionsForImportCommand*
;

validOptionsForImportCommand :
    fileType | configuration | noCopy | error | invalidOption
;

noCopy :
    NO_COPY
;

error :
    ERROR BASIC_ID
;

/**
*  I M P O R T / E X P O R T - C O M M O N
*/

getJobStatus :
   jobStatusOptions*
;

jobStatusOptions :
    jobStatus | jobIdentifier | jobDetail | invalidOption
;

jobIdentifier :
    jobId | jobName
;

jobStatus :
    JOB_STATUS
;

/* TODO this can be reverted back to 'JOB_ID EQ BASIC_ID' once
 * export is extracted from cmedit : TORF-89317
 */
jobId :
    JOB_ID_EQUALS BASIC_ID
    |
    JOB_ID_SPACE BASIC_ID
;

/* TODO this can be reverted back to 'JOB_NAME EQ BASIC_ID' once
 * export is extracted from cmedit : TORF-89317
 */
jobName :
    JOB_NAME_EQUALS BASIC_ID
    |
    JOB_NAME_SPACE BASIC_ID
;

jobDetail :
    JOB_DETAIL
;

/**
 *  V E R S I O N - C O M M A N D
 */

versionCommand :
     VERSION_CMD
;

/**
 *  F I L E - R U L E S
 */

fileName :
    BASIC_ID (DOT BASIC_ID)*
;


/* TODO this can be reverted back to 'FILE_TYPE EQ BASIC_ID' once
 * export is extracted from cmedit : TORF-89317
 */
fileType :
    FILE_TYPE_EQUALS BASIC_ID
    |
    FILE_TYPE_SPACE BASIC_ID
;

/**
 *  S C O P E - R U L E S
 */

// export command uses scopeList
scopeList :
    scope (SEMI scope)*
;

scope :
    networkElementName # networkElementScopeSubrule
    |
    fdn # fdnScopeSubrule
    |
    ((STAR EOF) | STAR_WS) # anyNodeScopeSubrule
;

// check for bugs here, likely some
networkElementName :
   extendedId # networkElementNameEqualsSubrule
   |
   extendedId (STAR_WS | STAR) # networkElementNameStartsWithSubrule
   |
   STAR extendedId # networkElementNameEndsWithSubrule
   |
   STAR extendedId (STAR_WS | STAR) # networkElementNameContainsSubrule
   |
   STRING_IN_QUOTES # networkElementNameInQuotesEqualsSubrule
   |
   STRING_IN_QUOTES (STAR_WS | STAR) # networkElementNameInQuotesStartsWithSubrule
   |
   STAR STRING_IN_QUOTES # networkElementNameInQuotesEndsWithSubrule
   |
   STAR STRING_IN_QUOTES (STAR_WS | STAR) # networkElementNameInQuotesContainsSubrule
;

rdn :
    BASIC_ID EQ BASIC_ID
    |
    BASIC_ID EQ FDN_ID+
;

fdn :
    rdn (COMMA rdn)*
    |
    FDN_IN_QUOTES
;

fdnList :
    fdn (SEMI fdn)*
;

/**
 *  O B J E C T - S P E C I F I C A T I O N
 */

cmObjectSpecificationList :
    cmObjectSpecification (SEMI cmObjectSpecification)*
;

cmObjectSpecification :
    type (DOT attributeSpecification)? (COMMA cmObjectSpecificationChildren)?
;

cmObjectSpecificationChildren:
    allTypes
    |
    cmObjectSpecification
    |
    LPAREN cmObjectSpecificationList RPAREN
    |
    LPAREN allTypes RPAREN
    |
    cmObjectSpecificationChildrenMissingClosingParentheses
    |
    cmObjectSpecificationChildrenTooManyParentheses
;

cmObjectSpecificationChildrenMissingClosingParentheses:
    LPAREN cmObjectSpecificationList
    |
    LPAREN allTypes
;

cmObjectSpecificationChildrenTooManyParentheses:
    LPAREN LPAREN+ cmObjectSpecificationList RPAREN+ RPAREN
    |
    LPAREN LPAREN+ allTypes RPAREN+ RPAREN
    |
    LPAREN cmObjectSpecificationList RPAREN+ RPAREN
    |
    LPAREN allTypes RPAREN+ RPAREN
    |
    LPAREN LPAREN+ cmObjectSpecificationList RPAREN
    |
    LPAREN LPAREN+ allTypes RPAREN
;

/**
 *  A T T R I B U T E - R U L E S
 */

attributeSetter :
    attributeNameValue
;

attributeSettersList :
   attributeNameValue ((SEMI | COMMA) attributeNameValue)*
;

attributeNameValue :
   (attributeType DOT)? attributeName EQ attributeValue
;

attributeType :
    BASIC_ID
;

attributeName :
    BASIC_ID
;

attributeValue :
    NULL_VALUE # nullAttributeValueSubrule
	|
    simpleAttributeValue # simpleAttributeValueSubrule
    |
    complexAttributeValue # complexAttributeValueSubrule
    |
    LSQBRACKET simpleAttributeValue (COMMA simpleAttributeValue)* RSQBRACKET # simpleAttributeValueSequenceSubrule
    |
    LSQBRACKET complexAttributeValue (COMMA complexAttributeValue)* RSQBRACKET # complexAttributeValueSequenceSubrule
    |
    LSQBRACKET RSQBRACKET # emptySequenceSubrule
    |
    attributeValueSequenceTooManyBrackets # attributeValueSequenceTooManyBracketsSubrule
    |
    attributeValueSequenceMissingClosingBrackets # attributeValueSequenceMissingClosingBracketsSubrule
    |
    complexAttributeValueSequenceMissingClosingBrackets # complexAttributeValueSequenceMissingClosingBracketsSubrule
;

simpleAttributeValue :
   extendedId # idAttributeValueSubrule
   |
   FDN_IN_QUOTES # fdnInQuotesAttributeValueSubrule
   |
   STRING_IN_QUOTES # stringAttributeValueSubrule
;

// note re-use of #allAttributesSubrule and #attributeFilterSubrule
attributeSpecification :
    allAttributes # allAttributesSubrule
    |
    LPAREN allAttributes RPAREN # allAttributesSubrule
    |
    persistedAttributes # persistedAttributesSubrule
    |
    LPAREN persistedAttributes RPAREN # persistedAttributesSubrule
    |
    pmAttributes # pmAttributesSubrule
    |
    LPAREN pmAttributes RPAREN # pmAttributesSubrule
    |
    cmAttributes # cmAttributesSubrule
    |
    LPAREN cmAttributes RPAREN # cmAttributesSubrule
    |
    attributeFilter # attributeFilterSubrule
    |
    LPAREN attributeFilter (COMMA attributeFilter)*  RPAREN # attributeFilterSubrule
    |
    attributeSpecificationMissingClosingParentheses # attributeSpecificationMissingClosingParenthesesSubRule
    |
    attributeSpecificationTooManyParentheses # attributeSpecificationTooManyParenthesesSubRule
;

attributeSpecificationTooManyParentheses :
    LPAREN LPAREN+ allAttributes RPAREN+ RPAREN
    |
    LPAREN LPAREN+ persistedAttributes RPAREN+ RPAREN
    |
    LPAREN LPAREN+ pmAttributes RPAREN+ RPAREN
    |
    LPAREN LPAREN+ cmAttributes RPAREN+ RPAREN
    |
    LPAREN LPAREN+ attributeFilter (COMMA attributeFilter)*  RPAREN+ RPAREN
    |
    LPAREN allAttributes RPAREN+ RPAREN
    |
    LPAREN persistedAttributes RPAREN+ RPAREN
    |
    LPAREN pmAttributes RPAREN+ RPAREN
    |
    LPAREN cmAttributes RPAREN+ RPAREN
    |
    LPAREN attributeFilter (COMMA attributeFilter)*  RPAREN+ RPAREN
    |
    LPAREN LPAREN+ attributeFilter (COMMA attributeFilter)*  RPAREN
    |
    LPAREN LPAREN+ allAttributes  RPAREN
;

attributeSpecificationMissingClosingParentheses :
    LPAREN attributeFilter (COMMA attributeFilter)*
    |
    LPAREN allAttributes
;

attributeValueSequenceTooManyBrackets :
    LSQBRACKET LSQBRACKET+ simpleAttributeValue (COMMA simpleAttributeValue)*  RSQBRACKET+ RSQBRACKET
    |
    LSQBRACKET simpleAttributeValue (COMMA simpleAttributeValue)*  RSQBRACKET+ RSQBRACKET
    |
    LSQBRACKET LSQBRACKET+ simpleAttributeValue (COMMA simpleAttributeValue)*  RSQBRACKET
    |
    LSQBRACKET LSQBRACKET+ complexAttributeValue (COMMA complexAttributeValue)*  RSQBRACKET+ RSQBRACKET
    |
    LSQBRACKET complexAttributeValue (COMMA complexAttributeValue)*  RSQBRACKET+ RSQBRACKET
    |
    LSQBRACKET LSQBRACKET+ complexAttributeValue (COMMA complexAttributeValue)*  RSQBRACKET
;

attributeValueSequenceMissingClosingBrackets :
    LSQBRACKET simpleAttributeValue (COMMA simpleAttributeValue)*
;

// For some reason the parser complains at runtime when combining
// attributeValueSequenceMissingClosingBrackets and complexAttributeValueSequenceMissingClosingBrackets into 1 rule...
// Hence the existence of 2 separate rules

complexAttributeValueSequenceMissingClosingBrackets :
	LSQBRACKET complexAttributeValue (COMMA complexAttributeValue)*
;

complexAttributeValue :
    LPAREN attributeNameValue (COMMA attributeNameValue) * RPAREN
    |
    complexAttributeValueTooManyParentheses
    |
    complexAttributeValueMissingClosingParentheses
;

complexAttributeValueTooManyParentheses :
    LPAREN LPAREN+ attributeNameValue (COMMA attributeNameValue) *  RPAREN+ RPAREN
    |
    LPAREN attributeNameValue (COMMA attributeNameValue) *  RPAREN+ RPAREN
    |
    LPAREN LPAREN+ attributeNameValue (COMMA attributeNameValue) *  RPAREN
;

complexAttributeValueMissingClosingParentheses :
    LPAREN attributeNameValue (COMMA attributeNameValue) *
;

attributeFilter :
    attributeName numericComparison simpleAttributeValue # attributeNumericComparisonSubrule
    |
    attributeName EQEQ attributePattern # attributePatternComparisonSubrule
    |
    attributeName # attributeSelectorSubrule
;

attributePattern :
    simpleAttributeValue # attributeValueEqualToSubrule
    |
    simpleAttributeValue (STAR | STAR_WS) # attributeValueStartsWithSubrule
    |
    STAR simpleAttributeValue # attributeValueEndsWithSubrule
    |
    STAR simpleAttributeValue (STAR | STAR_WS) # attributeValueContainsSubrule
    |
    (STAR | STAR_WS) # attributeValueMatchAnySubrule
;

numericComparison :
    LT # lessThanSubrule
    |
    GT # greaterThanSubrule
    |
    LTEQ # lessThanOrEqualToSubrule
    |
    GTEQ # greaterThanOrEqualToSubrule
    |
    NEQ # notEqualToSubrule
    |
    NLT # notLessThanSubrule
    |
    NGT # notGreaterThanSubrule
;


/**
 *  O U T P U T  - S P E C I F I C A T I O N
 */

cmOutputSpecifications:
    cmOutputSpecification (SEMI cmOutputSpecification)*
;

cmOutputSpecification:
    outputType (DOT outputAttributes)?
;

outputType:
    BASIC_ID
;

outputAttributes:
    allAttributes # outputAllAttributeSubrule
    |
    persistedAttributes # outputPersistedAttributesSubrule
    |
    pmAttributes # outputPmAttributesSubrule
    |
    cmAttributes # outputAttributesSubrule
    |
    outputOneAttribute #outputOneAttributeSubrule
    |
    LPAREN outputAttributeList RPAREN #outputAttributeListSubrule
    |
    outputAttributesTooManyParentheses #outputAttributesTooManyParenthesesSubrule
    |
    outputAttributesMissingClosingParentheses #outputAttributesMissingClosingParenthesesSubrule
;

outputAttributesTooManyParentheses :
    LPAREN LPAREN+ outputAttributeList  RPAREN+ RPAREN
    |
    LPAREN outputAttributeList  RPAREN+ RPAREN
    |
    LPAREN LPAREN+ outputAttributeList  RPAREN
;

outputAttributesMissingClosingParentheses :
    LPAREN outputAttributeList
;

outputOneAttribute:
    BASIC_ID
;

outputAttributeList:
    outputOneAttribute (COMMA outputOneAttribute)*
;

/**
 *  O P T I O N S
 */

namespace :
    NAMESPACE EQ (BASIC_ID | STRING_IN_QUOTES)
;

version :
    VERSION EQ versionValue
;

versionValue :
    BASIC_ID (DOT BASIC_ID)*
;

outputFormat:
    listOutput | tableOutput
;

listOutput :
    LIST_OUTPUT
;

tableOutput :
    TABLE_OUTPUT
;

configuration :
    CONFIGURATION EQ BASIC_ID
;

mandatoryNameSpaceAndOptionalVersionRule:
    namespace version?
;

nameSpaceAndVersionRule:
    namespace version |
    version namespace |
    namespace |
    version
;

neType :
    NETYPE EQ BASIC_ID
;

allFlag :
    ALL
;

allModelVersionsFlag :
    ALL
;

countFlag :
    COUNT
;

invalidOption :
    INVALID_OPTION |
    INVALID_OPTION EQ |
    INVALID_OPTION EQ BASIC_ID
;

/**
 *  C O M M O N - R U L E S
 */

yangType :
    STRING_IN_QUOTES
;

type :
    BASIC_ID
    |
    yangType
;

allTypes :
    STAR | STAR_WS
;

allAttributes :
    (STAR | STAR_WS)
;

persistedAttributes :
    (PERSISTED_ATTRIBUTES | PERSISTED_ATTRIBUTES_WS)
;

pmAttributes :
    (PM_ATTRIBUTES | PM_ATTRIBUTES_WS)
;

cmAttributes :
    (CM_ATTRIBUTES | CM_ATTRIBUTES_WS)
;

name :
    extendedId # nameSubrule
    |
    STRING_IN_QUOTES # nameInQoutesSubrule
;

// This 'extendedId' is a rule to match either an BASIC_ID token OR a keyword token.
// It should be used for attribute values and in a 'contains' type pattern match.
// The following should be valid:
//      get * networkElement.userLabel==-namespace
//      get * networkElement.userLabel==*-namespace*
// '-namespace' above is considered an extendedId by the parser as per the rule below,
// as the string '-namespace' is an allowable attribute value.
//
// This should be invalid:
//      get * -namespace.userLabel==someUserLabel
// The parser will reject it as '-namespace' above is NOT a valid BASIC_ID token, or type.

extendedId :
    HY*     // may start with hyphen
    (BASIC_ID |   // may contain an BASIC_ID
    CREATE_CMD | GET_CMD | SET_CMD | ACTION_CMD | DELETE_CMD | DESCRIBE_CMD | IMPORT_CMD | EXPORT_CMD // may be command tokens
    ALL | NAMESPACE | NETYPE | VERSION | TABLE_OUTPUT | LIST_OUTPUT | INVALID_OPTION)  // may be option tokens
;
