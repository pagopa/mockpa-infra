{
  "swagger": "2.0",
  "info": {
    "version": "1.0.0",
    "title": "Checkout API",
    "contact": {
      "name": "pagoPA team",
    },
    "description": "Documentation of the Checkout Function API here.\n"
  },
  "host": "${host}",
  "basePath": "/api/v1",
  "schemes": [
    "https"
  ],
  "paths": {
    "/payment-requests/{rpt_id_from_string}": {
      "x-swagger-router-controller": "PaymentController",
      "get": {
        "operationId": "getPaymentInfo",
        "summary": "Get Payment Info",
        "description": "Retrieve information about a payment",
        "parameters": [
          {
            "$ref": "#/parameters/RptId"
          }
        ],
        "responses": {
          "200": {
            "description": "Payment information retrieved",
            "schema": {
              "$ref": "#/definitions/PaymentRequestsGetResponse"
            },
            "examples": {
              "application/json": {
                "importoSingoloVersamento": "200,",
                "codiceContestoPagamento": "ABC123"
              }
            }
          },
          "400": {
            "description": "Invalid input or PagoPA response",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "424": {
            "description": "PagoPA service error. The requests cannot be handled by PagoPa services.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "500": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
            "schema": {
              "$ref": "#/definitions/PaymentProblemJson"
            }
          }
        }
      }
    },
    "/payment-activations": {
      "x-swagger-router-controller": "PaymentController",
      "post": {
        "operationId": "activatePayment",
        "summary": "Activate Payment",
        "description": "Require a lock (activation) for a payment",
        "parameters": [
          {
            "in": "body",
            "name": "body",
            "schema": {
              "$ref": "#/definitions/PaymentActivationsPostRequest"
            },
            "required": true,
            "x-examples": {
              "application/json": {
                "rptId": "12345678901012123456789012345",
                "importoSingoloVersamento": 200,
                "codiceContestoPagamento": "ABC123"
              }
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Payment activation process started",
            "schema": {
              "$ref": "#/definitions/PaymentActivationsPostResponse"
            },
            "examples": {
              "application/json": {
                "importoSingoloVersamento": 200
              }
            }
          },
          "400": {
            "description": "Invalid input or PagoPA response",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "424": {
            "description": "PagoPA service error. The requests cannot be handled by PagoPa services.",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "500": {
            "description": "PagoPA services are not available",
            "schema": {
              "$ref": "#/definitions/PaymentProblemJson"
            }
          }
        }
      }
    },
    "/payment-activations/{codice_contesto_pagamento}": {
      "x-swagger-router-controller": "PaymentController",
      "get": {
        "operationId": "getActivationStatus",
        "summary": "Get the activation status",
        "description": "Get the activation status and the paymentId",
        "parameters": [
          {
            "$ref": "#/parameters/CodiceContestoPagamento"
          }
        ],
        "responses": {
          "200": {
            "description": "Activation information",
            "schema": {
              "$ref": "#/definitions/PaymentActivationsGetResponse"
            },
            "examples": {
              "application/json": {
                "idPagamento": "123455"
              }
            }
          },
          "400": {
            "description": "Invalid input",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "404": {
            "description": "Activation status not found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "500": {
            "description": "Service unavailable",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    }
  },
  "definitions": {
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/teamdigitale/digital-citizenship-functions/v0.51.0/api/definitions.yaml#/ProblemJson"
    },
    "PaymentProblemJson": {
      "description": "A ProblemJson-like type specific for the GetPayment and ActivatePayment operations",
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "format": "uri",
          "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
          "default": "about:blank",
          "example": "https://example.com/problem/constraint-violation"
        },
        "title": {
          "type": "string",
          "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
        },
        "status": {
          "type": "integer",
          "format": "int32",
          "minimum": 100,
          "maximum": 600,
          "exclusiveMaximum": true
        },
        "detail": {
          "$ref": "#/definitions/PaymentFault"
        },
        "detail_v2": {
          "$ref": "#/definitions/PaymentFaultV2"
        },
        "instance": {
          "type": "string",
          "format": "uri",
          "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
        }
      },
      "required": [
        "detail",
        "detail_v2"
      ]
    },
    "CodiceContestoPagamento": {
      "description": "Transaction Id used to identify the communication flow",
      "type": "string",
      "minLength": 32,
      "maxLength": 32
    },
    "EnteBeneficiario": {
      "description": "Beneficiary institution related to a payment",
      "type": "object",
      "properties": {
        "identificativoUnivocoBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "denominazioneBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 70
        },
        "codiceUnitOperBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "denomUnitOperBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 70
        },
        "indirizzoBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 70
        },
        "civicoBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 16
        },
        "capBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 16
        },
        "localitaBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "provinciaBeneficiario": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "nazioneBeneficiario": {
          "type": "string",
          "pattern": "[A-Z]{2}"
        }
      },
      "required": [
        "identificativoUnivocoBeneficiario",
        "denominazioneBeneficiario"
      ]
    },
    "Iban": {
      "type": "string",
      "pattern": "[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{1,30}"
    },
    "ImportoEuroCents": {
      "description": "Amount for payments, in eurocents",
      "type": "integer",
      "minimum": 0,
      "maximum": 99999999
    },
    "PaymentActivationsGetResponse": {
      "type": "object",
      "description": "Define the response to send to App to provide the payment activation status related to a codiceContestoPagamento",
      "properties": {
        "idPagamento": {
          "type": "string",
          "minLength": 1,
          "maxLength": 36
        }
      },
      "required": [
        "idPagamento"
      ]
    },
    "PaymentActivationsPostRequest": {
      "type": "object",
      "description": "Define the request received from CD App to require a payment activation",
      "properties": {
        "rptId": {
          "$ref": "#/definitions/RptId"
        },
        "importoSingoloVersamento": {
          "$ref": "#/definitions/ImportoEuroCents"
        },
        "codiceContestoPagamento": {
          "$ref": "#/definitions/CodiceContestoPagamento"
        }
      },
      "required": [
        "rptId",
        "importoSingoloVersamento",
        "codiceContestoPagamento"
      ]
    },
    "PaymentActivationsPostResponse": {
      "type": "object",
      "description": "Define the response to send to CD App containing activation information",
      "properties": {
        "importoSingoloVersamento": {
          "$ref": "#/definitions/ImportoEuroCents"
        },
        "ibanAccredito": {
          "$ref": "#/definitions/Iban"
        },
        "causaleVersamento": {
          "type": "string",
          "minLength": 1,
          "maxLength": 140
        },
        "enteBeneficiario": {
          "$ref": "#/definitions/EnteBeneficiario"
        },
        "spezzoniCausaleVersamento": {
          "$ref": "#/definitions/SpezzoniCausaleVersamento"
        }
      },
      "required": [
        "importoSingoloVersamento"
      ]
    },
    "PaymentRequestsGetResponse": {
      "type": "object",
      "title": "PaymentRequestsGetResponse",
      "description": "Define the response to send to CD App containing payment information",
      "properties": {
        "importoSingoloVersamento": {
          "$ref": "#/definitions/ImportoEuroCents"
        },
        "codiceContestoPagamento": {
          "$ref": "#/definitions/CodiceContestoPagamento"
        },
        "ibanAccredito": {
          "$ref": "#/definitions/Iban"
        },
        "causaleVersamento": {
          "type": "string",
          "minLength": 1,
          "maxLength": 140
        },
        "enteBeneficiario": {
          "$ref": "#/definitions/EnteBeneficiario"
        },
        "spezzoniCausaleVersamento": {
          "$ref": "#/definitions/SpezzoniCausaleVersamento"
        }
      },
      "required": [
        "importoSingoloVersamento",
        "codiceContestoPagamento"
      ]
    },
    "RptId": {
      "type": "string"
    },
    "SpezzoniCausaleVersamento": {
      "description": "Payment installments (optional)",
      "type": "array",
      "items": {
        "$ref": "#/definitions/SpezzoniCausaleVersamentoItem"
      }
    },
    "SpezzoniCausaleVersamentoItem": {
      "description": "Single element of a payment installments",
      "type": "object",
      "properties": {
        "spezzoneCausaleVersamento": {
          "type": "string",
          "minLength": 1,
          "maxLength": 35
        },
        "spezzoneStrutturatoCausaleVersamento": {
          "$ref": "#/definitions/SpezzoneStrutturatoCausaleVersamento"
        }
      }
    },
    "SpezzoneStrutturatoCausaleVersamento": {
      "description": "Amount related to a single element of a payment installments",
      "type": "object",
      "properties": {
        "causaleSpezzone": {
          "type": "string",
          "minLength": 1,
          "maxLength": 25
        },
        "importoSpezzone": {
          "$ref": "#/definitions/ImportoEuroCents"
        }
      }
    },
    "PaymentFault": {
      "description": "Fault codes for the PagoPA Verifica and Attiva operations ( Deprecated )",
      "type": "string",
      "x-extensible-enum": [
        "PAYMENT_DUPLICATED",
        "INVALID_AMOUNT",
        "PAYMENT_ONGOING",
        "PAYMENT_EXPIRED",
        "PAYMENT_UNAVAILABLE",
        "PAYMENT_UNKNOWN",
        "DOMAIN_UNKNOWN",
        "PPT_MULTI_BENEFICIARIO",
        "GENERIC_ERROR"
      ]
    },
    "PaymentFaultV2": {
      "description": "Fault codes for the PagoPA/Controparte Verifica and Attiva operations",
      "type": "string",
      "x-extensible-enum": [
        "PPT_SYSTEM_ERROR",
        "PPT_AUTORIZZAZIONE",
        "PPT_AUTENTICAZIONE",
        "PPT_SINTASSI_XSD",
        "PPT_SINTASSI_EXTRAXSD",
        "PPT_SEMANTICA",
        "PPT_RPT_DUPLICATA",
        "PPT_RPT_SCONOSCIUTA",
        "PPT_RT_SCONOSCIUTA",
        "PPT_RT_NONDISPONIBILE",
        "PPT_SUPERAMENTOSOGLIA",
        "PPT_SEGREGAZIONE",
        "PPT_TIPOFIRMA_SCONOSCIUTO",
        "PPT_ERRORE_FORMATO_BUSTA_FIRMATA",
        "PPT_FIRMA_INDISPONIBILE",
        "PPT_ID_CARRELLO_DUPLICATO",
        "PPT_OPER_NON_STORNABILE",
        "PPT_OPER_NON_REVOCABILE",
        "PPT_WISP_TIMEOUT_RECUPERO_SCELTA",
        "PPT_WISP_SESSIONE_SCONOSCIUTA",
        "PPT_CANALE_ERRORE",
        "PPT_CODIFICA_PSP_SCONOSCIUTA",
        "PPT_PSP_SCONOSCIUTO",
        "PPT_PSP_DISABILITATO",
        "PPT_TIPO_VERSAMENTO_SCONOSCIUTO",
        "PPT_INTERMEDIARIO_PSP_SCONOSCIUTO",
        "PPT_INTERMEDIARIO_PSP_DISABILITATO",
        "PPT_CANALE_IRRAGGIUNGIBILE",
        "PPT_CANALE_SERVIZIO_NONATTIVO",
        "PPT_CANALE_TIMEOUT",
        "PPT_CANALE_NONRISOLVIBILE",
        "PPT_CANALE_INDISPONIBILE",
        "PPT_CANALE_SCONOSCIUTO",
        "PPT_CANALE_DISABILITATO",
        "PPT_CANALE_ERR_PARAM_PAG_IMM",
        "PPT_CANALE_ERRORE_RESPONSE",
        "PPT_RT_DUPLICATA",
        "PPT_ISCRIZIONE_NON_PRESENTE",
        "PPT_ULTERIORE_ISCRIZIONE",
        "PPT_PDD_IRRAGGIUNGIBILE",
        "PPT_ERRORE_EMESSO_DA_PAA",
        "PPT_DOMINIO_SCONOSCIUTO",
        "PPT_DOMINIO_DISABILITATO",
        "PPT_INTERMEDIARIO_PA_SCONOSCIUTO",
        "PPT_INTERMEDIARIO_PA_DISABILITATO",
        "PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE",
        "PPT_STAZIONE_INT_PA_SERVIZIO_NONATTIVO",
        "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",
        "PPT_STAZIONE_INT_PA_TIMEOUT",
        "PPT_STAZIONE_INT_PA_NONRISOLVIBILE",
        "PPT_STAZIONE_INT_PA_INDISPONIBILE",
        "PPT_STAZIONE_INT_PA_SCONOSCIUTA",
        "PPT_STAZIONE_INT_PA_DISABILITATA",
        "PPT_ID_FLUSSO_SCONOSCIUTO",
        "PAA_ID_DOMINIO_ERRATO",
        "PAA_ID_INTERMEDIARIO_ERRATO",
        "PAA_STAZIONE_INT_ERRATA",
        "PAA_RPT_SCONOSCIUTA",
        "PAA_RT_DUPLICATA",
        "PAA_TIPOFIRMA_SCONOSCIUTO",
        "PAA_ERRORE_FORMATO_BUSTA_FIRMATA",
        "PAA_FIRMA_INDISPONIBILE",
        "PAA_FIRMA_ERRATA",
        "PAA_PAGAMENTO_SCONOSCIUTO",
        "PAA_PAGAMENTO_DUPLICATO",
        "PAA_PAGAMENTO_IN_CORSO",
        "PAA_PAGAMENTO_ANNULLATO",
        "PAA_PAGAMENTO_SCADUTO",
        "PAA_SINTASSI_XSD",
        "PAA_SINTASSI_EXTRAXSD",
        "PAA_SEMANTICA",
        "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO",
        "PAA_SYSTEM_ERROR",
        "CANALE_SINTASSI_XSD",
        "CANALE_SINTASSI_EXTRAXSD",
        "CANALE_SEMANTICA",
        "CANALE_RPT_DUPLICATA",
        "CANALE_RPT_SCONOSCIUTA",
        "CANALE_RPT_RIFIUTATA",
        "CANALE_RT_SCONOSCIUTA",
        "CANALE_RT_NON_DISPONIBILE",
        "CANALE_INDISPONIBILE",
        "CANALE_RICHIEDENTE_ERRATO",
        "CANALE_SYSTEM_ERROR",
        "PPT_LOCAL_ERROR_PROTOCOLLO",
        "PPT_LOCAL_ERROR_EXTRAXSD",
        "PPT_LOCAL_ERROR_FSM",
        "PPT_RT_SEGNO_DISCORDE",
        "CANALE_FIRMA_SCONOSCIUTA",
        "CANALE_BUSTA_ERRATA",
        "CANALE_NEGA_CONTABILIZZAZIONE",
        "CANALE_CARRELLO_DUPLICATO_KO",
        "CANALE_CARRELLO_DUPLICATO_UNKNOWN",
        "CANALE_CARRELLO_DUPLICATO_OK",
        "OGGETTO_DISABILITATO",
        "PPT_IBAN_NON_CENSITO",
        "PPT_RT_IN_GESTIONE",
        "CANALE_CONVENZIONE_NON_VALIDA",
        "PAA_CONVENZIONE_NON_VALIDA",
        "PPT_IMPORTO_ERRATO",
        "PPT_TOKEN_SCONOSCIUTO",
        "PPT_TOKEN_SCADUTO",
        "PPT_POSIZIONE_SCONOSCIUTA",
        "PPT_DATI_POSIZIONE_GIA_CONOSCIUTI",
        "PPT_ESITO_GIA_ACQUISITO",
        "PPT_PAGAMENTO_IN_CORSO",
        "PPT_PAGAMENTO_DUPLICATO",
        "PPT_MULTI_BENEFICIARIO",
        "PPT_ERRORE",
        "GENERIC_ERROR"
      ]
    }
  },
  "parameters": {
    "CodiceContestoPagamento": {
      "name": "codice_contesto_pagamento",
      "description": "Transaction Id used to identify the communication flow",
      "type": "string",
      "minLength": 32,
      "maxLength": 32,
      "required": true,
      "in": "path",
      "x-example": "A0123BC123124"
    },
    "RptId": {
      "name": "rpt_id_from_string",
      "description": "Unique identifier for payments",
      "type": "string",
      "minLength": 1,
      "maxLength": 35,
      "required": true,
      "in": "path",
      "x-example": "A0123BC123124"
    }
  },
  "consumes": [
    "application/json"
  ],
  "produces": [
    "application/json"
  ]
}
