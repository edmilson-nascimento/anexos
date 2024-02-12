
* `GOS_ATTACHMENT_LIST_POPUP.`


DATA: ls_object    TYPE sibflporb,
      save_request TYPE sgs_flag.
ls_object-instid = 'FR 1234567890'.
ls_object-typeid = 'BUS1011'.
ls_object-catid = 'BO'.
CALL FUNCTION 'GOS_ATTACHMENT_LIST_POPUP'
  EXPORTING
    is_object       = ls_object
    ip_mode         = 'E' " Edit mode
  IMPORTING
    ep_save_request = save_request.
IF save_request = 'X'.
  COMMIT WORK.
ENDIF.

" Função para mostrar os anexos usada pelo standard
" Tabela de conexões: SRGBTBREL
