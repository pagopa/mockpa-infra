{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce payment requests service",
    "description": "pagoPA ecommerce microservice to retrieve payment request data or to manage carts (consisting of a group of payment requests) with redirects to checkout",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "payment-requests",
      "description": "Api's for performing verification on payment notices",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611745793/-servizio+payment+requests+service",
        "description": "Technical specifications"
      }
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "paths": {
    "/payment-requests/{rpt_id}": {
      "get": {
        "summary": "Verify single payment notice",
        "description": "Api used to perform verify on payment notice by mean of Nodo call",
        "tags": [
          "payment-requests"
        ],
        "operationId": "getPaymentRequestInfo",
        "parameters": [
          {
            "in": "path",
            "name": "rpt_id",
            "description": "Unique identifier for payment request, so the concatenation of the fiscal code and notice number.",
            "schema": {
              "type": "string",
              "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Payment request retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentRequestsGetResponse"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Node cannot find the services needed to process this request in its configuration. This error is most likely to occur when submitting a non-existing RPT id.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ValidationFaultPaymentProblemJson"
                }
              }
            }
          },
          "409": {
            "description": "Conflict on payment status",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentStatusFaultPaymentProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "PagoPA services are not available or request is rejected by PagoPa",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/GatewayFaultPaymentProblemJson"
                }
              }
            }
          },
          "503": {
            "description": "EC services are not available",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PartyConfigurationFaultPaymentProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Timeout from PagoPA services",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PartyTimeoutFaultPaymentProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/carts/{id_cart}": {
      "get": {
        "tags": [
          "payment-requests"
        ],
        "operationId": "GetCarts",
        "summary": "Get a cart data",
        "description": "Retrieve cart information",
        "parameters": [
          {
            "in": "path",
            "name": "id_cart",
            "description": "Unique identifier for cart",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true
          }
        ],
        "responses": {
          "200": {
            "description": "Cart data",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CartRequest"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "Cart not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "PaymentRequestsGetResponse": {
        "type": "object",
        "title": "PaymentRequestsGetResponse",
        "description": "Response with payment request information",
        "properties": {
          "rptId": {
            "description": "Digital payment request id",
            "type": "string",
            "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
          },
          "paFiscalCode": {
            "description": "Fiscal code associated to the payment notice",
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "paName": {
            "description": "Name of the payment notice issuer",
            "type": "string",
            "minLength": 1,
            "maxLength": 70
          },
          "description": {
            "description": "Payment notice description",
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "amount": {
            "description": "Payment notice amount",
            "type": "integer",
            "minimum": 0,
            "maximum": 99999999
          },
          "dueDate": {
            "description": "Payment notice due date",
            "type": "string",
            "pattern": "([0-9]{4})-(1[0-2]|0[1-9])-(0[1-9]|1[0-9]|2[0-9]|3[0-1])",
            "example": "2025-07-31"
          }
        },
        "required": [
          "amount",
          "paymentContextCode"
        ]
      },
      "ValidationFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to validation errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/ValidationFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PaymentStatusFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors related to payment status conflicts.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PaymentStatusFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "GatewayFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment and ActivatePayment operations.\nPossible values of `detail_v2` are limited to faults pertaining to Nodo errors.",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/GatewayFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PartyConfigurationFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment",
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PartyConfigurationFault"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "PartyTimeoutFaultPaymentProblemJson": {
        "description": "A PaymentProblemJson-like type specific for the GetPayment an operations.",
        "type": "object",
        "properties": {
          "faultCodeCategory": {
            "$ref": "#/components/schemas/FaultCategory"
          },
          "faultCodeDetail": {
            "$ref": "#/components/schemas/PartyTimeoutFault"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          }
        },
        "required": [
          "faultCodeCategory",
          "faultCodeDetail"
        ]
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
      },
      "FaultCategory": {
        "description": "Fault code categorization for the PagoPA Verifica and Attiva operations.\nPossible categories are:\n- `PAYMENT_DUPLICATED`\n- `PAYMENT_ONGOING`\n- `PAYMENT_EXPIRED`\n- `PAYMENT_UNAVAILABLE`\n- `PAYMENT_UNKNOWN`\n- `DOMAIN_UNKNOWN`\n- `PAYMENT_CANCELED`\n- `GENERIC_ERROR`",
        "type": "string",
        "enum": [
          "PAYMENT_DUPLICATED",
          "PAYMENT_ONGOING",
          "PAYMENT_EXPIRED",
          "PAYMENT_UNAVAILABLE",
          "PAYMENT_UNKNOWN",
          "DOMAIN_UNKNOWN",
          "PAYMENT_CANCELED",
          "GENERIC_ERROR"
        ]
      },
      "PaymentStatusFault": {
        "description": "Fault codes for errors related to payment attempts that cause conflict with the current payment status,\nsuch as a duplicated payment attempt or a payment attempt made while another attempt is still being processed.\nShould be mapped to 409 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_PAGAMENTO_IN_CORSO`\n- `PAA_PAGAMENTO_IN_CORSO`\n- `PPT_PAGAMENTO_DUPLICATO`\n- `PAA_PAGAMENTO_DUPLICATO`\n- `PAA_PAGAMENTO_SCADUTO`",
        "type": "string",
        "enum": [
          "PPT_PAGAMENTO_IN_CORSO",
          "PAA_PAGAMENTO_IN_CORSO",
          "PPT_PAGAMENTO_DUPLICATO",
          "PAA_PAGAMENTO_DUPLICATO",
          "PAA_PAGAMENTO_SCADUTO"
        ]
      },
      "ValidationFault": {
        "description": "Fault codes for errors related to well-formed requests to ECs not present inside Nodo, should be mapped to 404 HTTP status code.\nMost of the time these are generated when users input a wrong fiscal code or notice number.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PAA_PAGAMENTO_SCONOSCIUTO`\n- `PPT_DOMINIO_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PA_SCONOSCIUTO`\n- `PPT_STAZIONE_INT_PA_SCONOSCIUTA`\n- `PAA_PAGAMENTO_ANNULLATO`",
        "type": "string",
        "enum": [
          "PAA_PAGAMENTO_SCONOSCIUTO",
          "PPT_DOMINIO_SCONOSCIUTO",
          "PPT_INTERMEDIARIO_PA_SCONOSCIUTO",
          "PPT_STAZIONE_INT_PA_SCONOSCIUTA",
          "PAA_PAGAMENTO_ANNULLATO"
        ]
      },
      "GatewayFault": {
        "description": "Fault codes for generic downstream services errors, should be mapped to 502 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `GENERIC_ERROR`\n- `PPT_SINTASSI_EXTRAXSD`\n- `PPT_SINTASSI_XSD`\n- `PPT_PSP_SCONOSCIUTO`\n- `PPT_PSP_DISABILITATO`\n- `PPT_INTERMEDIARIO_PSP_SCONOSCIUTO`\n- `PPT_INTERMEDIARIO_PSP_DISABILITATO`\n- `PPT_CANALE_SCONOSCIUTO`\n- `PPT_CANALE_DISABILITATO`\n- `PPT_AUTENTICAZIONE`\n- `PPT_AUTORIZZAZIONE`\n- `PPT_CODIFICA_PSP_SCONOSCIUTA`\n- `PAA_SEMANTICA`\n- `PPT_SEMANTICA`\n- `PPT_SYSTEM_ERROR`\n- `PAA_SYSTEM_ERROR`",
        "type": "string",
        "enum": [
          "GENERIC_ERROR",
          "PPT_SINTASSI_EXTRAXSD",
          "PPT_SINTASSI_XSD",
          "PPT_PSP_SCONOSCIUTO",
          "PPT_PSP_DISABILITATO",
          "PPT_INTERMEDIARIO_PSP_SCONOSCIUTO",
          "PPT_INTERMEDIARIO_PSP_DISABILITATO",
          "PPT_CANALE_SCONOSCIUTO",
          "PPT_CANALE_DISABILITATO",
          "PPT_AUTENTICAZIONE",
          "PPT_AUTORIZZAZIONE",
          "PPT_CODIFICA_PSP_SCONOSCIUTA",
          "PAA_SEMANTICA",
          "PPT_SEMANTICA",
          "PPT_SYSTEM_ERROR",
          "PAA_SYSTEM_ERROR"
        ]
      },
      "PartyConfigurationFault": {
        "description": "Fault codes for fatal errors from ECs, should be mapped to 503 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_DOMINIO_DISABILITATO`\n- `PPT_INTERMEDIARIO_PA_DISABILITATO`\n- `PPT_STAZIONE_INT_PA_DISABILITATA`\n- `PPT_ERRORE_EMESSO_DA_PAA`\n- `PPT_STAZIONE_INT_PA_ERRORE_RESPONSE`\n- `PPT_IBAN_NON_CENSITO`\n- `PAA_SINTASSI_EXTRAXSD`\n- `PAA_SINTASSI_XSD`\n- `PAA_ID_DOMINIO_ERRATO`\n- `PAA_ID_INTERMEDIARIO_ERRATO`\n- `PAA_STAZIONE_INT_ERRATA`\n- `PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO`",
        "type": "string",
        "enum": [
          "PPT_DOMINIO_DISABILITATO",
          "PPT_INTERMEDIARIO_PA_DISABILITATO",
          "PPT_STAZIONE_INT_PA_DISABILITATA",
          "PPT_ERRORE_EMESSO_DA_PAA",
          "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",
          "PPT_IBAN_NON_CENSITO",
          "PAA_SINTASSI_EXTRAXSD",
          "PAA_SINTASSI_XSD",
          "PAA_ID_DOMINIO_ERRATO",
          "PAA_ID_INTERMEDIARIO_ERRATO",
          "PAA_STAZIONE_INT_ERRATA",
          "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO"
        ]
      },
      "PartyTimeoutFault": {
        "description": "Fault codes for timeout errors, should be mapped to 504 HTTP status code.\nFor further information visit https://docs.pagopa.it/gestionedeglierrori/struttura-degli-errori/fault-code.\nPossible fault codes are:\n- `PPT_STAZIONE_INT_PA_TIMEOUT`\n- `PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE`\n- `PPT_STAZIONE_INT_PA_SERVIZIO_NONATTIVO`\n- `GENERIC_ERROR`",
        "type": "string",
        "enum": [
          "PPT_STAZIONE_INT_PA_TIMEOUT",
          "PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE",
          "PPT_STAZIONE_INT_PA_SERVIZIO_NONATTIVO",
          "GENERIC_ERROR"
        ]
      },
      "CartRequest": {
        "description": "Cart request body",
        "type": "object",
        "required": [
          "paymentNotices",
          "returnUrls"
        ],
        "properties": {
          "emailNotice": {
            "description": "Email to which send the payment receipt",
            "type": "string",
            "format": "email",
            "example": "my_email@mail.it"
          },
          "paymentNotices": {
            "description": "List of payment notices in the cart",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentNotice"
            },
            "minItems": 1,
            "maxItems": 5,
            "example": [
              {
                "noticeNumber": "302012387654312384",
                "fiscalCode": "77777777777",
                "amount": 10000,
                "companyName": "companyName",
                "description": "description"
              },
              {
                "noticeNumber": "302012387654312385",
                "fiscalCode": "77777777777",
                "amount": 5000,
                "companyName": "companyName",
                "description": "description"
              }
            ]
          },
          "returnUrls": {
            "description": "Structure containing all the returning URL's to which user will be redirect after payment process has been completed",
            "type": "object",
            "required": [
              "returnOkUrl",
              "returnCancelUrl",
              "returnErrorUrl"
            ],
            "properties": {
              "returnOkUrl": {
                "description": "Return URL in case of payment operation is completed successfully",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/success.html"
              },
              "returnCancelUrl": {
                "description": "Return URL in case of payment operation is cancelled",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/cancel.html"
              },
              "returnErrorUrl": {
                "description": "Return URL in case an error occurred during payment operation processing",
                "type": "string",
                "format": "uri",
                "example": "https://www.comune.di.prova.it/pagopa/error.html"
              }
            }
          },
          "idCart": {
            "type": "string",
            "example": "id_cart"
          },
          "allCCP": {
            "type": "boolean",
            "example": "false"
          }
        }
      },
      "PaymentNotice": {
        "description": "Payment notice informations",
        "type": "object",
        "required": [
          "noticeNumber",
          "fiscalCode",
          "amount",
          "companyName",
          "description"
        ],
        "properties": {
          "noticeNumber": {
            "description": "Payment notice number",
            "type": "string",
            "minLength": 18,
            "maxLength": 18
          },
          "fiscalCode": {
            "description": "Payment notice fiscal code",
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "amount": {
            "description": "Payment notice amount",
            "type": "integer",
            "minimum": 1
          },
          "companyName": {
            "description": "Payment notice company name",
            "type": "string",
            "maxLength": 140
          },
          "description": {
            "description": "Payment notice description",
            "type": "string",
            "maxLength": 140
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKeyAuth": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
