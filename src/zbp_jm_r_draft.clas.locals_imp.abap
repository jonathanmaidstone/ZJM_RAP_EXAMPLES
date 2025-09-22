CLASS lhc_Zjm_R_Draft DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Zjm_R_Draft RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Zjm_R_Draft RESULT result.
    METHODS determineStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Zjm_R_Draft~determineStatus.

    METHODS validateInterval FOR VALIDATE ON SAVE
      IMPORTING keys FOR Zjm_R_Draft~validateInterval.

    METHODS validateStartDate FOR VALIDATE ON SAVE
      IMPORTING keys FOR Zjm_R_Draft~validateStartDate.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Zjm_R_Draft RESULT result.

ENDCLASS.

CLASS lhc_Zjm_R_Draft IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD determineStatus.
    READ ENTITIES OF Zjm_R_Draft IN LOCAL MODE
   ENTITY zjm_r_draft
   ALL FIELDS
    WITH CORRESPONDING #( keys )
   RESULT DATA(result).

    LOOP AT result ASSIGNING FIELD-SYMBOL(<line>).
      <line>-status = 'N'.
    ENDLOOP.

    MODIFY ENTITIES OF zjm_r_draft IN LOCAL MODE
    ENTITY zjm_r_draft
    UPDATE FIELDS ( status )
    WITH CORRESPONDING #( result ).

  ENDMETHOD.

  METHOD validateInterval.
    READ ENTITIES OF zjm_r_draft IN LOCAL MODE
    ENTITY zjm_r_draft
    FIELDS ( StartDate Enddate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(result).

    LOOP AT result ASSIGNING FIELD-SYMBOL(<line>).



      IF <line>-enddate < <line>-startdate.
        APPEND VALUE #(  %tky = <line>-%tky ) TO failed-zjm_r_draft.
        APPEND VALUE #(  %tky = <line>-%tky
        %msg = NEW zcm_jm_draft_messages( textid = zcm_jm_Draft_messages=>end_before_start
        severity = if_abap_behv_message=>severity-error )
        %element-StartDate = if_abap_behv=>mk-on
        %element-EndDate = if_abap_behv=>mk-on
        %state_area = 'DATE'  ) TO reported-zjm_r_draft.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateStartDate.
    READ ENTITIES OF zjm_r_draft IN LOCAL MODE
    ENTITY zjm_r_draft
    FIELDS ( Startdate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(result).

    FINAL(today)  = cl_abap_context_info=>get_system_date( ).

    LOOP AT result ASSIGNING FIELD-SYMBOL(<line>) .
    append value #(  %tky = <line>-%tky %state_area = 'DATE' ) to reported-zjm_r_draft.
      IF <line>-StartDate < today.
        APPEND VALUE #( %tky = <line>-%tky ) TO failed-zjm_r_draft.
        APPEND VALUE #( %tky = <line>-%tky
        %msg = NEW zcm_JM_draft_messages( textid = zcm_jm_draft_messages=>start_in_past
        severity = if_abap_behv_message=>severity-error )
        %element-startdate = if_abap_Behv=>mk-on
        %state_area = 'DATE' ) TO reported-zjm_r_draft.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zjm_r_draft IN LOCAL MODE
     ENTITY zjm_r_draft
     ALL FIELDS
     WITH CORRESPONDING #( keys )
     RESULT DATA(travel).

    LOOP AT travel ASSIGNING FIELD-SYMBOL(<line>).
      APPEND CORRESPONDING #(  <line> ) TO result
      ASSIGNING FIELD-SYMBOL(<result>).

      IF <line>-%is_draft = if_abap_behv=>mk-on.
        READ ENTITIES OF zjM_r_Draft IN LOCAL MODE
        ENTITY zjm_r_draft
        ALL FIELDS WITH VALUE #( ( %key = <line>-%key %is_draft = if_abap_behv=>mk-off ) )
        RESULT DATA(active_version).

        IF active_version IS NOT INITIAL.
          <line>-StartDate = active_version[ 1 ]-StartDate.
          <line>-EndDate = active_version[ 1 ]-EndDate.
        ENDIF.
endif.

        IF <line>-startdate < cl_abap_context_info=>get_system_date(  ).
          <result>-%features-%field-StartDate = if_abap_behv=>fc-f-read_only.
        ENDIF.

    ENDLOOP.




  ENDMETHOD.

ENDCLASS.
