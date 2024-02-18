use [PE_OPTICAL_ERP_PROD_20240218_0700]; 
GO

SELECT  peti_cod_peticion
       ,'cod_usuario' idEntity_
       ,format(PETD_FEC_EMISION,'yyyy-mm-dd') trandate
       ,2 approvalstatus
       ,ID_interno_Sub subsidiary
       ,PRFI_COD_COMPONENTE
       ,PRFV_DES_COMPONENTE
       ,ID_interno_de departamento
       ,15 class
       ,'no lo manejamos en el RQ' location_log
       ,PEDV_COD_CONCEPTO item_externalid
       ,PEDN_CANTIDAD quantity
       ,PEDN_PUNITARIO rate
       ,PEDN_PUNITARIO estimaterate
FROM log.LOG_PETICION_ENC
INNER JOIN log.log_peticion_Det
ON PETI_COD_PETICION = PEDI_COD_PETICION AND PETI_EST_REGISTRO = 1 AND PEDI_EST_REGISTRO = 1
INNER JOIN dbo.Subsidiarias_ERP
ON PETI_COD_EMPRESA = codemplog
INNER JOIN log.LOG_PETICION_REFERENCIA
ON PETI_COD_PETICION = PRFI_COD_PETICION AND PRFI_EST_REGISTRO = 1
LEFT JOIN dbo.Departamentos_ERP
ON PRFI_COD_COMPONENTE = CodCCLOG
WHERE PETI_COD_ESTADO = 94
AND PETD_FEC_EMISION >= '2024-01-01'
AND PETI_COD_DOCUMENTO = 24;