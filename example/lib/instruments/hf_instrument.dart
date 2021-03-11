class HFInstrument {
  static const hfInstrument = '''
  {
    "status": "draft",
    "resourceType": "Questionnaire",
    "meta": {
      "profile": [
        "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire|2.7"
      ],
      "tag": [
        {
          "code": "lformsVersion: 25.1.3"
        }
      ]
    },
    "item": [
      {
        "type": "group",
        "code": [
          {
            "code": "86923-0",
            "display": "Heartfailure Questionnaire - 8 items",
            "system": "http://loinc.org"
          }
        ],
        "required": false,
        "linkId": "/86923-0",
        "text": "Please indicate how much you are limited by <b>heart failure</b> (<i>shortness of breath or fatigue</i>) in your ability to do the following activities over the past 2 weeks.",
        "item": [
          {
            "type": "choice",
            "code": [
              {
                "code": "86483-V",
                "display": "Showering or bathing",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86483-V",
            "text": "Showering or bathing",
            "_text": {
              "extension": [
                {
                  "url": "http://hl7.org/fhir/StructureDefinition/rendering-xhtml",
                  "valueString": "<h2>Showering or bathing</h2><p><b>Splishing</b> or <i>splashing</i></p>"
                }
              ]
            },
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7701-4",
                  "display": "Extremely limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7702-II",
                  "display": "Quite a bit limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-6460-V",
                  "display": "Moderately limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-9605-II",
                  "display": "Slightly limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7707-1",
                  "display": "Not at all limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "6"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 6
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7708-9",
                  "display": "Limited for other reasons or did not do the activity"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86474-4",
                "display": "Walking 1 block on level ground",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86474-4",
            "text": "Walking 1 block on level ground",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7701-4",
                  "display": "Extremely limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7702-II",
                  "display": "Quite a bit limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-6460-V",
                  "display": "Moderately limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-9605-II",
                  "display": "Slightly limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7707-1",
                  "display": "Not at all limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "6"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 6
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7708-9",
                  "display": "Limited for other reasons or did not do the activity"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86477-7",
                "display": "Hurrying or jogging (as if to catch a bus)",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86477-7",
            "text": "Hurrying or jogging (as if to catch a bus)",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7701-4",
                  "display": "Extremely limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7702-II",
                  "display": "Quite a bit limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-6460-V",
                  "display": "Moderately limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-9605-II",
                  "display": "Slightly limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7707-1",
                  "display": "Not at all limited"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "6"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 6
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7708-9",
                  "display": "Limited for other reasons or did not do the activity"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86479-3",
                "display": "Over the past 2 weeks, how many times did you have swelling in your feet, ankles or legs when you woke up in the morning?",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86479-3",
            "text": "Over the past 2 weeks, how many times did you have swelling in your feet, ankles or legs when you woke up in the morning?",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7719-6",
                  "display": "Every morning"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7720-4",
                  "display": "3 or more times a week, but not every day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-14506-II",
                  "display": "1-II times a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7722-0",
                  "display": "Less than once a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7723-8",
                  "display": "Never over the past 2 weeks"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86481-9",
                "display": "Over the past 2 weeks, on average, how many times has fatigue limited your ability to do what you want?",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86481-9",
            "text": "Over the past 2 weeks, on average, how many times has fatigue limited your ability to do what you want?",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-6154-4",
                  "display": "All of the time"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7729-V",
                  "display": "Several times per day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7730-3",
                  "display": "At least once a day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7770-9",
                  "display": "3 or more times per week but not every day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-13834-9",
                  "display": "1-II times per week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "6"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 6
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7722-0",
                  "display": "Less than once a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "7"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 7
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7723-8",
                  "display": "Never over the past 2 weeks"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86472-8",
                "display": "Over the past 2 weeks, on average, how many times has shortness of breath limited your ability to do what you wanted?",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86472-8",
            "text": "Over the past 2 weeks, on average, how many times has shortness of breath limited your ability to do what you wanted?",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-6154-4",
                  "display": "All of the time"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7729-V",
                  "display": "Several times per day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7730-3",
                  "display": "At least once a day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7770-9",
                  "display": "3 or more times per week but not every day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-13834-9",
                  "display": "1-II times per week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "6"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 6
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7722-0",
                  "display": "Less than once a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "7"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 7
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7723-8",
                  "display": "Never over the past 2 weeks"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86485-0",
                "display": "Over the past 2 weeks, on average, how many times have you been forced to sleep sitting up in a chair or with at least 3 pillows to prop you up because of shortness of breath?",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86485-0",
            "text": "Over the past 2 weeks, on average, how many times have you been forced to sleep sitting up in a chair or with at least 3 pillows to prop you up because of shortness of breath?",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-14806-6",
                  "display": "Every night"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7720-4",
                  "display": "3 or more times a week, but not every day"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-14506-II",
                  "display": "1-II times a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7722-0",
                  "display": "Less than once a week"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7723-8",
                  "display": "Never over the past 2 weeks"
                }
              }
            ]
          },
          {
            "type": "choice",
            "code": [
              {
                "code": "86488-4",
                "display": "Over the past 2 weeks, how much has your heart failure limited your enjoyment of life?",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://hl7.org/fhir/questionnaire-item-control",
                      "code": "drop-down",
                      "display": "Drop down"
                    }
                  ],
                  "text": "Drop down"
                }
              }
            ],
            "required": false,
            "linkId": "/86488-4",
            "text": "Over the past 2 weeks, how much has your heart failure limited your enjoyment of life?",
            "answerOption": [
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "1"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 1
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7745-1",
                  "display": "It has extremely limited my enjoyment of life"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "2"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 2
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7746-9",
                  "display": "It has limited my enjoyment of life quite a bit"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "3"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 3
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7747-7",
                  "display": "It has moderately limited my enjoyment of life"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "4"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 4
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7748-V",
                  "display": "It has slightly limited my enjoyment of life"
                }
              },
              {
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                    "valueString": "5"
                  },
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                    "valueDecimal": 5
                  }
                ],
                "valueCoding": {
                  "code": "CODE-II-7749-3",
                  "display": "It has not limited my enjoyment of life at all"
                }
              }
            ]
          },
          {
            "type": "decimal",
            "code": [
              {
                "code": "86924-8",
                "display": "Overall summary score",
                "system": "http://loinc.org"
              }
            ],
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-unit",
                "valueCoding": {
                  "display": "{score}"
                }
              }
            ],
            "required": false,
            "linkId": "/86924-8",
            "text": "Overall summary score",
            "item": [
              {
                "text": "Overall summary score is the sum of responses from all 8 items, with lower scores indicating more significant disease impact. Changes in the summary score are predictive of changes in health status for patients with heart failure.",
                "type": "display",
                "linkId": "/86924-8-help",
                "extension": [
                  {
                    "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                    "valueCodeableConcept": {
                      "text": "Help-Button",
                      "coding": [
                        {
                          "code": "help",
                          "display": "Help-Button",
                          "system": "http://hl7.org/fhir/questionnaire-item-control"
                        }
                      ]
                    }
                  }
                ]
              }
            ]
          },
          {
            "text": "The Heartfailure Questionnaire is a short questionnaire",
            "type": "display",
            "linkId": "/86923-0-help",
            "extension": [
              {
                "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl",
                "valueCodeableConcept": {
                  "text": "Help-Button",
                  "coding": [
                    {
                      "code": "help",
                      "display": "Help-Button",
                      "system": "http://hl7.org/fhir/questionnaire-item-control"
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    ]
  }
''';
}
