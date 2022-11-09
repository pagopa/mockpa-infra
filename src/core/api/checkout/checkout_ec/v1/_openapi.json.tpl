{
  "openapi": "3.0.0",
  "info": {
    "version": "1.0.0",
    "title": "Pagopa Checkout for EC",
    "description": "This microservice that expose Checkout services to EC."
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/carts": {
      "post": {
        "operationId": "PostCarts",
        "description": "create a cart",
        "requestBody": {
          "description": "New Cart related to payment requests",
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CartRequest"
              }
            }
          }
        },
        "responses": {
          "302": {
            "description": "Redirect",
            "headers": {
              "location": {
                "description": "CheckOut Url",
                "schema": {
                  "type": "string",
                  "format": "uri"
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
      "CartRequest": {
        "type": "object",
        "required": [
          "paymentNotices",
          "returnurls"
        ],
        "properties": {
          "emailNotice": {
            "type": "string",
            "format": "email",
            "example": "my_email@mail.it"
          },
          "paymentNotices": {
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
                "amount": 1000
              },
              {
                "noticeNumber": "302012387654312385",
                "fiscalCode": "77777777777",
                "amount": 2000
              }
            ]
          },
          "returnurls": {
            "type": "object",
            "required": [
              "returnOkUrl",
              "returnCancelUrl",
              "retunErrorUrl"
            ],
            "properties": {
              "returnOkUrl": {
                "type": "string",
                "format": "uri",
                "example": "www.comune.di.prova.it/pagopa/success.html"
              },
              "returnCancelUrl": {
                "type": "string",
                "format": "uri",
                "example": "www.comune.di.prova.it/pagopa/cancel.html"
              },
              "retunErrorUrl": {
                "type": "string",
                "format": "uri",
                "example": "www.comune.di.prova.it/pagopa/error.html"
              }
            }
          }
        }
      },
      "PaymentNotice": {
        "type": "object",
        "required": [
          "noticeNumber",
          "fiscalCode",
          "amount"
        ],
        "properties": {
          "noticeNumber": {
            "type": "string",
            "minLength": 18,
            "maxLength": 18
          },
          "fiscalCode": {
            "type": "string",
            "minLength": 11,
            "maxLength": 11
          },
          "amount": {
            "type": "integer",
            "minimum": 1
          },
          "companyName": {
            "type": "string",
            "maxLength": 140
          },
          "description": {
            "type": "string",
            "maxLength": 140
          }
        }
      }
    },
    "requestBodies": {
      "CartRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/CartRequest"
            }
          }
        }
      }
    }
  }
}