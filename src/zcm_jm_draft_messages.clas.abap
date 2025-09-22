CLASS zcm_jm_draft_messages DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key
        severity type if_abap_behv_message=>t_severity
        !previous LIKE previous OPTIONAL .

constants:
  begin of START_IN_PAST,
    msgid type symsgid value 'ZJMDRAFT',
    msgno type symsgno value '001',
    attr1 type scx_attrname value 'attr1',
    attr2 type scx_attrname value 'attr2',
    attr3 type scx_attrname value 'attr3',
    attr4 type scx_attrname value 'attr4',
  end of START_IN_PAST.

  constants:
    begin of END_BEFORE_START,
      msgid type symsgid value 'ZJMDRAFT',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'attr1',
      attr2 type scx_attrname value 'attr2',
      attr3 type scx_attrname value 'attr3',
      attr4 type scx_attrname value 'attr4',
    end of END_BEFORE_START.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_jm_draft_messages IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    .
      if_t100_message~t100key = textid.
if_abap_Behv_message~m_severity = severity.
  ENDMETHOD.




ENDCLASS.
