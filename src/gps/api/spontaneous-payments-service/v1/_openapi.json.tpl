{
	"openapi": "3.0.1",
	"info": {
		"title": "PagoPA API Spontaneous Payment",
		"description": "Progetto Gestione Pagamenti Spontanei",
		"termsOfService": "https://www.pagopa.gov.it/",
		"version": "0.0.3-21"
	},
	"servers": [
		{
			"url": "http://localhost:8080",
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
									"$ref": "#/components/schemas/ProblemJson"
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
		"/organizations/{organizationFiscalCode}": {
			"get": {
				"tags": [
					"Enrollments API"
				],
				"summary": "Return all enrollments for a creditor institution.",
				"operationId": "getECEnrollments",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Obtained all enrollments for the creditor institution.",
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
									"$ref": "#/components/schemas/OrganizationModelResponse"
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
					},
					"404": {
						"description": "Not found the creditor institution.",
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
					"Enrollments API"
				],
				"summary": "The organization updates the creditor institution.",
				"operationId": "updateEC",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
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
								"$ref": "#/components/schemas/OrganizationModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"200": {
						"description": "Request updated.",
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
									"$ref": "#/components/schemas/OrganizationModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"404": {
						"description": "Not found the creditor institution.",
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
					"Enrollments API"
				],
				"summary": "The organization creates a creditor institution with possible enrollments to services.",
				"operationId": "createEC",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
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
								"$ref": "#/components/schemas/OrganizationEnrollmentModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"201": {
						"description": "Request created.",
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
									"$ref": "#/components/schemas/OrganizationModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"409": {
						"description": "The organization to create already exists.",
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
					"Enrollments API"
				],
				"summary": "The organization deletes the creditor institution.",
				"operationId": "deleteEC",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Request deleted.",
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
					},
					"404": {
						"description": "Not found the creditor institution.",
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
		"/organizations/{organizationFiscalCode}/services/{serviceId}": {
			"get": {
				"tags": [
					"Enrollments API"
				],
				"summary": "Return the single enrollment to a service.",
				"operationId": "getSingleEnrollment",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					},
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to enroll.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Obtained single enrollment.",
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
									"$ref": "#/components/schemas/EnrollmentModelResponse"
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
					},
					"404": {
						"description": "Not found the enroll service.",
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
					"Enrollments API"
				],
				"summary": "The organization updates an enrollment to a service for the creditor institution.",
				"operationId": "updateECEnrollment",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					},
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to enroll.",
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
								"$ref": "#/components/schemas/EnrollmentModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"200": {
						"description": "Request updated.",
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
									"$ref": "#/components/schemas/OrganizationModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"404": {
						"description": "Not found the creditor institution or the enroll service.",
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
					"Enrollments API"
				],
				"summary": "The organization creates an enrollment to a service for the creditor institution.",
				"operationId": "createECEnrollment",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					},
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to enroll.",
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
								"$ref": "#/components/schemas/EnrollmentModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"201": {
						"description": "Request created.",
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
									"$ref": "#/components/schemas/OrganizationModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"404": {
						"description": "Not found the creditor institution or the enroll service.",
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
					"409": {
						"description": "The enrollment to the service already exists.",
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
					"Enrollments API"
				],
				"summary": "The organization deletes the enrollment to service for the creditor institution.",
				"operationId": "deleteECEnrollment",
				"parameters": [
					{
						"name": "organizationFiscalCode",
						"in": "path",
						"description": "The fiscal code of the Organization.",
						"required": true,
						"schema": {
							"type": "string"
						}
					},
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to enroll.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Request deleted.",
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
					},
					"404": {
						"description": "Not found the creditor institution or the enroll service.",
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
		"/organizations/{organizationfiscalcode}/spontaneouspayments": {
			"post": {
				"tags": [
					"Payments API"
				],
				"summary": "The Organization creates a spontaneous payment.",
				"operationId": "createSpontaneousPayment",
				"parameters": [
					{
						"name": "organizationfiscalcode",
						"in": "path",
						"description": "Organization fiscal code, the fiscal code of the Organization.",
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
								"$ref": "#/components/schemas/SpontaneousPaymentModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"201": {
						"description": "Request created.",
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
									"$ref": "#/components/schemas/PaymentPositionModel"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"409": {
						"description": "Conflict: duplicate debt position found.",
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
		"/services": {
			"get": {
				"tags": [
					"Services API"
				],
				"summary": "Return all services.",
				"operationId": "getServices",
				"responses": {
					"200": {
						"description": "Obtained all services.",
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
									"type": "array",
									"items": {
										"$ref": "#/components/schemas/ServiceModelResponse"
									}
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
					"Services API"
				],
				"summary": "The user creates a service.",
				"operationId": "createService",
				"requestBody": {
					"content": {
						"application/json": {
							"schema": {
								"$ref": "#/components/schemas/ServiceDetailModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"201": {
						"description": "Request created.",
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
									"$ref": "#/components/schemas/ServiceDetailModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"409": {
						"description": "The service to create already exists.",
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
		"/services/{serviceId}": {
			"get": {
				"tags": [
					"Services API"
				],
				"summary": "Return the single service details.",
				"operationId": "getServiceDetails",
				"parameters": [
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id for which to have the details.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Obtained single service details.",
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
									"$ref": "#/components/schemas/ServiceDetailModelResponse"
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
					},
					"404": {
						"description": "No service found.",
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
					"Services API"
				],
				"summary": "The user updates a service.",
				"operationId": "updateService",
				"parameters": [
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to update.",
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
								"$ref": "#/components/schemas/ServiceDetailUpdModel"
							}
						}
					},
					"required": true
				},
				"responses": {
					"200": {
						"description": "Request updated.",
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
									"$ref": "#/components/schemas/ServiceDetailModelResponse"
								}
							}
						}
					},
					"400": {
						"description": "Malformed request.",
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
					},
					"404": {
						"description": "Not found.",
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
					"Services API"
				],
				"summary": "The user deletes a service.",
				"operationId": "deleteService",
				"parameters": [
					{
						"name": "serviceId",
						"in": "path",
						"description": "The service id to delete.",
						"required": true,
						"schema": {
							"type": "string"
						}
					}
				],
				"responses": {
					"200": {
						"description": "Request deleted.",
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
					},
					"404": {
						"description": "Not found.",
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
			"ServiceConfigPropertyModel": {
				"required": [
					"name"
				],
				"type": "object",
				"properties": {
					"name": {
						"type": "string"
					},
					"type": {
						"type": "string",
						"enum": [
							"STRING",
							"NUMBER"
						]
					},
					"required": {
						"type": "boolean"
					}
				}
			},
			"ServiceDetailUpdModel": {
				"required": [
					"description",
					"endpoint",
					"name",
					"status",
					"transferCategory"
				],
				"type": "object",
				"properties": {
					"name": {
						"type": "string"
					},
					"description": {
						"type": "string"
					},
					"transferCategory": {
						"type": "string"
					},
					"endpoint": {
						"type": "string"
					},
					"basePath": {
						"type": "string"
					},
					"status": {
						"type": "string",
						"enum": [
							"ENABLED",
							"DISABLED"
						]
					},
					"properties": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/ServiceConfigPropertyModel"
						}
					}
				}
			},
			"ServiceDetailModelResponse": {
				"type": "object",
				"properties": {
					"id": {
						"type": "string"
					},
					"name": {
						"type": "string"
					},
					"description": {
						"type": "string"
					},
					"transferCategory": {
						"type": "string"
					},
					"endpoint": {
						"type": "string"
					},
					"basePath": {
						"type": "string"
					},
					"status": {
						"type": "string",
						"enum": [
							"ENABLED",
							"DISABLED"
						]
					},
					"properties": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/ServicePropertyModelResponse"
						}
					}
				}
			},
			"ServicePropertyModelResponse": {
				"type": "object",
				"properties": {
					"name": {
						"type": "string"
					},
					"type": {
						"type": "string"
					},
					"required": {
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
			"OrganizationModel": {
				"type": "object",
				"properties": {
					"companyName": {
						"type": "string"
					},
					"status": {
						"type": "string",
						"enum": [
							"ENABLED",
							"DISABLED"
						]
					}
				}
			},
			"EnrollmentModelResponse": {
				"required": [
					"iban",
					"remittanceInformation",
					"segregationCode",
					"serviceId"
				],
				"type": "object",
				"properties": {
					"serviceId": {
						"type": "string"
					},
					"iban": {
						"type": "string"
					},
					"officeName": {
						"type": "string"
					},
					"segregationCode": {
						"type": "string"
					},
					"remittanceInformation": {
						"type": "string"
					},
					"postalIban": {
						"type": "string"
					}
				}
			},
			"OrganizationModelResponse": {
				"required": [
					"companyName",
					"fiscalCode",
					"status"
				],
				"type": "object",
				"properties": {
					"fiscalCode": {
						"type": "string"
					},
					"companyName": {
						"type": "string"
					},
					"status": {
						"type": "string",
						"enum": [
							"ENABLED",
							"DISABLED"
						]
					},
					"enrollments": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/EnrollmentModelResponse"
						}
					}
				}
			},
			"EnrollmentModel": {
				"required": [
					"iban",
					"remittanceInformation",
					"segregationCode"
				],
				"type": "object",
				"properties": {
					"iban": {
						"type": "string"
					},
					"officeName": {
						"type": "string"
					},
					"segregationCode": {
						"type": "string"
					},
					"remittanceInformation": {
						"type": "string"
					},
					"postalIban": {
						"type": "string"
					}
				}
			},
			"ServiceDetailModel": {
				"required": [
					"basePath",
					"description",
					"endpoint",
					"id",
					"name",
					"status",
					"transferCategory"
				],
				"type": "object",
				"properties": {
					"id": {
						"type": "string"
					},
					"name": {
						"type": "string"
					},
					"description": {
						"type": "string"
					},
					"transferCategory": {
						"type": "string"
					},
					"endpoint": {
						"type": "string"
					},
					"basePath": {
						"type": "string"
					},
					"status": {
						"type": "string",
						"enum": [
							"ENABLED",
							"DISABLED"
						]
					},
					"properties": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/ServiceConfigPropertyModel"
						}
					}
				}
			},
			"DebtorModel": {
				"required": [
					"fiscalCode",
					"fullName",
					"type"
				],
				"type": "object",
				"properties": {
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
					"province": {
						"type": "string"
					},
					"region": {
						"type": "string"
					},
					"country": {
						"type": "string"
					},
					"email": {
						"type": "string"
					},
					"phone": {
						"type": "string"
					}
				}
			},
			"ServiceModel": {
				"required": [
					"id",
					"properties"
				],
				"type": "object",
				"properties": {
					"id": {
						"type": "string"
					},
					"properties": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/ServicePropertyModel"
						}
					}
				}
			},
			"ServicePropertyModel": {
				"required": [
					"name"
				],
				"type": "object",
				"properties": {
					"name": {
						"type": "string"
					},
					"value": {
						"type": "string"
					}
				}
			},
			"SpontaneousPaymentModel": {
				"required": [
					"debtor",
					"service"
				],
				"type": "object",
				"properties": {
					"debtor": {
						"$ref": "#/components/schemas/DebtorModel"
					},
					"service": {
						"$ref": "#/components/schemas/ServiceModel"
					}
				}
			},
			"PaymentOptionModel": {
				"required": [
					"amount",
					"dueDate",
					"isPartialPayment",
					"iuv"
				],
				"type": "object",
				"properties": {
					"iuv": {
						"type": "string"
					},
					"amount": {
						"type": "integer",
						"format": "int64"
					},
					"description": {
						"type": "string"
					},
					"isPartialPayment": {
						"type": "boolean"
					},
					"dueDate": {
						"type": "string",
						"format": "date-time"
					},
					"retentionDate": {
						"type": "string",
						"format": "date-time"
					},
					"fee": {
						"type": "integer",
						"format": "int64"
					},
					"transfer": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/TransferModel"
						}
					}
				}
			},
			"PaymentPositionModel": {
				"required": [
					"companyName",
					"fiscalCode",
					"fullName",
					"iupd",
					"type"
				],
				"type": "object",
				"properties": {
					"iupd": {
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
					"province": {
						"type": "string"
					},
					"region": {
						"type": "string"
					},
					"country": {
						"type": "string"
					},
					"email": {
						"type": "string"
					},
					"phone": {
						"type": "string"
					},
					"switchToExpired": {
						"type": "boolean",
						"description": "feature flag to enable the debt position to expire after the due date",
						"example": false,
						"default": false
					},
					"companyName": {
						"type": "string"
					},
					"officeName": {
						"type": "string"
					},
					"validityDate": {
						"type": "string",
						"format": "date-time"
					},
					"status": {
						"type": "string",
						"readOnly": true,
						"enum": [
							"DRAFT",
							"PUBLISHED",
							"VALID",
							"INVALID",
							"EXPIRED",
							"PARTIALLY_PAID",
							"PAID",
							"REPORTED"
						]
					},
					"paymentOption": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/PaymentOptionModel"
						}
					}
				}
			},
			"TransferModel": {
				"required": [
					"amount",
					"category",
					"iban",
					"idTransfer",
					"remittanceInformation"
				],
				"type": "object",
				"properties": {
					"idTransfer": {
						"type": "string",
						"enum": [
							"1",
							"2",
							"3",
							"4",
							"5"
						]
					},
					"amount": {
						"type": "integer",
						"format": "int64"
					},
					"remittanceInformation": {
						"type": "string"
					},
					"category": {
						"type": "string"
					},
					"iban": {
						"type": "string"
					},
					"postalIban": {
						"type": "string"
					}
				}
			},
			"CreateEnrollmentModel": {
				"required": [
					"iban",
					"remittanceInformation",
					"segregationCode",
					"serviceId"
				],
				"type": "object",
				"properties": {
					"serviceId": {
						"type": "string"
					},
					"iban": {
						"type": "string"
					},
					"officeName": {
						"type": "string"
					},
					"segregationCode": {
						"type": "string"
					},
					"remittanceInformation": {
						"type": "string"
					},
					"postalIban": {
						"type": "string"
					}
				}
			},
			"OrganizationEnrollmentModel": {
				"required": [
					"companyName"
				],
				"type": "object",
				"properties": {
					"companyName": {
						"type": "string"
					},
					"enrollments": {
						"type": "array",
						"items": {
							"$ref": "#/components/schemas/CreateEnrollmentModel"
						}
					}
				}
			},
			"ServiceModelResponse": {
				"required": [
					"id",
					"name"
				],
				"type": "object",
				"properties": {
					"id": {
						"type": "string"
					},
					"name": {
						"type": "string"
					},
					"description": {
						"type": "string"
					}
				}
			},
			"AppInfo": {
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