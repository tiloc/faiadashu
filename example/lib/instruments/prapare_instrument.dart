class PrapareInstrument {
  static const prapareInstrument = '''
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
          "code": "93025-5",
          "display": "Protocol for Responding to and Assessing Patients' Assets, Risks, and Experiences [PRAPARE]",
          "system": "http://loinc.org"
        }
      ],
      "required": false,
      "linkId": "/93025-5",
      "text": "Protocol for Responding to and Assessing Patients' Assets, Risks, and Experiences [PRAPARE]",
      "item": [
        {
          "type": "group",
          "code": [
            {
              "code": "93043-8",
              "display": "Personal characteristics",
              "system": "http://loinc.org"
            }
          ],
          "required": false,
          "linkId": "/93043-8",
          "text": "Personal characteristics",
          "item": [
            {
              "type": "choice",
              "code": [
                {
                  "code": "56051-6",
                  "display": "Do you consider yourself Hispanic/Latino?",
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
              "linkId": "/93043-8/56051-6",
              "text": "Do you consider yourself Hispanic/Latino?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "32624-9",
                  "display": "Race",
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
              "linkId": "/93043-8/32624-9",
              "text": "Race",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA6156-9",
                    "display": "Asian"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA14045-1",
                    "display": "Native Hawaiian"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30187-1",
                    "display": "Pacific Islander"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA14042-8",
                    "display": "Black/African American"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA4457-3",
                    "display": "White"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA4-4",
                    "display": "American Indian/Alaskan Native"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA46-8",
                    "display": "Other"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93035-4",
                  "display": "At any point in the past 2 years, has season or migrant farm work been your or your family's main source of income?",
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
              "linkId": "/93043-8/93035-4",
              "text": "At any point in the past 2 years, has season or migrant farm work been your or your family's main source of income?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93034-7",
                  "display": "Have you been discharged from the armed forces of the United States?",
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
              "linkId": "/93043-8/93034-7",
              "text": "Have you been discharged from the armed forces of the United States?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "54899-0",
                  "display": "Preferred language",
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
              "linkId": "/93043-8/54899-0",
              "text": "Preferred language",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA43-5",
                    "display": "English"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30188-9",
                    "display": "Language other than English"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            }
          ]
        },
        {
          "type": "group",
          "code": [
            {
              "code": "93042-0",
              "display": "Family and home",
              "system": "http://loinc.org"
            }
          ],
          "required": false,
          "linkId": "/93042-0",
          "text": "Family and home",
          "item": [
            {
              "type": "decimal",
              "code": [
                {
                  "code": "63512-8",
                  "display": "How many people are living or staying at this address?",
                  "system": "http://loinc.org"
                }
              ],
              "extension": [
                {
                  "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-unit",
                  "valueCoding": {
                    "display": "{#}"
                  }
                }
              ],
              "required": false,
              "linkId": "/93042-0/63512-8",
              "text": "How many people are living or staying at this address?"
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "71802-3",
                  "display": "Housing status",
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
              "linkId": "/93042-0/71802-3",
              "text": "Housing status",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA30189-7",
                    "display": "I have housing"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30190-5",
                    "display": "I do not have housing (staying with others, in a hotel, in a shelter, living outside on the street, on a beach, in a car, or in a park)"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ],
              "item": [
                {
                  "text": "Describes patients living arrangement",
                  "type": "display",
                  "linkId": "/93042-0/71802-3-help",
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
              "type": "choice",
              "code": [
                {
                  "code": "93033-9",
                  "display": "Are you worried about losing your housing?",
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
              "linkId": "/93042-0/93033-9",
              "text": "Are you worried about losing your housing?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "string",
              "code": [
                {
                  "code": "56799-0",
                  "display": "Address",
                  "system": "http://loinc.org"
                }
              ],
              "required": false,
              "linkId": "/93042-0/56799-0",
              "text": "Address"
            }
          ]
        },
        {
          "type": "group",
          "code": [
            {
              "code": "93041-2",
              "display": "Money and resources",
              "system": "http://loinc.org"
            }
          ],
          "required": false,
          "linkId": "/93041-2",
          "text": "Money and resources",
          "item": [
            {
              "type": "choice",
              "code": [
                {
                  "code": "82589-3",
                  "display": "Highest level of educ",
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
              "linkId": "/93041-2/82589-3",
              "text": "Highest level of educ",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA30191-3",
                    "display": "Less than high school degree"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30192-1",
                    "display": "High school diploma or GED"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30193-9",
                    "display": "More than high school"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "67875-5",
                  "display": "Employment status current",
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
              "linkId": "/93041-2/67875-5",
              "text": "Employment status current",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA17956-6",
                    "display": "Unemployed"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30138-4",
                    "display": "Part-time or temporary work"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30136-8",
                    "display": "Full-time work"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30137-6",
                    "display": "Otherwise unemployed but not seeking work (ex: student, retired, disabled, unpaid primary care giver)"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "76437-3",
                  "display": "Primary insurance",
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
              "linkId": "/93041-2/76437-3",
              "text": "Primary insurance",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA30194-7",
                    "display": "None/uninsured"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA17849-3",
                    "display": "Medicaid"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30195-4",
                    "display": "CHIP Medicaid"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA15652-3",
                    "display": "Medicare"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30196-2",
                    "display": "Other public insurance (not CHIP)"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30197-0",
                    "display": "Other public insurance (CHIP)"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA6350-8",
                    "display": "Private insurance"
                  }
                }
              ]
            },
            {
              "type": "decimal",
              "code": [
                {
                  "code": "63586-2",
                  "display": "What was your best estimate of the total income of all family members from all sources, before taxes, in last year?",
                  "system": "http://loinc.org"
                }
              ],
              "extension": [
                {
                  "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-unit",
                  "valueCoding": {
                    "display": "/a"
                  }
                }
              ],
              "required": false,
              "linkId": "/93041-2/63586-2",
              "text": "What was your best estimate of the total income of all family members from all sources, before taxes, in last year?"
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93031-3",
                  "display": "In the past year, have you or any family members you live with been unable to get any of the following when it was really needed?",
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
              "linkId": "/93041-2/93031-3",
              "text": "In the past year, have you or any family members you live with been unable to get any of the following when it was really needed?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA30125-1",
                    "display": "Food"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30126-9",
                    "display": "Clothing"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30124-4",
                    "display": "Utilities"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30127-7",
                    "display": "Child care"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30128-5",
                    "display": "Medicine or Any Health Care (Medical, Dental, Mental Health, Vision)"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30129-3",
                    "display": "Phone"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA46-8",
                    "display": "Other"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93030-5",
                  "display": "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living?",
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
              "linkId": "/93041-2/93030-5",
              "text": "Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living?",
              "answerOption": [
                {
                  "extension": [
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                      "valueString": "A"
                    }
                  ],
                  "valueCoding": {
                    "code": "LA30133-5",
                    "display": "Yes, it has kept me from medical appointments or from getting my medications"
                  }
                },
                {
                  "extension": [
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                      "valueString": "B"
                    }
                  ],
                  "valueCoding": {
                    "code": "LA30134-3",
                    "display": "Yes, it has kept me from non-medical meetings, appointments, work, or from getting things that I need"
                  }
                },
                {
                  "extension": [
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                      "valueString": "C"
                    }
                  ],
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "extension": [
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                      "valueString": "X"
                    }
                  ],
                  "valueCoding": {
                    "code": "LA30257-2",
                    "display": "Patient unable to respond"
                  }
                }
              ]
            }
          ]
        },
        {
          "type": "group",
          "code": [
            {
              "code": "93040-4",
              "display": "Social and emotional health",
              "system": "http://loinc.org"
            }
          ],
          "required": false,
          "linkId": "/93040-4",
          "text": "Social and emotional health",
          "item": [
            {
              "type": "choice",
              "code": [
                {
                  "code": "93029-7",
                  "display": "How often do you see or talk to people that you care about and feel close to (For example: talking to friends on the phone, visiting friends or family, going to church or club meetings)?",
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
              "linkId": "/93040-4/93029-7",
              "text": "How often do you see or talk to people that you care about and feel close to (For example: talking to friends on the phone, visiting friends or family, going to church or club meetings)?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA27722-0",
                    "display": "Less than once a week"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30130-1",
                    "display": "1 or 2 times a week"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30131-9",
                    "display": "3 to 5 times a week"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30132-7",
                    "display": "5 or more times a week"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93038-8",
                  "display": "Stress is when someone feels tense, nervous, anxious or can't sleep at night because their mind is troubled. How stressed are you?",
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
              "linkId": "/93040-4/93038-8",
              "text": "Stress is when someone feels tense, nervous, anxious or can't sleep at night because their mind is troubled. How stressed are you?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA6568-5",
                    "display": "Not at all"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA13863-8",
                    "display": "A little bit"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA13909-9",
                    "display": "Somewhat"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA13902-4",
                    "display": "Quite a bit"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA13914-9",
                    "display": "Very much"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            }
          ]
        },
        {
          "type": "group",
          "code": [
            {
              "code": "93039-6",
              "display": "Optional additional questions",
              "system": "http://loinc.org"
            }
          ],
          "required": false,
          "linkId": "/93039-6",
          "text": "Optional additional questions",
          "item": [
            {
              "type": "choice",
              "code": [
                {
                  "code": "93028-9",
                  "display": "In the past year, have you spent more than 2 nights in a row in a jail, prison, detention center, or juvenile correctional facility?",
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
              "linkId": "/93039-6/93028-9",
              "text": "In the past year, have you spent more than 2 nights in a row in a jail, prison, detention center, or juvenile correctional facility?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93027-1",
                  "display": "Are you a refugee?",
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
              "linkId": "/93039-6/93027-1",
              "text": "Are you a refugee?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "93026-3",
                  "display": "Do you feel physically and emotionally safe where you currently live?",
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
              "linkId": "/93039-6/93026-3",
              "text": "Do you feel physically and emotionally safe where you currently live?",
              "answerOption": [
                {
                  "valueCoding": {
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA14072-5",
                    "display": "Unsure"
                  }
                },
                {
                  "valueCoding": {
                    "code": "LA30122-8",
                    "display": "I choose not to answer this question"
                  }
                }
              ]
            },
            {
              "type": "choice",
              "code": [
                {
                  "code": "76501-6",
                  "display": "Within the last year, have you been afraid of your partner or ex-partner?",
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
              "linkId": "/93039-6/76501-6",
              "text": "Within the last year, have you been afraid of your partner or ex-partner?",
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
                    "code": "LA33-6",
                    "display": "Yes"
                  }
                },
                {
                  "extension": [
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/questionnaire-optionPrefix",
                      "valueString": "0"
                    },
                    {
                      "url": "http://hl7.org/fhir/StructureDefinition/ordinalValue",
                      "valueDecimal": 0
                    }
                  ],
                  "valueCoding": {
                    "code": "LA32-8",
                    "display": "No"
                  }
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
  ''';
}
