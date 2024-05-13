{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "PagoPA API Calculator Logic",
    "description" : "Calculator Logic microservice for pagoPA AFM",
    "termsOfService" : "https://www.pagopa.gov.it/",
    "version" : "2.10.19"
  },
  "servers" : [ {
    "url": "${host}",
    "description" : "Generated server url"
  } ],
  "tags" : [ {
    "name" : "Calculator",
    "description" : "Everything about Calculator business logic"
  }, {
    "name" : "Configuration",
    "description" : "Utility Services"
  }, {
    "name" : "Actuator",
    "description" : "Monitor and interact",
    "externalDocs" : {
      "description" : "Spring Boot Actuator Web API Documentation",
      "url" : "https://docs.spring.io/spring-boot/docs/current/actuator-api/html/"
    }
  } ],
  "paths" : {
    "/psps/{idPsp}/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of the specified idPSP",
        "operationId" : "getFeesByPsp",
        "parameters" : [ {
          "name" : "idPsp",
          "in" : "path",
          "description" : "PSP identifier",
          "required" : true,
          "schema" : {
            "type" : "string"
          }
        }, {
          "name" : "maxOccurrences",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "allCcp",
          "in" : "query",
          "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "true"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentOptionByPsp"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "422" : {
            "description" : "Unable to process the request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200" : {
            "description" : "Ok",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BundleOption"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/fees" : {
      "post" : {
        "tags" : [ "Calculator" ],
        "summary" : "Get taxpayer fees of all or specified idPSP",
        "operationId" : "getFees",
        "parameters" : [ {
          "name" : "maxOccurrences",
          "in" : "query",
          "required" : false,
          "schema" : {
            "type" : "integer",
            "format" : "int32",
            "default" : 10
          }
        }, {
          "name" : "allCcp",
          "in" : "query",
          "description" : "Flag for the exclusion of Poste bundles: false -> excluded, true or null -> included",
          "required" : false,
          "schema" : {
            "type" : "string",
            "default" : "true"
          }
        } ],
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "$ref" : "#/components/schemas/PaymentOption"
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "422" : {
            "description" : "Unable to process the request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404" : {
            "description" : "Not Found",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200" : {
            "description" : "Ok",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/BundleOption"
                }
              }
            }
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/configuration/touchpoint/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deleteTouchpoints",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/configuration/touchpoint/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addTouchpoints",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/Touchpoint"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/configuration/paymenttypes/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deletePaymentTypes",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/configuration/paymenttypes/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addPaymentTypes",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/PaymentType"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/configuration/bundles/delete" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "deleteValidBundles",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/configuration/bundles/add" : {
      "post" : {
        "tags" : [ "Configuration" ],
        "operationId" : "addValidBundles",
        "requestBody" : {
          "content" : {
            "application/json" : {
              "schema" : {
                "type" : "array",
                "items" : {
                  "$ref" : "#/components/schemas/ValidBundle"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "200" : {
            "description" : "OK"
          }
        }
      }
    },
    "/info" : {
      "get" : {
        "tags" : [ "Home" ],
        "summary" : "health check",
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
          "429" : {
            "description" : "Too many requests"
          },
          "401" : {
            "description" : "Unauthorized"
          },
          "200" : {
            "description" : "OK",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "400" : {
            "description" : "Bad Request",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden"
          }
        },
        "security" : [ {
          "ApiKey" : [ ]
        } ]
      }
    },
    "/actuator" : {
      "get" : {
        "tags" : [ "Actuator" ],
        "summary" : "Actuator root web endpoint",
        "operationId" : "links",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/vnd.spring-boot.actuator.v3+json" : {
                "schema" : {
                  "type" : "object",
                  "additionalProperties" : {
                    "type" : "object",
                    "additionalProperties" : {
                      "$ref" : "#/components/schemas/Link"
                    }
                  }
                }
              },
              "application/vnd.spring-boot.actuator.v2+json" : {
                "schema" : {
                  "type" : "object",
                  "additionalProperties" : {
                    "type" : "object",
                    "additionalProperties" : {
                      "$ref" : "#/components/schemas/Link"
                    }
                  }
                }
              },
              "application/json" : {
                "schema" : {
                  "type" : "object",
                  "additionalProperties" : {
                    "type" : "object",
                    "additionalProperties" : {
                      "$ref" : "#/components/schemas/Link"
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "/actuator/info" : {
      "get" : {
        "tags" : [ "Actuator" ],
        "summary" : "Actuator web endpoint 'info'",
        "operationId" : "info",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/vnd.spring-boot.actuator.v3+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/json" : {
                "schema" : {
                  "type" : "object"
                }
              }
            }
          }
        }
      }
    },
    "/actuator/health" : {
      "get" : {
        "tags" : [ "Actuator" ],
        "summary" : "Actuator web endpoint 'health'",
        "operationId" : "health",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/vnd.spring-boot.actuator.v3+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/json" : {
                "schema" : {
                  "type" : "object"
                }
              }
            }
          }
        }
      }
    },
    "/actuator/health/**" : {
      "get" : {
        "tags" : [ "Actuator" ],
        "summary" : "Actuator web endpoint 'health-path'",
        "operationId" : "health-path",
        "responses" : {
          "200" : {
            "description" : "OK",
            "content" : {
              "application/vnd.spring-boot.actuator.v3+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/vnd.spring-boot.actuator.v2+json" : {
                "schema" : {
                  "type" : "object"
                }
              },
              "application/json" : {
                "schema" : {
                  "type" : "object"
                }
              }
            }
          }
        }
      }
    }
  },
  "components" : {
    "schemas" : {
      "PaymentOptionByPsp" : {
        "type" : "object",
        "properties" : {
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCreditorInstitution" : {
            "type" : "string"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "bin" : {
            "type" : "string"
          },
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "TransferListItem" : {
        "type" : "object",
        "properties" : {
          "creditorInstitution" : {
            "type" : "string"
          },
          "transferCategory" : {
            "type" : "string"
          },
          "digitalStamp" : {
            "type" : "boolean"
          }
        }
      },
      "ProblemJson" : {
        "type" : "object",
        "properties" : {
          "title" : {
            "type" : "string",
            "description" : "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status" : {
            "maximum" : 600,
            "minimum" : 100,
            "type" : "integer",
            "description" : "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format" : "int32",
            "example" : 200
          },
          "detail" : {
            "type" : "string",
            "description" : "A human readable explanation specific to this occurrence of the problem.",
            "example" : "There was an error processing the request"
          }
        }
      },
      "BundleOption" : {
        "type" : "object",
        "properties" : {
          "belowThreshold" : {
            "type" : "boolean",
            "description" : "if true (the payment amount is lower than the threshold value) the bundles onus is not calculated (always false)"
          },
          "bundleOptions" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/Transfer"
            }
          }
        }
      },
      "Transfer" : {
        "type" : "object",
        "properties" : {
          "taxPayerFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCiIncurredFee" : {
            "type" : "integer",
            "format" : "int64"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "idBundle" : {
            "type" : "string"
          },
          "bundleName" : {
            "type" : "string"
          },
          "bundleDescription" : {
            "type" : "string"
          },
          "idCiBundle" : {
            "type" : "string"
          },
          "idPsp" : {
            "type" : "string"
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "onUs" : {
            "type" : "boolean"
          },
          "abi" : {
            "type" : "string"
          },
          "pspBusinessName" : {
            "type" : "string"
          }
        }
      },
      "PaymentOption" : {
        "required" : [ "paymentAmount", "primaryCreditorInstitution", "transferList" ],
        "type" : "object",
        "properties" : {
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "primaryCreditorInstitution" : {
            "type" : "string"
          },
          "bin" : {
            "type" : "string"
          },
          "paymentMethod" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "idPspList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/PspSearchCriteria"
            }
          },
          "transferList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/TransferListItem"
            }
          }
        }
      },
      "PspSearchCriteria" : {
        "required" : [ "idPsp" ],
        "type" : "object",
        "properties" : {
          "idPsp" : {
            "type" : "string"
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          }
        }
      },
      "Touchpoint" : {
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "creationDate" : {
            "type" : "string",
            "format" : "date-time"
          }
        }
      },
      "PaymentType" : {
        "required" : [ "id", "name" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "createdDate" : {
            "type" : "string",
            "format" : "date-time"
          }
        }
      },
      "CiBundle" : {
        "required" : [ "ciFiscalCode", "id" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "ciFiscalCode" : {
            "type" : "string"
          },
          "attributes" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CiBundleAttribute"
            }
          }
        }
      },
      "CiBundleAttribute" : {
        "required" : [ "id" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "maxPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "transferCategory" : {
            "type" : "string"
          },
          "transferCategoryRelation" : {
            "type" : "string",
            "enum" : [ "EQUAL", "NOT_EQUAL" ]
          }
        }
      },
      "ValidBundle" : {
        "required" : [ "digitalStamp", "digitalStampRestriction" ],
        "type" : "object",
        "properties" : {
          "id" : {
            "type" : "string"
          },
          "idPsp" : {
            "type" : "string"
          },
          "abi" : {
            "type" : "string"
          },
          "pspBusinessName" : {
            "type" : "string"
          },
          "name" : {
            "type" : "string"
          },
          "description" : {
            "type" : "string"
          },
          "paymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "minPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "maxPaymentAmount" : {
            "type" : "integer",
            "format" : "int64"
          },
          "paymentType" : {
            "type" : "string"
          },
          "touchpoint" : {
            "type" : "string"
          },
          "type" : {
            "type" : "string",
            "enum" : [ "GLOBAL", "PUBLIC", "PRIVATE" ]
          },
          "transferCategoryList" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          },
          "idChannel" : {
            "type" : "string"
          },
          "idBrokerPsp" : {
            "type" : "string"
          },
          "digitalStamp" : {
            "type" : "boolean"
          },
          "digitalStampRestriction" : {
            "type" : "boolean"
          },
          "onUs" : {
            "type" : "boolean"
          },
          "ciBundleList" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/CiBundle"
            }
          }
        }
      },
      "AppInfo" : {
        "type" : "object",
        "properties" : {
          "name" : {
            "type" : "string"
          },
          "version" : {
            "type" : "string"
          },
          "environment" : {
            "type" : "string"
          }
        }
      },
      "Link" : {
        "type" : "object",
        "properties" : {
          "href" : {
            "type" : "string"
          },
          "templated" : {
            "type" : "boolean"
          }
        }
      }
    },
    "securitySchemes" : {
      "ApiKey" : {
        "type" : "apiKey",
        "description" : "The API key to access this function app.",
        "name" : "Ocp-Apim-Subscription-Key",
        "in" : "header"
      }
    }
  }
}