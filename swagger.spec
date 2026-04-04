{
  "openapi": "3.0.1",
  "info": {
    "title": "Booking Trip Project",
    "version": "1.0"
  },
  "paths": {
    "/api/bookings/{bookId}/passengers": {
      "get": {
        "tags": [
          "BookingPassengers"
        ],
        "parameters": [
          {
            "name": "bookId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BookingPassengersDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "BookingPassengers"
        ],
        "parameters": [
          {
            "name": "bookId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "required": [
                  "BirthDate",
                  "DocumentationType",
                  "DocumentFile",
                  "Email",
                  "ExpirationDate",
                  "FirstName",
                  "Gender",
                  "IssueCountryId",
                  "LastName",
                  "Phone"
                ],
                "type": "object",
                "properties": {
                  "FirstName": {
                    "type": "string"
                  },
                  "SecondName": {
                    "type": "string"
                  },
                  "ThirdName": {
                    "type": "string"
                  },
                  "LastName": {
                    "type": "string"
                  },
                  "Email": {
                    "type": "string",
                    "format": "email"
                  },
                  "Phone": {
                    "type": "string"
                  },
                  "BirthDate": {
                    "type": "string",
                    "format": "date-time"
                  },
                  "Gender": {
                    "type": "string"
                  },
                  "IssueCountryId": {
                    "type": "integer",
                    "format": "int32"
                  },
                  "DocumentationType": {
                    "type": "string"
                  },
                  "ExpirationDate": {
                    "type": "string",
                    "format": "date-time"
                  },
                  "DocumentFile": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "FirstName": {
                  "style": "form"
                },
                "SecondName": {
                  "style": "form"
                },
                "ThirdName": {
                  "style": "form"
                },
                "LastName": {
                  "style": "form"
                },
                "Email": {
                  "style": "form"
                },
                "Phone": {
                  "style": "form"
                },
                "BirthDate": {
                  "style": "form"
                },
                "Gender": {
                  "style": "form"
                },
                "IssueCountryId": {
                  "style": "form"
                },
                "DocumentationType": {
                  "style": "form"
                },
                "ExpirationDate": {
                  "style": "form"
                },
                "DocumentFile": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AddPassengerResponse"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/BookingTrip": {
      "get": {
        "tags": [
          "BookingTrip"
        ],
        "operationId": "GetAllBookingTripAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BookingTripDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "BookingTrip"
        ],
        "operationId": "AddNewBookingTrip",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripCreateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripCreateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripCreateDTOs"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/BookingTrip/{BookingTripID}": {
      "get": {
        "tags": [
          "BookingTrip"
        ],
        "operationId": "GetBookingID",
        "parameters": [
          {
            "name": "BookingTripID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BookingTripDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "BookingTrip"
        ],
        "parameters": [
          {
            "name": "BookingTripID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/BookingTrip/{BookingTrip}": {
      "put": {
        "tags": [
          "BookingTrip"
        ],
        "parameters": [
          {
            "name": "BookingTrip",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/BookingTripUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/BookingTrip/{bookId}/confirm": {
      "post": {
        "tags": [
          "BookingTrip"
        ],
        "parameters": [
          {
            "name": "bookId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Client": {
      "get": {
        "tags": [
          "Client"
        ],
        "operationId": "GetAllClientAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ClientDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "Client"
        ],
        "operationId": "AddNewClient",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ClientCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Client/{ClientID}": {
      "get": {
        "tags": [
          "Client"
        ],
        "operationId": "ClientByID",
        "parameters": [
          {
            "name": "ClientID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ClientDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "Client"
        ],
        "parameters": [
          {
            "name": "ClientID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Client/{Client}": {
      "put": {
        "tags": [
          "Client"
        ],
        "parameters": [
          {
            "name": "Client",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ClientUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Client/ByPerson/{personId}": {
      "get": {
        "tags": [
          "Client"
        ],
        "parameters": [
          {
            "name": "personId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Country/All": {
      "get": {
        "tags": [
          "Country"
        ],
        "operationId": "GetAllCountryAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/CountryDTOs"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Country/{CountryID}": {
      "get": {
        "tags": [
          "Country"
        ],
        "operationId": "GETCountryID",
        "parameters": [
          {
            "name": "CountryID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CountryDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "Country"
        ],
        "parameters": [
          {
            "name": "CountryID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CountryUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CountryUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CountryUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "Country"
        ],
        "parameters": [
          {
            "name": "CountryID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Country": {
      "post": {
        "tags": [
          "Country"
        ],
        "operationId": "AddNewCountry",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CountryCreateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CountryCreateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CountryCreateDTOs"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Employee/All": {
      "get": {
        "tags": [
          "Employee"
        ],
        "operationId": "GetAllEmployeeAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/EmployeeDTOs"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Employee/{EmployeeID}": {
      "get": {
        "tags": [
          "Employee"
        ],
        "operationId": "GETEmployeeID",
        "parameters": [
          {
            "name": "EmployeeID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/EmployeeDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "Employee"
        ],
        "parameters": [
          {
            "name": "EmployeeID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Employee/{Employee}": {
      "put": {
        "tags": [
          "Employee"
        ],
        "parameters": [
          {
            "name": "Employee",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Employee": {
      "post": {
        "tags": [
          "Employee"
        ],
        "operationId": "AddNewEmployee",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeCreateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeCreateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/EmployeeCreateDTOs"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/{id}": {
      "get": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "GetFlightScheduleById",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/FlightScheduleDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "UpdateFlightSchedule",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "DeleteFlightSchedule",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/All": {
      "get": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "GetAllFlightSchedules",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FlightScheduleDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "AddFlightSchedule",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/Search": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "SearchFlightSchedules",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleSearchDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleSearchDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/FlightScheduleSearchDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/FlightScheduleDTO"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/SearchMultiCity": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "SearchMultiCityFlightSchedules",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/MultiCitySearchResultDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/Cities": {
      "get": {
        "tags": [
          "FlightSchedules"
        ],
        "operationId": "GetAllCities",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/FlightSchedules/oneway": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/OneWaySearchRequestDto"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/OneWaySearchRequestDto"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/OneWaySearchRequestDto"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/FlightSchedules/roundtrip": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RoundTripSearchRequestDto"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/RoundTripSearchRequestDto"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/RoundTripSearchRequestDto"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/FlightSchedules/multicity": {
      "post": {
        "tags": [
          "FlightSchedules"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchRequestDto"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchRequestDto"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/MultiCitySearchRequestDto"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/InfoDocumentation/All": {
      "get": {
        "tags": [
          "InfoDocumentation"
        ],
        "operationId": "GetAllDocumentationAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InfoDocumentationDTOs"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoDocumentation/{DocumentationID}": {
      "get": {
        "tags": [
          "InfoDocumentation"
        ],
        "operationId": "GETDocumentationID",
        "parameters": [
          {
            "name": "DocumentationID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoDocumentationDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "InfoDocumentation"
        ],
        "parameters": [
          {
            "name": "DocumentationID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoDocumentation/{Documentation}": {
      "put": {
        "tags": [
          "InfoDocumentation"
        ],
        "parameters": [
          {
            "name": "Documentation",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoDocumentation": {
      "post": {
        "tags": [
          "InfoDocumentation"
        ],
        "operationId": "AddNewDocumentation",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationCreateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationCreateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/InfoDocumentationCreateDTOs"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoDocumentation/client/{clientId}/image": {
      "post": {
        "tags": [
          "InfoDocumentation"
        ],
        "parameters": [
          {
            "name": "clientId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "file": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "file": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/InfoPerson/All": {
      "get": {
        "tags": [
          "InfoPerson"
        ],
        "operationId": "GetAllPersonsAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InfoPersonDTOs"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoPerson/{PersonId}": {
      "get": {
        "tags": [
          "InfoPerson"
        ],
        "operationId": "GetIDPerson",
        "parameters": [
          {
            "name": "PersonId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoPersonDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "InfoPerson"
        ],
        "parameters": [
          {
            "name": "PersonId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoPerson/{PersonID}": {
      "put": {
        "tags": [
          "InfoPerson"
        ],
        "operationId": "UpdatePersonByIdAsync",
        "parameters": [
          {
            "name": "PersonID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoPersonUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoPersonUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/InfoPersonUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoTickets/{id}": {
      "get": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "GetInfoTicketById",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoTicketDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "UpdateInfoTicket",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoTicketDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "DeleteInfoTicket",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoTickets/All": {
      "get": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "GetAllInfoTickets",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InfoTicketDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoTickets/ByBooking/{bookId}": {
      "get": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "GetInfoTicketsByBooking",
        "parameters": [
          {
            "name": "bookId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/InfoTicketDTO"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/InfoTickets": {
      "post": {
        "tags": [
          "InfoTickets"
        ],
        "operationId": "CreateInfoTicket",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/InfoTicketCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/InfoTicketDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Login/login": {
      "post": {
        "tags": [
          "Login"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/LoginResultDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/LoginResultDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/LoginResultDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Login/register": {
      "post": {
        "tags": [
          "Login"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/RegisterRequestDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/RegisterRequestDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/RegisterRequestDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/PassengerClass/All": {
      "get": {
        "tags": [
          "PassengerClass"
        ],
        "operationId": "GetAllPassengerClasses",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/PassengerClassDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/PassengerClass/{id}": {
      "get": {
        "tags": [
          "PassengerClass"
        ],
        "operationId": "GetPassengerClassById",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PassengerClassDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/payments/checkout-session": {
      "post": {
        "tags": [
          "Payments"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CreateCheckoutSessionRequest"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CreateCheckoutSessionRequest"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CreateCheckoutSessionRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/CreateCheckoutSessionResponse"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreateCheckoutSessionResponse"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/CreateCheckoutSessionResponse"
                }
              }
            }
          }
        }
      }
    },
    "/api/payments/webhook": {
      "post": {
        "tags": [
          "Payments"
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/payments/my/status/{ticketId}": {
      "get": {
        "tags": [
          "Payments"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/profile/me": {
      "get": {
        "tags": [
          "Profile"
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProfileMeResponseDto"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProfileMeResponseDto"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProfileMeResponseDto"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "Profile"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ProfileMeUpdateRequestDto"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ProfileMeUpdateRequestDto"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ProfileMeUpdateRequestDto"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/profile/me/image": {
      "post": {
        "tags": [
          "Profile"
        ],
        "requestBody": {
          "content": {
            "multipart/form-data": {
              "schema": {
                "type": "object",
                "properties": {
                  "Image": {
                    "type": "string",
                    "format": "binary"
                  }
                }
              },
              "encoding": {
                "Image": {
                  "style": "form"
                }
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/summary": {
      "get": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/BookingSummaryDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/BookingSummaryDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/BookingSummaryDTO"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/seats": {
      "get": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/SelectedSeatsDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/SelectedSeatsDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/SelectedSeatsDTO"
                }
              }
            }
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/seats/hold": {
      "post": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
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
                "$ref": "#/components/schemas/HoldSeatsRequestDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/HoldSeatsRequestDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/HoldSeatsRequestDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/HoldSeatsResponseDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/HoldSeatsResponseDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/HoldSeatsResponseDTO"
                }
              }
            }
          },
          "409": {
            "description": "Conflict",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
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
                "$ref": "#/components/schemas/UnholdSeatsRequestDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UnholdSeatsRequestDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UnholdSeatsRequestDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/UnholdSeatsResponseDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UnholdSeatsResponseDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/UnholdSeatsResponseDTO"
                }
              }
            }
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/seats/confirm": {
      "post": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
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
                "$ref": "#/components/schemas/ConfirmSeatsRequestDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ConfirmSeatsRequestDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ConfirmSeatsRequestDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ConfirmSeatsResponseDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfirmSeatsResponseDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ConfirmSeatsResponseDTO"
                }
              }
            }
          },
          "409": {
            "description": "Conflict",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/seats/assign": {
      "put": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
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
                "$ref": "#/components/schemas/AssignSeatsRequestDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/AssignSeatsRequestDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/AssignSeatsRequestDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/AssignSeatsResponseDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AssignSeatsResponseDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/AssignSeatsResponseDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "409": {
            "description": "Conflict",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Bookings/{bookingTempId}/passengers/seats": {
      "get": {
        "tags": [
          "SeatMap"
        ],
        "parameters": [
          {
            "name": "bookingTempId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/PassengerSeatsResponseDTO"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PassengerSeatsResponseDTO"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/PassengerSeatsResponseDTO"
                }
              }
            }
          }
        }
      }
    },
    "/api/Services/{id}": {
      "get": {
        "tags": [
          "Services"
        ],
        "operationId": "GetServiceById",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ServicesDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "Services"
        ],
        "operationId": "UpdateService",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "204": {
            "description": "No Content"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "Services"
        ],
        "operationId": "DeleteService",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Services/All": {
      "get": {
        "tags": [
          "Services"
        ],
        "operationId": "GetAllServices",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/ServicesDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Services": {
      "post": {
        "tags": [
          "Services"
        ],
        "operationId": "AddService",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ServicesCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/TicketFlights/{ticketId}/{flightScheduleId}": {
      "get": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "GetTicketFlightById",
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "flightScheduleId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TicketFlightDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "UpdateTicketFlight",
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "flightScheduleId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TicketFlightDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "DeleteTicketFlight",
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "flightScheduleId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/TicketFlights/All": {
      "get": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "GetAllTicketFlights",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TicketFlightDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/TicketFlights/ByTicket/{ticketId}": {
      "get": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "GetTicketFlightsByTicket",
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TicketFlightDTO"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/TicketFlights": {
      "post": {
        "tags": [
          "TicketFlights"
        ],
        "operationId": "CreateTicketFlight",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TicketFlightCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TicketFlightDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/tickets/my/paid": {
      "get": {
        "tags": [
          "Tickets"
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/tickets/my/{ticketId}": {
      "get": {
        "tags": [
          "Tickets"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/tickets/my/{ticketId}/recalc-price": {
      "post": {
        "tags": [
          "Tickets"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/tickets/{ticketId}/recalc-price": {
      "post": {
        "tags": [
          "Tickets"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/tickets/{ticketId}/services": {
      "get": {
        "tags": [
          "TicketServices"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TicketServicesDTO"
                  }
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "TicketServices"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceAddDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceAddDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceAddDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "TicketServices"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/tickets/{ticketId}/services/{serviceId}": {
      "put": {
        "tags": [
          "TicketServices"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "serviceId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceUpdateQuantityDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceUpdateQuantityDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TicketServiceUpdateQuantityDTO"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "TicketServices"
        ],
        "parameters": [
          {
            "name": "ticketId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "serviceId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Triptypes/{id}": {
      "get": {
        "tags": [
          "TripTypes"
        ],
        "operationId": "GetTripTypeById",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TripTypeDTO"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "put": {
        "tags": [
          "TripTypes"
        ],
        "operationId": "UpdateTripType",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeUpdateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeUpdateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeUpdateDTO"
              }
            }
          }
        },
        "responses": {
          "204": {
            "description": "No Content"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "TripTypes"
        ],
        "operationId": "DeleteTripType",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Triptypes/All": {
      "get": {
        "tags": [
          "TripTypes"
        ],
        "operationId": "GetAll",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/TripTypeDTO"
                  }
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/Triptypes": {
      "post": {
        "tags": [
          "TripTypes"
        ],
        "operationId": "Add",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeCreateDTO"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeCreateDTO"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/TripTypeCreateDTO"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/UserAccount": {
      "get": {
        "tags": [
          "UserAccount"
        ],
        "operationId": "GetAllUserAccountAsync",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserAccountDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "post": {
        "tags": [
          "UserAccount"
        ],
        "operationId": "AddNewUserAccount",
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountCreateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountCreateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountCreateDTOs"
              }
            }
          }
        },
        "responses": {
          "201": {
            "description": "Created"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/UserAccount/{UserAccountId}": {
      "get": {
        "tags": [
          "UserAccount"
        ],
        "operationId": "GetUserAccount",
        "parameters": [
          {
            "name": "UserAccountId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UserAccountDTOs"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      },
      "delete": {
        "tags": [
          "UserAccount"
        ],
        "parameters": [
          {
            "name": "UserAccountId",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/UserAccount/{UserAccountID}": {
      "put": {
        "tags": [
          "UserAccount"
        ],
        "operationId": "UpdateUserAccountByIdAsync",
        "parameters": [
          {
            "name": "UserAccountID",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountUpdateDTOs"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountUpdateDTOs"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/UserAccountUpdateDTOs"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          },
          "400": {
            "description": "Bad Request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          },
          "404": {
            "description": "Not Found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemDetails"
                }
              }
            }
          }
        }
      }
    },
    "/api/UserAccount/me": {
      "get": {
        "tags": [
          "UserAccount"
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "AddPassengerResponse": {
        "type": "object",
        "properties": {
          "passengerId": {
            "type": "integer",
            "format": "int32"
          },
          "personId": {
            "type": "integer",
            "format": "int32"
          },
          "documentationId": {
            "type": "integer",
            "format": "int32"
          },
          "current": {
            "type": "integer",
            "format": "int32"
          },
          "total": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "AssignSeatsRequestDTO": {
        "type": "object",
        "properties": {
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          },
          "assignments": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/SeatAssignmentItemDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "AssignSeatsResponseDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          },
          "assigned": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/AssignedSeatDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "AssignedSeatDTO": {
        "type": "object",
        "properties": {
          "seatId": {
            "type": "integer",
            "format": "int32"
          },
          "seatCode": {
            "type": "string",
            "nullable": true
          },
          "passengerId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "BookingPassengersDTOs": {
        "type": "object",
        "properties": {
          "bookId": {
            "type": "integer",
            "format": "int32"
          },
          "ticketId": {
            "type": "integer",
            "format": "int32"
          },
          "expectedPassengers": {
            "type": "integer",
            "format": "int32"
          },
          "createdPassengers": {
            "type": "integer",
            "format": "int32"
          },
          "passengers": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PassengerSummaryDto"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "BookingSummaryDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "expectedPassengers": {
            "type": "integer",
            "format": "int32"
          },
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          },
          "cabinClass": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "BookingTripCreateDTOs": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "tripType": {
            "type": "integer",
            "format": "int32"
          },
          "isActive": {
            "type": "boolean"
          },
          "bookingDate": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "BookingTripDTOs": {
        "type": "object",
        "properties": {
          "bookID": {
            "type": "integer",
            "format": "int32"
          },
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "tripTypeID": {
            "type": "integer",
            "format": "int32"
          },
          "isActive": {
            "type": "boolean"
          },
          "bookingDate": {
            "type": "string",
            "format": "date-time"
          },
          "bookingStatus": {
            "type": "string",
            "nullable": true
          },
          "bookingReference": {
            "type": "string",
            "nullable": true
          },
          "confirmedAt": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "isConfirmed": {
            "type": "boolean"
          }
        },
        "additionalProperties": false
      },
      "BookingTripUpdateDTOs": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "tripType": {
            "type": "integer",
            "format": "int32"
          },
          "isActive": {
            "type": "boolean"
          },
          "bookingDate": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "ClientCreateDTO": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "personID": {
            "type": "integer",
            "format": "int32"
          },
          "documentationID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ClientDTOs": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "personID": {
            "type": "integer",
            "format": "int32"
          },
          "documentationID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ClientUpdateDTO": {
        "type": "object",
        "properties": {
          "personID": {
            "type": "integer",
            "format": "int32"
          },
          "documentationID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ConfirmSeatsRequestDTO": {
        "type": "object",
        "properties": {
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ConfirmSeatsResponseDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "confirmedSeatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          },
          "confirmedSeatCodes": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "CountryCreateDTOs": {
        "type": "object",
        "properties": {
          "countryName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "CountryDTOs": {
        "type": "object",
        "properties": {
          "countryID": {
            "type": "integer",
            "format": "int32"
          },
          "countryName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "CountryUpdateDTOs": {
        "type": "object",
        "properties": {
          "countryName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "CreateCheckoutSessionRequest": {
        "type": "object",
        "properties": {
          "ticketId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "CreateCheckoutSessionResponse": {
        "type": "object",
        "properties": {
          "sessionId": {
            "type": "string",
            "nullable": true
          },
          "url": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "EmployeeCreateDTOs": {
        "type": "object",
        "properties": {
          "personID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "EmployeeDTOs": {
        "type": "object",
        "properties": {
          "employeeID": {
            "type": "integer",
            "format": "int32"
          },
          "personID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "EmployeeUpdateDTOs": {
        "type": "object",
        "properties": {
          "personID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "FlightScheduleCreateDTO": {
        "type": "object",
        "properties": {
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "departureTime": {
            "type": "string",
            "format": "date-span"
          },
          "arrivalTime": {
            "type": "string",
            "format": "date-span"
          },
          "flightDate": {
            "type": "string",
            "format": "date-time"
          },
          "basePrice": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "FlightScheduleDTO": {
        "type": "object",
        "properties": {
          "flightScheduleID": {
            "type": "integer",
            "format": "int32"
          },
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "departureTime": {
            "type": "string",
            "format": "date-span"
          },
          "arrivalTime": {
            "type": "string",
            "format": "date-span"
          },
          "flightDate": {
            "type": "string",
            "format": "date-time"
          },
          "basePrice": {
            "type": "number",
            "format": "double"
          },
          "classFee": {
            "type": "number",
            "format": "double"
          },
          "totalPrice": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "FlightScheduleSearchDTO": {
        "type": "object",
        "properties": {
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "flightDateFrom": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flightDateTo": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "passengerClassID": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "FlightScheduleUpdateDTO": {
        "type": "object",
        "properties": {
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "departureTime": {
            "type": "string",
            "format": "date-span"
          },
          "arrivalTime": {
            "type": "string",
            "format": "date-span"
          },
          "flightDate": {
            "type": "string",
            "format": "date-time"
          },
          "basePrice": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "HoldSeatsRequestDTO": {
        "type": "object",
        "properties": {
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          },
          "seatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "HoldSeatsResponseDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "flightScheduleId": {
            "type": "integer",
            "format": "int32"
          },
          "heldSeatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          },
          "expiresAt": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "InfoDocumentationCreateDTOs": {
        "type": "object",
        "properties": {
          "documentationType": {
            "type": "string",
            "nullable": true
          },
          "issueCountryID": {
            "type": "integer",
            "format": "int32"
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          },
          "documentationImage": {
            "type": "string",
            "format": "byte",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "InfoDocumentationDTOs": {
        "type": "object",
        "properties": {
          "documentationID": {
            "type": "integer",
            "format": "int32"
          },
          "documentationType": {
            "type": "string",
            "nullable": true
          },
          "issueCountryID": {
            "type": "integer",
            "format": "int32"
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          },
          "documentationImage": {
            "type": "string",
            "format": "byte",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "InfoDocumentationUpdateDTOs": {
        "type": "object",
        "properties": {
          "documentationType": {
            "type": "string",
            "nullable": true
          },
          "issueCountryID": {
            "type": "integer",
            "format": "int32"
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          },
          "documentationImage": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "InfoPersonDTOs": {
        "type": "object",
        "properties": {
          "personID": {
            "type": "integer",
            "format": "int32"
          },
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "email": {
            "type": "string",
            "nullable": true
          },
          "phone": {
            "type": "string",
            "nullable": true
          },
          "birthDate": {
            "type": "string",
            "format": "date-time"
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "countryID": {
            "type": "integer",
            "format": "int32"
          },
          "countryName": {
            "type": "string",
            "nullable": true
          },
          "profileImageUrl": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "InfoPersonUpdateDTOs": {
        "type": "object",
        "properties": {
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "phone": {
            "type": "string",
            "nullable": true
          },
          "email": {
            "type": "string",
            "nullable": true
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "countryID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "InfoTicketCreateDTO": {
        "type": "object",
        "properties": {
          "bookID": {
            "type": "integer",
            "format": "int32"
          },
          "passengerClassID": {
            "type": "integer",
            "format": "int32"
          },
          "ticketPrice": {
            "type": "number",
            "format": "double"
          },
          "passengersCount": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "InfoTicketDTO": {
        "type": "object",
        "properties": {
          "ticketID": {
            "type": "integer",
            "format": "int32"
          },
          "bookID": {
            "type": "integer",
            "format": "int32"
          },
          "passengerClassID": {
            "type": "integer",
            "format": "int32"
          },
          "ticketPrice": {
            "type": "number",
            "format": "double"
          },
          "passengersCount": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "InfoTicketUpdateDTO": {
        "type": "object",
        "properties": {
          "bookID": {
            "type": "integer",
            "format": "int32"
          },
          "passengerClassID": {
            "type": "integer",
            "format": "int32"
          },
          "ticketPrice": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "LegDto": {
        "type": "object",
        "properties": {
          "from": {
            "type": "string",
            "nullable": true
          },
          "to": {
            "type": "string",
            "nullable": true
          },
          "date": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "LoginResultDTOs": {
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "nullable": true
          },
          "password": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "MultiCityLegResultDTO": {
        "type": "object",
        "properties": {
          "legIndex": {
            "type": "integer",
            "format": "int32"
          },
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "flightDate": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flightDateFrom": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flightDateTo": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flights": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/FlightScheduleDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "MultiCityLegSearchDTO": {
        "type": "object",
        "properties": {
          "departureCity": {
            "type": "string",
            "nullable": true
          },
          "arrivalCity": {
            "type": "string",
            "nullable": true
          },
          "flightDate": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flightDateFrom": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "flightDateTo": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "MultiCitySearchDTO": {
        "type": "object",
        "properties": {
          "tripTypeID": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "passengers": {
            "$ref": "#/components/schemas/PassengerNumberDTO"
          },
          "travelClass": {
            "type": "string",
            "nullable": true
          },
          "legs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/MultiCityLegSearchDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "MultiCitySearchRequestDto": {
        "type": "object",
        "properties": {
          "legs": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/LegDto"
            },
            "nullable": true
          },
          "maxOptionsPerLeg": {
            "type": "integer",
            "format": "int32"
          },
          "maxItineraries": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "MultiCitySearchResultDTO": {
        "type": "object",
        "properties": {
          "tripTypeID": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "travelClass": {
            "type": "string",
            "nullable": true
          },
          "passengers": {
            "$ref": "#/components/schemas/PassengerNumberDTO"
          },
          "legResults": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/MultiCityLegResultDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "OneWaySearchRequestDto": {
        "type": "object",
        "properties": {
          "from": {
            "type": "string",
            "nullable": true
          },
          "to": {
            "type": "string",
            "nullable": true
          },
          "date": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "PassengerClassDTO": {
        "type": "object",
        "properties": {
          "classID": {
            "type": "integer",
            "format": "int32"
          },
          "nameClass": {
            "type": "string",
            "nullable": true
          },
          "feesClass": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "PassengerNumberDTO": {
        "type": "object",
        "properties": {
          "adults": {
            "type": "integer",
            "format": "int32"
          },
          "youth": {
            "type": "integer",
            "format": "int32"
          },
          "children": {
            "type": "integer",
            "format": "int32"
          },
          "infants": {
            "type": "integer",
            "format": "int32"
          },
          "total": {
            "type": "integer",
            "format": "int32",
            "readOnly": true
          }
        },
        "additionalProperties": false
      },
      "PassengerSeatItemDTO": {
        "type": "object",
        "properties": {
          "passengerId": {
            "type": "integer",
            "format": "int32"
          },
          "personId": {
            "type": "integer",
            "format": "int32"
          },
          "seatId": {
            "type": "integer",
            "format": "int32"
          },
          "seatCode": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "PassengerSeatsResponseDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "items": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PassengerSeatItemDTO"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "PassengerSummaryDto": {
        "type": "object",
        "properties": {
          "passengerId": {
            "type": "integer",
            "format": "int32"
          },
          "personId": {
            "type": "integer",
            "format": "int32"
          },
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "birthDate": {
            "type": "string",
            "format": "date-time"
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "issueCountryId": {
            "type": "integer",
            "format": "int32"
          },
          "documentationType": {
            "type": "string",
            "nullable": true
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          },
          "hasDocument": {
            "type": "boolean"
          }
        },
        "additionalProperties": false
      },
      "ProblemDetails": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "nullable": true
          },
          "title": {
            "type": "string",
            "nullable": true
          },
          "status": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "detail": {
            "type": "string",
            "nullable": true
          },
          "instance": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": { }
      },
      "ProfileMeResponseDto": {
        "type": "object",
        "properties": {
          "userId": {
            "type": "integer",
            "format": "int32"
          },
          "personId": {
            "type": "integer",
            "format": "int32"
          },
          "clientId": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          },
          "email": {
            "type": "string",
            "nullable": true
          },
          "role": {
            "type": "string",
            "nullable": true
          },
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "phone": {
            "type": "string",
            "nullable": true
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "birthDate": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "countryId": {
            "type": "integer",
            "format": "int32"
          },
          "countryName": {
            "type": "string",
            "nullable": true
          },
          "profileImageUrl": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "ProfileMeUpdateRequestDto": {
        "type": "object",
        "properties": {
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "phone": {
            "type": "string",
            "nullable": true
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "birthDate": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "countryId": {
            "type": "integer",
            "format": "int32",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "RegisterRequestDTOs": {
        "type": "object",
        "properties": {
          "email": {
            "type": "string",
            "nullable": true
          },
          "password": {
            "type": "string",
            "nullable": true
          },
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "secondName": {
            "type": "string",
            "nullable": true
          },
          "thirdName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "phone": {
            "type": "string",
            "nullable": true
          },
          "gender": {
            "type": "string",
            "nullable": true
          },
          "countryID": {
            "type": "integer",
            "format": "int32"
          },
          "birthDate": {
            "type": "string",
            "format": "date-time",
            "nullable": true
          },
          "documentationType": {
            "type": "string",
            "nullable": true
          },
          "issueCountryID": {
            "type": "integer",
            "format": "int32"
          },
          "expirationDate": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "RoundTripSearchRequestDto": {
        "type": "object",
        "properties": {
          "from": {
            "type": "string",
            "nullable": true
          },
          "to": {
            "type": "string",
            "nullable": true
          },
          "departureDate": {
            "type": "string",
            "format": "date-time"
          },
          "returnDate": {
            "type": "string",
            "format": "date-time"
          },
          "maxItineraries": {
            "type": "integer",
            "format": "int32"
          },
          "maxOptionsPerLeg": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "SeatAssignmentItemDTO": {
        "type": "object",
        "properties": {
          "seatId": {
            "type": "integer",
            "format": "int32"
          },
          "passengerId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "SelectedSeatsDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "seatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          },
          "seatCodes": {
            "type": "array",
            "items": {
              "type": "string"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "ServicesCreateDTO": {
        "type": "object",
        "properties": {
          "nameService": {
            "type": "string",
            "nullable": true
          },
          "fees": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "ServicesDTO": {
        "type": "object",
        "properties": {
          "serviceID": {
            "type": "integer",
            "format": "int32"
          },
          "nameService": {
            "type": "string",
            "nullable": true
          },
          "fees": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "ServicesUpdateDTO": {
        "type": "object",
        "properties": {
          "nameService": {
            "type": "string",
            "nullable": true
          },
          "fees": {
            "type": "number",
            "format": "double"
          }
        },
        "additionalProperties": false
      },
      "TicketFlightCreateDTO": {
        "type": "object",
        "properties": {
          "ticketID": {
            "type": "integer",
            "format": "int32"
          },
          "flightScheduleID": {
            "type": "integer",
            "format": "int32"
          },
          "flightType": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "TicketFlightDTO": {
        "type": "object",
        "properties": {
          "ticketID": {
            "type": "integer",
            "format": "int32"
          },
          "flightScheduleID": {
            "type": "integer",
            "format": "int32"
          },
          "flightType": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "TicketFlightUpdateDTO": {
        "type": "object",
        "properties": {
          "flightType": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "TicketServiceAddDTO": {
        "type": "object",
        "properties": {
          "serviceID": {
            "type": "integer",
            "format": "int32"
          },
          "quantity": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "TicketServiceUpdateQuantityDTO": {
        "type": "object",
        "properties": {
          "quantity": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "TicketServicesDTO": {
        "type": "object",
        "properties": {
          "ticketID": {
            "type": "integer",
            "format": "int32"
          },
          "serviceID": {
            "type": "integer",
            "format": "int32"
          },
          "nameService": {
            "type": "string",
            "nullable": true
          },
          "fees": {
            "type": "number",
            "format": "double"
          },
          "quantity": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "TripTypeCreateDTO": {
        "type": "object",
        "properties": {
          "tripTypeName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "TripTypeDTO": {
        "type": "object",
        "properties": {
          "tripTypeID": {
            "type": "integer",
            "format": "int32"
          },
          "tripTypeName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "TripTypeUpdateDTO": {
        "type": "object",
        "properties": {
          "tripTypeName": {
            "type": "string",
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "UnholdSeatsRequestDTO": {
        "type": "object",
        "properties": {
          "seatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "UnholdSeatsResponseDTO": {
        "type": "object",
        "properties": {
          "bookingTempId": {
            "type": "string",
            "nullable": true
          },
          "releasedSeatIds": {
            "type": "array",
            "items": {
              "type": "integer",
              "format": "int32"
            },
            "nullable": true
          }
        },
        "additionalProperties": false
      },
      "UserAccountCreateDTOs": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "userNameOrEmail": {
            "type": "string",
            "nullable": true
          },
          "passwordHash": {
            "type": "string",
            "nullable": true
          },
          "isActive": {
            "type": "boolean"
          },
          "roleID": {
            "type": "integer",
            "format": "int32"
          },
          "createAt": {
            "type": "string",
            "format": "date-time"
          },
          "lastLoginAt": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      },
      "UserAccountDTOs": {
        "type": "object",
        "properties": {
          "userID": {
            "type": "integer",
            "format": "int32"
          },
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "userNameOrEmail": {
            "type": "string",
            "nullable": true
          },
          "passwordHash": {
            "type": "string",
            "nullable": true
          },
          "isActive": {
            "type": "boolean"
          },
          "createAt": {
            "type": "string",
            "format": "date-time"
          },
          "lastLoginAt": {
            "type": "string",
            "format": "date-time"
          },
          "roleID": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "UserAccountUpdateDTOs": {
        "type": "object",
        "properties": {
          "clientID": {
            "type": "integer",
            "format": "int32"
          },
          "userNameOrEmail": {
            "type": "string",
            "nullable": true
          },
          "passwordHash": {
            "type": "string",
            "nullable": true
          },
          "isActive": {
            "type": "boolean"
          },
          "roleID": {
            "type": "integer",
            "format": "int32"
          },
          "lastLoginAt": {
            "type": "string",
            "format": "date-time"
          }
        },
        "additionalProperties": false
      }
    },
    "securitySchemes": {
      "Bearer": {
        "type": "http",
        "description": "Enter: Bearer {your JWT token}",
        "scheme": "Bearer",
        "bearerFormat": "JWT"
      }
    }
  },
  "security": [
    {
      "Bearer": [ ]
    }
  ]
}