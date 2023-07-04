{
  "openapi": "3.0.1",
  "info": {
    "title": "Mock Configurator",
    "description": "A service that permits to configure the mocked responses used by Mocker service",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "1.0.1"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "name": "Mock Resources",
      "description": "Everything about Mock Resources"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "Return the application running status",
        "operationId": "healthCheck",
        "responses": {
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
                  "$ref": "#/components/schemas/AppInfo"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
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
    "/resources": {
      "get": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Get paginated list of mock resource",
        "operationId": "getMockResources",
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "description": "The number of elements to be included in the page.",
            "required": true,
            "schema": {
              "maximum": 999,
              "type": "integer",
              "format": "int32",
              "default": 10
            }
          },
          {
            "name": "page",
            "in": "query",
            "description": "The index of the page, starting from 0.",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32",
              "default": 0
            }
          }
        ],
        "responses": {
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
                  "$ref": "#/components/schemas/MockResourceList"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "post": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Create a new mock resource",
        "operationId": "createMockResource",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MockResource"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Created",
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
                  "$ref": "#/components/schemas/MockResource"
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
          "409": {
            "description": "Conflict",
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
                  "$ref": "#/components/schemas/ProblemJson"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
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
    "/resources/import": {
      "post": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Create multiple mock resources from OpenAPI specification",
        "operationId": "createMockResource_1",
        "responses": {
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
                  "$ref": "#/components/schemas/MockResource"
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
          "409": {
            "description": "Conflict",
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
                  "$ref": "#/components/schemas/ProblemJson"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
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
    "/resources/{resourceId}": {
      "get": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Get detail of a single mock resource",
        "operationId": "getMockResource",
        "parameters": [
          {
            "name": "resourceId",
            "in": "path",
            "description": "The identifier related to the mock resource",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
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
                  "$ref": "#/components/schemas/MockResource"
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
          "404": {
            "description": "Not Found",
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
                  "$ref": "#/components/schemas/ProblemJson"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "put": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Update an existing mock resource",
        "operationId": "updateMockResource",
        "parameters": [
          {
            "name": "resourceId",
            "in": "path",
            "description": "The identifier related to the mock resource",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MockResource"
              }
            }
          },
          "required": true
        },
        "responses": {
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
                  "$ref": "#/components/schemas/MockResource"
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
          "404": {
            "description": "Not Found",
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
                  "$ref": "#/components/schemas/ProblemJson"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "delete": {
        "tags": [
          "Mock Resources"
        ],
        "summary": "Delete an existing mock resource",
        "operationId": "deleteMockResource",
        "parameters": [
          {
            "name": "resourceId",
            "in": "path",
            "description": "The identifier related to the mock resource",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
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
                  "$ref": "#/components/schemas/MockResource"
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
          "404": {
            "description": "Not Found",
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
                  "$ref": "#/components/schemas/ProblemJson"
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
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
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
      "MockCondition": {
        "required": [
          "analyzed_content_type",
          "condition_type",
          "field_name",
          "field_position"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "The unique identifier of the mock condition.",
            "example": "6b0b003d-74f4-428e-b950-61f42e02bf07"
          },
          "order": {
            "type": "integer",
            "description": "The cardinal order on which the mock condition will be evaluated by Mocker.",
            "format": "int32"
          },
          "field_position": {
            "type": "string",
            "description": "The parameter that define where the field/element that will be evaluated by this condition is located in the request.",
            "example": "BODY",
            "enum": [
              "BODY",
              "HEADER",
              "URL"
            ]
          },
          "analyzed_content_type": {
            "type": "string",
            "description": "The parameter that define the type of the source in the request where the field/element that will be evaluated by this condition will be extracted.",
            "example": "JSON",
            "enum": [
              "JSON",
              "XML",
              "STRING"
            ]
          },
          "field_name": {
            "type": "string",
            "description": "The parameter that define the identifier of the field/element that will be evaluated by this condition",
            "example": "station.id"
          },
          "condition_type": {
            "type": "string",
            "description": "The parameter that define the type of condition that will be applied on the field/element that will be evaluated.",
            "example": "EQ",
            "enum": [
              "REGEX",
              "EQ",
              "NEQ",
              "LT",
              "GT",
              "LE",
              "GE",
              "NULL",
              "ANY"
            ]
          },
          "condition_value": {
            "type": "string",
            "description": "The parameter that define the value that the field/element must respect following the condition type.",
            "example": "77777777777_01"
          }
        },
        "description": "The condition applied to the mock rule that a request must respect in order to retrieve the mocked response related to the rule."
      },
      "MockResource": {
        "required": [
          "http_method",
          "is_active",
          "name",
          "resource_url",
          "rules",
          "subsystem",
          "tags"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "The unique identifier of the mock resource.",
            "example": "70aa0abb-0001-0212-aa01-2cb1a0f00301"
          },
          "name": {
            "type": "string",
            "description": "The name or description related to the mock resources, for human readability.",
            "example": "Get enrolled organization with ID 77777777777"
          },
          "subsystem": {
            "type": "string",
            "description": "The URL section that define the subsystem on which the mock resource is related.",
            "example": "apiconfig/api/v1"
          },
          "resource_url": {
            "type": "string",
            "description": "The specific URL on which the mock resource will be defined for the subsystem.",
            "example": "organizations/77777777777"
          },
          "http_method": {
            "type": "string",
            "description": "The HTTP method related to the mock resource.",
            "example": "GET",
            "enum": [
              "GET",
              "POST",
              "PUT",
              "DELETE",
              "PATCH",
              "OPTIONS"
            ]
          },
          "is_active": {
            "type": "boolean",
            "description": "The status flag that permits to activate or not the mock resource for Mocker evaluation.",
            "example": true
          },
          "tags": {
            "type": "array",
            "description": "The set of tags on which the mock resource is related to.",
            "items": {
              "type": "string",
              "description": "The set of tags on which the mock resource is related to."
            }
          },
          "rules": {
            "type": "array",
            "description": "The list of rules related to the mock resource that will be evaluated by the Mocker.",
            "items": {
              "$ref": "#/components/schemas/MockRule"
            }
          }
        },
        "description": "The mock resource, analyzed by Mocker, that permits to generate different responses based by rules and conditions."
      },
      "MockResponse": {
        "required": [
          "headers",
          "parameters",
          "status"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "The unique identifier of the mock response",
            "example": "26e05a1f-9621-4e24-a57d-28694ff30306"
          },
          "body": {
            "type": "string",
            "description": "The response body in Base64 format related to the mock response.",
            "example": "eyJtZXNzYWdlIjoiT0shIn0="
          },
          "status": {
            "type": "integer",
            "description": "The HTTP response status related to the mock response.",
            "format": "int32",
            "example": 200
          },
          "headers": {
            "type": "array",
            "description": "The list of header to be set to mock response.",
            "items": {
              "$ref": "#/components/schemas/ResponseHeader"
            }
          },
          "parameters": {
            "type": "array",
            "description": "The list of parameters that will be injected from request body to response body by Mocker.",
            "items": {
              "type": "string",
              "description": "The list of parameters that will be injected from request body to response body by Mocker."
            }
          }
        },
        "description": "The mocked response that will be generated by Mocker if the rule condition are all verified."
      },
      "MockRule": {
        "required": [
          "conditions",
          "is_active",
          "name",
          "order",
          "response",
          "tags"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string",
            "description": "The unique identifier of the mock rule",
            "example": "6c08a21c-6a92-4f6b-a1e1-bf68c4e099c9"
          },
          "name": {
            "type": "string",
            "description": "The name or description related to the mock rule, for human readability.",
            "example": "Main rule"
          },
          "order": {
            "type": "integer",
            "description": "The cardinal order on which the mock role will be evaluated by Mocker.",
            "format": "int32",
            "example": 1
          },
          "is_active": {
            "type": "boolean",
            "description": "The status flag that permits to activate or not the mock rule for Mocker evaluation.",
            "example": true
          },
          "tags": {
            "type": "array",
            "description": "The set of tags on which the mock rule is related to.",
            "items": {
              "type": "string",
              "description": "The set of tags on which the mock rule is related to."
            }
          },
          "conditions": {
            "type": "array",
            "description": "The list of condition related to the mock rule that will be evaluated in AND by the Mocker.",
            "items": {
              "$ref": "#/components/schemas/MockCondition"
            }
          },
          "response": {
            "$ref": "#/components/schemas/MockResponse"
          }
        },
        "description": "The rule a passed request can follow in order to obtain the defined mocked response."
      },
      "ResponseHeader": {
        "required": [
          "name",
          "value"
        ],
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "The key of the header to be set to mock response by Mocker.",
            "example": "Content-Type"
          },
          "value": {
            "type": "string",
            "description": "The value of the header to be set to mock response by Mocker.",
            "example": "application/json"
          }
        },
        "description": "The header that will be set to a mocked response"
      },
      "ProblemJson": {
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
      "MockResourceList": {
        "required": [
          "page_info",
          "resources"
        ],
        "type": "object",
        "properties": {
          "resources": {
            "type": "array",
            "description": "The list of retrieved mock resources.",
            "items": {
              "$ref": "#/components/schemas/MockResource"
            }
          },
          "page_info": {
            "$ref": "#/components/schemas/PageInfo"
          }
        },
        "description": "The paginated list of mock resources."
      },
      "PageInfo": {
        "type": "object",
        "properties": {
          "page": {
            "type": "integer",
            "description": "Page number",
            "format": "int32"
          },
          "limit": {
            "type": "integer",
            "description": "Required number of items per page",
            "format": "int32"
          },
          "items_found": {
            "type": "integer",
            "description": "Number of items found. (The last page may have fewer elements than required)",
            "format": "int32"
          },
          "total_pages": {
            "type": "integer",
            "description": "Total number of pages",
            "format": "int32"
          }
        },
        "description": "The information related to the result page."
      },
      "AppInfo": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "The name of the application."
          },
          "version": {
            "type": "string",
            "description": "The version related to the installed application."
          },
          "environment": {
            "type": "string",
            "description": "The environment tag on which the application is installed."
          },
          "db_connection": {
            "type": "string",
            "description": "The status related to the database connection.",
            "enum": [
              "up",
              "down"
            ]
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
      },
      "Authorization": {
        "type": "http",
        "description": "JWT token get after Azure Login",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}
