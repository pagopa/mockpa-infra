{
  "openapi" : "3.0.1",
  "info" : {
    "title" : "pagopa-gpd-upload",
    "version" : "0.0.1"
  },
  "paths" : {
    "/brokers/{broker-code}/organizations/{organization-fiscal-code}/debtpositions/file" : {
      "post" : {
        "tags" : [ "File Upload API" ],
        "summary" : "The Organization creates the debt positions listed in the file.",
        "operationId" : "upload-debt-positions-file",
        "parameters" : [ {
          "name" : "broker-code",
          "in" : "path",
          "description" : "The broker code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        }, {
          "name" : "organization-fiscal-code",
          "in" : "path",
          "description" : "The organization fiscal code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        } ],
        "requestBody" : {
          "content" : {
            "multipart/form-data" : {
              "schema" : {
                "type" : "object",
                "properties" : {
                  "file" : {
                    "type" : "string",
                    "format" : "binary"
                  }
                }
              },
              "encoding" : {
                "file" : {
                  "contentType" : "application/octet-stream"
                }
              }
            }
          },
          "required" : true
        },
        "responses" : {
          "202" : {
            "description" : "Request accepted."
          },
          "400" : {
            "description" : "Malformed request.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
                }
              }
            }
          },
          "409" : {
            "description" : "Conflict: duplicate file found.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/brokers/{broker-code}/organizations/{organization-fiscal-code}/debtpositions/file/{file-ID}/report" : {
      "get" : {
        "tags" : [ "File Upload API" ],
        "summary" : "Returns the result of debt positions upload.",
        "operationId" : "get-debt-positions-upload-result",
        "parameters" : [ {
          "name" : "broker-code",
          "in" : "path",
          "description" : "The broker code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        }, {
          "name" : "organization-fiscal-code",
          "in" : "path",
          "description" : "The organization fiscal code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        }, {
          "name" : "file-ID",
          "in" : "path",
          "description" : "The fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Upload result found.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/UploadReport"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
                }
              }
            }
          },
          "404" : {
            "description" : "Upload result not found.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/brokers/{broker-code}/organizations/{organization-fiscal-code}/debtpositions/file/{file-ID}/status" : {
      "get" : {
        "tags" : [ "File Upload API" ],
        "summary" : "Returns the upload status of debt positions uploaded via file.",
        "operationId" : "get-debt-positions-upload-status",
        "parameters" : [ {
          "name" : "broker-code",
          "in" : "path",
          "description" : "The broker code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        }, {
          "name" : "organization-fiscal-code",
          "in" : "path",
          "description" : "The organization fiscal code",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        }, {
          "name" : "file-ID",
          "in" : "path",
          "description" : "The fiscal code of the Organization.",
          "required" : true,
          "schema" : {
            "minLength" : 1,
            "type" : "string"
          }
        } ],
        "responses" : {
          "200" : {
            "description" : "Upload found.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/UploadStatus"
                }
              }
            }
          },
          "400" : {
            "description" : "Malformed request.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401" : {
            "description" : "Wrong or missing function key.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
                }
              }
            }
          },
          "404" : {
            "description" : "Upload not found.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500" : {
            "description" : "Service unavailable.",
            "content" : {
              "application/json" : {
                "schema" : {
                  "$ref" : "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    },
    "/info" : {
      "get" : {
        "tags" : [ "Base" ],
        "summary" : "health check",
        "description" : "Return OK if application is started",
        "operationId" : "healthCheck",
        "responses" : {
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
          "401" : {
            "description" : "Unauthorized",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
                }
              }
            }
          },
          "403" : {
            "description" : "Forbidden",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
                }
              }
            }
          },
          "429" : {
            "description" : "Too many requests",
            "content" : {
              "application/json" : {
                "schema" : {
                  "allOf" : [ ],
                  "anyOf" : [ ],
                  "oneOf" : [ ]
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
          }
        }
      }
    }
  },
  "components" : {
    "schemas" : {
      "AppInfo" : {
        "type" : "object"
      },
      "ProblemJson" : {
        "type" : "object",
        "description" : "Object returned as response in case of an error."
      },
      "ResponseEntry" : {
        "type" : "object",
        "properties" : {
          "statusCode" : {
            "type" : "integer",
            "format" : "int32",
            "example" : 400
          },
          "statusMessage" : {
            "type" : "string",
            "example" : "Bad request caused by invalid email address"
          },
          "requestIDs" : {
            "type" : "array",
            "items" : {
              "type" : "string"
            }
          }
        }
      },
      "UploadReport" : {
        "type" : "object",
        "properties" : {
          "uploadID" : {
            "type" : "string"
          },
          "processedItem" : {
            "type" : "integer",
            "format" : "int32"
          },
          "submittedItem" : {
            "type" : "integer",
            "format" : "int32"
          },
          "startTime" : {
            "type" : "string",
            "format" : "date-time",
            "example" : "2024-10-08T14:55:16.302Z"
          },
          "endTime" : {
            "type" : "string",
            "format" : "date-time",
            "example" : "2024-10-08T14:55:16.302Z"
          },
          "responses" : {
            "type" : "array",
            "items" : {
              "$ref" : "#/components/schemas/ResponseEntry"
            }
          }
        }
      },
      "UploadStatus" : {
        "type" : "object",
        "properties" : {
          "uploadID" : {
            "type" : "string"
          },
          "processedItem" : {
            "type" : "integer",
            "format" : "int32"
          },
          "submittedItem" : {
            "type" : "integer",
            "format" : "int32"
          },
          "startTime" : {
            "type" : "string",
            "format" : "date-time",
            "example" : "2024-10-08T14:55:16.302Z"
          }
        }
      }
    }
  }
}
