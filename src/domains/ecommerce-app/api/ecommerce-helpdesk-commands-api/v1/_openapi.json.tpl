{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa helpdesk commands services",
    "description": "This microservice exposes API for for manual operation related to eCommerce transactions"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "helpdeskCommands",
      "description": "Api's for performing money refund operations over failed transactions",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
        "description": "Technical specifications"
      }
    }
  ],
  "paths": {
    "/commands/refund": {
      "post": {
        "tags": [
          "ecommerce"
        ],
        "operationId": "refundOperation",
        "summary": "Api's for performing money refunds operations over failed transactions",
        "description": "POST with body payload - no resources created",
        "requestBody": {
          "$ref": "#/components/requestBodies/RefundTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "Transactions refunded",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RefundTransactionResponse"
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
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "RefundTransactionResponse": {
        "type": "object",
        "properties": {
          "refundOperationId": {
            "type": "string",
            "description": "The id of the refunded operation, if any",
            "default": 0
          }
        }
      },
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
      "RefundTransactionRequest": {
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string",
            "description": "The id of the transaction",
            "minLength": 32,
            "maxLength": 32
          },
          "paymentMethodName": {
            "type": "string",
            "description": "The name of the payment method"
          },
          "pspId": {
            "type": "string",
            "description": "The id of the psp"
          },
          "operationId": {
            "type": "string",
            "description": "The id of the operation"
          },
          "correlationId": {
            "type": "string",
            "description": "correlation id for a transaction executed with NPG"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "transactionId",
          "paymentMethodName",
          "pspId",
          "operationId",
          "correlationId",
          "amount"
        ]
      }
    },
    "requestBodies": {
      "RefundTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RefundTransactionRequest"
            }
          }
        }
      }
    }
  }
}