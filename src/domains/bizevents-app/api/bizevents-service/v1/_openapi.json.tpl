{
  "openapi": "3.0.1",
  "info": {
    "title": "Biz-Events Service",
    "description": "Microservice for exposing REST APIs about payment receipts.",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.1.18"
  },
  "servers": [
    {
      "url": "${host}/bizevents/service/v1",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/organizations/{organizationfiscalcode}/receipts/{iur}": {
      "get": {
        "tags": [
          "Payment Receipts REST APIs"
        ],
        "summary": "The organization get the receipt for the creditor institution using IUR.",
        "operationId": "getOrganizationReceiptIur",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iur",
            "in": "path",
            "description": "The unique reference of the operation assigned to the payment (Payment Token).",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
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
          "200": {
            "description": "Obtained receipt.",
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.CtReceiptModelResponse"
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
          "404": {
            "description": "Not found the receipt.",
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
    "/organizations/{organizationfiscalcode}/receipts/{iur}/paymentoptions/{iuv}": {
      "get": {
        "tags": [
          "Payment Receipts REST APIs"
        ],
        "summary": "The organization get the receipt for the creditor institution using IUV and IUR.",
        "operationId": "getOrganizationReceiptIuvIur",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "The fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "iur",
            "in": "path",
            "description": "The unique reference of the operation assigned to the payment (Payment Token).",
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
          "200": {
            "description": "Obtained receipt.",
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
                  "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.CtReceiptModelResponse"
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
          "404": {
            "description": "Not found the receipt.",
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
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
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
      },
      "it.gov.pagopa.bizeventsservice.model.response.CtReceiptModelResponse": {
        "required": [
          "channelDescription",
          "companyName",
          "creditorReferenceId",
          "debtor",
          "description",
          "fiscalCode",
          "idChannel",
          "idPSP",
          "noticeNumber",
          "outcome",
          "paymentAmount",
          "pspCompanyName",
          "receiptId",
          "transferList"
        ],
        "type": "object",
        "properties": {
          "receiptId": {
            "type": "string"
          },
          "noticeNumber": {
            "type": "string"
          },
          "fiscalCode": {
            "type": "string"
          },
          "outcome": {
            "type": "string"
          },
          "creditorReferenceId": {
            "type": "string"
          },
          "paymentAmount": {
            "type": "number"
          },
          "description": {
            "type": "string"
          },
          "companyName": {
            "type": "string"
          },
          "officeName": {
            "type": "string"
          },
          "debtor": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.Debtor"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.TransferPA"
            }
          },
          "idPSP": {
            "type": "string"
          },
          "pspFiscalCode": {
            "type": "string"
          },
          "pspPartitaIVA": {
            "type": "string"
          },
          "pspCompanyName": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          },
          "channelDescription": {
            "type": "string"
          },
          "payer": {
            "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.response.Payer"
          },
          "paymentMethod": {
            "type": "string"
          },
          "fee": {
            "type": "number"
          },
          "primaryCiIncurredFee": {
            "type": "number"
          },
          "idBundle": {
            "type": "string"
          },
          "idCiBundle": {
            "type": "string"
          },
          "paymentDateTime": {
            "type": "string",
            "format": "date"
          },
          "applicationDate": {
            "type": "string",
            "format": "date"
          },
          "transferDate": {
            "type": "string",
            "format": "date"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.MapEntry"
            }
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.response.Debtor": {
        "required": [
          "entityUniqueIdentifierType",
          "entityUniqueIdentifierValue",
          "fullName"
        ],
        "type": "object",
        "properties": {
          "entityUniqueIdentifierType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "fullName": {
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
          "email": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.response.Payer": {
        "required": [
          "entityUniqueIdentifierType",
          "entityUniqueIdentifierValue",
          "fullName"
        ],
        "type": "object",
        "properties": {
          "entityUniqueIdentifierType": {
            "type": "string",
            "enum": [
              "F",
              "G"
            ]
          },
          "entityUniqueIdentifierValue": {
            "type": "string"
          },
          "fullName": {
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
          "email": {
            "type": "string"
          }
        }
      },
      "it.gov.pagopa.bizeventsservice.model.response.TransferPA": {
        "required": [
          "fiscalCodePA",
          "iban",
          "mbdAttachment",
          "remittanceInformation",
          "transferAmount",
          "transferCategory"
        ],
        "type": "object",
        "properties": {
          "idTransfer": {
            "maximum": 5,
            "minimum": 1,
            "type": "integer",
            "format": "int32"
          },
          "transferAmount": {
            "type": "number"
          },
          "fiscalCodePA": {
            "type": "string"
          },
          "iban": {
            "type": "string"
          },
          "mbdAttachment": {
            "type": "string"
          },
          "remittanceInformation": {
            "type": "string"
          },
          "transferCategory": {
            "type": "string"
          },
          "metadata": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/it.gov.pagopa.bizeventsservice.model.MapEntry"
            }
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
