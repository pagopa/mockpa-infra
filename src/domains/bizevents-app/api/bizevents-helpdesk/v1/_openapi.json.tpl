{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Helpdesk",
    "description": "Microservice for exposing REST APIs for bizevent helpdesk.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.1.12"
  },
  "servers": [
    {
      "url": "${host}/bizevents/helpdesk/v1",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "429": {
            "description": "Too many requests",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "200": {
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.AppInfo"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/events/{biz-event-id}": {
      "get": {
        "tags": [
          "Biz-Events Helpdesk"
        ],
        "summary": "Retrieve the biz-event given its id.",
        "operationId": "getBizEvent",
        "parameters": [
          {
            "name": "biz-event-id",
            "in": "path",
            "description": "The id of the biz-event.",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained biz-event.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.BizEvent"
                }
              }
            }
          },
          "422": {
            "description": "Unable to process the request.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "Not found the biz-event.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/events/organizations/{organization-fiscal-code}/iuvs/{iuv}": {
      "get": {
        "tags": [
          "Biz-Events Helpdesk"
        ],
        "summary": "Retrieve the biz-event given the organization fiscal code and IUV.",
        "operationId": "getBizEventByOrganizationFiscalCodeAndIuv",
        "parameters": [
          {
            "name": "organization-fiscal-code",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iuv",
            "in": "path",
            "description": "The unique payment identification. Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained biz-event.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.BizEvent"
                }
              }
            }
          },
          "422": {
            "description": "Unable to process the request.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "Not found the biz-event.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.ProblemJson"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "components": {
    "schemas": {
      "it.gov.pagopa.bizeventsservice.model.ProblemJson": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.AppInfo": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "environment": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.AuthRequest": {
        "type": "object",
        "properties": {
          "authOutcome": {
            "type": "string"
          },
          "guid": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "error": {
            "type": "string"
          },
          "auth_code": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.BizEvent": {
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "idPaymentManager": {
            "type": "string"
          },
          "complete": {
            "type": "string"
          },
          "receiptId": {
            "type": "string"
          },
          "missingInfo": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "debtorPosition": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.DebtorPosition"
          },
          "creditor": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Creditor"
          },
          "psp": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Psp"
          },
          "debtor": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Debtor"
          },
          "payer": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Payer"
          },
          "paymentInfo": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.PaymentInfo"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Transfer"
            }
          },
          "transactionDetails": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.TransactionDetails"
          },
          "eventStatus": {
            "type": "string",
            "enum": [
              "NA",
              "RETRY",
              "FAILED",
              "DONE"
            ]
          },
          "eventRetryEnrichmentCount": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Creditor": {
        "type": "object",
        "properties": {
          "idPA": {
            "type": "string"
          },
          "idBrokerPA": {
            "type": "string"
          },
          "idStation": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Debtor": {
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "entityUniqueIdentifierType": {
            "type": "string"
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "streetName": {
            "type": "string"
          },
          "civicNumber": {
            "type": "string"
          },
          "postalCode": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "stateProvinceRegion": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "eMail": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.DebtorPosition": {
        "type": "object",
        "properties": {
          "modelType": {
            "type": "string"
          },
          "noticeNumber": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Details": {
        "type": "object",
        "properties": {
          "blurredNumber": {
            "type": "string"
          },
          "holder": {
            "type": "string"
          },
          "circuit": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Info": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string"
          },
          "blurredNumber": {
            "type": "string"
          },
          "holder": {
            "type": "string"
          },
          "expireMonth": {
            "type": "string"
          },
          "expireYear": {
            "type": "string"
          },
          "brand": {
            "type": "string"
          },
          "issuerAbi": {
            "type": "string"
          },
          "issuerName": {
            "type": "string"
          },
          "label": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.InfoTransaction": {
        "type": "object",
        "properties": {
          "brand": {
            "type": "string"
          },
          "brandLogo": {
            "type": "string"
          },
          "clientId": {
            "type": "string"
          },
          "paymentMethodName": {
            "type": "string"
          },
          "type": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.MBD": {
        "type": "object",
        "properties": {
          "IUBD": {
            "type": "string"
          },
          "oraAcquisto": {
            "type": "string"
          },
          "importo": {
            "type": "string"
          },
          "tipoBollo": {
            "type": "string"
          },
          "MBDAttachment": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Payer": {
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "entityUniqueIdentifierType": {
            "type": "string"
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "streetName": {
            "type": "string"
          },
          "civicNumber": {
            "type": "string"
          },
          "postalCode": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "stateProvinceRegion": {
            "type": "string"
          },
          "country": {
            "type": "string"
          },
          "eMail": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.PaymentAuthorizationRequest": {
        "type": "object",
        "properties": {
          "authOutcome": {
            "type": "string"
          },
          "requestId": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "authCode": {
            "type": "string"
          },
          "paymentMethodType": {
            "type": "string"
          },
          "details": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Details"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.PaymentInfo": {
        "type": "object",
        "properties": {
          "paymentDateTime": {
            "type": "string"
          },
          "applicationDate": {
            "type": "string"
          },
          "transferDate": {
            "type": "string"
          },
          "dueDate": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "fee": {
            "type": "string"
          },
          "primaryCiIncurredFee": {
            "type": "string"
          },
          "idBundle": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "totalNotice": {
            "type": "string"
          },
          "paymentMethod": {
            "type": "string"
          },
          "touchpoint": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.MapEntry"
            }
          },
          "IUR": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Psp": {
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string"
          },
          "idBrokerPsp": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "psp": {
            "type": "string"
          },
          "pspPartitaIVA": {
            "type": "string"
          },
          "pspFiscalCode": {
            "type": "string"
          },
          "channelDescription": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Transaction": {
        "type": "object",
        "properties": {
          "idTransaction": {
            "type": "string"
          },
          "transactionId": {
            "type": "string"
          },
          "grandTotal": {
            "type": "integer",
            "format": "int64"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "fee": {
            "type": "integer",
            "format": "int64"
          },
          "transactionStatus": {
            "type": "string"
          },
          "accountingStatus": {
            "type": "string"
          },
          "rrn": {
            "type": "string"
          },
          "authorizationCode": {
            "type": "string"
          },
          "creationDate": {
            "type": "string"
          },
          "numAut": {
            "type": "string"
          },
          "accountCode": {
            "type": "string"
          },
          "psp": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.TransactionPsp"
          },
          "origin": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.TransactionDetails": {
        "type": "object",
        "properties": {
          "user": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.User"
          },
          "paymentAuthorizationRequest": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.PaymentAuthorizationRequest"
          },
          "wallet": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.WalletItem"
          },
          "origin": {
            "type": "string"
          },
          "transaction": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Transaction"
          },
          "info": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.InfoTransaction"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.TransactionPsp": {
        "type": "object",
        "properties": {
          "idChannel": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "serviceName": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.Transfer": {
        "type": "object",
        "properties": {
          "idTransfer": {
            "type": "string"
          },
          "fiscalCodePA": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "amount": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.MapEntry"
            }
          },
          "IBAN": {
            "type": "string"
          },
          "MBD": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.MBD"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.User": {
        "type": "object",
        "properties": {
          "fullName": {
            "type": "string"
          },
          "type": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "fiscalCode": {
            "type": "string"
          },
          "notificationEmail": {
            "type": "string"
          },
          "userId": {
            "type": "string"
          },
          "userStatus": {
            "type": "string"
          },
          "userStatusDescription": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.entity.WalletItem": {
        "type": "object",
        "properties": {
          "idWallet": {
            "type": "string"
          },
          "walletType": {
            "type": "string",
            "enum": [
              "CARD",
              "PAYPAL",
              "BANCOMATPAY"
            ]
          },
          "enableableFunctions": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "pagoPa": {
            "type": "boolean"
          },
          "onboardingChannel": {
            "type": "string"
          },
          "favourite": {
            "type": "boolean"
          },
          "createDate": {
            "type": "string"
          },
          "info": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.Info"
          },
          "authRequest": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.entity.AuthRequest"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.MapEntry": {
        "type": "object",
        "properties": {
          "key": {
            "type": "string"
          },
          "value": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}