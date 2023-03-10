{
  "openapi": "3.0.1",
  "info": {
    "title": "Api config cacher ${service}",
    "description": "Api config cacher ${service}",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.0.1"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "paths": {
    "/stakeholders/node/cache/schemas/v1": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get full node v1 config",
        "operationId": "cache",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfigDataV1"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden"
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "400": {
            "description": "Bad Request",
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
          }
        ]
      }
    },
    "/stakeholders/node/cache/schemas/v1/id": {
      "get": {
        "tags": [
          "Creditor Institutions"
        ],
        "summary": "Get last node v1 cache version",
        "operationId": "versionv1",
        "responses": {
          "403": {
            "description": "Forbidden"
          },
          "429": {
            "description": "Too many requests"
          },
          "500": {
            "description": "Service unavailable",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CacheVersion"
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
      }
    }
  },
  "components": {
    "schemas": {
      "BrokerCreditorInstitution": {
        "required": [
          "broker_code",
          "enabled",
          "extended_fault_bean"
        ],
        "type": "object",
        "properties": {
          "broker_code": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "type": "string"
          },
          "extended_fault_bean": {
            "type": "boolean"
          }
        }
      },
      "BrokerPsp": {
        "required": [
          "broker_psp_code",
          "enabled",
          "extended_fault_bean"
        ],
        "type": "object",
        "properties": {
          "broker_psp_code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "extended_fault_bean": {
            "type": "boolean"
          }
        }
      },
      "CdsCategory": {
        "required": [
          "description"
        ],
        "type": "object",
        "properties": {
          "description": {
            "type": "string"
          }
        }
      },
      "CdsService": {
        "required": [
          "category",
          "description",
          "id",
          "reference_xsd",
          "version"
        ],
        "type": "object",
        "properties": {
          "id": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "reference_xsd": {
            "type": "string"
          },
          "version": {
            "type": "integer",
            "format": "int64"
          },
          "category": {
            "type": "string"
          }
        }
      },
      "CdsSubject": {
        "required": [
          "creditor_institution_code",
          "creditor_institution_description"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "type": "string"
          },
          "creditor_institution_description": {
            "type": "string"
          }
        }
      },
      "CdsSubjectService": {
        "required": [
          "fee",
          "service",
          "start_date",
          "subject",
          "subject_service_id"
        ],
        "type": "object",
        "properties": {
          "subject": {
            "type": "string"
          },
          "service": {
            "type": "string"
          },
          "subject_service_id": {
            "type": "string"
          },
          "start_date": {
            "type": "string",
            "format": "date-time"
          },
          "end_date": {
            "type": "string",
            "format": "date-time"
          },
          "fee": {
            "type": "boolean"
          }
        }
      },
      "Channel": {
        "required": [
          "agid",
          "broker_psp_code",
          "channel_code",
          "digital_stamp",
          "enabled",
          "flag_io",
          "ip",
          "new_fault_code",
          "password",
          "payment_model",
          "port",
          "primitive_version",
          "protocol",
          "proxy_enabled",
          "recovery",
          "rt_push",
          "thread_number",
          "timeout_a",
          "timeout_b",
          "timeout_c"
        ],
        "type": "object",
        "properties": {
          "channel_code": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "password": {
            "type": "string"
          },
          "protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "ip": {
            "type": "string"
          },
          "port": {
            "type": "integer",
            "format": "int64"
          },
          "service": {
            "type": "string"
          },
          "broker_psp_code": {
            "type": "string"
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_port": {
            "type": "integer",
            "format": "int64"
          },
          "proxy_username": {
            "type": "string"
          },
          "proxy_password": {
            "type": "string"
          },
          "target_host": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
          },
          "target_path": {
            "type": "string"
          },
          "thread_number": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_a": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_b": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_c": {
            "type": "integer",
            "format": "int64"
          },
          "nmp_service": {
            "type": "string"
          },
          "new_fault_code": {
            "type": "boolean"
          },
          "redirect_ip": {
            "type": "string"
          },
          "redirect_path": {
            "type": "string"
          },
          "redirect_port": {
            "type": "integer",
            "format": "int64"
          },
          "redirect_query_string": {
            "type": "string"
          },
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "payment_model": {
            "type": "string",
            "enum": [
              "IMMEDIATE",
              "IMMEDIATE_MULTIBENEFICIARY",
              "DEFERRED",
              "ACTIVATED_AT_PSP"
            ]
          },
          "serv_plugin": {
            "type": "string"
          },
          "rt_push": {
            "type": "boolean"
          },
          "recovery": {
            "type": "boolean"
          },
          "digital_stamp": {
            "type": "boolean"
          },
          "flag_io": {
            "type": "boolean"
          },
          "agid": {
            "type": "boolean"
          },
          "primitive_version": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "ConfigDataV1": {
        "required": [
          "cdsCategories",
          "cdsServices",
          "cdsSubjectServices",
          "cdsSubjects",
          "channels",
          "configurations",
          "creditorInstitutionBrokers",
          "creditorInstitutionEncoding",
          "creditorInstitutionInformations",
          "creditorInstitutionStations",
          "creditorInstitutions",
          "encodings",
          "ftpServers",
          "gdeConfigurations",
          "ibans",
          "languages",
          "metadataDict",
          "paymentTypes",
          "plugins",
          "pspBrokers",
          "pspChannelPaymentTypes",
          "pspInformationTemplates",
          "pspInformations",
          "psps",
          "stations",
          "version"
        ],
        "type": "object",
        "properties": {
          "version": {
            "type": "string"
          },
          "creditorInstitutions": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CreditorInstitution"
            }
          },
          "creditorInstitutionBrokers": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BrokerCreditorInstitution"
            }
          },
          "stations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/Station"
            }
          },
          "creditorInstitutionStations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/StationCreditorInstitution"
            }
          },
          "encodings": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/Encoding"
            }
          },
          "creditorInstitutionEncoding": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CreditorInstitutionEncoding"
            }
          },
          "ibans": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/Iban"
            }
          },
          "creditorInstitutionInformations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CreditorInstitutionInformation"
            }
          },
          "psps": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/PaymentServiceProvider"
            }
          },
          "pspBrokers": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/BrokerPsp"
            }
          },
          "paymentTypes": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/PaymentType"
            }
          },
          "pspChannelPaymentTypes": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/PspChannelPaymentType"
            }
          },
          "plugins": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/Plugin"
            }
          },
          "pspInformationTemplates": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/PspInformation"
            }
          },
          "pspInformations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/PspInformation"
            }
          },
          "channels": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/Channel"
            }
          },
          "cdsServices": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CdsService"
            }
          },
          "cdsSubjects": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CdsSubject"
            }
          },
          "cdsSubjectServices": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CdsSubjectService"
            }
          },
          "cdsCategories": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/CdsCategory"
            }
          },
          "configurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/ConfigurationKey"
            }
          },
          "ftpServers": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/FtpServer"
            }
          },
          "languages": {
            "type": "object",
            "additionalProperties": {
              "type": "string"
            }
          },
          "gdeConfigurations": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/GdeConfiguration"
            }
          },
          "metadataDict": {
            "type": "object",
            "additionalProperties": {
              "$ref": "#/components/schemas/MetadataDict"
            }
          }
        }
      },
      "ConfigurationKey": {
        "required": [
          "category",
          "key",
          "value"
        ],
        "type": "object",
        "properties": {
          "category": {
            "type": "string"
          },
          "key": {
            "type": "string"
          },
          "value": {
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "CreditorInstitution": {
        "required": [
          "creditor_institution_code",
          "enabled",
          "psp_payment",
          "reporting_ftp",
          "reporting_zip"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "business_name": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "address": {
            "$ref": "#/components/schemas/CreditorInstitutionAddress"
          },
          "psp_payment": {
            "type": "boolean"
          },
          "reporting_ftp": {
            "type": "boolean"
          },
          "reporting_zip": {
            "type": "boolean"
          }
        }
      },
      "CreditorInstitutionAddress": {
        "type": "object",
        "properties": {
          "location": {
            "type": "string"
          },
          "city": {
            "type": "string"
          },
          "zip_code": {
            "type": "string"
          },
          "country_code": {
            "type": "string"
          },
          "tax_domicile": {
            "type": "string"
          }
        }
      },
      "CreditorInstitutionEncoding": {
        "required": [
          "code_type",
          "creditor_institution_code",
          "encoding_code"
        ],
        "type": "object",
        "properties": {
          "code_type": {
            "type": "string"
          },
          "encoding_code": {
            "type": "string"
          },
          "creditor_institution_code": {
            "type": "string"
          }
        }
      },
      "CreditorInstitutionInformation": {
        "required": [
          "informativa"
        ],
        "type": "object",
        "properties": {
          "informativa": {
            "type": "string"
          }
        }
      },
      "Encoding": {
        "required": [
          "code_type",
          "description"
        ],
        "type": "object",
        "properties": {
          "code_type": {
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "FtpServer": {
        "required": [
          "enabled",
          "history_path",
          "host",
          "id",
          "in_path",
          "out_path",
          "password",
          "port",
          "root_path",
          "service",
          "type",
          "username"
        ],
        "type": "object",
        "properties": {
          "host": {
            "type": "string"
          },
          "port": {
            "type": "integer",
            "format": "int32"
          },
          "enabled": {
            "type": "boolean"
          },
          "username": {
            "type": "string"
          },
          "password": {
            "type": "string"
          },
          "root_path": {
            "type": "string"
          },
          "service": {
            "type": "string"
          },
          "type": {
            "type": "string"
          },
          "in_path": {
            "type": "string"
          },
          "out_path": {
            "type": "string"
          },
          "history_path": {
            "type": "string"
          },
          "id": {
            "type": "integer",
            "format": "int64"
          }
        }
      },
      "GdeConfiguration": {
        "required": [
          "event_hub_enabled",
          "event_hub_payload_enabled",
          "primitive",
          "type"
        ],
        "type": "object",
        "properties": {
          "primitive": {
            "type": "string"
          },
          "type": {
            "type": "string"
          },
          "event_hub_enabled": {
            "type": "boolean"
          },
          "event_hub_payload_enabled": {
            "type": "boolean"
          }
        }
      },
      "Iban": {
        "required": [
          "creditor_institution_code",
          "iban",
          "publication_date",
          "validity_date"
        ],
        "type": "object",
        "properties": {
          "iban": {
            "type": "string"
          },
          "creditor_institution_code": {
            "type": "string"
          },
          "validity_date": {
            "type": "string",
            "format": "date-time"
          },
          "publication_date": {
            "type": "string",
            "format": "date-time"
          },
          "shop_id": {
            "type": "string"
          },
          "seller_bank_id": {
            "type": "string"
          },
          "avvio_key": {
            "type": "string"
          },
          "esito_key": {
            "type": "string"
          }
        }
      },
      "MetadataDict": {
        "required": [
          "key",
          "start_date"
        ],
        "type": "object",
        "properties": {
          "key": {
            "type": "string"
          },
          "description": {
            "type": "string"
          },
          "start_date": {
            "type": "string",
            "format": "date-time"
          },
          "end_date": {
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "PaymentServiceProvider": {
        "required": [
          "agid_psp",
          "digital_stamp",
          "enabled",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "description": {
            "type": "string"
          },
          "business_name": {
            "type": "string"
          },
          "abi": {
            "type": "string"
          },
          "bic": {
            "type": "string"
          },
          "my_bank_code": {
            "type": "string"
          },
          "digital_stamp": {
            "type": "boolean"
          },
          "agid_psp": {
            "type": "boolean"
          },
          "tax_code": {
            "type": "string"
          },
          "vat_number": {
            "type": "string"
          }
        }
      },
      "PaymentType": {
        "required": [
          "payment_type"
        ],
        "type": "object",
        "properties": {
          "payment_type": {
            "type": "string"
          },
          "description": {
            "type": "string"
          }
        }
      },
      "Plugin": {
        "required": [
          "id_serv_plugin"
        ],
        "type": "object",
        "properties": {
          "id_serv_plugin": {
            "type": "string"
          },
          "pag_const_string_profile": {
            "type": "string"
          },
          "pag_soap_rule_profile": {
            "type": "string"
          },
          "pag_rpt_xpath_profile": {
            "type": "string"
          },
          "id_bean": {
            "type": "string"
          }
        }
      },
      "PspChannelPaymentType": {
        "required": [
          "channel_code",
          "payment_type",
          "psp_code"
        ],
        "type": "object",
        "properties": {
          "psp_code": {
            "type": "string"
          },
          "channel_code": {
            "type": "string"
          },
          "payment_type": {
            "type": "string"
          }
        }
      },
      "PspInformation": {
        "required": [
          "informativa"
        ],
        "type": "object",
        "properties": {
          "informativa": {
            "type": "string"
          }
        }
      },
      "Station": {
        "required": [
          "broker_code",
          "enabled",
          "invio_rt_istantaneo",
          "ip",
          "password",
          "port",
          "primitive_version",
          "protocol",
          "proxy_enabled",
          "station_code",
          "thread_number",
          "timeout_a",
          "timeout_b",
          "timeout_c",
          "version"
        ],
        "type": "object",
        "properties": {
          "station_code": {
            "type": "string"
          },
          "enabled": {
            "type": "boolean"
          },
          "version": {
            "type": "integer",
            "format": "int64"
          },
          "ip": {
            "type": "string"
          },
          "password": {
            "type": "string"
          },
          "port": {
            "type": "integer",
            "format": "int64"
          },
          "protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "redirect_ip": {
            "type": "string"
          },
          "redirect_path": {
            "type": "string"
          },
          "redirect_port": {
            "type": "integer",
            "format": "int64"
          },
          "redirect_query_string": {
            "type": "string"
          },
          "redirect_protocol": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "service": {
            "type": "string"
          },
          "pof_service": {
            "type": "string"
          },
          "nmp_service": {
            "type": "string"
          },
          "broker_code": {
            "type": "string"
          },
          "protocol_4mod": {
            "type": "string",
            "enum": [
              "HTTPS",
              "HTTP"
            ]
          },
          "ip_4mod": {
            "type": "string"
          },
          "port_4mod": {
            "type": "integer",
            "format": "int64"
          },
          "service_4mod": {
            "type": "string"
          },
          "proxy_enabled": {
            "type": "boolean"
          },
          "proxy_host": {
            "type": "string"
          },
          "proxy_port": {
            "type": "integer",
            "format": "int64"
          },
          "proxy_username": {
            "type": "string"
          },
          "proxy_password": {
            "type": "string"
          },
          "thread_number": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_a": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_b": {
            "type": "integer",
            "format": "int64"
          },
          "timeout_c": {
            "type": "integer",
            "format": "int64"
          },
          "invio_rt_istantaneo": {
            "type": "boolean"
          },
          "target_host": {
            "type": "string"
          },
          "target_port": {
            "type": "integer",
            "format": "int64"
          },
          "target_path": {
            "type": "string"
          },
          "primitive_version": {
            "type": "integer",
            "format": "int32"
          }
        }
      },
      "StationCreditorInstitution": {
        "required": [
          "broadcast",
          "creditor_institution_code",
          "mod4",
          "primitive_version",
          "spontaneous_payment",
          "station_code"
        ],
        "type": "object",
        "properties": {
          "creditor_institution_code": {
            "type": "string"
          },
          "station_code": {
            "type": "string"
          },
          "application_code": {
            "type": "integer",
            "format": "int64"
          },
          "aux_digit": {
            "type": "integer",
            "format": "int64"
          },
          "segregation_code": {
            "type": "integer",
            "format": "int64"
          },
          "mod4": {
            "type": "boolean"
          },
          "broadcast": {
            "type": "boolean"
          },
          "primitive_version": {
            "type": "integer",
            "format": "int32"
          },
          "spontaneous_payment": {
            "type": "boolean"
          }
        }
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
      "CacheVersion": {
        "required": [
          "version"
        ],
        "type": "object",
        "properties": {
          "version": {
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
