class SDCDemoInstrument {
  static const sdcDemoInstrument = '''
    {
    "resourceType": "Questionnaire",
    "id": "sdc-demo",
    "url": "http://build.fhir.org/ig/HL7/sdc/examples.html",
    "title": "SDC Demo Survey",
    "status": "draft",
    "subjectType": [
      "Patient"
    ],
    "date": "2021-03-14",
    "publisher": "HL7 International - FHIR Infrastructure Work Group",
    "item": [
      {
        "linkId": "1",
        "text": "Please answer Yes or No to each of the following questions:",
        "_text": {
          "extension": [
            {
              "url": "http://hl7.org/fhir/StructureDefinition/rendering-xhtml",
              "valueString": "<i>Please</i> answer <b><u>Yes</u></b> or <b><u>No</u></b> to each of the following questions:"
            }
          ]
        },
        "type": "display"
      },
      {
        "extension": [
          {
            "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "http://hl7.org/fhir/questionnaire-item-control",
                  "code": "radio-button",
                  "display": "Radio Button"
                }
              ],
              "text": "A control where choices are listed with a button beside them. The button can be toggled to select or de-select a given choice. Selecting one item deselects all others."
            }
          }
        ],
        "linkId": "1.0",
        "text": "Gender:",
        "type": "choice",
        "answerOption": [
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                "valueString": "(a)"
              }
            ],
            "valueCoding": {
              "code": "F",
              "display": "Female"
            },
            "initialSelected": true
          },
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                "valueString": "(b)"
              }
            ],
            "valueCoding": {
              "code": "M",
              "display": "Male"
            }
          },
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                "valueString": "(c)"
              }
            ],
            "valueCoding": {
              "code": "O",
              "display": "Other"
            }
          },
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                "valueString": "(d)"
              }
            ],
            "valueCoding": {
              "code": "U",
              "display": "Unknown"
            }
          }
        ]
      },
      {
        "linkId": "2.3.b",
        "text": "Email*",
        "type": "string",
        "required": true
      },
                {
            "extension": [
              {
                "url": "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression",
                "valueExpression": {
                  "description": "current date",
                  "language": "text/fhirpath",
                  "expression": "today()"
                }
              }
            ],
            "linkId": "2.4.b",
            "text": "Current Date:",
            "type": "date",
            "readOnly": true
          }, 
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/minValue",
                "valueDecimal": 1
              },
              {
                "url": "http://hl7.org/fhir/StructureDefinition/maxValue",
                "valueDecimal": 100
              },
              {
                "url": "http://hl7.org/fhir/StructureDefinition/maxDecimalPlaces",
                "valueInteger": 2
              }
            ],
            "linkId": "100000",
            "type": "decimal",
            "text": "Enter your weight in kg"
          },
                    {
            "linkId": "123523.35235",
            "type": "string",
            "text": "Enter your First Name",
            "maxLength": 50
          }
    ]
  }
''';
}
