CLASS zcl_jm_add_record DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jm_add_record IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data record type zjm_draft_test.
  record-agency_id = '70000'.
  record-travel_id = '1111'.
  record-start_date = cl_abap_context_info=>get_system_date( ) - 7.
  record-end_date = cl_abap_context_info=>get_system_date(  ) + 7.
  insert zjm_draft_test from @record.
  ENDMETHOD.
ENDCLASS.
