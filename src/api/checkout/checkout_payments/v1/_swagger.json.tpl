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
    "/payment-requests/{rptId}": {
      "parameters": [
        {
          "name": "rptId",
          "in": "path",
          "required": true,
          "description": "Unique identifier for payments.",
          "type": "string"
        },
        {
          "name": "test",
          "in": "query",
          "description": "Use test environment of PagoPAClient",
          "type": "boolean",
          "required": false
        }
      ],
      "get": {
        "operationId": "getPaymentInfo",
        "summary": "Get Payment Info",
        "description": "Retrieve information about a payment",
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
            "description": "Bad request",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "401": {
            "description": "Bearer token null or expired."
          },
          "500": {
            "description": "PagoPA services are not available or request is rejected",
            "schema": {
              "$ref": "#/definitions/PaymentProblemJson"
            }
          }
        }
      }
    },
    "/payment-activations": {
      "parameters": [
        {
          "name": "test",
          "in": "query",
          "description": "Use test environment of PagoPAClient",
          "type": "boolean",
          "required": false
        }
      ],
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
            "description": "Bad request",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "401": {
            "description": "Bearer token null or expired."
          },
          "500": {
            "description": "PagoPA services are not available or request is rejected",
            "schema": {
              "$ref": "#/definitions/PaymentProblemJson"
            }
          }
        }
      }
    },
    "/payment-activations/{codiceContestoPagamento}": {
      "parameters": [
        {
          "name": "codiceContestoPagamento",
          "in": "path",
          "required": true,
          "description": "Transaction Id used to identify the communication flow.",
          "type": "string"
        },
        {
          "name": "test",
          "in": "query",
          "description": "Use test environment of PagoPAClient",
          "type": "boolean",
          "required": false
        }
      ],
      "get": {
        "operationId": "getActivationStatus",
        "summary": "Get Activation status",
        "description": "Check the activation status to retrieve the paymentId",
        "responses": {
          "200": {
            "description": "Payment information",
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
          "401": {
            "description": "Bearer token null or expired."
          },
          "404": {
            "description": "Activation status not found",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          },
          "500": {
            "description": "Unavailable service",
            "schema": {
              "$ref": "#/definitions/ProblemJson"
            }
          }
        }
      }
    },
    "/browsers/current/info": {
      "get": {
        "operationId": "GetBrowsersInfo",
        "description": "Get info of the current browser used by the user",
        "responses": {
          "200": {
            "description": "Browser info retrieved",
            "schema": {
              "$ref": "#/definitions/BrowserInfoResponse"
            }
          },
          "400": {
            "description": "Bad request"
          },
          "500": {
            "description": "generic error"
          }
        }
      }
    }
  },
  "definitions": {
    "ProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-functions-commons/v10.7.0/openapi/definitions.yaml#/ProblemJson"
    },
    "PaymentProblemJson": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/PaymentProblemJson"
    },
    "CodiceContestoPagamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/CodiceContestoPagamento"
    },
    "EnteBeneficiario": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/EnteBeneficiario"
    },
    "Iban": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/Iban"
    },
    "ImportoEuroCents": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/ImportoEuroCents"
    },
    "PaymentActivationsGetResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/PaymentActivationsGetResponse"
    },
    "PaymentActivationsPostRequest": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/PaymentActivationsPostRequest"
    },
    "PaymentActivationsPostResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/PaymentActivationsPostResponse"
    },
    "PaymentRequestsGetResponse": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/PaymentRequestsGetResponse"
    },
    "RptId": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/RptId"
    },
    "SpezzoneStrutturatoCausaleVersamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/SpezzoneStrutturatoCausaleVersamento"
    },
    "SpezzoniCausaleVersamento": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/SpezzoniCausaleVersamento"
    },
    "SpezzoniCausaleVersamentoItem": {
      "$ref": "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.0/api_pagopa.yaml#/definitions/SpezzoniCausaleVersamentoItem"
    },
    "BrowserInfoResponse": {
      "type": "object",
      "required": [
        "ip",
        "useragent",
        "accept"
      ],
      "properties": {
        "ip": {
          "type": "string"
        },
        "useragent": {
          "type": "string"
        },
        "accept": {
          "type": "string"
        }
      }
    }
  }
}
