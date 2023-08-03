{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa eCommerce services for assistence api",
    "description": "This microservice that expose eCommerce services for assistence api."
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "PM",
      "description": "Api's for performing transaction search on PM DB",
      "externalDocs": {
        "url": "TODO",
        "description": "Technical specifications"
      }
    },
    {
      "name": "eCommerce",
      "description": "Api's for performing transaction search on ecommerce DB",
      "externalDocs": {
        "url": "TODO",
        "description": "Technical specifications"
      }
    },
    {
      "name": "helpDesk",
      "description": "Api's for performing transaction search on ecommerce DB",
      "externalDocs": {
        "url": "TODO",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/pm/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "PM"
        ],
        "operationId": "pmSearchTransaction",
        "summary": "Search transaction by input parmeters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/PmSearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
    },
    "/ecommerce/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "eCommerce"
        ],
        "operationId": "ecommerceSearchTransaction",
        "summary": "Search transaction by input parmeters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/EcommerceSearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
    },
    "/helpdesk/searchTransaction": {
      "post": {
        "parameters": [
          {
            "in": "query",
            "name": "pageNumber",
            "schema": {
              "type": "integer",
              "default": 0
            },
            "required": true,
            "description": "Searched page number, starting from 0"
          },
          {
            "in": "query",
            "name": "pageSize",
            "schema": {
              "type": "integer",
              "default": 10
            },
            "required": true,
            "description": "Max element per page"
          }
        ],
        "tags": [
          "helpDesk"
        ],
        "operationId": "helpDeskSearchTransaction",
        "summary": "Search transaction by input parmeters",
        "description": "GET with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/SearchTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SearchTransactionResponse"
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
            "description": "Transaction not found",
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
      "ProblemJson": {
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
      "PmSearchTransactionRequestFiscalCode": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "userFiscalCode": {
            "type": "string",
            "minLength": 16,
            "maxLength": 16
          }
        },
        "required": [
          "type",
          "userFiscalCode"
        ],
        "example": {
          "type": "USER_FISCAL_CODE",
          "userFiscalCode": "MRGHRN97L02C469W"
        }
      },
      "PmSearchTransactionRequestEmail": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "userEmail": {
            "type": "string",
            "pattern": "(?:[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+\\/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(?:25[0-5]|2[0-4]\\d|[01]?\\d\\d?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
          }
        },
        "required": [
          "type",
          "userEmail"
        ],
        "example": {
          "type": "USER_EMAIL",
          "userEmail": "mario.rossi@pagopa.it"
        }
      },
      "SearchTransactionResponse": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "transactions": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/TransactionResult"
            }
          },
          "page": {
            "$ref": "#/components/schemas/PageInfo"
          }
        },
        "required": [
          "transactions",
          "page"
        ]
      },
      "EcommerceSearchTransactionRequestRptId": {
        "type": "object",
        "description": "Search transaction by user fiscal code",
        "properties": {
          "type": {
            "type": "string"
          },
          "rptId": {
            "type": "string",
            "pattern": "^([0-9]{29})$"
          }
        },
        "required": [
          "type",
          "rptId"
        ],
        "example": {
          "type": "RPT_ID",
          "rptId": "77777777777302011111111111111"
        }
      },
      "EcommerceSearchTransactionRequestPaymentToken": {
        "type": "object",
        "description": "Search transaction by payment token",
        "properties": {
          "type": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          }
        },
        "required": [
          "type",
          "paymentToken"
        ],
        "example": {
          "type": "PAYMENT_TOKEN",
          "paymentToken": "paymentToken"
        }
      },
      "EcommerceSearchTransactionRequestTransactionId": {
        "type": "object",
        "description": "Search transaction by transaction id",
        "properties": {
          "type": {
            "type": "string"
          },
          "transactionId": {
            "type": "string",
            "minLength": 32,
            "maxLength": 32
          }
        },
        "required": [
          "type",
          "transactionId"
        ],
        "example": {
          "type": "TRANSACTION_ID",
          "transactionId": "c9644451389e47b0a7d8e9d488fcd502"
        }
      },
      "TransactionResult": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "transactionInfo": {
            "$ref": "#/components/schemas/TransactionInfo"
          },
          "paymentInfo": {
            "$ref": "#/components/schemas/PaymentInfo"
          },
          "paymentDetailInfo": {
            "$ref": "#/components/schemas/PaymentDetailInfo"
          },
          "pspInfo": {
            "$ref": "#/components/schemas/PspInfo"
          },
          "product": {
            "$ref": "#/components/schemas/Product"
          }
        },
        "required": [
          "transactionInfo",
          "paymentInfo",
          "paymentDetailInfo",
          "pspInfo",
          "product"
        ]
      },
      "TransactionInfo": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "creationDate": {
            "type": "string",
            "format": "date-time",
            "description": "transaction creation date"
          },
          "status": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fee": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "grandTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "example": {
          "creationDate": "2023-08-02T14:42:54.047",
          "status": "TO BE DEFINED",
          "amount": 100,
          "fee": 10,
          "grandTotal": 110
        }
      },
      "PaymentInfo": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "subject": {
            "type": "string"
          },
          "origin": {
            "type": "string"
          }
        },
        "example": {
          "amount": 100,
          "subject": "Causale pagamento",
          "origin": "CHECKOUT"
        }
      },
      "PaymentDetailInfo": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "iuv": {
            "type": "string",
            "minLength": 18,
            "maxLength": 18
          },
          "paymentContextCode": {
            "type": "string"
          },
          "creditorInstitution": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "paFiscalCode": {
            "type": "string"
          }
        },
        "example": {
          "iuv": "302001069073736640",
          "paymentContextCode": "paymentContextCode",
          "creditorInstitution": "66666666666",
          "amount": 99999999,
          "paFiscalCode": "77777777777"
        }
      },
      "PspInfo": {
        "type": "object",
        "description": "TransactionResponse",
        "properties": {
          "pspId": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "idChannel": {
            "type": "string"
          }
        },
        "example": {
          "pspId": "EXAMPLEPSP",
          "businessName": "businessName",
          "idChannel": "13212880150_02_ONUS"
        }
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "PageInfo": {
        "description": "Informations about the returned query page",
        "type": "object",
        "properties": {
          "current": {
            "type": "integer",
            "description": "Current returned page index (0-based)"
          },
          "total": {
            "type": "integer",
            "description": "Total pages for the query (based on requested page size)"
          },
          "results": {
            "type": "integer",
            "description": "Transactions returned into the current page"
          }
        },
        "required": [
          "current",
          "results",
          "total"
        ]
      },
      "Product": {
        "type": "string",
        "enum": [
          "PM",
          "ECOMMERCE"
        ],
        "description": "Product from which transaction belongs"
      },
      "PmSearchTransactionRequest": {
        "type": "object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/PmSearchTransactionRequestFiscalCode"
          },
          {
            "$ref": "#/components/schemas/PmSearchTransactionRequestEmail"
          }
        ],
        "discriminator": {
          "propertyName": "type",
          "mapping": {
            "USER_FISCAL_CODE": "#/components/schemas/PmSearchTransactionRequestFiscalCode",
            "USER_EMAIL": "#/components/schemas/PmSearchTransactionRequestEmail"
          }
        }
      },
      "EcommerceSearchTransactionRequest": {
        "type": "object",
        "oneOf": [
          {
            "$ref": "#/components/schemas/EcommerceSearchTransactionRequestRptId"
          },
          {
            "$ref": "#/components/schemas/EcommerceSearchTransactionRequestPaymentToken"
          },
          {
            "$ref": "#/components/schemas/EcommerceSearchTransactionRequestTransactionId"
          }
        ],
        "discriminator": {
          "propertyName": "type",
          "mapping": {
            "RPT_ID": "#/components/schemas/EcommerceSearchTransactionRequestRptId",
            "PAYMENT_TOKEN": "#/components/schemas/EcommerceSearchTransactionRequestPaymentToken",
            "TRANSACTION_ID": "#/components/schemas/EcommerceSearchTransactionRequestTransactionId"
          }
        }
      }
    },
    "requestBodies": {
      "PmSearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/PmSearchTransactionRequestFiscalCode"
                },
                {
                  "$ref": "#/components/schemas/PmSearchTransactionRequestEmail"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "USER_FISCAL_CODE": "#/components/schemas/PmSearchTransactionRequestFiscalCode",
                  "USER_EMAIL": "#/components/schemas/PmSearchTransactionRequestEmail"
                }
              }
            },
            "examples": {
              "search by user fiscal code": {
                "value": {
                  "type": "USER_FISCAL_CODE",
                  "userFiscalCode": "user_fiscal_code"
                }
              },
              "search by user email": {
                "value": {
                  "type": "USER_EMAIL",
                  "userEmail": "test@test.it"
                }
              }
            }
          }
        }
      },
      "PmSearchTransactionResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/SearchTransactionResponse"
            }
          }
        }
      },
      "EcommerceSearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/EcommerceSearchTransactionRequestRptId"
                },
                {
                  "$ref": "#/components/schemas/EcommerceSearchTransactionRequestPaymentToken"
                },
                {
                  "$ref": "#/components/schemas/EcommerceSearchTransactionRequestTransactionId"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "RPT_ID": "#/components/schemas/EcommerceSearchTransactionRequestRptId",
                  "PAYMENT_TOKEN": "#/components/schemas/EcommerceSearchTransactionRequestPaymentToken",
                  "TRANSACTION_ID": "#/components/schemas/EcommerceSearchTransactionRequestTransactionId"
                }
              }
            },
            "examples": {
              "search by rpt id": {
                "value": {
                  "type": "RPT_ID",
                  "rptId": "77777777777111111111111111111"
                }
              },
              "search by payment token": {
                "value": {
                  "type": "PAYMENT_TOKEN",
                  "paymentToken": "paymentToken"
                }
              },
              "search by transaction id": {
                "value": {
                  "type": "TRANSACTION_ID",
                  "transactionId": "transactionId"
                }
              }
            }
          }
        }
      },
      "EcommerceSearchTransactionResponse": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/SearchTransactionResponse"
            }
          }
        }
      },
      "SearchTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "oneOf": [
                {
                  "$ref": "#/components/schemas/PmSearchTransactionRequest"
                },
                {
                  "$ref": "#/components/schemas/EcommerceSearchTransactionRequest"
                }
              ],
              "discriminator": {
                "propertyName": "type",
                "mapping": {
                  "USER_FISCAL_CODE": "#/components/schemas/PmSearchTransactionRequestFiscalCode",
                  "USER_EMAIL": "#/components/schemas/PmSearchTransactionRequestEmail",
                  "RPT_ID": "#/components/schemas/EcommerceSearchTransactionRequestRptId",
                  "PAYMENT_TOKEN": "#/components/schemas/EcommerceSearchTransactionRequestPaymentToken",
                  "TRANSACTION_ID": "#/components/schemas/EcommerceSearchTransactionRequestTransactionId"
                }
              }
            },
            "examples": {
              "search by user fiscal code": {
                "value": {
                  "type": "USER_FISCAL_CODE",
                  "userFiscalCode": "user_fiscal_code"
                }
              },
              "search by user email": {
                "value": {
                  "type": "USER_EMAIL",
                  "userEmail": "test@test.it"
                }
              },
              "search by rpt id": {
                "value": {
                  "type": "RPT_ID",
                  "rptId": "77777777777111111111111111111"
                }
              },
              "search by payment token": {
                "value": {
                  "type": "PAYMENT_TOKEN",
                  "paymentToken": "paymentToken"
                }
              },
              "search by transaction id": {
                "value": {
                  "type": "TRANSACTION_ID",
                  "transactionId": "transactionId"
                }
              }
            }
          }
        }
      }
    }
  }
}