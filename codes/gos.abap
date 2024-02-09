*&---------------------------------------------------------------------*
*& Report ZCG_TESTES_ANXOS_COM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcg_testes_anxos_com.

DATA: go_container       TYPE REF TO cl_gui_custom_container,
      go_gos_attachments TYPE REF TO cl_gos_attachments.



PARAMETERS: pa_spp   TYPE /ygc/f_spp_h-sppnum,
            pa_anexo TYPE abap_bool RADIOBUTTON GROUP rb1,
            pa_comen TYPE abap_bool RADIOBUTTON GROUP rb1.


START-OF-SELECTION.

  PERFORM executar.


FORM executar.

  CASE abap_true.
    WHEN pa_anexo.
      CALL SCREEN 0100.

    WHEN pa_comen.
      MESSAGE e000(/ygc/ffe) WITH |Não implementado|.

    WHEN OTHERS.
  ENDCASE.

  BREAK-POINT.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
*  SET PF-STATUS 'xxxxxxxx'.
*  SET TITLEBAR 'xxx'.
BREAK-POINT.
  IF go_container IS NOT BOUND.

    go_container = NEW cl_gui_custom_container( container_name              = 'GV_CONTAINER'
                                                lifetime                    = cl_gui_custom_container=>lifetime_dynpro ).

  ENDIF.

  IF go_gos_attachments IS BOUND.
    go_gos_attachments->close( ).
    CLEAR go_gos_attachments.
  ENDIF.

  go_gos_attachments = NEW #( io_object    = NEW cl_sobl_bor_item( VALUE #( objkey  = pa_spp
                                                                            objtype = '/YCG/F_SPP'  ) )
                              io_container = go_container
                              ip_mode      = 'E'  ).

*      SET HANDLER me->on_commit_required FOR me->go_gos_attachments.

  go_gos_attachments->display( ).

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'SPOS'. "Save

      call FUNCTION 'BAPI_TRANSACTION_COMMIT'.

    WHEN 'E' OR 'ENDE' OR 'ECAN'. "Voltar, Sair ou Cancelar

      LEAVE TO SCREEN 0.

    WHEN OTHERS.
      BREAK-POINT.
  ENDCASE.

ENDMODULE.